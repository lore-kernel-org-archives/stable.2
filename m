Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE491343895;
	Sun, 28 Jun 2026 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619349; cv=none; b=FHl5aJvZn5YShItaNEC/gRm++vl3cWbXTcu2YErEaL9Oih+ezONOFoqFnZibip++eGmhvemVW2uz7BlRhfPYv2yLUHTbyCcotH5FT3b9Zy7KLbgis9w39bYt9QwOpgYLpfGflJ+MIBiOXnuYcsWeGz5Nt85UHiJmUz4s1bgXYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619349; c=relaxed/simple;
	bh=MuDvmcmmgPKtqdnqO2VvaY2OuorH7GlUaG/MEVEWbJ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S3nneInLIx16uwQNVLUxkecVlzuCFk1nh26lJrrUVK9fZSPrIu8wepdpOozkFky6em+7kMod29lFVmDlSvVEFQVhJnT24mA4S09WB3K4lAZg0jWEC1kItggerVqWJEFZVO4oaqz2GzWPaJ1bqxuh92VxS2CWkg+DhdAkAkZVFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S7;
	Sun, 28 Jun 2026 12:02:15 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: nvmet: nvmet_sq_create: fix ctrl reference leak on
 nvmet_check_sqid   failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626154043.53241-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:02:05 +0800
Cc: Keith Busch <kbusch@kernel.org>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4DA546F-94F7-4B5C-975C-1BC3BE622F7F@iscas.ac.cn>
References: <20260626154043.53241-1-vulab@iscas.ac.cn>
To: Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rZF4DGF17JryfWFy3Arb_yoW8GFWrpF
	s8Kr4jyrZxGFZ7ta1xAw4Y9FyF9w45KryUCwn5Kw1xZrn0q3y3Ar4DW3Wjvr15GrWrGry3
	JF4jyFy0ga45ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
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
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jedgAUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixEc0gAAs0



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:40=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> After kref_get_unless_zero successfully acquires a ctrl reference, the
>  nvmet_check_sqid failure path returns the status directly without =
calling
>  nvmet_ctrl_put, leaving the ctrl reference permanently leaked.
>=20
> Add nvmet_ctrl_put before returning on the nvmet_check_sqid error path =
to
>  properly release the acquired reference.
>=20
> Cc: stable@vger.kernel.org
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/nvme/target/core.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 62dd59b9aa4f..52fc2dade4ea 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -943,8 +943,10 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, =
struct nvmet_sq *sq,
> 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
>=20
> 	status =3D nvmet_check_sqid(ctrl, sqid, true);
> -	if (status !=3D NVME_SC_SUCCESS)
> +	if (status !=3D NVME_SC_SUCCESS) {
> +		nvmet_ctrl_put(ctrl);
> 		return status;
> +	}
>=20
> 	ret =3D nvmet_sq_init(sq, cq);
> 	if (ret) {
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

