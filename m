Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866A2836F
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769087; cv=pass; b=mTZBrzbz0EyMgb+87/EGPTHo9NQspbSH501Xs7msklK4wH8pJe3d3OgQbflY2a/8bkoJDzhnONBMBXNDichrrMC5x6ZomE44R5zVte0Ln4HkjRnpecw1FLmGMipg/F/0r9MhfK47BvfRG/UgksUer9b0ZE7xfKbl0f+YPVYIv5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769087; c=relaxed/simple;
	bh=DBLsZBTcpOpqSPXBTYH+P28xN9Gb07adf8wrpusAmuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtOEXvBFZoxrcdjZhd2nsXUyhPTJWH/9fVhoRXmSkgff/oy3YI5mI7JU+31dbL67c3NDlmYxyO95nkUCjA69Szv1XU3n14sMQZTbQ1qC39CNKZfWJicGb/6BqZD1KV4q2BweM0uqnI3wCBjtbQSEIjJeZZHkBT2hNqiK2qvvVHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b=DysI+TXI; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b="DysI+TXI"
ARC-Seal: i=1; a=rsa-sha256; t=1785769068; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nCbIWIpOY9mnXvTlxX4V3ItQJolyEDAVuCn987X95RUwD+yysCaY/7ipSKkIx9ImGmjztedcKbubmk2c8AbxUjwZDT3E7QbtC+wXuwNq8o39rOKorsyqGRhH2XF/k0TMFfwfsE2UbQT0ehpxJDqFvSgWCbTHXToS2moT3M31mI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785769068; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gtnRxnAJy2dsiKrobx2oFPPKqEB9iFtcSoUIiKrtqa4=; 
	b=FilKMOvbhSjpRQMHqH2o8A7F/MFfqAaMETAGrSEHqR9g6aoI0ANjUnlNWQlX4w5uT6nXhq0z6nsYlqozzcRtwImfPAylhN3rRFJoiWl++tPx2KtPX4fam3spKKEjQm+YXQ7ypw9eZyYCKmcuo71GvGxTWAyAMif33znXYrR34DI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=robert.mader@collabora.com;
	dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785769068;
	s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gtnRxnAJy2dsiKrobx2oFPPKqEB9iFtcSoUIiKrtqa4=;
	b=DysI+TXIVYay5Z5FUzkO3OefQHVO87Au7luV5QsHXGVC/cEdimXoYHf4DNqzRULT
	VpkJzjQtFrLwW7X289Bl/2HRYPYMfKT5DUWniEKXE8qIVaaNSlGh2nM+SKOvJon9TT+
	DaJp3bvB3Ujvx1ashhL6I3+ewclbSiDPpWHeJHUs=
Received: by mx.zohomail.com with SMTPS id 1785769067337954.6216272757437;
	Mon, 3 Aug 2026 07:57:47 -0700 (PDT)
Message-ID: <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
Date: Mon, 3 Aug 2026 16:57:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org, kraxel@redhat.com,
 stable@vger.kernel.org
References: <20260803144120.11524-1-xaver.hugl@kde.org>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260803144120.11524-1-xaver.hugl@kde.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

See 
https://lore.kernel.org/dri-devel/20260722110145.36641-1-robert.mader@collabora.com/ 
;)

On 03.08.26 16:41, Xaver Hugl wrote:
> Buffer sizes can get big very fast, and the previous limit of 64MB
> is easily hit nowadays.
> I hit this problem while working on better multi-gpu copies for KWin,
> where on my 5120x1440 monitor with scaling applied, some apps ended
> up using a resolution of 8192x2304, resulting in buffer sizes of
> roughly 75MB.
>
> As another reference, with merely 32 bits per pixel, buffers reach
> - 33MB for 4k
> - 133MB for 8k
> - 530MB for 16k
>
> With 64bpp, those sizes would be doubled, and even 4k would hit the
> previous 64MB limit.
>
> Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
> Cc: stable@vger.kernel.org
> ---
>   drivers/dma-buf/udmabuf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 2f94be1df525..8cbba7ddfa00 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,9 @@ static int list_limit = 1024;
>   module_param(list_limit, int, 0644);
>   MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
>   
> -static int size_limit_mb = 64;
> +static int size_limit_mb = 1024;
>   module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 64.");
> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 1024.");
>   
>   struct udmabuf {
>   	pgoff_t pagecount;

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

