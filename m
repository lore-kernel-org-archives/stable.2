Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857749;
	b=yeC+sUxS9uy+vgOsGfEw19W304JRfVnvOlSXO+MkABVbCVVdeKecciB6OrGSq4upOavU
	 F8qQ7GoqASFADMppIY9MsQk+nj0TPZxLdfWPdYMjbdLFbwu1HGCYC7VElTV76oFdkfR6D
	 9XCzE4B0zSvokRiUDYdYUQl+teDGYT4ij0CTWUX0x1E93rZGtwf9X0vvukuohQUkinXyY
	 Ok/gpd570KyDICyx0ZgKCYbRBo9kEEzf0HVPxaauAv0PCt36WzI6pQLC2kFMaR7ZPMG+P
	 D9lNv6J+ubYaa1CswrSuKRA4n1zMQxB9GdjKOcZ8rthPqh853Sjk46Hoi7nC+6xjaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=;
	b=REZ4Y1D2xsYw8gu5cR/SuZSf24jRfmLFCLBvjDKgJ8YUCzLn29BFeZ37WoxD/50kGT2i
	 XjoqpX7LTQA4/GeDTVYj+xmYQqBSvm58o/oL2RwNibwWBUGhW2RhLMswvzO8WAyF1V1CY
	 A9l3mYpIxokLZCIXZ8kjEKs9L3yrJ5jPHCP2vtXThvLWaygn0XPXiWZgOqWbGBsnlG27i
	 1O/G3yT48n2/Y8aPsjvKrAnq2sWRzLk6PvaWm551ABglMrqPmw5XLMPoaE4z6nU+uCF8T
	 jrlACqJ/XSeLVxKmhPtg1wqLPHHRmpwH6tk/Ro5ArNAA+HKtgjN/S6ITVLUVt46jUvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nyze8rjx;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC59606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 19:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC59606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nyze8rjx
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1537560b3a.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794857748; x=1795462548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=;
        b=Nyze8rjxw0aTSqWgIv3F7gQCT622+k3dltreBUkbH5hyCt6WAm46b36jeOK9Z+ZdBF
         db6XwgoPw/B3PUMSASi/1r82R/A8rVcAtENM/aJIWs764Q0HwokZwGXj8d0+MTDKAIv6
         +53g5s9VpxJZ5IKtewvArhvd//Cx8Vn3bOWmk1h/n9+t8GCkto3jDD8IST2WQ43wfgiM
         g+82mJO94TS1YPFeZIN2SQpu+CW51OG5jnvyxjBJlO7FcGYHw24B6LV8zMAbnMfT+XuU
         vc+D4hkcMit5c1ZrKysSN+ALlohY6+m1vjNFS76n+Xx/9G/pZLqUkqM6DJ7si2pMx1xc
         ROgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794857748; x=1795462548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=;
        b=Ua/et0L9MvhpUqLZ0sKcQl9gr3eNL+57TloYc/BqZHAGDjrK80crYDRS7b+E8Pao4q
         irOFkX0+bWLGqPAaZrTaLiciMO6WK9R30kJT0Va699d+lLdMKaXxcatvVR+g+zcIIwwc
         YNWww1k8oYwvbbyUPJ20Jpp8GJ6R/3fwPAHTQCQClXDo8Ht4vSiD5ECT5NIU3YJOYWmd
         mjwGLjyFofNEIR3W7o4kHbxV/ZiQKexZIxn5uD8tpfqr/UI6TQBLuwiTajD5Um3LaUND
         SdpDV/81CbCTocLrW9CUQCRTXExYa4UV3Kbup64uSx/cMMQPCC9prnD94fuUuy8eJYOK
         cQ7w==
X-Forwarded-Encrypted: i=1; AL+hErH/ih5k5gmwx+S3A34xjEhEd6AX5XC8Bl8LjzrVSkTEmcfa54bjIkj53NYHzmRcXxFG0Qr1Gho=@vger.kernel.org
X-Gm-Message-State: APuU4Z98zerjjkb8nbJQvSgDgRG9YjEsM6UTv14TNrD5hZX/tIIaJFqv
	Ol1W7NGZRdxa1ZWS5lUtW6QnX++z9hdOwiGZ2g+ClpHqDpPfRDeKwm7n
X-Gm-Gg: AYBFou37hnxKoqcxAAp+ISlxIwPvd5cRMi+iizMFS81NHPShSArtwcO3eZdrB/GOOfE
	YLt42/Yo5WQ9Es9l9LsRkVOdSeA+a6BL3E8iu3nn5791ShbrE62gOL4TItz6IlINQuqT+oEPTHz
	9DcNRLpBmEfESbSZrYSeOdXOxpY5j+IvIkR3o4Jzmwd15njByms4+GvEShygRhe77etZbyXpb6I
	am4SCv7fgFGNTj0hMqG0edO5DaiNcrZdVNT5pwv+uPkkuIET09SYIU8HE5SCREr5OOCm0P8AUjD
	SHSk0uCczFzmY0xDlDKsHF6MpT3CCthpQeNhC+jY87eAGB1LTDMDHG6h53teaA4d1R3CSwcIxhO
	r7PrGM7Ko2CnxDuO5HN36hq+wyu0kYEnNsX5oypiuz632Jb+gPMAvwpo1ZoFauKpN/zl7SE6kMM
	asPtnxv3jkDbOMVKK5ryjfLqSShH5p9UZQ4EWOqFfEWiILSqdjCmcJ/0+g8YMqEQW6NB6avq2p0
	Zk8WoRo+Mj1AuCygp4YJViBrjP672ILWa7hXBe6DuNlezC8ZP2M880bWL2KSlpm3Hp9+jgxtK+R
	h7WW72uZAVXDwCN+6gDI3vhrPEAVdImICvMJpcmNUaU9XUiSNNxussb0jpb45o2g4CcHVCXT8X7
	MZ21A5s/gEAkDyV3XWn/XtuwTxu4bUkFMHDSMf8y7B8bQDbo=
X-Received: by 2002:a05:6300:8055:b0:3e2:83d5:191b with SMTP id adf61e73a8af0-3f7a88cfb61mr7749185637.63.1794857747962;
        Mon, 16 Nov 2026 11:35:47 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c09fesm4704933a12.26.2026.11.16.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:35:47 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: don't run out of free sections in the dry run of resize_fs
Date: Mon, 16 Nov 2026 11:35:42 -0800
Message-ID: <20261116193542.111825-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
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

From: Daeho Jeong <daehojeong@google.com>

f2fs_resize_fs() migrates the blocks in the range to be shrunk in a dry
run before freeze_super(). Checkpoint is blocked there to protect
MAIN_SECS, so the space freed in the meantime can't be reused, while GC
and other writers keep using free sections in the remaining area. On a
busy filesystem, free sections can run out and we hit the below.

 kernel BUG at fs/f2fs/segment.c:3020!
 Call trace:
  new_curseg+0x9dc/0xa50
  f2fs_allocate_data_block+0xa2c/0xcb8
  do_write_block+0xd4/0x2b4
  f2fs_outplace_write_data+0x78/0xcc
  f2fs_do_write_data_page+0x564/0x69c
  do_garbage_collect+0x1668/0x21ec
  f2fs_gc_range+0x274/0x41c
  free_segment_range+0x290/0x33c
  f2fs_resize_fs+0x200/0x530

Without CONFIG_F2FS_CHECK_FS, checkpoint is stopped by
STOP_CP_REASON_NO_SEGMENT instead, and writes fail with -EIO.

Stop the dry run before free sections run out. To migrate as much as
possible before freeze_super(), write a checkpoint before the dry run,
and repeat them as long as the valid blocks in the range decrease. The
rest, if any, is migrated after freeze_super() as before, where no one
else allocates blocks.

Shrinking a 4GB filesystem down to 4MB of free space with two writers
running hit the BUG in 3 of 4 runs on a 4KB page kernel, and in none of
4 runs with this patch.

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
This applies on top of "f2fs: reserve space to be shrunk during resize_fs"
(v3), which changes the same function.
https://lore.kernel.org/linux-f2fs-devel/20261114011807.3811774-1-daeho43@gmail.com/

 fs/f2fs/gc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7609c23ec27b..2d2cc3417c36 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2241,6 +2241,14 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
 			goto next;
 
+		/*
+		 * Checkpoint is blocked in the dry run of resize, so the space
+		 * freed in the meantime can't be reused. Stop before free
+		 * sections run out, and let the caller migrate the rest later.
+		 */
+		if (dry_run && !lock && has_not_enough_free_secs(sbi, 0, 0))
+			break;
+
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
@@ -2411,15 +2419,30 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
+/* Count the valid blocks in the last @secs sections. */
+static block_t f2fs_valid_blocks_in_tail(struct f2fs_sb_info *sbi,
+					 unsigned int secs)
+{
+	unsigned int secno;
+	block_t valid = 0;
+
+	for (secno = MAIN_SECS(sbi) - secs; secno < MAIN_SECS(sbi); secno++)
+		valid += get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno),
+					  true);
+	return valid;
+}
+
 int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	struct cp_control sync_cpc = { __get_cp_reason(sbi), 0, 0, 0 };
 	struct f2fs_lock_context lc;
 	struct f2fs_lock_context glc;
 	struct f2fs_lock_context clc;
 	unsigned int secs, old_tail;
+	block_t valid, prev_valid;
 	bool reserved = false;
 	int err = 0;
 	__u32 rem;
@@ -2468,9 +2491,6 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		goto out_drop_write;
 	}
 
-	/* stop CP to protect MAIN_SEC in free_segment_range */
-	f2fs_lock_op(sbi, &lc);
-
 	spin_lock(&sbi->stat_lock);
 	if (shrunk_blocks + valid_user_blocks(sbi) >
 			__get_available_block_count(sbi, false)) {
@@ -2488,10 +2508,31 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	if (err)
 		goto out_unlock;
 
-	err = free_segment_range(sbi, secs, true);
+	/*
+	 * Migrate the blocks in the range to be shrunk before freeze_super().
+	 * Checkpoint is blocked in the dry run, so the dry run stops before
+	 * free sections run out. A checkpoint makes the space freed so far
+	 * reusable: write one first, and repeat as long as the range gets
+	 * emptier. The rest is migrated after freeze_super().
+	 */
+	valid = f2fs_valid_blocks_in_tail(sbi, secs);
+	do {
+		prev_valid = valid;
+
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
+		err = f2fs_write_checkpoint(sbi, &sync_cpc);
+		if (err)
+			break;
+
+		/* stop CP to protect MAIN_SEC in free_segment_range */
+		f2fs_lock_op(sbi, &lc);
+		err = free_segment_range(sbi, secs, true);
+		f2fs_unlock_op(sbi, &lc);
+
+		valid = f2fs_valid_blocks_in_tail(sbi, secs);
+	} while (!err && valid && valid < prev_valid);
 
 out_unlock:
-	f2fs_unlock_op(sbi, &lc);
 	f2fs_up_write_trace(&sbi->gc_lock, &glc);
 out_drop_write:
 	mnt_drop_write_file(filp);
-- 
2.56.0.679.gc527c65306-goog

