Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011863;
	b=nxufokg0891ljMi12nVVdn678AKWMQaKdzFJ/sn5gDj5j/NjEnZ+tYgbnZrKG7QM8/aq
	 n1JwreMibHyC2GdwiZ8QfOaO0bgcGO0TG734pypjIjJdxlv6LOzdAE4dXRmaZ6L3+8hCS
	 1tLx30a6iAJ0RTYo6eEuSQDWi7pe07PjvbPdGFVeyngMA5xxi8qoG/YMC7smEJMNQhXyO
	 tK1C7VAtdu+MK2EKI9pw7QBcMfzbUd4MQH8447xzWrOc1jXM+6JNMEthXprvbJi48aNpV
	 /Ah7zM6YfVzD4wNRch/Ds/63S1xoe9papt05ebB6ZTDWWYW9O6kMB6Wri+ZWuj0heiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=;
	b=IXtSu9Fgq3ugSTdRQ9Hsm7kVSwwSpzJ5hZux+G0pMtoaziGyaAgQVZURyyCCIrT933EA
	 CP4DJxwepG7Jmfv0vHpC0bEYjgB6VV2zpHLQ+dzOWI+bNJmQ0Mg2KgpXhvl/fr4Dh+fDK
	 rzUyNrHUDXpcGkl0UNTooaQYXsDsn2kQPvND9c0wiYtkASi3SMiNz77gcWYciEqWDiQH1
	 AcQVgqGLvDneKsPHpYyZKSbpOufm/BJ/XP2l5B41kobhkIFdoqP2lb+Z/aZScHCQJ0YiH
	 MLF6o3Xh/U1gtioP4h9/wLVnIHHi5LgnonCRCilpMXEjjv6lfhdijuCPhPXeTLcVEfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+IVH3Sb;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29632606A32C
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29632606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+IVH3Sb
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-19305bcb72cso1891592c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011862; x=1793616662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=;
        b=f+IVH3SbG8hiisMXFSjhAeGotRyhQpy/OMWP+0tpxsHbOoWrTCsrDXHFZHQGU4/jw3
         zCPyecSnphnqpuD6xwIT6bT/2BWnaDsAXX+GNpepK88bg7AImzzRaEA+YR7zNJZzWTYG
         UI52QXKfZ1EF/mrHMS2itzQq7gLJb6+5H1dgrIePKQpTYBy2CKoWW3ki9esMSuWNTEWo
         QhV3lc6lymJOPyq6NXhoTg3Ok6fvw+71kBfjgXJBRi3LcXTN9eediER4Hb5gKaNmyESN
         i3SBSKCg6GfLQr4eq5KGfDzmwPhW5rSRd2pLTWagAsgM0e70DSenqbxY9wxt0LaiZQZN
         xuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011862; x=1793616662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=;
        b=pgtY7MY5CSbyvkzRSm6WUWlh7kxpY9WdRGTIUtMxO2oAAhbljASEO4ruV2y5+8JUt2
         NRZYmXQw3xc9du3N8yGF+Rr4C3Y/rugrDX0lL20tRdU1SzG6KniAd4jFdX99NvLINqsN
         iP0PMHfJJBkwUmRhbLkoMy3AKjJPHHBJUhHyF1ErA4Y4LrsQogE3RoozfV9w24w4iYbF
         LjVVl1FfKXn8aSMYbi50VHKKzUy1++hAuHUjdCr/i2jcFfgTRymm1TbdDXw0Qpfvgo3p
         mb/Qj52WJ18jYn7Csd3zMkexHLZ+wtYZ1mwBvBIcNL1UbhLNFsg59mgZ4WsfRu1fuQ2m
         UhAg==
X-Forwarded-Encrypted: i=1; AKwUvBzTmiBvIUdY6D8hRCQ3SKN1BDQdQphWUagt/UETd2HIuqelMaYJrkWouo9EJ1i0xj3sgNfsazQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6FAPi8z/qmZsOw41Ia94KtZ8EpUmC2PYaxfaMpit3mqGanOGm
	9/J5teenFNkoBUyv30xGckfz+L6FBQGL59fmU4Mq+rcpu7ozLxczILgrHoGv7ByCKRI=
X-Gm-Gg: AYBFou0oUbUD4XYklGe5uSrn+7jk8s4iteZoXztGgrm/KL+B2iOPBlH2HvzSu/NoVkQ
	cu3rbJD6LZcOAC31q6B5E18C46IxSYQtgTH5RCh4aZgN0fldNjs8Z5o1G61HuD9qaJSA9dQ+O0h
	HiZahLvdfWPYHUV8uRD/U8kODhvTLycy86vgRyRn5ra6Kc0/GxL9t5dgiz7m9MMHu+4Z2ZkcQ9C
	Sa/kGnb4Hj0+Zw3+6R3qa/Q50QzFx9iE+OQ0j0hDINnZgkhs3lqdQ04sdUVejzniRnSTi9+JsOK
	/T77Nk7AYIshedu6FqJnHk11ctivCrShia1zjPrr7Go+UdoFdDvbTb+6hYXrm9qog34VGc/f3f1
	JCoKA2yIAkugnvifIRLOp5SBkoj0QFVmXcL48kvBfl3eibwAqwaQAABp0PNFcuMAOe2WH+19ks3
	YsJxsOJbolBlc3nrnSboRbhX/T9kUYhZV335j4wMcnhSUXU3dWL3s0fsxVqmQyRRcucdZqTSxRd
	HcLGSVsfTj7erf7fLsK9thfyp68oUHNLJnCDOg6jpKgStDO0EvjsQwjgseywqTuv7gbRl8Ji2+q
	E3+BlN4HPHci2VDBxSx6gNC4JhzCmrusd74EWLZK
X-Received: by 2002:a05:701b:208a:b0:13b:3132:6e99 with SMTP id a92af1059eb24-19934a96a8bmr9053500c88.20.1793011861911;
        Mon, 26 Oct 2026 03:51:01 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:51:01 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] f2fs: refresh superblock CRC after MAIN_AREA alignment fix
Date: Mon, 26 Oct 2026 03:50:41 -0700
Message-Id: <20261026105042.1148554-4-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026105042.1148554-1-teel4res@gmail.com>
References: <20261026105042.1148554-1-teel4res@gmail.com>
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

sanity_check_area_boundary() fixes the on-disk segment_count through
__f2fs_commit_super(..., false), which does not refresh the superblock
checksum.  segment_count is covered by the checksum, so the next mount
fails with -EFSCORRUPTED after the alignment fix.

Recompute the CRC over the modified superblock before writing it.  Use the
raw superblock's feature bit: sanity_check_area_boundary() runs from
read_raw_super_block(), before sbi->raw_super is assigned.

Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b90831e..7dcf15e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4023,6 +4023,13 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
 
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			u32 crc;
+
+			crc = f2fs_crc32(raw_super, offsetof(struct f2fs_super_block, crc));
+			raw_super->crc = cpu_to_le32(crc);
+		}
+
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
-- 
2.34.1

