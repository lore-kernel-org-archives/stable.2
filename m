Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622416;
	b=2YGCMVo99ZQXMPiDhViIfQQAZg+j5/4GLYKfpQ7Sq8rWyOWksepcWmC8NxS8lhGT9XXt
	 HJwUOWmznShZYHiFl2BoCw7UPuucHIUoaTwMOJ9dDR6/YdSGkKoDMOQkZg5+WGVrxCxdH
	 uz5OTUZNLCYv3DFWatC/Ynady16AgduJE+fArY44igYpwqABk4NQiMqa9xP5P9Sq4FXSv
	 xc+f1ht6NjLaaAaBkWuNjRNi1DsAAZOlQlEY8pU1mZudzfVOJH1OGIojJ6iBeCPsr0oBN
	 4CoS4vKTiK0jZuaP6Utr943jVXebzxdatjrYqoWGDyI0pTSYx8UzV9NJw6vovqLtgZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622416;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=pSEjQ6X6nKMFKE8BpPFQ+T1/sYQgPv1ypTviAL6uW8A=;
	b=g8zy0S0CNOT631ZY3xXF9Vz22urFfU+awE1pzmimytvTedPyxh4cRGiEYZy4jlV9f3zg
	 ZNrJ66OGVtW4P0LJWQKbWuRjl1+u5MKqMJv+w+cKKMWNYmZ3hX05bZvAfm0IeFbNa8W0S
	 R7iGwPdOQDEKqSoEb1XE6JoYNFH1gWbclzfAbJpEthrOy2hT2dTfxBdjzB47oAMq6toGc
	 ZeKh4967D0dDpD84KKs+kUqswvf40q2/E30M3jhpPjazljSCZLsGMSKz3Eqg6xy3z4ccA
	 ribK+1vPwrya7qDFeVA7nmS6C72GmqajUiyPgnLoyAbHCjDHlp0NVY7Zrjx/JRbu9Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uJHIuLM9;
	arc=none smtp.remote-ip=91.218.175.13
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB6606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 02:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96CB6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uJHIuLM9
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pSEjQ6X6nKMFKE8BpPFQ+T1/sYQgPv1ypTviAL6uW8A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794622412; v=1; x=1795227212;
 b=uJHIuLM9sQrW+i/MVKZJ3bRJpeZLK6ZH4se7cKklNSodCE/MgkX+kpLge8jc9btBUpVOBGzF
 9xBr6lzwoFdZWSAwIEshq20merSButjJv92IRPZZoHbHfq5xPxpggbyqbaArGSWAh7SsFRO+QgO
 zwdk8rScDaQFykPSgnPmA7mk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5565a4f17b539d2;
	Sat, 14 Nov 2026 02:13:32 +0000
X-Mizu-Trace-ID: e5565a4f17b539d2
X-Migadu-Flow: FLOW_OUT
Date: Sat, 14 Nov 2026 03:13:32 +0100
From: Denis Benato <denis.benato@linux.dev>
To: Aspecky <tarrihmoad@proton.me>
Cc: Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sercan GOKMEN <gokmensercan@gmail.com>,
	Burak Goncu <burakgon12@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Message-ID: <1b1257ea-e6c0-4380-a277-e20c99e047de@linux.dev>
In-Reply-To: <-sHRKK56awNgHWFUXMcBVRL0SSag0CruNAfbxPNPYJJC8qqk_N74k3wCldWqNkfw-CBwHj-6CvkYhrkCsBYqgNNUQV2oT31VbehOxMbR87E=@proton.me>
References: <20261111-asus-wmi-kbd-readback-v4-1-79df1567476d@proton.me> <04c46822-9baa-4152-8193-d8aa9d757b4e@linux.dev> <-sHRKK56awNgHWFUXMcBVRL0SSag0CruNAfbxPNPYJJC8qqk_N74k3wCldWqNkfw-CBwHj-6CvkYhrkCsBYqgNNUQV2oT31VbehOxMbR87E=@proton.me>
Subject: Re: [PATCH v4] platform/x86: asus-wmi: Ignore unusable kbd
 backlight WMI device on ROG Strix G814FP
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <1b1257ea-e6c0-4380-a277-e20c99e047de@linux.dev>

14 nov 2026 01:50:29 Aspecky <tarrihmoad@proton.me>:

> On Thursday, November 12th, 2026 at 10:21 AM, Denis Benato <denis.benato@=
linux.dev> wrote:
>
>>> On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
>>> backlight brightness in sysfs works, but reading it back always gives
>>> 0, and the read makes the Fn brightness keys misbehave.
>>
>> With "works" do you mean the write report success but does nothing or
>> that it is actually changing the brightness?
>
> Sorry about the confusion, the write does actually change the brightness.
> Writing 3 to /sys/class/leds/asus::kbd_backlight/brightness turns the
> LEDs to high. asus-wmi passes the level both to the WMI device and to
> hid-asus, the latter is the one that registers as a listener on the LED.
> The DEVS(0x00050021) write to the WMI device fails with -ENODEV and
> changes nothing, hid-asus is what actually sets the LEDs:
>

No, you excuse me: the question was not well expressed.

I meant if wmi actually changes something, not if the sysfs write does... F=
rom this answer I understand. Keep the description this way.


Do as if I never said anything about this :)

> sysfs write -> asus-wmi |- DEVS(0x00050021) -> firmware -> rejected
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |_ hid-a=
sus -> USB HID report -> LEDs
>
>>> DSTS(0x00050021) always returns 0x50000, which is level 0
>>
>> Always returns level zero with the presence bit set.
>
> Correct, always returns level zero with the presence bit set,
> i'll say that in v5.
>
>>> As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes ar=
e
>>> no longer created on this board, they never worked here since the firmw=
are
>>> rejects those writes as well.
>>
>> Isn't this a contraddiction to what is written above? That writes
>> actually succeeds?
>
> It's not a contradiction, the sysfs brightness write succeeds because
> of hid-asus, while the WMI DEVS(0x00050021) writes are rejected and
> so are the ones behind kbd_rgb_mode. The commit message doesn't make
> that clear, I'll reword it in v5 and wait a day or so in case there
> are more comments.
>

All good. I understand, proceed mentioning the presence bit and level zero =
and you're done.

Put a Reviewed-by: Denis Benato <denis.benato@linux.dev> in your next patch=
.

Thanks,
Denis

> Thanks,
> Moad

