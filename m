Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67F383305
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853762; cv=pass; b=uCTWadgPitTPqxEQFV7KGsS92/cGsdSGFsX1oi+VQQ1PYg/ZmnnugggXiOhKXiO8H6Xf5u/AL2IDvLQMxYjfwZV0fMSibBYmt6L1Lt9yLMzTHVg/QnuQrCLXe8xnpNrO2HQwlBYXaewIj4/i1NTyu2uYrebklz2HhMS1dXDyBIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853762; c=relaxed/simple;
	bh=do51Gl5dKXox8vJq4RVAbo30sgZsNyHF3P929jzrUc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuyvND4VbrqntYQo2DkRf3sfl2TF8xmqOUpztTC7hWeg41IQv9MNCA8U756wdGivOizeGV3N4LwAgTQ/F2dlkzQSzicn6ipoL94hub+tc8VlWfCRmMtH3z2p3po/PW/8e9Nczqb9tBu+xGlPc/dqbUK5xC/Ep2vPkEBSfrw0QVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2eTbU+c; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2eTbU+c"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c74c469e8so878741fa.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787853759; cv=none;
        d=google.com; s=arc-20260327;
        b=pM61944ZFImwhLdQiuKWNR6/qUk6cpya0yUEDrhinoKtj5wPlcj3ToHOm42l8+Ktyo
         ZgEPZEzvxP5VTZoI6HUMI4/3/yh/qD4z2pwJc6LZru3L7+bJvHmfYcsuGwJvOI5kTWvE
         1xpLL97bSOznFKxF0FNhjLKRiFpfl/iEKq/jnbrphHpr2kE7TZkVd05cbBiF7uo3iD3s
         U4t2tgaFENRbkE6zT89fXluPWo9XPJULcqzya6pKZd1HUfWIVBW3S33expa6Brqh8OBZ
         5AgEhlQWOC1qVLn5XxatDElv7weAEWxiALhjQQjTODAI4nrARVZt7Lv1PooPsYjffsmr
         wntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=do51Gl5dKXox8vJq4RVAbo30sgZsNyHF3P929jzrUc0=;
        fh=KAYlTOV5X4pDdGjv20j7w5T78cT5Y4wk5UobjGcelbk=;
        b=K/AGV4YK7pVz35JJsUVStTcJSgpEZbKUmdXl5S3plKAJ5y7Upofbr3Rcbi8CUwJwQf
         rzAjqcFjVoFKrGShYJ0arHo58pdA2FTFHs4bk8vhhieWlsqVQyiELPXPIB0ijDkJLQ88
         F2n7YYXj4NNw/AxOaRyodveOXUkruKLO6YstjfjYYnGRu1ncCuCKOZtcpN/TevVhYcNL
         KlOnNWs8gQjaE67VNQ6iSB2DHYWwBFNTSi3EBZwigBELunl/5JXjobVyu2tcnrsJ9RcU
         qTnBC2LWUZYYiW6rmO3fdQyvoAW1k0TW/MIIADU0gGC1xN970xbqCDqKaAzKdQvi309c
         42Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787853759; x=1788458559; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=do51Gl5dKXox8vJq4RVAbo30sgZsNyHF3P929jzrUc0=;
        b=n2eTbU+cbSbMUPkABPoMoo/sPQBVCvk2x42AjW51PvgBG2QdJkfraFvAANsPASidPf
         hgKh55SR4U04ozjiNmctMMYi6DdS84DpFDoN2Dda88qInvjcUzOuiq8AaHJ1LjNrqYXd
         BAhTk8QE74rczrC8g2Jh+81993ycn/H9sglMjaRAEGLj3kDriJsfUGVhQPTBVWlfrmnM
         zQ9Wp/bpAoBBunLQ0c8S2qR+05WXHrFYD+5DAGN29/41yzzqdH/t6mpiJ4Kq+Ua+S6s2
         Miiilzi23ZCYmU1UCM3d56SBR7xCR6syP3wZvuI3HC5AgIaTtILZRsvwzhUPpXXaXyxW
         S6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853759; x=1788458559;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=do51Gl5dKXox8vJq4RVAbo30sgZsNyHF3P929jzrUc0=;
        b=rwXXEo3KrpZSUWpcBjfT3QJVTYEKdTmRpXA1aP9emXJtDuE+qDxe9x0y5eU33JULsT
         Pe5KWJqBKVsLbNMdiQORgz2R8SmQTj88PiOYS3hxm+mtVoJQz85h/DtA3y7RWO0nfzVg
         v7u+l+yIo2gunyeVEJMtkVK1pOQto4537Zy6EZn/Q7Ai/PaQs0Iyp75Azpj0Wftj83je
         vkjhIWbEKMQgpro0T+uYqvr1T9cMjwvsMOqkQ8XUmoJRCqVrPjDJ4/3oohfXw2JF0BG2
         qKh2NIGG6tEXY9KeRJ+k+DYp2qHRJ8ea6JzS+bOpwzLWFRbC9whcg2/K6FGjZmj6xqja
         Am1w==
X-Forwarded-Encrypted: i=1; AHgh+RrgnR1uiJm5oj1Idb76v3Ssdm5PmKKz6kssL+t0eYa9/Wp/Qn8PtR/R3rIv3fB+bBgFDbc0A1U=@vger.kernel.org
X-Gm-Message-State: AFuF++kIId3LVy3OCPUqh6sYebas+guQpIkc+GDiV2W6TSxvPrty38Y7
	HhzEH/Vt/fD6kvl1VvFWsiUq6ZyI7Lpayw3To58qziuSY/lZi32GIU7n/2GMn32PoGpUE2MXzhb
	ze58BGb7rlPhFeEcd4P0nXAAEeKNMe3M=
X-Gm-Gg: AR+sD118sFgFoTL2y4AciCJaD28gC0ZJY3yPZfUxkJ6MwUPqc3hTEeYha2m7Nu9K1fy
	0LP4njx4gO5pK2n93UJFCMITI7krlFCA9IHM85mhkUSuQyEJhOAe03/miNeGWqfjUE7nSB2eqU5
	8GGeeRmeaDR7vPrrh6dPWw/QMlvLiR1Fzg6s5oL79VgqxliGWKa9dcZgukTb1WNPgTdRT4KtgQS
	FMw+01uSlWXa/dfAoebbUq6IlsrlO0XALTpJKBC49OfJcnbiCXRQY8sv29eS86qPPmdwalbUGJg
	XmtL2otWPtALdUJ497RQlh7xL37JQeKSBnKktrd3iIbZCY91EBx8gP01es7I7AuEBiYjsOPqfQq
	ddPzY5jC0mc3CO1XtND8B/q8ycQ==
X-Received: by 2002:a05:651c:a11b:10b0:39c:9241:af65 with SMTP id
 38308e7fff4ca-3a301ac1f3amr415741fa.11.1787853758715; Thu, 27 Aug 2026
 11:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827171937.28878-1-gvalkov@gmail.com> <20260827171937.28878-3-gvalkov@gmail.com>
 <15F55ACD-E206-4B79-9E8D-1ED24427BB19@dolcini.it>
In-Reply-To: <15F55ACD-E206-4B79-9E8D-1ED24427BB19@dolcini.it>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 27 Aug 2026 21:02:27 +0300
X-Gm-Features: AcwNN1WhcJL-nGDx-lqXbkS4JNH0Ob2Z7Us1EwrenTLfU7VSU-Ti3TpW8tZnfmw
Message-ID: <CADOrJmae24XCgxFwtHssdoWc4rv1Q743hfgjG=kUrVPgf6urmw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] ARM: dts: armada: WRT3200ACM: add marvell,invalid-reg-hint-in-rom
To: Francesco Dolcini <francesco@dolcini.it>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, rongqianfeng@vivo.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, arend.vanspriel@broadcom.com, 
	peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Aug 2026 at 20:40, Francesco Dolcini <francesco@dolcini.it> wrote:
>
>
>
> On 27 August 2026 19:19:37 CEST, Georgi Valkov <gvalkov@gmail.com> wrote:
> >WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> >from the mwifiex ROM, which conflicts with the platform regulatory
> >configuration on units sold outside the US market. For example:
> >- phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> >- phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> >- phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> >
> >When the system boots, it detects a conflict between the user selected
> >region and the radios, e.g. BG FR US, and applies extreme restrictions,
> >preventing phy0 from starting on any DFS channel. phy2 works.
> >
> >Add node wifi@1 with a flag marvell,invalid-reg-hint-in-rom to the
> >WRT3200ACM device-tree, which signals mwifiex that its regulatory
> >hint from ROM conflicts with the platform and should be ignored, so the
> >platform regulatory domain can be used. This does not allow the user to
> >change the regulatory config of any radio. It only allows phy0 to start
> >and operate according to its certified configuration. All radios in
> >WRT3200ACM/WRT32x are locked to the hard-coded configuration for which
> >they are certified.
> >
> >On WRT3200ACM, the platform configuration is stored on the devinfo mtd3
> >partition, which is read-only: cert_region=EU modelNumber=WRT3200ACM-EU
> >
> >The Linux kernel sources do not have support for WRT32x. An equivalent
> >patch for these routers has to be sent to OpenWrt.
> >
> >[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> >[2] https://github.com/openwrt/openwrt/issues/9956
> >
> >Cc: stable@vger.kernel.org
>
> This whole series is not material for stable. Please drop thia tag from all the patches.

Dropped CC: stable from all patches, and sent v9:
https://lore.kernel.org/linux-wireless/20260827175850.89395-1-gvalkov@gmail.com/T/#t

Thank you!
Georgi Valkov
