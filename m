Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F335DA78;
	Sun, 28 Jun 2026 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619438; cv=none; b=NkF4XtQox8OiWURG1zpQCx1UjXdUGfXWyPpvLKtlHxxwVRbXw7BKAVIjWY3Lh5HHkcJ006MHMDI7XwR4tw/wgC1e9FNqjWG3PBuyIA8s4vr8uXGz/ZALP5LNnpSAVgclm0DHfADW2riy+GSG/vnlfz8Yxvih+1fl1obuG1fA0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619438; c=relaxed/simple;
	bh=1irYGifYEF0fUWaFjm2XQhimsMrAIGxj0qTi2bZ0Qo8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sg5zd4kgU4JZRdPKvpiaN1otPb9X7oRENZ9Xns7G/TvgKZUt18yPB4ogw2omo43t0tuG0/y60578cFohT8UYjOlqdLp/LmS2uBgMCUNUPhyl7i2qgTVZHMZf6ChoN6W4SLttPbG1vKJUwjutB4Mc5dKz9+rcoWGxkqSILIVv5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S15;
	Sun, 28 Jun 2026 12:03:52 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: mfd: of_syscon_register: fix reset_control reference
 leak on success   path
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626151125.50780-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:03:41 +0800
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <89B74B13-D7CA-4E26-A301-31C5490A9F01@iscas.ac.cn>
References: <20260626151125.50780-1-vulab@iscas.ac.cn>
To: Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S15
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7tw48CF1DZr4DWFyxAFb_yoW8JFW5pr
	W5WFy3XFZ8Ar4rGw4rGrWF9FyS93ZxKFWDCF4DJayS9rnxt34UXryYqF4rJF98Jry8CFW3
	Ka1DKr95uFyqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0byZUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2pAixEdaQAAsN



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:11=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> of_reset_control_get_optional_exclusive acquires a reset control
>  reference. On the success path, the function stores regmap and np but
>  does not store or release the reset handle. Only error paths call
>  reset_control_put to release it. This leaks the reset control =
reference
>  on the success path.
>=20
> Store the reset handle in syscon->reset so it can be properly managed.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7d1e3bd94828 ("mfd: syscon: Allow reset control for syscon =
devices")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/mfd/syscon.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 21a7fcdd2737..28576a3c02fd 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -148,6 +148,7 @@ static struct syscon *of_syscon_register(struct =
device_node *np, bool check_res)
>=20
> 	syscon->regmap =3D regmap;
> 	syscon->np =3D np;
> +	syscon->reset =3D reset;
>=20
> 	list_add_tail(&syscon->list, &syscon_list);
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

