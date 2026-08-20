Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFD3B5835;
	Thu, 20 Aug 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211555; cv=none; b=SRj8mt8AxiOpT7ZZFgXS5KiiTa6hcIypiiBpjuJI2mU6R4pZjQjAFzHE0PvdebLoBLVOC9dhsyPXBs36H50wCRxHVJxi5amOBT3BgNwgqWlbeabc8Y9jq8LWMMhrzECEpRY5pIBYLZw7KmFlPQyB50ey+5qmba0vfqyymFfGUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211555; c=relaxed/simple;
	bh=DdN3Gh1lxmKnB9+GTGOIIMmXR2A2U4BnLOhD1NseQtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLkJPkXZXnxUCnFB9oS8ONXSQuhbEjMvNPQqTTSgiGlitY20ORUJGq2uqzAZdpSXdWAc7BC/c3/lZRB34+Xmjwml42dvCOcuHQjNicO+DEBQqM/4dSF83ZEAk4hEHQg4B09QbubArMlsNvNntMzZ9RILSoQ3tRx438/IV35nrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 38f104649c6a11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:36b88cc6-04b6-43c6-a0c8-dfa35fd10a37,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f055d0e2a151bed5bf24dc88124f2a7e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 38f104649c6a11f19a56ed5b684f684d-20260820
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 941672992; Thu, 20 Aug 2026 15:39:06 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: require owner privileges for system attribute xattrs
Date: Thu, 20 Aug 2026 15:39:02 +0800
Message-Id: <20260820073902.136352-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_setxattr() allows system.dos_attrib and system.ntfs_attrib to update
NTFS file attributes. These attributes affect the inode mode because the
READONLY flag is mapped to the write permission bits.

Require the caller to own the inode or hold CAP_FOWNER before accepting
updates to these xattrs. This prevents unprivileged callers from changing
file mode semantics through NTFS attribute updates.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/ea.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 4fbea76afe7e..5cd5a4a02d1e 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -820,6 +820,18 @@ static int ntfs_setxattr(const struct xattr_handler *handler,
 	if (NVolShutdown(ni->vol))
 		return -EIO;
 
+	/*
+	 * system.dos_attrib and system.ntfs_attrib affect file permissions
+	 * (READONLY flag maps to write permissions). Require owner or
+	 * CAP_FOWNER to prevent unauthorized access control bypass.
+	 */
+	if (!strcmp(name, SYSTEM_DOS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB_BE)) {
+		if (!inode_owner_or_capable(idmap, inode))
+			return -EPERM;
+	}
+
 	if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
 		if (sizeof(u8) != size) {
 			err = -EINVAL;
-- 
2.25.1

