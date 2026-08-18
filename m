Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD6448B9C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047098; cv=pass; b=lkHMmn5YPiu6j6bNMrVtugfZYL6h5Or7Bkk7upop4SMIKl9DeUkwW7nrYVNBRaGyrkttQwN8RWrROtYVmaMf1XZIt31JNyTJw016CZjsxpmbT+qD70cOxri1TeGGMsepVkssX7S2oXB27Wa5mBwy+UrJJoQIUEkdXdogOqVXDCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047098; c=relaxed/simple;
	bh=v7X5fOOgkMN7zwozDWTMmdpVAqvNyDVzElCQ5lmWHdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRkh64evusesck/H6LF4hYpr1nw4IcKaHXuFcmU2ZX3Yj61WbyxEjUHhtJenGCVrq542bBeDwkAzG1STp+vs3yGUtheoBkJReWQMv33yXqVzi18KxE81jqhk5W6Ky946vdpccNXXsx28G+3w28oL77lIkZmD7PVyOMXjlYEEqig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTn1BIgF; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTn1BIgF"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b159850b16so4197138e87.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787047095; cv=none;
        d=google.com; s=arc-20260327;
        b=iHS2lmCgU+9c1XEovQKw0o6P6cT/1fkCPouyo1UOlYLJ6MO9T9NcPS8z5kULt9h9wk
         9K4KAK2Aj17f1I19H7k8SmxdPs06pK+79Y53U7xb4SPRtfgsHita+jw1MvyHNim9Kxac
         peB7CDy30PNn3Y9vZ8hJhcLzLfTAig0/NZqJfCvBlENVAqsGosfUT28TNy1lyJGb5t6M
         +0TuALWtSoWxffyEv1nJaGPMZeo12iS32ZyFEC5s4AIxLgkzugmMxG8iV4kWBBFj1Vk8
         w9h+BkcsD65aXfQHl+RHSJmGEmFEjxBAe7mksE/qRfFfomH8mAcEUp6Vx7/TV1598vNR
         ysrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wB5u1mD3caKiv5VwodTINCWhAlYduQugf9/JTmV6yLg=;
        fh=o1J3G540joER4jerVNGoYZqpuT9UqHegLUwiNRfq/Ys=;
        b=GprV+2MpqScZT/YnU9I3rvkpLebk5TeLRBVhswsdbsDoIeMguagvy1XHpGO2AZDF0g
         4p0IHiq2OioC5diWYa7Z78njG5S38KPFURNWNH2uikfuaOhTEZSbB3iQv6xVx3nR9Jii
         IPIuNMJ0jCRz4vqrn6lwnx1ucAmoC1O6VwwKlkzpjEAmj5Yq9joN8sBcMIOU8VQHj1aQ
         fyzc/VnPLdzKamQxPpeuTvdUonQ8d+6fxVnuJcpEvpRcDFdxVhAcRI/9VQC8G7pBoGiv
         6lSqsv0nrfhUD+38x/RvgQFZfjMsRu2inBW+zfUJIM5VnObXbVUfHlwFHog5F/s3coCy
         6Lpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787047095; x=1787651895; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wB5u1mD3caKiv5VwodTINCWhAlYduQugf9/JTmV6yLg=;
        b=XTn1BIgFrgnNUBoTe47C0ZSHKKiP97okpPyS1BjPkb1qn+3DbdNtn6UvsTNpQPcwED
         PCR/IqGBZmSfV6SW6NiR42WxSnAx1kc++wDHZ20Mf3KeL05wHYDrMqlYtK/5pn00Ghju
         twFU2mwtnVNZqjCRU5I099xRuq+J+319Pa+CsrBrCJIk4rK+cQGFC3cIpSkw/9QZuv4Z
         oyTSdAsrcJLRK+vXKQlH1qMESygSNW8qTc/CTBlPcLfwQmdU3JsYplnEDRCmVtN9QS/t
         nx5+Y8WuJdgT9dy+xJA79XM+/q5oTae6Itv+GL1nYNUzdPUy3ZMu0Cc28eZXF75T2Npn
         z6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047095; x=1787651895;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wB5u1mD3caKiv5VwodTINCWhAlYduQugf9/JTmV6yLg=;
        b=Jv7BA5J9+QPdzi2BZzzrd1us0VKFVW3lL32OZUC0qAH91Aq0Ak5wZWt/ThhLJ1xtX0
         VnuNlQ/NfxeBuuc8PF3U2NiDs1DymwzYekXM3AyeisHe8kn1W8d3uv4pwQ76FpHgCrHe
         SGi5t9MC4O6OAyrAJp3NK4PQkTUfpctMU7qLATa4Q4mDSJptbBIWhYWHEZN5j/Jy0pOh
         WdB8albfto4itTFpacZoKgMAAPJg6gb35qd0BQzu/vtS9TktZxL9es3svocUiF5Zb689
         Az63N9rNo09mvHs5Z7dgnv7bnH/mKtYM5/QiVG0Eaj3yz1odQOxKkaU+uRWey/S7t3xC
         svRw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9csiKHT8TvIKX4/eFJ1/4Z88+ZKj7Odrw58XF8tFYz23un7YMschTmeEDto3TXprUXsTIVnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMxrskskOyt9+kn063BWiPG6bpXezX78RnRFtnsvgQ4NMBup/
	2bMokBOpW9kIQdqpp4rnYRVr8J0vX7US2o0dE/WqrBtmmTLyBzOlJJvrsqoXmyQMaCvNAAD+7Ok
	jQx/IDcySvz9j4qs5Kx/324OdIh2ReLw=
X-Gm-Gg: AR+sD11V7Htwcv4lwuZR9KQPHtSi24FWUmV37j2/ajVhtfxGTuqIsOWBUw0awLaJeJq
	1Ef7b15Y3LwcbKvmQ5S2ZtXh6Pgk4b/lZaotvk5AVT3Ul+0f26YmtOl/V5M+X9W1BM+JihDOE21
	YqApqjBZHjTad7vx0r76vAagCealkg4FkA3qyohhyd9kGaprh3nzPxO4itpgGngvsl39rdWhr+4
	BBsd75+WSxHOOszqL4NoiJP9L2zth5/uzMN29C6u4yNB/2soiBNmwFh+ajKWtG0SCdOI+yG3cKx
	Ftp+shJMHwk6q5gkslOParsiW7YVlOfOnH33rsXn9ccLsIWP4QrOJo5R5V+jvIP0O/9g0ULaAVM
	uqxPa3fkHAuADuntjYN2qwJMw2w==
X-Received: by 2002:a05:6512:3d12:b0:5b3:c15:c688 with SMTP id
 2adb3069b0e04-5b470661ef1mr1563289e87.7.1787047094580; Tue, 18 Aug 2026
 02:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com> <c10c5132-1bac-4bf7-acd5-1319ce072eaa@lunn.ch>
In-Reply-To: <c10c5132-1bac-4bf7-acd5-1319ce072eaa@lunn.ch>
From: George Valkov <gvalkov@gmail.com>
Date: Tue, 18 Aug 2026 12:58:03 +0300
X-Gm-Features: AcwNN1XJfTB43bmjv2TjXUd_fF7J3LtyinrySWzpxtBcHtKj_KY-OKWZu5UgGM4
Message-ID: <CADOrJmZpJo+MDZpaAC=cGv-i_ZZ0wNjWsMP-dttnE3aQPpHLMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
To: Andrew Lunn <andrew@lunn.ch>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, krzk+dt@kernel.org, 
	francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Aug 2026 at 03:53, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +  marvell,ignore-regulatory-hint:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Ignore an incorrect regulatory hint from ROM,
> > +      so userspace can set the correct regulatory domain.
> > +
>
> Maybe this has been discussed in a previous version of this patch...
>
> What is Marvell specific here? I assume any vendor can mess up, and
> make a US only device, but ship it elsewhere.

I don't recall any previous discussion on that topic, other than the
use of a root flag in v3, which was objected to, because
marvell,ignore-regulatory-hint does not belong there. I assume this is
due to the marvell prefix. I guess we can have a generic flag?
Implementation instructions, along with good design patterns are
warmly welcomed.

I like the idea of implementing a standardised approach, which is
scalable to any platform or driver that needs this quirk. I would also
like to add this feature to mwlwifi (not part of Linux), because the
main radios (88W8964) on WRT3200ACM have a hard-coded region of 98
(non-standard EU, translated to FR because it's the most restrictive).
This way I can set my correct region: BG.

In theory it is possible for other vendors to make the same mess. I
think the chances are very low, because they would violate
regulations. The story with this Linksys router is special:
It was designed and marketed to be OpenWrt compatible. Likely because
open-source gives a lot of power they made sure the hands of all users
are well tied-up: all radios use proprietary firmware and are
locked-down to their certified region in ROM. They do not allow
anything related to regions to be set. A third radio 88W8887 using the
mwifiex driver was added with the sole purpose to monitor for radars:
this idea was later abandoned. I do not have any information about
this choice, but my educated guess is that using a US radio created a
conflict and they disabled support for this radio to avoid it.

openwrt-ai:
https://github.com/openwrt/openwrt/pull/24458#pullrequestreview-4956971863
TLDR: It suggests that the compatible string should be marvell,sd8887
instead of marvell,sd8897. The string it suggested is not documented
and would need more changes, which I hope to avoid. I prefer keeping
things simple. The string I used works and is documented.

Sashiko-bot complained that patch 2 adds a flag to the device-tree,
with no support in the driver. Patch 3 adds support in the driver. Let
me know if I should reorder them?

Greetings!

Georgi Valkov
