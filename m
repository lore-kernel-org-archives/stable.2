Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43B342517;
	Sun, 28 Jun 2026 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619366; cv=none; b=ILV2dLXKIowSTshhmril+yWZrAZkJGL5J4xteaA0EESMVQnJJ86GFx9TZ/PTxk+KI+TqOCFl0KjqQ907Mgq6pXJfMWY3u+j7Ja9G0gYg143ogKAoO+6l9qVJmksE+tOSdLgB8Vl3abG8ewliGGfakCYFxb8f6JjqOV3/nDW9ZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619366; c=relaxed/simple;
	bh=y5ecxOWOWwwx1finAoL0dpTCJAbb3p1COzqj+JgqXqY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FaWYMr8v5eDDABLcQGyEBrn9rYeetO7Rgwq+NA8jcj0LpU6kaDsCRoTqXjHoaoaG0N/VflwyU17rxScdD07GQ9atIq0K/05ZLCQ3PmjL4iC7lbeQ26gULrDRM5SjUabIzZJRRrtN1HxyD2lheck1BVtBfAd2E26WH2paK/o0KvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S9;
	Sun, 28 Jun 2026 12:02:34 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: net: renesas: rswitch_mii_register: fix double
 of_node_put after   of_mdiobus_register
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626152430.51835-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:02:23 +0800
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A197C4A1-24C8-450D-9003-DF0F1C193FA4@iscas.ac.cn>
References: <20260626152430.51835-1-vulab@iscas.ac.cn>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr17CF4xuw1DWFy8Xr43Jrb_yoW8Ww1kpr
	W5KFW7ArykJr42qan7Gw4UuFyrZayrKry5uF1jyFWF9ws8tas8Jryjg3W3Xr45GrW8Ca13
	tr1jkr18ua4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5zVbUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2pAiNkg4AAAsu



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:24=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> After of_mdiobus_register succeeds, the mdio_np reference ownership is
>  transferred to the mii_bus device (released via fwnode_handle_put =
during
>  mdiobus_release). The success path calls of_node_put(mdio_np) which,
>  combined with the automatic release via bus teardown, results in a =
double
>  put and refcount underflow.
>=20
> Move of_node_put so it is only called in the error path where
>  of_mdiobus_register failed. On success, the bus driver manages the
>  reference lifecycle.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for Ethernet =
Switch")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/net/ethernet/renesas/rswitch_main.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c =
b/drivers/net/ethernet/renesas/rswitch_main.c
> index 6fe964816322..c33add28a70c 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -1387,13 +1387,13 @@ static int rswitch_mii_register(struct =
rswitch_device *rdev)
> 	err =3D of_mdiobus_register(mii_bus, mdio_np);
> 	if (err < 0) {
> 		mdiobus_free(mii_bus);
> -		goto out;
> +		of_node_put(mdio_np);
> +		return err;
> 	}
>=20
> 	rdev->etha->mii =3D mii_bus;
>=20
> -out:
> -	of_node_put(mdio_np);
> +	return 0;
>=20
> 	return err;
> }
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

