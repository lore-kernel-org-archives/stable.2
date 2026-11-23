Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426055;
	b=ye5ydywIZoqq58ruzmnH8cPu6QfjCmHu/CvAHIMCLmHFxf6YM9wDvia75bDYA3VEOwXv
	 vhJeL5pI3KtaxjLqA4gnxY1ub0h6ayO7RrKhHPlEcVU2chencYU9vx4wvZvAfBiCN+iLU
	 X37U1hZZFcwWcto5v3uD8HuERFr6BKLHagEq59Tw/tSJi0N2zNIYKxqqB8YkaHsWAO+Ae
	 IP0HfehImWVrLhsV2aOPGqUI7SgUlgRJY4S02XCw+beX2K0rSXzXGNtbwRXiQSgJMwXzj
	 m1X+eJFVmTxC8Wi0/nGUrITprRa6o5Gw7xiBbzTud4gliRmh53bv+3HYOVjq4PDxFSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426055;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=O9WYOpMy3rGcu2QFyMreqnCz0RC3LAV/SW4SChJTtnQ=;
	b=CisWB3cr/JEa50T94kynepseFSYDO5Hlq6YkPjo/YH5QTuimub+jKNexTDCMiwkEVH4A
	 m9rsTNu94v+USwUbrifIjj2orR6guNtqlcIrBhKGTlAZ34GBK41VhwXcG3BscW+d/5oWt
	 +5BHoe0qjuzUDyOUZNQQZ9ulrVpdDjw3Ue11CtJP/gN2KnBbGoHLYOtmsRYHAhgelCpUg
	 cjIJ/0Y/68xA6PqUiJvWJ8lh5ccsxOZ61pBHMojfOP1bi7AOa3Z3hguhs5zufrX83fT57
	 l99h5PSf4kNlQs2/VA28Fio5PHySt6YZXaJJBeAZ6gQWnNQ9cAigYyb4jUPolyLztrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Lq8kSUT0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2049606A31E;
	Mon, 23 Nov 2026 09:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2049606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Lq8kSUT0
ARC-Seal: i=1; a=rsa-sha256; t=1795426001; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lULQlH/iWZZAdHdVhCjEwlcIzQA41m4SqeNp1MPnq9Jt/tYdxzg3aHTgGj1D2rz+KsuCUGwWnaVUvosX47EyOBrDbAiRBsYZxxwyIk7N28IBwB/qIZbt0oHJQb7YCfzbN+/0X/vCy6DZt97F/biYn2YeSVTsI/G2hWO9GPU6IzY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795426001; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O9WYOpMy3rGcu2QFyMreqnCz0RC3LAV/SW4SChJTtnQ=; 
	b=Vd2ywhMpqKj7PqWkZl2NRUcPuWD5TwNdurhTts1g7C9OI3IlVBXUkByYjeBXo+DMs3X/V74YIyp1KYAV1tCnS1Fcgm1IOqY+D3aGt6r1r3PoN3fPTs0rIxBZi6h7khs/Lgol0aJ+k6PzcYR6ijxXRgTFbD16sYrLLTXP3emy6GI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Lq8kSUT0J+v9ygmmcSasd3NU78h95TZpZxPHb+q8M9V34UAys8cfLKpk78g6OMR0k0Tr3dwBNTdK/2MN3UtIZfH/i4xwvvn5zc+9mqrh/acmWBugjARWoaC/mLFSVdmxrSvVEA//lCYB2L2TmkaREdzX42092zNRrBzhUiYCxq8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=O9WYOpMy3rGcu2QFyMreqnCz0RC3LAV/SW4SChJTtnQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795425996155774.0498302105844;
	Mon, 23 Nov 2026 01:26:36 -0800 (PST)
Message-ID: <793eccf2-712b-44b8-8d71-5c69460cd5b8@collabora.com>
Date: Mon, 23 Nov 2026 10:26:31 +0100
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
Subject: Re: [PATCH v2 1/4] media: verisilicon: Size the VP8 segment map for
 the largest frame
To: aiyengar1990@gmail.com, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Hans Verkuil <hverkuil@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261115-hantro-fixes-v2-0-bfecfb07a3e7@gmail.com>
 <20261115-hantro-fixes-v2-1-bfecfb07a3e7@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261115-hantro-fixes-v2-1-bfecfb07a3e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/11/2026 à 09:39, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> The segment map is sized at STREAMON, but the CAPTURE format can grow
> while streaming and overrun it. Size it for the largest frame, as VP9
> does.
>
> Fixes: bbd267daf4fc ("media: verisilicon: vp9: Allow to change resolution while streaming")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/media/platform/verisilicon/hantro_vp8.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_vp8.c b/drivers/media/platform/verisilicon/hantro_vp8.c
> index 381bc1d3bfda..98ad86269bc3 100644
> --- a/drivers/media/platform/verisilicon/hantro_vp8.c
> +++ b/drivers/media/platform/verisilicon/hantro_vp8.c
> @@ -151,8 +151,8 @@ int hantro_vp8_dec_init(struct hantro_ctx *ctx)
>   	int ret;
>   
>   	/* segment map table size calculation */
> -	mb_width = DIV_ROUND_UP(ctx->dst_fmt.width, 16);
> -	mb_height = DIV_ROUND_UP(ctx->dst_fmt.height, 16);
> +	mb_width = DIV_ROUND_UP(ctx->vpu_src_fmt->frmsize.max_width, 16);
> +	mb_height = DIV_ROUND_UP(ctx->vpu_src_fmt->frmsize.max_height, 16);
>   	segment_map_size = round_up(DIV_ROUND_UP(mb_width * mb_height, 4), 64);
>   
>   	/*
>
