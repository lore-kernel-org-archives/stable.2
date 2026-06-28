Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A93382F3;
	Sun, 28 Jun 2026 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619319; cv=none; b=GN0pZ2FPZDUJw5Gpd5uc4PI59KRQwnBmOgMO+badHKRIuy34J3l4LREmHar6jUFymd+iBmrRHSXYSzdr5FGrZf7rE32uW3541EZMAZWsN/LexOHEBICsnjjGCwbqKcrzaAyRFKzGoMWf6tD0m1QK+fGPURZbdGxaBkp8k7uOXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619319; c=relaxed/simple;
	bh=V24SaJq9Tz6v3bppqvijUingXOZtWLTEtuVQjKW3NB4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=THJ3Zz7PjXyzomFwE5G13QitPo1Nf6QU95IeRez/SOsVpUatx646QNEIvHa4Dw6oCFD3c3LhwBiFIs/fmohBuPdoaZHr1P2Pw1l2EptkSl1DyVMcWTjXshbknqVLZWAxHur61JWLMx9gy0eYpcZBk+2dx3x1qqrBktt/gaX1FgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S4;
	Sun, 28 Jun 2026 12:01:50 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: of: overlay: init_overlay_changeset: fix fragment
 overlay/target   reference leak on error paths
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626154419.53581-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:01:40 +0800
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2308A78C-D5A2-49A7-A513-CDF284A187F5@iscas.ac.cn>
References: <20260626154419.53581-1-vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWUtryUZw4kWw4fur18Grg_yoW8Cw4xpr
	W5K3yqqr45Xrs7Wa18t3ZrZF4Y9345tFWFkryjvwn5u3sa93sxAry5K3ZxJr13tFy3uF1Y
	qa1jyFykW3WUKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	W5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jc4SrUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2pAixEcqAAAsN



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:44=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In init_overlay_changeset(), when iteration fails (e.g., find_target
>  returns NULL), previously stored fragment overlay and target =
references
>  from successful iterations are leaked. The ovcs->count is never set
>  before goto err_out, so free_overlay_changeset() cannot clean up.
>=20
> Set ovcs->count =3D cnt before jumping to err_out and ensure
>  of_overlay_apply() calls free_overlay_changeset() on failure to =
properly
>  release the acquired fragment references.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 24789c5ce5a3 ("of: overlay: detect cases where device tree may =
become corrupt")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/of/overlay.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index c1c5686fc7b1..25521ff7c942 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -804,6 +804,7 @@ static int init_overlay_changeset(struct =
overlay_changeset *ovcs,
> 			of_node_put(fragment->overlay);
> 			ret =3D -EINVAL;
> 			of_node_put(node);
> +			ovcs->count =3D cnt;
> 			goto err_out;
> 		}
>=20
> @@ -825,6 +826,7 @@ static int init_overlay_changeset(struct =
overlay_changeset *ovcs,
> 			pr_err("symbols in overlay, but not in live =
tree\n");
> 			ret =3D -EINVAL;
> 			of_node_put(node);
> +			ovcs->count =3D cnt;
> 			goto err_out;
> 		}
>=20
> @@ -924,8 +926,10 @@ static int of_overlay_apply(struct =
overlay_changeset *ovcs,
> 		goto out;
>=20
> 	ret =3D init_overlay_changeset(ovcs, base);
> -	if (ret)
> +	if (ret) {
> +		free_overlay_changeset(ovcs);
> 		goto out;
> +	}
>=20
> 	ret =3D overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
> 	if (ret)
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

