Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718344;
	b=O6fgq+8nXptqHGg9y8hnMg5HQk1RW1R9Tw6A1I738YjTKMsBvez6dO2uwoEDQngEe3Vv
	 zwcnCvT4tAe6EpJD6vnQ3W5ff8VQafqq/IzcOcl9G2wll1WH67Z+Cvn6PuNb2U9wkPzhG
	 rba4X8rpSflTi79j6Xgr59xlTcL4RrDdZu/P4Z8R38RFghSMUhOZzIdtCyLRzLzZM0CxD
	 uvhGkhFltK0GoCP6V7MV5Y6Ft4GmeFJbkrHsmTozFg7YWu+ALN/V7MHNUkzBbxNlJPzpM
	 0FY4vWFR+5kXEc3pIv8j4kpJqmoWyqDIN0Tavgi2mVHTZ8oxfZ0ge+N/+XlURJXvI5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=67TybRkP8njggFQDhor39f7CtHtsMroxxr3yAFAiuuM=;
	b=bguMj5hCUXZJxCQn9tuGU6exMtA30fTergNtwPmQ4HuoTDOXNpP/lxCWCH4DhDaMKxk8
	 e5+ryX+IJg6JGyjx9PeBUCS4kPO52E3fx7mXnqUsAom8Jo9JRpQSalmOk4IVEySb4YT+a
	 o1GLssu/QS1tuV7rqdTpaHUyUsZ2Umvd1VkKrqdkSt2vPbrRqQzY6rdYbWbRxVI8xIGmm
	 2Zvk3ADY4cGYRjzKdTbyMQixBjL7+MyNVeR1pue5zdodc7TVezPQakefYlpzB+Ctm17dt
	 U4Vivc2iA20K2Ob1ySi2Irb0S35wQs7+/5/BI95PQ14fBoyf0dBF9ksLqJDCshG0/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bMonX4KE;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59004606A791
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59004606A791
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bMonX4KE
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so3050900e0c.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793718343; x=1794323143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67TybRkP8njggFQDhor39f7CtHtsMroxxr3yAFAiuuM=;
        b=bMonX4KEsTOZ4px5x4FS1daHqkRFFxhdMlwl1RsI1M6dJVaG0bGGg1Chz1BG7/AhcJ
         VxfKuWb6/OQQ9VhHPU4eqMyMBtEfakSZl24U1Sa9Zfm3tU0/1pYykvU7TxdFT9fgiQvG
         U+aEEtMxPEhcS0Uodxt1iYwFZOBfP3f+GBT9b5P8ghApqaie9bJHVnGCgoQzn4FSpI82
         X31IQ7cm3vdLOBXArvxnpGvHEApelwa2KRd2ku5AFdbb7k8Vfonr/Vd/kkVzJkzapCuy
         2GYQAPac6/pHaLVjVidNQRhFhCE5CuKlJiyUYWuyzuevCQMDzYkoO5+6MEymAGnpXnSU
         EGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718343; x=1794323143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67TybRkP8njggFQDhor39f7CtHtsMroxxr3yAFAiuuM=;
        b=Z8yDkXxKF5sgvwKW6Tm5UAuYH9PMhqconYmPxg9rs9gGbP6dRPn6u2pENdSJpHrHDX
         HW2BTykIWEAsrpHRWsE0hSca7OQG+h+Qa8PcXeZF8AhSwO7QlCvRjF/3u4trNT1f5NPK
         BRo2I8stjWKEcCRXcuxxwP1O6ljlXwBvGcJgTNKjKCK2QWAOdrb0NrmW3rdAEArGtGka
         VlfVnhcmP+vR8xzRlZF+NY+rRbz73Pu3XLAnh9dAceWmjbTCJJaWRPlLXiJdMkFCIE2V
         lZYcIznRNEsRd7d3umPoVDqDMlIQoiUkalYNIqfZsvA5CshYto9LL/VbXxC/1xe0b/7c
         T5GA==
X-Forwarded-Encrypted: i=1; AKwUvBy99eyRRHmuRKUoswdgQ3lv+836O8w69h+3/61P1li2PPGrcNFJ5Nsd+51kHPzkJryipSXwAc4=@vger.kernel.org
X-Gm-Message-State: APuU4Z82tx6xL8hwgIG3CoQgGIetlQNSz/lfafKH+zI9JaOedPchW/Ow
	Qz3rkeAY1/q4TamlfGmo+77ZoEB7upaXjhjAC84mGxiBF/8n73C2BnXjqoPnL+qkd7s=
X-Gm-Gg: AYBFou0elgCRdGWa2JcrF3El2NtRmdQ0axk18EtjXIXrynpWYPUGgDwws6/FCjEdYeH
	wXeLp1jZDoLjhGX7UcMqyllY3Byk6Z+EfOdxrOv1HlVRJGUPPyOLJyA0JNKZ1ffJW/RgMwdlY2T
	18K1ClH/+RrtU7uxUR2mg6iFLwuuKZHyEY/iPLp70kCMYCdtfiJWZwarRCPoQ8bQJVLQ7njB0xw
	T84NxEqqf2NdzbLrR7fLShZZgFq7rZ4Kpsclwgg4HkFTwGY/OGoY2LB3ANJTUlvkv5zVDx/St6L
	l7IfUxgsxTOLHBLsYPADgAWdZKDx4e9urWEAJG8rl7cq2O4z0PsPwINgasAXxQnKJb39MZNpneC
	BR/kTVmZ9f9KUxwRSuaHEPY3YmU9v2g22/inoPFGgVgDGHM0g0hR469JHu9AiMfyaYhM25XVEOj
	kR8SxgSQyuLva3tNArFlsovAn3zMz3hZ4v2vBBGSBrxKHKugfKJ2e5aQFwTDwpQc11SOVp9S4Xb
	6seTQdOkiIMfywsXwgqBrmKr23Gh3KiXrQX6N8BHc/bCIYqlg55S0JJ/IglIz05BpPmDT2K8jUl
	ms4SWPZO1OhZ9UJC3ytutvElRI8DqFriw2HG+vGjVUkA
X-Received: by 2002:a05:6122:420e:b0:5ea:c874:6c4 with SMTP id 71dfb90a1353d-5ec689a714dmr5635533e0c.16.1793718343201;
        Tue, 03 Nov 2026 07:05:43 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bbf5easm12733681e0c.3.2026.11.03.07.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:05:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 15:05:17 +0000
Subject: [PATCH v2 2/5] btrfs: clear dirty blocks after a delalloc failure
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-b4-btrfs-data-integrity-v2-2-577dc2690061@toxicpanda.com>
References: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
In-Reply-To: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793718330; l=1851;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=jNWS89+wbKg8G8W46m/SRpIJP0/cRE8yhKoG8CaTcKU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAA1w+5lm7c9UOO/a8yqwjLT/d0i6ZFcBjFmBUzjfBpenpmo+Wg+hATTZzY7y8DYkemX56lgUD1
 0fpwmDfJoBgU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

If writepage_delalloc() runs the first delalloc ranges of a folio and
then btrfs_run_delalloc_range() fails, the blocks that already got an
ordered extent are finished with an error through
btrfs_mark_ordered_io_finished(), but their dirty bits are left set. The
next writeback then submits blocks whose ordered extent is gone, or is
about to be completed a second time.

Fix by clearing the dirty bits and cycling the writeback state for those
blocks, as submit_write_sector() does for a block it fails to submit.

Fixes: 72dad8e377af ("btrfs: fix double accounting race when btrfs_run_delalloc_range() failed")
CC: stable@vger.kernel.org # 6.14+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ff630630490..3283835ccb5e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1746,6 +1746,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
 			u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
+			/*
+			 * The blocks are not going to be submitted, so they
+			 * must not stay dirty. Otherwise they are written back
+			 * later without an ordered extent, or worse, with this
+			 * one if it is still around, and invalidating the folio
+			 * would account for them again.
+			 */
+			btrfs_folio_clear_dirty(fs_info, folio, start, len);
+			btrfs_folio_set_writeback(fs_info, folio, start, len);
+			btrfs_folio_clear_writeback(fs_info, folio, start, len);
 			btrfs_mark_ordered_io_finished(inode, start, len, false);
 		}
 		return ret;

-- 
2.55.0

