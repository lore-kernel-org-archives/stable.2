Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930647;
	b=CKQtilVOVSoOe2H92xFLdsEY79B3q52X/6hFm7gk6CLuGI/VsQwBpxEqJvSkv3XS8mxP
	 k3ka5BOm9p2j5tSMtZPoZwEX0ivNNPptCaOBzM64viKYEo0titDn29X9kq5ahBzCkj0nJ
	 X79D5XLshuKYQiOSc9nXb2L84ZFghY92ZEdh7m3lzC9jAD7fo6Of/x7KksYhAXR0sG9jo
	 Mhb852yvubu13K/fFoC0wo/yu/TodUJUgOu0j5Aq+iJeLReBwGoPFVpKdQQn1nUwUDrJG
	 dU42xtmLPqavkK8pOIn5DbInLOHkSWtmz4v2mNMqwDJzAVjzIy9PyOFf2Azbi2vHB9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930647;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=G1LL/x7N77Eu1XLmVkvU8EZYqDRVKlBzvqhN4r+M2Js=;
	b=MwyBotSh8lbtIzML994Qfna8OOclXGI8TdCNTNn6ZDdlTaBlmv+rA8w3rECWe/rSD4aP
	 raoz9FNxoTXF0VAUSpzGGSnkol95p4/wcGRDVosZlo9Y29s1CKLXnXEx5Q0lHTH9TysjY
	 h9hySPa72vXoZK6pqZFMiS9P2T7SjGDOEkzlt6GCVxwF7YvogzYVk4GwIfddt3cux6aBq
	 NmiXFFtTynlHr5z0Wm8JysaXkZ9HGd0ylijJwb0liGfd8xHnurItdQKCFpBXym8CWVbjO
	 gyTbkIN7Q7pU0/hQhppjNzacfEodHntjC6evU8LfSt3LL4ok88KlblOWT8VlbARa23A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hfz1DwFR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BC606A8BB;
	Tue, 17 Nov 2026 15:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E43BC606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hfz1DwFR
ARC-Seal: i=1; a=rsa-sha256; t=1794930629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M+ZrGkTyiA8mwALNyDzkzYpqOuc0nk8rmPgHMbEodQl2vZLceLmuJhx0znthV3bbNnTHSd2FH5+eNy1ekBAVnajB/5F6/fyw7NVxVymy2+4CKSaVehsf+ryAUiQpqQ0SGD3MpNK2a8vPiigIhAWyMpm/Ssr5mbHQgutT53IyyL4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794930629; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G1LL/x7N77Eu1XLmVkvU8EZYqDRVKlBzvqhN4r+M2Js=; 
	b=iZK1oKOEBlWQDlGQ6qNLIdCkTCV7v2bHmLs9GWvOgrqVeJaqJ75+EcQZlO5lpJEeyveuGOUD/mYRtdjljISHPweKHwES8MS11buv1sN7I2iZIA9HwycDLm/lirZRJVPrXiA5AL/p2uvOKKGJemENT36JrKYgfEGaEgWgmcNU7IY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=hfz1DwFRq3HWKRf2nl7c818zlf3EcVL9zW5dXCaoQaXM+BjqHTCDnFcCOUMBcNxWuKkCs0ROA04nWwMXZYrP5YR6H6aUFyOAWD/9IqiyBFUPEpMVOi61iBD8lzOIxfFySCJC+RBAkqxIgEp15kncqGhzWb0CAS4QvYJIEko786o=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=G1LL/x7N77Eu1XLmVkvU8EZYqDRVKlBzvqhN4r+M2Js=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794930627710904.9822389417972;
	Tue, 17 Nov 2026 07:50:27 -0800 (PST)
Message-ID: <93161ff8-dd0d-4253-aa80-174a33de30dc@collabora.com>
Date: Tue, 17 Nov 2026 16:50:24 +0100
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
Subject: Re: [PATCH 2/2] media: verisilicon: av1: Read the segmentation map at
 the reference's offset
To: aiyengar1990@gmail.com, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20261115-b4-vpu981-av1-refs-v1-0-c65769715db9@gmail.com>
 <20261115-b4-vpu981-av1-refs-v1-2-c65769715db9@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261115-b4-vpu981-av1-refs-v1-2-c65769715db9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/11/2026 à 09:59, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> The segmentation map of the primary reference is read at the motion
> vector offset of the current CAPTURE format. After a switch to a larger
> format, that is past the end of a reference held in a smaller buffer.
>
> Use the reference's own offset, and skip the map of a reference of
> another size (the spec then uses segment 0, load_previous_segment_ids()
> in section 6.8.2).
>
> Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> index 59f2adf74850..f23af435f961 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> @@ -899,15 +899,17 @@ static void rockchip_vpu981_av1_dec_set_segmentation(struct hantro_ctx *ctx)
>   	if (!!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_ENABLED) &&
>   	    frame->primary_ref_frame < V4L2_AV1_REFS_PER_FRAME) {
>   		int idx = rockchip_vpu981_get_frame_index(ctx, frame->primary_ref_frame);
> +		int mi_cols = DIV_ROUND_UP(frame->frame_width_minus_1 + 1, 8);
> +		int mi_rows = DIV_ROUND_UP(frame->frame_height_minus_1 + 1, 8);
>   
> -		if (idx >= 0) {
> +		if (idx >= 0 && av1_dec->frame_refs[idx].mi_cols == mi_cols &&
> +		    av1_dec->frame_refs[idx].mi_rows == mi_rows) {
>   			dma_addr_t luma_addr, mv_addr = 0;
>   			struct hantro_decoded_buffer *seg;
> -			size_t mv_offset = rockchip_vpu981_av1_dec_chroma_size(ctx);
>   
>   			seg = vb2_to_hantro_decoded_buf(rockchip_vpu981_av1_dec_ref_buf(ctx, idx));
>   			luma_addr = hantro_get_dec_buf_addr(ctx, &seg->base.vb.vb2_buf);
> -			mv_addr = luma_addr + mv_offset;
> +			mv_addr = luma_addr + seg->av1.mv_offset;
>   
>   			hantro_write_addr(vpu, AV1_SEGMENTATION, mv_addr);
>   			hantro_reg_write(vpu, &av1_use_temporal3_mvs, 1);
>
