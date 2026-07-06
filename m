Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539523B1EFB;
	Mon,  6 Jul 2026 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310490; cv=none; b=JOhPWFNoz5FqpvvKzQatUMMZsJccSdVRiap4AQaRc/e7MDLIixAO6XJjDpejLbwk/ioOmefQsODpteM4WtA/CZjpYR2JqWq4Pa4xQsLMHJiJ649R6wFqkQeBGxYUgPRGh0ETeIE+54bIu16R2WCSfc3fPJTz0dopYZjRB8wHKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310490; c=relaxed/simple;
	bh=ljvOM33/j2Xxv3dk5TCikWXeIvoy30/FryuIkc0sf2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdAOUyR4tpG4zos6cN1UJkCwFrdssd7ILxHcc0ATeoDOjXjWLzMktNC+kK/FGF6OAEolx5i8J3khH0u2gxvM3NlbguAJiUxPMNITwNKJIMgWJr5Qt8WevUOZ1Mx1noC7HZhXEtwx3AIoa0JgW8B11U4iak5lXskPvw8NjWkAeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=2gl+vCod; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="2gl+vCod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783310450;
	bh=tjrOM6PyX4kDIg0sU86ZR78XTEWudzor9AVaa1May2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=2gl+vCodv8RSIDwlOILDVlFbaSjbVlAp85GKmEDO72pQN+O9E/5WNJzTB08YOjbb4
	 TARj/HJfNZJuyeFxFo10cEocxZ3IN+1Lo372VzQr9QzsVigUZX0hZOKt58Vyuq1soB
	 Wzn+Z3EuSYUT2pGcKM2wcNJfAa0aaz25oCJdMFqk=
X-QQ-mid: zesmtpgz7t1783310446t2e2a16d3
X-QQ-Originating-IP: gELqnvcASbNGn9Saat4iEXMErRuvsOV48BQ1DGOaFDM=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.72])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jul 2026 12:00:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5072464180285240553
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: fail attrlist updates when the superblock is inactive
Date: Mon,  6 Jul 2026 12:00:15 +0800
Message-ID: <A82793FCC5832BB2+20260706040015.58048-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
References: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NpfbsqbTlzxUvGUMliidCt9CfeS7qQ71EmSejH2/RFlws7vp2fQO1sCa
	55WpjqJarTAcKt8RjjvS4L1IwgOvr6aelXuDHznZDsspj6GHmepHwj5Go4EGruzzYpfgptK
	CIr4vGPqix/uY7AnkucmwRJZhszPDEVcpgUQCLZNVGfdqVL/AQoKMySOiYbWhIPI+C9RP4+
	b0SAJMJTfTf3Owypkoxzx2ctI4olvuA6grHUF/vRO/QRpDDcNodC3kyxFhbmofKmHxD9fRE
	Qt9WnLDZJ9PwJnJSjTVpYMw6JGdDOLbYiMjPWJ+maZweP4E+bP48fwj34fn5ieR8NcbkUbZ
	K95OGZIB+czWQ535TvZW9j/3PnD3Tv7j3qlgbmJroCTx7e8FrsNZHwGmT4PWVA5GXJ7NYnH
	55eKhffGBqIOprmkjeRKU2SlYQImF3VGalEKMSxL5SKdkwR4jsGr7P0+3CeC3HMXKUVoxEa
	k3UjbJyMrV750fNKU1goHTtdAS0w0BCePuBUodPiF3LnxQnaiDdufPgBvcZt/9mnXNlzZXm
	LvMaHTQhuGLOIc7BS/N2/08VwkTg0JO0zV8QCnGAVoUHysRwzT7v74l0RpdwdWziiH3NCWi
	H98RUKaDX82m3v4Jek4bwKff6N3arrtQ6sLJDTLfc/f6WcL1Ri+fk4BkRya0vBbAfiOnBvh
	V92iqD0yoUW5HR1HICkPd1fQV8oQD4HGSICmBB/X1bo/Qqz0tQErpafWpJrbTmmzUkvgPVB
	804S6TPDUSFeXl1tnzVwP0cmJf4r7mI4G5IjZ/HB6oyxQGeWYmMeIpAIR/7e7CGTmAj69Dh
	IaCcjuCaFzhcvWTD1sWOPNNCy67rxT8SaA3rGUPSjx9Q4ekWpadsHGV9MdAGusDOc/QXuFP
	bpdRaUoXPgFY+Cq3QtUbkq54uVkDI2LgB8c8x24mq3MwIE9PY7vKyC1vKoLaMkNXZGBxHQr
	oO6ZbcrKoWg+yMPZlOKiWjZAH1s3Om0FkVXkd7P41xmM9Z5UIrVN7uniBdudZeYSqY0e+/W
	zZO8Ts2JP3uYBCbSK0MZ5FnbSyDABBpe67ppQy6ubrGT8Uu7qAR9giFQekEJ1/67hDqG6V2
	DzkqPYDCOp4
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

generic_shutdown_super() clears SB_ACTIVE before evicting cached inodes.
If eviction selects the fake inode for a base inode's unnamed
$ATTRIBUTE_LIST attribute, ntfs_evict_big_inode() drops the fake inode's
reference on the base inode while the fake inode is still hashed and marked
I_FREEING.

That iput can synchronously write back the base inode. The writeback path
may update mapping pairs and call ntfs_attrlist_update(), which
unconditionally calls ntfs_attr_iget() for the same $ATTRIBUTE_LIST fake
inode. VFS then finds the I_FREEING inode and waits for eviction to finish,
but the current task is still inside that eviction path, causing a
self-deadlock in find_inode().

Fix this by mirroring the teardown guard used by __ntfs_write_inode():
once SB_ACTIVE has been cleared, do not try to iget the attribute-list fake inode.
Return -EIO so teardown aborts the update instead of waiting on the inode it is evicting.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/AB8D5E603E6EA856+ae5f622a-dd3a-4e38-bdd2-42276ae0e1a8@smail.nju.edu.cn/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Changes in v2:
  - add code comments
  - collect Reviewed-by

 fs/ntfs/attrlist.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index afb13038ba42..be3086d34338 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -57,6 +57,15 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
 	struct ntfs_inode *attr_ni;
 	int err;
 
+	/*
+	 * generic_shutdown_super() clears SB_ACTIVE before evicting cached
+	 * inodes. Do not look up the attribute-list inode after SB_ACTIVE has
+	 * been cleared; it may already be I_FREEING, and waiting on it can
+	 * self-deadlock.
+	 */
+	if (!(VFS_I(base_ni)->i_sb->s_flags & SB_ACTIVE))
+		return -EIO;
+
 	attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
 	if (IS_ERR(attr_vi)) {
 		err = PTR_ERR(attr_vi);

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0
