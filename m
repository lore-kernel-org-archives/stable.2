Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F71E7C12;
	Sun,  7 Jun 2026 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780813968; cv=none; b=Ix0GWzpPYrPJ24qnwBLK204BIoIgXm0DgUo2K8bXokR9Ca825minU6nU1VLaZ7dN4qRZoS5+sVrzy4oaUtz71G9t9Dnqkh0raB3RRse2GN8xDGm0bvXwt0+fekCaaFaBmc4693hvyAKJ5ptCTnhmlzAcAlqSINrOkvDQfwnGEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780813968; c=relaxed/simple;
	bh=QyQ6aU3mVa7BUSitYqw1JyeKMgsBwVZiirxjccob+go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCllKzOuek/z4LPHyA+99hcrPWAWNxKoy6NMDV2Aq50Irg1XsHJUqS9p2DTI10VlnJxeOd8ns1+I+a9FJiUKlTKaFVdYRAToIFHO83kOsC5/GVeV/w4y0P96IioEN41TpEFthxDj6HwGXveYxGxIv0aAmFU9pU5IjST2yC4yDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kOtcEY9y; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kOtcEY9y"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id W73dwnUfCJkT6W73dwFmhI; Sun, 07 Jun 2026 08:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1780813956;
	bh=qnbMUaAUGWbhJ7kILtaMcBgwchhzxpm+oFvWPyiGaSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kOtcEY9yrMD2rh1xwEPTX/vzt1SW3y0/l8dFkhASECYsn0Nvar2NLusK5OuhRMv3h
	 Z6ce9NujD5LDU77KDYjf7y9eP003GlCp8EMJLfqrvTAm8GH3/HsgjQNxNZ2TYFIRZ+
	 14YmCrgonL2yL6TA9TNpxbqruf8tt5+MnHZ6E0Df+QgMTmx9dqNvM36XZ+gXyKANPr
	 xPwJ86WLT87a7J8N3a+AEKh1NsuVwcn60pPxlTp1VND8Lr+fCG6zAuL3rDdqbfkpIA
	 1P559zwHmZdEK4sJJGLjovz8XLHH0lIuq333T/4N5B7p0AQe4zIp5R6a9cnJyqzwQn
	 70hkyT6x8KxpQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jun 2026 08:32:36 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <81cb20eb-a27a-45f4-98dc-7d529b3ac0b9@wanadoo.fr>
Date: Sun, 7 Jun 2026 08:32:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
To: Wentao Liang <vulab@iscas.ac.cn>, wens@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jernej.skrabec@gmail.com,
 samuel@sholland.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260607030950.83636-1-vulab@iscas.ac.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260607030950.83636-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/06/2026 à 05:09, Wentao Liang a écrit :
> When sun4i_backend_init_sat() calls reset_control_deassert() it
> increments the deassert_count of the reset controller, and must
> pair that with a reset_control_assert() call to decrement it.
> In the error path where clk_prepare_enable() fails, the function
> returns immediately without calling reset_control_assert(), leaking
> the reference count.  Other error paths, like the devm_clk_get()
> failure, correctly jump to the err_assert_reset label which performs
> the missing assert.
> 
> Fix the leak by using the existing err_assert_reset label in the
> clk_prepare_enable error path instead of returning directly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 440d2c7b127a ("drm/sun4i: backend: Handle the SAT")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index bc35dad53b07..c9ec5fc26f7e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -686,7 +686,7 @@ static int sun4i_backend_init_sat(struct device *dev) {
>   	ret = clk_prepare_enable(backend->sat_clk);
>   	if (ret) {
>   		dev_err(dev, "Couldn't enable the SAT clock\n");
> -		return ret;
> +		goto err_assert_reset;
>   	}
>   
>   	return 0;

Hi,

another way to fix it and simplify the code at the same time would be to 
use devm_reset_control_get_exclusive_deasserted() and 
devm_clk_get_enabled().

just my 2c,

CJ
