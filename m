Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203DE239068;
	Fri, 18 Sep 2026 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691337; cv=none; b=OFGOLAUZ1CdKWRjb381+QPvvEUU9BjugXpfIAPWmVjoUb9evy8PQEVm3cpTbzbxx6Pem1i9WQ6scvwgfyAoGwImdoHXI4LmwX021xSjnlEXh0a3tW/P79dbTkuSFM+pmRA6sKGfeDMFdOaM4bFnxeqwIp0dzSBvEZRlmd3iIduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691337; c=relaxed/simple;
	bh=HDkuNFY7TXKZNIx+1grKeivnyY8OQt4wbVDA1oAHYS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1t9ejtH/62m1XrL2aA4pqVO7uBr0+7wQKQsITqIlIuVAS1CJAV+GmMMbjXAShSjStcdtZ2RwOvO2YCJyxaii4Ydt57zfY78PyhOirJKiS6rgL9kl3HkSUcyMmJtaXtLImLg8Os49MLqD0kjZU6FQ/NAz3/zfPkNtob/oQnNdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 68I0IPF23974234;
	Thu, 17 Sep 2026 19:18:33 -0500
Message-ID: <d607e8d94d17ac7b7832725b0672560fb1346ada.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb: gadget: aspeed-vhub: cancel wake work on device
 removal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fan Wu <fanwu01@zju.edu.cn>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Song Li
 <songl@zju.edu.cn>
Date: Fri, 18 Sep 2026 10:18:24 +1000
In-Reply-To: <20260908041740.613713-1-fanwu01@zju.edu.cn>
References: <20260908041740.613713-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 04:17 +0000, Fan Wu wrote:
> wake_work is armed from the gadget .wakeup callback to resume suspended
> downstream ports, and it is never cancelled in ast_vhub_remove(), so a
> work item queued before or during removal can run after devm has freed
> vhub and its ports, a use-after-free.
>=20
> Cancelling the work alone is not sufficient: usb_gadget_wakeup() takes
> no lock and the unbind path never clears wakeup_en, so a remote-wakeup
> request in flight on another CPU can re-arm the work after the cancel
> and before vhub is freed.
>=20
> ast_vhub_del_dev() already clears d->registered under vhub->lock before
> unregistering the gadget. Refuse the wakeup in ast_vhub_udc_wakeup()
> once d->registered is clear: the check and the schedule_work() are then
> atomic against the unbind, so a wakeup that passed before the flag was
> cleared is drained by the cancel_work_sync() after the del_dev loop,
> and one that arrives later returns without arming. Also move INIT_WORK()
> to the top of ast_vhub_probe(), since the probe error path reuses
> ast_vhub_remove() and would otherwise cancel a never-initialized work
> item.
>=20
> This issue was found by an in-house static analysis tool.

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> =C2=A0drivers/usb/gadget/udc/aspeed-vhub/core.c | 4 ++++
> =C2=A0drivers/usb/gadget/udc/aspeed-vhub/dev.c=C2=A0 | 2 +-
> =C2=A0drivers/usb/gadget/udc/aspeed-vhub/hub.c=C2=A0 | 5 +++--
> =C2=A0drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 1 +
> =C2=A04 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadg=
et/udc/aspeed-vhub/core.c
> index 4a8b9ff83..069673f0d 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -267,6 +267,9 @@ static void ast_vhub_remove(struct platform_device *p=
dev)
> =C2=A0	for (i =3D 0; i < vhub->max_ports; i++)
> =C2=A0		ast_vhub_del_dev(&vhub->ports[i].dev);
> =C2=A0
> +	/* Final drain; the worker takes vhub->lock, so stay outside of it */
> +	cancel_work_sync(&vhub->wake_work);
> +
> =C2=A0	spin_lock_irqsave(&vhub->lock, flags);
> =C2=A0
> =C2=A0	/* Mask & ack all interrupts=C2=A0 */
> @@ -328,6 +331,7 @@ static int ast_vhub_probe(struct platform_device *pde=
v)
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	spin_lock_init(&vhub->lock);
> +	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
> =C2=A0	vhub->pdev =3D pdev;
> =C2=A0	vhub->port_irq_mask =3D GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_port=
s - 1,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VHUB_IRQ_DEV1_BIT);
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadge=
t/udc/aspeed-vhub/dev.c
> index 8b9449d16..4b389de0d 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -280,7 +280,7 @@ static int ast_vhub_udc_wakeup(struct usb_gadget* gad=
get)
> =C2=A0	int rc =3D -EINVAL;
> =C2=A0
> =C2=A0	spin_lock_irqsave(&d->vhub->lock, flags);
> -	if (!d->wakeup_en)
> +	if (!d->wakeup_en || !d->registered)
> =C2=A0		goto err;
> =C2=A0
> =C2=A0	DDBG(d, "Device initiated wakeup\n");
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadge=
t/udc/aspeed-vhub/hub.c
> index 02fe1a08d..d0345f310 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -558,7 +558,7 @@ void ast_vhub_device_connect(struct ast_vhub *vhub,
> =C2=A0		ast_vhub_send_host_wakeup(vhub);
> =C2=A0}
> =C2=A0
> -static void ast_vhub_wake_work(struct work_struct *work)
> +void ast_vhub_wake_work(struct work_struct *work)
> =C2=A0{
> =C2=A0	struct ast_vhub *vhub =3D container_of(work,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 struct ast_vhub,
> @@ -588,6 +588,8 @@ static void ast_vhub_wake_work(struct work_struct *wo=
rk)
> =C2=A0
> =C2=A0void ast_vhub_hub_wake_all(struct ast_vhub *vhub)
> =C2=A0{
> +	lockdep_assert_held(&vhub->lock);
> +
> =C2=A0	/*
> =C2=A0	 * A device is trying to wake the world, because this
> =C2=A0	 * can recurse into the device, we break the call chain
> @@ -1076,7 +1078,6 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub=
)
> =C2=A0int ast_vhub_init_hub(struct ast_vhub *vhub)
> =C2=A0{
> =C2=A0	vhub->speed =3D USB_SPEED_UNKNOWN;
> -	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
> =C2=A0
> =C2=A0	return ast_vhub_init_desc(vhub);
> =C2=A0}
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadg=
et/udc/aspeed-vhub/vhub.h
> index aca2050e2..96f1c3709 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> @@ -547,6 +547,7 @@ void ast_vhub_hub_suspend(struct ast_vhub *vhub);
> =C2=A0void ast_vhub_hub_resume(struct ast_vhub *vhub);
> =C2=A0void ast_vhub_hub_reset(struct ast_vhub *vhub);
> =C2=A0void ast_vhub_hub_wake_all(struct ast_vhub *vhub);
> +void ast_vhub_wake_work(struct work_struct *work);
> =C2=A0
> =C2=A0/* dev.c */
> =C2=A0int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx);
