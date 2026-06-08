Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3803B7756
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908059; cv=none; b=f5DiTYxkEUdrBaOSoUlyWq0xu2lkoZ6hYXcHNKLyoYdaFLgD85mKpiPXvYqV2nBXFcs3h+40LQGQGeUyW/cMwXbVpApoC3/JzWYc4hRkag7kVUrdSNNNZKHoZYIUorT+vw72IMswYOjGr4jYtoAPv3jDosYmwXXfCv23lYjbbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908059; c=relaxed/simple;
	bh=Z1tpQiF5SlWYkxPC/pBiynkFWvlAzchlifLEFft0XF8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nySMAXs6mdU+clVsSv8KX1WH5weSjwNDlH6WoFG9EaUusv2k9+BfRzHnuvGaIqkbBInHWabBWRLs+cg9iT/3EMhEN1OZh2gwT7gHPiOW99QChaxtlODjAZbvFVwJZSOWNHquecntoQRq5hfE9rGcRBqtpWPtR68POWm96aD9Xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtAzf/TG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtAzf/TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0181F0089B
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 08:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780908055;
	bh=4HoT9KIsnYIDd0zvedKTYCGFgVE6ChDhK5tVcTIkXrs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UtAzf/TGWJfwCsNV2Ue5iolZ68yf3f30P6b6WmVzMzBqmmPCvh444Q2e4wBR9DYZC
	 AnxUpcvEVn2Om/u9TmAeMRVOIJcAlsFT0YmOWjrVMVfIRbPKrc9iGS0/Jgf4Qr2NYD
	 MBwOdTvIy/zAkvHr4quF7Wwq4FMCmIDH4DB7ddcjbeIN5xVcDXorm2J96nVOaL/XCC
	 r8l2OPZPij1DKq+wHQbblb/+Tt2+7PzogxDLKgACcK819/76HiKDbpBS0bXE4RuGEG
	 d69BNA98i9BydLxFP1a+/yqre2Wxr8M5vsK9LaX6cTvPy5TevPtps1emBN/QIKPBDS
	 nJrnvZt+BYY4w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so3917909e87.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 01:40:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/760tkLij13DzSqDCQqvyDbzgE4SdILoyKPUXNUMg5k0EfMPJU4ZEdo+rR6z9h09KN82EY/xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6EDI1qFczLRWL2Om4yNRIY0AwMV1588mUSwQ3tNLtPmYE8YM
	jfWm9XBb4S30ShS2guRi8O2qbhHLjX9WydEthM+Q9Zg2Ckny0V02inYDYQUjcRtlUGJq9/16mJz
	xbDHtXc6ZyuouN8/xFO6BcP5fUXb04LZHASZRFWrxrw==
X-Received: by 2002:a05:6512:8046:b0:5aa:6dff:cf0d with SMTP id
 2adb3069b0e04-5aa87bc2279mr2524415e87.28.1780908053800; Mon, 08 Jun 2026
 01:40:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 01:40:52 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 01:40:52 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com> <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 01:40:52 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdrfyUUyk9sMGVCedyug_JmZQZEQHuK5T6+BRv3AvNT6g@mail.gmail.com>
X-Gm-Features: AVVi8CchM9VaksLWvpKbwHirniTnl6glReoNd3-xvchi05VK9oh9JtbFGYTDxqA
Message-ID: <CAMRc=MdrfyUUyk9sMGVCedyug_JmZQZEQHuK5T6+BRv3AvNT6g@mail.gmail.com>
Subject: Re: [PATCH 05/23] powerpc/powermac: fix OF node refcount
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	stable@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 10:36:28 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().
>
> Cc: stable@vger.kernel.org
> Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
>  		if (bus->platform_dev == NULL)
>  			return -ENOMEM;
>  		bus->platform_dev->dev.platform_data = bus;
> -		bus->platform_dev->dev.of_node = bus->busnode;
> +		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
>  		platform_device_add(bus->platform_dev);
>  	}
>
>
> --
> 2.47.3
>
>

Hi!

Gentle ping for that fix. Can we get this landed for v7.1 or early v7.2 and
make getting the rest of the series upstream easier next cycle?

Bart
