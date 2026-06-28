Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15C31A81C;
	Sun, 28 Jun 2026 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619130; cv=none; b=SHkR7zAtAOb7wyWAWIjh277D+m9e3rbUG4PCgKMf9oMxEw6XIX3g/k5oCeFvOH4KH8F53Qp7axZ/8H5aOv9sHidsUoS8z1gyn9BaBAcBEzgUSvfyNEd310nT8OOgsWlDUBpyvXLoMy+U+eEEdDj40rjWI9dZmDmgCJKku7mobok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619130; c=relaxed/simple;
	bh=xc0MBYg0Y/spYENyLmebqeOhHNNc2N+29iJjmFn5eBc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YELLoQIaNqiGPNt0LIw0MVWvX175LgCpbgi0/KwvWKS1aH8JaZdSyshamP5FJifezuMJIB2GS7N+dVsMrcToKTgC06EUeU5ylUotNAtyj19F/lAvvxwHbJPJzsN2mU59Y3Oh5EsnhY3dJDXH5XA3VO7iEqFhaV2PCUowzOg1Wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAAnztbpm0BqfUqqAw--.7329S2;
	Sun, 28 Jun 2026 11:58:33 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: mtd: mtd_device_parse_register: fix refcount
 imbalance on   add_mtd_device failure and multi-call scenarios
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626151349.50859-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:58:22 +0800
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <52A2B858-B071-4644-8939-62BF8C292AA7@iscas.ac.cn>
References: <20260626151349.50859-1-vulab@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAAnztbpm0BqfUqqAw--.7329S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4UKFyxKrWxCFWDJr17Awb_yoW5Gr45pr
	Z8Wa9Yy3y3Kr429wsrWF1qgFWUKasay34rur47Gw12kws3G34YqFZ8KFy7Ww18t34xGF4j
	qr4xXan5Cw4UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHGQDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixEbZQAAsE



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:13=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> add_mtd_device initializes mtd->refcnt via kref_init unconditionally. =
The
>  cleanup in the out label only calls del_mtd_device when
>  device_is_registered is true. When add_mtd_device fails before
>  device_register, the refcnt is left at 1 (leak). Conversely, when
>  CONFIG_MTD_PARTITIONED_MASTER is disabled and the device was already
>  registered by a prior call, the error path incorrectly calls
>  del_mtd_device without a matching add_mtd_device in this invocation,
>  causing a refcount underflow.
>=20
> Track whether add_mtd_device succeeded in this invocation with a
>  registered flag, and only call del_mtd_device on error when =
registered is
>  true.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1c4c215cbdcb ("mtd: add new API for handling MTD registration")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/mtd/mtdcore.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 576537774628..59d8a6c61f55 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1108,6 +1108,7 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 			      int nr_parts)
> {
> 	int ret, err;
> +	bool registered =3D false;
>=20
> 	mtd_set_dev_defaults(mtd);
>=20
> @@ -1119,6 +1120,7 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 		ret =3D add_mtd_device(mtd);
> 		if (ret)
> 			goto out;
> +		registered =3D true;
> 	}
>=20
> 	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
> @@ -1136,9 +1138,11 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 		ret =3D 0;
> 	else if (nr_parts)
> 		ret =3D add_mtd_partitions(mtd, parts, nr_parts);
> -	else if (!device_is_registered(&mtd->dev))
> +	else if (!device_is_registered(&mtd->dev)) {
> 		ret =3D add_mtd_device(mtd);
> -	else
> +		if (!ret)
> +			registered =3D true;
> +	} else
> 		ret =3D 0;
>=20
> 	if (ret)
> @@ -1170,7 +1174,7 @@ int mtd_device_parse_register(struct mtd_info =
*mtd, const char * const *types,
> 		nvmem_unregister(mtd->otp_factory_nvmem);
> 	}
>=20
> -	if (ret && device_is_registered(&mtd->dev)) {
> +	if (ret && registered) {
> 		err =3D del_mtd_device(mtd);
> 		if (err)
> 			pr_err("Error when deleting MTD device (%d)\n", =
err);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

