Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242394;
	b=dcfvoI5BUP43QFM0GTTE1iSheHJzq3ODFkdNRg1E8grF0/MhSLtafzGqUAGzXpUTHJiD
	 UPm6Dvzwwc3ogpRZS89JvhbM6evj92sWFCqUNRQpuSyeYswf7sAlmZhcNenJP0++e+Xb6
	 cAFTASrTciX+rvyWdIW7eGAIshw1hFQh1uuWv8vPE+mMg+l0g7vSHT8amiuMGPfuPtx6m
	 2bwpj0nsVqmQH6DfH15Jc0NSNsjNedx7n+hW9HYhuYeeD138/A4Xc7LVjfvXXhdMG6TZb
	 9edaZpjc/iO7JVdSsjY4YyK8KSbiStTEswCSICYXPAzQYt8nkBF+LePH0X+7W/eAmhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4wxnfdpSUTEWbf5N5FfVvIOuI1p+o2nIr53eHqMZxnE=;
	b=M/08x5FX4jvQq1f4TE/N3PtIO+cIJlyAyKR+D4svsSzKZM6fBJd15CKLpgWJHWIJJxAS
	 GRpUwy5JmzmbehfJj93f+3cutYuQsARi3ZGD5sM5JuWkejOwdYM9in0jErLYHTyRAIynY
	 J0sIoff0eG723auXT3Typ/o5dTXG5cZycUtXk5owvJudyNkkC5ECNEkq0mkfhjtf7sYlx
	 +Bo9V2xpHA8HnzPx3Dhs0PP4xmajPMOvMIbDAekZntgf4Samz1k5LKF3hT39g8W2atwc2
	 lVvRpMjVrtDMgEDs4/OKg9qeprcpm0uEThagohCE0BnQsEHmYAHE7Q3NCkTh0H6Cwng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MDzoIbkq;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA83606AAC8
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA83606AAC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MDzoIbkq
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso1268655e87.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794242392; x=1794847192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wxnfdpSUTEWbf5N5FfVvIOuI1p+o2nIr53eHqMZxnE=;
        b=MDzoIbkqECn5KPxncXI50clXKu/apQayPH0nibzPkWi5OEc+0p/vMCLuYKDyB5KPpu
         V0o1t9fj830HesMmil/MeRlY123HZzbVozLHKAl470tSYEiavor8/a3uUin17JV3IOBi
         nV50H5h/6xs46/XF/56XSCWtRbFal6oq461kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242392; x=1794847192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wxnfdpSUTEWbf5N5FfVvIOuI1p+o2nIr53eHqMZxnE=;
        b=wQf70V1ahIa+hTLxale0F9RkCZT1q0QffyKwRNukGQeXKW5vqiP8hvOrTaSY/0ehOk
         2GlAdjynoYzRfsWnRrJsBkiOOUEP/2ZkzJIxu6dURdcDHddNpcAhlBz5P8xV+6HD24DM
         YzIube6i1IqaHi7Rgu0wZGlBLj2HKs7nZvNLlsgzcl60WHIGWRJJ/l2hq/Re08m7434j
         QXrTL19LGrDSpU8PGCyOc6XSRB3fbN1wsqnCe6APgrxdEpZ5HiNjOUhk13a17SCR7hwu
         ukPAnCJIzCxTZtv8GIOnpkI+OoGQqqFmy0JeJaEEYfNA5NVfSlp3EgBRVbjOBBphnjpo
         Qc1w==
X-Gm-Message-State: APuU4Z8VdfBj4VPgk/I19oKMaHqNDiQCbSYxbe5j1SpFPQh4RhUAD/3m
	4NY2vPSWohWfv+5rp2+VFEsJZ+BRpz4KMZN8JFqU+ZUHb3WiAsTmw2MjeDILs4NORKucuL3djNU
	Bw09wfw8n
X-Gm-Gg: AYBFou3Z0xYy0SeQiQOn8548vw+CqL3e/YfgEf/awAaz58hFObD5XO1HTgGhw3gFPEo
	W9vrvIPEUhdwrTGzXPRlmJn208IkgeBdvoLK2D/qUlzBPuxfOq0Rs3CpKMNB0OZSx2uQXhllx7M
	5zmY32p+O7S1s4dgFiBTfLZMCcptZWY0K36kL45AfTUs61d11xHMjAVT8nKiUi1bvI6QDwk/pTx
	OnZf6Nvo52VwqkHCp4nVshU3WqCywP2vStdZuAuvV+q6uFe0Yl8sV8wynQV/AEdl7XlTfv3IndA
	kzhzo0zRWKjvsjGmRF8IOr66XynRmSumxy5z6yNPMMgi6xT23+xxyoBFDIo+Y40lm8Eu88xUpFg
	VZsY9zR4ijoLCe3zVc75OZMAzU1R0GGhjk6Q6Px9Gn3pCRFFWgF5FiS0IZoc3SVsGxGLvHsGa6Z
	COcgsg6bnkB+NpakzXHGxF7pKdyb3b9RAOCHb0LurmzyhQokbNXBs1NBJDDmbAURTaHp1p+643o
	joIVxOSpBzxRkPh5+bPFyoIpqFZgOdI7YE+bxnrNEyD8z+Zv+tzhRlNLMI/vYGnZ6I/+1/0b71W
	PG9A3rZWzgFMOFd4YD985rlW5MUaonzqtwpQHMEKZ9RZTQAYo5BwOqZzD3NMjK9L37/As9kQvjx
	fYxgQBC/djcK4Jc4=
X-Received: by 2002:a05:6512:128e:b0:5c0:5717:5736 with SMTP id 2adb3069b0e04-5c156d9f0abmr12743e87.10.1794242392596;
        Mon, 09 Nov 2026 08:39:52 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b82384fsm980162e87.72.2026.11.09.08.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:39:50 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH v2 5.10.y 2/4] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 16:39:39 +0000
Message-ID: <20261109163941.1114322-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109163941.1114322-1-ribalda@chromium.org>
References: <20261107061805-failed-5.10-65444446f0c5@kernel.org>
 <20261109163941.1114322-1-ribalda@chromium.org>
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

A user has reported that this device gets stuck in a loop where every
few seconds it will turn off and turn back on, causing audio devices
to disappear and reappear, its LED to flash, spamming dmesg, etc.
This only happens when not in use; everything is fine when the video
device is actually being used.

They also reported that using the AUTOSUSPEND quirk via module parameters
fixes the issue.

Add the device to the quirk list.

ID 07ca:1570 AVerMedia Technologies, Inc. AVerMedia USB Device
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.10
   bDeviceClass          239 Miscellaneous Device
   bDeviceSubClass         2 [unknown]
   bDeviceProtocol         1 Interface Association
   bMaxPacketSize0        64
   idVendor           0x07ca AVerMedia Technologies, Inc.
   idProduct          0x1570 AVerMedia USB Device
   bcdDevice            1.00
   iManufacturer           6 AVerMedia
   iProduct                7 AVerMedia USB Device
   iSerial                 3 53106326013650
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength       0x01d6
     bNumInterfaces          4
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              150mA
     Interface Association:
       bLength                 8
       bDescriptorType        11
       bFirstInterface         0
       bInterfaceCount         2
       bFunctionClass         14 Video
       bFunctionSubClass       3 Video Interface Collection
       bFunctionProtocol       0
       iFunction               8 AVerMedia Live Gamer HD 2
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass        14 Video
       bInterfaceSubClass      1 Video Control
       bInterfaceProtocol      0
       iInterface              8 AVerMedia Live Gamer HD 2
       VideoControl Interface Descriptor:
         bLength                13
         bDescriptorType        36
         bDescriptorSubtype      1 (HEADER)
         bcdUVC               1.00
         wTotalLength       0x004d
         dwClockFrequency      120.000000MHz
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
         bLength                11
         bDescriptorType        36
         bDescriptorSubtype      5 (PROCESSING_UNIT)
       Warning: Descriptor too short
         bUnitID                 3
         bSourceID               1
         wMaxMultiplier          0
         bControlSize            2
         bmControls     0x0000000f
           Brightness
           Contrast
           Hue
           Saturation
         iProcessing             0
         bmVideoStandards     0x09
           None
           SECAM - 625/50
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
         bLength                28
         bDescriptorType        36
         bDescriptorSubtype      6 (EXTENSION_UNIT)
         bUnitID                 4
         guidExtensionCode         {c66d125b-0480-0844-8c26-b8363a84de63}
         bNumControls           17
         bNrInPins               1
         baSourceID( 0)          3
         bControlSize            3
         bmControls( 0)       0x07
         bmControls( 1)       0xfe
         bmControls( 2)       0x01
         iExtension              0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass        14 Video
       bInterfaceSubClass      2 Video Streaming
       bInterfaceProtocol      0
       iInterface              8 AVerMedia Live Gamer HD 2
       VideoStreaming Interface Descriptor:
         bLength                            14
         bDescriptorType                    36
         bDescriptorSubtype                  1 (INPUT_HEADER)
         bNumFormats                         1
         wTotalLength                   0x00bd
         bEndpointAddress                 0x89  EP 9 IN
         bmInfo                              0
         bTerminalLink                       2
         bStillCaptureMethod                 0
         bTriggerSupport                     0
         bTriggerUsage                       0
         bControlSize                        1
         bmaControls( 0)                     0
       VideoStreaming Interface Descriptor:
         bLength                            11
         bDescriptorType                    36
         bDescriptorSubtype                  6 (FORMAT_MJPEG)
         bFormatIndex                        1
         bNumFrameDescriptors                5
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
         bCopyProtect                        0
       VideoStreaming Interface Descriptor:
         bLength                            34
         bDescriptorType                    36
         bDescriptorSubtype                  7 (FRAME_MJPEG)
         bFrameIndex                         1
         bmCapabilities                   0x00
           Still image unsupported
         wWidth                            640
         wHeight                           480
         dwMinBitRate                294617088
         dwMaxBitRate                294912000
         dwMaxVideoFrameBufferSize      614400
         dwDefaultFrameInterval         166833
         bFrameIntervalType                  2
         dwFrameInterval( 0)            166666
         dwFrameInterval( 1)            166833
       VideoStreaming Interface Descriptor:
         bLength                            34
         bDescriptorType                    36
         bDescriptorSubtype                  7 (FRAME_MJPEG)
         bFrameIndex                         2
         bmCapabilities                   0x00
           Still image unsupported
         wWidth                            720
         wHeight                           480
         dwMinBitRate                331444224
         dwMaxBitRate                331776000
         dwMaxVideoFrameBufferSize      691200
         dwDefaultFrameInterval         166833
         bFrameIntervalType                  2
         dwFrameInterval( 0)            166666
         dwFrameInterval( 1)            166833
       VideoStreaming Interface Descriptor:
         bLength                            30
         bDescriptorType                    36
         bDescriptorSubtype                  7 (FRAME_MJPEG)
         bFrameIndex                         3
         bmCapabilities                   0x00
           Still image unsupported
         wWidth                            720
         wHeight                           576
         dwMinBitRate                331776000
         dwMaxBitRate                331776000
         dwMaxVideoFrameBufferSize      829440
         dwDefaultFrameInterval         200000
         bFrameIntervalType                  1
         dwFrameInterval( 0)            200000
       VideoStreaming Interface Descriptor:
         bLength                            38
         bDescriptorType                    36
         bDescriptorSubtype                  7 (FRAME_MJPEG)
         bFrameIndex                         4
         bmCapabilities                   0x00
           Still image unsupported
         wWidth                           1280
         wHeight                           720
         dwMinBitRate                737280000
         dwMaxBitRate                884736000
         dwMaxVideoFrameBufferSize     1843200
         dwDefaultFrameInterval         166666
         bFrameIntervalType                  3
         dwFrameInterval( 0)            166666
         dwFrameInterval( 1)            166833
         dwFrameInterval( 2)            200000
       VideoStreaming Interface Descriptor:
         bLength                            46
         bDescriptorType                    36
         bDescriptorSubtype                  7 (FRAME_MJPEG)
         bFrameIndex                         5
         bmCapabilities                   0x00
           Still image unsupported
         wWidth                           1920
         wHeight                          1080
         dwMinBitRate                994332672
         dwMaxBitRate                1990656000
         dwMaxVideoFrameBufferSize     4147200
         dwDefaultFrameInterval         166666
         bFrameIntervalType                  5
         dwFrameInterval( 0)            166666
         dwFrameInterval( 1)            166833
         dwFrameInterval( 2)            200000
         dwFrameInterval( 3)            333333
         dwFrameInterval( 4)            333667
       VideoStreaming Interface Descriptor:
         bLength                             6
         bDescriptorType                    36
         bDescriptorSubtype                 13 (COLORFORMAT)
         bColorPrimaries                     1 (BT.709,sRGB)
         bTransferCharacteristics            1 (BT.709)
         bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass        14 Video
       bInterfaceSubClass      2 Video Streaming
       bInterfaceProtocol      0
       iInterface              8 AVerMedia Live Gamer HD 2
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x89  EP 9 IN
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x1400  3x 1024 bytes
         bInterval               1
     Interface Association:
       bLength                 8
       bDescriptorType        11
       bFirstInterface         2
       bInterfaceCount         2
       bFunctionClass          1 Audio
       bFunctionSubClass       2 Streaming
       bFunctionProtocol       0
       iFunction               9 AVerMedia Live Gamer HD 2
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass         1 Audio
       bInterfaceSubClass      1 Control Device
       bInterfaceProtocol      0
       iInterface              9 AVerMedia Live Gamer HD 2
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      1 (HEADER)
         bcdADC               1.00
         wTotalLength       0x003a
         bInCollection           1
         baInterfaceNr(0)        3
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             1
         wTerminalType      0x0602 Digital Audio Interface
         bAssocTerminal          0
         bNrChannels             1
         wChannelConfig     0x0000
         iChannelNames           0
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             5
         wTerminalType      0x0603 Line Connector
         bAssocTerminal          0
         bNrChannels             1
         wChannelConfig     0x0000
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
         bSourceID               4
         bControlSize            1
         bmaControls(0)       0x01
           Mute Control
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                 8
         bDescriptorType        36
         bDescriptorSubtype      5 (SELECTOR_UNIT)
         bUnitID                 4
         bNrInPins               2
         baSourceID(0)           1
         baSourceID(1)           5
         iSelector               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              9 AVerMedia Live Gamer HD 2
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              9 AVerMedia Live Gamer HD 2
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
         bEndpointAddress     0x8a  EP 10 IN
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x00c0  1x 192 bytes
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
Binary Object Store Descriptor:
   bLength                 5
   bDescriptorType        15
   wTotalLength       0x0016
   bNumDeviceCaps          2
   USB 2.0 Extension Device Capability:
     bLength                 7
     bDescriptorType        16
     bDevCapabilityType      2
     bmAttributes   0x00000006
       BESL Link Power Management (LPM) Supported
   SuperSpeed USB Device Capability:
     bLength                10
     bDescriptorType        16
     bDevCapabilityType      3
     bmAttributes         0x00
     wSpeedsSupported   0x000e
       Device can operate at Full Speed (12Mbps)
       Device can operate at High Speed (480Mbps)
       Device can operate at SuperSpeed (5Gbps)
     bFunctionalitySupport   1
       Lowest fully-functional device speed is Full Speed (12Mbps)
     bU1DevExitLat           4 micro seconds
     bU2DevExitLat           4 micro seconds
Device Status:     0x0000
   (Bus Powered)

Reported-by: Sean Baggaley <me@drinkybird.net>
Closes: https://lore.kernel.org/linux-media/5ef59031-0853-41a7-8d11-c345fe535daf@drinkybird.net/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://patch.msgid.link/20260730-uvc-avermedia-v1-1-7272dd394d83@chromium.org
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
(cherry picked from commit b79251c881bb39f70c6f6fb30ad5d454b78c9f4a)
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e2dab556ec99..663f07f9ca01 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2787,6 +2787,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
+	/* AVerMedia Live Gamer HD 2 capture card */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x07ca,
+	  .idProduct		= 0x1570,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
 	/* ViMicro Vega */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.56.0.506.g506a7eabc5-goog

