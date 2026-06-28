Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DF2E5429;
	Sun, 28 Jun 2026 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619011; cv=none; b=ZF66ra2nucsM3a7nG/a1OtHvVDk7lpULuccRju1JIvJlgivQVmUrQGmNCQ+KvcNBeG1Xn8D9awdwkA39dN9TUgifxC9xjS5V29sjkCGrhiL4pH/i2gjGTcJMOL14hTY35clmUu6rC2fQ5nSvb+zZF95wCu9/aJld3KeXhfsJAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619011; c=relaxed/simple;
	bh=3N5AQTNarKS8ptO1xivOb3R2Zg9tQPObRK9V/Up40kk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l3H1aqQ6x2TnXvIPNN7HkQP+cSO8An3w7IR1mYzzupZywlhXGRe0xqYNKTo1X1AGnDRpnCtjxCuM+TukltrLEBAUTGD38kA6xDPhBtv9kf/yDRzJspyQqhQyAeNajoHBX35yukhFmuL/ssnqVrBuh+fRHTOLTbbnUYXn7iV4dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S11;
	Sun, 28 Jun 2026 11:56:42 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: i2c: i2c_mux_add_adapter: fix child device_node
 reference leak on   adapter registration failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626150310.49875-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:56:31 +0800
Cc: Peter Rosin <peda@lysator.liu.se>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E427A42-90FC-4244-8B38-8CEA55DABE6B@iscas.ac.cn>
References: <20260626150310.49875-1-vulab@iscas.ac.cn>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S11
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW7WF4kXr1fWF1fWw4fGrg_yoW8JFW7pF
	45GryqyrWUXw40gF48Ar1ruFyj9ay3K3yS9FnYk34fZrsIk34Iyr9xWFy7WF4rJrn7Kwsx
	tr1kKFyUuFyDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1Q6LUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2pAixEa0gAAs4



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:03=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When the OF block successfully acquires a child device_node reference =
and
>  stores it in priv->adap.dev.of_node, but the subsequent
>  i2c_add_numbered_adapter or i2c_add_adapter call fails, the error =
path
>  jumps to err_free_priv which only kfree's the priv without calling
>  of_node_put on the stored child node, leaking the reference.
>=20
> Add of_node_put(priv->adap.dev.of_node) in the err_free_priv error =
path.
>=20
> Cc: stable@vger.kernel.org
> Fixes: a7ab72390b77 ("i2c: mux: add common data for every i2c-mux =
instance")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/i2c/i2c-mux.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 681a201c239b..68a4c34b5987 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -408,6 +408,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
> 	return 0;
>=20
> err_free_priv:
> +	of_node_put(priv->adap.dev.of_node);
> 	kfree(priv);
> 	return ret;
> }
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

