Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9B3876A9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762606; cv=none; b=O1n8klrcIfp7CuRcPzWmcQqHwmcL1StM2c8oR2+MOfYwm2XJn769W9kwgKjZryuYn4Bhuxv5PFDp+kdquV5zhyy9eWadcNhSLEfzAy8cJ2TJbJ2SV25haCX6Q/Yc4lJipV7bgNFxL7WJWERnxplfRuR+h7qHh7IfzUd4g7Amo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762606; c=relaxed/simple;
	bh=x5guGdJAAIKwpP0NZplYho13twzWvU7CvwIvYsr2Wbo=;
	h=From:Date:Mime-Version:In-Reply-To:Cc:Content-Type:To:Subject:
	 Message-Id:References; b=f6VwETxIoz3R4XYOsnSxxm11Nzk4yl71cw+zkGmepIfqFS3zxx+R4HAKTyl7gZQseV7Djd79qSmQwS6eMPKiY2y6wx5qyVlRRs23dfDFTqTi3ps5i4+2RLMLbXJ+Qubyy/edWPVQPSiCNHyOa88ikSxDrA5zOYfuHMdWZa+1Jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=acf8dByI; arc=none smtp.client-ip=209.127.231.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="acf8dByI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1788762585;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vpgb7oo5WCZG8uezRw6A5uDm/zaoD9pp+3kxMCeeS78=;
 b=acf8dByILkfpRXOyEo1r6yMUP5FYBLQVdqw93OhVdUnmT6i0rAPBf5LFCQTDDYTDarUKGr
 eduGYwzqgTIC7Mv7O2mr6RQ2cvxiculImCIRQl2La6qyHC/gAf7N1dcdTmQzGWJ/7jfapV
 8rrJmABqyRc+ladaYWNgeZONFJdZF0jDXq3whsUCfa685LtN/79zE2bbteGPBO851kw1sZ
 /5qQ3zhdxGzabwXW4+0v1A8+ZbgqksqMWVeifaBxzq6iPYwBa3vhqFCYeYc647ZoPc5ZF5
 YhZTBuLdNwd42L7h8IQsw2n8pTONMqv7ZO+qPx3HyIbAogovH0h2p+t0cjZx6g==
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>
Date: Mon, 7 Sep 2026 14:29:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260902181819.267431-1-mwilck@suse.com>
X-Lms-Return-Path: <lba+26a9e59d8+b490b2+vger.kernel.org+yukuai@fygo.io>
Cc: "Xiao Ni" <xiao@kernel.org>, "Li Nan" <magiclinan@didiglobal.com>, 
	<linux-raid@vger.kernel.org>, "Martin Wilck" <mwilck@suse.com>, 
	"Junrui Luo" <moonafterrain@outlook.com>, <stable@vger.kernel.org>
Received: from [192.168.1.104] ([39.182.0.161]) by smtp.larksuite.com with ESMTPS; Mon, 07 Sep 2026 06:29:43 +0000
Content-Type: text/plain; charset=UTF-8
To: "Martin Wilck" <martin.wilck@suse.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v3] md/raid5: validate payload size before calculating payload_len
Message-Id: <b6f56e58-fcfc-482b-999a-b9ad8d5af023@fygo.io>
References: <20260902181819.267431-1-mwilck@suse.com>
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/9/3 2:18, Martin Wilck =E5=86=99=E9=81=93:
> Commit b0cc3ae97e89 ("md/raid5: validate payload size before accessing
> journal metadata") introduced a bounds check to verify that a given paylo=
ad
> fits into the current metadata block. In order to calculate the payload
> size, it has to access the members payload->header.type and payload->size=
,
> the offset of which may already be past the end of the metadata block,
> because the loop condition only checks that the first byte of the payload
> is inside, and the payload entries have variable sizes. Later on,
> payload->checksum[0] and payload->checksum[1] are accessed without
> verifying that payload->size is large enough.
>
> Add another check to make sure that payload->size can be safely
> accessed, and make sure that the checksum fields are accessible.
>
> This issue has been found by AI (gemma4, Gemini) during a backport
> review.
>
> Cc: Junrui Luo <moonafterrain@outlook.com>
> Cc: stable@vger.kernel.org
> Fixes: b0cc3ae97e89 ("md/raid5: validate payload size before accessing jo=
urnal metadata")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
> Changes v2 -> v3: Fixed another issue reported by Sashiko
>
> * Modify loop condition to make sure the payload->header.type can be acce=
ssed
>
> Changes v1 -> v2: Fixed issues reported by Sashiko
>
> * fix use of wrong variable name payload_len instead of mb_offset
> * add checks to ensure payload->size is large enough to hold the checksum=
 values
>
> ---
>   drivers/md/raid5-cache.c | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 7b7546bfa21f..031a89faddae 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -2001,27 +2001,36 @@ r5l_recovery_verify_data_checksum_for_mb(struct r=
5l_log *log,
>   	if (!page)
>   		return -ENOMEM;
>  =20
> -	while (mb_offset < le32_to_cpu(mb->meta_size)) {
> +	while (mb_offset + sizeof(struct r5l_payload_header) < le32_to_cpu(mb->=
meta_size)) {

Offset can't be meta_size, however, is it possible that the remaining space=
 is exactly one
payload size? If so I think <=3D should be used here.

> +		uint32_t payload_size;

checkpatch report u32 is prefered.

>   		sector_t payload_len;
>  =20
>   		payload =3D (void *)mb + mb_offset;
>   		payload_flush =3D (void *)mb + mb_offset;
>  =20
>   		if (le16_to_cpu(payload->header.type) =3D=3D R5LOG_PAYLOAD_DATA) {
> +			if (mb_offset + sizeof(struct r5l_payload_data_parity)
> +			    > le32_to_cpu(mb->meta_size))
> +				goto mismatch;
> +			payload_size =3D le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9);
>   			payload_len =3D sizeof(struct r5l_payload_data_parity) +
> -				(sector_t)sizeof(__le32) *
> -				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
> -			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
> +					(sector_t)sizeof(__le32) * payload_size;
> +			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size) ||
> +			    payload_size < 1)
>   				goto mismatch;
>   			if (r5l_recovery_verify_data_checksum(
>   				    log, ctx, page, log_offset,
>   				    payload->checksum[0]) < 0)
>   				goto mismatch;
>   		} else if (le16_to_cpu(payload->header.type) =3D=3D R5LOG_PAYLOAD_PAR=
ITY) {
> +			if (mb_offset + sizeof(struct r5l_payload_data_parity)
> +			    > le32_to_cpu(mb->meta_size))
> +				goto mismatch;
> +			payload_size =3D le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9);
>   			payload_len =3D sizeof(struct r5l_payload_data_parity) +
> -				(sector_t)sizeof(__le32) *
> -				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
> -			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
> +					(sector_t)sizeof(__le32) * payload_size;
> +			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size) ||
> +			    payload_size < conf->max_degraded)
>   				goto mismatch;
>   			if (r5l_recovery_verify_data_checksum(
>   				    log, ctx, page, log_offset,
> @@ -2035,6 +2044,9 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l=
_log *log,
>   				    payload->checksum[1]) < 0)
>   				goto mismatch;
>   		} else if (le16_to_cpu(payload->header.type) =3D=3D R5LOG_PAYLOAD_FLU=
SH) {
> +			if (mb_offset + sizeof(struct r5l_payload_flush)
> +			    > le32_to_cpu(mb->meta_size))
> +				goto mismatch;
>   			payload_len =3D sizeof(struct r5l_payload_flush) +
>   				(sector_t)le32_to_cpu(payload_flush->size);
>   			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
> @@ -2096,7 +2108,7 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log=
,
>   	mb_offset =3D sizeof(struct r5l_meta_block);
>   	log_offset =3D r5l_ring_add(log, ctx->pos, BLOCK_SECTORS);
>  =20
> -	while (mb_offset < le32_to_cpu(mb->meta_size)) {
> +	while (mb_offset + sizeof(struct r5l_payload_header) < le32_to_cpu(mb->=
meta_size)) {
>   		sector_t payload_len;
>   		int dd;
>  =20
> @@ -2106,6 +2118,9 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log=
,
>   		if (le16_to_cpu(payload->header.type) =3D=3D R5LOG_PAYLOAD_FLUSH) {
>   			int i, count;
>  =20
> +			if (mb_offset + sizeof(struct r5l_payload_flush) >
> +			    le32_to_cpu(mb->meta_size))
> +				return -EINVAL;
>   			payload_len =3D sizeof(struct r5l_payload_flush) +
>   				(sector_t)le32_to_cpu(payload_flush->size);
>   			if (mb_offset + payload_len >
> @@ -2130,6 +2145,9 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log=
,
>   		}
>  =20
>   		/* DATA or PARITY payload */
> +		if (mb_offset + sizeof(struct r5l_payload_data_parity) >
> +		    le32_to_cpu(mb->meta_size))
> +			return -EINVAL;
>   		payload_len =3D sizeof(struct r5l_payload_data_parity) +
>   			(sector_t)sizeof(__le32) *
>   			(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));

--=20
Thanks,
Kuai
