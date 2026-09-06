Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EF33A6EB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707629; cv=none; b=GFzNdKihQnEypJ5pV8jNqnV7M8ARyGfxmijs7zbSOqMXUPtpL4uWFhp3aE1Qjcp/901hdWMbeq9UTea+iya55hzT3Q/1MW4olH2ieNHl3t5hcCMZJ4cE1XFTCDvPhC/GyHvpdumuVuzl+9/MPWMbK5vY/qtXzqhQ/k7f93vSzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707629; c=relaxed/simple;
	bh=BqGxE9nkLfdkBIu5aY1zJEdNUbF+l0ApWnnuNDapMxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvIFZpIw3WDc8paaNdMQd1imJ+ypAaRHDwlqypLreoeNAeBPy9lQbJkQoyxX+BdPsGUfcQ5LmdQtcSHwNA4wQ8hxA/iAvmqLaqcIbt9cxEj0UFePXhpKv0BrGsps4dqbQAY/wpn/NWJgOl1woN68oJXWMea6I6DdJ2IGIMUpmjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsYsBcKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsYsBcKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A706C1F00A3A;
	Sun,  6 Sep 2026 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707628;
	bh=j4PdoNFgE6lJ9mJo+rUoy2u4yTFe0Ohdsz7BvpoyX/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MsYsBcKQNjHrP/oPeTl5RyPgShCOcCjNiLwj1zfHfoySaDLDkBcMdBaENrjot8vZF
	 flmQWv2B9upOjM5P3KuIvHGOuzpae3IkmRmY9dXSMzc00Ir/v3ldHINK4q3R2XLHZd
	 wJueQRO/Q07LLzbNieDgERkvLsP4HDDlGz8eUt3FI//0KzH+OfWw3gSRC81kqQnp2W
	 uXtSo63sLcTZxfpH0AxSZ5fIT2KiiUsuq4magqeMse8WqSb9iFDwEmu+jvuek5zloj
	 iLnP7OUYRujtxmZlpUGUEq1vc58zvbv+3EmLruEYEqCYPMBLNQJ9Yvv4zon4JfQSp4
	 71nAmFCP//DFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	XIAO WU <xiaowu.417@qq.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] NFSD: Guard admin state-revocation walks with NFSD_NET_UP
Date: Sun,  6 Sep 2026 11:13:46 -0400
Message-ID: <20260906151346.1401031-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-oat-exclude-4fc9@gregkh>
References: <2026090353-oat-exclude-4fc9@gregkh>
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
index 7b0a6beee96ed..40b454d08dd24 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -301,7 +301,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
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

