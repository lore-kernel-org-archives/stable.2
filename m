Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF3478E5A;
	Wed,  9 Sep 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949544; cv=none; b=UxFOENWOTvhMEZDQGvCWVGxTGGdNYEj9itET8tWCBSA3IbaIJe/0u4uIkAw8XcD0pMF2XMmKGGSpSsfOHTtSPjsTbnxLwKZc7J3P5ZJI4PTwcfMAw3cqUuIL04BUtW1xyqN6JhJfi1+utk8S7up7cSfD5VrRNtf9zVrNmLhatiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949544; c=relaxed/simple;
	bh=X6CS8natN/FeN/v/5ZXPoQdCMzGosg/lTx3jrqNsSAg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2llAIbGFRyrTkOs/zKsVr5xzS687RpnXT4wgb3pIfjGX6kkFZVC+L/tRKUGTtimBUIvC/3LKgsPV+Wo2DJ763zWaynyz2gWjBUMToV0rr/8b47gVmgrttv1k0vy7sdU1I1eIRUEVp7xNPZ8Z7sGKRZhun+LXrrd55mlForelVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DRHdZGDq; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DRHdZGDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788949532; x=1789208732;
	bh=dceBWMYXZxkpNT6zH1rL/lZdha3FG9MrbZct7tilnUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DRHdZGDqhCLAkGAGUj8U+fvFj4X5M/DHA+Z8+sbfE0x6PS/dJGFv2n/X/EyjfX4BH
	 A+omUHWmb7zGGICxo0hbGuX2+QVh0Yp9vqSa9LpTsdt7zfGlcCiStk0gmMDNql5PvA
	 jFEITMrSqSzZRQAO77xy4wEPw4/134x+8V51oZZldOrMASbjoic1wdUBuoCw+6p9iY
	 we8VzR1OUEbLCtt0MZx5EQHYhVKt4bd4naQ12sQyACsC//fAGw1P5P1lLKBhoiTmJp
	 PyrTDJNynqkzDWrKvtrQCeh7LS17WuRjF0TKSxNNQTTUZyNdh+YNNKpo/G0d8MYMuZ
	 xJ2cbsn4Usbxw==
Date: Wed, 09 Sep 2026 10:25:28 +0000
To: Hans de Goede <johannes.goede@oss.qualcomm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Input: soc_button_array - fix MS Surface Pro 11 probe failure
Message-ID: <20260909102521.67488-1-lsa.uz@pm.me>
In-Reply-To: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
References: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: c74eb37c6e77e0b9bb4eea2612100284fe62ca97
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hans,

It fixes it. Sixteen consecutive boots on the Surface Pro 11, every one wit=
h
both gpio-keys devices present and MSHW0040:00 bound. The baseline in my
report was 13 boots in 40.

  boots                     16
  buttons appeared          16
  first input at            1.242 - 1.377 s

For comparison the 13 stock successes ran 1.28 - 1.78 s, so no boot here wa=
s
slower than stock managed when it worked, and the spread is tighter. The un=
it
that binds this device by hand was disabled for the whole run, so nothing
masked the result.

Built on 7.0.0-30, Ubuntu 26.04; both patches apply to that kernel's copy o=
f
the file as-is, 2/2 at an offset. Ubuntu ships the file unmodified - an
out-of-tree build of mainline v7.0's source carries the same srcversion as
Ubuntu's own module - so the tested source differs from stock by your patch=
es
and nothing else.

One note for whoever tests this driver next rather than about the patch: on
this install soc_button_array is in the initramfs under MODULES=3Dmost, so
replacing the module under /lib/modules does nothing until update-initramfs
runs, and modinfo will report the new one while the old one is loaded. Thre=
e
boots of mine were recorded before I noticed. I checked
/sys/module/soc_button_array/srcversion on every boot above.

Patch 2/2 was in the same build and caused no regression, but I am not
claiming a test for it: the buttons appear here, so this machine's ACPI
descriptor package is not empty and the new check is never reached. So for
1/2 only:

Tested-by: Sergey Lebedev <lsa.uz@pm.me>

Sergey

