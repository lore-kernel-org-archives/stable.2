Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762273;
	b=iQz2EPTxzt1DKc7Hff8MDq1qTJ/4M4mL7l5djyqaepdvtOPYlddsmCpZcS3C81rAB5I5
	 6qCAfU8oMnlA78EYc3NBF/9cDODeTDcPxDFwjXZHMd8Omzm7QvJ/EegJJoQLwfl216+xj
	 yFU18A5xj3YKcWmcfC6P9O7sYnky52USt1NQc6r2VEeNwDWR4yNL0vJ6O1ck/OOS3VLyZ
	 zpwWnsSge56mqWH/nUnmONbgrEiBpLezAZVCiScqY9N3mA6hFlKivLYV80UVze+5+RVj6
	 PI8uFXIZOhwvFVhaiXCZD0g4F9US0c5a03rscSIBHYv48chggAuwjNGAO0QY7Q7InBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=9Etp+uIPqQGcLckVfNV7TmEvYSXTHwzYuJnCc6iuXOg=;
	b=OIbY5Bk4tl5BnQ3E0hhJgacAsOW0r93lam0hyiyXyOQyUs9FLW1ZataCYO9aGrEK9qIk
	 qZGjHCHfwlZBm2N/b8q3Y76dauttptqyhBwk6WhIsOM1IHCIjcVHNUheC6kCgO57U5BnE
	 cqecUgs5/vhr0pldltkh6Ql9CR1wTPzerZOjmVz7hJXVvezqGCcOTMcWVCMuXnJK5P8DZ
	 ThQYzw2UjSf7Yq7WYikksN3mCR/u+GGRTF+m5+vKQyjIT4FhGFn6Hq4MHS4QW1tIVh8jO
	 WikC8cw8TDgNdYXLFHs95+7dv/gVmrY8/B16ZlOOFFVuPCWQwK7FGNsE4nFbhLAvpYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=fWxkZqxN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DC606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B40DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=fWxkZqxN
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6767d92cde6so8510467d50.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795762272; cv=none;
        d=google.com; s=arc-20260327;
        b=ADPEJtZfrOg3tK2LKC8EfczOEqq269Mbd6bjL4c1zs13NK55TETBbBE1Zu3paBMIYN
         R+d4CgAxNISD3FGqyYw1CKNIYeVzA5SoJdI1eeCFdUPSsuLYky8juojED0T5Q1HTzPOA
         fYZuLgL0xzgMKSvEVGY5sPrdKRxPK6K5mtCprPk+R7+D48mdQ7Hr1t4KpNaC+oQjY6jr
         ZDo7+40PPm4P8G069Lwgy5Veo704X8OBxlaslVWk4dO4BrdTzt9p11PJXRrkgoHgfbU6
         kj9lZ4BdAEXY/r8dmxuyNfHC8P3EdNr5MrfDYeqWVGV1PWc5hlLgGqR/JduEf20XDo9x
         4XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=9Etp+uIPqQGcLckVfNV7TmEvYSXTHwzYuJnCc6iuXOg=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=PM1BM1/0Nh5KEUEX+J0JQCJZ8TGHzo9pNSOnnaijj2RCyWGOz9ylDS8HYabGq5Jrpw
         ZeXmOFfleGpcZKnfE/BSHCdsH3XiGAqXwb9U0K0BnHpRY38U4Xcf8S4RhdDqbXbwKRzB
         +xouh8gN2yWymjMU7dXK7qMiplbX/olVVCPPWEaqO0HxFdagKW7jMbUcbLenDkkv3D0X
         pbM8f0mkuL9E72vTpEKd1BhY0MX84U300M3q+iBq3vjUJbe2wnsiSoGpq/2zntDJUULI
         fIEGQxwVttxb44ZtdIUhB57IS17U4VXQQ06rgKUsSlemFI4SNmsvFyivjTDAiVNVHD4J
         ZTHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795762272; x=1796367072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Etp+uIPqQGcLckVfNV7TmEvYSXTHwzYuJnCc6iuXOg=;
        b=fWxkZqxN+QMQSpTeExZA6wF6xwe3PoaNLLN0GnX58CBlhJemNYrMT+QB9Jc/H8qoJ7
         H9vT+Rkx6hPIgbc1urefzr2gRWFxUO4QhgCBU+qFuTESnD6cojRVVOpXxZLdgTQu+KAa
         NBXHk0btI9AzkIwQD8zouMVkSMa/dUMFvOFk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762272; x=1796367072;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Etp+uIPqQGcLckVfNV7TmEvYSXTHwzYuJnCc6iuXOg=;
        b=scqTVyBAlXHkgz9WEhIb6OJnxJWAkc4q5s++a3qniypq0d510io4TiVWYAzi7rm03Z
         yfmHwTJdJk7U7VXDbslBJxCkeRST3VtIq2jzi2k7ppTbKu0Fk2uiPT4Ekkq16AsQvhO6
         6NcOeZeWkF8hr70vzAX/1dh88+3C8Ay+ts0IKcYoKV+8xnjlQ+hN0nipMbdP5Uo6W0nM
         srX8K+ZOjqTB6A+0sx6gIaA9ZvUD15ogEoSDva0rnRDcso+y+kDv5e3ruzcMywphQXko
         RmlC2OW/oLGqVAUoV3IRnR6RkXGOdMe3stpKHNjh01U/6dfzrs8JSZUCw2ZcOkzxyNik
         px8A==
X-Gm-Message-State: APuU4Z+GYEmJhlYm0If280YL6RA2bgBRxIgniEzBukQrYvGGFf8xl6Fi
	Arr3JsVTzMbCHllrgP8YC6XX29+0orkn0L1+xm35YYx/AXQ3w2nB9fGb0xXQFA6nZL4ueZN9bEC
	9NKWjk6ZiV8jk6YS+wRwfcqc6w5GpDQRJtedjov2KBxynYoxzaojS4LT/eg==
X-Gm-Gg: AZFdTZds6gQTG/Hc4b8KOt6IVbs2sPAUpHftiUb7QWYtvDZDhY5yS4wXUoI1aFTkoeN
	O+RoIYvLZru40gIyk+8Sh0QxftyYIttjB9L/taPIVGDWwRMiy/prdOyFdR7+5S+VsLS/q7jbnZ+
	y/DKnHfvFkpRTCSrdlSej2dVRTJsdi2kTd1AP0AsIGp5ev15u3Q3k16eIcV233BdpwGUUc/5LmA
	XNxS12NLEbRi8SLem7Tric2fKnuPsnmT90MnHxqy/bgxuiir1pwNytl7uD1ITZdMNHjFh5XcHIQ
	I65FfBAUpk1p1jxSbWx++b2ZHFJqWjKI03N4prwCr3C8arIR+zf4r6ePNstI9u7iDW0jKeCwgj1
	oTibCHqy8EWI6D9crsS2DLc8dvkxm7+CvUg2IGXl20SGoASp2Bbdu+y+z/O7QbnP/iLjeffC1WE
	LS7s/GWtYhHikqdaC23sOpjAYY7kcmKM3iEd+5W9K8pN8N3gcBbBSnKASzO8+6nVRrbdhnlpB1d
	qelMkp0TxtdPlzcK+UZ9zVr3LAjA378AkC/
X-Received: by 2002:a05:690e:1513:b0:67d:eb6d:7445 with SMTP id
 956f58d0204a3-67df446e829mr7082280d50.90.1795762271654; Thu, 26 Nov 2026
 22:51:11 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 06:51:11 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2026112650-vigorous-outclass-f813@gregkh>
References: <CAFaZ9erY+wo3QhtNvBdw1q2CB1fm4d2Zrx4t2QuJWEakDmo0bA@mail.gmail.com>
 <2026112650-vigorous-outclass-f813@gregkh>
From: Dickson Wu <dickson.wu@certik.com>
Date: Fri, 27 Nov 2026 06:51:11 +0000
X-Gm-Features: Aa3M54qxZgEdthKrPi_3dgyCIH5AV5k7AUy6ZIE9rXdFV4wYjnU3LvqkmvMARIs
Message-ID: <CAFaZ9epdU-uJXTWLCgWD+Gc920pfF6xKS+Hnag_yR1mZHhG8pw@mail.gmail.com>
Subject: Re: Request: security fixes for 5.10.y, 5.15.y and 6.6.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 12:59:01PM +0000, Greg KH wrote:
> For all of these, please provide actual backports, that you have tested,
> so we can apply them that way. Some of the above you list seem to
> already be in the relevant kernel branches, so be careful and test them
> properly before sending them to us (also be aware of when things have
> been reverted due to problems...)

Got it, thanks. These are out now as tested backports with my
Signed-off-by:

5.10.y binfmt_misc, 90f601b497d7:
https://lore.kernel.org/stable/20261127-so5-binfmt-510-v1-1-c62790b381f0@certik.com/
5.15.y qla2xxx, c0b7da13a04b:
https://lore.kernel.org/stable/20261127-so5-qla-515-v1-1-fc31e58ffd78@certik.com/
5.15.y PCI, 8ec9c1d5d0a5:
https://lore.kernel.org/stable/20261127-so5-pci-515-v1-1-58c7cedf2a45@certik.com/
6.6.y ALSA, 59e1592d3c27:
https://lore.kernel.org/stable/20261127-so5-alsa-66-v1-1-e6baeea4106a@certik.com/

On the already-in-tree point, I rechecked each one against the current
tips (v5.10.275, v5.15.226, v6.6.163) by upstream SHA reference,
patch-id and subject, and looked in mainline for later reverts or
fixups. I'm pretty sure none of these is in yet. The two that can look
present:

- hfsplus: 5.10.y has 76a4c6636a69, the backport of 94458781aee6, which
  has the same title as bea3e1d4467b. bea3e1d4467b is the follow-up
  (Fixes: 94458781aee6) and it isn't in 5.10.y. I'll send that one
  separately shortly.
- binfmt_misc: 5.10.y has db1856ea9196 as 7873f9872136, but the error
  path fix in bm_register_write() from 90f601b497d7 is still missing.

I've dropped d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip
reset") for 5.10.y and 5.15.y. It needs two later fixes, 17488f139074
and 5c50d84798eb, that so far are only in 7.2.y and 7.3.y, so I'll come
back to it once the other branches have all three.

If you had a different one in mind, let me know and I'll drop it.

Best,
Dickson


On Thu, 26 Nov 2026 13:59:01 +0100, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 25, 2026 at 11:06:47PM -0600, Dickson Wu wrote:
> > Hi Greg and Sasha,
> >
> > Could you please queue these upstream commits for the trees below?
> > They're security fixes that every newer stable branch already has, and
> > each one cherry-picks cleanly onto the current branch tip.
> >
> > 5.10.y:
> > - bea3e1d4467b ("hfsplus: fix slab-out-of-bounds read in
> >   hfsplus_uni2asc()")
> >   CVE-2025-40082. 5.10.y already has the earlier fix with the same
> >   title (76a4c6636a69); this is the second one.
> > - 90f601b497d7 ("binfmt_misc: restore write access before closing
> >   files opened by open_exec()")
> >   CVE-2025-68239.
> > - d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip reset")
> >   CVE-2025-68745.
> >
> > 5.15.y:
> > - d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip reset")
> >   CVE-2025-68745.
> > - c0b7da13a04b ("scsi: qla2xxx: Completely fix fcport double free")
> >   CVE-2026-43414.
> > - 8ec9c1d5d0a5 ("PCI: Free released resource after coalescing")
> >   CVE-2023-53743. Upstream tagged it for v5.16+, but 5.15.y has the
> >   coalescing change it fixes as 26277a425020.
> >
> > 6.6.y:
> > - 59e1592d3c27 ("ALSA: seq: Don't leak the extension cell pointer in
> >   the bounce payload")
> >   CVE-2026-90220.
> >
> > Testing, on v5.10.275, v5.15.226 and v6.6.163: cherry-picked onto the
> > branch tip, W=1 build of the touched objects before and after with no
> > new warnings, and x86_64 defconfig with the relevant options enabled,
> > built and booted under QEMU/KVM. I didn't run targeted runtime tests
> > for these paths.
> >
> > The list and the test runs were prepared with AI coding tools (OpenAI
> > Codex agents, with review by Claude).
>
> For all of these, please provide actual backports, that you have tested,
> so we can apply them that way.  Some of the above you list seem to
> already be in the relevant kernel branches, so be careful and test them
> properly before sending them to us (also be aware of when things have
> been reverted due to problems...)
>
> thanks,
>
> greg k-h
