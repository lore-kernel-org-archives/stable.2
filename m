Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379161;
	b=InOscnuCC0rj65vvn9pxLGux9xk7mA3r5rxa4C32mJHizXIw86Pow0xz5HqQfBT6QTGx
	 gK+J6ESG0I+at+fQZMHbgN5RTEGbIpxHKf1mAnBbEz5xZ2HXaF/nlcQ44gG1hZ3YWceP5
	 Oiz8UYQ+vrg0L1lk5ihUlXUm83Nk3iq5ElABX6nVc1ukVrjoOYqW7HhjeqLSSDHblqOW7
	 EThEaIS8wUV5O1cs6OkN6xk48iNa5sQHby7zABfaEALKVA+TsfjtCCB9fsZVR4BVpLkey
	 fQWtqEOKbzFz/GmfCnf/655yMPBBM1NgG6wNSxPe8wuh3nwNn4ALbt7aEKmT8G3Xu2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EZG8DW65lYxNMhPsjCMAIqNHtaoCok58c1D0j+yEE9A=;
	b=Deg4R2Rx3uGQ6gWNn46+oEWX84Wz2QqU75puRhf/jx7IBuwelzW2InBq0zgxmxEMThF6
	 wFAFo1/DYF2/Gs/MqZ6OoAlYaj10AXqYxMkxo3JwO7vQPQHN2JZ+izyoQ/acWBJH0bsKT
	 RyK4EoQ2U5YbOuImKUPG9PHILXj9O8ubxQcfOMYPFvTd+Zgf9UgwEG9hmx0gu0sIled5U
	 WjqHeWidoN92mmRIZoQIYcqIIJKouPmYhuVuX/JmpA1lLnRSOWAQJQ10mDrhOlvQOHDen
	 18t3XaxTSHjnCGdhgHC/IWm3+GSkDZ+/BYXP06cNQFreniELqNRKa+jfvUFQeAYrMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zonni.pl;
	spf=fail smtp.mailfrom=zonni.pl;
	dkim=pass header.d=zonni-pl.20260707.gappssmtp.com header.i=@zonni-pl.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=he4gnpWw;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2B606A329
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B2B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonni.pl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zonni.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zonni-pl.20260707.gappssmtp.com header.i=@zonni-pl.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=he4gnpWw
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c40f29667e6so138013966b.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zonni-pl.20260707.gappssmtp.com; s=20260707; t=1793379159; x=1793983959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZG8DW65lYxNMhPsjCMAIqNHtaoCok58c1D0j+yEE9A=;
        b=he4gnpWw1/2oGJqngV1Dhe1ajGr+YVtS+w9ZQJOQywgzFg6AiRL0NdHp92dUbvHLnf
         8K2hZjqJe14PUuICT0ygtcxcVs54oI3AI3pOv8KrHozDUjiWSSEvYnT9pdFZyhKhF5SP
         3q2d5iTwyB77B/rDGS+Xq3ULDAYAAr5FhqayeLf+M2+3UIqyaaSI6W0SFmp3xCMHxnGW
         ViY9DaCSCsF4T5c5ssrQ21WampV00rwe0cSB/ck95Fs/c5S6TMa66K4C7Qe11dpxTx0k
         L8fRpaTkD38tcst4Qv2VWH77aiwQy4NhMphoT5E5KZGIyPsqi7USCUVy2BgDLh3e1FZ8
         FaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379159; x=1793983959;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZG8DW65lYxNMhPsjCMAIqNHtaoCok58c1D0j+yEE9A=;
        b=kKCs0MQlBbYKOnE+aIl5jD2kvU/za9z3Oz9iRBtw4MHiip0hfYHo0Qc5qt5zMc1ZrH
         RWHrBSVtRNTLsO1o17nIvBj2/iPq9OtipHmMzaSrKpSJo3gSbTjGocNb2Bwfk6bdxumI
         a9FeVzN4j6oc8eoh+ABZnewnLDp7aBMpjC6pBAOYgFqR7VFKzAhwfzSEkZ32fedSYVb1
         UFWcV/q1XBXGbC/s8nrTy/1CYd+TxAC3528qBBjPUP0SnuveVP9evUAiIAndqBI6H7ld
         TSGZ/HmzrePwhOFDqO+F0I3bOK/tPyPG7v+5YKzmor//OD8JuY28Rn6Li5/OLyqu3gXZ
         C/1g==
X-Forwarded-Encrypted: i=1; AKwUvBxrDR/1F9VP1nMvi5SHD08Tn648MWGCSGFW8LfcqfiK+yWd4ap9IlBpKdjSerZIgVXDQjuPOuY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBiin9SNEfTZfzRNIM2pgc4xu8ijyIphHXkULwIuw7dPwTRmV1
	rTwcQ0ngHZU0samACNFcuzG0AYwSjnFjBHpSJw+DiZgYxoVALdNzhCCBsg/HFMw4Qpc=
X-Gm-Gg: AYBFou2b/o0dtmcluGxcLtqOpeOXpMa8nhpzNJ4AIZelJIP6X5vC//Gp2JSfD1hf1jJ
	rjxNEpRQB0JFYxsdui+C5bGuwrqwsh6mxykA6ZkCrAaDTsSFeay4+6tD0k6ZZPN6OcVfGho7ENG
	iyV8Zs0Nz1VjutwcROIbz0weG4mfXNHsmLzZI8r6iar+oRm8dukD8gYnpQA0wARdhxphl7JSO6Z
	l/7zhojHiCXdirve5MK2OIV3yWOmBEDWBhoOnPr9ZOSTx1ck/XtY7BbHmTlVD9owYUaY5uqbXKo
	QgGTSO82vdAzo3IgzPo4Q6RWhRZcxVf5AsPx8njpeA1eCbbJlhUWB78pYyJ9rz2FfHUpmj55cKU
	YXvcdeqSlilgvu41IvJULhEjdXoQOTIIHZ35q0w1E7DY3/LFY6ksb+RwZm2wj2/DwUSCpcyWItU
	6oMmriAbvr6Y0/EUr/EIxW24HezE+qZW4Os88tqTaKKDexHhb2SHl/RKXjdUNDIFjFqH2BUrHfQ
	nlykHYg1lcuwPliJ87EaQFVyD4gBHFZnQKTL/G+7QtUopNxP+erKvYhb5jlbTyRMV7JMCIIzdc3
	neQ4L3Vq0r5UK2CLXNb4AZrEQjDiRcRG6XXrVts=
X-Received: by 2002:a17:907:d40c:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c4ca7a4087fmr238307766b.24.1793379158505;
        Fri, 30 Oct 2026 09:52:38 -0700 (PDT)
Received: from [10.0.1.50] ([89.228.212.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfdc3csm88828566b.17.2026.10.30.09.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:52:38 -0700 (PDT)
Message-ID: <361defcf-9268-40d2-a0ac-eebd51d5da10@zonni.pl>
Date: Fri, 30 Oct 2026 17:52:37 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] usb: pci-quirks: always assert xHCI OS ownership
To: Rishabh Jain <rishabh.jain1198@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mario Limonciello <superm1@kernel.org>, Michal Pecio
 <michal.pecio@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902052631.75c6068b.michal.pecio@gmail.com>
 <178832755831.50581.1058201741431375556@gmail.com>
Content-Language: en-US
From: Maciej Zonski <me@zonni.pl>
In-Reply-To: <178832755831.50581.1058201741431375556@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I tested v5 of this patch on an ASUS ROG STRIX X870-I GAMING WIFI
(AMD 800 series chipset). It fixes the failed xHCI state restore on S3
resume and no USB device is reset any more.

Tested-by: Maciej Zonski <me@zonni.pl>

Hardware
--------
  Board:   ASUS ROG STRIX X870-I GAMING WIFI, BIOS 1805 (09/18/2026)
  CPU:     AMD Ryzen 9 9950X3D
  Sleep:   S3 ("deep"); /sys/power/mem_sleep is "s2idle [deep]"

  6f:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
          800 Series Chipset USB 3.x XHCI Controller [1022:43fc] (rev 01)
          driver: xhci-pci-prom21
          path:   00:02.1 -> 03:00.0 -> 04:0c.0 -> 6f:00.0
                  (behind the chipset PCIe switch)

  Devices on that controller: Intel AX210 Bluetooth (8087:0032), a
  Logitech Logi Bolt receiver (046d:c548), a YubiKey, and several
  HID devices.

  The CPU xHCI controllers (72:00.3, 72:00.4, 73:00.0) and the ASMedia
  ASM4242 controller (6b:00.0) resume fine with and without the patch.
  Only 6f:00.0 is affected.

Kernel
------
  7.2.8 (NixOS, CachyOS flavour, so v7.2.8 plus the CachyOS patch set).
  v5 applied cleanly (drivers/usb/host/pci-quirks.c only).

Before the patch
----------------
Every S3 resume I looked at showed this (shortened):

  xhci-pci-prom21 0000:6f:00.0: xHC error in resume, USBSTS 0x401, Reinit
  usb usb8: root hub lost power or was reset
  usb usb9: root hub lost power or was reset
  usb 8-7: WARN: invalid context state for evaluate context command.
  usb 8-8: reset full-speed USB device number 6 using xhci-pci-prom21
  usb 8-4: reset high-speed USB device number 2 using xhci-pci-prom21
  usb 8-11: reset high-speed USB device number 7 using xhci-pci-prom21
  usb 8-7: reset full-speed USB device number 5 using xhci-pci-prom21
  usb 8-6: reset full-speed USB device number 4 using xhci-pci-prom21
  usb 8-5: USB disconnect, device number 10
  Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi

USBSTS 0x401 is HCH | SRE (halted, save/restore error). btusb then
re-probed the AX210, so bluetoothd lost and re-created the adapter, and
the USB devices on that controller were reset or re-enumerated.

The disconnect was also visible: on every resume the desktop showed a
"YubiKey connected" notification, because the key was re-enumerated as
a new device (device number 10 -> 11 in the log).

With v5 applied
---------------
I analyzed three S3 suspend/resume cycles on the patched kernel:

  - two short ones in a row on one boot (about 13 s asleep each),
  - one long one on a later boot: 07:29:58 -> 16:19:29, about 8 h 49 min
    asleep.

In all three, the kernel log between "PM: suspend entry (deep)" and
"PM: suspend exit" contains none of the lines above: no "xHC error in
resume", no "root hub lost power or was reset", no "reset ... USB
device", no USB disconnect, and no hci0 firmware/probe lines. The
Bluetooth adapter stayed bound to btusb, and the YubiKey and the AX210
were still enumerated after the long sleep.

The "YubiKey connected" notification that appeared after every resume
before the patch has not appeared since the patch was applied.

The patch also fixed a problem I had given up on: my Logitech Bolt
receiver (046d:c548, port 8-6 on this controller) was reset and
re-enumerated on every resume, which made it unreliable, so I had
stopped using Logitech devices to wake the machine. With v5 applied the
Bolt Receiver works consistently across many suspend/resume cycles (this
is what I observed in daily use; the three cycles above are the ones I
checked in the kernel log).

Thanks for the fix.

Maciej Zonski
