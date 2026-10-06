Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280449E5D8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303278; cv=none; b=upJi/fzpPMfb7wO7SKO+d6a9OXg0ql4LAe+hfu7jwnH6T6vDDJPJVfyFXu8AGhEvGEDy7mBwll8gF1FMw53kAB53HCi8xpfMWh9BBXjM5h8rxeyyo3+E1DFGrZ8cN/NjdcjZWAiqYxo4XWpGZ+8DfFudP9UrWjrYOqR+ug7hP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303278; c=relaxed/simple;
	bh=HR5FB8OCAo/43n+qRa+y3/khb6JMdhxgLHs1MszRgNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4xvzKfOAIv6VTOv8pBth6Ydt7bCc8ijs4/43v7DqQH4ybxpOqJJHsf0OPa49VYqZv6odIeprj960TBxG4g0R8pUY0hspyCZBSMybkGJfT96EvdmRhRK5kv9zWDyHiPLkNtvub+F3/qR2W+6y9PCuy/9Ctlc9JattvlF7D0MwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=iTu59Hkq; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="iTu59Hkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791303276; x=1822839276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qj4WtYCG0gm1ZCBpy+8pAfEQZy31Vb4PlUBv5lo59TQ=;
  b=iTu59HkqewdnEQ6nABfzJgZmK9vpFASFUE/SLfl2i0swo1ylpnYPmRDv
   6wrPNC1zxmLPT9fS3Ho3qeCfsOWPVUUoJdecStQ8o7DVMbEZsyT5RmJzP
   FUMxV/WFSAeFtAonHbEkBAMC4hVwlNg5Yh97kYIk1JZNiTaSiG6OHHhfU
   28kcwV1cyl7b9YPWm/5fqVat4nKZHA6kD+ZLqRLmNu5WsEIV54DgEt3qE
   FFza+25wi1iGCHIHrfInywO3+E/gZGCLAWce+P2XlGqDpfRXfWDURPiZp
   ECdNa0k8BXwCCY5LpkvtrNTOvhGgqA6li6Iy19LBDgg28dkvwXk5UVmd0
   w==;
X-CSE-ConnectionGUID: muAQ5zKbTyai5IgptbhbZA==
X-CSE-MsgGUID: Ct56NO8+Q3WVuuuwzNHGeQ==
X-IronPort-AV: E=Sophos;i="6.27,143,1787011200"; 
   d="scan'208";a="30589389"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 16:14:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1448]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id 18378c73-08f0-483a-8a1a-0cac7d850752; Tue, 6 Oct 2026 16:14:34 +0000 (UTC)
X-Farcaster-Flow-ID: 18378c73-08f0-483a-8a1a-0cac7d850752
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 6 Oct 2026 16:14:33 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 6 Oct 2026 16:14:32 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Sasha Levin <sashal@kernel.org>, Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH v2 5.10] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Tue, 6 Oct 2026 16:14:19 +0000
Message-ID: <20261006161421.1948193-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002145332.3925377-1-doebel@amazon.de>
References: <20261002145332.3925377-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

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
[ Backport note for 5.10: code lives in fs/cifs/inode.c; no sbflags
  local exists here, so test cifs_sb->mnt_cifs_flags directly (same flag
  bits). Drop the upstream posix_extensions clause: 5.10 lacks
  d413eabff18d ("fs/smb/client: implement chmod() for SMB3 POSIX
  Extensions"), so cifs_setattr_nounix() has no POSIX ATTR_MODE branch;
  match its CIFS_ACL/MODE_FROM_SID check. ]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: opencode:kimi-k3
---
v2:
- Drop the posix_extensions clause from the cifs_setattr_nounix() check:
  5.10 lacks d413eabff18d, so there is no POSIX ATTR_MODE branch and the
  clause would route the kill-suid mode change into the DOS READONLY
  emulation. Mention this in the backport note. (Sasha)
- v1: https://lore.kernel.org/stable/20261002145332.3925377-1-doebel@amazon.de/

 fs/cifs/inode.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index b11a919b9cab0..1a3c7a9bafc1b 100644
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
@@ -2831,8 +2835,22 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
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
+	 * cifsacl or modefromsid mount options (via an ACL) - the cleared
+	 * mode must be pushed to the server.  Dropping ATTR_MODE here
+	 * would leave the setuid/setgid bit set on the server after a
+	 * write, which is a security issue (the bits are not stripped as
+	 * they are on local filesystems).
+	 */
+	if ((attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
+	    !(cifs_sb->mnt_cifs_flags &
+	      (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)))
 		attrs->ia_valid &= ~ATTR_MODE;
 
 	if (attrs->ia_valid & ATTR_MODE) {
-- 
2.50.1

