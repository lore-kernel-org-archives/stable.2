Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426163;
	b=JSxXKNN+sDQnHh3VEYEPJmeIrQLnnrzJ4YCUkZvugCADRqyZKWycrMhCHurrg5Nqnuim
	 EoPyTdRnmm6aIdDSB6PwjPB04XjD+ZZSVgnQpkiqjXAivmiISCkr0fy7Cf4FQDNZJtegD
	 wPSoX9jWoLKtM+zsrQDgHthzEoVvFxHitvN9ZcXPXuc1NNZOSS838AaY+2yBDm9yvRa6Y
	 aJiZ3Kk6A46fRSDOJ5v4dk+0VVzpqhGTo/RekM02qdSkkIYnErpUYgo6XqEUcpthP+DIA
	 lvv8o+8GzX88z+uIRnnOvZ8ZoDlkBPqmu5/mvwNbpt2ZSqpDqy7bVEJXdPqMM+WRdig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426163;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=53LL2D2w2EtJWe1+ddsR6vv92olybDI66APL3fli6Ak=;
	b=hDSD2bsuVEJMTQ2Iob8olPaPra0Nl5gRW5vPgBrefDZncv1jOSkMlEXr09QLy1YRTwm+
	 UFR+pqlJsqI7ulvrHrAaLd6H9FWaludUC/9TP9pi1nGip1b26Zs40j90CMvGiTVAZ3oig
	 swxpYvwSfHzpItmlJqXRTVkmdNpr3KzCduxB8Y2im5QKExmLT6ZHz655B+ggFa878SftX
	 kR0+xN8mDrBazJvKkxdnVsXZzK/8d75kJbBm4soyjGznb8nfd0BpAvLz4nub7UwSXc1O6
	 0v4CS57vQzN8Z36kdlZL5eC8yTPwRE/MSNc1WMnsaLDR3sM/Eh67xdwTgfsWtJyQTfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DQj9+7CG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39E606A31A;
	Mon, 23 Nov 2026 09:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A39E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DQj9+7CG
ARC-Seal: i=1; a=rsa-sha256; t=1795426122; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TgqzDKVEL05neW6G3OiXqN/NYFeY0JBuHTOpsKcaNHJ/7MlsUSMQ1snWnTLodHVpybgZhsii0ccE/eydlvwpzpWDn3TWDII7ON++Q24OnUhwgsqbahhN4Nuzp4//msYTulAZTgGdAllaqAzsxp9RIc2by3M4AGCTmjLCB6P3fV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795426122; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=53LL2D2w2EtJWe1+ddsR6vv92olybDI66APL3fli6Ak=; 
	b=Wn32+qDuW+Qgs2SnyxdeAWxG347VXmalFRCh6dyUQHASp1SbrJ/6Lvv7JUeF8JP0k85V6bQYye/qOczGtvIHhLg99uoDCdQOxGnG+rAS+Au0CXiWednfhkeSzLHvExC3WaUF7yba71/Mwjc7MnhWvq51skMYEHKdWayMSwrCFio=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=DQj9+7CGafMRyuGqodovNZbhyVhriEePnrEDodKxF/BU9L8aNqTKtKsJeOdLJSmTTLJbYQ6iivtbuXVV+HxZt4b8QmkMyONezmeoK0tM1jaxB5XDJRYvG2AjbMlZMkRvCtuw0JkRjf6E8T4C5Lgn9R25dUj5t9S0tSckMHjyyog=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=53LL2D2w2EtJWe1+ddsR6vv92olybDI66APL3fli6Ak=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795426120017335.5726507575188;
	Mon, 23 Nov 2026 01:28:40 -0800 (PST)
Message-ID: <ad73cef4-0212-4749-8950-140dcfe4438c@collabora.com>
Date: Mon, 23 Nov 2026 10:28:34 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: verisilicon: Set need_postproc before
 resetting the CAPTURE format
To: aiyengar1990@gmail.com, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Hans Verkuil <hverkuil@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261115-hantro-fixes-v2-0-bfecfb07a3e7@gmail.com>
 <20261115-hantro-fixes-v2-2-bfecfb07a3e7@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261115-hantro-fixes-v2-2-bfecfb07a3e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/11/2026 à 09:39, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> hantro_reset_raw_fmt() sets bit_depth and need_postproc only after
> hantro_set_fmt_cap(), so hantro_try_fmt() sizes the format with the old
> values: after AV1 film grain is turned off, the CAPTURE buffers lack the
> motion vector area. Set them first and restore them on error.
>
> Fixes: 80c7373a456e ("media: verisilicon: Conditionally ignore native formats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/media/platform/verisilicon/hantro_v4l2.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 83af9fa1ce94..5939fffc350d 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -449,6 +449,8 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
>   {
>   	const struct hantro_fmt *raw_vpu_fmt;
>   	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
> +	bool old_need_postproc = ctx->need_postproc;
> +	int old_bit_depth = ctx->bit_depth;
>   	int ret;
>   
>   	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth, need_postproc);
> @@ -465,14 +467,17 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
>   	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
>   	raw_fmt.width = encoded_fmt->width;
>   	raw_fmt.height = encoded_fmt->height;
> +
> +	ctx->bit_depth = bit_depth;
> +	ctx->need_postproc = need_postproc;
>   	if (ctx->is_encoder)
>   		ret = hantro_set_fmt_out(ctx, &raw_fmt, need_postproc);
>   	else
>   		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
>   
> -	if (!ret) {
> -		ctx->bit_depth = bit_depth;
> -		ctx->need_postproc = need_postproc;
> +	if (ret) {
> +		ctx->bit_depth = old_bit_depth;
> +		ctx->need_postproc = old_need_postproc;
>   	}
>   
>   	return ret;
>
