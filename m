Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914546;
	b=HQalZ1kEXls9hCD9Ym4GLpBRqvIuBQFOY7WtNHd5C4rpvQElsaio5A2UW23LuxjfA2rw
	 +3J1ONkRixGZ5HykMB/hY+xpmW4Q3WXpPb6e9J8dXiy7Mz8HNLQLeiE1YDDI8OD/FWaQc
	 infxwkmLl/vCffn5Ahu4eEb80GRaUayvS4uhTHcgV8+Ts6l7x8LRCmy6d0+hsarg3wYFe
	 DbtbYAM4GV3Zcr5axUYRJyyo3grfODz28AXQRm2CsE7aY1ZTRMcEf6wKX3HJqBKcwSycl
	 HYdowSuUiqKLxOJyfVO54r6kD9N8GisYQ47mmXgERye4nhdR+UafZ6CaDYncYlJrhEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914546;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Vaxj0UCX/u2B7vVUjGyn07SoS8L42PJgRkivrLerX2E=;
	b=seDbReonGnfsjsVu0HXLl7OurEebKY6XnPBPBGf2wnqhBxyk5pbR1bhpChrunWAU6KqK
	 +EeUcBjWsbhlBd7UWAbiA7ejxtbR1elXNVc/CdHxCg3loWHdZrvIqImFW5SrW2fxQer4G
	 N787nP0tGf8VlntzzYRLHOnhyV0CIBh9iA2jvfoDQAb4sTefO1EX/AgxH9T3X4M0P+1e2
	 eL2ED5ZXpqMafjRKFVjP0DaMvu6nKV5MWw5iKoq445Xhmaiij5WzYyXG2bLTM0pi4zm9H
	 7iSD4vuzuGHLEPifZyqLHSK35TVece/nCu4tN9tGbLSjz/YDHNMQOgFJC/ERgFUqayA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9wRjb2c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EF606A332;
	Tue, 17 Nov 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9wRjb2c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C201F000CB;
	Tue, 17 Nov 2026 11:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914546;
	bh=Vaxj0UCX/u2B7vVUjGyn07SoS8L42PJgRkivrLerX2E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=d9wRjb2cUN5O2n31CYOp+Q7QuDNIj2jY99zp8Cufo+HkSzSmsVZXnq84Xz660Fntp
	 AuK3AU296/0Sg3etAh9l+8TVvriZBj/G2Il0onttrF7xG3ebquM2U0TiHM9YR5jTjq
	 Gbhvzst8XC+4jrDaVUak98C7XXWV1Lf1viDquUcTYn0cvLKafc0SbfzQTfwXwOOBIk
	 pgi/JbClXiTE5nhCRuMmazFDHdtOiePllomdx7ug051iB4ICd8f6tm2kWs4lRtEsmj
	 n9bnmJp8WGveEhmScqtHFjkGVGh9Qnz2hvO5JR1suVYrJKvjtGLBOrXhXFLgQXPATq
	 m022Bchpe+K+g==
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
Subject: Re: [PATCH v5 1/2] media: venus: hfi: disable IRQ before freeing
 HFI device
From: bod@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20261023223635.3c895c4752c4-2-mhun512@gmail.com>
References: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
 <20261023223635.3c895c4752c4-2-mhun512@gmail.com>
Date: Tue, 17 Nov 2026 11:22:21 +0000
Message-Id: <179491454156.2846709.7627811261842181926.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=bod@kernel.org;
 h=from:subject:message-id; bh=QHLVTW5WgvoZKjE8jvdQa8cL7Ssb/MMwEdpwX3np+ZQ=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBq/DjtFE9cjyvBSIPcRvdaYN2o6n6DWC6d1WxDq
 yBFh8ilnUiJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCavw47QAKCRAicTuzoY3I
 Oi5/EACvWim5m8wuRUPv0aEXtPx3UbsuFYfnQLqYEvlbYdDbdz6mwRw1oSarF6xbExNAgfJ+J3t
 GBvBqeoBT3MWKAhJtkP5O+NaA+wubvLdUPR1S82c52XVVk1+aQMhHmdjgnWvd/epF8NsNKGaxbh
 X1m7l3nmpMJt0xR/gl8cMSsy6aN3rwhHgsmFZgGh0GvlHIG/iJOvJcQSbWa93DIL9McwkCaACB2
 QhgMtbAichYhypJ/emahQ5Rhq6AWgIlz9/vnWSiE8PmaVMOOigoY8RoRPU89+Pr82J9v0w+qZ//
 crr7bCcFuNy23URU7RYG+kCnCkVR9u9lYCzQ9q+AgW9BiYb4BbrGB7lYT0Dy8yI/v1GPtjZurqR
 +3OT4hFwP/uv+Rrp+Ne5zQo163vi9Gk/S6IJLaf7x/piZgrGhCS+aUe6Kjo3sHWrbU+E3eEq/sf
 Yvh89/mIzsNkLgCytbHGYnOrW5Vy9gHdzR5vntfOkvs9mGcP1O4u8JxKTOWKsXcfmoPMAapjw+T
 enHR8moAg50IGFqCHM5wgnn3xweGSDYNovfbz50IuYnAZkDF8x6gOGsV8RZzWmdlsgkZAyY+2C7
 Wd4HviL7QMxsMSOEItlS/2y8jo4GiZgMd4wugE1AYN679BDICCdQWFgvaB1lmenGiGv3sv6VOk+
 TZHs7fYKsSo0q9g==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-23 22:40 -0400, Myeonghun Pak wrote:
> venus_hfi_destroy() frees hdev and its interface queues before disabling
> the IRQ. A handler that already loaded core->priv can therefore access
> freed state even after core->priv is cleared.
> 
> Move disable_irq() before clearing core->priv and releasing HFI state so
> both the hard and threaded handlers have completed before teardown.
> 
> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")

Fixes: 640803003cd9 ("media: venus: hfi: explicitly release IRQ during teardown")

No need to resend, I'll fix this tag too.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260612103333.5585D1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index bd82066bb6e77f68ac3fe1440a8b5429ad62a192..e7e4e78a186adaa7fd80deeb094ed53d54f27ba6 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1689,11 +1689,11 @@ void venus_hfi_destroy(struct venus_core *core)
>  {
>  	struct venus_hfi_device *hdev = to_hfi_priv(core);
>  
> +	disable_irq(core->irq);
>  	core->priv = NULL;
>  	venus_interface_queues_release(hdev);
>  	mutex_destroy(&hdev->lock);
>  	kfree(hdev);
> -	disable_irq(core->irq);
>  	core->ops = NULL;
>  }
>  
> -- 
> 2.53.0
> 
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

