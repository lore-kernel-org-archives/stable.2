Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990790;
	b=mOzZ9LEUYWPxOJ0+RO7Wm+MZHjxXaE9DOq/XZf+eMPFort7PkHqAZR49VvVO0lJDThTJ
	 GfSzG9yXv04aa/NOD4xJSKsOMrp5zpMe6HPPppAhjtMzcPu8GjgO/Vd4rkppw/BmtGeXN
	 ASoBoLVkI94CSttYWHzdkeesczYoRdnll4ZtN3EPA+F/zWrE+pm3PDe3VDBI7O1iRZ5eY
	 h9sHZFd8IvCbIAw3jps+hJ9BeX/N6QyTk4J9/pgPLKBNsQHZ1IfUfsLjHrpf0sBZUFM3T
	 w9MAtSl4gda/OSkkU+J7UNBHRnkHa/R38ytOxDVQni3sf9J6Y8Hc2ftGdoxLhLtbSNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990790;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NLmt/AZKtREcaDKgDQ5NlYZMhl4LgJCsucH6I4F3Shw=;
	b=5DdnE1ghiOLmdHQEz52yvB9TV6l6+5xZUAHsnH2bEQZzPHRSPYrAKq6fWkE/p+j/QKhE
	 +wIy5T/RtXtcmItWcMM2AoO9A+qwolnQT78JEwdTQEraKvvXYr6gmYtZFMSXap/uNQxiC
	 RRqybxls9p1PQNG8Iu6uGD++rxs+pzUDM0QJy1LQmci8xiuaxu2S8ejRD4SDiv9cmu+MH
	 A0MZD/c3cxhnQsUeaJwlYEBm4iP+wuo+GkfrhZlEflt9ll20fWeoM1pqcPCb/Lho1a+qF
	 vQeQvS6mRx8juQunxR3ldyZn6IGIgvmGPTW+ClAT3gq2rOPZEbwfOqBMU98tovwMTTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWdb2xS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C470606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWdb2xS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182C11F031F0
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792990789;
	bh=NLmt/AZKtREcaDKgDQ5NlYZMhl4LgJCsucH6I4F3Shw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EWdb2xS9oApBjg6p4ixceDJP4tSn2ThGDTvC15VYpUt6HTPFG9HSua/JRoRQNf4Ad
	 3my1oSTlvTDcqr8JI93hLcbdXxMRWE9BIrWViKyhR5jfvH3eK1uxm+DrsxvIg4HXkg
	 aezUSpZffI7eKg/WRfU3ofk156e7lKFohlPpmyJWGacg2TvhjZj4Kn1kun4EOXQRa6
	 d4NTypTpEM6qYx6WL2BqtZkS/yB5mVfbSCS1lyXlaQ4ZBIutquqh7yJ67GmiSGPPGM
	 htxDsN03VPFt1kvtZfqd21a5ruB8iMryMsqBBOQ8UAfN+haQfbeBbc+ttWkmCeEaKp
	 UTv5C+Omv/Kzg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso3697037a12.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxdVIP2Gobj1wCMoF0WKBkxu2TkGaSRTMvLpa117gaS7PTZ2lPSHOq7lsY6b3F7N3DYcAJnvS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNs2btCJ64lHOKHCZuz0tO4m/FKo4M4dfpqnuewOxBdB4mB2ic
	j0244IzTVR1qdOo/h1EAzOwOcGZ6IK04aL42mefu1FMCw6VL4o4hCDn9jqWrj+QSc5PqXz8G5bD
	frNcdu/UZ+8kU+FuhruY5caUYEdEKnBA=
X-Received: by 2002:a05:6402:e08:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b443a2fee7mr6790635a12.10.1792990787933; Sun, 25 Oct 2026
 21:59:47 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 25 Oct 2026 21:59:36 -0700
X-Gmail-Original-Message-ID: <CACRMN=cR0P0ETKLKkM2k67Kuv5oe4+gz8vY8DhhuZGZ6LiCGhQ@mail.gmail.com>
X-Gm-Features: AclHuK9u7vjAQCLxUR5sEBpiJHi39rWIfcPdQhFAQgsEzk2KJz-ZGO2-0-6Y7xs
Message-ID: <CACRMN=cR0P0ETKLKkM2k67Kuv5oe4+gz8vY8DhhuZGZ6LiCGhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] of: property: Make fw_devlink follow GPIO, PWM and
 clock nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:00=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> This series fixes an fw_devlink supplier-resolution problem reported by
> Leonardo Costa while using a Devicetree nexus to describe GPIO and PWM
> resources routed through an LVDS connector. Consumers referencing the
> nexus could remain deferred because fw_devlink linked them to the nexus
> rather than to the providers selected by gpio-map and pwm-map. [1]
>
> GPIO, PWM and clock consumer APIs use of_parse_phandle_with_args_map()
> to resolve specifiers through gpio-map, pwm-map and clock-map
> properties. The corresponding fw_devlink parsers use direct phandle
> parsing instead. Given a consumer which references a nexus, the consumer
> API and fw_devlink therefore resolve the reference to different nodes:
>
>   consumer API:  consumer -> nexus -> mapped provider
>   fw_devlink:    consumer -> nexus
>
> A nexus is a translation node rather than the resource provider and need
> not have a driver. The link to it can consequently remain unresolved and
> defer the consumer even though the mapped provider is available.
>
> Make the fw_devlink GPIO, PWM and clock parsers use the same map-aware
> resolver as their consumer APIs. The resolver also handles valid direct
> references by returning the original provider when no map is present.
> Use dedicated exact-name and suffix declaration macros to opt these
> bindings into map-aware parsing without changing unrelated property
> parsers. Retain GPIO's existing exclusions and compatibility handling.
>
> Since fw_devlink runs the resolver for every consumer when its device is
> created, patch 1 first fixes a stack buffer overflow in the resolver
> when the provider referenced by the consumer has more than
> MAX_PHANDLE_ARGS cells.
>
> The regression tests call the OF add_links operation and verify that a
> mapped reference creates exactly one link to the provider selected by
> the referenced map entry, not to the nexus. They also cover valid direct
> references. The GPIO tests exercise all property spellings recognized by
> fw_devlink, including the deprecated singular and unprefixed forms.
>
> The clock patch fixes aacc54c67869 ("clk: Add support for clock nexus dt
> bindings"), which has been in clk-next and linux-next with the same hash
> since next-20260907. There is no build-time dependency on it, but the
> clock patch should not reach mainline before it. The series applies to
> next-20261014.
>
> Tested with:
>   - The CONFIG_OF_UNITTEST cases under QEMU/x86_64: all passed. With the
>     fw_devlink parser changes reverted, exactly the six mapped consumer
>     cases fail.
>   - W=3D1 builds of each patch on arm64, including the OF unittest data
>   - Toradex Verdin iMX8M Plus hardware using a connector nexus for the
>     display GPIO and PWM resources (v2, same fw_devlink changes): the
>     display probes successfully
>
> [1] https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jba=
uradujrre@gc5nbdhhixaf/

Thanks for the patch series to keep this updated! Took a close look at
all the patches and they mostly look good.

Left some minor comments. Should be easy to address/clarify.

When they are addressed:
Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks,
Saravana

>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> ---
> Changes in v3:
> - New patch 1 fixing a stack overflow in
>   of_parse_phandle_with_args_map() (Uwe)
> - Tests: route map entries to different providers and reference a
>   non-first entry with non-zero cells (Herve)
> - Collected R-b tags
> - Rebased onto next-20261014
> - Link to v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v=
2-0-17ac82dbe226@toradex.com
>
> Changes in v2:
> - Split the unit tests into per-resource follow-up commits
> - Added clock nexus as well because the clock nexus series was merged:
>   https://lore.kernel.org/all/20260807-schneider-v7-2-rc1-eip201-upstream=
-v5-0-8785f9531cf0@bootlin.com/
> - Link to v1: https://lore.kernel.org/r/20260902-fw-devlink-nexus-ready-v=
1-0-68fe1996e78a@toradex.com
>
> ---
> Ernest Van Hoecke (8):
>       of: base: Fix stack overflow in of_parse_phandle_with_args_map()
>       of: property: fw_devlink: Follow GPIO nexus maps
>       of: property: fw_devlink: Report unsupported supplier linking
>       of: unittest: Test fw_devlink with GPIO nexus maps
>       of: property: fw_devlink: Follow PWM nexus maps
>       of: unittest: Test fw_devlink with PWM nexus maps
>       of: property: fw_devlink: Follow clock nexus maps
>       of: unittest: Test fw_devlink with clock nexus maps
>
>  drivers/of/base.c                           |  5 ++
>  drivers/of/property.c                       | 53 ++++++++++++++-----
>  drivers/of/unittest-data/tests-phandle.dtsi | 81 +++++++++++++++++++++++=
++++++
>  drivers/of/unittest.c                       | 79 +++++++++++++++++++++++=
+++++
>  4 files changed, 205 insertions(+), 13 deletions(-)
> ---
> base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
> change-id: 20260901-fw-devlink-nexus-ready-c859706b019d
>
> Best regards,
> --
> Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
