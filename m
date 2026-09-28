Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F04E01F5
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605956; cv=none; b=jXG1D0AridMsKQu/EeY11+KFS/jlI/qdU73ybn8M54j3VsEQlIuMoc7MxcfRi5BXmeqj+pQ25r7F4wQAMRwjSQFthAPygrYAiGoh+BOYMaNfl5+mgdq+S+VJ1hBnopfS+kRZc4ShNeMU/Mx2rnX5oOwp6+nEubEPbDj+5BZjuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605956; c=relaxed/simple;
	bh=Me1qTIeJDMlXPknlAL/BAKmWdjinBucEj83cP4f8zxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsNcyILYDhn0TppvnqELnwbEAE8ENNMoHWzC7eY/PGlo2PDPD8A2XPG8ETwLfkc+7rlK729s8c4Rto/iNqrsaMq5s4j8OtS5P9bor0WJ8P5hUfuVSfKrvgJOZEEkF1iHurINcIQ/CsYukm64IpvDpqilBOvdwKm7WUXJ8/daL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K3yjYX0G; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3yjYX0G"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8cbb7b9cfso2451659e87.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790605939; x=1791210739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rV6mwiI6gMVHZS5XCWS6eGjcUlYZNbnHMW/o8liQU8I=;
        b=K3yjYX0GEemnDajHi38aX51lO/RgK8ZIy9x3vivnRKazSzUto67zDpXAh+ZU7jFaP7
         sq/wy3v9BVPXJmF+3LZF+rogXng31MVv0ZOy0RzkkgrI4MJwfsgoL2+sPSEvly0RZM8c
         pvON2pOsEM4xq0JFHaGuKy6W255lmiSRvQjtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605939; x=1791210739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rV6mwiI6gMVHZS5XCWS6eGjcUlYZNbnHMW/o8liQU8I=;
        b=F5N2xJ3yTO0MWn+QqoaKsWlFtcLOeZhjvoy7LqTG3F9lvahqZuIMLY8HDyMjlSw49j
         3PkUJUQd+WbNUJbShZCiAezprXBu0wnx9fQknS/03A0ujCKj4gFYs6i11XFCwiINjgOb
         GJwODUjQOqwPYW1jE9Ale7aMEtwHtDKHlAPDvd9xbPyK9Yh3U9roMjIINKBdgvMCUQmz
         4OdpnffYgPDb6DeIFxPUV2uvuzM1UXn56XI6egp+hoxLDAF/GN6MtFsQ9et4BHDVfKQm
         01z9z521haSx8VmtxQP85NqJggYeMWiff5ZH/d+mGxppPsoDJ2gKRENxQqLNL40lu2vK
         xUlA==
X-Forwarded-Encrypted: i=1; AKwUvBxOHyZtuvqL579SdIwiMbp5WOeAfbtQCPdmht+zvdZK85DETw3m8wkZJVh/wo/iXyS+72MU0KM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2hjGbzqWykXTofZ+cF7CU3dfCSSqhiphLFxabk3r3tazDcxDR
	fuKKsTf5WK9WNTTk/uZXZ2Xz99y5tCptSislCZIDngZMCJeb3UwTSzK8SPkrjVLW1w==
X-Gm-Gg: AYBFou17PDN4do5Cf8ptiXAFIwuHaCwWExJ39QmNQ24GbHCciBxzPpMUxI2c1Appcq+
	GRufB6R9W3RTfoUMi7J/+9i6JcHAvjx14bNF7zyaCxUTjQHeo+SIzY+hnkhzo9AMWwg+z975NuP
	BOV07vjLj7+FdQtL7F4zG/swpK5htlLIGmugI+Ke+0qiO+cUFOdnVR7cW9+y+GIFYTI8x2afjml
	h57IcDh44ISgbsDhSpgbgBZht/McCY8e52H3qWxP7BiuOyMA98I25mzKYimtlYElIKliB0wX/yI
	Qx8Mr643RA0WV53w77WgSvCrX6DpGMGUc7FyJ7n7wj2DIFwmRndllIzd7eqb5ts4Fssazkcp8pS
	P/7izWWBHlifS+AD0PwhqX8IBkNpOP5KxxB4ovM12WJIdVbB46EZmp8g86+oZcGFMSs+K+YoYcx
	gfkKkB2IZhOFQ12MpwiBu3oQw1yZVq0NOFgzBTxfyuJ1/4Z28lIqtSsnrMVk2FnBgzF27R7f+0m
	KnLYScQhnJof88O3w9+T22dCUNJlCjjUX+hq3BmOF9MnjyZWQ==
X-Received: by 2002:a05:6512:3d08:b0:5b8:f494:da93 with SMTP id 2adb3069b0e04-5b8f494dc2amr1480373e87.33.1790605938623;
        Mon, 28 Sep 2026 07:32:18 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b9debb098dsm603606e87.38.2026.09.28.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:17 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Sep 2026 14:32:04 +0000
Subject: [PATCH v4 5/5] media: uvcvideo: Force UVC version for Avermedia
 GC515
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-uvc-version-v4-5-da0e983fcb95@chromium.org>
References: <20260928-uvc-version-v4-0-da0e983fcb95@chromium.org>
In-Reply-To: <20260928-uvc-version-v4-0-da0e983fcb95@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Edwin Gatier <edwin.gatier@protonmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3

The device announces itself as UVC 1.5, but it only accepts UVC 1.1
controls.

The camera can probably be handled by the automatic uvc_version handler,
but it is more correct to add a quirk and keep some tracking of what
vendors are more or less compliant. Also it might be more robust if we
introduce more UVC version-dependent code.

Bus 003 Device 021: ID 07ca:1515 AVerMedia Technologies, Inc. X'tra Go GC515
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 [unknown]
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x07ca AVerMedia Technologies, Inc.
  idProduct          0x1515 X'tra Go GC515
  bcdDevice            0.10
  iManufacturer           1 AVerMedia
  iProduct                2 X'tra Go GC515
  iSerial                 3 5313180000221
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x03fd
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      1
      iInterface              0
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.50
        wTotalLength       0x0059
        dwClockFrequency       30.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0
        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x00000000
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               4
        iTerminal               0
      VideoControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      4 (SELECTOR_UNIT)
        bUnitID                 3
        bNrInPins               1
        baSource( 0)            1
        iSelector               0
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 4
        bSourceID               3
        wMaxMultiplier          0
        bControlSize            3
        bmControls     0x00000000
        iProcessing             0
        bmVideoStandards     0x00
      VideoControl Interface Descriptor:
        bLength                29
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 5
        guidExtensionCode         {55be8e1c-2fdb-4f7a-bd8d-b9b1108d20c3}
        bNumControls           24
        bNrInPins               1
        baSourceID( 0)          4
        bControlSize            4
        bmControls( 0)       0xff
        bmControls( 1)       0xff
        bmControls( 2)       0xff
        bmControls( 3)       0x00
        iExtension              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
        VideoControl Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      3 (EP_INTERRUPT)
          wMaxTransferSize       64
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      1
      iInterface              0
      VideoStreaming Interface Descriptor:
        bLength                            16
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         3
        wTotalLength                   0x0303
        bEndpointAddress                 0x81  EP 1 IN
        bmInfo                              0
        bTerminalLink                       2
        bStillCaptureMethod                 1
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                     4
        bmaControls( 1)                     4
        bmaControls( 2)                     0
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                8
        guidFormat                            {34363248-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      24
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        1
        bVariableSize                     1
      VideoStreaming Interface Descriptor:
        bLength                            62
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1920
        wHeight                          1080
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  9
        dwBytesPerLine                      0
        dwFrameInterval( 0)             83333
        dwFrameInterval( 1)             83416
        dwFrameInterval( 2)            166666
        dwFrameInterval( 3)            166833
        dwFrameInterval( 4)            200000
        dwFrameInterval( 5)            333333
        dwFrameInterval( 6)            333667
        dwFrameInterval( 7)            400000
        dwFrameInterval( 8)            416666
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwBytesPerLine                      0
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            333667
        dwFrameInterval( 2)            400000
        dwFrameInterval( 3)            416666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x01
          Still image supported
        wWidth                           2560
        wHeight                          1440
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  3
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
        dwFrameInterval( 2)            200000
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x01
          Still image supported
        wWidth                            720
        wHeight                           576
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         200000
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            200000
        dwFrameInterval( 1)            400000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x01
          Still image supported
        wWidth                            720
        wHeight                           480
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            333667
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                8
        guidFormat                            {43564548-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      24
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        1
        bVariableSize                     1
      VideoStreaming Interface Descriptor:
        bLength                            62
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1920
        wHeight                          1080
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  9
        dwBytesPerLine                      0
        dwFrameInterval( 0)             83333
        dwFrameInterval( 1)             83416
        dwFrameInterval( 2)            166666
        dwFrameInterval( 3)            166833
        dwFrameInterval( 4)            200000
        dwFrameInterval( 5)            333333
        dwFrameInterval( 6)            333667
        dwFrameInterval( 7)            400000
        dwFrameInterval( 8)            416666
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwBytesPerLine                      0
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            333667
        dwFrameInterval( 2)            400000
        dwFrameInterval( 3)            416666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x01
          Still image supported
        wWidth                           2560
        wHeight                          1440
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  3
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
        dwFrameInterval( 2)            200000
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x01
          Still image supported
        wWidth                            720
        wHeight                           576
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         200000
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            200000
        dwFrameInterval( 1)            400000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x01
          Still image supported
        wWidth                            720
        wHeight                           480
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            333667
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 33554432
        dwMaxBitRate                268435456
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  2
        dwBytesPerLine                      0
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            166833
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            11
        bDescriptorType                    36
        bDescriptorSubtype                  6 (FORMAT_MJPEG)
        bFormatIndex                        3
        bNumFrameDescriptors                1
        bFlags                              0
          Fixed-size samples: No
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 1 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        1
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1920
        wHeight                          1080
        dwMinBitRate                314572800
        dwMaxBitRate                314572800
        dwMaxVideoFrameBufferSize     4147200
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  1
        dwFrameInterval( 0)            166666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         2
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       2 Streaming
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength       0x0026
        bInCollection           1
        baInterfaceNr(0)        3
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 3
        bSourceID               1
        bControlSize            1
        bmaControls(0)       0x03
          Mute Control
          Volume Control
        iFeature                0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00c4  1x 196 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000

Cc: stable@vger.kernel.org # 5.12.x
Reported-by: Edwin Gatier <edwin.gatier@protonmail.com>
Closes: https://lore.kernel.org/linux-media/CANiDSCu4AW=JZ9FS+Ny=DK_+LqqytGvSe+V6aVncRiGRiyDMfA@mail.gmail.com/T/#me584c35c4b523ac455925a1590a3de8efc354349
Tested-by: Edwin Gatier <edwin.gatier@protonmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index adec9d1aa653..bbfc409c5167 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2847,6 +2847,17 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
+	/* Avermedia GC515 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x07ca,
+	  .idProduct		= 0x1515,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&(const struct uvc_device_info){
+		.uvc_version = 0x0110,
+	  } },
 	/* ViMicro Vega */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

