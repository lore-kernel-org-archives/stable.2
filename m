Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794447052;
	b=XaTbruHjsARB8c0YiCnSEwDXS9KWW02pO3UFltegntEZhYg5U7rsxOo4zqqJ4Pvful5/
	 LyuA+PIy2+zq7MQ34DZbAru+cj59vnU+k6zuJo7HCnocUhTfwkjxLmrEF/xdKYmggSf8Q
	 HgjzYIIDWvce4QXJObPgRmmRJQmsKAwekJkMh/TPtaJzVSX/UB8jOusV6BNAOZFZyOQMx
	 QoO/0tHvxJ6gUgOwdp+DxVs6YviTkWqk81uDUQ3XzioggeRYVrEST/tsYfvWUDW2DwC+V
	 AlSt2NeVG8s3WQrhO6ureAKwxCVXfgkINU1TSd3xCAfYRHmSTOFmV/tRfdWYpdW6XLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
	b=dKbxVprJzP/OmUUdAG8LZ54Qqm64X9F9RhV2L1WGIfDMvCAtllmjkl8D7RnrZx5jt9cr
	 XcWsCTJ85wi0yQ8UaMKBOO5WHlNTc8TnTe5N1l8j7xo/i4kzrVcyTwIy47ALIPcxovu8c
	 f/Ct/E+wh1urYeshEOtiX3GHtU4DsIMFPIDC6QoauQKKB6e6Ew1oyCpId35No82w37dZH
	 qnnjWtbgXk2muh+D+jpFev51Cu4vLz6/2PegN6BAUzlsYX6CZlZ39Wb+yGJqqHvp8ZAQs
	 NjQNEsitgtwxmX+ScJ7cm1E7oB/pmZYyfavSlz9YIQA85TEQjnyY1FGWffcSYWrvHzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y/lJbvwI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8E606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y/lJbvwI
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67c0bd676eeso3679498d50.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:30:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794447050; cv=none;
        d=google.com; s=arc-20260327;
        b=f90Yn26MsFPazgUznRXWc9KATdYtAmmYwIjU0jOIyVJhViklgOmoKBOsutbY0mzz74
         rp+aEQxap60BKihPXz/s2O3GRini/7mN9SAIYcrEaHo96nkf5/4UWfgKtpsih7gMXIUH
         G2JjdJeN9WVmaJsbYslclQl607faLe9aHktlzQ9nDJSTPFem3BpoMbRkFcy4tqsQEyXJ
         e270QZbQnEHPsU/1CKeMX0C1XD7FAuHw4spirXnnhblkGLFib3sTMEr/lnNLwRfVsAXT
         lHPRHvY7DL2I/xVxchRcVRIc1k4gr8ngPff1dB+YnAu8GRmWbmRyO+PHAb8t8axPkro3
         QHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
        fh=E0HTSY+jjd3Zm3xnuc+2PSWE3Ferwk7HPlAysklAlTI=;
        b=S7xSckpv0w6X2JH8k6efiIgA4buEjchh7WF5UXU0JBiMiZAlrxcxFaG2tXgL9vBHAz
         toeK94Zkj1W3QRhMtyQehvLQd4d62mGLwtF/Z0hfTrk9M7Zd5wTEVIe5sx8JcvlH9cZL
         OdSo9agiqtd0udAkA2qFdN//FO8pRZIUpyojyUkVZ/AVT8Gh4HcQ7t5Rtg0XgiqdExNG
         auWxpsQRS+nlDGDS6fTfm3TpAb0IBWsq61kNeHrWtNUm//oA/F9LNqHkTV/1fRWHdda8
         MyosZBMuB1qWIGgcUa6jhuykNCYEurw1aGeIfESUinjvJfF/x9nEW6ay+HCa/lV+03cX
         68tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794447050; x=1795051850; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
        b=y/lJbvwIyJUNJf+iEwafVeL35qIQWE8o/yeXSsqV0WGo+yOTlDXC2TfsnDpKk4r4fW
         HCoxpn5CZBPzHnJ7/IA6clIhxD1oYcHmpWIyu6zFOgCWPNBrrzqm79d1oz8lUsqSUKfd
         VCaJc/Ol5yOHkrrJ1OEH19HZiQxszCOV2SSXU2M81MZZGOT8hXTPoE73rKWjqEeDsDkz
         FaxJJuPUzndKoNpp1G683K9uSe2twR4KP1v2/Mk7WLf9BdBWGBMLVT8DrIzRHjeuVeSV
         nJ2pNVVnLDZUa+sG/jwBRjAiuLT/+iKjLaH5xtDs/mVr08+C9jbn7LMlymxZVfcxwWuO
         sQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794447050; x=1795051850;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
        b=Qui1ePhmVzUPHEdYfBWj3GjjFSqRUB3rZediJ4I0LPNXd07abpm+6N14GCaDAR+52K
         PigZ6JjYuK33cxBJP9Sg8XO1v0NSBc2Vvo485/zaLX5U4jtTJozshSuh2MxgKhtzTpCK
         v9ylZNWMa8zYxn+Q5y0RqC8kGIJ2Pvb5zCwV2lUHTki+hODOon/xRW8/OL/QVj9NRpCM
         VYvlbyiIRpjc4uSvKoY1dAbaQQKaayTXzutP2CFunFtUGettdckpjpXHRyOFEoEl05DT
         tkEmnmEUQXGvtFMtNXGHw/H45ke9Nv81sNw1c5WEFmaylk2keYynUnKJqnIv3VlCMx5F
         nl/Q==
X-Forwarded-Encrypted: i=1; AL+hErHExPToqe4YgJrOMWVe5HePzBUCmQsHQimkcjGfgdfVLeNClLwMuCNPMfX0r8AOHf/0auWx6I4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/zdrPolPKLpfjc9E9GZSUJLwbj/GRE+MS/5yvV/zqqqbxPziO
	pV6d/qsTsVzTEI23pz/Nb5bhFTKRv/F9kbXvMoOMl/neBAATdlQ8XlqKtyibH0a3T5rbEsVMS+v
	lwfVqct14SO88IJs+c6wub/XzvwxFOSs=
X-Gm-Gg: AYBFou1a3P8qf71S95R8yTecieWiTmA85IRaN/47gkHovlcM9MjDDxuAeyRgkjOcOse
	+o6ywHtjC1p1TD/b8oJA6uJVwgnoROj3M2/gk16n42z+B6kAFd/OiRvC84H+n6THcXJvEMOVqgt
	vsbHx1rPYRqjy7DYmRTM8MAvkjzsgCYwBILB/JAoH7gJy74MoLr86Q2z5QHX2jLz0zo4QwIaOpd
	3JzeKAX0YYsD8krt/kAdtLHKUSBfoy42K29hlWMBOnTEf988BsCYa7LQJZ1YuAQ/LV0qiFK4fN8
	u8djuvz1SHLnwljuc9Rx3RsajsGJSou91I+M1POyIqLCNYg+c2xTsyCnartgrLDWJGCacs2zFcX
	eVDYKfN/vHUC78p6Mt5pi3m2ZFYxQJ9uYdfARoJF3rg8OgYGpQNw2eaBRmNEo5BIBGYBJdsASEc
	W//pT2GOB5KK/VN7s=
X-Received: by 2002:a05:690e:1445:b0:67c:257a:cba8 with SMTP id
 956f58d0204a3-67c67ee4afemr3040960d50.15.1794447050552; Wed, 11 Nov 2026
 17:30:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Thu, 12 Nov 2026 02:30:39 +0100
X-Gm-Features: AclHuK93X2NS4OkDx9i0xCDJ4Jv5CPtODKBLv44HwCgLoH-cBZXhsL3lMnkWxMQ
Message-ID: <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

I tested v2 of the series on my G920 (046d:c262). Everything on my
list works except one scenario that takes the whole machine down, with
and without your series (last item).

Setup: Linux 7.3.1-1-cachyos (clang build). The pre-image of patch 1
(blob 60fc6b86a085) is identical to v7.4-rc2's hid-logitech-hidpp.c, so
I applied all 33 patches to that file (every step matched the blob hash
recorded in the patch) and built it as an out-of-tree module against
the 7.3.1 headers, loaded with insmod. The only local change is a
3-line fallback for devm_kzalloc_obj(), which the 7.3.1 headers lack.
No full kernel build.

Results:

 - Initialization: "Force feedback support loaded (firmware release 4)"
   on every plug-in (8 in total), no -110.

 - fftest: all effect types are listed and the effects play and
   produce force. After exiting with -1 the log stays clean for 2+
   minutes.

 - Input: wheel rotation, buttons and the hat all register in evtest.
   I use other pedals, so the G920 pedals are untested.

 - range sysfs: with nothing holding the device open, writes take
   ~67 ms and read back correctly (540, then 900). On v1 my
   closed-device writes each ended in a "Failed to send command to
   device!" about 15 s later. With evtest open it behaves the same.
   100 reads back as 180 and 2000 as 900.

 - Replug x4: FF loads cleanly each time.

 - Unplug with evtest open: evtest exits with "No such device",
   "Unloading HID++ force feedback" and nothing else in dmesg.

 - Unplug with fftest open (6 effects loaded): 6 "Failed to send
   command to device!" lines within 1.7 ms of each other (v1 gave 12),
   then "Unloading HID++ force feedback" 19 ms after the last. No
   warnings, oops or hangs.

 - rmmod with fftest holding the device open: rmmod returned after
   2.99 s with "Unloading HID++ force feedback" and nothing else in
   dmesg. When I then exited fftest (entering -1), the machine went
   down: the first time with a garbled panic screen that I couldn't
   read, and on later attempts as a total hang with no output. The
   same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
   driver also hangs the whole system, so this predates the series.

   To reproduce: with the module loaded and the G920 plugged in, start
   fftest on its event node and leave it at the effect prompt, run
   "rmmod hid_logitech_hidpp" from another terminal, then enter -1 in
   fftest.

   I could not recover a trace yet and will send one if I manage to.

   My guess, from reading the code and not verified by a trace:
   hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
   callbacks in the ff_device as pointers into the module. With fftest
   holding the evdev open, the input_dev outlives the driver, so when
   fftest closes, the final input_dev release calls ff->destroy in
   module code that rmmod has already freed.

Not tested: the battery patches (10-14, a wired G920 can't exercise
them), in-game FFB, and sysfs driver unbind.

Happy to test patches or send the full logs.

Gideon
