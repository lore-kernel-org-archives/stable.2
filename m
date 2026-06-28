Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643231EB5FD
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667331; cv=none; b=eB0rGQPUP7plsFbtxQrfUvfQYNwANXqnkcHgHhzL1m0dKpCBVwtfLtGflbKz8NRC4KIMCGVJln0pyZ9rGxMEnBPU0p5UM247yMtSofPlrpz+ZM3XeFtIYuzD2razSRs1iiYjw9qY5nGy6pKsrPU/gyPML67nG27r81zz4q6y2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667331; c=relaxed/simple;
	bh=K3EOnm1FTPPIVgm7ZBKpbKmC5oI+YrXDEzBB1/dVpHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEaJdRcdubIgkEbixU8ZTbOZx7KLzlDsXCjXFrMdsVCdHV3rQB6E4/26sNRYNDwi1I2QU2VGxzozEF6F6lNpnaLDDw75agMFbmssZ2RZyHDRMRE2q8BQMqeETmZAFAoZeF4Al5r7O5tGCpRYtqCoHrjNA+UhsO7hXkgYoSMgNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9ZMZPeK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9ZMZPeK"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46cbe01d4b6so1433450f8f.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782667328; x=1783272128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBABlV/y3tcVRj6J4pCvx1ErOlS8DPYAimesttySdoE=;
        b=p9ZMZPeKYklW9y9bTUWZv3xL6SxinrYKC5qxU3P6Z7EqCWdR8yfWyWcsx4c4uga1cS
         aqSPWK32B7VKgYG0SbA1DKqWFF4SvPv9n+/PKDkyEzkHFDjPJ3IsmHjP/OZhmjsyLmYC
         /kGnBW3J+e62qCJiqiTZ/KOPwYF6x+P8OLWnJKDqDpYhglZp68xomAami1etPoSCVcs3
         AEH4SIKd70Sv8N0g6Csgxpi6OY4yn+VBPMprnCVb7DoJI+FIbJEAZ24qSCFhw7cqUbSB
         +95cB+MjtzRMKa4aDrWNVLpo+LRybZd1wwMXxcx2zaoaiOA0RhvbBQgyZegVuyJ7uygk
         oLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782667328; x=1783272128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBABlV/y3tcVRj6J4pCvx1ErOlS8DPYAimesttySdoE=;
        b=fAVY/fTnkYv5U8PyjKzn6EepDa7GICHgxehj4/w9/ge9aPp4qReKWtuwX8A8bVKpoy
         e1app2kJ1/l35wnLwkgEklESDqbRXqGyCqGcX6TDXK2/zCTeDX65VlBMy0xBuKUZOCym
         uO5mknH7ZogfkYbF/VPU7JHO0JzzoSUm5WnqWKn/8xee8l1htnoK+G7cuKNGqp5bU+CG
         jOh9AXsrv2k/MtcvvKwCP/iq3f9jiz/iIvCpRXr8qytEK28Yog+YsL6zDiScluUnzgAR
         diVTqjbAt0rrhh80hGdebXn1am/xadgeWA8L406YSR+yQQuUCYXNmtxYTC6wKkZ6Yv1f
         jv3A==
X-Forwarded-Encrypted: i=1; AHgh+RrmvkuPvXgT2ekLl14wo4/Q/6GmOIqWiE28YfkIsGlbuBdEMKrsRcc3UpARb3YU+Nj07TBzTHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpVo8VGjBsCWgDxugZN5SrLOxRCzjnDCNjDP5NT1YOgEra4zN
	H+FctLqnWIGMaa0kOuwqgbimfEQTm46VQupi6jtzWRLp9PVLdME0DqGM
X-Gm-Gg: AfdE7cm6FY77XwzgR2n1bhei3esPLDXz0zQS4AKlGgctlez30aJoK0e9qXiHKLC8UJV
	a7fA2PZG2mRPt80JVVmXAuPdlihHjK8ymCCBXOssNHFG1a6USUrreVMa4cbDdzd1uv9v2dF7xXe
	1BLElYBGY44OIYPjfelEH6Oy4E7vzPamKbnfTKlCHXOg7obGjaZ+/v7zVsjxGi8YqT1YLbCgMzr
	6aqlmNe120krYHIlxoYtvsSzBtqkJ47JadJU1BXUH6HXd7Vvou/xkRmVj2Qi0cXDfFfe63lZM6P
	oqzU9KwKVnSYjJzFFppaFNMU/tgpkmTEt3KAb12CN0ETig5SEeGW/7UXUXwnRZc7R062GhUwR8U
	YAFluiAF28r/rVcGolfKIyIkGooUYVt8hR0c6/zjZYA+WynZpEJ4czMRNwV/juJhU99OCTvRCqZ
	3sAnp6hzIc3EalzidDrsm7totg
X-Received: by 2002:a05:6000:1867:b0:46d:8695:f49d with SMTP id ffacd0b85a97d-46dc2a1614cmr23514992f8f.34.1782667327708;
        Sun, 28 Jun 2026 10:22:07 -0700 (PDT)
Received: from foxbook (bgu190.neoplus.adsl.tpnet.pl. [83.28.84.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472c7bec9c2sm7927088f8f.12.2026.06.28.10.22.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jun 2026 10:22:07 -0700 (PDT)
Date: Sun, 28 Jun 2026 19:22:03 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <20260628192203.5fb9daac.michal.pecio@gmail.com>
In-Reply-To: <20260628190201.00afdccf.michal.pecio@gmail.com>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
	<567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
	<CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
	<5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
	<CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
	<eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
	<CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
	<02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
	<20260628165040.76fd608d.michal.pecio@gmail.com>
	<62e1fab3-1045-41f3-bc74-4c7624011619@rowland.harvard.edu>
	<20260628190201.00afdccf.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I really think it could (and should) be a simple patch.

This is what I wrote a few weeks ago. It's an unconditional change
for all devices, but it would be easy to turn it into a quirk.


--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -938,15 +938,14 @@ int usb_get_configuration(struct usb_device *dev)
 	if (!dev->rawdescriptors)
 		return -ENOMEM;
 
-	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
+	desc = kmalloc(255, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
 	for (cfgno = 0; cfgno < ncfg; cfgno++) {
-		/* We grab just the first descriptor so we know how long
-		 * the whole configuration is */
+		/* Try 255 bytes first because that's what Windows does */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+		    desc, 255);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s: %d\n", cfgno, "start", result);
@@ -975,8 +974,12 @@ int usb_get_configuration(struct usb_device *dev)
 		if (dev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(200);
 
-		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    bigbuffer, length);
+		/* Don't bother if we already have it all */
+		if (length <= result)
+			memcpy(bigbuffer, desc, length);
+		else
+			result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
+					bigbuffer, length);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s\n", cfgno, "all");
