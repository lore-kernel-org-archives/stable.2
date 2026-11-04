Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821823;
	b=pQ2RAP2BUiXihbV+sboQR8KtbwhQ9+6dMgpuInpdpnrR8TFUKAvxIpBvLBzg8Mlunts/
	 X+l5RaHGDsgpHW+vG6TcYKMwvyYcIIN3skeG3cvnk5tEqH3tBTMYHavqDDp32OIcnCwqP
	 8mrVkkCFv5RqFhzMxVP3qRCkOX8fussvt8ME30JpXnyuQQBHv69/1xL25AVcx63heGIHL
	 UV+6DO9sdP9QtO2QjqXgLvnfqhvxYQDQwaU7O7uFkJmW6CSdDksu5ukyRzBuWjLf/TOBd
	 mZv8kLP6ZUNd/rNQveVSRiGoLwQzhj1HiKAR3fuJ5VUkXk4UWM1gqb5JFIIn5r+DgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=OT/io50s2GTf++6usH4VAdftnCA55S4d8sAF74Ec5zI=;
	b=il13nId4lnj14tbCCKobkAWX6hnxWmMcwJzZAumXCBWFSOx9qGo+dre2o4BK0txOpYNQ
	 E76UtR9U8ciEjTbMdk+Cnjd/sX7bb/vM3mdlen5Hp+kBI3qzc5CA4azqeyhFdYleKEZ7h
	 0ORp9sm6EVvcJRqomQCVG8kbyWew3jpY0mBxQi5NFdQ/PQh1zLNIdVxiTp/1sqY4m2qL1
	 VOnk7aHlK8Rphm5yTAYmhG+fci42a+GL/ocZrfQhtDdRsFi6lPmNTpf9AczTeNhFKpPuv
	 79w3lkBH8zNiTZSGJWYrS5grwvUkfQgAJE4GVB4F9W6GXVz5sVnC2B0Yk/DdUu9ThSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bGHNw1OC;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7E6091770
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AD7E6091770
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bGHNw1OC
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-702dedeb70dso645101eaf.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821821; x=1794426621; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OT/io50s2GTf++6usH4VAdftnCA55S4d8sAF74Ec5zI=;
        b=bGHNw1OCkJP67JAUat0ugoirxrIwnORV+zMh8qw/ehxwkL7zFaV3h3/Pdto5xKTkpc
         QQIhjFOHJSCK1Wxqn5C7OkIsjbcySL1CCMA9fX1p2I5+TtNDsgeOIC171X6rWMtX+Cs1
         RiVGD0rasx0GLquN8O4dNoZ9xYlmDpKR25znSLWEGDM2cUctzkvvfa4dQcH3QVDOYB0n
         Xz449sJTLf8U8bOy/dgbqCQyKkzcwoHPHDMb6pMd8XNLrTrjoxZZX7Bv1Zx6QbRNFJoC
         zOFQpoix31ylJ9jDeEcoFaafFtL1gmQZ83gd7v1HYhSHSRDm2hm4PfctEFppx91/Qgzw
         CDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821821; x=1794426621;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OT/io50s2GTf++6usH4VAdftnCA55S4d8sAF74Ec5zI=;
        b=id4SagncWWqktF2mXjkr7LekJw7vRnwTSfLSjchrdWRqtjTsKwhOhJraX5bRPB7kbo
         DQjucmmtEWOv3+20qp/hy31u0sl5m2S6N4TzZGn+me8hvUvLpbkUPhsSUxB+c6IoHfSV
         pDxbrZIFFjN3Jb1S3OCXylKskESvpoQ+u/h7+DI/VKT9lL1kMPkqu91BTMeb69rC4yL8
         dLts+UHjAQDQvbiTAFL4lUirTr8WFH3SMdnpxQBmYlskt8ZnIZiHpjPsN7mRIbvWCpwq
         wKi++PISVhH2SfMprLOHhgrFXbGJORcb7+agM1Wsps4zfiHRnYo6918eS4HDulBVltv7
         Ohng==
X-Forwarded-Encrypted: i=1; AKwUvBw5wLcFRBHWQIDf0d4wOv/ekSYVujbY7Qm4Q47+LIWP/LUS01CnBRBiBKVJUwanK9xfcLA46h4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wo4hzCcwKeuQ3nmb7loAh+6ZFwvnWd63FxwThBIWKlRv4boAd
	V9s5znaggwQfrRNRGdRVb57p4XPSlLNsFgHtyeHzcVV78HvTHJonvZEm
X-Gm-Gg: AYBFou1IQR8JHYY2oyKUpf8h+c9EkvtmeY4z2SRkPO9aAK1c3D+ty1ui7Qg0NmOBOoA
	RoOOv126+fSqaU/eceMGbMJD4zOSRwZpe/8Me4AG6cJBJxlFEGCP32VV84V1SGwLY+7nlFKp3mO
	Tiq5u59Z/6Npa3Ypj+FbiEpBK5SvpLBqf6TqvlR4Xcl9b4hzD1ye4X1k9vbwtlhHoZi3QZD6F0q
	SOzfIDelhhOI6dpQVweV9VbPn7PoIiK2Fhrqu+adyBw6tv1PwH8zXlp/MpWqmvZHJf2LR6vXR+s
	jLyN0i0RWLNpPTFKRHaDn9NjAKQEqS+UVviCOnf4fPPeXH+07da/fC975QlG8M3UYhN1sMF67xP
	Vtp4chqa708GsGbefrbSOQPaJNEgjACYx8kAj1K2m7I9z2dZVvpVNkujCCQPArMJFRddvW47Sj8
	VqutFSzjBNUEImcb5zJwe85x+aKT+x4fPp1hYOjmyhGbTuZgvW9WRluHe1hfdlFzxGoINjajY/H
	lUH2icKx2t9JJV7rWtCK7sgygyEdoi06LMbC9MIDqimj6gyTwb6ppqK25thVEW1yUq33klClTQd
	s4w8UoI/wkg4XJNDPCtZAStNNUvVu3a8kKDqxvdftBjT+CMmKJUC7LEgPkRAl3uVBQcVaU9d9fD
	bBcqUMydZV6wEp9SaWn2RSKpv4ER4fEUhuzHMUfMlAIW+bhiwoYOIEUDGCa6SezMmHDA9liT3F9
	Hf671hc9Ikoktb71anfzayZbZSxqfOxRMbjShcB8zCsnVms+VruTM=
X-Received: by 2002:a05:6820:55c6:20b0:716:bf0b:f804 with SMTP id 006d021491bc7-716bf0bfc08mr1741495eaf.79.1793821821491;
        Wed, 04 Nov 2026 11:50:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c12eb1b9sm2504522eaf.10.2026.11.04.11.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:50:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 12:50:19 -0700
Subject: [PATCH] mtd: core: reject OOB transfers starting at the device end
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
Message-Id: <20261104-submit-mtd-oob-end-v1-v1-1-5cb8ad921cb0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1gasiIu5iszCpokTwXZoqwji3
 a26fIv/D0gclRN8qgMib5o0+AJTV0C/0U+M6oqhbdremKbDtNpFMy7ZYQgW2TvcDErnqBcrJDR
 Caf+RRffnO3xfl3BmyvcMzvMC9n0lXXkAAAA=
X-Change-ID: 20261104-submit-mtd-oob-end-v1-f4dc6fbfcfca
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

mtd_check_oob_ops() permits offs == mtd->size when the data length is
zero. For an OOB-only request with a nonzero ooboffs, maxooblen then
underflows because there are no pages remaining. The wrapped value lets
the request pass the OOB length check.

The OOB ioctls can reach this case by encoding the OOB offset in the low
bits of start. On a partition ending before its master device, the
subsequent address translation allows the request to read or write OOB
in the page immediately following the partition.

Reject nonempty OOB transfers starting at or beyond the end of the MTD
device before calculating the remaining OOB capacity. Keep empty
requests and data-only operations unchanged.

Fixes: d82c36821684 ("mtd: Fix mtd_check_oob_ops()")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdcore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..b82fd7ccd111 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1676,6 +1676,9 @@ static int mtd_check_oob_ops(struct mtd_info *mtd, loff_t offs,
 	if (ops->ooblen) {
 		size_t maxooblen;
 
+		if (offs >= mtd->size)
+			return -EINVAL;
+
 		if (ops->ooboffs >= mtd_oobavail(mtd, ops))
 			return -EINVAL;
 

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261104-submit-mtd-oob-end-v1-f4dc6fbfcfca

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

