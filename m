Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67C30D41D;
	Tue, 28 Jul 2026 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253680; cv=none; b=ixaX359tuz4eQWnX5DwzCzW4LyX+c9Csu/C+zJ6FGg5z6l8J6igurVKAp8zaKoAbS9k24YK4/qJZ3B5GkKEB3Rf+0mqPqVinK5ef769fjLyWmvb01+JI2/iyFTE5jRP5/1Vw4syfX04/X3b7Wq4A2ka2TkfJbwFk78J+uvW95oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253680; c=relaxed/simple;
	bh=xJDhVCkgWKO4HuQCt6XRq1m+1KGRNT0WhDkL9oXb380=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gk86ntzPBvgb69Tyff4VFU45UcW5NeKChxBmGmVPea1pC9GcR/raugjFtZjg5wyAWlL9J2w3PejI6Kc25TjLhBm9C9PUTd1HnlJdMdTrYK+T4AH+fjPnbaNJfWurm/29zC37i8IoWKVovrmq0MthnTDPf/zGwpFvUM67tgdXKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adamthiede.com; spf=pass smtp.mailfrom=adamthiede.com; dkim=pass (2048-bit key) header.d=adamthiede.com header.i=@adamthiede.com header.b=D6qqTCX2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adamthiede.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adamthiede.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adamthiede.com header.i=@adamthiede.com header.b="D6qqTCX2"
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h8fxQ4dq0z8v22;
	Tue, 28 Jul 2026 17:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamthiede.com;
	s=MBO0001; t=1785253674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m0jzKJEPepVGepYcMIeTQbCbRTzWsK+sr+7McMSIGg4=;
	b=D6qqTCX2p14zOOjeMNhLND/fWWTF5yY8lwc9VkHE58VDJEp/Tvpp+zdV59jna769cR9eMM
	UyClvjI4IPjitzMfh+JUPhU9F3DS5Z+WB6Fo2E0EkOzQF5TNTtOojeBqjd5sQ95l4phNw8
	O3vIdTiBuMeA0HNQUZrRfk2KEzEbm6SVRgLJzjN3qncI4ECyXJRu8c12NWuKxLGfF18FEF
	eVdx3jOENOlE+UwOGR4Zq0DsxL/CHJLBTp06Eb77fDu+wxeTlQjfQ5QkLXyy9oAEhhC/+T
	G8LdXZjEd4weRn9vKAxm9oI5hWf7es9iXXMRmEifZjpXM+e2JXXfxPdDoglXQQ==
Message-ID: <22898b98-1d46-44b7-b5c7-e636cfc110c5@adamthiede.com>
Date: Tue, 28 Jul 2026 10:47:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: bisson.gary@gmail.com, regressions@leemhuis.info, p.zabel@pengutronix.de,
 airlied@gmail.com, simona@ffwll.ch, matthias.bgg@gmail.com,
 ck.hu@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 stable@vger.kernel.org
References: <20260728153145.578404-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Adam Thiede <me@adamthiede.com>
Autocrypt: addr=me@adamthiede.com; keydata=
 xsBNBF+n+90BCAC2ZRLVcvdXDgfY7EppN05eNor3U7/eeiNCCEIWZkYLhikUEP1ReLGBkXpK
 Pc70hfnKAKkCoth3IwhDty9WXMNU+iLNei4ieb2luW+UqluR6xIUIA+txahMU9YcjVaQTKf/
 yZWO4yl6pfBPCxC2UdPZKBAdGoi5NnE0ABFNbhBETQhhBic533lZn33ByupfI3acECnQdjgQ
 llCUpDbw4I+S/N1iFiEHcbMXH7ZB00e3IYNorZ1E9v7p++5rDY1fQ9gXpieg1vFKwSq1NJWo
 9xx336YjaTUbX0EwrdKd9l8AktA3yRjckaK5TAcwSQaDtHvhpbl4ebvPhtwHh699MroXABEB
 AAHNH0FkYW0gVGhpZWRlIDxtZUBhZGFtdGhpZWRlLmNvbT7CwI4EEwEIADgCGwMFCwkIBwIG
 FQoJCAsCBBYCAwECHgECF4AWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1HxQAKCRAC7fV9
 o/vRzgyRB/wLqRCvvWhQCMgvzeKvru9wcXquhb77K8H/ByLbfiT8YBuP3lZFVh0IQhgO9Ylk
 fIoOJE4V+jjxyOnO2d9xjGbvAmmR6yT0gfLzSVWqrC4k+V9MWLv43nrNzxt41dvo5j824FAl
 X+zaiRZCdO8Jtxg5Elpiop2SKLi1utX1Z8i6YZh+ccJZlchUBAGUTk+D4UjK7vUcjLWT96ya
 CtdtTfXyw36CvGOPEWfc6++Kkl/5sgej1i7biPYzu/r0vssaQYTXKSrv6Cfa3Maa89ASiTtv
 q4qmhLnJeCrPxWlRAf6LEizeBEkOasYni2u8sp4wBezEq45Ozu45sfPkqLpPolG7zsBNBF+n
 +90BCADBRt+vrToRBEG580n77S99qSEkbKD+oJtCVyovnjMNkg0K9UG68LIeCX/ezngiV1M8
 JISvw5iFOuUFqGX/1hLl9wgt/YpuIrgWOp8XxkotavTCloLDvQmufJPO1L8bnnA+WgP2YgVZ
 5MJTj/t4DI+yQgysEjsH8aurHO2uuqgJE+xK+2dy6Cl/wskuGxObksSPmmFH5PH0Joziwrtl
 61ouLE2XwKbkMgIGEKkbFgbfwz3/QuLZGBni+OOtLzXeZ9wNTW/AHUPy6S9U4F+5z6/09fVT
 tTH0cvrgAGjbASlYx2VqGONXAsxCfjulq6ryJBFlPLp949c/JTTgOojukCSbABEBAAHCwHYE
 GAEIACACGwwWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1H0gAKCRAC7fV9o/vRzlamCACs
 vHw+0heTm+BfC3S8DUST6889gidIIwdqBep1ByzetCph7Bq8Y8BlT5YTX0u/bSKkxCzFgeTm
 vC341Q09ST2XjLAl1ZTdzGhH9gcgYyOw34pr5fPQRJLB392mPzD8YReRzciNbhWzj+DLgeVe
 ouyfGajd6jDjkf4FEq+trQLGZhpfsKn3JnDbzBUs945D50l/vz9q/QN3qZO+H4F6g8ZeMnqo
 FOEFN26xVtdEDr+0DNFsbgKmEzs675kdAY78ZZdbEetX/FSknxJ+FK1ZW3J7Yswwulj34AXP
 LB49Mk8Ot7fo6mdt0DkV11JS9LmKxKvpY+KTlrKG+i7pVCSZvVUx
In-Reply-To: <20260728153145.578404-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/26 10:31, AngeloGioacchino Del Regno wrote:
> Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock
> during pre-enable") rightfully moves the HS clock enablement to
> before atomic_enable(), but it's moving it to mtk_dsi_poweron(),
> which is not only called in the .atomic_pre_enable() callback
> for the DRM bridge, but also in the MediaTek DRM's .ddp_start()
> callback, which happens way before the bridge ones.
> 
> The HS clock enablement should be done at just the right time,
> otherwise some bridge chips (or some Display Driver ICs) may
> not work correctly: this is seen at least with a Parade DSI to
> eDP bridge (PS8640) on the MT8173 Elm Chromebook.
> 
> This resolves a regression that was seen on the aforementioned
> machine, which was happening only after a suspend-resume cycle.
> 
> Cc: <stable@vger.kernel.org> # 7.1.x
> Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-enable")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index dc0c4e867179..c729a163bda6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1165,8 +1165,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>   		goto err_disable_dsi_and_digital_clk;
>   
>   	mtk_dsi_set_interrupt_enable(dsi);
> -	mtk_dsi_lane_ready(dsi);
> -	mtk_dsi_clk_hs_mode(dsi, 1);
>   
>   	return 0;
>   
> @@ -1284,6 +1282,9 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	ret = mtk_dsi_poweron(dsi);
>   	if (ret < 0)
>   		drm_err(drm, "failed to power on dsi\n");
> +
> +	mtk_dsi_lane_ready(dsi);
> +	mtk_dsi_clk_hs_mode(dsi, 1);
>   }
>   
>   static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,

Tested-by: Adam Thiede <me@adamthiede.com>
