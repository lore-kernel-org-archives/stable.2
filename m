Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288938;
	b=kmEdh1FbBjiFluV5anBrb9tuGrhicVsBlHgfsf77IxAIeA/GfKImfwwsZqczAvFc4nB1
	 9Vs8Cvnuon16SMxIza2+6iJIid8yPJc9s3R0Qidxr2xo8gUqp/tSwPzBFzXlL+jqk5A2o
	 hLkuZg8thsfQrF4bj4ofdsMfYqfh73U2MDxBgwiddSP/XmTebUpBCYxhZVJlhbgJjG4SQ
	 Rifz7TUQ+ay922TjjL3vzwwr9gyNtY04aPV13fw9girtGZRwrpYFkL8VY1+XRWHM05IvY
	 mzR2vhxT3hLpT+EH/2yrd05+ghf2UYFAKbWgT5mT8n2PyVvly3w0YkOUnKhdYXsXFJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=eeEUmGxrMpMZqWG1Qts6PPxT81+Hv3D75laR0be6LSA=;
	b=XTEMSieldg0l85yrXITV01t0C7oylq22CqteZdSSbEt6AuO9eY4mnfW3JS6zUfnbb43E
	 ixBOXSRfxxwvzU/z5snK+u2uKzbKGC/UfoSliA869UKAj2tnICmYS2BIb2vqcnRu2Sdpg
	 Oge8TxLSNTFd0fC51IyBDkdAWcCIfLJIckQNFFosPytxzYM2sWoF0mtWT2hZ/hf6d9Huy
	 da9QkvyFRusP4oFTKdR2Il8dpLOAYy1pvZkj+gd/B8kCFnMzOjPsH2GbVuo7y3qBF86x3
	 vpvy2EioubBHoGwVLaS3DdfFss1fkJSt+Bww0b5dLf1qjFjJHrSu0KonhjlkY3CZy+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hA3HvPav;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A4606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59A4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hA3HvPav
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1849187f8f.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793288936; x=1793893736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eeEUmGxrMpMZqWG1Qts6PPxT81+Hv3D75laR0be6LSA=;
        b=hA3HvPavX2sHuUPiuFsemzRqz5ehY9s6we+dmLmLNMdWvuWI51GSFgjG4swuVOc98Y
         JUSdketNBfRTtLKbg4LQVRDYc63Jwl9ofkc/SFJQC9Hfu2maQKWnkpXQ/SKWM2FGSNj8
         9FRbFhNq8e3DvEcYicBhDtn81JQOunMt0dkYcmKjbyIP13WaO1kqVByk1aAdn28Vwcf9
         NV0szqzQIGCwyJ6Et409rdEk95YXNDl1Ac0JYAnfr19ZzKfCH8PuPr4v+aF1qDC07WFX
         WERRvXibFIVnR9BZstGjP3XLU++Eb3TaA6IDyD4rdRfX/ZDR+0ahK55+PUk5nM2eondb
         ZQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288936; x=1793893736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eeEUmGxrMpMZqWG1Qts6PPxT81+Hv3D75laR0be6LSA=;
        b=FaNdRPWxsp6lzXTSB6oiRfLOZV8qBtbPBl9RmO9jp6YDsZBFlHi0MlmcKbVSHT3EjN
         XIW0moZsYWNUjGD5BXNBHiXHbWRV7IAae/KskBg8T3y3WUAcBckbsazMYQQXuYBfnm2S
         anzd/zkIKc3NYOjWL6VhaNi7AcGWg9njvVrVhu0v6Bz1GPPibHFeOkQeKt8GeM3B426e
         D+CpixhWVwBkQTqPsGOJCqbNYYCAe9g7qxry7kAe3er7Lo/U4Cs7mRIVCD3iEsk0yJ9S
         AwCpsJCwVwJTymSqMRO3U79fx08LJxOu0LspT/EmJzGv1UOrGqLsv3+tdLcB9MKecW/g
         YaFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZi7ck/YXMFfl1R1yjzlFngNYjbUoIRP3neRtE41Gr0lCx5I8RfyNv4QnPAf9H9/WqWKZSbfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL80M78IcuCgKjVuAtmbccjiY0kFCbseIS2O5ez7U32Tq+8xQ3P
	BJpr0S0/VSgb5VE/yuWy0rXP1Zrb0RU3x5aysed+VTyfXOXHWpR/9r5l
X-Gm-Gg: AYBFou3mKcYY6FOkCQXu/7g80QZUXIysvE2AuYZ5MLz6mXvWdnBT2ILQgYvvnnpI01Q
	DPS+7op30M+wdS8aMEXkanbGUjns/Mn0W7Y4tnZWYYUOuuM6oW23NKciqh0KAASCsvoUs6ISFAD
	w7LGxxN9UZ070YhlugwWeZYET1O1l8aZ/I30ekl14AvJoFkkzxCC9UW83eTYINeLoziFmodjksP
	kiZ0fbUo7zMF3pyN9M6BTBNMV0On1wy0EzoX4Lq8j7P0TbB+AIKziH9KPllKtpn/kgtYToRLT5r
	kDFfaNXj34WIFKW3uopocnf7B1XwX9B3Ch9KXOnV0k2fBAILFo+FnJjotItfMtKMf07ZvlLjLXH
	ytuILDVwR6MuHzeaJWtZzhMe8q3K/YyjgKrQUS+Q3xSVeMto65G/1diXgZmCoYsn1bIfts9WH7g
	v3tcSGebjE+1KTH/jqyzEqSN7KX3lq9eRfT/LOH1L1g0t1dVMF3c5hETqlkpgkJl3+gvlX+jaUx
	JELfuvOwcMtlODTz8OWWTqF8cKURBCevnCuAJXUtuF2YvCWI097tT8xU0ODF5+u72UJ+zCwF42C
	S4jDeDqVprhzWkv0GHEIyAR+YfgXdAQo+bWNYt+1qkjJuBF0yebIz6zE57V0sL01ZWmE0nWokrk
	Zv2IEHB5FCJ7l4cVilISe7g3p5HgTNf6nOnZ5Orn+FnhOA7EKdE/IcgzX
X-Received: by 2002:a05:6000:1a8c:b0:48d:eec6:308b with SMTP id ffacd0b85a97d-48e5d2ecf6fmr13635522f8f.21.1793288935685;
        Thu, 29 Oct 2026 08:48:55 -0700 (PDT)
Received: from ernest.hoecke-nb (static-2a02-1368-6200-2fbc-d3e8-e0a5-7e8a-a15c.cust.swissbackbone.net. [2a02:1368:6200:2fbc:d3e8:e0a5:7e8a:a15c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm38102304f8f.48.2026.10.29.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:48:54 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:48:53 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Saravana Kannan <saravanak@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Leonardo Costa <leonardo.costa@toradex.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/8] of: property: Make fw_devlink follow GPIO, PWM
 and clock nexus maps
Message-ID: <33yzkmwkcyzhmoyxcotdsnsy3mddkueyjyvlqno2qlio5tjziy@cf6a6dxfctlz>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
 <CACRMN=cR0P0ETKLKkM2k67Kuv5oe4+gz8vY8DhhuZGZ6LiCGhQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRMN=cR0P0ETKLKkM2k67Kuv5oe4+gz8vY8DhhuZGZ6LiCGhQ@mail.gmail.com>

On Sun, Oct 25, 2026 at 09:59:36PM -0700, Saravana Kannan wrote:
> On Tue, Oct 20, 2026 at 6:00 AM Ernest Van Hoecke
> <ernestvanhoecke@gmail.com> wrote:
> >
> > This series fixes an fw_devlink supplier-resolution problem reported by
> > Leonardo Costa while using a Devicetree nexus to describe GPIO and PWM
> > resources routed through an LVDS connector. Consumers referencing the
> > nexus could remain deferred because fw_devlink linked them to the nexus
> > rather than to the providers selected by gpio-map and pwm-map. [1]
> >
> > GPIO, PWM and clock consumer APIs use of_parse_phandle_with_args_map()
> > to resolve specifiers through gpio-map, pwm-map and clock-map
> > properties. The corresponding fw_devlink parsers use direct phandle
> > parsing instead. Given a consumer which references a nexus, the consumer
> > API and fw_devlink therefore resolve the reference to different nodes:
> >
> >   consumer API:  consumer -> nexus -> mapped provider
> >   fw_devlink:    consumer -> nexus
> >
> > A nexus is a translation node rather than the resource provider and need
> > not have a driver. The link to it can consequently remain unresolved and
> > defer the consumer even though the mapped provider is available.
> >
> > Make the fw_devlink GPIO, PWM and clock parsers use the same map-aware
> > resolver as their consumer APIs. The resolver also handles valid direct
> > references by returning the original provider when no map is present.
> > Use dedicated exact-name and suffix declaration macros to opt these
> > bindings into map-aware parsing without changing unrelated property
> > parsers. Retain GPIO's existing exclusions and compatibility handling.
> >
> > Since fw_devlink runs the resolver for every consumer when its device is
> > created, patch 1 first fixes a stack buffer overflow in the resolver
> > when the provider referenced by the consumer has more than
> > MAX_PHANDLE_ARGS cells.
> >
> > The regression tests call the OF add_links operation and verify that a
> > mapped reference creates exactly one link to the provider selected by
> > the referenced map entry, not to the nexus. They also cover valid direct
> > references. The GPIO tests exercise all property spellings recognized by
> > fw_devlink, including the deprecated singular and unprefixed forms.
> >
> > The clock patch fixes aacc54c67869 ("clk: Add support for clock nexus dt
> > bindings"), which has been in clk-next and linux-next with the same hash
> > since next-20260907. There is no build-time dependency on it, but the
> > clock patch should not reach mainline before it. The series applies to
> > next-20261014.
> >
> > Tested with:
> >   - The CONFIG_OF_UNITTEST cases under QEMU/x86_64: all passed. With the
> >     fw_devlink parser changes reverted, exactly the six mapped consumer
> >     cases fail.
> >   - W=1 builds of each patch on arm64, including the OF unittest data
> >   - Toradex Verdin iMX8M Plus hardware using a connector nexus for the
> >     display GPIO and PWM resources (v2, same fw_devlink changes): the
> >     display probes successfully
> >
> > [1] https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
> 
> Thanks for the patch series to keep this updated! Took a close look at
> all the patches and they mostly look good.
> 
> Left some minor comments. Should be easy to address/clarify.
> 
> When they are addressed:
> Reviewed-by: Saravana Kannan <saravanak@kernel.org>
> 
> Thanks,
> Saravana
> 

Hi Saravana,

Thanks for the review. I will address your comments in v4 which will
follow in December as I'll be away in November.

Thanks,
Ernest

> >
> > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >
> > ---
> > Changes in v3:
> > - New patch 1 fixing a stack overflow in
> >   of_parse_phandle_with_args_map() (Uwe)
> > - Tests: route map entries to different providers and reference a
> >   non-first entry with non-zero cells (Herve)
> > - Collected R-b tags
> > - Rebased onto next-20261014
> > - Link to v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com
> >
> > Changes in v2:
> > - Split the unit tests into per-resource follow-up commits
> > - Added clock nexus as well because the clock nexus series was merged:
> >   https://lore.kernel.org/all/20260807-schneider-v7-2-rc1-eip201-upstream-v5-0-8785f9531cf0@bootlin.com/
> > - Link to v1: https://lore.kernel.org/r/20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com
> >
> > ---
> > Ernest Van Hoecke (8):
> >       of: base: Fix stack overflow in of_parse_phandle_with_args_map()
> >       of: property: fw_devlink: Follow GPIO nexus maps
> >       of: property: fw_devlink: Report unsupported supplier linking
> >       of: unittest: Test fw_devlink with GPIO nexus maps
> >       of: property: fw_devlink: Follow PWM nexus maps
> >       of: unittest: Test fw_devlink with PWM nexus maps
> >       of: property: fw_devlink: Follow clock nexus maps
> >       of: unittest: Test fw_devlink with clock nexus maps
> >
> >  drivers/of/base.c                           |  5 ++
> >  drivers/of/property.c                       | 53 ++++++++++++++-----
> >  drivers/of/unittest-data/tests-phandle.dtsi | 81 +++++++++++++++++++++++++++++
> >  drivers/of/unittest.c                       | 79 ++++++++++++++++++++++++++++
> >  4 files changed, 205 insertions(+), 13 deletions(-)
> > ---
> > base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
> > change-id: 20260901-fw-devlink-nexus-ready-c859706b019d
> >
> > Best regards,
> > --
> > Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >
