Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858545;
	b=kZsOGFnTRk49/vw8Ge4fnjx2EhrE5QUA0V/ji9arHYp+p0fdC5iDKJs/y+CKjsgLVZgt
	 5rVT8fFjZt1h0fUgtNxvFeRkiIcihXC1bLzdAWUQByqlfGpohYjWrJH3PkiQeIP8t5tqn
	 Dq4RYd5Rr2G+2uwk1Mf6z/eyqF6GneaoqZiAnUAUPfUzyE3tAJyGPjOTZSTRmSE2GgZDX
	 9AK3uV5n2fCBTztW5MvgHQm38cjzmLIWz/CZccIoMqZs0IhMv76+HCt5uaSlCLVG0yEdg
	 3y7RiJzYiyZBTCIt/MKeGfxS2Lp9ERLduDQQCC/jluaySp5QGAiwnycDK2Gir3s77FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sWPRyWlGaMNiQpJpvF0wXPtyt8f20HZGodlR95AlKmA=;
	b=M5RjCw8cfW43TDmESIw3LKC4tcwknyQw0cgypODx5Eb7/Q6ASEGSlerNMlDvhpYPyjYd
	 o9NlKFZSIo3tKnxDM57WndeWaiC/gOoZtdwLnn97flc7uqxMMXnSqsfWLMGQxJ/6cHjuj
	 mkHDcMejL9WABWdF24Vv9StwrwozEMwkJVU6Tj9FqlQJ9aMtaxgV2rzbH5xeYTo5rlzZC
	 ANC6SKuLQpm7c1IQyQICz1wHEK57e3TMPJus5P1QpDWzXA/lnNs+lTdqRLPcLBkkFz9Jg
	 wi7vftBYbOpwJQ8l+r1Dipz/Hm3GxOIBEPLH+p71leQrHkWG4rTNL+1X6l0NeeZWtkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0BLdy5H;
	arc=none smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24F606A322
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC24F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0BLdy5H
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a9787a156eso14578991fa.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858543; x=1793463343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sWPRyWlGaMNiQpJpvF0wXPtyt8f20HZGodlR95AlKmA=;
        b=D0BLdy5HYV45c9qpPXBdOUZmb20eOXzBkqmnKBAfshAYG5diu6bzXGW2wOGtOHPasg
         K391NmMWxtLMR0Nj5375zWZlkUi/iau/lbUdl9OVQAK4UrQXLD1J9EOg0S1VnrYddamM
         S1ScwKaYBUgkGTQg4gwWzb26CrZfju/eA9+250EOFqWv69auZrCFU3GlXw+NVQIl7mCf
         aQIHWVKT3hrQvRKbPEi9FSdfLk8NnhVWaOsI/NhLvLd2Kg97GV3pKosR7BlBZLNxUNEd
         0Y2u19i1yNxC7zzBsW6u0DJzSRx4whP/2vRBLP4riAyZZjVowNf1y1bAI/BGon3HU6Xp
         pVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858543; x=1793463343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sWPRyWlGaMNiQpJpvF0wXPtyt8f20HZGodlR95AlKmA=;
        b=ufWOjo1lc2p79t/xT2S2QuVB+8TG50zSX0zsyMU0VrAvzfJqIHCaeLy5oXTs7jUBmV
         eCA16w+Di8bKvIwwuAweHaxV68eTw47W1E9NnC93KOuTpsEeJwm3im9Ehq7IX1A/4nmK
         oQzgw+sLUuwgfBV0mpgo8SGcanDK4v1tv7oJMVDDKBuRw0D6YK1crzF5pxRL5GwaacNv
         lYNoXe8RPKCIFihSjqY1onTSYGs6ozMAWU3ZFocw0oybVQxAj9e8jxUEG1+oKm6GJAbM
         4mX2wWCOOqKI1eJQrz+fcxfKdBxOwZQeAfJjqSPsF3qbO+DU8lK6ofLZMunL0NAnGzfb
         iYZw==
X-Forwarded-Encrypted: i=1; AKwUvBw3fNn+enAlXs9NJ+Aq4lNsY35+inKGJr2/8qSKZzEaPRNF3VcwV12GqQGjGKE5tJ/EbOCM+oY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5IaKXc2ISzEZw6nkxwJ2A164/fe21zGSyCwYkrCV705fOSl/v
	BJD4GcPI+Knux0s378sx0/zI8SnWSn0Dx7Ltf2hTM7HJY/mjGB6zXwxO
X-Gm-Gg: AYBFou2O6yvYKK3fscGImMM4M07+RAEPhmJxJ3nn2MoURq8bQNivDMk3sQXlG0m6eD3
	+b4ZudTWloUmkYtIyKu3HEtPGSjv9+316+kmL1UvQSCfl5tib3YiBF8G8lN+z/wSJ4Rl3O05s/R
	lkKg9VCf5NliE5lqVjSglqTTV/Jpgvye2XglIj+xFPGCXw84VAL8BilPCimj0jWfHpTFFPrkvMZ
	qmKYLazRXk6pTOUme1S7HB4W1JDrd162QpwzddTb1wfX2Rt0WNKfQeTaztbLQps5DOJjq/baybf
	h3bv7/XUYB52jgbxruepBAe5uKSLn2bkbxGDiq2XjBFr2KCJekcX+Z/t2IwuWzmaNFlnyks9jX2
	VKpJ2o5tIP25f0+bu2FI5WoghNEZ35uLT+1YFXle8I0Nq3oHaHeke3QMl5FoKR6bn9fZNXts8qI
	M0Knha3Kh/W1gCZBKhNYOh9426Y+uScYxpU4+0Kfc546dfgO5u8g0KbitozqdCLt2w+CsnWEMYX
	9yxA40LyrmfjKDO550wUB6vrOqrVvRoq60UK+IUl3VyjAs3gwREXIQV1CMWqQDkPrVla7ett94U
	AVZrZo4Ak4cALdWAm+8iVV45xXSDugq5dyxWnVFXeXLcjqXiWt/2yb62ChsY
X-Received: by 2002:a05:651c:211c:b0:3a6:553d:cb1c with SMTP id 38308e7fff4ca-3ac6fceb510mr5573981fa.12.1792858542702;
        Sat, 24 Oct 2026 09:15:42 -0700 (PDT)
Received: from x870steellegend.lan (95-25-165-240.broadband.corbina.ru. [95.25.165.240])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a493b6sm5645121fa.37.2026.10.24.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:15:42 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Mike Snitzer <snitzer@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+8e6fc64255334ccf3ab3@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH] dm snap: fix use-after-free when origin and COW devices match
Date: Sat, 24 Oct 2026 19:14:59 +0300
Message-ID: <20261024161459.5539-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When snapshot_ctr() parses target arguments where both origin and COW
paths resolve to the same underlying block device, a slab-use-after-free
occurs.

The origin device is acquired first with origin_mode (e.g. BLK_OPEN_READ
or BLK_OPEN_WRITE). When opening the COW device with dm_table_get_mode()
(typically BLK_OPEN_READ | BLK_OPEN_WRITE), dm_get_device() sees that
the device is already in the table list and calls upgrade_mode() because
the requested mode is broader than the existing one.

upgrade_mode() opens a new table_device, points dd->dm_dev to it, and
calls dm_put_table_device() on the previous one. Since the refcount drops
to zero, the old table_device is freed. However, s->origin still holds a
pointer to that freed table_device. The subsequent check:

    if (s->cow->bdev && s->cow->bdev == s->origin->bdev)

dereferences s->origin->bdev, tripping a KASAN slab-use-after-free read.
Furthermore, under the bad_store error path, dm_put_device(ti, s->origin)
fails to find s->origin in ti->table->devices because dd->dm_dev was
replaced, leaking the device reference count.

Fix this by resolving cow_path to a dev_t via dm_devt_from_path() and
verifying that it does not match s->origin->bdev->bd_dev before calling
dm_get_device() for the COW device.

Fixes: 26110d5afe81 ("dm-snap: simplify the origin_dev == cow_dev check in snapshot_ctr")
Reported-by: syzbot+8e6fc64255334ccf3ab3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8e6fc64255334ccf3ab3
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 drivers/md/dm-snap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 7c3725e4ac54..4a7c04c780d1 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1232,6 +1232,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	int i;
 	int r = -EINVAL;
 	char *origin_path, *cow_path;
+	dev_t cow_dev;
 	unsigned int args_used, num_flush_bios = 1;
 	blk_mode_t origin_mode = BLK_OPEN_READ;
 
@@ -1274,15 +1275,21 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	argv++;
 	argc--;
 
-	r = dm_get_device(ti, cow_path, dm_table_get_mode(ti->table), &s->cow);
+	r = dm_devt_from_path(cow_path, &cow_dev);
 	if (r) {
 		ti->error = "Cannot get COW device";
 		goto bad_cow;
 	}
-	if (s->cow->bdev && s->cow->bdev == s->origin->bdev) {
+	if (cow_dev == s->origin->bdev->bd_dev) {
 		ti->error = "COW device cannot be the same as origin device";
 		r = -EINVAL;
-		goto bad_store;
+		goto bad_cow;
+	}
+
+	r = dm_get_device(ti, cow_path, dm_table_get_mode(ti->table), &s->cow);
+	if (r) {
+		ti->error = "Cannot get COW device";
+		goto bad_cow;
 	}
 
 	r = dm_exception_store_create(ti, argc, argv, s, &args_used, &s->store);
-- 
2.47.3

