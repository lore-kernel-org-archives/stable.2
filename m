Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794261787;
	b=LBxCKDCvCpN79Ul/w3OWODuHFWn0qOIEqp+8XTO/K26cgcAi4RVr0acmE4dO7JKNl362
	 sX9HWwUlYMmtD+IvN1PnKWK5BL48k7AEvd2Hh1pPRutA5lqPMN7/g/wDKO62FnVL68Ry6
	 lfNK3fBXLJ/0JqpQexyisx5AVg/CoIIjF+s2xmODqAameBnXpBMP3RepYpNRLkTcVBTFq
	 64WnoDvZkRl4k3OIXGALrpHUOVpvyKF3RR/gqRhgPz0Dvt6Fql/3EhonwoYDnr6S2TzDU
	 x3oM+wtyQJX2wwVbVXWKRdG6l5YnK0wiI7jrU/tCQi489WTEqX48tzZuBsmalxtadwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/4B+HMYQGdeNoawaC8nb2MBw5WMuUhGF+veGWpIt95w=;
	b=zxPSXr0RZDBCwVYDaLmuZsUYjnvWMzgm/CATXUQNAcrl0SeXIC1U6HFK8dBVrSahsQ0e
	 Vem47xXInJ2qc0GAtorY0sKanl8UM3KnLUSFeTwrkXbSnuSMcojanOthzG8aHVw19fHTG
	 iR5oluVFgjUgxcacJeSYs5vr/DFB9RY0c0iYjD/aVWO3kDuY3y6YL5DhWydFcKZDUQBBp
	 IEu56KdtKJ3yzW5FXHPnPcfuuDAMYNGGRI9UdlwNnTJQSRszdEAadSB5AmkkjKmo6rvT/
	 vMQ1qAojO0bHesdweKn1vHrCgjhoe/pMkikSzGVLJBFyUcckFvJnB4kSuaHpLhknr2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=BSUTlFht;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D5606A33A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 22:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 554D5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=BSUTlFht
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso129620a12.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 14:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794261781; cv=none;
        d=google.com; s=arc-20260327;
        b=R9rE3AJu3wNeMWeP0yUomzb9Czph41i6aotDE6AvbV0o0QT+/ILxrZyvKhkIUc640s
         kQkFQvQdJEnKPFXbueZTgGzX/qxKci/NR039NiKlfE75QTUW2+FHvFSNqcCd6PZQDugO
         TzMWEQ/a58e/uvk3qIoIJ3HaCO+eddb82vT84k/O3VnX1A2qDA+y7lrH2YXXuHwj55nC
         gVYLavKxPG9k4VKmniqHNAbt93y25V6A81MpF8N1U0JnLoMO7k6Azr5Dsks+CYD2oJyx
         guHchomzFXdY+R3Utg3c2hqrCgJGDp0vBEsG6QPAyUPLoqO50p/w6c4t0SsZzJOP9stj
         GtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/4B+HMYQGdeNoawaC8nb2MBw5WMuUhGF+veGWpIt95w=;
        fh=2AJ6y1CNoFtOO2kF5NJxWlnyL1UEA2IutSb+OBEe9no=;
        b=fyUxOOMSjYcSgxGxOowTRNi2gBMkWIyn236/XNMhlZTOZNumB8m7pnoUiIAgSqfZSB
         jhDBKkHWndsdJ0weaus+7HpwpZBp64PS4Ev3/ZC3OKETNCHUuqsY53ASAs9ORblhxzM2
         IHLTHJ9MK9vzgm8RcTHbzHfznGSzw/m77GSMmQ2T4wTLYRuoRIz4pkAxA6zzggxohiWs
         k03G8pu/JRLJ6ysH+i7/RT6MdAr4uX9PIxvRwKLjkvKtjo/1QXJZAJEPHBS0Kn5Zpr7d
         TZZKL6096waQW+g9lcukQzIhNK0raYYqePWNrrl6WwQYonYFh98pVP1CWyfAd6OeZXpw
         31ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1794261781; x=1794866581; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4B+HMYQGdeNoawaC8nb2MBw5WMuUhGF+veGWpIt95w=;
        b=BSUTlFht39VNuJ/f2J56X1s7bZ7V2SNgiXfLZnVcGiL1jIU4NznY9fE2HkjZmULok1
         x60Vf3QAfEuCA1jvHmnHu1CC9AcJp08kuvVT8l5qpx4T4NU4ylgNZf25JIwR3YHhAKQd
         Qn0z40snzSs1+K11hpetvZMTri1kDGLdQ9Pmb6pGGbbcBhaE0eUIspki2qJK0xwomhJY
         Rq/8cEG+xuhEWuV8g+0jDwvIqDpq26NFGtV+XemcHnqOwpN6iQVJ7qI59pGoQpyzGKeA
         +f14gx25gOszOrAfXaYBcvorgkduohNMqwnYMIgQYPwprPWNiBPoveI/vOSv0NZUaed7
         dfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261781; x=1794866581;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/4B+HMYQGdeNoawaC8nb2MBw5WMuUhGF+veGWpIt95w=;
        b=QkQr11EBu8nX7Ij5b6YFHzLiBFC+ji7HDv1MMU51zKL0vN4sab6krynfg0T3AhSej1
         /TAjuT/l7AxWB/1gkHOnHqIc3seWcFrLJmgDzIv9fHm5/CTR9+7d8SFDBTgLwcFMZ7ZH
         RQDHKGZZTx6qEAOmRhcc2Fn4ZhzZL2PooMz9LkNn49MSqtLxQCPMsVS8fIj/VmVjkT9u
         obqzaAi2tVl9wrjxQ66Kfg6wLBLEFkdtnRe3nIwz/MXHaaaQH1w6Wjs0gYxuuGbDhPLU
         XBoXI1wzP8ab7mUSMW0dVSuJ0Wbfbx6++ybExLcZSx6vIXfRb84o8NBQN8fg+91mvslj
         OQww==
X-Forwarded-Encrypted: i=1; AL+hErH4LiP0gKQXrIAE/SAZ/fhtkMuZCqmUHte+7cD+xKUu9khCcq467HuXA+v3I/EL+w08mQehR6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vt0xQi7xyVEKHE3Mkb+KF4AeqLtFXbcLZJe/Dphs1mhIqyM0+
	+wTnPoIO+bokCPGBhcDm4pZHtgwSX/sUU8VomUyfMW0zv9LMp89r4nk1JFnkoBjjuQ0XLOZAlWc
	LC6jg/KN2upmJUmAkZ5UB281W4IIJ2LZK314TrNdCmQ==
X-Gm-Gg: AYBFou3C+iLCXM9Jgrd1pBpzIv0U6FkdI6rIk2NhvxtAFiplhdJ1qHwiOgntwf0Q/4N
	la5Gil+OnqeqkOYMWKR16Be3RPZMUfuYUndItFX6RZaYB84FUECu/xSbpHq/jQ/hMfPdVW9PwEP
	rsK6X8Nta9se/yVIeZ5pT86XlepIV4Hk1DGinL8JjWHai/WExzp5DVKr7Eq/oQ1onKn0GGJ+5yn
	8RSUaJY28jEawp8SPm5PDZwqmLGjoVTf+pliO697bxMvaCWKE5kgLWAhWZZChi+HvxMRqMEeaVd
	mL1SpNt4whDTy4l8OcRPDbaiF3GQGImKPArG7GmbXOMxi4ImMsaC3isFESNz4MQSOJIqi5vpNcc
	f3nGass7m0qG8KDGPtCoU+zjKaoHrNeUiTR4=
X-Received: by 2002:a05:6402:c45:b0:6b3:e89b:126a with SMTP id
 4fb4d7f45d1cf-6b7565f7d6dmr640342a12.12.1794261780736; Mon, 09 Nov 2026
 14:03:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109175752.793130-1-jure.rebernik@luxonis.com> <25204208-5fcc-4b00-b359-86fc5f124700@packett.cool>
In-Reply-To: <25204208-5fcc-4b00-b359-86fc5f124700@packett.cool>
From: Jure Rebernik <jure.rebernik@luxonis.com>
Date: Mon, 9 Nov 2026 23:02:49 +0100
X-Gm-Features: AclHuK-cvftGYpN4mqto5HWIYSl8oeGTMovdxZCsAtUy9fF3sq2BZncPc5FuUyM
Message-ID: <CAD9jT+r2gBSbcO7CVu_YLhiJja4PDs6O=7v5g-VM_RYx07=4Jw@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: pas: Request stop before tearing down
 GLINK and SMD
To: Val Packett <val@packett.cool>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	konrad.dybcio@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, 
	linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Val,

Thank you for looking at the patch and for offering to test it.

On 11/9/26 10:40 PM, Val Packett wrote:
> I've been seeing crashes in sensorspd like
>
> qcom_q6v5_pas 3700000.remoteproc: fatal error received:
> EX:kernel:0x1:SNS_SEE_I_0:0x10000025:PC=0xf00280b8:LR=0xf001f>
>
> on a Kodiak device (sm7325-motorola-dubai) also cause a whole-SoC reset
> right after logging that, when trying to restart the ADSP.
>
> Those are somewhat random and not too frequent, like once every couple days.
>
> I'll test this patch and see if I no longer end up with my phone
> randomly showing the u-boot menu when I pull it out of my pocket :D

A test on Kodiak would be very welcome, thank you. I should say up
front that I don't expect this patch to change that case, though. Your
log shows a crash that the firmware reported itself:
q6v5_fatal_interrupt() clears the running flag before it reports the
crash, so qcom_q6v5_request_stop() does not send a stop request, with
or without this patch. The patch only moves the request that is sent
for a crash the host reports, such as one triggered through the
debugfs crash file. I could not inject a firmware-reported crash on my
boards, so I would be glad to hear how it behaves on your device
either way.

> Try not to provide the free advertisement right in the commit msg btw,
> and to make it sliiightly less verbose.

Thanks for the feedback, that's fair. I added the note because
generated-content.rst asks for tool use to be noted in the changelog.
I'll wait for comments from Bjorn and Mathieu, and then send a v2 that
cuts it down to one short sentence, moves the details below the ---,
and tightens the rest of the message.

> It looks a bit funny that "stop is a device" but well, it's not like I
> can think of a more elegant solution...

Agreed, it does read a bit oddly. The alternative I could see is a hook
in the remoteproc core that runs before rproc_stop() stops the
subdevices. That would change the core for every driver to fix an
ordering problem inside the qcom drivers, so I kept the change local.
I'm happy to rework it that way if Bjorn or Mathieu prefer it.

Thanks again,
Jure
