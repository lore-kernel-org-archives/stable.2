Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CB495AF5;
	Thu, 17 Sep 2026 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679030; cv=none; b=RuxV8nIMxVIbyArmGQf40CIynVuLRsGjHKogorOU55m/s63UfyhqV1mvSB9L/QyTEyt2sEeWNmiLGyPfD7THKzTW9EmFBfOsyuzUVTnzs6fSDWLhN0c7giOlJa8nYDbRmBCQrFzxGZR2hJOYc1urtmcshMAjHvoD6OkXTROU3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679030; c=relaxed/simple;
	bh=Ru2PT7ya3nmd82WlgT1N/Dq4zTwS1PQn2JkRk3sId60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPxOoIOw6C01A+4I4cb3WAVWF/wYbXfxZXr5VskrqqpUUI8Cvz1J2+wWHkMnwxqHrCgpx+GDhxx2XXMGZ3qrkfAwMhhh3mttjyuSasAbK9AZVI8oS3dAbWRWHEtCiEAFx++yaFbYAiIOdSprN865G6c3nJ7jyyn54Yta2zZeC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ms5tB0nJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ms5tB0nJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=WPT3loKEvy34Kug8Bmer100Ee2Gt1ulHDe7e2kGuSXg=; b=Ms5tB0nJi0A24/8w46w76OyMRe
	NdlPcjXq4ThABtjg7m1CKKnR54RL+p4EJKb59z0XVNwwwpPEvKg/iWc8CNkYY1jpZMXHm8zCbmR7f
	Vwzz6JakArbAZrj+cju0QzX/M2fVWwpZFG15sZ88ariMlEXZTKFwuuadvE7Z91XmKu3iOjkEEvg0a
	hBXqJCcwkUkDJLrEe9SCXdKM8UPdFqY+9uvFmlPDr1xWmnXycYNmdKXBXi3upFiQ6f10wPf5hwHI4
	zYtherua1A9NulCus1z0Iy+HT/LwQxDYiHiCj7NmgyAAf+vRp6lqVftB7ApSDw614n1Z68zYiE7Tl
	eGgNny5g==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7JGb-003eRT-51; Thu, 17 Sep 2026 23:03:37 +0200
Message-ID: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
Date: Thu, 17 Sep 2026 18:03:30 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, stable@vger.kernel.org
References: <20260916154137.2058618-1-vulab@iscas.ac.cn>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260916154137.2058618-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wentao,

On 16/09/26 12:41, Wentao Liang wrote:
> The firmware reference taken via rpi_firmware_get() is leaked when
> either of the devm_clk_get() calls for the core or display clocks
> fails, as both error paths return without releasing it.
> 
> Put the firmware reference before returning from both clock lookup
> error paths.
> 
> Fixes: 2a001ca00ad5 ("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/vc4/vc4_hvs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index ee8d0738501b..20dde4150068 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -1680,6 +1680,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>   					     (vc4->gen >= VC4_GEN_6_C) ? "core" : NULL);
>   		if (IS_ERR(hvs->core_clk)) {
>   			dev_err(&pdev->dev, "Couldn't get core clock\n");
> +			rpi_firmware_put(firmware);

Instead of adding this line twice, move the line `firmware =
rpi_firmware_get(node)` closer to its actual use. Then, you don't need
to add these `rpi_firmware_put()` calls.

The same comment applies to your other PATCH: `[PATCH] drm/vc4: Fix
firmware reference leak in vc4_drm_bind()`.

Best regards,
- Maíra

>   			return PTR_ERR(hvs->core_clk);
>   		}
>   
> @@ -1687,6 +1688,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>   					     (vc4->gen >= VC4_GEN_6_C) ? "disp" : NULL);
>   		if (IS_ERR(hvs->disp_clk)) {
>   			dev_err(&pdev->dev, "Couldn't get disp clock\n");
> +			rpi_firmware_put(firmware);
>   			return PTR_ERR(hvs->disp_clk);
>   		}
>   

