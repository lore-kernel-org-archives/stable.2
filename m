Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCD233946;
	Sun, 28 Jun 2026 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618785; cv=none; b=oQpHs2JRLJwNzn1pLFp+WIOkYaqAPfPDoUe5yxvZD6b8nZybKcHfC/aQK+rjEf9rEQyamnyZ/kiwmp8fRjuWB1wURYjSE/tH2O811DLCtDhHtzUazXvz//+NnfOCY0uEZvstl80fCYbKoSPo9EvZWUKAs7LJd3RoIv1BG3fRu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618785; c=relaxed/simple;
	bh=tbjF4QqXbHnlCpYP13n7EfSMGrExejSImEHcnOjePm4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZHAW20VHc44s6dB6QUXnF8kSovohYA1LwzrhcHZIxsZ156XhTVKQtIuZXshZSJ5e0Fa3K6HL2WDq56CLJuKb+x7Ai8QwRYxyLog7N1n/Eo7HTykzkIahdmUB0iPavry68ZJVcwBRTy7faipSI4YulUKNXPnOZ2kCEI9nLgOhUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S5;
	Sun, 28 Jun 2026 11:52:58 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: clk/ingenic: ingenic_register_clock:
 clk_register_clkdev failure   leaks registered clock
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626115644.33779-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:52:47 +0800
Cc: bmasney@redhat.com,
 linux-mips@vger.kernel.org,
 linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E515C805-12EF-456F-B698-642CF3A845A5@iscas.ac.cn>
References: <20260626115644.33779-1-vulab@iscas.ac.cn>
To: paul@crapouillou.net,
 mturquette@baylibre.com,
 sboyd@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAA33NRbmkBqExKqAw--.34181S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ur47Wr1fKrWfWr17WF4Uurg_yoW8Jw47pr
	4rKa45Aay2qr409a17JF1agFyYgay2yFW8urWfXwnIvrn8tFy0gFWUJF9rGF1UJrWfGa13
	Kw15GF48KFWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hNVDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYMA2pAixEZXAAAs7



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 19:56=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> clk_register() succeeds but clk_register_clkdev() fails, and the error
>  path jumps to out without calling clk_unregister or clk_put to =
release
>  the registered clock. This leaks the clock object within the common =
clock
>  framework, contrasting with the CGU_CLK_EXT type path which correctly
>  calls clk_put on error.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b066303fb3e7 ("clk: ingenic: add driver for Ingenic SoC CGU =
clocks")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/clk/ingenic/cgu.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 41e4c69131bd..b59b24d0e3cf 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -774,8 +774,10 @@ static int ingenic_register_clock(struct =
ingenic_cgu *cgu, unsigned idx)
> 	}
>=20
> 	err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> -	if (err)
> +	if (err) {
> +		clk_unregister(clk);
> 		goto out;
> +	}
>=20
> 	cgu->clocks.clks[idx] =3D clk;
> out:
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

