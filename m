Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA933F5AA;
	Sun, 28 Jun 2026 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619328; cv=none; b=Llu9ZM58FAqDsiReXmygjkqsZo3RkOAfzol3bmBh6zuk3qp3fZCohM/pz/QZnl9WLdvPRm24tuftfohQsd8aQ7yrX6jR8hJi03v2HZ/Ou0t2XV7mg9p2+ruAWlNpf+a1CwG03euBOESEgvLf4iiFFVg91M9C4Y30iIkO8ZOk+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619328; c=relaxed/simple;
	bh=dZEZ3joUiOtGA8rdZtqgmnjjt7flvlMnOFKmfpfZ6U8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gStq/BvxUmP6/WxHehXi6KHVl8GJII4dCojRcf8+tMF9j1ol9D+A9uYKwTcZ1zCUzKdwLpa3QKqrMXXPj+I6zhW5SWpsxUZiWwbwZIHKBXq4tsYztTEDXSDMNrr3+XxBxbyIDduSy6mut2AJRb/If+GEoJqZURX2Gtr5KgMIPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S5;
	Sun, 28 Jun 2026 12:01:58 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: nvmem: sl28vpd_add_cells: fix missing of_node_put
 for info.np on   nvmem_add_one_cell failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626154236.53449-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:01:47 +0800
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A757644-4D4B-4618-B41D-9643DD1EBAA3@iscas.ac.cn>
References: <20260626154236.53449-1-vulab@iscas.ac.cn>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW8XryfJF48uw1rGr17Jrb_yoW8GrWxpF
	WDKFW2vr9xGF4Ikr4xZa1UuFWj934ayrWrCF43K34I9rn5Ja97XrsxWF1vvas8Jr1rW3y7
	tr4jq3ZxKas8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	W5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2zuAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYMA2pAhrYkgAAAsx



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:42=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In sl28vpd_add_cells(), of_get_child_by_name() acquires a reference =
for
>  info.np inside the loop. On success, nvmem_add_one_cell() consumes =
the
>  reference. However, when nvmem_add_one_cell() fails, the function
>  releases layout_np via of_node_put() but does not call
>  of_node_put(info.np), leaking the device_node reference.
>=20
> Add of_node_put(info.np) before returning error to fix the leak.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d9fae023fe86 ("nvmem: layouts: sl28vpd: Add new layout driver")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/nvmem/layouts/sl28vpd.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvmem/layouts/sl28vpd.c =
b/drivers/nvmem/layouts/sl28vpd.c
> index e93b020b0836..79de1e6947d0 100644
> --- a/drivers/nvmem/layouts/sl28vpd.c
> +++ b/drivers/nvmem/layouts/sl28vpd.c
> @@ -126,6 +126,7 @@ static int sl28vpd_add_cells(struct nvmem_layout =
*layout)
>=20
> 		ret =3D nvmem_add_one_cell(nvmem, &info);
> 		if (ret) {
> +			of_node_put(info.np);
> 			of_node_put(layout_np);
> 			return ret;
> 		}
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

