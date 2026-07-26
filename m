Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0443A6B71
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065571; cv=none; b=s6doyXnUss+rkEW/GKA6XhuxzDJ1ivWfM3UZCWQK2gxDxeo5+6tzbc2HwBMgyCXYYhSdJjng5Vf7c0SE48UfRXu0xNRcTr0g5aPnc7gDHsV5hQ+pE9nYYlwQ/G/BmWBQqpobenNtgfzL7BADzEA9km0miwXlN1DoyGbHZVhAqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065571; c=relaxed/simple;
	bh=B1aIegApdgScj51bEIGVKX+FENfztmE4q/fjJ31TwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYjLC1//PyjDaXUu6zvXLJZ6Sd1zR2uerR54FKEgUONl4HJakxYg/cX71zRZ/+Nm+sOYK7t/uA91gcDzgP2+qs+JY8i3X6lIuj1S4ztW7roEPw6uiQDdLicDSY0P1lxevrpNdM42ioU+x/tUgCxKQndXlifmxNgG3OTvI3c5Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=DorYaqq6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="DorYaqq6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f7854678bso596337f8f.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065566; x=1785670366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=DorYaqq60eepV9rkw2WLxOal0xhjSKbGs9hrRJ1XPVYOI9kOpk/Dm3PiGoGNaPW3gz
         vci0JAfUL9vlKjkzhHyl+zoF95mf5S/QQiLXoEYXrj8UhDCqVUkl8/U+9AOHBYsCWLJV
         BRcirt+Gy3X+vnTRZ0QeYEx1ycOYLro84nFCm/kSGJZd8AwXJNi4NJoOz2F+FTYwYvuA
         +qHQTnbqhWoTz8J73z+OypD6SF6GbcWkjKmN6mv95758cWif1C5M+6kcL6eTApr0P0NE
         mQITvxApZyeGMyWb4hUJkXstxw/jbbZh/3czgPLxD1d/u+e9y9PjxrCW9EHfAFQ/BH8Y
         oakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065566; x=1785670366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=KITI0yNaQNgk5n3k3VxnEi7Iw2rh50JwRO/gStSsjvdPI/X7SZ6oHV6ade3s/MJX76
         AwXb1CQ9EOI82YKe21J/fgweeDOU1LXPrBkFMFr/7O00gAJmLnBW9rNFRgEzRNY26VqU
         cnVCKnnhuGrBPfmUjcgHmg9fvf72vM+4FjLE69r36zpDD9HJyRPcY4EBzJd3MBRMMDQC
         qaUGXjlOMdzvqZxEN2pVpF9OpL2UaLB/6GIELsJb6TqURnBGsvS7P67QhyJungmPQJqw
         RE10VWxxQwkcAFNGtM7weti+NABWXzGmMWNdA3VeecImyJcIdo8b+brxecf43G7lu8vu
         zdhA==
X-Forwarded-Encrypted: i=1; AHgh+RqopqQ1SmPI/B2Dr/lvjC50R2yQdHU8n1KlGe7rQ1NsjBeAA4f9ks7YN4Jds+P0QJ/wM8l8ark=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamPIX6na5wXTQFK7wpi+WMJhJF6G7C7k+THawnILR2dGn8XAo
	EMHzdzv8I2/r5NtTGLsjbc8gZjrLnXwYzuXXqkPwOq2sQ6Yon/zXKd7gZFSYVfGlag==
X-Gm-Gg: AR+sD12kQ7tjCiVQCwvyFev7HJIOtx6AzLhyniZs1wtrGwWHljR4UMy+2g0O5/uPaox
	vAreVHt5FskH7bN/w1zVl/V+EUsagGmgAwvxX8dStWYo2gy1HaWVGKHTmPdtpnz0Xo87acTAFdE
	kUROsa9qGlsrTpnABHfGeOrFhDeBouKnosGZVetp6O3U2BVue9um+9O53U8Nt4KJyjJEMJU8T2V
	/P+jsiwdudcOy5d7Zi3oPDh48ocnXjCkxuVQnPGHvl+Pn93gRPyNQudN5UIWJ4RdMB/ou3irE6X
	fyTGHM8g5hBoxzkQ227ZSE2631TLZdu6UvI8tKAWvl6dxQIh3sdjP/pqhy62FM2AUg2/uEacSsR
	EC63TYJ/qjLroTW2V7SnmV1f6soaqrK3rcMMAAWM1MgWR443oMEu7lCbC14ONOvoqCla9uc64kF
	EF67C7t9QYNptTGtda0KRRINRmp/NO3Kdsp4YGCcac+q5qceYo2DZRfwgrjFKA2GkrNkkG38OCp
	6O5OWV1FCdLYe/61L3f3pwYvFWMwks0YzESfPoCsQ==
X-Received: by 2002:a05:6000:200f:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47f9fe9bc91mr5809021f8f.24.1785065566081;
        Sun, 26 Jul 2026 04:32:46 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:45 -0700 (PDT)
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
Subject: [PATCH v6 05/12] md/raid1,raid10: factor out raid1_write_error() helper
Date: Sun, 26 Jul 2026 13:32:22 +0200
Message-ID: <20260726113229.2154269-6-mykola@meshstor.io>
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

From: Logan Gunthorpe <logang@deltatee.com>

Factor out a common raid1_write_error() helper from raid1.c and
raid10.c.

This will help reduce code duplication in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c | 13 +++++++++++++
 drivers/md/raid1.c    | 13 ++-----------
 drivers/md/raid10.c   | 10 +---------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 56a56a4da4f8..cee21452e066 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -303,3 +303,16 @@ static inline bool raid1_should_handle_error(struct bio *bio)
 	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT)) &&
 		bio->bi_status != BLK_STS_INVAL;
 }
+
+static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
+				     struct bio *bio, bool allow_failfast)
+{
+	set_bit(WriteErrorSeen, &rdev->flags);
+
+	if (!test_and_set_bit(WantReplacement, &rdev->flags))
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+
+	if (allow_failfast && test_bit(FailFast, &rdev->flags) &&
+	    (bio->bi_opf & MD_FAILFAST))
+		md_error(mddev, rdev);
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7d769b6460ca..f07edeac6e5a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -483,17 +483,8 @@ static void raid1_end_write_request(struct bio *bio)
 	 * 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !ignore_error) {
-		set_bit(WriteErrorSeen,	&rdev->flags);
-		if (!test_and_set_bit(WantReplacement, &rdev->flags))
-			set_bit(MD_RECOVERY_NEEDED, &
-				conf->mddev->recovery);
-
-		if (test_bit(FailFast, &rdev->flags) &&
-		    (bio->bi_opf & MD_FAILFAST) &&
-		    /* We never try FailFast to WriteMostly devices */
-		    !test_bit(WriteMostly, &rdev->flags)) {
-			md_error(r1_bio->mddev, rdev);
-		}
+		raid1_write_error(conf->mddev, rdev, bio,
+				  !test_bit(WriteMostly, &rdev->flags));
 
 		/*
 		 * When the device is faulty, it is not necessary to
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..5b63175fb382 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -482,16 +482,8 @@ static void raid10_end_write_request(struct bio *bio)
 			 */
 			md_error(rdev->mddev, rdev);
 		else {
-			set_bit(WriteErrorSeen,	&rdev->flags);
-			if (!test_and_set_bit(WantReplacement, &rdev->flags))
-				set_bit(MD_RECOVERY_NEEDED,
-					&rdev->mddev->recovery);
-
 			dec_rdev = 0;
-			if (test_bit(FailFast, &rdev->flags) &&
-			    (bio->bi_opf & MD_FAILFAST)) {
-				md_error(rdev->mddev, rdev);
-			}
+			raid1_write_error(rdev->mddev, rdev, bio, true);
 
 			/*
 			 * When the device is faulty, it is not necessary to
-- 
2.52.0

