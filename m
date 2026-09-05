Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AD29B766
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626721; cv=none; b=X2YAmwLyjrFraIcRhj81mgEqzTVHgaOVulO0SwUu/4xJMRMzO9kstSa+hD7n1hWIHi5JRPvbhyXt6EziSqdUkU6tvZ+gKi5dI/D1qs0Y9G9221xNVQ9BDCw47lWPAah2gbFhHnNG8jxBCxkwYXDdE4bqCmhbHTnMKl+pOwacLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626721; c=relaxed/simple;
	bh=ifc7H3d8cophRdBVvhP/1sBwTZYA0mepFYMjpoBRgcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGHsJfOc2+vMJBFCE3BYgyC//Orjw+nS0PY4+dhJfIxBUhdHlqSvTSgQFiZ8yjwlvpuNnT17MgYjrD1VjzDE1ML0UN9HtAJW1LgIHXfxstYD4onUEEj8YriPGXxdoKCKhzn5REfJityuo11oOaJFV3P4D9EgykoYEv3dy2okClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2veQxqu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2veQxqu"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5300bdf61d9so24274621cf.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788626713; x=1789231513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGsQP05BVP7HKqk9s+jX5IUhEyQb2OXorpPQmD8qdnw=;
        b=Q2veQxquBr3zYbatYaVLvr4AA+RntALkXyYoZab0Cu48VI4Ru3iCBuS8vuCfN08/ic
         EBftGeAMGl1yQuTg7FjPggwRRiNAtyzfHju75/NEFmAmlWrYtng5wpuv7YXbX5tYZeVy
         rKyLYy9YZTWoFDHt+heUW1jOTeTovjQVRb7UQr7twfrmyL+blcSRb79LwzvbuepBfHUc
         yiZlIhuR6p365i9aPzRsXY2BtIdvjEJseoZ8RPsadAxroqfkxtpH2lorgim8HDQJQiB5
         TZBbD3dXWrGEevCqoYREh37fu+0yvM/hfB/EcbFymWZvTdtuZJQxrfAowIdfqK69Vjso
         OB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788626713; x=1789231513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGsQP05BVP7HKqk9s+jX5IUhEyQb2OXorpPQmD8qdnw=;
        b=NR8fq/co5J5LaNmsHzBv7ZpElt2n3mOJA53rHS7F8hiW/nmphSh0vRA9KEYdoZyrak
         s5FuLCg3DldplDzmZS4n/UvnVtQSK/NZyAHHPggug+T66EQi6drU4aFlWfBpjDqai+u4
         5RbS6Y9MmzosgEO6GtQP5vZTzca41GK5X8a194/Of84Mp9y2c20yi2FOMZr8OXiyXd49
         fdlgKevuBVLVQJD8rjvGlwQ7SxHl+0HSK6mjvsL45GEOulSQgg00empW7Abhj4ZRIn+3
         rlnN8G5OQmrEtVcpGGRa8frGgW5H7SzRS71tiRjDnAPR3686rX9YqAoRpgeZ79IyYkGC
         S/hA==
X-Forwarded-Encrypted: i=1; AKwUvBx2L1SbQQuEBzXFyvnO+/htpA69YMBrORyjNGJ+7Qolcv30kAwMLiUs7kaBBYmHcqcxFqaqNBE=@vger.kernel.org
X-Gm-Message-State: AFuF++nQK7iFRKNsl55R/YaoTalVeWFgZ+IcktcCc1hy/Ut4kpfAaq+1
	+VEewUeAuf63NQFy0/Pyg319wWL6Q5J87Sy5/rK2FV2duKLs5Zttm5aj
X-Gm-Gg: AYBFou0+SaAhTf5X9mySGFl9bmXUhsWaDrIISgP8J3rvTITkCYTB11IhTx63h5wZE2j
	u3hy4pwiCLj1o2LvTZi5VMN9s9ELfhhxFU8wejpArjV9uUBQ+GdEwBxJzezqb+G/HW5l7SEUT6T
	irF6YZpW+0IAbEIXH31mOEFZ9TuUqiqdJAHljy/VE7PyF6t3roCPSvcrMohluBgZMM177io1Xpw
	x1dVhFufPXvsRmoHBJ8jTjqKLGqNEtkvarF/YJ4KCf98BqszE7w36ZxMU67Ng5qp8iBv7TAR0Ew
	1mMnwoUCbsFaOpoXbi9PXIp4usTO8w6AuIqvwsmWVMgB5lEFDCvtG00TtTkxeAQaGnoOPRjSeDQ
	XpvenKgeRVf5342P1XGzCjJ+6hamW/971gpRrqxfKRs6+HR9NpGt6lptIHwqUqzWVkNtgBCXw0h
	vFXOONtOhUakIhbVtVrFh11gRvS6+g02Pbo/u4Xfykt/oTEUanuyxBUrj99t8j9mrohqUNsd9Pk
	lmW9Ri+rNlG1ddvwbkn5pifuL0=
X-Received: by 2002:a05:622a:1493:b0:52e:12e6:6d7b with SMTP id d75a77b69052e-530549f8c81mr144088371cf.39.1788626711978;
        Sat, 05 Sep 2026 09:45:11 -0700 (PDT)
Received: from dave-desktop.lan (modemcable053.177-58-74.mc.videotron.ca. [74.58.177.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104067ac52sm48984326d6.27.2026.09.05.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:45:11 -0700 (PDT)
From: David Collin <davidcollin899@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Collin <davidcollin899@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: dwc3: host: fix props[] overflow when all quirks are enabled
Date: Sat,  5 Sep 2026 12:44:48 -0400
Message-ID: <20260905164448.209348-2-davidcollin899@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905164448.209348-1-davidcollin899@gmail.com>
References: <aptV-QHKGbMqw1uP@vbox>
 <20260905164448.209348-1-davidcollin899@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props[] is sized for exactly the number of properties
dwc3_host_init() can populate, leaving no slot for the NULL
terminator property_entries_dup() requires when usb3_lpm_capable,
usb2_lpm_disable, and the <=3.00a PED quirk are all true. Size
props[] for one more slot.

Fixes: 8da7644493b4 ("usb: dwc3: Specify maximum number of XHCI interrupters")
Cc: stable@vger.kernel.org
Signed-off-by: David Collin <davidcollin899@gmail.com>
---
 drivers/usb/dwc3/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 74117cbb2f42..cd1e5204ac3a 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -130,7 +130,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[6];
+	struct property_entry	props[7];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
-- 
2.55.0

