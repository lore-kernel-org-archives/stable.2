Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546351DB06;
	Thu, 15 Oct 2026 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065290; cv=pass; b=UpQVTd6Kt3HwI8L91ReSsLKnnvpiLC0GPDvC9T2MqHVIuTCliUX8Mec2093ZwPZOYJieW/Uxmk9y1Zt7EF0DV1ci7gO1EcrEkBrULbzp6EQ/Zu5dUimiJmUVMTKLRmIquFTU20QpKO338ZsnXSECaup+pgLCfCmSlMJlVD327r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065290; c=relaxed/simple;
	bh=kRyMVoq0ZW9ViZ0Zmcbt3V+vROebgZVQ+rLzm8xglYY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XFaT0TIq4GDKNwmsH15c9ZWasmq9/nTswX219ythJGItktUT/INTnkTevQZLz20jyxfnx+bAsA/UiQY1VGzEBUJUFCtOo1kKGcRAAEUJ3X44uLPowaoYulgoJGK7B6HcBqp5OukB2Xa+jl7EPAZImvlgHGbYGw7A29wfzzPXMSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=C00ZywNU; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="C00ZywNU"
ARC-Seal: i=1; a=rsa-sha256; t=1792065263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TQRBEIkMBub/FR7n/CSnryrwl4CW2S6W+vQ4sPk+EOzSpUHJu/JhrcIXSnhkGhMOzPQ5/P3njOPo8dlrSvetz6abJjZZ6jK762C3fzQIKrXtuo/uTtJtJygtDiwm2jongHxEMYpGfJCiUu7l+sZKpMxYZPvluoaTsbaQ4Q5EqzU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792065263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ki6N5ywcGFZeooLfVqyWGKfQqH9QdXIJgUBt3sbTgyw=; 
	b=R/gd9Ck2rl36TOMUZZwObO8FXqapKNHZM+0r6sIqm93I0pqb69I8kr5KojKNEzlwJpVFKWKCGQFq3ZYyl9vYV4ct4/x1LRCxLzJF5tdYbMe9CkknUoboxeBwoco7aSEhu5HfVOpjYwozGIRUoVXJCLssW7hAOSe9RL9ZWAmnQi4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792065263;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=ki6N5ywcGFZeooLfVqyWGKfQqH9QdXIJgUBt3sbTgyw=;
	b=C00ZywNUxgSSf0UlA0HIKq30JFo6R/9jEhFa3Blhukx1UZxUxcQSrDdX583of/ga
	D9nccmpvmB8zc1zoWfrX7vMPlG7JZyv6sjBYfGdg0G7zmHQn4bcUEBa0wCquYKcT4Ja
	pKHV1JQC20oevSWwrrJvaFE+m19jx3hB9rRaQnidOtD9sdggmUftH4spsicG4Utuchg
	EBWYXb6uR69xdejh3H3JZwMWqdFcbkBCvpXbZt1TUSVOLy30r621C2P4c7J7t0JPhRD
	dgdZg0q55/Cg8n2kp7h3EL9jdeSIXnze8uSjFWS6ZrUUpyj9/2VYXkmHH4uRf5sfwYU
	XDxqp3D4Lg==
Received: by smtp.zohomail.com with SMTPS id 1792065261502609.0412633087469;
	Thu, 15 Oct 2026 04:54:21 -0700 (PDT)
Message-ID: <5323dea7e1fdc48dff8cc820d5e7c8c2c0e081ac.camel@rong.moe>
Subject: Re: [PATCH 2/3] ACPI: battery: Evaluate battery methods exclusively
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>,  Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>,  Hans de Goede
 <johannes.goede@oss.qualcomm.com>, Charis Stratakis
 <c.stratakis@proton.me>, 	linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
In-Reply-To: <20261014133013.94097-2-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
	 <20261014133013.94097-2-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:48:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ali,

On Wed, 2026-10-14 at 16:30 +0300, Ali Ahmet Memi=C5=9F wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the AML mutex the battery methods use, so _BIX and _BST
> running at the same time can read the wrong page. Since commit d33e89d122=
95
> ("thermal: core: Suspend thermal zones later and resume them earlier")
> this happens on most resumes.
>=20
> Evaluate the battery methods with acpi_evaluate_object_exclusive().
>=20
> Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resu=
me them earlier")
> Reported-by: Charis Stratakis <c.stratakis@proton.me>
> Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iR=
Ug2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=3D@p=
roton.me/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memi=C5=9F <aliamemis@disroot.org>
> ---
>  drivers/acpi/battery.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 670853ec3a4d..61de3f5be51f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -583,9 +583,9 @@ static int acpi_battery_get_info(struct acpi_battery =
*battery)
>  		struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>  		acpi_status status =3D AE_ERROR;
> =20
> -		status =3D acpi_evaluate_object(battery->device->handle,
> -					      use_bix ? "_BIX":"_BIF",
> -					      NULL, &buffer);
> +		status =3D acpi_evaluate_object_exclusive(battery->device->handle,
> +							use_bix ? "_BIX":"_BIF",

Since you are anyway moving the alignment, let's add spaces around `:' as
well.

> +							NULL, &buffer);

Please merge it into the previous line for readability.

> =20
>  		if (ACPI_FAILURE(status)) {
>  			acpi_handle_info(battery->device->handle,
> @@ -624,8 +624,8 @@ static int acpi_battery_get_state(struct acpi_battery=
 *battery)
>  			msecs_to_jiffies(cache_time)))
>  		return 0;
> =20
> -	status =3D acpi_evaluate_object(battery->device->handle, "_BST",
> -				      NULL, &buffer);
> +	status =3D acpi_evaluate_object_exclusive(battery->device->handle, "_BS=
T",
> +						NULL, &buffer);

Ditto.

>  	if (ACPI_FAILURE(status)) {
>  		acpi_handle_info(battery->device->handle,
>  				 "_BST evaluation failed: %s",
> @@ -667,6 +667,8 @@ static int acpi_battery_get_state(struct acpi_battery=
 *battery)
> =20
>  static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  {
> +	union acpi_object arg =3D { .type =3D ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args =3D { .count =3D 1, .pointer =3D &arg };

You did the same in the ideapad-laptop patch.

Please don't open code when the same pattern is repeatedly used. Add an
acpi_execute_simple_method_exclusive() helper in PATCH 1 and use it here
and there.

With these comments resolved:

   Reviewed-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

>  	acpi_status status =3D 0;
> =20
>  	lockdep_assert_held(&battery->property_lock);
> @@ -675,8 +677,9 @@ static int acpi_battery_set_alarm(struct acpi_battery=
 *battery)
>  	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>  		return -ENODEV;
> =20
> -	status =3D acpi_execute_simple_method(battery->device->handle, "_BTP",
> -					    battery->alarm);
> +	arg.integer.value =3D battery->alarm;
> +	status =3D acpi_evaluate_object_exclusive(battery->device->handle, "_BT=
P",
> +						&args, NULL);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> =20
