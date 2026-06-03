Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31D46AECF
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487682; cv=pass; b=jzd3TFydcjb+ewlq7CVdUHg5RCIfCASjgRw/G8zH5FQ65YhVxGP5/LoI2+S0t6WGQradVTgklk6XNq/D7oSRBE3kEM3sUp5DxOF7O7edTO3pUyu/bissjKQv7PfWtKBrwbyz2veR5XYtbr4QKI8CJn4QXcmPPsEz2zuqkf7IOzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487682; c=relaxed/simple;
	bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhajUiRgYBRhT3EziRG5zfaRyWiL8YbKWBnK+BgvlMC+pIVa+PtwK5Yw0gPOuSRmPhBf/CgeRo2xmXfhgS7hsurwRrPWGxlboEEZpiqhv5AFI7Sxd102nxsYaRgDbe6hGUm2AXOtrCAejYI+YIOeeV6JLdH/UPFpE9RowgLhgRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlYONL+F; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlYONL+F"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4865e953031so432994b6e.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 04:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780487680; cv=none;
        d=google.com; s=arc-20240605;
        b=QryzWT0sGSwyAHVCcLLjNuaQtAt5Plp6nOzhcHme/jUrJr6QePhVtcJyB6Nr2xfGmW
         9v7xkrEuFYaMvYm3k+4M3qYRV2Mtj0+7PadHremy6td+IpVc+PAGYCL30Z1Uyqx4Xrbf
         Rryt9SAxx1DVIOWrHSEOrJI7iHGoJBQA4GaCAvBdqOhcLpMvOtFRfM1Bt5VytRkYlSMp
         /PbNc1psG/VJLozxAk2EbJOC9lLpak1ntoC91dufdPFGxAc/CQ2ovo0BqevRBxwIIG6Y
         cxY30zBym52ZHWdIHHTG9Nd5VjuLjoH+9AK6uxv7L4To9nXQOsZWVsCwahW7qTiKHpVv
         88WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
        fh=zTNpSoCVnsyrPjBRDbJZdSkj7ATkfaRBe29yd5xc2UU=;
        b=aqc+njQPdkUSVW9x1IE6GDmAGqaSsbUryOzKiWGfYIndi07CIpCZ/S56zxY9I4gP3a
         +cQDA6HyQ7BEMCVWnTZCodf6kvRSoBlC4a3ZDKeiu/UDre38o/8JZ9nuOY8PfkXX5BJt
         PwajKNXfRghx1KikM7Y8p7m83eU5feCUNvkCf8VTo4jHkrvkUFRRqv84/hFbWf8nyiFh
         kQRpHBsaqiCYcw7blM65r9z9iS1gO5QixJNdUKjbL6rx9Df+QnIJ+40XTA1kYdLLn+FZ
         +8l3U4X98Y+MVQQ+CZxE6nZZdl9UM30Ge7rW8ClpZhNyv8zuoYgxVI4ezpxaQiHYQTom
         QdeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780487680; x=1781092480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
        b=OlYONL+FfqXfXl6maYpHskABjAtWPkHnQe+F/X7rlyGeblWUfp/rXGvGkJ1kl7jCbs
         CW5TLcgeEKR1S/NlU+/CFFdtX6u5ZYphUVD8s0jjCyFhBG+qhqRxwjmtjXbbSxVXGYSh
         1cV+HHYhezTSLNN5LlTzZz7EMq3veBTdd9lsFSL8eK+BdcXJm4wpPWBQ/Z6Hp3fhAjWm
         UW5iniKDnf1Xl0xGjTu50RHZ3+uSx9z6htPQbgSeVTXERF6jzCopy4zH+ec6tyCP7xB8
         67WtpBmpOaC954Ou3FeN9u1Gah7YesvvnYtruVV3FNYp+YoqBolXfVfWRQICSU4jZjyV
         ftBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487680; x=1781092480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
        b=YXXy6UUyZvcVtcpx1wjpL6FvQAKf/foNNG+tmdARYcZVwZca1yvdI8amUdrYCfRfge
         GwhWjwRGlEukaqfQq7B3pmHqSJ9n9ptVb++XWeJmsrwAUFBa694V/bkjPAmMefLwyzuX
         274A4tC9aea0LUoWeibH9WbNq4jdUZAyBE50/KP4YRpxlAVKvELe9lLyTvcWX/Y315sj
         K/GObJmi6h0dD1JEccsJ/iUEAisiaofF7rE06JDjNX9HnK8htF9CFBfRI2Qt7XS7Dyx+
         3L/5wR+xG8vbvV0SjUl0F1OU1FQi8HOTuzMhOYRUr3u4/LTeTeNCYOdtoOlYC6Np2oy2
         tRFA==
X-Forwarded-Encrypted: i=1; AFNElJ/r2M+5vs5LaS9IdVzmbb8CbKveN6BdCNYZqrblSHeDvKF+G5J2mhoSokITTdpH7ohr9Os13is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixpESFiweq3FG2rS0LAeuqK3VhQZpFMfBq0zWsTDs1RbcyR+e
	MAOouKFAKFf8LIBhvtJKNht5bH1HInznSRP4CW3McmTOaPRUqpB+froMMUd6GE4i5iqoMIflEuR
	NsB7Nvo8TlRJsgMLgaD0J4RR1x0QQngI=
X-Gm-Gg: Acq92OHTlQRuiUThQwVuWeQ//ZI3J/dZn0VJ70qmTtw/rqjTnNoZMJh8OiItNQlniPA
	gpjvyPD10CecbAw+cozKdjx9s8Q5zGbrEseovwKFcOiV23NT2hgTo8JxToTnUqqLnyrg+wsZfIP
	cADDrLIHemr+mHGmjGqRArucEerM7LzduE9tgBDdFfObX27DmQI9C/aXjBdeHCSxHjI0C8nY9zd
	E3aik1U5e5KiOfYVsFaiVBCmytvaRTidjCQXijPq5jtQnkxGtRugO6Gn8DNUa6000GtqhXvxUAB
	dPdyEIgoYaAZYfnWrnI=
X-Received: by 2002:a05:6808:1a19:b0:485:724c:36fa with SMTP id
 5614622812f47-4865aaf57c7mr1333684b6e.0.1780487679996; Wed, 03 Jun 2026
 04:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
 <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
 <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com>
 <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net>
 <CA+bbHrXtEdHEDHDb+8KNaKu=ODvkYwjiEEOtU2HntSRb8-WZ5g@mail.gmail.com> <CA+bbHrVbDBwmQnDyEa-Mw1yH8vMSEQa0ZP5CyL+8oaT2rpqpOg@mail.gmail.com>
In-Reply-To: <CA+bbHrVbDBwmQnDyEa-Mw1yH8vMSEQa0ZP5CyL+8oaT2rpqpOg@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 3 Jun 2026 13:54:29 +0200
X-Gm-Features: AVHnY4K3utIg3I6x4sZDLnt_FWV_RmlMsSVk-e9XyJxjPW7_VKnU5hzaspwrUxM
Message-ID: <CA+bbHrUqv=4y7OUQuaheLuoBjp9hnaxw_8WwFOY0o8J4xm-K0Q@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, after my yesterday's email with the tests results. As you can see,
all the cases are working but the 5ghz+VIF+DoS. Will this patch be
added anyway while looking for a fix for this specific case? if so,
from what kernel version will it be available? 7.0 I guess, just to
confirm and update airgeddon wiki-docs.

Thanks and Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mar, 2 jun 2026 a las 10:29, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Hello, sorry for the delay, but here are the tests that were carried out:
>
> -Compiled kernel 7.0.11 using the suggested patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.=
49109-2-lucid_duck@justthetip.ca/
>
> *Tests with Ralink RT3572:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> working
>
> *Tests with MediaTek MT7921U:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> not working (no freeze or error)
>
> -Compiled kernel 7.1-rc6 using same patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.=
49109-2-lucid_duck@justthetip.ca/
>
> *Tests with Ralink RT3572:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> working
>
> *Tests with MediaTek MT7921U:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> not working (no freeze or error)
>
> So exactly the same behavior on both kernels.
>
> Hope it helps. Thanks and regards.
> --
> Oscar
>
> OpenPGP Key: DA9C60E9 ||
> https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> --
> El mi=C3=A9, 20 may 2026 a las 11:55, =C3=93scar Alfonso D=C3=ADaz
> (<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
> >
> > Ok, I'll do the testing using this one you suggested:
> > https://patchwork.kernel.org/project/linux-wireless/patch/2026051923571=
3.49109-2-lucid_duck@justthetip.ca/
> >
> > Thanks.
> > --
> > Oscar
> >
> > OpenPGP Key: DA9C60E9 ||
> > https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> > 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> > --
> >
> > El mi=C3=A9, 20 may 2026 a las 11:53, Johannes Berg
> > (<johannes@sipsolutions.net>) escribi=C3=B3:
> > >
> > > On Wed, 2026-05-20 at 11:51 +0200, =C3=93scar Alfonso D=C3=ADaz wrote=
:
> > > > Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The =
expected
> > > > behavior is as follows:
> > > >
> > > > 6.18 or lower: no need to test, it will not work. It=E2=80=99s clea=
r now that
> > > > this does not matter, since the goal is only to fix newer kernel
> > > > versions.
> > > >
> > > > 6.19: some versions of the 6.19 will crash and others will not. The
> > > > crash was fixed at some point between 6.18.12 and 6.19.12. No need =
to
> > > > test.
> > > >
> > > > 7.0, or 7.1: the expected result is that there will be no crash, an=
d
> > > > VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
> > > > (I'll test both, normal DoS and VIF+DoS). There should be no crash,
> > > > but it will not work.
> > > >
> > > > So I'll focus my testing on 7.0 and 7.1 and I'll get back to you wi=
th
> > > > the results. I'll be testing this patch (v2):
> > > > https://patchwork.kernel.org/project/linux-wireless/patch/202512161=
11909.25076-2-johannes@sipsolutions.net/
> > > >
> > >
> > > Thanks. For testing that one you'd have to revert the other first, I
> > > think, you could also just test this one:
> > >
> > > https://patchwork.kernel.org/project/linux-wireless/patch/20260519235=
713.49109-2-lucid_duck@justthetip.ca/
> > >
> > > But I think they're basically all equivalent.
> > >
> > > Since we eventually need a patch to apply w/o reverting, Devin's is
> > > probably better than my old one.
> > >
> > > johannes
