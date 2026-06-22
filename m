Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF35341057
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150215; cv=none; b=hcDsJQFzoBMpgjJOBaa48fqXsQTlnQZsNgoYoZpFGrdGE668JgdeaIf0u7wUFzCmobqh4i4Qn+Oh0fJBf/NHns/Fd++01SN0wIfiPT2oXuNnoNniifsRIDJHGC4bm7BRJSICmxjuuieg+Y9bbljCNsFWoU4ar0T98tIvhBtHSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150215; c=relaxed/simple;
	bh=37n0r5kMauruI+X87up//ZNJGThpP+mu8r7gnCJwuZs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX/hEZj/3AcIVgczlvwdmrYsyIedMKsjRcVMyzg1OKenbTV2LagIGMTOdskK0wlJIlQtuX8AVKtXjJeG/n8VyQlQpec9MwGkatsNQA4uWXENHfD7UjmSTHQn7rgoXRYRi+Nt+FqP2Pu4vaW1XmOtsUpzAmE3/75qhx7Iw6yiw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWs9bj1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWs9bj1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B0D1F01560
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782150212;
	bh=ZOvkxM7SoiYga4F3HI0NRlsezjpo0hLIkN4UO4HHxjU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=bWs9bj1fag5KYrEtQKDWajU/F6qyj+Xj0XywCLK/icvKgyu3zXE8BtiE5VCmzBOIO
	 skOV0vdmfh5mCkma6G1yrE/H1sWckCiKx0kV384oGGNyzktYrin//aZ1A2T9J+RvZq
	 tLhd4ueV9nefHqs6/L55gODvylLnx+BGn1DaSxnxjd+YO5r+feGhhbbldQDXQzrV7q
	 InN3bE5Wk7q70Sq7/fRrBO5JcoyyAgKcaZfkUgqIJcm8KxCXn9dPVJbUuFpObZuXcl
	 40yRt2QoBA60YiGyyZSznJ1lh57IMuMv+WKUqWeRQZyld2GfoWo6fs7ZFdt1rcNYd6
	 YnYd6Pb1v9FZg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so47961311fa.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8eLYCfC10umlN/yDHXKfxlcgSkaH3sptbHWlPVowMSyY0m+XhWTTHd/eORsEKbGsESK3HnC2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNN0xmPJF0WeKin4m+D2LBgOt3X9kOpPwHGzlw5XtcZBkjPgA
	VjVW4G+tqOqbigzog6x5eb7x+arFo6vZLyC+X3BjOI3G3EFmyOsdDlQon0/9GV3AEZUiBXf9hoK
	FUTkJgqlkylXGNIkzVo1Hkqhpy8e5b93ZhgcOfd5Q8g==
X-Received: by 2002:a05:651c:88b:b0:394:635:70b1 with SMTP id
 38308e7fff4ca-3998bc52fbemr41304291fa.3.1782150210743; Mon, 22 Jun 2026
 10:43:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 13:43:29 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 13:43:28 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com> <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 13:43:28 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfSsLt8+CAh++8qo_=F=q5XRu6G3WGB=B2TZj8dTZydfg@mail.gmail.com>
X-Gm-Features: AVVi8CfRnQqz6Nh2M0v3z0C67LQjbAf_AXtOmIr-lp4acya5s7VimMoD1ExGxmc
Message-ID: <CAMRc=MfSsLt8+CAh++8qo_=F=q5XRu6G3WGB=B2TZj8dTZydfg@mail.gmail.com>
Subject: Re: [PATCH 05/23] powerpc/powermac: fix OF node refcount
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, stable@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
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

Madhavan, can you please pick this up and send it upstream as a fix please?
Not having to carry it with the rest of the series will make things easier
for the next release.

Thanks,
Bartosz
