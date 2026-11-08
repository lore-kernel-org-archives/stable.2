Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171865;
	b=mkwO3mzDW+DyO6rjAGlt/h6/PKZd7CTuUKHYGkFSCkzA8BvcmQd3TFpiSu0XO4SvLzvP
	 vzYaEqNSVmeBzZAxwojzkcJr7HbYx2oaEZYbHan437DD2l1alhfplRdrT2TMJ0WhOFkTS
	 K8GAhrufL+MHFEPEjN8LC7UWedfdn6NNBPWmK6DaKC+v8hu7KcZ/MN5j84uAQ6gagS/tO
	 aSDHpQ2cwcM9mc5CrHaAHeHn42ni7/kt7R/vK7cX6MdhjN69DLTKo7hdPi8G5RAHjfDrF
	 tNDZVmBNS4s5KYsmukiZbZi7BM2SKNlyreGyxqMnxfz4c6PN9DXVCiWNtpaVfWtnohw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=5GT+YOwt4Wk5UaYozi9TZs9C5IMfkSYjhBBTrIEYhmQ=;
	b=AkYDqPGiS6B5LzBpV6Cs6l4WrIGPEWqY6Tvfr6h/i1vhNFXaQ79yFt8HO00nAsWqpxyp
	 AG65OPThD5VZVRSKxvYBZrWkm4CqyQpsZUWqRXAfYeA9kxsMN9fKK+GmBn+GH3bFUHzyC
	 yLOUU5S72SgcF7aZ+F2l4OudqkAbv7XZXaoYv02lVFbxDxdzHREzhxO5wELwx8CN6Fit6
	 iG2V2B2TPQIdVPzlZC8Jhiu/4gqkwAd8lrA6+gym4pSJ3eEncsJuqwr4gyzMYnVmODEO5
	 iJ7wdf5iUWTlg+BxkUNBk1IKSYbKkOXQnUJie/spJo7SXUV4+pc3uBVVzlJhlex+nhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QtEgshp/";
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B4606A332
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0B4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtEgshp/
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-49429181ce9so185060fac.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171864; x=1794776664; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5GT+YOwt4Wk5UaYozi9TZs9C5IMfkSYjhBBTrIEYhmQ=;
        b=QtEgshp/hMdeDywBQqrU8jr4TeOfNd23D70HubU4cWYXtrvU0f8+P1tZtrSSRhL8h4
         NkZI+unS2oj9gniScMyAsi7iQhS3EddiwtjuwolxsaNF8WYQovDw62JQ8itQ0CnZuVUc
         LgHniQiVENtOjxwE4e2c45rUFubF6Bh3l9sMUqGK5cNNQoPhGiYcbHnyLr7vbBaTmfHW
         IlefwwyscLyhVnL1kLE8rRtyGHXUL96gA4dGHQwBCQ7NBm/Cdp8060cDsHwJUR7KTAG/
         dT+Xd924Q0l6IeuFJ9aA8NCbxaF86vaiFyO0u4KaY2HFwJ8ZNU5cII2Bn5x+ko+aPnIz
         biBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171864; x=1794776664;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5GT+YOwt4Wk5UaYozi9TZs9C5IMfkSYjhBBTrIEYhmQ=;
        b=TIhNCN0yd/s4+OAHhRk2zedw4VWZjhAHZA92vZmZFkUeMrL115wjZ77ch9qFlqDHE4
         fGi4V/gMNr2Z/RV92tAH2frsEdZHtXVyhoyPNl1GwE4o02sKgJTOLEEI4CH3gOcXP7k1
         fO1i0BucplLTBgzq9YVFHcieaYWYlMLzgtA8p+1ffjBmAPWYOp1tctPQT2UgRDSH837u
         jQqUQlfAgYOWR86vQbN+nRD8en8jhPMxOoJWY6KIBjNNgHff/pPHkUwy1f1HBw35gNrY
         V0AhZRCGHc5PAx7HH0la9UbXqUeveKCMTv9Fu6zgxQrQEtlfzk7qQnRayN2g/mRgjjD+
         yrPQ==
X-Forwarded-Encrypted: i=1; AL+hErEQBJ0TmLzIxsnNhgVgx94UMp8P5zCI3+UcITnqQxOuel8ksp8YTJ7DeLsu6Hkxt4nRwzUL/Ls=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/bw8KxyriS2svN8wiOEW03YuPcX04Ru50t8qFwcXf+AI6PfTS
	LnHIsUSAEmnIHFDvyGqSvhUFYCXDnHyFPPRIO4CdtbIJH4As0lBjNAul
X-Gm-Gg: AYBFou2bCnOXLBnJXg+qWJN2n/eIzC51kv6CFD36AWEaZZ1jfQBj7TEQyOP6gvyx8OU
	oSfS7fbSDksxBEE2iNhw1WycI2Nt3wIzshxZglZyZKKwFxg5OWPb1/mzhznc6HUHrcpHBTH/1m3
	ZUfsM7tC4AjaT+H+iGhkJw9qhhZeJ9u/2pMhkAUlHp1eoCETanv3TXZxraaUj7QzwuJYTYNqL6I
	NO3KDk/0kTEaxBICi/l/mbMlPt8iHZ2BcUCU1Z24SfvsPv3rVv+4F/ca8nnNMqxsMZeISX/eb9r
	uBjyTHAs+wVhphgpaCXvdg3xxjlhbqwxh1DvVv5mBxZ+HkfOvOkKEVU8mHt2rcboH1WJBrpJRbO
	vvLRniEKmanlrYVMVD9Jd46rVsUlUGXn986zuUs9ZRYgj8NRIeg1kIzhRNPLqyhofLQMoffCbgR
	9ogPseaJ/bU76ZJrKS/wWN9vo6okNV7soq3K0Jg0KRz4XHRML36COBav0Qn7l+BB8oiRbMacevF
	qVG1CNW9/U77VRZOc9NOFOkIy+ZbROhXytJC0Qi/JePLJSBY8hCUvev/2fn120dF3BSdVasg9s6
	DXewsnY3FpBI1E4x8H39XgUluYcmhbv2PoyzBfpNgh2gAOJLyWzavoZNNbEm6iVerGKjnwl5jK+
	kePSB1Qo2UduFE2U40g3Txjdkc2T3Ce286thoEOX+uVD4Bmjm0pClIsBmVFpGjOmzY17SrYdYV+
	WXi64wS3RP1lzetHGNI6dmI/bgUmV382/yLRI1NKsaNGaKjL6ULQlW
X-Received: by 2002:a05:6870:538b:b0:49d:d617:b692 with SMTP id 586e51a60fabf-4adecb98a9dmr1074710fac.49.1794171863950;
        Sun, 08 Nov 2026 13:04:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade695a5a6sm3597440fac.10.2026.11.08.13.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:04:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:04:21 -0700
Subject: [PATCH] mtd: rawnand: r852: prevent card work from being requeued
 during shutdown
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
Message-Id: <20261108-submit-r852-shutdown-work-v1-v1-1-8e448ad7c54c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2w7CIBBEf6XZZzcCltb4K8YHLltBU2qAXpKm/
 y7oyyRnMnN2SBQ9Jbg1O0RafPJTKMBPDRinwpPQ28IgmOg4Zz2mWY8+Y7xKgcnN2U5rwHWKb1w
 4cjkQa+WlZ10LRfGJNPjtp78//lz+LzK5OutCq0SoowrG1WrM9hxUKEFbhuP4AqcfqoagAAAA
X-Change-ID: 20261107-submit-r852-shutdown-work-v1-15fe04537064
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The card interrupt can queue card_detect_work after shutdown cancels it
but before interrupts are disabled. The worker can then access the
controller after pci_disable_device(), and can enable card interrupts
again while processing the event.

Disable and drain the delayed work before turning off interrupts and the
PCI device. Later queue attempts are rejected while the IRQ handler can
still acknowledge events until interrupt teardown completes.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..bf1c1be7f2aa 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -1007,7 +1007,7 @@ static void r852_shutdown(struct pci_dev *pci_dev)
 {
 	struct r852_device *dev = pci_get_drvdata(pci_dev);
 
-	cancel_delayed_work_sync(&dev->card_detect_work);
+	disable_delayed_work_sync(&dev->card_detect_work);
 	r852_disable_irqs(dev);
 	synchronize_irq(dev->irq);
 	pci_disable_device(pci_dev);

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-r852-shutdown-work-v1-15fe04537064

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

