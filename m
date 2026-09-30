Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339E233942
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742112; cv=none; b=TvRY714Jz/F56MeqovSq3IYeaIlmMT5TozU5IxPV7MgSd5DAihsMyJM2ILjL9p2Z9Wj3jE6ZV6Z8Hc0chjSzhinFRTiZYtcB+m8YSUAnHJ6GWSDWS8kw5ayCxyd4gEyxM4slqQmEVFlhCk8qlVUaNNHwJPBBOY1eKmCFCxwXzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742112; c=relaxed/simple;
	bh=KlrsJ+xWx55By5AGQiDhl1NdRFnMonqmoIeuB7vdp5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z07deNiD7xZQY2Q2QMtSecqkDKjN1MtBawQnNbrQpHn/EgtWPpIBCcMLPSrNnAgIqIpIJ/yNYVHuwHKk4+iRdUFMTIq+3ICkhTw55FFUwm/8CXEshFNm8Ok9RTV2hQW3ZLZyTrNXJPpcrNSZCJJUk7JcRpN1QRcp65eF/vL/70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6I1ZE8V; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6I1ZE8V"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso3551484a91.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790742111; x=1791346911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lB7hyHSXLltAudB1hHTz2rUZpBJb7tlLLr+gvCXCEhQ=;
        b=M6I1ZE8VQEL0mOxpa2ldxq5B70o2L1x7Pjf8x2D+eKezNYulT74YXRWCsGqKX3FalI
         Lb2NfYn+L7VzRfazfa0lqwZ6C6FMLjoTvUC68md5tBQROsg3euwFmJx5vABJOQyRLlap
         YaUZp5Mg5WxOViPynjOZtJHcBbw5rZuRMhENz5CniMbqGEtYOWPLjqG3DY1VNi0rI0yx
         qITaw+sjlOiadPA5DZKe4VZS5W2uv/lSFH5zb3+Ekg9nonWmVhszr97zeTMnP+bsInbY
         onmpPFtOBN8Z2YePob1Idlvr337JVW5585XX7t/mdLk18ijM4i2XeV+etplUGUJz5r02
         AOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790742111; x=1791346911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lB7hyHSXLltAudB1hHTz2rUZpBJb7tlLLr+gvCXCEhQ=;
        b=CyO9sNqADGCh8YgCvArdvBR+o+IAK8J0qG0CJ36HEt0a+5QDmjO0Rfkg5Fi4Dr4rr/
         ST8w1asx2Vq7h3UTK4tY917qNcqLaKByeXOIJUMEFDGN82w8WCkuVrDXetGlCyIZV4Fz
         /xKaudtCwmqsUcqZ/lFAKyM+gBXEvRN/15dfoq/6vxmDY+TQUKy7aac2fwACYPWxdDxX
         FqLGe0IDX6VT9vbjArvxK3H3G4i1hoAUvPvXmy7VYMK0MDtwbei2bKKyp/7mVwc9RpHA
         5zrC/buyDnycikRRBR1ISPfPZvITWXxvutm7hr09IbToApVpUslxO8WRfQapToI9i933
         H2WQ==
X-Forwarded-Encrypted: i=1; AKwUvByOaqfTt783dV4G1hPMXHaFi431xJQWzmSqE/uNL2MjWPtxL7n6SKL8x4Ucbl2vSZeFKGyQNWE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR7gr5HNqJYCrhDrpNJ7WOBbYWSkC6xHsaCX7Ul3Ue4NwGuVW9
	cH+NXBxzwh/6ub3rt6zD6udjk5LZtnhP6AdPsrQWlb3UIs57x8nZbs4Y
X-Gm-Gg: AYBFou2U9/2Ej45orX1iMe+EIUT+FjKwbv2AnfR5LmxmdtW7lzTSN+Vdioo402WVk4A
	4usSNxB0vjUzHJQDUJG/YE9gm/ppKVDrFgUUT5KaN4UFIFaaf3hGObIipzC7oFEfApHE63ClN2r
	feNMrSkOI4bVY5kthnrzYNagUlzlT1H+lTXcK6a0DDsXMBTtzCq6Ii26aXxw+a4nuSmsFZNmRvD
	EanTy1fKSN2EkKkW5zfz4ByZNedeDhlXvKgpUBuEw3YLrOFQOqaPWEADmnc3nIqii49pXfRpn/h
	ykY+xMWAt/QRyUksbazVxd5fVOebKlcON/pfafBPyuIufno/d/0CA6o8TPiX62CLPorxSXf5ihX
	91WMSVZ1eha3bYIEL7lCDFJDZDqOFsUBPMfyMmkxquL825Aix3G+lEf961KN69IfAN+mbEC+OI3
	EoL2WavuWiErSNoic8cJffkC5IRCCFYDzwqw+Kt1AFbQ+24hLSJJqNt5n4SEx+OWjRN90BWniSa
	GOMweZBbxmlxjdg5ZsW+f+ZSB5qkIB88XBjRK3Qzt6kgqP2vBHy7SZFxaBaf+3fO/yiHjo5tPpN
	FNrS1AamSg==
X-Received: by 2002:a17:90b:1d4e:b0:3a0:4023:bb09 with SMTP id 98e67ed59e1d1-3a4d193d3bfmr194422a91.56.1790742110485;
        Tue, 29 Sep 2026 21:21:50 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cdf25c6csm857427a91.5.2026.09.29.21.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:21:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] isofs: bound empty directory blocks in isofs_read_level3_size()
Date: Wed, 30 Sep 2026 04:21:48 +0000
Message-ID: <20260930042148.169831-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_read_level3_size() walks the sections of a level-3 (multi-extent)
directory record and, on encountering a zero length byte (de_len == 0),
moves on to the next block without bound. A crafted image with a long run
of empty blocks between two sections of a multi-extent file can force the
walk to read every block to the end of the device.

Count empty blocks (de_len == 0 at offset == 0) towards the existing
100-section limit. Track empty_blocks in a separate variable from section
count 'i' rather than incrementing 'i' directly, because 'if (i == 1)'
records the start of the second section (ei->i_next_section_block/offset);
incrementing 'i' on empty blocks before the second section is read would
cause 'i' to jump past 1, leaving the next-section pointer uninitialized
(0) and reading past the first extent into unrelated disk data.

Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled using a crafted
ISO image containing 150 consecutive empty blocks between two extents:
on the unfixed kernel the loop reads all 150 blocks; whereas with this fix
applied, the loop aborts with "isofs_read_level3_size: More than 100 file
sections/empty blocks ?!?".

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Co-developed-by: Matthias Goergens <matthias.goergens@gmail.com>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Document in code comment why empty_blocks is tracked separately from
  section count 'i' rather than incrementing 'i' directly (preserving
  the 'if (i == 1)' check for the second section pointer), answering Jan
  Kara's reviewer feedback.

Changes in v1:
- Combined section and empty-block bounds check into i + empty_blocks > 100.

 fs/isofs/inode.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 184350d2e6ad..d7b324029a1b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1173,6 +1173,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	struct buffer_head *bh = NULL;
 	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
+	int empty_blocks = 0;
 	int more_entries = 0;
 	struct iso_directory_record *tmpde = NULL;
 	struct iso_inode_info *ei = ISOFS_I(inode);
@@ -1200,6 +1201,17 @@ static int isofs_read_level3_size(struct inode *inode)
 		de_len = *(unsigned char *) de;

 		if (de_len == 0) {
+			/*
+			 * A zero length byte at the start of a block (offset == 0)
+			 * means the whole block is empty. Count that towards the
+			 * same 100 limit as file sections, or a chain of empty
+			 * blocks could be walked without bound.
+			 * Track empty_blocks separately from section count 'i'
+			 * so that 'if (i == 1)' correctly identifies the start of
+			 * the second section even if an empty block precedes it.
+			 */
+			if (offset == 0 && ++empty_blocks + i > 100)
+				goto out_toomany;
 			brelse(bh);
 			bh = NULL;
 			++block;
@@ -1241,7 +1253,7 @@ static int isofs_read_level3_size(struct inode *inode)
 		more_entries = de->flags[-high_sierra] & 0x80;

 		i++;
-		if (i > 100)
+		if (i + empty_blocks > 100)
 			goto out_toomany;
 	} while (more_entries);
 out:
@@ -1258,7 +1270,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	return -EIO;

 out_toomany:
-	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
+	printk(KERN_INFO "%s: More than 100 file sections/empty blocks ?!?, aborting...\n"
 		"isofs_read_level3_size: inode=%llu\n",
 		__func__, inode->i_ino);
 	goto out;
