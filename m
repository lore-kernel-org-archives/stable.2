Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585082253EB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701330; cv=none; b=i3UIP4VpYgrbJKBvH4843dX8UcRk6vippRMT+3w6c4KCVxpS7dkRr1a2bczMYJkeD1tARbCaXp9yCeXLcW2GnOCT1LumoOlLojrebLVfuYeowl6pUGyoWeNXK7lfW23izOJB9/rFJA3Td/aYohINXqe2vvpx+dEL9WyDEyJAai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701330; c=relaxed/simple;
	bh=KTAAna8uf6aoN1d4+/jJDoY9JcPwqRw6W8rTEHinCh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3VmPRR+ByIx3ZbkVPeKJpOo75ZMZt7VHEjjVF7pAo/X3jBgZJIaV5sk0eZYm4R/nxxMJ+jlprE7Wzjq1mFPtPOkQsmAwqJkvVyxeGabLv3gD2clfDJGIF7OPnlY1e7y4Gzina6+sDRGOwPqOy/PRF19Yu0sYiolFm0w0q2gAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5OzmoTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5OzmoTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3AF1F00A3E;
	Sun,  6 Sep 2026 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701329;
	bh=wBeDtm3FDlEDM9QD+CpdrWYlH5p6E5armagfpEhMF5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5OzmoTfIkjXGZElPavSR5LurS1ZoDzhiG5/iRjrHxbRGVEPN83n//AnR1P5iMpjL
	 9+77P9EqptUDQ1IX0/JacVT5TD3nJEWzFIa4lliQja2OKNqzslolXbwFLuBfbOHcf4
	 HfvXBARyJdxs6Vuvd6u+rH9Rj89aa0AqFUNfSQ+JD3z7q5WKTvsvuwdYMHpmfEIOEd
	 oxmAGuzy+n4v2mgnA4PhZQTHdZV/DHd1NkAhksfDDWvCVyuy7owGRyhKparUnHHb5S
	 XP0sTs1Fwo71QlL2kbAy/Jw0YX72AE/QaDkmckCXulgQRcYVkeYt90Uggut0WDFv0Y
	 8iDGIovSbfBGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/4] NFSD: Prevent post-shutdown use-after-free in unlock_filesystem
Date: Sun,  6 Sep 2026 09:28:44 -0400
Message-ID: <20260906132846.875246-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132846.875246-1-sashal@kernel.org>
References: <2026090352-fading-liquefy-e98c@gregkh>
 <20260906132846.875246-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 292d915d3ba6fd15eeb88351fa10581683073109 ]

Writing a filesystem path to /proc/fs/nfsd/unlock_filesystem runs
nfsd4_cancel_copy_by_sb() before nfsd_mutex is held and before the
handler confirms that nn->nfsd_serv is set. Once nfsd has shut down,
nfs4_state_destroy_net() has freed nn->conf_id_hashtbl but left the
pointer intact, so the cancel helper iterates freed slab memory as an
array of struct list_head and then dereferences a bogus nfs4_client
when it takes clp->async_lock. A local administrator holding
CAP_SYS_ADMIN can reach this use-after-free by stopping the server and
then writing to unlock_filesystem; KASAN reports a slab-use-after-free
read in nfsd4_cancel_copy_by_sb().

nfsd4_revoke_states() walks the same state tables and for that reason
already runs only under nfsd_mutex with nn->nfsd_serv confirmed
present. Move the async COPY cancel into that protected section so
every NFSv4 state-table walker on this path observes a running server.
Async copies exist only while the server runs, so gating the cancel on
nn->nfsd_serv loses nothing.

Reported-by: Musaab Khan <musaab.khan@protonmail.com>
Fixes: 3daab3112f03 ("nfsd: cancel async COPY operations when admin revokes filesystem state")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260613-unlock-filesystem-uaf-v1-1-462b9bec8c84@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 2f3e6638aebc ("NFSD: Guard admin state-revocation walks with NFSD_NET_UP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 5e3e60110ee64..32106d223a23c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -296,14 +296,15 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 2.  Is that directory a mount point, or
 	 * 3.  Is that directory the root of an exported file system?
 	 */
-	nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 	mutex_lock(&nfsd_mutex);
 	nn = net_generic(netns(file), nfsd_net_id);
-	if (nn->nfsd_serv)
+	if (nn->nfsd_serv) {
+		nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
-	else
+	} else {
 		error = -EINVAL;
+	}
 	mutex_unlock(&nfsd_mutex);
 
 	path_put(&path);
-- 
2.53.0

