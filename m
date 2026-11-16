Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794834365;
	b=HqTUm6Rngvb5Y9XchMRH9RLjzQyrE34dXrOV4NHMNMH0SZ/DwYaRyASHE3erovIfPPeV
	 ns9SDzZI/hQqXvnuiS/ns6jfkpirJi5svrb/DqCT4PbN5ldfKaQM01rSULLphjn1JTCkk
	 GGFZDD9EvL8E0YR8ZPbHEQJpCRtHwVhHitnqHa/T97pLssilyYsNRtLce6iWfQcoidzQJ
	 Iu21R2WGwBuAR2vMkslurdtpVpRowvVz4AS3vFMllVVaDo5O6CKLzRug0LbH49unXBBYU
	 ep4lH1cfAzFekXBvbnGBmDaApm8osEY6OR5HobqskPrwmVHZWx83gxPwiW9cy9PUFXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834365;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=yLvZB+PQTARTmlUcjwOhJJuGhpGZsfckvTKRm3i2+J4=;
	b=qUlyL+H6P9MbCwT1Ids6Q38HxwVMBz+8Oa7qpUtyzmdeMsaix6iDxvKvctqYVqPAK1Jk
	 15wI8ClWWUbhSnstFqPyniWdMac6QDXDJHJeiwISx9lh91+zfdq2mnc9JoBXfwuDAMuSe
	 pj88f6p0eqTRj+G9t7p8mhKA+WbchYfZgMsKPucXGEl2967cw6N7T8spBgDIItPiM9xFZ
	 dPaT7uh3JZ26HwBLQox68U5zJPCBWNTbWkb+u95mK0lUARYxFFZBN9Qm9PDJfVmbGNpcs
	 NR5tTQHQBGJ2EqDuDOEuJYF0SnWEm2D1k985qjuu/mxJDZ3y/YYNCWDWEUcOR2UXW5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=ArRuH8kP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED12606A31C;
	Mon, 16 Nov 2026 13:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED12606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=ArRuH8kP
ARC-Seal: i=1; a=rsa-sha256; t=1794834348; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WjcROA4x+xSGzQAItNATKvWA2GXr2tuyBKdwRTc+Gvrl+OF6h3mEckyq4w0i8WjKYOw2Xy2oUZ3c0pK0bqnNNcfebZXVpv2bQOI3J09cyJnWU5itWShVLUB9evtBegSXYkDsaSMf4i7ui1jWPxeDVeywuP5SdLdRO5vrFt3/I9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794834348; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yLvZB+PQTARTmlUcjwOhJJuGhpGZsfckvTKRm3i2+J4=; 
	b=k3npFeqkmhasX1FsR2d8U+8+9q6OtMaJgCMqDnYfVPMqFlloHr3jF82xebULlQC7bCQhuTJKeEY/Xm7+3Zfb0CSRjmZyf7MjtHi+dlDEnb23M/45Ctl8rL8lAiKje8imVs1H9ijJlp6HDex+cUBmNQ7HZmAjjGSqLcz2L2SuEW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=ArRuH8kPJFvuYrY6XhhgZlWHO4Gc7lN+/IPq181u2M6NdGDpMdGFUpnq8aNjWIUyxS7oPSpFjC/0DhLTC4WzbOow4mB2gTv/L389g4+fox4uecnIOWH7oIEDRRpcXAl5CsLdWvEE/n/reH46yuU90svibTr1v/cKC53LO1KzZ6X5RpSOmkdPA7KuEQC0FTeLXxiAnKj+KRXLEJDjpdNgSD8zXUQzRdhfvQ1Ao6ZFH8ufW/D+9OS1oDPyBnv+4ewwqLxwtXRLEalqwkGtP15FUonAaZNwNTiQ0gc/gYuj4+Zjak6CwnfMj3R/kagT7dFUpHpJZ2XgMdkPDod+S5rcCg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=yLvZB+PQTARTmlUcjwOhJJuGhpGZsfckvTKRm3i2+J4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794834346199799.3745500364936;
	Mon, 16 Nov 2026 05:05:46 -0800 (PST)
Message-ID: <ab88da4911164925279b071519825fc344e998fc.camel@rong.moe>
Subject: Re: [PATCH v2 2/2] platform/x86: lenovo: cancel fastcharger work
 on detach
From: Rong Zhang <i@rong.moe>
To: Hongyan Xu <getshell@seu.edu.cn>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hansg@kernel.org>
Cc: Zehao Gao <gaozehao@iie.ac.cn>, Hyunjung Ko <hj351016@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, "Derek J.Clark"	 <derekjohn.clark@gmail.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, 	platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
In-Reply-To: <179474326460.103840.3845211906644469212@seu.edu.cn>
References: <179474326098.103840.15531040789536968458@seu.edu.cn>
	 <179474326460.103840.3845211906644469212@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:59:52 +0800
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

Hi Hongyan,

On Sun, 2026-11-15 at 19:47 +0800, Hongyan Xu wrote:
> The extcon callback schedules a worker which uses managed serdev,
> pinctrl and GPIO resources. Releasing those resources while the
> worker remains pending or running can access invalid state.
>=20
> Install managed work cancellation after the UART is opened and
> before registering the managed notifier. Reverse devres order
> then unregisters and waits for notifier callbacks, drains the
> worker and only afterwards closes the UART and frees its pin
> resources. This depends on the preceding all-connector notifier
> synchronization patch; resource order alone is insufficient.
>=20
> The actual lc824206xa supplier notifies from work context, and
> this consumer callback only schedules work. The callback must not
> outlive synchronized unregister or republish after cancellation.
>=20
> Found by the author's in-house static analysis tool.
>=20
> Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcha=
rger driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260806060526.1189-1-getshell@seu.edu.=
cn/
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>

The submitter's S-o-b should be placed at last.

(+CC Zehao)

And how did Zehao contribute to the series? You didn't even CC them!

(+CC Hyunjung)

Hyunjung is also working on this. See
https://msgid.link/20261116122001.3096223-1-hj351016@gmail.com

Thanks,
Rong

> ---
>=20
> Discovery: found by the author's in-house static analysis tool.
>=20
>  .../platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c=
 b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> index 9e2ac80..51ff383 100644
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
> @@ -209,6 +209,10 @@ static int yt2_1380_fc_serdev_probe(struct serdev_de=
vice *serdev)
>  =09serdev_device_set_baudrate(serdev, 600);
>  =09serdev_device_set_flow_control(serdev, false);
> =20
> +=09ret =3D devm_work_autocancel(dev, &fc->work, yt2_1380_fc_worker);
> +=09if (ret)
> +=09=09return ret;
> +
>  =09ret =3D devm_extcon_register_notifier_all(dev, fc->extcon, &fc->nb);
>  =09if (ret)
>  =09=09return dev_err_probe(dev, ret, "registering extcon notifier\n");
