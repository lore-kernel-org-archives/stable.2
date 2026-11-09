Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216208;
	b=RyoveRn4j8mRl/sCMMZfj03Yx5fuZovGe5iXSX9mzddQmJ1zWiG/LgsTjpUuqx7HT3N9
	 cVJzVplZImMOXHFGK0n5hepEYQnGhaSOkCqw1j4FvhCTxP1DdztfXUTTKZUeTudStRXlT
	 pUTgOyASL4OB1C2gzMVszbF7sOqvmDvVHp35me3ERFkyprwkP/3ZXmwnuOZrMtGm+X7IZ
	 cJhlXMWOKY+Mw8TPi69KYr9NruiflEotwpsi3R4WQcB0QcTqoip9mm9UDdhw8FY6QVrpE
	 23RsAP3byYmvlVRVNsotDdhQ4v+8NxwyLl5Doh33LxgAz0xgsO1jk1WnN9cQc8yHU+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=an0RcfYUkqdV2eMi2bIBBpBriR6fzMflVHPfQfCz81c=;
	b=t6uWeg0FOYyUqoEC7fNenFlkD3lBay18R/LDSeFAmRs6huiMc0kSBMEtZEQNDl+XBJGP
	 nyALfzY3VQoT5oyXrx3MrC8/TctbI1UUe+Ooz9vmCDCv2wKtRM2OYaep9j3OTjSDP2XU/
	 fIxPOgDc/nP7bFW93b2Cu5FjFWtDHjbByoMU/aYFudpJbOpkhlJy2Nebp+56ub9FIVthV
	 pRO7o715SiUBsKNgBfNz3Yw30qkHLAHUbnCzleAXB4G89Wea1JADudIurNhHZmc/N4LVW
	 zyp2iOA64lXRublhBREJhA9bUEXKraToWeNKOr43Smp4CRN6Nm1Yeow5Kas+pA77dXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fFl0ZSBa;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEA606D82A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0BEA606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fFl0ZSBa
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so360847e87.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794216206; x=1794821006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=an0RcfYUkqdV2eMi2bIBBpBriR6fzMflVHPfQfCz81c=;
        b=fFl0ZSBaRVHU5Bnvnw+T4KfhWZkqzzzi3bMxy3CeGr6FLaRx7wZJS8BUR/UPhSECni
         6DHSGfbKQpN9lVIrQjzkkVPXDHb4PccA2IuJ+PwWbCfI2aQ0EcoFxtQpT2tQ9lzhaP2n
         sB0EzbsClG+1wW6gYqHGt38PdqPp5mX6+c49Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216206; x=1794821006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=an0RcfYUkqdV2eMi2bIBBpBriR6fzMflVHPfQfCz81c=;
        b=OZuxFGwFJl6VvaYhlb6QKgb8wHhBhYh6JgpQjx232bbX5XyOBCa9CXAmGuT/LW8xHK
         AlHr7iuKm2EMCPf4sWe8qQ2vSC4rNvwbMKFci0qGHwVk5KRT/4Em9jNbjUGesiyLjcQ5
         t2BOzV/5y88ucZ34F4Hdru0mjYzyp4t5eYqFALlaLhbMNUSHYTA2vs7vjuIj7praObQn
         ud8gdgA5pn8cKySXMx8wyGMJN6U5V0VSpTSKo+pyjBJGW7HczlyHgn36dAOGwdCyZdMF
         9YFOrDvmzGpDVzQfdres2/I+cc+26U3nLCFrnur3iAzLXSD6QNAkOSjhitt0fGYDaD7x
         vq1Q==
X-Gm-Message-State: APuU4Z8/9k4ikjFwNa8C6oBgHhFedw3ccX0y9LlSEtOZCqk+0IlWC9Rj
	Owliwl83F/fpmuLWOFYD2fCuhEfbocN0O69B2T1tjhJEMsrco6IUu04T4sswOZCHfn6nsEXoTDk
	b1cE=
X-Gm-Gg: AYBFou2l1Hfxvq94jFvEyfDMkAFBteh5suBkfXi7RueQhR9Jen66uvHKhtnpHfTCW/P
	bBtSE28yctufl/fbAePmz67mQg/ioaUb+mOFn1CjGIKBepd0689ofOhlXB4PtTXRvSiuI63uDFY
	cVcsQcPg3E74FTeNLANtUtQNQyWQ54D9E3qLzSuD+mHNIlpmCP5GnolAsEyCWFMTUHKpxKVcFMd
	ZwL7SEwayhkEbyZhXrDdgK4j1t/WQmFgCywIPD+I651icBUv8gkpji+0rJbhkzJKau0stuSKhrG
	SdYBeUBV3LDDmAs1845Ng9usasvkcidy0OqeapFFKS4JyUzgZTpTS07ouX0RqtorKcnqC094KZJ
	4qgEX+Ovr23lV9H/w5uUyTAfZxg/uD4C5XQZz1NlS3MolQSf2PzgeraJuW9j17q1xEPiJE/eIRv
	SuvN/cCfHaEzjqNsbzpi5tMQeTOJXUt2cyzIyOFZJqnK1RamjpDo4N999D3hppbBUYWG6F9HKwd
	MFc7JkqfRgSxLILZX3kbN0KIkANsFPuzJLxYFBQKL3itFjmHRmJP3VWInK7J0wh18DxGAv53pdr
	QXBvGVR1nQudusXwqnVxutRbiIkoA3WHo4nCUjw+xMToNAGsRFdD6HxCuNGuqnnOzuqVjxhtqBP
	b+tcLZRUV8fsB7e+bhuvnl864sX7l1NMN93kd
X-Received: by 2002:a05:6512:6687:10b0:5c1:4ede:6fc8 with SMTP id 2adb3069b0e04-5c14ede7134mr360610e87.45.1794216205921;
        Mon, 09 Nov 2026 01:23:25 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b81d189sm744405e87.69.2026.11.09.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:23:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Edwin Gatier <edwin.gatier@protonmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.3.y] media: uvcvideo: Force UVC version for Avermedia GC515
Date: Mon,  9 Nov 2026 09:23:21 +0000
Message-ID: <20261109092321.2282542-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261107050357-failed-7.3-65444446f0c5@kernel.org>
References: <20261107050357-failed-7.3-65444446f0c5@kernel.org>
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
index 30adde5a8bc9..73b97ec578ec 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2851,6 +2851,17 @@ static const struct usb_device_id uvc_ids[] = {
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

