Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1B3CBE96;
	Wed,  7 Oct 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372111; cv=pass; b=DoW5DYtHM2GRVP0ovZKGqZW20cq0gfEKXPz0GDQAf87SudGaFwaijyzHRCd6fuUeDNqMfsrJIueRNJCVC7zLATL3E22R+wSl275662/cnEpsoU1492iBs00uImBrNEPV2dAO+l3L8XRJvNTdvZwmQ6/9tdWL8bjLCP3oG5EgQHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372111; c=relaxed/simple;
	bh=Oz5w33I0aWZKeCyF2rgD7FdclPfY6S3l6RkrDTyWTO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1Q+X7tWUE2461x3gufOJLuuoP2z1i5wufY/hNRuRZ5Rf86iXd99Z73HptxK26UiOoGz0SFHT4R2qGG5Wk1jiuiKlRkzSYpdtGmivPHLBa0JsmFHw4RtonkySAfw55+6fzxI4SqoVd2BDAnE+ewyRigalfjMEQSNzjF3JnltRV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=kxlw0qmp; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="kxlw0qmp"
ARC-Seal: i=1; a=rsa-sha256; t=1791372064; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VVwyfoWYAq10SOGH/95EvOcTYVYkPsLx1K36jmaD+REVN8CixevtiTtXFEjvkXCB2zkleTsErRHyh5K5kOoHbfz/KLWWvYfOTu2o/NQYObXuYOTCk4ShhDgS+r/mGfd2gi1dBB1nuZDxHbsXVeUjjRXmL0IkeoZnHjqat2sEjj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791372064; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5AjtX2ixtUaJlIPmzG/Mdx77uYIeRYJWWfOZV1ANyJg=; 
	b=gabNiKMUc6RLzUsXQ6iCb980c8FP84Q7b53hUxtNk43ZddgGLp+HOkjEyk0M6NZz/EBIzCjOu+yOYimDs0y9K45b0xbwT/0dP43xVye+EbyVXfdEMENaDbBdmreRkLVEKwUEsjupunGKxhG+hVhus5BXbSMHZWm+398JtRXnFlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791372064;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5AjtX2ixtUaJlIPmzG/Mdx77uYIeRYJWWfOZV1ANyJg=;
	b=kxlw0qmpSZj54hR03TKiP1ReAp0stnqGH/1cNhw0QdVF55wc4fStAR/FekYkUHP2
	0df7doR+W+MuNHEn1/nuLvRzTtuc0hpeWYCDFaKz1eeCb3PFnVA3I9SJks9a0RakK6/
	xmFwFLk1rHhHrAPFCCtaxWv3+Noh+7E2GP+I68OI=
Received: by smtp.zohomail.com with SMTPS id 1791372062135131.0277099644934;
	Wed, 7 Oct 2026 04:21:02 -0700 (PDT)
Message-ID: <647b6128-2bd1-40cb-86bb-d36e84378d93@collabora.com>
Date: Wed, 7 Oct 2026 14:20:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] media: synopsys: hdmirx: free the driver data
 when the last user is gone
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>,
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: Gerald Loacker <gerald.loacker@wolfvision.net>,
 Lucas Sinn <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
 <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/5/26 16:28, Sascha Hauer wrote:
> @@ -2792,16 +2807,13 @@ static void hdmirx_remove(struct platform_device *pdev)
>  	hdmirx_disable_irq(dev);
>  
>  	vb2_video_unregister_device(&hdmirx_dev->stream.vdev);
> -	v4l2_ctrl_handler_free(&hdmirx_dev->hdl);
>  	v4l2_device_unregister(&hdmirx_dev->v4l2_dev);
>  
> -	/* touched by hdmirx_disable()->hdmirx_plugout() */
> -	hdmirx_dev->rgb_range = NULL;
> -	hdmirx_dev->content_type = NULL;
> -
>  	hdmirx_disable(dev);
>  
>  	reset_control_bulk_assert(HDMIRX_NUM_RST, hdmirx_dev->resets);
> +
> +	v4l2_device_put(&hdmirx_dev->v4l2_dev);
>  }

This is uncommon v4l driver removal pattern, I suspect it's either not
correct or needs to be fixed in the core code.

What is the user-visible or sanitizer-visible problem? How to reproduce it?

-- 
Best regards,
Dmitry
