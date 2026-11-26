Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795709932;
	b=fZdqM+NVfL2ZKW0lvPwfkbj5FBbC8u1UobLueLbtkw0p86ppIMvhA/HkduHgMnsZe5H9
	 3yg2D8nZRSIugO1Tj4ZUvsN0G6swm1edt6tC47qkrU3DRT07iJbzhw8UilNFQVVLXGuhq
	 TxDsuwWnEl5YOJI1L0Bzbl1NedNk+JSeGYZVAD/c1uaLaoqVtzTneKXtLe7JzuAaNoVmE
	 lOUvqlRHV2ypBb3NEMC6FGdjhQiO2S8mjnJIW7hUN07wZsn2vukHpUtfpQ/xMEZeK4TcR
	 3xfVFiuNIlC33MMCci58BUgDqDzHU5r8uxy9b828MvM/gOMrPEWB0UBNtqKVsY8C12Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709932;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=Sheh8Re0PVDjBdVA3EltFLk4JbLOu8Er8OMJmYxJgaY=;
	b=ssNClvzuq2iXTrEap2+WbBFmIwqI3b9uylYkH3gVWK3B61qXo1b9X873hXA/VJ4F9DEq
	 5NITNryOWJlLyZQk1gh+orJcf42orS9Ow7+mEfsfDCqiqYkMmhPxaX+iVmKj71cQ5gOKB
	 6lQxa+2jTAdBFaXSI6xRI542CWq3O6Q6TCBQSXgOCH7C0sSVimm+QEmiUiRmJbayaDwsj
	 3WtVMF/mN72V4prrw7a0p/BnUBTx4KqJ5mgwim420EqqGDrYBBbmpT3iycqbRi1EOsIa/
	 f1KRruoWy1iDx+OOJWy7IRSGmsFbQApw/zTkMt6m4lW4qWaM2vZS8AAlWsUS38QFxYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=N4eJIi74;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47C606A31C;
	Thu, 26 Nov 2026 16:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A47C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=N4eJIi74
ARC-Seal: i=1; a=rsa-sha256; t=1795709910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n8GT9DA/b/dufTX9LgvVofXdLlN3BC36O6/ydE/f9tMvhoEMheukiFTToQBb4e9KQwOr44+F71kpXAld8Ii9NNkvYn1IOcGODw93chYAUEr/q1noGfazPFSh5sVu+8ROoCgaJi+9s20n8qbNlQczS9scdv5tveLXC7h/JQT168I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795709910; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Sheh8Re0PVDjBdVA3EltFLk4JbLOu8Er8OMJmYxJgaY=; 
	b=flgEM/ggFBn4Sb+vjKM13wy3NygJ3i6HrKodCIWijtTmfXA5iUPbDb287PWYb0lS85KeoDsrnwhs7BzONfduUxuCYamOKgAWRhfvxb3tfjXbT8O79FR7eXOxegYVKXb14yb3hQcdcubFVqoVEFSH1VILgf4C+0vHfNifsZqBgcQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256; b=N4eJIi74vkSqP+pvXtfONpD3X2GWHG+f2PvYihGlAhDv/yO1ArA4Nek1pPPe3pewoUVF+TD7BVefLCVau7ny1vP2cUYFpXSx4DGZ9q+EgU5YlTDXf+meF8uGbfBGlQ7FzFlLGA3/spmGCa/io7yFhUtsFvnM2qCLWl7mUcIJi3k=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Sheh8Re0PVDjBdVA3EltFLk4JbLOu8Er8OMJmYxJgaY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795709907264444.03070160972027;
	Thu, 26 Nov 2026 08:18:27 -0800 (PST)
Message-ID: <b79882a0-d438-4798-9a28-5019ae3be4c0@collabora.com>
Date: Thu, 26 Nov 2026 19:18:23 +0300
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
Subject: Re: [PATCH] media: synopsys: hdmirx: move the reset bulk data out of
 the driver data
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261116-hdmirx-resets-uaf-v1-1-1903146a3118@pengutronix.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261116-hdmirx-resets-uaf-v1-1-1903146a3118@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/16/26 18:06, Sascha Hauer wrote:
> devm_reset_control_bulk_get_exclusive() keeps a pointer to the bulk data
> it is handed and releases the controls through it when devres is torn
> down. Since the driver data is freed from the v4l2_device release
> callback, remove() and the probe error paths may free it before that
> happens: on every unbind without an open file descriptor, and on every
> probe that fails after hdmirx_parse_dt(), in practice a deferral.
> devm_reset_control_bulk_release() then reads the controls from freed
> memory. KASAN reports the use-after-free, the controls stay claimed, and
> the deferred probe fails for good with -EBUSY on the exclusive get.
> 
> Give the array an allocation of its own with devm_kcalloc(), so it lives
> exactly as long as devres needs it.
> 
> Fixes: 03ec4aa9817b ("media: synopsys: hdmirx: free the driver data when the last user is gone")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Hans, this fixes the patch you applied from v3 of the hdmirx bridge
> series. Sashiko pointed out the use-after-free on v3, and the fix was
> meant to go into v4 of that patch. If you can still replace 03ec4aa9817b
> in your tree, please squash this into it; otherwise it applies on top.
> 
> The remaining patches of the series will follow as v4, rebased onto this
> and with the v4l2-compliance output you asked for.
> 
> The fix was developed with the help of an AI coding assistant (Claude),
> which also drafted this message.
> ---
>   drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> index a241761b1bcd9..8a5304603c00d 100644
> --- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> +++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> @@ -144,7 +144,8 @@ struct snps_hdmirx_dev {
>   	struct mutex phy_rw_lock; /* to protect phy r/w configuration */
>   	struct mutex stream_lock; /* to lock video stream capture */
>   	struct mutex work_lock; /* to lock the critical section of hotplug event */
> -	struct reset_control_bulk_data resets[HDMIRX_NUM_RST];
> +	/* devres may release these after the driver data is freed */
> +	struct reset_control_bulk_data *resets;
>   	struct clk_bulk_data *clks;
>   	struct regmap *grf;
>   	struct regmap *vo1_grf;
> @@ -2296,6 +2297,12 @@ static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
>   		}
>   	}
>   
> +	hdmirx_dev->resets = devm_kcalloc(dev, HDMIRX_NUM_RST,
> +					  sizeof(*hdmirx_dev->resets),
> +					  GFP_KERNEL);
> +	if (!hdmirx_dev->resets)
> +		return -ENOMEM;

hdmirx_dev->resets array is a part of hdmirx_dev struct, the hdmirx_dev 
is used by hdmirx_v4l2_release(). This looks like a slop, what am I missing?

-- 
Best regards,
Dmitry
