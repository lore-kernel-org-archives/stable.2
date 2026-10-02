Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B53033E6
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952945; cv=none; b=OEfnXNPcdkUdNSOBOVpTF/BQ3zqwggFHyxndG0D2J/cNBFkj1PMVN+2tkwGIsoTmDO8SlThYYh8nqEU/dE6JM7Q+PKPZY3fZHeTZn8fbNz2ITFai9S6AxRvgBY4wYyQ4bNeQGT44f8kCrQsJ152A5P0VdSxyWP2WMXR8HnnGSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952945; c=relaxed/simple;
	bh=6qAW5F2RUjtuTX5UTqFSkmfdWTb7EeBdy/TeigHBaSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YA7l1qeMKPb4LdL8Dt57n26OazqYPDRbmmwG8vfaF1zMFAduDpTvtzD2vLdpJyfidR08wZMEQxOQ28pCw1uHn6HW2bkVX6MnfGQFkMYzCIAEKKP5N4qtv1dDuiyHLTtBp+lCn49ghwVFxRIhm+Z2kjVj04vkXNjKzn+GfzmfuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ddqgOdh8; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ddqgOdh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790952944; x=1822488944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4mmPmwCUBY1t6+agFyd1MJKDtCJndnq3T1vPQHQ6mHY=;
  b=ddqgOdh8HW9SEyOAftvHUhgeKHymmx+axwzZIdGFXU/22ANT9I8vqVns
   Fslpc67RDQWB0LMEd02UqZ9IczrE8FypsXbtx1Xb1DbTWCUh/6bKH1Nli
   5EsaQG3H/4U4vxDLalfhqsrFmZTS/h3BPcy16BOEdFyP3I0d+TqtQyPdV
   7r0f1uaGkUgLlfh8o++sHNsKa0e9qgvjDq3Xbrp9t26oThTRjmAqvn+/i
   tQ9UuuGn1+oI+hLQb0blpd7orOkR9VpIm4b6WDQHXLISLdHVS604Z1akS
   PZO/J+cdYvboo9wZJLMsIKItnkCNar6Wi6QMGCppPmOlWouOGUnEujg6O
   w==;
X-CSE-ConnectionGUID: Ufi0HZTWQcu+RLA7IrM0Cg==
X-CSE-MsgGUID: sLGECNU2Qrqmzd74QVOFlg==
X-IronPort-AV: E=Sophos;i="6.27,136,1787011200"; 
   d="scan'208";a="30224353"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 14:55:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:12966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.21:2525] with esmtp (Farcaster)
 id 80a85674-026d-45f9-9dda-9f2b2f8b11cb; Fri, 2 Oct 2026 14:55:41 +0000 (UTC)
X-Farcaster-Flow-ID: 80a85674-026d-45f9-9dda-9f2b2f8b11cb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 2 Oct 2026 14:55:41 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 2 Oct 2026 14:55:40 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Jiangshan Yi <yijiangshan@kylinos.cn>, Namjae Jeon
	<linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.org>, Bjoern Doebel
	<doebel@amazon.de>
Subject: [PATCH 6.6] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Fri, 2 Oct 2026 14:55:33 +0000
Message-ID: <20261002145533.3927672-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Jiangshan Yi <yijiangshan@kylinos.cn>

commit b8e5dc4f95e5484159b343903f302eb6d783f2e6 upstream.

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

[ Backport note for 6.6: no sbflags local exists here, so test
  cifs_sb->mnt_cifs_flags directly (same flag bits); uses existing "bool posix". ]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: opencode:kimi-k3
---
 fs/smb/client/inode.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 0000000000000..0000000000000 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3064,9 +3064,13 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
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
@@ -3253,8 +3257,24 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
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
+	      posix))
 		attrs->ia_valid &= ~ATTR_MODE;
 
 	if (attrs->ia_valid & ATTR_MODE) {
-- 
2.50.1

