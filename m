Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914462;
	b=EYRu90mPFDhmQj3BBBLT3uuSJUgoF8d4YZJKn3bFoN5RPDh0ORZpzItPsfyXqF9hB1HK
	 urOfe8JYi776jnEbGRSfwp9zxQIKWwcMv3Uo06BnS77XqdIWUhswSjnPs4S8OjFzUCwSK
	 3P2Q7VixtU3IZCja4NYb4X4JiCV095WnPU43S0pj2SAufgdlEe7qRLGnObGfRD2tjxOnu
	 UZhYdK0UU14ZssqwvT6QJETm4aCeqxaLZRI2Ku9dekGoCqNUiuUwQHD1IIGnx0XijhPCk
	 q+IrbmDvwo50rONX8mr+A+0GR6af84ceZr1GgzeFaaxFwrtbqG0Sxe7Rs7JIknZ8Log==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914462;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cI/nGQMT2x2CQh+vFtSBd5pXIA0jLezpANUhvPNMlHg=;
	b=balyGVaLp4iARWFVja1TZ4/kPSTPE48S77ciiYVg69q09B+rzUPhYC5oOzRhBFgbIOub
	 ufSx1GiKWJOd18XzPVonXpg6R5XZduS2cNMMvluVMvkg+Hq1VwKX8q26snRzbTamZ+1KD
	 SZC+ilO+Hr9FSsAA8FbhaBcNP2h36P1rJv0JBK1NRtKWCt7bUmNy02yhLrphPhTAl3EyL
	 w+OfQoPWFyZqo+IY8j/a8WHmIhf7TAys4wcCY4V90C5Cmx8X06g7KsyezHw0nzbxeltV9
	 F0pr5TMGhD0IDOv6xPHhCqLS3BhJ7pyuK0Fm7ODbIHrdvY9xEvVAVsLM8CP2rjOxlCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCRvHT0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A85606A323;
	Tue, 17 Nov 2026 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCRvHT0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443C41F000C4;
	Tue, 17 Nov 2026 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914461;
	bh=cI/nGQMT2x2CQh+vFtSBd5pXIA0jLezpANUhvPNMlHg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XCRvHT0b3PV9eMs8PaLEO7rMHF7CtLtxDCz4zROTjByksVD4zR8CDFcAXoVaw4AkI
	 bcqGFMYnz0+dIcEakLkcaiS6MzrTtHm8LyU59UoqQiuZBQfRR6irz0sh1cDbrWRXqi
	 OSFJS55QUL8kYvuyylz54fKNxUXd9hsKjGN/Yi8jcplW5z/Vh7L16X1/dQsyhDFulo
	 dDRx8Ix5iNS/WZ392XEafZdYFm48ruzXzrS7NgwS93hQstW8HuAct2djaXu45jRpzp
	 WtpSoiHvUgxL3TqablsdQPA9ZaAqVj7+bzbhpTA28CZOYmpxrUnFeCuFGT+AJ3b6Ik
	 LHSnMrU6xM6Kg==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/2] media: venus: disable recovery work before HFI
 teardown
From: bod@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261023223635.3c895c4752c4-3-mhun512@gmail.com>
References: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
 <20261023223635.3c895c4752c4-3-mhun512@gmail.com>
Date: Tue, 17 Nov 2026 11:20:55 +0000
Message-Id: <179491445504.2846709.15401208553880995023.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=bod@kernel.org;
 h=from:subject:message-id; bh=FSRXQ+24aToiVyHwsteWEHLX3pHh5wfgpDmcb93PRYQ=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBq/DiX256l3R3aVaEmeU4eeP67NruwFoPOquwdU
 jBUYjdtw3mJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCavw4lwAKCRAicTuzoY3I
 OhQ4D/0Xe/1OJ90lYivItRDE3k9riosSRVxYBzHuwIpmpAzl4KdOn9hj4RM37Lnl/fx22dTgOPG
 YtuEbjjxjV7rP/qohyK2PcVsRAeu8TQ90PENWCJPjsJwudaWj2vvFEEin4DLmLqr9cIY6Jy3TH4
 RFEIBneVwtokj4qOOwdWLKiZUwbCRXv510SWP35woRRamdHPsVRkgaCJPWHU/P6OKDrtabHP8KD
 cj6Zegy5byR5/cPT9BzNEJyVno8ahKKfh/MKc5wjfmwrrxtCt0C4tWgfEOHg3F98XPZl3OQUmPl
 DvVLflsXB3NnNhbP6wNDW0pvFrpVezvgSSWHSNAtvnfnG3Lp9cOH7E9MEV3jJeOeh9Ly7XMHlVQ
 rzNdHUtQY4l1vZH6P10jpRvSqqCyE16XNd4ohd15objG7wNcq7QojpznOapaMu24DrugVBJJi9h
 GsgrMyimJBF8Ehw7M/5OXeyv9i4bblgVwiiqPSAgo+kb8XGeX4uBpHdMw6vur4acMruMLOfyk5l
 lrkOqUWnC0aDemq7sZ/LihxCH2Zpum6VSt95oqtttqpc27FuhXIzRlUuyTgzaLV3hNvnjKCKh94
 Pm6h/8ezgQccKLmED6TpCFFTw5M5SPU8xqNQee1kh72jAPnOPT584bxQ1Ula03wUbKKcBR10RVU
 aeb+xjBF0XxTX9w==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-23 22:40 -0400, Myeonghun Pak wrote:
> venus_remove() cancels core->work while the IRQ can still schedule it.
> A later IRQ can requeue recovery work, which may access HFI state after
> it has been freed.
> 
> Use disable_delayed_work_sync() at the start of remove to drain recovery
> and prevent further IRQ or worker requeues. Drain the work before
> disabling the IRQ so recovery can finish completion waits that depend
> on IRQs.
> 
> Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")

Fixes: c5a85ed88e04 ("media: venus: fix use after free bug in venus_remove due to race condition")

Don't resend I'll fix the tag for you.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/media/platform/qcom/venus/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 7087af32060f1ed4190bf9f5d4a58cf88dad537d..6e495bc046913b46c926a498c062a6b55c6f7b64 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -596,7 +596,7 @@ static void venus_remove(struct platform_device *pdev)
>  	struct device *dev = core->dev;
>  	int ret;
>  
> -	cancel_delayed_work_sync(&core->work);
> +	disable_delayed_work_sync(&core->work);
>  	ret = pm_runtime_get_sync(dev);
>  	WARN_ON(ret < 0);
>  
> -- 
> 2.53.0
> 
> 
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

