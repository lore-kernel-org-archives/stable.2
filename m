Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3D3DDDD1;
	Thu, 20 Aug 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216140; cv=none; b=sNvk6R3Iq0b8wqt00ZK4enmbyKrQ1qc5OpDAwPyp6cP/bplibXD0tJjrKuSzCEnf+dOj55v0ZiMF7/6QmwNUydCnOdsmHKlegljDb0jvKHDhcNxohIWwCSCETOhcVL+ZjmUiwhyRO25CnpOOyBtBghNuRDbUv7wR+i650cxxGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216140; c=relaxed/simple;
	bh=UihTdHI6l9UbD3yGyq9GDngt/s1heLl9kIX6GK1Ady0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VboJABSntLjJF6vgoAmA8aGdtUi/X5zN6yL6sHv14hii8VRfOLMCNKbk9skYyfk3ZFLOqkd34du1j8xyGP0cGiFzQw+5qyTknlvCmjA2KIoNp37ENHekq/xflifiHg/MKyPZEAt4ADF4l6Iiw3Xkw2naAhVUJ04hyZhFLd9TKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e586b99e9c7411f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7a9de21-bb99-4eb0-aafa-0ce9b53b145f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:38c983c4a0b25c0e6a7507c1e3a04a15,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e586b99e9c7411f19a56ed5b684f684d-20260820
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 611031109; Thu, 20 Aug 2026 16:55:30 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: add permission checks for NTFS system attributes
Date: Thu, 20 Aug 2026 16:55:26 +0800
Message-Id: <20260820085526.169144-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs3_setxattr() allows system.dos_attrib, system.ntfs_attrib, and
system.ntfs_attrib_be to update NTFS file attributes without permission
checks. These attributes affect the inode mode because the READONLY flag
is mapped to write permission bits, allowing unprivileged users to bypass
file access controls.

system.ntfs_security allows modifying NTFS security descriptors which
control access control. Similar to POSIX ACLs where file owners can
modify access permissions, require inode owner or CAP_FOWNER for these
NTFS system attributes.

Fixes: 4534a70b7056 ("fs/ntfs3: Add headers and misc files")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs3/xattr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 7a81369a1173..4e41aca0d5c7 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -868,6 +868,22 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	enum FILE_ATTRIBUTE new_fa;
 
+	/*
+	 * system.dos_attrib and system.ntfs_attrib affect file permissions
+	 * because the READONLY flag is mapped to write permission bits.
+	 * system.ntfs_security controls NTFS security descriptors.
+	 *
+	 * Require the caller to own the inode or hold CAP_FOWNER before allowing
+	 * these NTFS system attributes to be changed.
+	 */
+	if (!strcmp(name, SYSTEM_DOS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB_BE) ||
+	    !strcmp(name, SYSTEM_NTFS_SECURITY)) {
+		if (!inode_owner_or_capable(idmap, inode))
+			return -EPERM;
+	}
+
 	/* Dispatch request. */
 	if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
 		if (sizeof(u8) != size)
-- 
2.25.1

