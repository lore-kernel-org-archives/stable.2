Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8844908BF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839389; cv=none; b=ocZZGvkodomIDUvUX+fgtf+4yohionmowPXV/6a0AmSo1hT+HvREfDn84OgYXbP7nwH0k7POkBygl2axurtZD2rX6MfjXf5qZkLV8hjQmb7MaHFSdzPOse2uQ+QNJtP9M9KZYW17skhH2IXJZPh3Gn3kpIsvy5aATeIXP3iSzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839389; c=relaxed/simple;
	bh=IeQBFCH3bM4bVxRkUROK9805WYYXPr2VLMisCc8LPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYLfhg+ZELbE8DiYyvKgvwDlp2KD4CjprJIjSKlhWWzKl3hgYyilpf9Vm6F/fM2bbYoBx7pJV0bz4HOS2pE0PtS2y3o8/G3Q2Mj7mkPeBqaNGnhuZCzXmZAftVkS/T2zP41FSzBMmtSA50vx1fNxNbkKhhhTm55zpDYo4MaY+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=mF1+onUo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="mF1+onUo"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47db714766aso493563f8f.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839380; x=1785444180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=mF1+onUoH8g5krZlDyx9lcBqRTRrF8paWBw3zaSjWmlVE6WvKJ0hEWSwfUYbccpbQ1
         t9YUnOrozr0YB0sILt9Ctur/Nz1zQ/+OXnwO4Yateq4zcnMQslQTbkXRAru/PCvt6s0v
         oJii8kk5FyPuMEupv9MF29Mgc1Y5C6bhNWmwe7p0TOW3xEArB6PLHLZqPweAU+ntzo1B
         ktrg4VEg0Gh8PWx+hQQgfsVKYPv7TvjDzrQV917gexA2Xy6m7/K6teAHHecYcbfbwQil
         nTYInJ/HyX7DpgOhTOvw6luyy1O0Q+pApnsCG6gVUm6a/fJMfcX/7HCemMP8nZ376T66
         QUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839380; x=1785444180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=fZ3po6ymvlFR90Io8z/Thrg8NTQRVbJtKWiliNoMOgoifrXFlO2ftd/3v+ALIblvUL
         i98VLizgMmPIgrh35P+p2c1i+7iNoXR3HZwinbjc7z8laT+F2JTsxEP7Trp+fcmHFriZ
         Hzc/USYCwRyx/kMAjoFj29AH4IUYPsH2tTFYcAvmQ1DqWgbJEcJEsfr08iE6gwACqngC
         nPbL7idu0ANRaPpENhJKZlCg3/I8PiMp3IIHMOwQIDMKBm63MR7w/gzQr9c1yIeh5zJW
         Xhb8SBdxaEsf1xAepjuhJJEvLoR7dnerCIWhZryMmtdQ5iKtO+drc17heZwO3N+qAqPA
         aIeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFljyIiPu0B1NxUlHZeTXvG69I+5h9nnggjxZmW37dPK5Y2FTjlCyYX9lt6uU4qG4CNGohjjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwibcib+JQlcRIHoLeANiapX2MIFxTJyO1ZE3Mv8HOdOQdTzZ
	d0O8OwOASyjkRbYAV+n3RIigcNpPrN5V4+iRhLtGoX9/9icMg8m+0SFNvJ+UAmMq0w==
X-Gm-Gg: AR+sD13K1v0+FvtiTt3CL7DMAx0thblT4vCzxbIYymJOj27iKLYgz6/WVolzC/f7OQo
	DCapb93F6dY7tG0uF+j1yKqd5LaOKcXMm0osZfQ5j/eqSGuCC2r8q9ODI6aoxAVWQTRHz8dt6Ju
	auwuYoUkxqe+Hz4ADt+4wdtI/xf90K7nveylyeAokoofKgiYRge49/IAPVtaecJZ8eVk7hhdZFo
	xtYFqCeKOsynsRhDQCELNygOVczmoT6S+m8HPzzli/xHo2di/ix2iGGWbMUcGt1pXvKBRS3+g6t
	26JCXTvkJq7wEhDe+C3+ZMlpW/4h5XkEsatqvnklb6284EoqXjYChjWjARoDGTaJKRhkOkZXgo5
	4/K0huV9u7lUArYpIA3ICnvFuscLhJcLJKg6uKKOWn6pTVz/XzsscNW8R3KAylksPhWzmHxzevO
	fU3/aOxxdJtAzZVk9WCSn0k1AZLA4/KnrJ9YTJ6RyhlHZpcN64u36020qDU+J6pwZyAuqFJcuHy
	+qPuU00vjbkJKJrmpAQ1EYE6FCiX7uvjUu8ADJOrA==
X-Received: by 2002:a05:6000:2309:b0:47f:9208:9e4 with SMTP id ffacd0b85a97d-47f92080a4cmr4670984f8f.31.1784839379605;
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 03/10] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Thu, 23 Jul 2026 22:41:59 +0200
Message-ID: <20260723204206.76930-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A write that skips write-behind (full behind queue, a waiting
reader, failed behind-bio allocation) races the in-flight behind
write it overlaps: nothing orders the two on the write-mostly
member, and if the older behind data lands last the member keeps
stale data for sectors already acknowledged as rewritten.

Serialize on CollisionCheck, which marks exactly the rdevs owning a
serial tree: serialize_policy rdevs plus write-mostly members when
write-behind arms serialization -- the case the MD_SERIALIZE_POLICY
test misses.  remove_serial() under the same condition.  This also
avoids the old gate's latent NULL deref for rdevs hot-added under
serialize_policy (they never get a serial tree).

Fixes: 69df9cfc7042 ("raid1: serialize the overlap write")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..997f79c05db7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -564,7 +564,7 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	} else if (test_bit(MD_SERIALIZE_POLICY, &rdev->mddev->flags))
+	} else if (test_bit(CollisionCheck, &rdev->flags))
 		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
@@ -1677,7 +1677,11 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * CollisionCheck marks every rdev with a serial
+			 * tree; order against in-flight write-behind I/O.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.52.0

