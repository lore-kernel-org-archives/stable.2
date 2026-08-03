Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A43B6BE4
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748666; cv=none; b=HRYptqTZCWLZq1gWm/IrzQsm+ESqhr8D8Ccu83Nivjg1tFsHpvrHrwtQmPrjAgh3LDIKPwrWgwiU9kM2ePGjUIR9giYZYMO72dJ2JpGm638S9eT/KRkVG01onmJaIBJ+OzP6V4t1rCCNoahYpSEoX+UnkI7VoOrnmvK9C6foexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748666; c=relaxed/simple;
	bh=wAVpunttGNKbElHadGCPUxU/SwXZ1IYwWBsD/E198xY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DdmbHl7uT3LtUlKlOhYxq0hplPJC/rJvH/KBCt25bcozOLLRIH14nziM2DXRnHAt9Oes/Hpsk7TkzVkvl9pwtqvviX508b2EyyJGDj6rV0VFqmmScj3+Cn7Lo2RHULjCWBmHFOp/RXLWby/FkKm/5i8rjfK1oKht4iYOQMs4vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1wqonZ-0007Ib-97; Mon, 03 Aug 2026 11:17:29 +0200
Message-ID: <1de7a5daa6f4fbee2a22a92215533052fba61949.camel@pengutronix.de>
Subject: Re: [PATCH] power: supply: ucs1002: fix use-after-free on remove
From: Lucas Stach <l.stach@pengutronix.de>
To: Fan Wu <fanwu01@zju.edu.cn>, linux-pm@vger.kernel.org
Cc: sre@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 03 Aug 2026 11:17:27 +0200
In-Reply-To: <20260802051249.424015-1-fanwu01@zju.edu.cn>
References: <20260802051249.424015-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Am Sonntag, dem 02.08.2026 um 05:12 +0000 schrieb Fan Wu:
> ucs1002 has no remove callback, so unbind runs entirely through devm.
> The alert IRQ handler queues the health_poll delayed work, and the work
> reschedules itself while the chip reports a bad-health condition.  devm
> frees the alert IRQ, which only synchronizes the handler; it does not
> cancel the delayed work, which can then run after devm frees the driver
> data and dereference it.
>=20
> Register health_poll with devm_delayed_work_autocancel() before the
> alert IRQ is requested.  devm then frees the IRQ before cancelling the
> work, so the handler can no longer queue it and the work is cancelled
> before the driver data is freed.
>=20
> This issue was found by an in-house static analysis tool.
>=20
> Fixes: 81196e2e57fc ("power: supply: ucs1002: fix some health status issu=
es")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/power/supply/ucs1002_power.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/=
ucs1002_power.c
> index 3f44cc9..ca58c21 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -640,7 +641,10 @@ static int ucs1002_probe(struct i2c_client *client)
>  	}
> =20
>  	info->health =3D POWER_SUPPLY_HEALTH_GOOD;
> -	INIT_DELAYED_WORK(&info->health_poll, ucs1002_health_poll);
> +	ret =3D devm_delayed_work_autocancel(dev, &info->health_poll,
> +					   ucs1002_health_poll);
> +	if (ret)
> +		return ret;
> =20
>  	if (irq_a_det > 0) {
>  		ret =3D devm_request_threaded_irq(dev, irq_a_det, NULL,
