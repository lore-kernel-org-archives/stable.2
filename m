Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E793D4112
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367957; cv=none; b=LPvujt8DyS9tO4uv/88XcST6LXY6Alcy0Pp+VR7mf9WMlWzLHoL5bSwNNVBku1gcSSj0iDf4cLXD+XjeVrYFpxoahh6PXYUfoh1e9rFT4i8nhevbgfTz94G4a/XU+wd2KPOrWnxQ32fkVCSTv2s7At6vBdhhU1yuWviMamYEvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367957; c=relaxed/simple;
	bh=9HWeIwTTx2EQ/+4qhn4IVPVNueno6718Zzeh+X7aaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+ClqBOU8XJIiH8E8F06itQ3YgTTufjQ5uznTPevXv/4Em53maAbBMqKXtrWcO7Z8nApN8c5sXEchsVnQfg4JNsTOLWSJsyvJFt6Y/VMBgHUS1VLj52BWqMO+2qhRM/oYwoB1QbxZGR2eAEgfvbBUzfp/j4UXxLYynW4t2s4sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4hFfb6X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ludN8PLQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4hFfb6X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ludN8PLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783367954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miOaW9hoFfDuFPnXiu262F/4yDf/EKYiy2TifipKj0Q=;
	b=O4hFfb6XYW7+q2mw4nalPOPkj2/yaUX6hujnrfv3E3ZEqE8oTIYOZ/ECQyXbrqm3K4CRd1
	Jui2Rs8l1Cf9f6lOWG39kirZGTSFD+pip5ANLH+IkQlIwRNCftgrQxUEU0bOJyqQjRkAdW
	bobbJMDPjOidYI6wJcBFbY22sXdtHCU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-TiCTDXN6MeukXLmCiyzGaA-1; Mon, 06 Jul 2026 15:59:10 -0400
X-MC-Unique: TiCTDXN6MeukXLmCiyzGaA-1
X-Mimecast-MFC-AGG-ID: TiCTDXN6MeukXLmCiyzGaA_1783367950
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ef8249f871so40210566d6.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783367950; x=1783972750; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miOaW9hoFfDuFPnXiu262F/4yDf/EKYiy2TifipKj0Q=;
        b=ludN8PLQ+BJ6uHL1m9W8Wj//DhmjPDjwZiuzo999ZByjOZ/LSePw0lw0OPl48BUIZh
         hdgHQfkDv/WjHikD4HNd9PPLeKQX0PFf93p/JJ6Fw2CbxLghMndUoAyD1NGrn3aXOB8a
         nYpFsIgERFEIknVEpU2iX3VmmzEQxEoF6RFmmodUSRODN2ZJ8+5UCgZPziF+PtqQ6srd
         tKN+N7Mh09R0upoDxl27tLUGR4ELEkgs2ykLSQFX1NkNW/ABuv5W8Fne/Cr7cpcBJMcQ
         nhHbseDPiG3QGHIrvq0VW7jNs7vA3J8dLQx9aQ4qnbd4knvlgWzBSIKjUtLrVBwbtY7x
         GEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367950; x=1783972750;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miOaW9hoFfDuFPnXiu262F/4yDf/EKYiy2TifipKj0Q=;
        b=MAO1jqimT3FbQkmpEb4OwhmytND5uYZkBBySPiuac2JnFfe7cKesXwd76HUQ4Nhot4
         3beNhE1mLYy9V6Y3GnuaVd9TB8hRXcvelgruZK9Xu3/d4puxTRcNWzbrk3t9qGppSMyl
         PSm0QOlb7yn0pJk2a6hNjQx8IKkmcH6UJxVXUaEhNFmT+CLqou1Pf8bf8z+aTE2lJ1wR
         TnxFxqau+AdWzPpUl68JBXlXD98goyGVRCLp6E/KNtIwBbWIiX2W4eZ3kHJSHwxTXK6h
         3UByybVCZu8ejx1Ms7a1Rmxds8KcroO/3al9HOxMr0FLi7L+K1MUe6bsCIfR76gmv0Yh
         +EBg==
X-Forwarded-Encrypted: i=1; AHgh+RqmyYn8KaX/tIePdGcdXKLipWTplhQ5jjYqUL3iUaz5tvXWwMNjIcFkX8jP4OMKB9OK/k4X77w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcPLbbMUjHrlkGQLQnqVOtwZBLZSFUdlVSbv79uwBjmrvWQWo
	ykWEKp4yFjE4At08q6oPz9H/zUux7RwPvPcceVB+cS7oFBcweeq+xQxA6B5sHkW3cpaHfOMu4zO
	pZoM9MaNNVlKDULMPtg5guV6m3dgp59Pj4Lm0Id0moF8zolzh9nsXzQsmTzuVtbEP0Q==
X-Gm-Gg: AfdE7cnxDq6jpJyf3Sb50vzVQyFsPGKGlsbDQM4Nyn7YQMY4kHjSG5W5IrAOZGXRPzt
	mQo7a94OmQgVSLsCf42NRj1u4aoacavwHSDmmpUVV9Z4Tqg5MnRhgVwkCzWXrL+cvXq9rtqPUiQ
	oG4DDTwatAIiOG59j9jy6zZiENDpbXKiaw7dEgfcEaqYHFGeoVgacX3DzJBFCgiror9saxnFmgE
	qKbXqoKaRqqGpPaAJwWg8ywooN5OinYzklkX7RPR8PKugQ+6EUef7QDxajTzVnadaGY/F6A1RY8
	7ze3LZuGkU/9sb/kAK6xajf8tsbw5iMj1UMHbUa+An3HzvZLHo7xxJo77CQgLZTa3GlUiENFU2f
	fM+w3lvik5s1jGrrSJpOBTx0tnCLimiD1IigxL4+qWhPQYA==
X-Received: by 2002:a05:6214:2605:b0:8eb:70e0:47d0 with SMTP id 6a1803df08f44-8fcb4c006ddmr26668696d6.37.1783367950097;
        Mon, 06 Jul 2026 12:59:10 -0700 (PDT)
X-Received: by 2002:a05:6214:2605:b0:8eb:70e0:47d0 with SMTP id 6a1803df08f44-8fcb4c006ddmr26668246d6.37.1783367949576;
        Mon, 06 Jul 2026 12:59:09 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f013f05sm143092136d6.16.2026.07.06.12.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:59:08 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:59:06 -0400
From: Brian Masney <bmasney@redhat.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] clk/ingenic: fix clock leak on clk_register_clkdev
 failure
Message-ID: <akwJCq9uUY3rzFxe@redhat.com>
References: <20260628122811.44799-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628122811.44799-1-vulab@iscas.ac.cn>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Sun, Jun 28, 2026 at 08:28:11PM +0800, WenTao Liang wrote:
> clk_register() succeeds but clk_register_clkdev() fails, and the error
> path jumps to out without calling clk_unregister or clk_put to release
> the registered clock. This leaks the clock object within the common clock
> framework


> , contrasting with the CGU_CLK_EXT type path which correctly
> calls clk_put on error.

I would drop this part. Just focus on what you are fixing.

> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

I don't see where on the v1 Greg suggested this, unless I am missing
something?

> Fixes: b066303fb3e7 ("clk: ingenic: add driver for Ingenic SoC CGU clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback

Link to v1: https://lore.kernel.org/linux-clk/20260626115644.33779-1-vulab@iscas.ac.cn/

With those fixes:

Reviewed-by: Brian Masney <bmasney@redhat.com>


> ---
>  drivers/clk/ingenic/cgu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 41e4c69131bd..b59b24d0e3cf 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -774,8 +774,10 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
>  	}
>  
>  	err = clk_register_clkdev(clk, clk_info->name, NULL);
> -	if (err)
> +	if (err) {
> +		clk_unregister(clk);
>  		goto out;
> +	}
>  
>  	cgu->clocks.clks[idx] = clk;
>  out:
> -- 
> 2.39.5 (Apple Git-154)
> 

