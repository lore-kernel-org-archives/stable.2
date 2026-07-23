Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D814A33F2;
	Thu, 23 Jul 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811471; cv=none; b=iFJerDon62oujAjMaoYRALXrtvpShcbujGljTmQZwoOioUK7XSxpTaBTm2mtOdea0mI6FMQctQwm8oAtyW94m1nqIJZgudJ3vBS6tNa5vjiqN9FlbF3O6DGPXoDI3+Okva4HzRmdk4yWp0nlO9DVViRSM+3419MQJLfo7PDHmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811471; c=relaxed/simple;
	bh=on69y1pq3HqrvgWQSXR3gDq7XMkOITqWGUmC2INhzkA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+dSQKFPeSXxazWeRLPNM0LDASL7CKuQo8BmX1+jxjQ703iNl51HDAypnx1SfdDbdKY7ywZmvFP3/TPa4dpEp9ZOyDs9XjhPmvh6nprZQN4hAmY33jjVzOIkrKqLspEyjSR2zwrsBjwifVjAO/hfdgrZOC8oi9jsSh6SvSYj0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=KBLdrqfN; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="KBLdrqfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1784811463;
	bh=xjAz6KIgciXGp2zeH8i+bSFJy02BM165LiSaYH8hdcQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KBLdrqfNHXQrgIKdlub4TWHwWqh+9VDFJPRRD+DLlIABnZvcckcXuXCM/G90StRDR
	 /PCSs2PQzJMDuWsPNuL4DUn/w1gVQcHc4O38APdZsWz4ip07adhpbn/X0QFli2Kdlo
	 C77qHxcvIcN0XxBpwFxLppsMLAFM4nQwL8tWtAL4=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4486B65982;
	Thu, 23 Jul 2026 08:57:37 -0400 (EDT)
Message-ID: <f1011fde1f3998021dbc2946f7456269d41a98a9.camel@xry111.site>
Subject: Re: [PATCH v2] platform/loongarch: laptop: explicitly reset the
 bl_powered state when resuming
From: Xi Ruoyao <xry111@xry111.site>
To: Zixing Liu <liushuyu@aosc.io>, linux-kernel@vger.kernel.org, Yao Zi
	 <ziyao@disroot.org>, Jianmin Lv <lvjianmin@loongson.cn>, WANG Xuerui
	 <kernel@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Date: Thu, 23 Jul 2026 20:57:35 +0800
In-Reply-To: <20260723121840.1120953-2-liushuyu@aosc.io>
References: <20260723121840.1120953-2-liushuyu@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 20:18 +0800, Zixing Liu wrote:
> On EAECIS NL60R with EC firmware version 1.11, resuming from S3 has a ver=
y
> high chance (>=3D 90%) of causing the EC to lose the previous backlight
> power state. When this happens, the laptop resumes normally from S3, but
> the backlight remains off (when shining on the screen with a flash light,
> we can see the screen contents are updating normally).
>=20
> Since there is no generic way to query the EC's backlight state on
> Loongson laptop platforms, assume the worst-case scenario and restart the
> backlight power inside the kernel each time the system resumes.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 53c762b47f72 ("platform/loongarch: laptop: Add backlight power con=
trol support")
> Signed-off-by: Zixing Liu <liushuyu@aosc.io>

Tested-by: Xi Ruoyao <xry111@xry111.site>

> ---
> Changes in v2:
> - Move bl_powered reset logic to loongson_hotkey_suspend.
> - Link to v1: https://lore.kernel.org/loongarch/20260722044457.1333404-1-=
liushuyu@aosc.io/
>=20
> ---
> =C2=A0drivers/platform/loongarch/loongson-laptop.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platf=
orm/loongarch/loongson-laptop.c
> index 61b18ac206c9..dc8142f4fa95 100644
> --- a/drivers/platform/loongarch/loongson-laptop.c
> +++ b/drivers/platform/loongarch/loongson-laptop.c
> @@ -189,6 +189,7 @@ static int __init setup_acpi_notify(struct generic_su=
b_driver *sub_driver)
> =C2=A0
> =C2=A0static int loongson_hotkey_suspend(struct device *dev)
> =C2=A0{
> +	bl_powered =3D false;
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
