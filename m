Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929988;
	b=LkR/atMC+ukiQKp3H9vkn8x7Xtzy1nAdxcY8toVXEbta96R1QyXlLFENHbXOze9a6CVc
	 DaRUsnBft/fJ40QMhOfEGf4whkzziN7pKN3vga5x4NYth9Wcl815QBfObis1ELlD5rD7u
	 nizFkCNGC/ba4DR5NWhaGCbzolPVVSZ1lTpk0+wkba0tFFAnwxfhtCjviw7ue66mi7m9e
	 Tgf1iQMgHVeiLMOutgh1ASqPwUeb6jIj4SkVTz6jfdxVQfa/P0lk6w4cBK4vN6pvUwqX5
	 g4xTgbUslXSmQTa2X2fjPltCHMiTaRoI8fod5GFOmqTH4sHcHk9xzogChWnIyBbmlNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GNdigNYAas6SKGxbSHa7ya5ZvebOJ7BNFuDXKivyGVs=;
	b=vcbGTAhE4lRQzOR92/mbUJ0eSj6GKfkjgantM26XB9wCkB0h+5opc1RYOJjhAddumpnR
	 40ilG8RZAQ4SFbxUCipVsdT1DFSGb8cxuaAwGVlnZ381zPUh1xKMBM2DjdafL4Xv0pyNH
	 WwkPdol9ILBvms/fYzPkhLYdJSbdoMouufLc7+mhBb4CEQoULykbxxo4LohNBG6v6mShr
	 Da14UI9HBYCQ24FrA9fr0E9reLOqS1ES+nLRPGmHQdd+CW+NCSqH5GkVYIv74fWcv4o7+
	 qLIZEZF5kaegawSWPOiWhoWLTqlb1o8AAzmT75+Gn9h+T7R96dKTOwsWr8uDtU07jqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORov6dCW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F8606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORov6dCW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2BF1F0089F;
	Fri,  6 Nov 2026 01:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929987;
	bh=GNdigNYAas6SKGxbSHa7ya5ZvebOJ7BNFuDXKivyGVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ORov6dCWgrtAsYHyuuOEqfOexZgl8q6Hj8wKM+TxDrhT3i33SSiRjnxk9WAD7YJH0
	 sCKofDeEy43ydmQYI+vbeVlpfaysEqNv88iWNQrwt3p7QHPk8n17SttgR9yUPynX7r
	 Zn80Lh1gUP/xiwugk09f0t0i1pGnWNZR0A2jmuZejGTrB362ZA01ySw3YPBXYk2lZx
	 +gsI6vrHObVGbcc8toAybik1hIYN4PzQANFRn6p+I5eyo7AYdFMWpw4c8VYD7RvHC8
	 oQsISX47Lp9vdhb0dcPakurIr9PUOde2tSsjQR2EiL8o9DjsJo1f+HJPDF2BJ71d6W
	 LIDlel1vsIv9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] NFSD/blocklayout: Extract extent mapping from proc_layoutget
Date: Thu,  5 Nov 2026 20:53:01 -0500
Message-ID: <20261106015245.3586810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110409-glaucoma-strongman-8f52@gregkh>
References: <2026110409-glaucoma-strongman-8f52@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit a1dce715c64d4376321b5534366ae48fd7d14bcc ]

No changes in functionality. Split the proc_layoutget function to
create a helper function that maps single extent to the requested
range. This helper function is then used to implement support for
multiple extents per LAYOUTGET.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 5d28b2c920d9 ("nfsd: don't offer flexfiles layouts when NFSv3 isn't being served")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayout.c | 115 ++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index e9512c34c9dcf..8f6478d88ea22 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -17,68 +17,44 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/*
+ * Get an extent from the file system that starts at offset or below
+ * and may be shorter than the requested length.
+ */
 static __be32
-nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
-		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
+		u64 offset, u64 length, u32 iomode, u64 minlength,
+		struct pnfs_block_extent *bex)
 {
-	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
-	u64 length;
-	u32 block_size = i_blocksize(inode);
-	struct pnfs_block_extent *bex;
 	struct iomap iomap;
 	u32 device_generation = 0;
 	int error;
 
-	if (locks_in_grace(SVC_NET(rqstp)))
-		return nfserr_grace;
-
-	if (seg->offset & (block_size - 1)) {
-		dprintk("pnfsd: I/O misaligned\n");
-		goto out_layoutunavailable;
-	}
-
-	/*
-	 * Some clients barf on non-zero block numbers for NONE or INVALID
-	 * layouts, so make sure to zero the whole structure.
-	 */
-	error = -ENOMEM;
-	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
-	if (!bex)
-		goto out_error;
-	args->lg_content = bex;
-
-	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
-					    &iomap, seg->iomode != IOMODE_READ,
-					    &device_generation);
+	error = sb->s_export_op->map_blocks(inode, offset, length, &iomap,
+			iomode != IOMODE_READ, &device_generation);
 	if (error) {
 		if (error == -ENXIO)
-			goto out_layoutunavailable;
-		goto out_error;
-	}
-
-	length = iomap.offset + iomap.length - seg->offset;
-	if (length < args->lg_minlength) {
-		dprintk("pnfsd: extent smaller than minlength\n");
-		goto out_layoutunavailable;
+			return nfserr_layoutunavailable;
+		return nfserrno(error);
 	}
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
-		if (seg->iomode == IOMODE_READ)
+		if (iomode == IOMODE_READ)
 			bex->es = PNFS_BLOCK_READ_DATA;
 		else
 			bex->es = PNFS_BLOCK_READWRITE_DATA;
 		bex->soff = iomap.addr;
 		break;
 	case IOMAP_UNWRITTEN:
-		if (seg->iomode & IOMODE_RW) {
+		if (iomode & IOMODE_RW) {
 			/*
 			 * Crack monkey special case from section 2.3.1.
 			 */
-			if (args->lg_minlength == 0) {
+			if (minlength == 0) {
 				dprintk("pnfsd: no soup for you!\n");
-				goto out_layoutunavailable;
+				return nfserr_layoutunavailable;
 			}
 
 			bex->es = PNFS_BLOCK_INVALID_DATA;
@@ -87,7 +63,7 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		}
 		fallthrough;
 	case IOMAP_HOLE:
-		if (seg->iomode == IOMODE_READ) {
+		if (iomode == IOMODE_READ) {
 			bex->es = PNFS_BLOCK_NONE_DATA;
 			break;
 		}
@@ -95,27 +71,68 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 	case IOMAP_DELALLOC:
 	default:
 		WARN(1, "pnfsd: filesystem returned %d extent\n", iomap.type);
-		goto out_layoutunavailable;
+		return nfserr_layoutunavailable;
 	}
 
 	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
 	if (error)
-		goto out_error;
+		return nfserrno(error);
+
 	bex->foff = iomap.offset;
 	bex->len = iomap.length;
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+{
+	struct nfsd4_layout_seg *seg = &args->lg_seg;
+	struct pnfs_block_extent *bex;
+	u64 length;
+	u32 block_size = i_blocksize(inode);
+	__be32 nfserr;
+
+	if (locks_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
 
-	seg->offset = iomap.offset;
-	seg->length = iomap.length;
+	nfserr = nfserr_layoutunavailable;
+	if (seg->offset & (block_size - 1)) {
+		dprintk("pnfsd: I/O misaligned\n");
+		goto out_error;
+	}
+
+	/*
+	 * Some clients barf on non-zero block numbers for NONE or INVALID
+	 * layouts, so make sure to zero the whole structure.
+	 */
+	nfserr = nfserrno(-ENOMEM);
+	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
+	if (!bex)
+		goto out_error;
+	args->lg_content = bex;
+
+	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
+			seg->iomode, args->lg_minlength, bex);
+	if (nfserr != nfs_ok)
+		goto out_error;
+
+	nfserr = nfserr_layoutunavailable;
+	length = bex->foff + bex->len - seg->offset;
+	if (length < args->lg_minlength) {
+		dprintk("pnfsd: extent smaller than minlength\n");
+		goto out_error;
+	}
+
+	seg->offset = bex->foff;
+	seg->length = bex->len;
 
 	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
-	return 0;
+	return nfs_ok;
 
 out_error:
 	seg->length = 0;
-	return nfserrno(error);
-out_layoutunavailable:
-	seg->length = 0;
-	return nfserr_layoutunavailable;
+	return nfserr;
 }
 
 static __be32
-- 
2.53.0

