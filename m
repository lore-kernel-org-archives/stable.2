Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F14ED1AA
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997546; cv=none; b=jMa34a5jsi/Ij0vE/BEqQu9lSk/Mlk6rHmhUkvLcShdODFRXsNUtF3Q3ZlDGRJM3qePxxZKd3Ngs2NHHCKxxhQrtlJOSqHxJsD+b2zWvJfqykNh2msx+EkZ4PB+VdoN2exqewMv89uie2KAFzRKiTrRn+aqJZPwP1OVU/t3D9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997546; c=relaxed/simple;
	bh=/+VXd1ovnPLZdJQOqnh4F/q6HlFzJgF55EQXVEW4WlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2evf7k/xELFRJINuzGPFORazSFMMFbmurreNUzJoZb+jS/789OEh/3Y+11z8iG4T+akyVKEMj18aTsoXFP8oiXXLUzbmTYrfyVvxtq+ol97scPNM9psJgNXBzIMQJ0VKRakqLVm85DVTBa6A/j/f5mRmoJXWDAvV56799c+3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+k08sun; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+k08sun"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso6281810a12.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997543; x=1792602343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vr2GQIRj+SVQDPhLexxv6L3pH5NTTn/hvbHQlNsKV1A=;
        b=H+k08sunZeZVkazljplEmZkBojSDOoVMKIB7wjd1TGi4qP3jf1RWEnOkLsnmhx/mFp
         WlzwwXilrvS2Cjpyer+/apeA2QA/WPNYFBW+rrAGuXsWgFQFVtQkAbux1cHXf4DwvvMd
         +owkgLcht7uSIlzSuTEkZttUIJApr744/fU4RtcxrO11aHPZBNuPa/cOOaGbZqv7WqZp
         aZQsJuoiAmUkAF39EpDmGaMEulpC9eWLNO1B13ytWQov5+vFy2yocQY+ArdcfWiVw5Sg
         RtXhTyL+kl0G17VZcUP4GdW5wUBLNjEq3aQZoX7uHaBxzRVKiHb3ZFJE1A8yBH2/R4AL
         qvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997543; x=1792602343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr2GQIRj+SVQDPhLexxv6L3pH5NTTn/hvbHQlNsKV1A=;
        b=MJn1qjFWv6TpCSRFP7IcY2dEHvTdvGxZKQEbt3Mfp1lxYCMzH4UDLq9jI2LYDSmb5n
         lKi63O8bzwu2Ket/lDBZ8w5hp3r/NQaR2w58TYydgJdBj32uyY/CcwBaV4d0AIwKzcKO
         GU0rLcuKusO4FUt7XzngFEOGoMFVGI2WU6EqKFz/N+RiuTwDPN4CP5zgulTEhOPGXjm+
         upLmvfiUmQYg7fqiFrHv8dm5nrE0YC1N3ywBy5DVMH0qwR1Vga8UvXaCvP+MSYkIvj1v
         Zfkw+IyTn221fEgXpEOsX6tix9eR7igKYa8WpHi8mZhKZsCbYoUyEedPNIbMPO/Qa3p4
         ZD0g==
X-Forwarded-Encrypted: i=1; AKwUvByM/VJjThNggvzV5Xhsti0zgzWBVxyyGhXYYAqB1wF3fQdb4Plkoi/XiuyISyZzJqT5oZoSPys=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoOATnurYLSZon7TcdDzdfa4KtwpgI5RbTA+s+jEJWTt0tYonO
	T7qUNmkuGbjRvujcER0PVyNR1+s1jsTRdjUOu6/C4xGGsCb3mY/pvCAt
X-Gm-Gg: AYBFou14E1CYBRYe7ZyPH2LovJExtm0LWp52jeOL6Icese+uVcGz5I6ntd/LV2D9jdA
	c348baPT5Njugg6F21vuX8SBs9WnMo0Yv3rGrJAcGuLn+n88J4NlNLVN5TegHOuox77TjZCjS0L
	nme4weWhbGgPQfX5Bmv1tRu/W782hut7jWv/r8bv+4cnT+Fu47ot7xkMLc0YObW7PVjHViHgvRr
	XA96zvhLQ3F+1KLYJY8FENfYiYGoxVVyiaiWM9N8YYjsVIvSytsMDpS70gkwKeqlTm9ddNrDjOS
	6wU1JqyaDZQOQCnar39LV1gO/bawjI6B/GUyKp0jeBez3CJM0iH3HnEt5xbkMokdOtccC0huCxg
	3eCtAnsde3WkkmSjVxvpKRUgRjgbxAiAygRxaNPtf+fSlcx6JQzBNQikt8o67dxIeowGa05C5VI
	SN207JunJ6Rv0pOR6ed+CEvmZs1g1RY0LnQwm1aShBTpKbWMPmvPsSszUKXgaMahTDTSi/hcr5x
	LmgOQ52iHjWd4We4c8zPBXdO0nz/4zMp+UAI1e7TUk6BwyY6kbmDonivFniCKOhgumz5/cnBK8+
	nxRAR/sNGsrCXXuRykTQv9URp+6QPRiwUDE1ye4aAPiue80OCk6Vir6KD9j2dKwHGjQbaGIKkCr
	H/LrQ838blSS6lRYZ31XlAm2HhNB+ENKUvumj/62ZvU0=
X-Received: by 2002:a05:6402:915:b0:6ac:6b18:3475 with SMTP id 4fb4d7f45d1cf-6b17c246377mr15246408a12.21.1791997543177;
        Wed, 14 Oct 2026 10:05:43 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203863511sm1407133a12.20.2026.10.14.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:05:42 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot@lists.linux.dev,
	syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
Subject: [PATCH v2] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
Date: Wed, 14 Oct 2026 19:05:36 +0200
Message-ID: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A KASAN slab-out-of-bounds read can occur in blk_mq_free_rqs() when there
is a mismatch between the number of hardware queues allocated for the IO
scheduler (et->nr_hw_queues) and the number of hardware queues in the block
tag set (set->nr_hw_queues).

This mismatch can happen if blk_mq_update_nr_hw_queues() fails halfway
through (e.g., due to memory pressure during
blk_mq_prealloc_tag_set_tags()). In this error path, the elevator is
restored with a larger number of hardware queues than the block tag set
actually has.

When the elevator is later freed, blk_mq_free_sched_tags() iterates up to
the new et->nr_hw_queues and calls blk_mq_free_rqs(). In blk_mq_free_rqs(),
it attempts to access set->tags[hctx_idx] to get the driver tags. Because
set->nr_hw_queues was not updated due to the earlier failure, set->tags
still has the old (smaller) size, leading to an out-of-bounds read.

BUG: KASAN: slab-out-of-bounds in blk_mq_free_rqs+0xde/0x680
Read of size 8 at addr ffff88818d67fc28 by task syz-executor117/5839
Call Trace:
 blk_mq_free_rqs+0xde/0x680
 blk_mq_free_map_and_rqs+0x40/0xf0
 blk_mq_free_sched_tags
 blk_mq_free_sched_res+0xeb/0x280
 elevator_change_done+0x1d2/0x5c0
 elevator_change+0x34f/0x480
 elv_iosched_store+0x504/0x630
 queue_attr_store+0x207/0x2b0

To fix this, explicitly check if hctx_idx < set->nr_hw_queues before
accessing set->tags[hctx_idx]. If hctx_idx >= set->nr_hw_queues, the
hardware queue doesn't exist in the tag set, meaning there are no driver
tags to clear mappings from. In this case, safely set drv_tags to NULL. The
subsequent call to blk_mq_clear_rq_mapping() already handles a NULL
drv_tags pointer and will safely return.

Fixes: 04225d13aef1 ("block: fix potential deadlock while running nr_hw_queue update")
Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e90526cab23b9efcd03c
Link: https://syzkaller.appspot.com/ai_job?id=827b5760-86a0-4f44-9c69-430b572eac12
Reviewed-by: Nilay Shorff <nilay@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.17+
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes since v1:
- Drop the additional blk_mq_alloc_rqs() claim, as that path is bounded by
  set->nr_hw_queues.
- Add Nilay's Reviewed-by tag.
- Rebase onto current mainline and refresh the recipient list.

v1: https://lore.kernel.org/all/c92b0c7e-17fb-44c8-99d9-59d45004d05a@mail.kernel.org/

 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b92..259a5705efb79 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3484,8 +3484,10 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 	if (blk_mq_is_shared_tags(set->flags))
 		drv_tags = set->shared_tags;
-	else
+	else if (hctx_idx < set->nr_hw_queues)
 		drv_tags = set->tags[hctx_idx];
+	else
+		drv_tags = NULL;
 
 	if (tags->static_rqs && set->ops->exit_request) {
 		int i;

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
-- 
2.53.0

