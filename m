Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46B49EC5E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781672; cv=none; b=Owq8WLUNBkS3WPTvbJrs203zVneQE6XXeEag6/J/mU4COdIBMBIUlSKFowZJcLrFh0wnJ8qQv7vpS68RHJstZH39F+pob7Dpfd216Jhvf79zvOkDOS1BV1v3z39li2AU7xH9tK5TPtqBLs0Jxv8phMGRW70EDHeT8fz4SuWN+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781672; c=relaxed/simple;
	bh=3QHBGowDoVeCPPl+wJTxzY8ygRh/raya1+O/v9ZTMZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLQPenY81E9s7JbRLRGFwalDxOq2XHX2RvZ2xgPrHJH+IQfpqhQ5c22pbJwhyJdJNyjyB4LTidCS/jC49hZmpjL7SgghJ7L44pgVerjDImAVroF7ylcePTC4GeSvQ0JBkPrMn+4aVit4NsbJGxjF4B2BV2XD3qZgy3acpi1pv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asJ8JMZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asJ8JMZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9D11F00A3E;
	Mon,  7 Sep 2026 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781669;
	bh=mSKDz0FFqAoMs8GDOBWOLuqyczwnlgF0YOip10GnBTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asJ8JMZFTnUPnUhAicJaElODLuXCvv44/nNSznQ1oXhC3hFztbGtfF5jUp2zXC2Jj
	 K/OEcOZC1Ep/L5sqlPo34mFE+42qbUAkZaSR4cUKWlWU+tJcpCREYS/sm4MNvg6ch8
	 T0gqzv2/Ewgmr6KHm9isjFLl9D01YIcYwinQB97+FbnIeWlAcB7uEQnBNgS2ykHxYj
	 rmIiRidj+jIkAL1BBmIJ94vUyFEO6dC+O/77lOdC4Z4a2JdG/Hzl5r28cqxOrVa6t4
	 iB4BvuidzbhQaKKjauVSNJDys82rcEABM6KEklr4Luy+Fe2sMXX5n9j8qMTcREwMJN
	 Q/owxEPbYjyeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Mon,  7 Sep 2026 07:47:42 -0400
Message-ID: <20260907114742.2872537-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907114742.2872537-1-sashal@kernel.org>
References: <2026090351-popper-penpal-d0a0@gregkh>
 <20260907114742.2872537-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 26590df944f04..4037971e828bc 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3118,9 +3118,13 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		attrs->ia_valid &= ~(ATTR_CTIME | ATTR_MTIME);
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
 
 	args = kmalloc_obj(*args);
 	if (args == NULL) {
@@ -3309,8 +3313,23 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 		attrs->ia_valid &= ~(ATTR_UID | ATTR_GID);
 	}
 
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
+	    !((sbflags & (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
+	      cifs_sb_master_tcon(cifs_sb)->posix_extensions))
 		attrs->ia_valid &= ~ATTR_MODE;
 
 	if (attrs->ia_valid & ATTR_MODE) {
-- 
2.53.0

