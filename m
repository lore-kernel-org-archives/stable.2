Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216364;
	b=VPJrfGcaNi4NntqYm902h737ZqaxU6Sy5yXx9z1zWpO3anJjcWE5p+bdMD8BwmFun/oA
	 K2QP8dWdq4BBB8dY2c5s+FsE24VhcJmNXt4vW+K3RUILPEWjUkfoRm4Eje3+y7ya+b1al
	 mlj0WpP97kDwOz/oxXVf3Aq+Oqe09LR96tlETCotet8Cwma+P3rVdL1Ez0qqYI0mzsMnf
	 6szwyYh1lkHnvB24bBy+JsUBH8mnhxoBMcLzBkbZUOznWweW0qw8puGghUwYNK59Vc/7v
	 CMEhnJIZ2pBXPKmOVoBPgPPYORXl3Jv4UwbC7HMwIk6DWulPYTIc+3wM6Hsb4cCMxZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oGYRtNm+OpEdkhc+j+MjKB9P/P9lBgdC+GZCMpMbh3E=;
	b=bKAGF2kPYYEC1xhqBrFAgfaT6tn/6nmC9UKoDTmdY02IDQnGVnm3wG+6Rsb3BDx3oEL5
	 nGaRZ+TA9rLqjj96fiFkicBSeKoq3Vy22VF4ZMma4JmK0fkk6BTugskfnaG6pxjpeP0Mn
	 N/CxjOVEBgZhj4CZlj6yukOP+WxjS+aoB/pzTGTjo70uTNwFk/a75slVGZ9zDh7Q52UNf
	 Nth189axbkMBgpZWeFOELYUXvLaqSkGggzGf/KyCpbhz9Zp7omXFKfacIB1Baz+l74Anw
	 YSEVGXNxK3BKiin9/canSfOkbkmVL7QjjZqKfujWcCoFMpCjpEniTXO/u1LSVdaAOJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LLS0gjuU;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA558606D80B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA558606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LLS0gjuU
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3adfd5771ccso4453781fa.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794216362; x=1794821162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGYRtNm+OpEdkhc+j+MjKB9P/P9lBgdC+GZCMpMbh3E=;
        b=LLS0gjuUZOrg42G89J+OJXKQZElYeru58GHeUw8VMw3DX9tvBmat9pGa/lIqkwtc3U
         ZH11iHeMaosZx9i9xNPVJeieY3ChcbDPnK9fS+8+z9ewQySnXiCxSVfqef+wZZbj4Zv8
         qug59NlMieqlcQvWKf4GIG2pG+Y+aZ7E2Fnxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216362; x=1794821162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGYRtNm+OpEdkhc+j+MjKB9P/P9lBgdC+GZCMpMbh3E=;
        b=abB17CTscDI3mxd0oxoa1jcEe1/YazzGKFNHysIayhoNCKoktgMrzrHcqe0oe4njzp
         5sjIDgm0L4CU2cU2STJ05sJBHYxVW54X4OLXaKHm/eLNWO9Ad722T/00GyY9IQkFc6Uj
         sWt2Eqwxr1D/lboX4VEXj4RS8PtOhojY2NLWi1xT28mjAnyMEzyD1Swv9ncKUiFSCfVs
         ZjN0QnM5lYaIp5xLcflWBaREtFEJbT5QjbwxqDgjREN3bJ+8NpTaICAf7BEeV2dbqFda
         b2eQu0JsxUnxyz5BSiU/BQ98rl3HoMW8Va7CiRgbJwiICxMfYKKvqUOda8OdxS9PJR9b
         keeg==
X-Gm-Message-State: APuU4Z9dvUOPz3hRZHyQDzsdf3sMUCtMi3YT4iMPdeKI5I95Dzo55UDV
	LN2dWJgNqjiXUAlYYR48XY9y5u1yO//teowT5KLVL08K4dIj4/BQJKkQaTuCpILpBi4AeaZrGCk
	NggOY5w==
X-Gm-Gg: AYBFou3BlTUZ7ocZfOMT257RQmvpFslwoFhdNrnb/L/SZmF7pumXNADqAAupUQIQJbC
	dMH1cZsMA6LSYByQctrojqkSpXXw+j/xL5A4Bjw2KTC1B5JC5Hg9VsB4hJ5bW6FPjQT6JqG087A
	WnvehvvW6Uq71wZADGC+PmsjYYraUbrHXWv+rwWHBDzAX0zWvj1ogI7E2ygqNprg2KMD5x3Rkqy
	z0mRck44NkQpoVedHLaVtWRinp/kQ4YEMU9tI5CSOiByH82nm1lHUMi8jKL654YzsRN3Wig5Xgq
	qHC3ibpDtr/X5WTBrh/VqGkk1dslBAJ6cLrii9/ccytVQtsmMz001kC17tyiSzBApy5avjLitur
	ufBgcDWfqRfy/M5T8H9LSIztg/xr2wphiPclTGr3DwW/3ec6Gqj41DflsD6c2Zoz3er9AAMUIlp
	pINIKhVPgXxtuvR09JRWUw4M7W7bWCQX91uQthGPlcgPNPb8bkMISupsLWhkgfyGP4nDW7nK4fn
	E5QvHRHNZYYQFbcXc5knW7YIbFDaMxu1Vzy5+eAJ+GfotvLDLCF9A1iUhW0qOSygEsRJ3wSiFRP
	kpOXteqiZ4VpSu5skMachS/Ds2Hmj/zQntxz2EJCv9DXIHooZhAw394awrIluwL8pOuZTW9+9yj
	velTZCS/nrA5ku1A=
X-Received: by 2002:a05:651c:41c7:b0:3ad:f36d:41e2 with SMTP id 38308e7fff4ca-3adfa22c812mr6843211fa.0.1794216361988;
        Mon, 09 Nov 2026 01:26:01 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b812195sm748322e87.55.2026.11.09.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:26:01 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Edwin Gatier <edwin.gatier@protonmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.18.y 2/2] media: uvcvideo: Force UVC version for Avermedia GC515
Date: Mon,  9 Nov 2026 09:25:51 +0000
Message-ID: <20261109092551.2315410-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109092551.2315410-1-ribalda@chromium.org>
References: <20261107050802-failed-6.18-65444446f0c5@kernel.org>
 <20261109092551.2315410-1-ribalda@chromium.org>
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
Link: https://patch.msgid.link/20260928-uvc-version-v4-5-da0e983fcb95@chromium.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
(cherry picked from commit 65444446f0c595c0e250368cde88735b59ccc446)
---
 drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c15e73f41910..511912074ba0 100644
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
 	/* AVerMedia Live Gamer HD 2 capture card */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.56.0.506.g506a7eabc5-goog

