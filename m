Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795094244;
	b=w5lI/4xx5cUiUqYz7rPDOFx3WKXt/ZZdcqEidkHDydUasLB9L8lGqvxrcckvqI+lWbaC
	 B2kq0mqHlnpqz0c9ShpEHeLOkqFPHWI+J4++uM096GvOWQ7ImZuF88TbaCgV0F5ZlrW6X
	 sF23CxtyEk4vsYeoAT9qFWoj8rm2RuRe3gFFKy6hh8YUqDdRkCWRA7lsyC6DiTo2DhlXB
	 d973S3nn24WaM7ssKIwgfpuS3cqdnhlxfRQHDcCG/ynHrl7aB10/Guoc7aKdFLCCV2yfV
	 Eo1tgAxiE67B52Aa4eFFDOJdj5WpBxdg2b4Z+xuDxaO25BEGsZZENPWUsqwGWsF2ZbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094244;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=7DY1TQIQvk0+ckMeuoPyfBbQwgC+A8N3jdkd9bWc/6A=;
	b=5fxhbKrZ9dQXMxvkHsaOX5FyApXnAoisPG6fKnPijkz7B3UwdvO1puouKJxrq2nu+vWp
	 VIy8VpRttSikYW4XZC9QjV+KjmF3MEYiH+B8gYfOtxhS3XQ821PYpGiplTLaPr1Lqcg0L
	 QCoYUkBqiTIfpK4oVFXhcuRxAJHKqw7QLdKjc+zdVftMOYTdSYFo0kHKRHdCrjQZB8IES
	 ltAXLP5O3XWcRZiKrDlKqCjFxVShEVrVOeCTG1S9Gl9b/CyaoeiK4OkdUB2B0UG2DH56T
	 Ho6KYiOslTVGG/p0PI1jDbTbEW5Hnaf1p2ggJrL9fbUqyN5w4waiiRVgsAiXyP7UPyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=LfC28QO3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2060A260E;
	Thu, 19 Nov 2026 13:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E2060A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=LfC28QO3
ARC-Seal: i=1; a=rsa-sha256; t=1795094235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h3EITVBwAK+YsgR9Huv2o58quTn8f7RSgUNRqCYoxogIM71dBLC+2GXD2YT8rEUWtGvn4AuzmhG028gFhGgXkebCJkUPctF7+jHBzhtKF58HeMwqAoXo0iRwsLpKyLO1/gE7PJsuxmrvlQU4f7iYhzKVWm/wI3td/RXcAT5NP0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795094235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7DY1TQIQvk0+ckMeuoPyfBbQwgC+A8N3jdkd9bWc/6A=; 
	b=Rd4g7GFenAKJjKOFb3fNBvz+GK4RvS95xwupccasN2S7OZ9yxW4M7eYh18PbMp8G4bBuXHb6DmvDuJO2dw2sfACKEa99pjN9eyP7DkLzLS2aWGYbUVr049gCrH7FhQWFZVJ6zhsJdrWnlqKVGKKY3lLYFC/mJyYljbM7CaU+tqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=LfC28QO3hxBu3b0WDOWN1xlTVyS7ZLYICokDhgT/fFuZ/9P1ocwS3xiqESu+D0Nu8MT87oE+zrIxRtmpEo8zuvCqlaRVNeaeJAWkibS1WQHFxUiOAdi/SOZsJqWyctXJVk/aNMj2bzbU3/+men0D3vxaa1KM78FrJ5lCnBy/Vb6jaegWlScfSPpCVy09raERDEXScMhP0PCOlMkdQag6Hlfjt2c581nnII21uKEmG9gEMpDtj4J9BMn3/NrT61qR7lmuYFlGYa9zdchfPvCDtoFWeDOYS5h9iScwDM/C3eNhIULwfI79QsuDRWCHc/wSo/hdmpU0zQg3YA4XEMKM+g==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=7DY1TQIQvk0+ckMeuoPyfBbQwgC+A8N3jdkd9bWc/6A=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795094232098759.8778588301834;
	Thu, 19 Nov 2026 05:17:12 -0800 (PST)
Message-ID: <b42d57fcd0ff720bd91c52590f95ccf247804423.camel@rong.moe>
Subject: Re: [PATCH v3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: cancel work on teardown
From: Rong Zhang <i@rong.moe>
To: Hyunjung Ko <hj351016@gmail.com>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,  "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
In-Reply-To: <20261116122001.3096223-1-hj351016@gmail.com>
References: <20261116122001.3096223-1-hj351016@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 21:12:05 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Hyunjung,

On Mon, 2026-11-16 at 21:20 +0900, Hyunjung Ko wrote:
> fc->work is scheduled from the extcon notifier callback
> yt2_1380_fc_extcon_evt() (and once from probe), but it is never cancelled=
.
> The containing struct yt2_1380_fc and the extcon notifier are both
> device-managed on the serdev device, and the serdev driver has no
> ->remove callback, so teardown happens entirely via devres unwinding
> when yt2_1380_fc_pdev_remove() calls serdev_device_remove().
>=20
> devm_extcon_register_notifier_all() unregistering on teardown only stops
> future notifications; it does not drain a work item that the notifier has
> already queued. A fast-charger extcon event that races device unbind can
> therefore queue fc->work just before teardown; the work then runs after
> devres has torn the device down. yt2_1380_fc_worker() dereferences not
> only fc itself but also fc->pinctrl (pinctrl_select_state()) and the
> serdev (serdev_device_write_buf()), so it must be drained before those
> device-managed resources are released, not merely before fc is freed.
>=20
> Initialize the work with devm_work_autocancel(), placed after the serdev
> is opened and pinctrl is acquired but before
> devm_extcon_register_notifier_all(). Because devres runs cleanup in
> reverse order, teardown then unregisters the notifier first (so it can no
> longer queue the work), next cancels the work while fc->pinctrl and the
> serdev are still valid, and only then closes the serdev, releases pinctrl
> and frees fc. This closes both the re-arm window and the use-after-free
> of fc and of its sub-resources in the worker.
>=20
> Found by static analysis / code review; compile-tested only, not
> reproduced on hardware (requires the Lenovo Yoga Tablet 2 1380 charger).
>=20
> Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcha=
rger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Reviewed-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

> ---
> v3:
>  - Use devm_work_autocancel() instead of a hand-rolled
>    devm_add_action_or_reset(cancel_work_sync) (suggested by Ilpo Jarvinen=
).
>    It is placed at the same point in probe (after devm_serdev_device_open=
()/
>    devm_pinctrl_get(), before devm_extcon_register_notifier_all()) so the
>    reverse-order devres teardown still drains the work after the notifier=
 is
>    unregistered but while fc->pinctrl and the serdev are still live. Movi=
ng
>    INIT_WORK() down into devm_work_autocancel() is safe: fc->work is only
>    scheduled from the extcon notifier and from the probe-tail schedule_wo=
rk(),
>    both after this point.
>  - Add Cc: stable (this is a use-after-free fix).
> v2:
>  - Move the work-cancel registration from right after INIT_WORK to after
>    devm_serdev_device_open()/devm_pinctrl_get() and before the extcon
>    notifier, so devres (LIFO) drains the work while fc->pinctrl / serdev =
are
>    still valid rather than after they are released.
>  .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c=
 b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> index 8551ab4d2c7d..c2fe919a3ce9 100644
> --- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/extcon.h>
> @@ -160,7 +161,6 @@ static int yt2_1380_fc_serdev_probe(struct serdev_dev=
ice *serdev)
> =20
>  =09fc->dev =3D dev;
>  =09fc->nb.notifier_call =3D yt2_1380_fc_extcon_evt;
> -=09INIT_WORK(&fc->work, yt2_1380_fc_worker);
> =20
>  =09/*
>  =09 * Do this first since it may return -EPROBE_DEFER.
> @@ -209,6 +209,18 @@ static int yt2_1380_fc_serdev_probe(struct serdev_de=
vice *serdev)
>  =09serdev_device_set_baudrate(serdev, 600);
>  =09serdev_device_set_flow_control(serdev, false);
> =20
> +=09/*
> +=09 * Initialize fc->work with automatic cancellation on teardown.  This=
 is
> +=09 * registered after the serdev is opened and pinctrl is acquired, but
> +=09 * before the extcon notifier: devres unwinds in reverse, so teardown
> +=09 * unregisters the notifier first (no new work can be queued), then
> +=09 * cancels the work while fc->pinctrl and the serdev are still valid,=
 and
> +=09 * only then closes the serdev and releases pinctrl.
> +=09 */
> +=09ret =3D devm_work_autocancel(dev, &fc->work, yt2_1380_fc_worker);
> +=09if (ret)
> +=09=09return ret;
> +
>  =09ret =3D devm_extcon_register_notifier_all(dev, fc->extcon, &fc->nb);
>  =09if (ret)
>  =09=09return dev_err_probe(dev, ret, "registering extcon notifier\n");
