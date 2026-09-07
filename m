Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82633525A8B
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811241; cv=none; b=MJOZNkXmo1hYuKZvHInRuNE2nSx+Z/VbKXhaA4uNUvmnxgfmHdKn6FvqhanhskmD9nyxKTcVHwVqBM+iVqJNEWyw5xU4Si9PE6C2TiS4SKkLXl1zFNfW0pvdPg1L3NXG/H1pWI90DM4GxkTJ1zqeUj94zorMyPF0iDTA325zh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811241; c=relaxed/simple;
	bh=ywFDbm3dQOgcLqeurRzo7MhB0JOZ79levDI231w37kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6/vKJg+5phLlRr7pMByaC8h0jfuhrAr+tqxFfP9MJUooXaGUQ0YBox1gflw4Pn2MbptkR+GWL2T8rd4lhplRYr1CL4o2XlG4zxAJXuzmlAF75630TO3IZDLEVlJrtFqkQ5sVpAbNJCYEc8aUg7DcxjIOi10PXw5aTFd1cYsNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXqh+oYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXqh+oYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6AB1F00A3E;
	Mon,  7 Sep 2026 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811240;
	bh=jwbjVUBxJ7YKHCuD3bpYYprsD88/RaZPpyTOH9AQZ3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXqh+oYpdGiLRZW2kA+Ns3CXemWMj4psvfSDLlmArWva5bU4EQGo35wjgqidQMC/U
	 tiDD2S45ASq9VhB3AjYqvt88y4/IKFDVf7PD7ksw7e32hvnl58itIkTFgjvWh8ZkD3
	 RApvo4+RI9Bwycgz838J6V+H8NaCKgJgF9YE4KZB+7QRwW6WDFtoY67udkI/gciVuf
	 Zqi06D/3KvfLJFO2GIuA0wx3iYSfjrh0TbgF7zpS+u8GjlyaPrtdqsNw4Gxi5eeCpk
	 2tEs0r+ILoW6UpKy/zcfjtTZ28tQchX752ypdCNrLzSJTbClquo7zWx+49FHNviqOU
	 mB/iGc4nt93CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Mon,  7 Sep 2026 16:00:38 -0400
Message-ID: <20260907200038.328541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-consonant-fondue-4dfb@gregkh>
References: <2026090354-consonant-fondue-4dfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit b8e5dc4f95e5484159b343903f302eb6d783f2e6 ]

When a file has the setuid or setgid bit set and is written to, the VFS
strips those bits and issues a setattr with ATTR_KILL_SUID/ATTR_KILL_SGID
together with an ATTR_MODE carrying the already-cleared mode.

Both cifs_setattr_unix() and cifs_setattr_nounix() unconditionally dropped
ATTR_MODE in that case:

	/* skip mode change if it's just for clearing setuid/setgid */
	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
		attrs->ia_valid &= ~ATTR_MODE;

This is fine for the default mount, where the mode is only emulated via
the DOS read-only attribute and cannot represent the setuid/setgid bits
anyway.  However, with the "cifsacl" or "modefromsid" mount options the
mode is stored on the server through an ACL (id_mode_to_cifs_acl()), with
the SMB3.1.1 POSIX extensions the mode is sent to the server directly,
and with the SMB1 Unix extensions (cifs_setattr_unix) the mode is sent
via CIFSSMBUnixSetPathInfo().  In all those cases dropping ATTR_MODE means
the cleared mode is never pushed to the server, so the setuid/setgid bit
survives the write.

This is a security issue: on local filesystems the setuid bit is stripped
when a file is written, but over these cifs.ko mounts the bit persists on
the server, potentially allowing an unexpected privilege escalation on
subsequent execution.

Fix this in two places:

  1. cifs_setattr_nounix(): only take the "skip mode change" shortcut
     when the mode is emulated via the DOS read-only attribute (i.e.
     neither cifsacl/modefromsid nor the SMB3.1.1 POSIX extensions are
     in effect), so that the cleared mode is propagated to the server
     in the ACL / POSIX cases.

  2. cifs_setattr_unix(): this function is only called when Unix
     extensions are in effect, so the mode is always stored on the
     server.  Remove the shortcut entirely so that the cleared mode is
     always pushed.

Fixes: d32c4f2626ac ("CIFS: ignore mode change if it's just for clearing setuid/setgid bits")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ adapted sbflags access to cifs_sb->mnt_cifs_flags for Linux 6.1 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index b11a919b9cab0..716284c82d220 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2645,9 +2645,13 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 			goto out;
 	}
 
-	/* skip mode change if it's just for clearing setuid/setgid */
-	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
-		attrs->ia_valid &= ~ATTR_MODE;
+	/*
+	 * This function is only called when Unix extensions are in effect,
+	 * so the mode is always sent to and stored on the server.  Do not
+	 * skip the mode change when clearing setuid/setgid bits: dropping
+	 * ATTR_MODE here would leave those bits set on the server after a
+	 * write, which is a security issue.
+	 */
 
 	args = kmalloc(sizeof(*args), GFP_KERNEL);
 	if (args == NULL) {
@@ -2831,8 +2835,24 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID))
 		attrs->ia_valid &= ~(ATTR_UID | ATTR_GID);
 
-	/* skip mode change if it's just for clearing setuid/setgid */
-	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
+	/*
+	 * Skip the mode change if it is only being done to clear the
+	 * setuid/setgid bits *and* the mode is emulated via the DOS
+	 * read-only attribute (the default, non-ACL case), which cannot
+	 * represent the setuid/setgid bits anyway.
+	 *
+	 * When the mode is instead stored on the server - i.e. with the
+	 * cifsacl or modefromsid mount options (via an ACL) or with the
+	 * SMB3.1.1 POSIX extensions - the cleared mode must be pushed to
+	 * the server.  Dropping ATTR_MODE here would leave the setuid/
+	 * setgid bit set on the server after a write, which is a security
+	 * issue (the bits are not stripped as they are on local
+	 * filesystems).
+	 */
+	if ((attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
+	    !((cifs_sb->mnt_cifs_flags &
+	       (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
+	      cifs_sb_master_tcon(cifs_sb)->posix_extensions))
 		attrs->ia_valid &= ~ATTR_MODE;
 
 	if (attrs->ia_valid & ATTR_MODE) {
-- 
2.53.0

