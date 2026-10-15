Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14F4DD3C7;
	Thu, 15 Oct 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065344; cv=pass; b=ehP4y+H2GyyLf0q8SeIv3GxEebZhGHGW/Znf2qTS3sxHG4714c6UOW1oAwMAt+wr7+lkAuf8wCJ/VN3B24zrB8gZV9FtZak2NYFuxwFgRxOZaFPHxq+DLrExrLNq89Jff8168aMMJ8r0EY6U2o7+IQjT7+ZGWUQE8UP3D3mAva0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065344; c=relaxed/simple;
	bh=vZ9uJcr+D1uX+jbJMZk9t6m4wV0GltbsDzD+BEsx7Kw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WVGrtGatL8uwSslbKmO1d6uretXsONum/7vHcaoyxk+NhQZYdMa/m6a9kDXl/KoBsi+AIyKpFCvSoHV6IG/gFqVBST1RKdOYqYndSOPCSb+OPkrY2coI5GeMU6f2yBpKrcb1Vf4eyCumQtrflmh2lTb2f15cSE5QWCVj+40wfzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=S6549Zfr; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="S6549Zfr"
ARC-Seal: i=1; a=rsa-sha256; t=1792065333; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FZHZmRyh7kb5Qkqm5nfQrVb1rff9ca520ilJaQYGK8ylhd09YxFFqveml4hPXPqYMY16KnxZaQyhPBF2MbBvjZjgip/pvnXw/8viVRm+FcYAmp5In/NQVCBuybdDlsl8JfVK6OINlLUIunCSSk6gDKMMPL5GrQHbeceGhjiV5K8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792065333; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xEb5oCNmOAdVTUBDsHbqnDjppqSh5CCR9J0Pd4ST0DI=; 
	b=lh66bEFcBLD98Mr/+76WCUuxapfNOmdCdKNdSCAgIXo1q4Zo1BMEgaPg6oQzNHWDZV5Rt213WW6Q7y0kNa412AVejwxkalQy4FwSRSM3oIyJbb/iO6FLHrld3GlDfmJXH4N3W1YA9k28C5CPtdfcYy8o2x7HC78L7Cy/1yJfAVo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792065333;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=xEb5oCNmOAdVTUBDsHbqnDjppqSh5CCR9J0Pd4ST0DI=;
	b=S6549ZfrD9fKTVeMvX6AEmhsROfLLcULzm/VEnaxJI6zB04+24QAMrDPg44kgUYb
	qyUw5jfoq98b0hW6enFXIMMn87YjHFGN+/7EJxYlgLuC1o9fGTyc3ZZvfz3RuOk/wwL
	RnB2OKg6wW0uTL0D2ZqPQZY23gpohu/qxCKivuCUUvmpAnXHrxC0gcOjfUk9IznX1Oa
	Gmw9BXX/nexyaMCTYkzCkTiH5tvY6so7RGk+17uJK0A/n/FDj01CaTnrZPgwyK0xcjt
	HvxMDAKv+Qbmz6f6UJKROEl/ZdIgiiOrqxoFeRRIMhzebbE7jHDdOpP2H8O8cETKBYh
	jf+9rhEPVg==
Received: by smtp.zohomail.com with SMTPS id 1792065331559294.33918562789336;
	Thu, 15 Oct 2026 04:55:31 -0700 (PDT)
Message-ID: <e82f18f8d1137a5916f9b47e05cd2572bf1bf911.camel@rong.moe>
Subject: Re: [PATCH 3/3] thermal: intel: int340x: Evaluate _TMP exclusively
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
In-Reply-To: <20261014133013.94097-3-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
	 <20261014133013.94097-3-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:49:32 +0800
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
> without taking the mutex the battery methods use, so it must not run
> interleaved with them.
>=20
> Evaluate _TMP with acpi_evaluate_integer_exclusive().
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
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c=
 b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 965700ee6962..de0a1fc7b817 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -18,7 +18,12 @@ static int int340x_thermal_get_zone_temp(struct therma=
l_zone_device *zone,
>  	unsigned long long tmp;
>  	acpi_status status;
> =20
> -	status =3D acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
> +	/*
> +	 * On some ThinkPads _TMP switches the EC page selector without
> +	 * taking the mutex the battery methods use.
> +	 */
> +	status =3D acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NUL=
L,
> +						 &tmp);

Please merge it into the previous line.

With it resolved:

   Reviewed-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

>  	if (ACPI_FAILURE(status))
>  		return -EIO;
> =20
