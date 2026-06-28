Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745633A716;
	Sun, 28 Jun 2026 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619334; cv=none; b=J6S1RwUhkBwhf8NPqbHsFk+55+Fp8wEW3RkpeC5qNjAxK0g7qGuJAhnbwt56ebtdIfbHzG4wnPjb68eLxB3GGq3cp2qcfzTpQrKLMHJqFuzBAffvvnyEFtdVO9tfQw1lt27otkJ1DrCvooYO2Sqq8cqFcHaCwPLpaYzzGTh998Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619334; c=relaxed/simple;
	bh=m0bt5CkN8oHuwT8Rm7FFLQcqc9gf2cZ2TT5GSKIQKU8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gonXzBKMTHrc3xWepe/RvNLtQMGT/WMqC6sFaoahS64vj0mBE3F3hRyar0ntOVaszovTrD6IGNEdTrV4kFh02Hym29PRGziCVF0Hdgz1LFaN2bs5zcPA7NbREnEtKy0XPIK3JqyqTRtGterTlcRaOPEI9YhpMFyXdvFlEeNzFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S6;
	Sun, 28 Jun 2026 12:02:05 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: nvmem: onie_tlv_add_cells: fix device_node reference
 leak on   nvmem_add_one_cell failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626154133.53346-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:01:54 +0800
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <82D122E8-C4B5-4B30-9B9A-CFD77B682D81@iscas.ac.cn>
References: <20260626154133.53346-1-vulab@iscas.ac.cn>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW8ZFW7ur4fKw1xZrWrXwb_yoW8GrW8pr
	WUKayYyF9rJF4Ikw1IvF48uFyUKw1YyrWF9F1fK34I9rZ5CrW7JFn0gFyqgrn8JFWrWw4I
	gw1jkF1xW345JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j24E_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2pAixEcwAAAsh



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:41=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> of_get_child_by_name acquires a child device_node reference stored in
>  cell.np. When nvmem_add_one_cell fails, the error path calls
>  of_node_put(layout) but fails to call of_node_put(cell.np) on the =
child
>  node, causing a device_node reference leak.
>=20
> Add of_node_put(cell.np) in the error path to properly release the =
child
>  node reference when cell registration fails.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout =
driver")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/nvmem/layouts/onie-tlv.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvmem/layouts/onie-tlv.c =
b/drivers/nvmem/layouts/onie-tlv.c
> index 0967a32319a2..3d77680f089b 100644
> --- a/drivers/nvmem/layouts/onie-tlv.c
> +++ b/drivers/nvmem/layouts/onie-tlv.c
> @@ -128,6 +128,7 @@ static int onie_tlv_add_cells(struct device *dev, =
struct nvmem_device *nvmem,
>=20
> 		ret =3D nvmem_add_one_cell(nvmem, &cell);
> 		if (ret) {
> +			of_node_put(cell.np);
> 			of_node_put(layout);
> 			return ret;
> 		}
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

