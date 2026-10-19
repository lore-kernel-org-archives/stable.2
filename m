Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450570;
	b=eokfdDnmPXTf+xCYYlZyeL7U8blvjekdWkEpjMZa+MmuZFv3V72/pNPYHGrTtBALhzYh
	 0IVj9CoKNC3GdsnYnq8qpkKJFoCXfhK68z0n+NvuJ/8S6eLe/nGifuevwB2RYsQBd4XzF
	 AWbMM1NcfnahOfJeQOkBX248n8IHIlT8QUcf0E9NRNdqM6Nb7z8ozLbz9gwzWfdl409hP
	 w02U5X5U3p3VBkJO74MOFDBTq6X1vh5UH0XXm2DHHrlnRvlfvQqThgBuw20D00ikT2N/D
	 uoCTvOGP3UzzM8ODCK6F/0FmcabBZiVhcFM1Y0rkA7+a8vEzln1hRlO8QbGWHjkrC7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JQ17Ye4qjJesc7oajTqdRZkaPeMTHXbF5jh3TZSK5Hc=;
	b=zdGa76UIWm4P/+U5/X3+x4Xikj5PdpCq9FCLg/38MidMeT7AwBxwxQDmDIgAtBg/ES+7
	 GPfvOwIBsGmgWg5/1m8D72l8sLWxs6s/XT+ObbwH37nG1tdF9dc2Yuz/Le6+Fr5Ionvd4
	 fz3ups0sp7A/9GkdSKrXiVcAg08tLmxRH+2JWeTs5LBa8WghkT0AnFBqUiRyZVJdq6EBr
	 3orxMLwmJASazppiXRe4oEroP5X4vh46//vSqTPNsztgghBoah8HkwMwIilAXM1kH7sl0
	 Z9+Rm8uzXMu8yMPiZz0gY0TABvZOc2p42vxyQ3k08EIIAEkanVx4CVyS7+Mtmi9bUkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MbN/UaUD";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C936606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C936606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MbN/UaUD
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so18589635e9.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792450568; x=1793055368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQ17Ye4qjJesc7oajTqdRZkaPeMTHXbF5jh3TZSK5Hc=;
        b=MbN/UaUDBEM9EWrCHUFOXwAPxBqKToc1rA92rbGMpmsEzh54ASqrfOO1A+MKQsNH3D
         1pwYk7IrHlQ4uK3JQ6sw4R8vB7UIeMMghPDaLCWRQOlZuymeZMbhsx/dezoFanrd402F
         NK+MW3q6TiUR6Rm1rEBnpaLXfgaA5d7ujoxgwrCxEakIO3pb7JFHkTsJEV1bwU0yZA1l
         ee2qI+sq3MpFQsYMNr7UWZqmFBfNVF9ivixBdeqqL+KJEUT26X8AcYY2eldOX34h2UH1
         cijuw5DAkbdLxfkC2UmRiX9FA9dzN81wOHe0T+LnA418RDL9LTp+v71KDfyT01VPTFPD
         0vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792450568; x=1793055368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQ17Ye4qjJesc7oajTqdRZkaPeMTHXbF5jh3TZSK5Hc=;
        b=blQq29gfDwbVDU151cVFo+DVctxWNCWJyr4u0YamORZr9kLnzuXa2uAT0HlRti847Z
         oer2Mwm5LiD0JCqULjI+2jQ9j49FJUQSCDMvOnkYchGYlzDJKKq9EJuh1ZMWcw5vJaqW
         z/cYwj2r53m2gRw99qs9hHOF9uzxMj+RurKDm1iWb7op0J96QtpDM0BW34zoXOL606rI
         x85wuoTBY2Pm8JeqlcdPV+y3A+PThh6iMoZLMI0qmRqpkoq7Zhx3qs6NVE1bja4f/ab+
         3c//XVuF4pwSIkEHzdY0cyOOhkQxhsgrbFPsrYwGu8Xec1OjXceZ6xcQCN+d5/hqUSl6
         /bAQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9wLHtG1PIBz+T8sop3E+0p7uRI8nOjirq5TR5Z4/G4g7U7ireAqqlbmMq6iXfA61QdWewJwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+flbN/mLMDDG0TnS5rno9resNj16LfDO/lUvs7MNgjoEz5Y5d
	xCkXJYn+CqgwqhrlTIspF1JsZLBh2lwnPqO2OZaEhK5G3P8SzLWALwM=
X-Gm-Gg: AYBFou3H/kcwqb/c0HbdWB95LW4rbgaShF6/XciEJNnXoJb8YNY6EPW7Atz1oyDJCzB
	+KDWreW99Za9+WS7h+0vCqHhUv8vF6PYpM9pp03g5JeEJr4jSrGVrTJ7p4xfYi1qjaiLy36U67/
	SD5sXGFumKBRNU9scUeZqFC9Opod9VVwz0/8/LLvPeKuW60R8e8AjWztk6tf58vJWvS3uZxg0t9
	BghKmmpSYHJ7/4Fub8By2g5/xO6F4E8e4UZUccZKfvpY5sNg1bBamTuQnRsKIHJ8l0L90HbfhPk
	s+9NdwYzwh8EZ7F3nqr+s+JH5Xcl2hEMhsz04rWjtGN2V0m/N+i2706DxxYv63RyKopCsMoxpX9
	5glM+DCVB1yvarXieHjbgb2xQnheN16B0f9aa1afWw0Y2D7DriFoLe9x7r4pmW+w6O7Mg+CSPte
	ElZAUcMtY13oqq6QW7/9Y7cVCSKFKJh9yM5oscVw4=
X-Received: by 2002:a05:600c:1d0a:b0:4a1:f377:5c6e with SMTP id 5b1f17b1804b1-4a1f4172b01mr10699575e9.7.1792450567871;
        Mon, 19 Oct 2026 15:56:07 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm25403155e9.14.2026.10.19.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:56:07 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Stefan Bader <shbader@de.ibm.com>,
	linux-s390@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] s390/tape: cancel delayed work on device removal
Date: Mon, 19 Oct 2026 22:56:06 +0000
Message-ID: <20261019225606.1864082-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

tape_generic_remove() drops the device reference without cancelling
the pending delayed work tape_dnr. If tape_delayed_next_request() is
still scheduled or running when the struct is freed on the final
reference drop, the work function dereferences freed memory.

The cancel cannot go in tape_put_device() because that function is
called from atomic context (under get_ccwdev_lock with interrupts
disabled) and from within the work function itself, both of which
would deadlock or sleep in atomic context with cancel_delayed_work_sync().

Add cancel_delayed_work_sync() in tape_generic_remove() after
dev_set_drvdata() clears the device pointer and before dropping the
final reference. At this point the spinlock is not held and the device
is no longer reachable for new operations.

Fixes: 4111796d89b8c ("[PATCH] s390: channel tape fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Moved cancel from tape_put_device() to tape_generic_remove().
  tape_put_device() is called from atomic context (under spinlock with
  IRQs disabled) and from within tape_delayed_next_request() itself,
  so cancel_delayed_work_sync() there would deadlock or sleep in atomic.
  tape_generic_remove() runs in process context with no locks held.
 drivers/s390/char/tape_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index bd8e3deb11993..cb5db2cabd21a 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -662,6 +662,7 @@ tape_generic_remove(struct ccw_device *cdev)
 	if (device) {
 		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
 		dev_set_drvdata(&cdev->dev, NULL);
+		cancel_delayed_work_sync(&device->tape_dnr);
 		tape_put_device(device);
 	}
 }
-- 
2.47.3

