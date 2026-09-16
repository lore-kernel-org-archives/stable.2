Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7662D0C72
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578893; cv=none; b=vAiXhuIFfICVyOGDb2OO0updPjVqCx5h/uXjKMGIypt3jOG9AwSOnsBDBU12XVd58pgzVfJtHfUE7slmz5Gt6tXn/O6gIaSas3jKg0pxuLMYPuRPBCrYZqEBotZwO7E9Ef4Kq5Ft4A27XGEDyq/Wy7WmL8g/vndUh9O8Nz6Qdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578893; c=relaxed/simple;
	bh=Q3hFAz21Puk4qp5OVNLkTKvWHULbnjoIhvvfucWc9Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1j2PsHJsHvyKZqJJIgqO2/Y6jm1QAxkDVPlnxTym/ZKNCwwV4cypVquHkS6EWo6Fm3WJUk7a8P6wapSWUQkdQXkRdJpKOOKbLFUirKeGCDHGC331B1p2kFoEcnqUp6BFE9TO+V876yDf5uFGsvPbvsNeBIAD3V0CRXVGwnEEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWRxEyan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWRxEyan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC7C1F00893
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578890;
	bh=Q3hFAz21Puk4qp5OVNLkTKvWHULbnjoIhvvfucWc9Ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LWRxEyanij8iyqFWzVauR5rek7ibzKqMag8JkJWqC/D54WCmt5VYct+MySEMYaj99
	 FLCBuo7/Bpwy4Ae1rF2ZbimIwE/QVqVVl71hzAUfipJcFri3oLsxI5PfUuurnWv+QI
	 rASRh8bgfT30BPoA3AO0pKgOWDRpEuzc+7pr7MBh3ozCsc8oM3NMOXovnp4QhF0Te/
	 yZTu2HOaFRg4N5y7rDwnmG340Db7yiIYAklQZauANCYZtf1ypWnBoOwcJQYaSVWHNu
	 SLx7GBjhBdebWM4eGY3rICp9mq2G4fKqHN9Uk9WlCESVE5DC+x7VpTbesUZAw5o945
	 MQH6UxWBXWELQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso1264223e87.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:14:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxsp5XLutqNVdZcu8ycXuedJGLxbw7BxKSEVy6BzM9zB3KRA3vwAd6BZiWoLDGiBlPxQ+vT35M=@vger.kernel.org
X-Gm-Message-State: AFuF++liTBpoGLk6oizlpSCTgRTmyH4lVwI3iE4y2j4eYN6JlnVpZ88q
	LXOoXIdDWXoszufu1HdUQqHHXIMOj0KNMHmAxS1wJdZyG0kgQ5AowxEWBi/yQhIqmprx+iHAZYx
	eTmKBBnq35qaMp2/kEnvLmzCSAVCkisU=
X-Received: by 2002:a05:6512:3c94:b0:5b4:97db:b740 with SMTP id
 2adb3069b0e04-5b8b6646174mr1819762e87.20.1789578889250; Wed, 16 Sep 2026
 10:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com> <20260910-fw-devlink-nexus-ready-v2-1-17ac82dbe226@toradex.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-1-17ac82dbe226@toradex.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:14:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLn2LmvsO2PNh0AVcTJULTRFazANBaTOJCYcL5TgvyoDFA@mail.gmail.com>
X-Gm-Features: AcwNN1WrC5AS_PRz3Sq427sJhJfk8k29uqMAQRw-Dbr4KzlXEKv1HU-8tHH5OjQ
Message-ID: <CAD++jLn2LmvsO2PNh0AVcTJULTRFazANBaTOJCYcL5TgvyoDFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] of: property: fw_devlink: Follow GPIO nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:16=E2=80=AFPM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> GPIO consumers use of_parse_phandle_with_args_map() to resolve
> specifiers through gpio-map properties. fw_devlink instead parses GPIO
> properties as direct phandle references, so it records the nexus node as
> the supplier rather than the mapped GPIO provider.
>
> A nexus is a translation node, not the GPIO provider, and need not be
> populated as a device. The resulting fwnode link can therefore remain
> unresolved and indefinitely defer the consumer while
> device_links_check_suppliers() waits for the nexus.
>
> Use the map-aware parser for all supported GPIO property spellings. This
> makes fw_devlink resolve the same provider as the GPIO consumer API.
> Direct GPIO references continue to work because the map-aware parser
> returns the original provider when no gpio-map property is present.
>
> Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt=
-parent, dmas and -gpio(s)")
> Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
> Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4j=
bauradujrre@gc5nbdhhixaf/
> Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
