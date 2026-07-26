Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D93A3815
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065565; cv=none; b=jZ7iCFN5t/OWbgot2zHdTRVC7HMlWngXgXxxlOLfuStPTnkZP1oUw2/dhu8YUYjJQV9lE85jrp9IoTQufHZO8JFAr4n9qzjtvc5eGkO8O9pYMT4GoPrOtrzH6hWbuzXeC/5KcwTD6YrewuQukRBIUFh2tNTpnsfn8OQDg+PjybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065565; c=relaxed/simple;
	bh=rD6vL7WJH3OCucOsC8HBYYohWiKi/wQIj/76rbm0B/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT/AU2r0e7qBRroAAFBc324ZJTHHYOOswkdPJsg/C0EWBpOmRMcqdZGhioITtl5fMJHinaczU0E+gqRFMes+1f05+vZWJz33/8bmGvCZXTIu5JNfLXqgSMpRHp54eKMfu7AaL5Klnyocl2hoCgzhB0EvmYHKcKZP7orF2Pq5LOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=JEGOOfiK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="JEGOOfiK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1648980f8f.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065562; x=1785670362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=;
        b=JEGOOfiKjmdRgAn/rz27wkOqzxNLw/FYo9ETNFROQ2DvbC8peSFlKJWSB20Eso/uLc
         EKrR9KZFOaq64Lc+r2cuA7A+Ke0YhqsmZSwGkVwPNiUmYYz55E8WriTu7oh5C8Ilk9uB
         sNWafa6j1Qbvb1J7N97cyLpDirgi8g0si/PXNkdqQ6mD1x5FejTxdbgOxQgB3JqkL507
         mYBJ5PJnJj90slXI1sbIymIWfbTypjTcIcPc0KcXScp/rgzfYpw7+Oun6TN5l8xmNF1z
         GSzMEOdu817Y3lHj9KiZQRXOxhoKW9rJ24qdiSCD2C9SmToP0d/hHofpIvZGzH2TRA6x
         75rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065562; x=1785670362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=;
        b=NeOqDIh+lHTwGUiSNHAV7xpq17cpdf456LOVSDrnUYsgZ7/TnkNnr6N1kA+jSCqLCx
         NlB7/LSIThmsxyXwVLNRCzBKAa6MnJeGNVK91D1a2ugdM7Mr0HOwqpvqxNKiyYBK4fyG
         9JOuBTE2/dr+Dnr5mFDRt/yhGuF8Qf6vw7fMyGErQtfhsH3HJXAjx7TX7kwesrTfGvBf
         OAB3iw1Sb3EExTYEZ2a1JpfpVNKFDRc9GI9M84+d3UgW3RKKL8x44cIN5LFSgvrZjP6p
         VggtBirQTkvJcVDLdsYGqwSQ9NaVHbSWSGY7PgM3WbZ2QRViFwMZxnoF9qui+nTx2IvT
         5mjg==
X-Forwarded-Encrypted: i=1; AHgh+Rr59/qW+JxQnrnzZWe8nvubdwwehB5CkI21L8gy9Ldt7YRl+oGFNNWUrxsG7cAbmKfdpActhUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGCn31WJ5mFqdjoEDiwjWVMOJ5zavRfHhAgqJKvsEPl92rR/C
	W8n2Wu0flt2Ebzwv7X6htSO8sNik618GWdJjCBcf9sQHi977G7H/plpQ91IR7/0cSA==
X-Gm-Gg: AR+sD10HRB8qySQVwMP1hLSrAa19t4XPQ3O5zDuhbSrUfL1nDkMKNRcB2NJzt0QA5Sj
	XpFV4vAoIZgMpTS8MMZjrNxaO2ZWvMGRs0VPp6MgOFXGYlMmQxoLr26lFaTRLLHZR5uzWYP29Gs
	g/Q/sotg8fbaELwpMCoP5xPt6UG9JWUaDks+6VzROfU0aI3eJJSdhaP30zDGE1kOTHTzCXHHpWu
	3OgVkd9unvgDbzIvBPVt/shoxPHarqnYxB+w6DmeyRGHpXuQDz0yoTnuBUebIk7e5iAbqaYBDBG
	mm+TytyZdMc+26jrCkp//mn+h1hskTFBa0ZCDpzP5VO5i/4BgkPHeZb5j7JdVzEyxvOglToelXy
	5Frh7gC+bETU0RHJpcf0Mo9oadz8g9i49xUgnBGKcnkppd0rMX6VdLXlprlrJFEJMS0gQYqv7Oe
	4XDdxLwgvUFaubtPRbiAo/VWvBFjrUqHTBYSWByNy8heqDU8xZw0kOW4ArGohJ0i84/fhJlCl1J
	vVyZ3K9jkxylQCJPEvhuxtNmGdntv6RRXOdxBGZYw==
X-Received: by 2002:a05:6000:2088:b0:47f:91e6:3729 with SMTP id ffacd0b85a97d-47f9cf160b0mr9458165f8f.24.1785065561564;
        Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 03/12] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Sun, 26 Jul 2026 13:32:20 +0200
Message-ID: <20260726113229.2154269-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
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
test misses.  remove_serial() under the same condition.

An rdev hot-added under serialize_policy gets no serial tree at all,
because mddev_create_serial_pool() skips one that is not write-behind
eligible: the old gate dereferences NULL there, this one skips
serialization instead.  Martin Wilck's fix repairs that case at the
source, after which CollisionCheck is a strict superset of
MD_SERIALIZE_POLICY.

Link: https://lore.kernel.org/linux-raid/20260723112741.1206836-1-mwilck@suse.com/
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

