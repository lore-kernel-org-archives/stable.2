Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028353644BE
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785648757; cv=none; b=jJSfu7AEyc2NArO+vvmmnnSIu+S4Ks9rC1dvabkjeXMyPtZQ6IUIH5FO/ocXX5sC5T/nJ5UQDBy+jmc2ysLvxyN3yvWEGuJH1nUZGZtAVILx9BIEQT8ALY+sjxOHyi8kKyHSpOROwX6aJrcA0fNMfVjYQnykKGYsAwHzOaZh7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785648757; c=relaxed/simple;
	bh=fgg7Qjji2zMcVkekodrj0/ZvH5H7zQTSNCkznTKy3yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/YaFKbXfoxe0R95Z5TNkoVAM2Q98QMDwVIba1bUAodNk/lkftTnGO3OztJv+c4TMPztuj03WaEUuh0N2m34UktjGBHXfWQEEOkLP20wweRXwLWUCyDANW9kFhgS+uRgslXuLmRAnvT0NpaaShLqFf+3UhXqv+ETCMJMwgI+Wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZA7k8t4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZA7k8t4"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe3fed2f58so909507a12.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 22:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785648755; x=1786253555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPT3S91E0Ihd5PRK7Van7rtPeXxJZdF/W+QgUiRGOn4=;
        b=rZA7k8t4YRldR9ImgwY0wiRRK+1c3yZUBiUiXn06KShdNOReFzZpbPEvv2jodBvaeh
         zpsJOfCTZIG6U3en+sOhl/Www4PzI5ogalqhGjIoLSoU+NWHwRcqC1r3vQEZxKCcetSN
         WvBC5b6IsqJ1eR+fsxFDsQZrhptkK7XSpcW4AWnpWGMUHiDL0wpsVkz3rbFOs/oimZi8
         UbnaWYuK71VuW5DHyrvBNcyAYYfHvALICkknc3HLbilrF4A5ojnINUexdMaLvKf9VoeE
         y1R3c6MWWfYl3wQwfuTpaUh70XkHxGt6vN9m53xKTEYwa66Nd2ZpxP51HPr1aQi77NCD
         fh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785648755; x=1786253555;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPT3S91E0Ihd5PRK7Van7rtPeXxJZdF/W+QgUiRGOn4=;
        b=TKfvSEAJREpXx3o1lM9qc5KG/dnazOEO049m4vwv2WMx8w2DCsipm9wd80QHxQXF5E
         oBmgV9foo4gFQW0UZ3x7QQwHQk+p9it2tc6GW7yZw03m/GkdmzWqfE5IP4+X45VrZ0vi
         BpZ7gbZtH6tMNESWCyM89UrYkWrJpG9Zow34uJ1b150JpSyfADmVKEMTA7GkB2+cFgVq
         ldstN/sWrjEmS1JUIbIry37RxHCBHiKFmHl/uU7a42h27iJoBS7Gsqty4b54LoNRKEp2
         ENvQ+SkmaW20NuVMk3BKWxZp+SQyrE64gbhujX5buGEwCjhjqnkFmmijOZHFm+T6XkOy
         f8ew==
X-Forwarded-Encrypted: i=1; AHgh+RoNPdeYnK0Od7HbxV/qRN+v3g4ZJnZKeLAEWL1A8Si2wiB3puLQsz0dSDPBZIs0MYau62S5owM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSgdongkyoFH0bRtn2/xCfiTf3fr9SFDoXwV1sy+aNbvxHItC
	2gfeQFlJmZWeGS5rEuDgzq4cEKLi9D12QkPN/JmTDZ7P5W1SZFZKgYSw
X-Gm-Gg: AR+sD10CPWzvCZwcIptN4a9/qj8iRYB4y0d2Qh4Dn7PYudj27i63kwuWbvKmdfLy+Fu
	mhp6HMpHspF0+MTjTpvbnedktXN11aD8rDPmJiV0JCPjFwAULREKDjbUndHmQhpVuf5BEEXLhp3
	bGYr/xQjkFcrqQ0X0SN3gmD5dHOlVAXX5G9Dq7b6Kv2uavIJtujsDuRB8QEhmj6nUpWKAJp56Dm
	CKZ7fXnYNhe8tRTQZm4HzvsVl40l9LJkDZx21vArImS2D/ehgNV0f541nhR4zmKyySs3BIdqXlR
	rhDT3Enkml4hkio6JEVX02zJTvOcQ59LVNaDS9/WuvgfXJZEdhXNJoGPAq3ELKrBCS9E+Yp7Tws
	XjTV1rkUKD8vX3pXm7joJf3EVnvte5lvlKZC6lXzvn0ytbUFJD0OZYAZ9I4FXlO72rHTAGo8Leg
	kk7DfLd80TXviFGz0aDhsl8BKX3mUQv6x8F4l09dqTzHg+l5/G8tOfRLRMmGJrVuQHsKMHjlmQ4
	+sXlxZb+OJZdR38oukG5qWaPflq3fFUwryEBovonwvDmFy/Xuw9wznlmAdYkkulmNw+d/o3es+A
	o6b/TppFupA+1k1ar1NTkNF6JOXYV1oVZT7ngrXFFDzx5+XhLUevjW+7qyKah446
X-Received: by 2002:a05:6a20:d487:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3c92a8371fcmr5921538637.41.1785648755210;
        Sat, 01 Aug 2026 22:32:35 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm17563209c88.15.2026.08.01.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 22:32:34 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: syzbot+e68dbebd9617a9250e8d@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	Matthias Goergens <matthias.goergens@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_rmdir (7)
Date: Sun,  2 Aug 2026 13:32:14 +0800
Message-ID: <20260802053214.3266477-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

From: Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] ext4: stop retrying saturated xattr cache entries


ext4_xattr_block_set() retries when a cache entry selected for reuse
has a saturated reference count after taking the buffer lock. The retry
returns to the mbcache lookup without making that entry ineligible, so
it can select the same unusable entry indefinitely. A task spinning
there can hold the parent directory's i_rwsem and leave concurrent
rmdir callers blocked.

Normally a reusable entry has a reference count below
EXT4_XATTR_REFCOUNT_MAX because the count and MBE_REUSABLE_B are
updated under the same buffer lock. A corrupted filesystem can violate
that invariant. The syzbot reproducer reports allocator and xattr
corruption before triggering this retry loop.

Check the untrusted on-disk count before incrementing it, avoiding
overflow, and clear MBE_REUSABLE_B when it is already saturated. The
next lookup then skips the entry that was just proven unusable. This
mirrors the normal transition at EXT4_XATTR_REFCOUNT_MAX; the release
path marks the entry reusable again if the count later falls below the
limit.

Using the same QEMU harness and guest parameters, current unpatched
Linux hung in 6 of 8 420-second trials with the do_rmdir signature;
representative NMI backtraces caught the owner spinning in
ext4_xattr_block_set(). The patched kernel completed 20 of 20 trials
without a hung-task report. The final four trials exercised the
reviewed overflow-safe form of the change.

Reported-by: syzbot+e68dbebd9617a9250e8d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e68dbebd9617a9250e8d
Fixes: 65f8b80053a1 ("ext4: fix race when reusing xattr blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/ext4/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 982a1f831e228..6f4215d4806de 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2075,12 +2075,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				 * stable so we can check the additional
 				 * reference fits.
 				 */
-				ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
-				if (ref > EXT4_XATTR_REFCOUNT_MAX) {
+				ref = le32_to_cpu(BHDR(new_bh)->h_refcount);
+				if (ref >= EXT4_XATTR_REFCOUNT_MAX) {
 					/*
 					 * Undo everything and check mbcache
 					 * again.
 					 */
+					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
 					unlock_buffer(new_bh);
 					dquot_free_block(inode,
 							 EXT4_C2B(EXT4_SB(sb),
@@ -2091,6 +2092,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 					new_bh = NULL;
 					goto inserted;
 				}
+				ref++;
 				BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
 				if (ref == EXT4_XATTR_REFCOUNT_MAX)
 					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
