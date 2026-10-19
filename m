Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424866;
	b=AO2KWqOCa9PQWT6S3Qi7C3rJ/3Q5fh/6emdLEO8hPmRTR+DzUy+zET1AMqLaaEpYdH9n
	 0EqLvkI1ihto7vJ4LyDJMZEXqq/YIYzT4pmAunyd2BR1ONn0+GsvyBUuJhlszuofZFKSp
	 E/T0HtGTGN87t1iYFlPtGhMKZm6gGCM6x8/P92xkYlbe04jrJ27l4QUtoantSOq2oj4yz
	 /U97WvyRV+HLULt4GSiQIAGMDC/3cMA4IHqpAcYBLzIDrllecsXMKWQKEs0QBwLJE7YC8
	 JoA4DCIEs241iGfimgB7qHryecXu5V/CymyRMBW48l4Ma9qNNEOX7qUdc6i0H+nCFiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J4t4H89v7aV1e5EzzyxhnG8qiUcpvGcd+ixs31MkbCQ=;
	b=Hj3t3sWpPlElc+FY3k/I69wvzg89NayrImN3YUfXG9NKx0dSFm9XbNRdHh0ZbYRVprJU
	 RWPtl5eYYnePQMYEvVVaiuj7DNBIwsD4KCddI9dSNBByvbI8l2Zm0/W6Ec/2ZIHTXsskE
	 WwP4JirVra9t9kXD/DwJrO1XPcCZYk4PBTZYBvNt3/3/Reck4T4gjcV0qfJ8BkAV3AW4K
	 lf7BLZkHD9F8W898ASjmM8wTb9aFiKkpFdcNSWlTbTfRqrbQrduSa01n8iKCLxsxNBaAn
	 r+LeFdcbut5srjsCWlWaRnzh3UvhZPiw41nxLk4ZgfE4FbVrBCu0t37lRSEeRBjZR8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NyB55KG8;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF3607553D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3AF3607553D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NyB55KG8
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so676241b3a.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792424865; x=1793029665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4t4H89v7aV1e5EzzyxhnG8qiUcpvGcd+ixs31MkbCQ=;
        b=NyB55KG8d1iW+QLhXJyq11mQNA6PgfqLPndw/T7DFLnL+3R/NhJ6+y4gBc2uGctA01
         xKmOFn8XIhtJGBixvzTCHtnkV61Sj9DcejX1ndH1Kt4pO/Fo6BEhVB0eA+USc3HVtQHm
         r7UqpM5WGEpeX0jO/hGYhIrVEPhjWBaSxk6fCD5n/2vkH2sr3k5aL8OkxDSKwLvA8V3h
         oijTd9/iXWa91jWv1TAcMjBNrK0eUsgQxwg1t185OMgttjVC9+nCC2usntILM/kJRHfy
         n4tuZVc+HlDfZ3Zi54xcQX8QY/Di2EYiFV5C1vgeYbb5QbPjpJeAMgkHWTXDJfXdE1AG
         CdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792424865; x=1793029665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J4t4H89v7aV1e5EzzyxhnG8qiUcpvGcd+ixs31MkbCQ=;
        b=tkVSLW6fsKxYb74ENjoQ84h7DrKDPr1YmT/SV5jdJoR149yGGiTGW1FnR7S/Wa1v6K
         Kh6/oP0mrE1rAznV64wHHj3gIokOgqsIMrm0JRrptaM08ieg8l0VzP6wnfQ82k101/Lo
         owX0WqZkYbK4YHF1xyKaS0Lq/EJhoD8K/tBdnE0gtw2xgaBHakWQwNVQxONk3x/RFWOC
         loxAn7lry7rBHlZYaCy5I9CrFv21O9krRsjg6GYMpM06RLT6dhHsvhAWoeC0cie8DHqS
         nqXxD/50HOn9Rp1wXqqpn3aMRojd8yN2shc9vqi9pOyEODtkRpnWRHXveBL2oF7FaHBc
         qN3w==
X-Forwarded-Encrypted: i=1; AKwUvBzj7Ubs7uqNEI1OGTz91aX0POHC35tAWHWQwx7xNqwqXq+gNIehrdW5gxL6P1VHAFiNn+/NsFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1xxSKMTIqZqIp4h5n2b0eO/mC0lZ4q0SD+vt/Yol6kx9hrk0z
	1FWXk8JO73cderVo9s7/TBNEtPXKPkMuvov+7CZNgOrZh/05P/eIuaUH
X-Gm-Gg: AYBFou3C/8/Tf5gVKXKES2nwpUUmVUxhAU0vImROBHy9Kgbt5reeXzjXwykLAxmnUAK
	RKoS/4YD0l0JR2J+U81WuB98RldT5DZssROmBydCfJ5DTAH7XZHwKZxSlgG/5ybffKEABzz1QtV
	HZNQkL2jsbI+2y5A/DJMa0A7tRvcoANtdDtia8bdrofcZ8Rmue1n08+9csp+icz8raV8rHD/ybz
	Ap8IL+Kmx0E5pcw5tb90mLAAuaywNw/ciPfSU9Ea27wC3KtSPuzNOxfis8oPfNW0/pPvV975RR9
	nGWTNgvk2cJO9dCUizx4CmG0R6/W7ib3QM8YfIMYFTpq2hYxt/KUVtm78MrvpnIFVzM5zyMKg4O
	YPsKMKFdAp2qMmqe/3js2+XCJ0v42OtzrN4Jh/GDpfT2CEPAbxmCBSAKyTrNHYbIBeYFiN4ZqwQ
	oucpIhyAwNYIvelQjhNmbdfjoqMSySZgMuoGuaoN/X5UcitGYF/71xPP4SP0QZRWy8g4mNN66KO
	JWWqmaXVWzAgbD3K2Rm
X-Received: by 2002:a05:6a00:7701:b0:89e:37b0:d1b2 with SMTP id d2e1a72fcca58-8a05742b68cmr4299138b3a.37.1792424864745;
        Mon, 19 Oct 2026 08:47:44 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e513sm4108693b3a.27.2026.10.19.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:47:44 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev
Cc: r772577952@gmail.com,
	heming.zhao@suse.com,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: validate the block count of a local quota file
Date: Mon, 19 Oct 2026 23:47:32 +0800
Message-ID: <20261019154732.3149351-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANypQFbjcxXjiigMCCyErN=DSEh3ZG3NMWRpq=Hic8KJ76cwew@mail.gmail.com>
References: <CANypQFbjcxXjiigMCCyErN=DSEh3ZG3NMWRpq=Hic8KJ76cwew@mail.gmail.com>
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

Every ocfs2 node keeps a local quota file made of chunks.  A chunk is a
header block, whose bitmap marks the entries in use, followed by up to
ol_chunk_blocks() blocks of entries, and only the last chunk may be
partly filled.  The file header records the number of chunks in
dqi_chunks and the number of blocks in dqi_blocks.  When no chunk has a
free entry, ocfs2_extend_local_quota_file() works out from dqi_blocks
how many entry blocks the last chunk already has, and puts the new entry
right after them:

	chunk_blocks = oinfo->dqi_blocks - ol_quota_chunk_block(sb,
			chunk->qc_num) - 1; ... *offset = chunk_blocks * epb;

olq_alloc_dquot() then sets that bit in the chunk's bitmap, which fits
in a single block.  This is only safe while chunk_blocks is at most
ol_chunk_blocks().

ocfs2_local_read_info() reads dqi_chunks and dqi_blocks from disk at
mount time and never checks that they agree.  With one chunk and a
dqi_blocks of a few thousand, the last chunk appears to hold thousands
of entry blocks, and the bit lands kilobytes past the end of the bitmap.
A dqi_blocks below the last chunk's header block makes chunk_blocks, an
unsigned int, wrap around to the same effect.

The stray write corrupts unrelated kernel memory.  KASAN calls it a
use-after-free only because the page it hits happens to be free; nothing
in ocfs2 was freed.  Reaching it takes mounting a crafted image with
quotas enabled, which needs CAP_SYS_ADMIN, and creating a file.  The
issue was found by fuzzing and not seen in production, the reproducer
can be found in the linked report.

Check in ocfs2_local_read_info() that the last chunk has its header
block and at most ol_chunk_blocks() entry blocks, and that a file
without chunks holds only its info block, since the first new chunk is
placed at block dqi_blocks.  Refuse the file with ocfs2_error()
otherwise, as ocfs2_read_quota_block() does for a corrupted quota file.
The header block of the last chunk is computed in 64 bits because a
crafted dqi_chunks can wrap ol_quota_chunk_block().

Fixes: 9e33d69f553a ("ocfs2: Implementation of local and global quota file handling")
Closes: https://lore.kernel.org/lkml/CANypQFbjcxXjiigMCCyErN=DSEh3ZG3NMWRpq=Hic8KJ76cwew@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5-5
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/ocfs2/quota_local.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index f55810c59b1b..bad913d8bc4f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -678,6 +678,30 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 	return status;
 }
 
+/* Check that dqi_blocks agrees with dqi_chunks in local quota file info */
+static int ocfs2_local_check_info(struct super_block *sb, struct inode *lqinode,
+				  struct ocfs2_mem_dqinfo *oinfo)
+{
+	u64 hdr_blk;
+
+	if (!oinfo->dqi_chunks) {
+		if (oinfo->dqi_blocks == ol_quota_chunk_block(sb, 0))
+			return 0;
+	} else {
+		/* Same as ol_quota_chunk_block(), but in 64 bits */
+		hdr_blk = 1 + (u64)(ol_chunk_blocks(sb) + 1) *
+			      (oinfo->dqi_chunks - 1);
+		if (oinfo->dqi_blocks > hdr_blk &&
+		    oinfo->dqi_blocks - hdr_blk - 1 <= ol_chunk_blocks(sb))
+			return 0;
+	}
+
+	return ocfs2_error(sb,
+			   "corrupted local quota file %llu (chunks=%u blocks=%u)\n",
+			   (u64)OCFS2_I(lqinode)->ip_blkno,
+			   oinfo->dqi_chunks, oinfo->dqi_blocks);
+}
+
 /* Read information header from quota file */
 static int ocfs2_local_read_info(struct super_block *sb, int type)
 {
@@ -733,6 +757,10 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	oinfo->dqi_blocks = le32_to_cpu(ldinfo->dqi_blocks);
 	oinfo->dqi_libh = bh;
 
+	status = ocfs2_local_check_info(sb, lqinode, oinfo);
+	if (status)
+		goto out_err;
+
 	/* We crashed when using local quota file? */
 	if (!(oinfo->dqi_flags & OLQF_CLEAN)) {
 		rec = OCFS2_SB(sb)->quota_rec;
