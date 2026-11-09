Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237495;
	b=vZ8dAiOpuADBkPS1AXjlWOIPlhzSFHodMAE8r0lNDuqkRmgnVry+TNPa9OoboRvHuuoi
	 d6/fWm47jKjuzTG9qR7UtIHK8HRDqVJhBg/b8O11kxOW/ws6ufAL1ZZ1srgQlvlCdg6ZW
	 fjukQrFf4VOvLEGFUFkBsMGxFz41LI3wIVsRV7Zqa9gBzaCBhseFCKp14iHPGotjazofe
	 cXwd9o1mYvjoULZXVFcxxVZNAYFotCkEjWO0sBIOgRMCb0e3EEcKGNeJUdsf4ZKTn7iAQ
	 ErEAX1hnkxdP0Ep/KRX32EAyRLLDIHM3uHRV9+vFaVTqKh4dMFKjmZS0IOJjTAJRctA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237495;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Tq7znQYoOkVkkKUAJEz3ffT9r3etLqc1I3E3TM6MEIs=;
	b=SbETgp3qmbP2Wy84PKwJ0tEHLHRBWkV+iwS+SC7SOZIY12ZadZfWnuPzD1gEDdmLMkPM
	 TbDapwz2VfgFEYS5pb3pxk+6XN9qfHLsr1BES5i+JC1qlgPmatJ/G7CRwev1OAPIzlvva
	 Zw8ht4OjkGgDk80+7lXaOz7OpOQpuJbOweQnEI6qobNS3w9TiCDFZrrfSvgO9XffR4OWl
	 1wqe2sYeXQjUg1CQAETyZLV8uhXevQSvc1lGuurnL+QJGzEQLynXWz/eAz3sHZWhT1r7i
	 gGPzhvDtiIXTqGd/isPjYRPY56KIqTL05vGRriJ7eQydQzLoRE3/NvHViCWSaxJCrYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMtsYynC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF6606A31C;
	Mon,  9 Nov 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMtsYynC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590151F0089F;
	Mon,  9 Nov 2026 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237494;
	bh=Tq7znQYoOkVkkKUAJEz3ffT9r3etLqc1I3E3TM6MEIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mMtsYynCXwjp4wFVSfTB+WMYc9bEkSz8dXbr5A4wAf2r3TLVTwtBhuu4KOjp3r/Oj
	 jlNdm83/MEwKNzBGxiS6Guc65dq3pOWTcV+YV0qVX7aCFnIkOeOu7/Vz+ADhjVlFjF
	 49eD19yTNa3KaqvZYyG9Dglyy7dDxYT+gbyFA8+0pQn+tJXbJaKwSba4wOTBKHES1j
	 8LX88GIHcqa+76mhtZ8KOpeP6ubpVbWidk+fiF9YqcDEHLjW2Esry2c667/qrxqWC0
	 PL6JJU72/WfpBiN+YyXqz7Ng0IeZuDcGZTlxj6cq55PAlNZPXdWWxdcyGgEFQpQqgt
	 woUptyOQ5RP2g==
Date: Mon, 9 Nov 2026 16:18:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, hansg@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libahci_platform: reject invalid port numbers
Message-ID: <avHkMosHVOXCpVPD@ryzen>
References: <20261029190111138tS0yRo0lL1zJZ_IutobE1@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029190111138tS0yRo0lL1zJZ_IutobE1@zte.com.cn>

On Thu, Oct 29, 2026 at 07:01:11PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ahci_platform_get_firmware() reads the "reg" property of every child
> node of the AHCI controller and uses the value as an index into
> hpriv->saved_port_cap[], which has AHCI_MAX_PORTS (32) entries, without
> checking it first.
> 
> ahci_platform_get_resources() checks the same property against
> hpriv->nports, but only in its own loop, and hpriv->nports is itself
> clamped to AHCI_MAX_PORTS.  A device tree describing a port with a
> "reg" value of 32 or more therefore reaches
> ahci_platform_get_firmware(), where the "hba-port-cap" property is then
> written past the end of the array.  Values just above the end corrupt
> the following fields of struct ahci_host_priv, larger ones write outside
> of the devres allocation.
> 
> Apply the same validity check as the resource loop and skip such child
> nodes.
> 
> Fixes: 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index ae342080556a..d7106ab9ff3d 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -434,6 +434,11 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
>  		if (of_property_read_u32(child, "reg", &port))
>  			return -EINVAL;
> 
> +		if (port >= hpriv->nports) {
> +			dev_warn(dev, "invalid port number %d\n", port);

The warning is redundant.

ahci_platform_get_resources() already prints a warning for this.

So perhaps something like:

--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -434,6 +434,10 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
             if (of_property_read_u32(child, "reg", &port))
                     return -EINVAL;

+            /* Already reported by ahci_platform_get_resources() */
+            if (port >= hpriv->nports)
+                    continue;
+
             if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
                     hpriv->saved_port_cap[port] &= PORT_CMD_CAP;



Kind regards,
Niklas
