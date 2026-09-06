Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5D360EE2
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707085; cv=none; b=ndXS9HEdaS5QvA2bm1Ita32WbC8vbBqIvWk01RYPa9kMq6lshH2HnaaL+7lsW3RsaurhzBS9ECHCPAHhsHwxXrSYqZ92oG82a1fEkpCWxCf9hMKaqKp5E7mrPMe9wAh1CbWh3I4ozXb1UJcWLYDyGamfP2VZ4g4xAMN9ZPyzvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707085; c=relaxed/simple;
	bh=Q72hJAMFCt9BuaNG7EXAc7zxdpwBxhERXy8i4CISySw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfx0G2S+bk41gdZhpNOzrJv/pCWYyWcKdGtxjfmXSV/DmxiIvnBhcN9NQgs02tlZoxeztJUudUKOhi9a+CCvz+sv4gWGCXsnmjkHePDTKPxYjQqjccQhmWwJtSSSH5uNIeV7iG1TFABlU0USJpcpyHp+S5HEQ+s4H8bquxwYWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft0b/dU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft0b/dU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001C91F00A3A;
	Sun,  6 Sep 2026 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707082;
	bh=3GKJgaoJAnDrVC9UVjKnYasDhu8tmlDjva8YD8BBU8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ft0b/dU/h1UoSCBfkUGMTSf8c12zFJAePHkbuCISW5SA6LFExWH2jSbjzoifn+X0m
	 f2rLI6+eSO0GOcywUrC2wgPkzA3S14V0ZqxRdjmwWtPF91ujROPsj9c+tZ51L0tml+
	 6WbXuQlZUt/YNYneOYyPsGyGCsd0XRvlWxiDiE5IG6BJYWFkl3dcFvbinkK3sSxLiF
	 o4acbFQnHgqrfYvgrSsdFz+xogZc3VXbv9GM4mXh7Td/y2KavgJ/K4LElDzzDWB2ND
	 Vpvo0qT0b74wJtudGQ7nrMIxvEvZWMMtlTnVx3scqQ364+bV3HvxCFOn0cZRX0MmHR
	 eNWHyLjxyWuhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	XIAO WU <xiaowu.417@qq.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] NFSD: Guard admin state-revocation walks with NFSD_NET_UP
Date: Sun,  6 Sep 2026 11:04:40 -0400
Message-ID: <20260906150440.1365883-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-parting-overeater-9374@gregkh>
References: <2026090352-parting-overeater-9374@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 2f3e6638aebc0ab8afb8b4e9816ea9a1cad85378 ]

Writing to /proc/fs/nfsd/unlock_filesystem, or sending the
NFSD_CMD_UNLOCK_FILESYSTEM or NFSD_CMD_UNLOCK_EXPORT netlink command,
walks the NFSv4 client hash tables to revoke open state and cancel
async COPY operations.  All three handlers gate that walk on
nn->nfsd_serv, but a listener added via portlist or netlink
listener_set sets nn->nfsd_serv before any nfsd thread starts.
nfsd_startup_net() has not yet allocated nn->conf_id_hashtbl, so the
walkers dereference a NULL table.  A local administrator with
CAP_SYS_ADMIN can crash the kernel this way without ever starting the
server.

nn->nfsd_serv is set when the service is created, which precedes
table allocation.  NFSD_NET_UP instead brackets the window where the
tables are live: set at the end of nfsd_startup_net() and cleared in
nfsd_shutdown_net() after they are freed, both under nfsd_mutex.
Gating the three unlock paths on NFSD_NET_UP fixes the startup-time
NULL dereference while preserving the earlier post-shutdown
use-after-free fix.

Reported-by: XIAO WU <xiaowu.417@qq.com>
Fixes: 1ac3629bf012 ("nfsd: prepare for supporting admin-revocation of state")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260621162551.2469460-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ adapted NFSD_NET_UP flag check to the older nfsd_net_up boolean ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1da5c40d6722a..eb90e31440d68 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -298,7 +298,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 	mutex_lock(&nfsd_mutex);
 	nn = net_generic(netns(file), nfsd_net_id);
-	if (nn->nfsd_serv)
+	if (nn->nfsd_net_up)
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
 	else
 		error = -EINVAL;
-- 
2.53.0

