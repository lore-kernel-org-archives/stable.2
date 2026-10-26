Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012671;
	b=G2EJUqdqjd0qbcthIR4F0qu5TOXRFy596BqnFK4gUs7/ZcSJ0383AQ7RkBbvAcmqsYIq
	 m9w3zWQ3mZ3phjPVV0q4Z8DtD9J8vAuoQCkGrY5iZcrq4nVtm7j4n8G5Sgzv0iXCVkmYA
	 2d/ov+Lc/LnVegLE5qfm7/59YnKmThx+Q1p8r4isVs1tHNsqbNp1CspyMBX7CCUHhYKfw
	 NpBWSR6/2RROzRFHPrdvWB70UUHZ5pnqxb/CWw5fsC7SMpz8cF5T9S7aq36kra40OJ51k
	 hIGjWLIQQlniK2lvff1oRKElot/8jKUwHiO8SuUA7Z0QGRAeIoA1POyD7Inv3U1ljJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eQulDPAhSJ3VfZ/4ogb1s3vm11tJrOqeW6KyN89YN3g=;
	b=IHnYNZYObbaT5ya5KjLnjcrb/dtSJmTB4Zf1U6voFkjYOjFuABCzthVzc7C8hsjkoQr5
	 bc7BfEeO+L8ngCxZWiVI5FevNw6Azwg54rfmvyELFlNsLFdY/hRR364rj0GzYrOcBn5j6
	 MzK6KiBiIpHU0yVQgouN/AW+aqw0eWtuihTn6qJ/wYztMgOnMFwxfFcrn5mGZu+RLDdDe
	 FqpzXf30X4jCUFWG04746CXGu1ULuDe1fSQuiAZNMkQzkiedRMeCuGkOvQq39dJrX7H0f
	 cb/9T4FiSzomU0is3lYVT/1/wr+qZ1PAH7c27X4CpaFpTHIZdFddwbRVnjDhXPXh12w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="JM/S9Bt4";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CA606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JM/S9Bt4
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-354ba08cfd1so5211485eec.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012671; x=1793617471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQulDPAhSJ3VfZ/4ogb1s3vm11tJrOqeW6KyN89YN3g=;
        b=JM/S9Bt4a9R3TNL+TCkPQhq+KJbHd3iPuq8zU2cF5ZvY4wVYELmaRo6Szo3aSdXFPO
         /X5FKEtq8ot1dKlgCjK/HVGpL128Lz0f1PJpMdfvRJb6sQRWNmGQXZ2Kcwne2WEIq1oI
         KwRWjUtN6hhiG609IqelTfjl+GaE7ZqYOrsbyn/d+EbKW7CO+omFUTHeSHE5DZMX1gXN
         7JYfJjJ2obuh9em6lw1E74gmS5HsUzQxdjrVUSXltW47/pavP/O+8Yf5JY2Cb86SXPuv
         w19qNos6YeriyGUNoB7xuN9gxsC8qMj+1DS9FUqPZpaA4dHTK+HngU+IX5mjbJNGrKeO
         YBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012671; x=1793617471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQulDPAhSJ3VfZ/4ogb1s3vm11tJrOqeW6KyN89YN3g=;
        b=I24hNq4tyVQw5qgI7LHd31SHdmXCwWKpbe7me9lbckd7HNYE0YsLNx4BFh20vQl7Tj
         PBsBSyPM7JPc/BsOUvRKnYyyV2MOuhFEYYPLR6zNUSaOONMrQ+YNRUlsru/JBKJJoTiK
         qAbt7K+WyXMDM7hmp16LyTtFrKnzSAHUD1nfMbZxbCNvoay+iNojouXG5oYlOpWjpd53
         ovqbAyYLcoN8UyJ+RRqVsezaykqrlO4a+vgEGtCzz7C41vtqhnF96Pd93orNzrK34yV+
         FnfoDGiuEvS++qdy11B/heTdiAWA8IGBHvR83hnz0GaPlkYhg1IeDvTBvhGmv/TWQiEv
         lWWg==
X-Forwarded-Encrypted: i=1; AKwUvByXWLC+lbNqvWSwMLShrP5qIXoF9sTwAjMWFDl24b1u1yxf/P/HZmhDD2nFpYdo1btXzAiWNTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdl4zRk8EpTsbym7GqKyRdHdMCbwh34QambNQNgDawFdyODqlx
	aLg18KGP5p0vcB1cErRGVbz1MrA0feA2DHQ5Rjdh/BES//CIDTtAuZ5m
X-Gm-Gg: AYBFou1rt/ir/iGUoY9h9l3xUBfBbCkESi7Zy8mYMmlAgX/+r6ax9LyJNYv5DbPjrat
	80/Yks7tNQ3EPnTJCnficHtHsaXBeBxOFQR8y3BJhMllEzwD/0ZniRX1R0qCjKedYHQT/ZmaoVj
	YcV1xLqJCbRLXKagwB0ZXw4/SxNSbY8Zst02H4ITQ+OH7h7TVjm3np425n+hvmLjmWmLA4+ES2D
	FL4Mml4wCYXpk+AZ70u/BdhJPJCDc0HAkUzUN2Q/cT4QaLvrczaYQeBr4pMpFvKU5jM9nuTj8Bx
	GK3JY+M/UbhbD2YxjkFLFvulU1+0gdqZ4uulSMKhxA/kJMuV2dsaH4H+sBy2fmlCM+7CZ6bw42B
	K/6bBOle2Ec1Iov7tbFEguU0SyqA7Pj1Jxacg31ms248O9152hTcz5b3bUpUfvhktkEmaNnzm3N
	WAKaVGC815k56G51eFI0I8xhUnFLM7Qn22M81Yls6qgOYIS/wK2uQr6S4JB9wJ1Me3Jc8eT+QiC
	7AAxniQHtIapKk+m7Q5adkcYlGOE7z4UqRCuqfYyzyTNpXYR6KrWjDoLPjlmQZ/wsTiJ6bvZqjX
	XFOqXU5FmO0b
X-Received: by 2002:a05:7300:ec0a:b0:35f:8c5d:5927 with SMTP id 5a478bee46e88-369e849d9e3mr12626709eec.14.1793012670428;
        Mon, 26 Oct 2026 04:04:30 -0700 (PDT)
Received: from Hruday.lan ([2409:4091:903b:c404:624b:425f:9d48:c5a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71easm22985134eec.5.2026.10.26.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:04:30 -0700 (PDT)
From: Rahul Rao <shreeramrahul94@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>
Cc: Joe Thornber <thornber@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+83827f9a59abe148bff4@syzkaller.appspotmail.com,
	Rahul Rao <shreeramrahul94@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm thin: prevent use-after-free when metadata and data devices alias
Date: Mon, 26 Oct 2026 16:34:02 +0530
Message-ID: <20261026110402.103622-1-shreeramrahul94@gmail.com>
X-Mailer: git-send-email 2.43.0
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

pool_ctr() takes separate specification strings for the metadata and data
devices. However, different strings (or format representations such as
/dev/ram0 and 1:0) can resolve to the same underlying block device.

When the read_only feature is requested, the metadata device is opened
read-only before the data device is opened read-write. If the devices
alias, the second dm_get_device() call upgrades the existing device's
mode. upgrade_mode() replaces the dm_dev and drops the old table device,
leaving pool_ctr() with a stale metadata_dev pointer. The subsequent
metadata_dev->bdev access triggers a KASAN use-after-free report.

Acquire the read-write data device first so that acquiring the metadata
device cannot trigger this mode upgrade. Then reject matching block
devices, including those specified through different names, and release
the devices in reverse acquisition order on error.

Reported-by: syzbot+83827f9a59abe148bff4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=83827f9a59abe148bff4
Fixes: 991d9fa02da0 ("dm: add thin provisioning target")
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rao <shreeramrahul94@gmail.com>
---
 drivers/md/dm-thin.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 59392de7a477..52e47874048d 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3326,18 +3326,24 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	metadata_mode = BLK_OPEN_READ |
 		((pf.mode == PM_READ_ONLY) ? 0 : BLK_OPEN_WRITE);
-	r = dm_get_device(ti, argv[0], metadata_mode, &metadata_dev);
+	r = dm_get_device(ti, argv[1], BLK_OPEN_READ | BLK_OPEN_WRITE, &data_dev);
 	if (r) {
-		ti->error = "Error opening metadata block device";
+		ti->error = "Error getting data device";
 		goto out_unlock;
 	}
-	warn_if_metadata_device_too_big(metadata_dev->bdev);
 
-	r = dm_get_device(ti, argv[1], BLK_OPEN_READ | BLK_OPEN_WRITE, &data_dev);
+	r = dm_get_device(ti, argv[0], metadata_mode, &metadata_dev);
 	if (r) {
-		ti->error = "Error getting data device";
-		goto out_metadata;
+		ti->error = "Error opening metadata block device";
+		goto out_data;
+	}
+
+	if (metadata_dev->bdev == data_dev->bdev) {
+		ti->error = "Metadata and data devices must be different";
+		r = -EINVAL;
+		goto out;
 	}
+	warn_if_metadata_device_too_big(metadata_dev->bdev);
 
 	if (kstrtoul(argv[2], 10, &block_size) || !block_size ||
 	    block_size < DATA_DEV_BLOCK_SIZE_MIN_SECTORS ||
@@ -3426,9 +3432,9 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 out_free_pt:
 	kfree(pt);
 out:
-	dm_put_device(ti, data_dev);
-out_metadata:
 	dm_put_device(ti, metadata_dev);
+out_data:
+	dm_put_device(ti, data_dev);
 out_unlock:
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
-- 
2.43.0

