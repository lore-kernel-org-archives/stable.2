Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124566;
	b=fG2BIOWA1aW5mHUhDPREHytl1wegLXgTH5RgzR6EDfQrkz5i4YsFMpv9k4SpLdcHfcDD
	 C59plCaPODsZKaHD6Q1FSauqPNbNmBe0RRv5CrqMhb/j4uYaGaWh8KJ+n/x9JDmnbJ4Ih
	 Y6tNHjXgW+MCrio0BUDIwnwa8OojqIKR47JjTa2V6LD07lXAnRjHw6H0KjCbqv3RNgQAD
	 /WigdF/Sft6vEWwIKa3dpluKoZGpDyVEh96TrROMzhLSJ04Csb2Tc03codrI0n1lO9eRv
	 8Z+bgCSxsywA2Tikxz8+edKiOArENvuCbsg6cc333ezwPOTAQBqmrsj+b+7HpPTiMxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124566;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O+XOpYxnEggyl2hN1NfzgWCb0jUC7SPgqGbZ9K842Mg=;
	b=GX8yx/e1i2USdZE4JR94AGKJozEdpK8SgOS3HwW7it7YahcAd2Hdq8DMXAqpf9hTayUw
	 HosvZJ0ul78LsrP5WupQUHANPdApk5SGVX4oqHGWixcj3iiPd812PtZybdM19dJ9avYzU
	 bujFjsi2XAGNyU+lrag+QtC6dbUoPBDdnOMBBqu3sWoMl2RFxgkrPXzgalDGf79VmMTaS
	 1bSOjdaLxtnU9EiCVMV0jdXpBSndbVxFUH7/g7RvEPfpCp9Gun3pSPLzsp2evzlpkC2rO
	 KI68c6aqwj3xVMDp1CPmGMqo7ix8c7z7/jpDfHc8p4Uz3MQ87o7+ecM1OnHpTzB3krg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5q23tuZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31588606A31C;
	Sun,  8 Nov 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5q23tuZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142DF1F008A2;
	Sun,  8 Nov 2026 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794124565;
	bh=O+XOpYxnEggyl2hN1NfzgWCb0jUC7SPgqGbZ9K842Mg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K5q23tuZ0ZnjqXEuwXJlCISGAiRpIT1ZYtjfhHoBJwR+LAjuxHC8UkDQ4woMAA4YB
	 hy24h8pquTfo1Djlo6ru4IIQL707WZIIDQ2P3u/lix8IhfGet1xyN8c/54VMhJCzpK
	 nyh6ejzfc158uL/3IVDLwA4MiFw5SfaEqD5ZTG6zAxu84uYvoPi47X0EFNMGRB8d6N
	 622muy0yByWtBv6D6o3vr1XC9erlnwEDOCVrtvvzxa608JyN80NLmtutvw+9zKOEzx
	 WmC72pn05kxWdIdQ1lV0znHJ1BCDyElGt58bQStzolBzcM1t8nluCodjZQt2E61aO3
	 ZBaGDvUDdFJ2A==
Subject:
 Re: [PATCH v2] fsl/fman: Fix fm_node reference leak in read_dts_node()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 madalin.bucur@nxp.com, nsaenz@kernel.org, sean.anderson@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 07:56:04 +0000
Message-ID: <179412456458.994134.2511936313095675582@kernel.org>
In-Reply-To: <20261107072941.314160-1-vulab@iscas.ac.cn>
References: <20261107072941.314160-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a double of_node_put(fm_node), so the
  device_node refcount underflows.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits on the
  error paths the patch edits.
- [High] This problem wasn't introduced by this patch, but the FMan IRQ
  handlers are live before driver state is set up, and the init check…

--

fsl/fman: Fix fm_node reference leak in read_dts_node()

The patch adds an of_node_put(fm_node) on the success path of
read_dts_node(). It also sends the failure paths that used to jump to
fman_free through fman_node_put instead, and removes the now unused
fman_free label.

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 46cc28895e565..5507002097fd4 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2760,7 +2760,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
>  		err = -EINVAL;
>  		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
>  			__func__);
> -		goto fman_free;
> +		goto fman_node_put;

[Severity: High]
Does this drop a reference that read_dts_node() no longer holds?

Just above this hunk, read_dts_node() does:

	muram_node = of_find_matching_node(fm_node, fman_muram_match);

of_find_matching_node() wraps of_find_matching_node_and_match(from,
matches, NULL), and that function releases from on every path:

drivers/of/base.c:of_find_matching_node_and_match() {
    ...
	for_each_of_allnodes_from(from, np) {
		...
	}
	of_node_put(from);
	raw_spin_unlock_irqrestore(&devtree_lock, flags);
	return np;
}

The MURAM lookup therefore consumes the reference taken by
of_node_get(of_dev->dev.of_node). That means the pre-patch code was
already balanced. Early failures went through fman_node_put, while the
later failures and the success path skipped the put.

After this patch, all six error gotos after the lookup, plus the new
of_node_put(fm_node) before return fman, drop one extra reference on the
FMan device_node. That happens on every successful probe.

The commit named in the Fixes: tag, ecb239d96d36, describes this exact
situation:

  "the probe function ends up calling of_find_matching_node() using the
  node as an argument. The function takes care of decreasing the
  refcount on it. We are then incorrectly decreasing the refcount on that
  node again."

With CONFIG_OF_DYNAMIC, of_node_put() becomes kobject_put(). fman_driver
does not set suppress_bind_attrs, so repeated unbind/bind through sysfs
can drive the count to zero. Static nodes would then hit "ERROR: Bad
of_node_put()". Overlay-created nodes could be freed while
of_dev->dev.of_node and the children created by of_platform_populate()
still point at them.

Given that the leak described in the commit message doesn't seem to
exist, should this patch be dropped rather than respun? Without that,
the Cc: stable tag would also carry the imbalance into stable trees.

>  	}
>  
>  	err = of_address_to_resource(muram_node, 0,

[ ... ]

> @@ -2779,7 +2779,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
>  	if (err < 0) {
>  		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
>  			__func__, irq, err);
> -		goto fman_free;
> +		goto fman_node_put;
>  	}

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but can
fman_irq() run before the driver state it reads has been set up?

fman is allocated with kzalloc_obj(), so fman->cfg and fman->fpm_regs
start out NULL. Both are only set in fman_config(), which fman_probe()
calls after read_dts_node() returns. The shared handlers are registered
here, before that.

is_init_done() treats a NULL cfg as "init done":

static bool is_init_done(struct fman_cfg *cfg)
{
	/* Checks if FMan driver parameters were initialized */
	if (!cfg)
		return true;

	return false;
}

If the line fires in that window, fman_irq() does:

	if (!is_init_done(fman->cfg))
		return IRQ_NONE;

	fpm_rg = fman->fpm_regs;

	/* normal interrupts */
	pending = ioread32be(&fpm_rg->fm_npi);

That is a NULL pointer dereference in hardirq context. fman_err_irq()
has the same window.

The interrupt could come from another device sharing the line. It could
also be an FMan interrupt left enabled by a previous kernel across kexec
or kdump, since fman_driver has no .shutdown or .remove callback.

[ ... ]

> @@ -2817,11 +2817,12 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
>  		of_property_read_bool(fm_node, "fsl,erratum-a050385");
>  #endif
>  
> +	of_node_put(fm_node);
> +
>  	return fman;
>  
>  fman_node_put:
>  	of_node_put(fm_node);
> -fman_free:
>  	kfree(fman);

[Severity: High]
This is also a pre-existing issue, not one introduced by this patch, but
can kfree(fman) here leave live shared IRQ handlers pointing at freed
memory?

read_dts_node() passes fman as dev_id to devm_request_irq() with
IRQF_SHARED for both fman_irq() and fman_err_irq(). fman itself is plain
kzalloc memory and devres does not manage it.

Three failures after the IRQ requests reach this kfree(fman) while the
handlers are still installed:

  - a failed err_irq request
  - a failed devm_platform_get_and_ioremap_resource()
  - a failed of_platform_populate()

fman_config() has the same pattern:

err_fm_state:
	kfree(fman);
	return -EINVAL;

free_irq() only runs later, from devres_release_all(), after
fman_probe() returns the error. A shared interrupt in that window would
call fman_irq() on the freed object.

With CONFIG_DEBUG_SHIRQ, __free_irq() always calls the shared handler
once during teardown, so this would happen on every such failure.

On the read_dts_node() failure paths, the freed object probably still
holds cfg == NULL. is_init_done() would then return true, and fman_irq()
would read fman->fpm_regs and do MMIO through a stale pointer. If the
read returns nonzero, call_mac_isr() makes indirect calls through
function pointers in the freed object.

>  	return ERR_PTR(err);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107072941.314160-1-vulab%40iscas.ac.cn
