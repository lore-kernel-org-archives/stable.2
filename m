Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547B4E36E5;
	Mon, 19 Oct 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408916; cv=none; b=Ov1pVeof/w26dSgaFy4M3Qy4/waHD/6Hne8f9RU5tRp2iZgmwbv1XiYyIQhpn4F8WLtTVG6AFMMND5Uwy3kCRKxeQxyc08/u+qe3so2QOHlDbb6CxAlXH+SsJB72Z4nxDsJ5Bxt6MJwedhJ6kv9z01eUl3fF9c4OnvY76bpYYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408916; c=relaxed/simple;
	bh=UlHVilldh8KYJX6Se4ACfuP9AZy8D0Uj8w+EngiYuwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWh11zDNf2JoIK8ExSaXXO7qF7kg4sTG/SbN0onAmDPY+VM5KEuf9OIqLPCaw5ZLoBgWQCmq0aeQAHJ094zB3MpNpcdePe7C+R8UJ0+XwHjGbmD1rEQnPvUwQhptylydPOfdXuhEyWl7zzjK8MfNuF5+Q7uitlUIFQn8xBh8fTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iROhSUUQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iROhSUUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42FE1F000C4;
	Mon, 19 Oct 2026 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792408913;
	bh=aBPKlEK5/XB126JBMD2PPjXRaYHyrK0ifen/+JlaCjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iROhSUUQ0Kdwc0i8zRcERNGPF7VLFMutLg1IWWyE/1zC/fru3FxDeOlRfrb2iMXXg
	 G6r258EBfC/mOr+nYkBQwFWZr2HpECqJ57LlRmHot3hNcD7TpeG30UcD/zZhnTjCQB
	 2iOevrMGiBzuNVJ3UFQShmwPtpo5dJ1UNSDS9pA5+o0frwjgYOuKs64UoUyOWd65Jr
	 TOuodR/z/f5PVSH8+p5LRvZjLu+ZS48vUcSXMYucYkXEf3m1Y25eruueZ2D1GSnIgZ
	 BYdr2ed/+/mRlwpt0l5bHe0Aizbq2qAmYZuWRpUOCaI84ji5BUz8ynZqEDrhaNyywh
	 bECj35MYKGwDg==
Message-ID: <449eb143-37a8-4044-a071-63fe495c0213@kernel.org>
Date: Mon, 19 Oct 2026 13:21:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE for
 SVBONY SV105C
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, ostashow@gmail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261019-sv105c-retry-set-interface-v1-1-ab2f08bc3fcb@gmail.com>
 <20261019111712.GP595565@killaraus.ideasonboard.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261019111712.GP595565@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19-Oct-26 1:17 PM, Laurent Pinchart wrote:
> On Mon, Oct 19, 2026 at 02:07:28PM +0300, Ostashow Constantine via B4 Relay wrote:
>> From: Ostashow Constantine <ostashow@gmail.com>
>>
>> The SVBONY SV105C (0c45:636b, Sonix based) fails most SET_INTERFACE
>> requests that select a streaming alternate setting right after a
>> VS_COMMIT control. The request completes with -EPROTO, so
>> VIDIOC_STREAMON fails and capture applications see the camera
>> randomly failing to start.
>>
>> A usbmon capture of a failing VIDIOC_STREAMON:
>>
>>   S Co:1:003:0 s 21 01 0200 0001 001a 26 = 01000104 15160500 ...
>>   C Co:1:003:0 0 26 >
>>   S Co:1:003:0 s 01 0b 0004 0001 0000 0
>>   C Co:1:003:0 -71 0
>>   S Co:1:003:0 s 01 0b 0000 0001 0000 0
>>   C Co:1:003:0 0 0
>>
>> The failure rate is around 80% and does not depend on the alternate
>> setting (alt 1, the smallest one with 128 bytes per microframe, fails
>> as often as alt 6), on a delay between VS_COMMIT and SET_INTERFACE
>> (0 to 100 ms tested), or on USB autosuspend. SET_INTERFACE without a
>> preceding VS_COMMIT succeeded 15 out of 15 times, and an immediate
>> retry after the -EPROTO failure succeeded 15 out of 15 times. Once
>> streaming has started, the camera works reliably. It also works with
>> the Windows UVC driver.
> 
> What does Windows do differently then ?

I guess Windows always has a short-delay of at least one USB frame-time
between the VS_COMMIT and SET_INTERFACE. I think we should simply add
a flseep(1000) before the set_interface instead of adding a quirk for
this.

Regards,

Hans



> 
>> Add a UVC_QUIRK_RETRY_SET_INTERFACE quirk that retries SET_INTERFACE
>> up to three times when it fails with -EPROTO, and enable it for the
>> SV105C. With the quirk, 35 out of 35 stream starts succeeded, 29 of
>> them needed a retry, and no start needed more than one.
>>
>> lsusb -v:
>>
>> Bus 001 Device 003: ID 0c45:636b Microdia SVBONY SV105C
>> Negotiated speed: High Speed (480Mbps)
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               2.01
>>   bDeviceClass          239 Miscellaneous Device
>>   bDeviceSubClass         2 [unknown]
>>   bDeviceProtocol         1 Interface Association
>>   bMaxPacketSize0        64
>>   idVendor           0x0c45 Microdia
>>   idProduct          0x636b SVBONY SV105C
>>   bcdDevice            1.00
>>   iManufacturer           2 Sonix Technology Co., Ltd.
>>   iProduct                1 SVBONY SV105C
>>   iSerial                 3 SN0001
>>   bNumConfigurations      1
>>   Configuration Descriptor:
>>     bLength                 9
>>     bDescriptorType         2
>>     wTotalLength       0x032e
>>     bNumInterfaces          2
>>     bConfigurationValue     1
>>     iConfiguration          0
>>     bmAttributes         0x80
>>       (Bus Powered)
>>     MaxPower              500mA
>>     Interface Association:
>>       bLength                 8
>>       bDescriptorType        11
>>       bFirstInterface         0
>>       bInterfaceCount         2
>>       bFunctionClass         14 Video
>>       bFunctionSubClass       3 Video Interface Collection
>>       bFunctionProtocol       0
>>       iFunction               5
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        0
>>       bAlternateSetting       0
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      1 Video Control
>>       bInterfaceProtocol      0
>>       iInterface              5
>>       VideoControl Interface Descriptor:
>>         bLength                13
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (HEADER)
>>         bcdUVC               1.00
>>         wTotalLength       0x0050
>>         dwClockFrequency       15.000000MHz
>>         bInCollection           1
>>         baInterfaceNr( 0)       1
>>       VideoControl Interface Descriptor:
>>         bLength                 9
>>         bDescriptorType        36
>>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>>         bTerminalID             4
>>         wTerminalType      0x0101 USB Streaming
>>         bAssocTerminal          0
>>         bSourceID               3
>>         iTerminal               0
>>       VideoControl Interface Descriptor:
>>         bLength                29
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (EXTENSION_UNIT)
>>         bUnitID                 3
>>         guidExtensionCode         {28f03370-6311-4a2e-ba2c-6890eb334016}
>>         bNumControls           32
>>         bNrInPins               1
>>         baSourceID( 0)          2
>>         bControlSize            4
>>         bmControls( 0)       0x9f
>>         bmControls( 1)       0x07
>>         bmControls( 2)       0x07
>>         bmControls( 3)       0x07
>>         iExtension              0
>>       VideoControl Interface Descriptor:
>>         bLength                18
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>>         bTerminalID             1
>>         wTerminalType      0x0201 Camera Sensor
>>         bAssocTerminal          0
>>         iTerminal               0
>>         wObjectiveFocalLengthMin      0
>>         wObjectiveFocalLengthMax      0
>>         wOcularFocalLength            0
>>         bControlSize                  3
>>         bmControls           0x0000000e
>>           Auto-Exposure Mode
>>           Auto-Exposure Priority
>>           Exposure Time (Absolute)
>>       VideoControl Interface Descriptor:
>>         bLength                11
>>         bDescriptorType        36
>>         bDescriptorSubtype      5 (PROCESSING_UNIT)
>>       Warning: Descriptor too short
>>         bUnitID                 2
>>         bSourceID               1
>>         wMaxMultiplier          0
>>         bControlSize            2
>>         bmControls     0x0000177f
>>           Brightness
>>           Contrast
>>           Hue
>>           Saturation
>>           Sharpness
>>           Gamma
>>           White Balance Temperature
>>           Backlight Compensation
>>           Gain
>>           Power Line Frequency
>>           White Balance Temperature, Auto
>>         iProcessing             0
>>         bmVideoStandards     0x31
>>           None
>>           NTSC - 625/50
>>           PAL - 525/60
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x83  EP 3 IN
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0010  1x 16 bytes
>>         bInterval               6
>>         VideoControl Endpoint Descriptor:
>>           bLength                 5
>>           bDescriptorType        37
>>           bDescriptorSubtype      3 (EP_INTERRUPT)
>>           wMaxTransferSize      128
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       VideoStreaming Interface Descriptor:
>>         bLength                            15
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  1 (INPUT_HEADER)
>>         bNumFormats                         2
>>         wTotalLength                   0x024f
>>         bEndpointAddress                 0x81  EP 1 IN
>>         bmInfo                              0
>>         bTerminalLink                       4
>>         bStillCaptureMethod                 2
>>         bTriggerSupport                     1
>>         bTriggerUsage                       1
>>         bControlSize                        1
>>         bmaControls( 0)                     0
>>         bmaControls( 1)                     0
>>       VideoStreaming Interface Descriptor:
>>         bLength                            11
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  6 (FORMAT_MJPEG)
>>         bFormatIndex                        1
>>         bNumFrameDescriptors                8
>>         bFlags                              0
>>           Fixed-size samples: No
>>         bDefaultFrameIndex                  1
>>         bAspectRatioX                       0
>>         bAspectRatioY                       0
>>         bmInterlaceFlags                 0x00
>>           Interlaced stream or variable: No
>>           Fields per frame: 1 fields
>>           Field 1 first: No
>>           Field pattern: Field 1 only
>>         bCopyProtect                        0
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         1
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1920
>>         wHeight                          1080
>>         dwMinBitRate                995328000
>>         dwMaxBitRate                995328000
>>         dwMaxVideoFrameBufferSize     4147789
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         2
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1280
>>         wHeight                          1024
>>         dwMinBitRate                629145600
>>         dwMaxBitRate                629145600
>>         dwMaxVideoFrameBufferSize     2622029
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         3
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1280
>>         wHeight                           960
>>         dwMinBitRate                589824000
>>         dwMaxBitRate                589824000
>>         dwMaxVideoFrameBufferSize     2458189
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         4
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1280
>>         wHeight                           720
>>         dwMinBitRate                442368000
>>         dwMaxBitRate                442368000
>>         dwMaxVideoFrameBufferSize     1843789
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         5
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                            800
>>         wHeight                           600
>>         dwMinBitRate                230400000
>>         dwMaxBitRate                230400000
>>         dwMaxVideoFrameBufferSize      960589
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         6
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                            640
>>         wHeight                           480
>>         dwMinBitRate                147456000
>>         dwMaxBitRate                147456000
>>         dwMaxVideoFrameBufferSize      614989
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         7
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                            480
>>         wHeight                           640
>>         dwMinBitRate                147456000
>>         dwMaxBitRate                147456000
>>         dwMaxVideoFrameBufferSize      614989
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>>         bFrameIndex                         8
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1920
>>         wHeight                          1080
>>         dwMinBitRate                995328000
>>         dwMaxBitRate                995328000
>>         dwMaxVideoFrameBufferSize     4147789
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            34
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
>>         bEndpointAddress                 0x00  EP 0 OUT
>>         bNumImageSizePatterns               7
>>         wWidth( 0)                       1920
>>         wHeight( 0)                      1080
>>         wWidth( 1)                       1280
>>         wHeight( 1)                       720
>>         wWidth( 2)                        800
>>         wHeight( 2)                       600
>>         wWidth( 3)                        640
>>         wHeight( 3)                       480
>>         wWidth( 4)                        640
>>         wHeight( 4)                       360
>>         wWidth( 5)                        320
>>         wHeight( 5)                       240
>>         wWidth( 6)                        320
>>         wHeight( 6)                       180
>>         bNumCompressionPatterns             0
>>       VideoStreaming Interface Descriptor:
>>         bLength                            27
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
>>         bFormatIndex                        2
>>         bNumFrameDescriptors                8
>>         guidFormat                            {32595559-0000-0010-8000-00aa00389b71}
>>         bBitsPerPixel                      16
>>         bDefaultFrameIndex                  1
>>         bAspectRatioX                       0
>>         bAspectRatioY                       0
>>         bmInterlaceFlags                 0x00
>>           Interlaced stream or variable: No
>>           Fields per frame: 2 fields
>>           Field 1 first: No
>>           Field pattern: Field 1 only
>>         bCopyProtect                        0
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         1
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1920
>>         wHeight                          1080
>>         dwMinBitRate                165888000
>>         dwMaxBitRate                165888000
>>         dwMaxVideoFrameBufferSize     4147200
>>         dwDefaultFrameInterval        2000000
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)           2000000
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         2
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1280
>>         wHeight                          1024
>>         dwMinBitRate                104857600
>>         dwMaxBitRate                104857600
>>         dwMaxVideoFrameBufferSize     2621440
>>         dwDefaultFrameInterval        2000000
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)           2000000
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         3
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1280
>>         wHeight                           960
>>         dwMinBitRate                 98304000
>>         dwMaxBitRate                 98304000
>>         dwMaxVideoFrameBufferSize     2457600
>>         dwDefaultFrameInterval        2000000
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)           2000000
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         4
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1280
>>         wHeight                           720
>>         dwMinBitRate                147456000
>>         dwMaxBitRate                147456000
>>         dwMaxVideoFrameBufferSize     1843200
>>         dwDefaultFrameInterval        1000000
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)           1000000
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         5
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                            800
>>         wHeight                           600
>>         dwMinBitRate                153600000
>>         dwMaxBitRate                153600000
>>         dwMaxVideoFrameBufferSize      960000
>>         dwDefaultFrameInterval         500000
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            500000
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         6
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                            640
>>         wHeight                           480
>>         dwMinBitRate                147456000
>>         dwMaxBitRate                147456000
>>         dwMaxVideoFrameBufferSize      614400
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         7
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                            480
>>         wHeight                           640
>>         dwMinBitRate                147456000
>>         dwMaxBitRate                147456000
>>         dwMaxVideoFrameBufferSize      614400
>>         dwDefaultFrameInterval         333333
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)            333333
>>       VideoStreaming Interface Descriptor:
>>         bLength                            30
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>>         bFrameIndex                         8
>>         bmCapabilities                   0x00
>>           Still image unsupported
>>         wWidth                           1920
>>         wHeight                          1080
>>         dwMinBitRate                165888000
>>         dwMaxBitRate                165888000
>>         dwMaxVideoFrameBufferSize     4147200
>>         dwDefaultFrameInterval        2000000
>>         bFrameIntervalType                  1
>>         dwFrameInterval( 0)           2000000
>>       VideoStreaming Interface Descriptor:
>>         bLength                            18
>>         bDescriptorType                    36
>>         bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
>>         bEndpointAddress                 0x00  EP 0 OUT
>>         bNumImageSizePatterns               3
>>         wWidth( 0)                       1920
>>         wHeight( 0)                      1080
>>         wWidth( 1)                       1280
>>         wHeight( 1)                       720
>>         wWidth( 2)                        640
>>         wHeight( 2)                       480
>>         bNumCompressionPatterns             0
>>       VideoStreaming Interface Descriptor:
>>         bLength                             6
>>         bDescriptorType                    36
>>         bDescriptorSubtype                 13 (COLORFORMAT)
>>         bColorPrimaries                     1 (BT.709,sRGB)
>>         bTransferCharacteristics            1 (BT.709)
>>         bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x0080  1x 128 bytes
>>         bInterval               1
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       2
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x0100  1x 256 bytes
>>         bInterval               1
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       3
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x0320  1x 800 bytes
>>         bInterval               1
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       4
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x0b20  2x 800 bytes
>>         bInterval               1
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       5
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x1320  3x 800 bytes
>>         bInterval               1
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       6
>>       bNumEndpoints           1
>>       bInterfaceClass        14 Video
>>       bInterfaceSubClass      2 Video Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x1400  3x 1024 bytes
>>         bInterval               1
>>
>> Cc: stable@vger.kernel.org
>> Assisted-by: claude-opus-5-5
>> Signed-off-by: Ostashow Constantine <ostashow@gmail.com>
>> ---
>> Notes for reviewers (not part of the commit message):
>>
>> Testing:
>> - Runtime-tested on a Raspberry Pi 4 (VL805 xHCI) running 6.18.57, with
>>   this patch applied to the 6.18.57 uvcvideo sources (it applies with
>>   line offsets only). Results are in the commit message. Before the
>>   patch, 3/20 and 5/20 stream starts succeeded.
>> - Built with W=1 without new warnings: as part of the 6.18.57 module,
>>   and the patched media/next sources against 6.18 headers plus the
>>   media/next include/linux/usb/uvc.h.
>> - Not runtime-tested on media/next itself, and not tested on other host
>>   controllers (e.g. x86 xHCI). I can't tell whether the failure depends
>>   on the host controller.
>>
>> Tool disclosure (Documentation/process/generated-content.rst):
>> The root-cause analysis (usbmon capture, libusb experiments varying the
>> alternate setting, the delay after VS_COMMIT and retries), the patch and
>> this changelog were produced by an AI coding assistant (Claude Code,
>> claude-opus-5-5) in an interactive session, at my request, on my
>> hardware. I have reviewed the patch and take responsibility for it.
>> ---
>>  drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
>>  drivers/media/usb/uvc/uvc_video.c  | 14 ++++++++++++++
>>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
>> index cbc145697..9e1f855cd 100644
>> --- a/drivers/media/usb/uvc/uvc_driver.c
>> +++ b/drivers/media/usb/uvc/uvc_driver.c
>> @@ -2928,6 +2928,15 @@ static const struct usb_device_id uvc_ids[] = {
>>  	  .bInterfaceSubClass	= 1,
>>  	  .bInterfaceProtocol	= 0,
>>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF) },
>> +	/* SVBONY SV105C */
>> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>> +				| USB_DEVICE_ID_MATCH_INT_INFO,
>> +	  .idVendor		= 0x0c45,
>> +	  .idProduct		= 0x636b,
>> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
>> +	  .bInterfaceSubClass	= 1,
>> +	  .bInterfaceProtocol	= 0,
>> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RETRY_SET_INTERFACE) },
>>  	/* MT6227 */
>>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
>> index a92a986ab..3a3b1d1d7 100644
>> --- a/drivers/media/usb/uvc/uvc_video.c
>> +++ b/drivers/media/usb/uvc/uvc_video.c
>> @@ -2100,6 +2100,20 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
>>  		}
>>  
>>  		ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
>> +
>> +		/*
>> +		 * Some devices, namely the SVBONY SV105C, fail most of the
>> +		 * SET_INTERFACE requests that follow a VS_COMMIT control with
>> +		 * a protocol error. Retrying the request immediately succeeds.
>> +		 */
>> +		for (i = 0; ret == -EPROTO && i < 3 &&
>> +		     (stream->dev->quirks & UVC_QUIRK_RETRY_SET_INTERFACE); ++i) {
>> +			uvc_dbg(stream->dev, VIDEO,
>> +				"SET_INTERFACE failed (%d), retrying\n", ret);
>> +			ret = usb_set_interface(stream->dev->udev, intfnum,
>> +						altsetting);
>> +		}
>> +
>>  		if (ret < 0)
>>  			return ret;
>>  
>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
>> index af8cef94f..19851c3d2 100644
>> --- a/drivers/media/usb/uvc/uvcvideo.h
>> +++ b/drivers/media/usb/uvc/uvcvideo.h
>> @@ -81,6 +81,7 @@
>>  #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
>>  #define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
>>  #define UVC_QUIRK_MSXU_META		0x00040000
>> +#define UVC_QUIRK_RETRY_SET_INTERFACE	0x00080000
>>  
>>  /* Format flags */
>>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
>>
>> ---
>> base-commit: d7e7bca7169873b46e857c025c10f3336c1258d8
>> change-id: 20261019-sv105c-retry-set-interface-759a92a1e7b5
> 

