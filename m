Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D131F9B4
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435684; cv=none; b=C2yyzNXuBM9Pl+wjI75TXkpmD9KGGk9EWlCG4g8+Q4zLE5b8dstUF403U3QR2CTEbpVpuUjQBsgCp9d+jhwTBaAfAAXnAab3k4YOcclWYd5vSkUtEX2UUlN4NwnkUSph+Gv9dm/E3HUJjD/vnBh6L9/EkNYv7m2tll+mg3Nvbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435684; c=relaxed/simple;
	bh=S+Yern/ohFP1Pftuewb5E8aWkrFDh5l+IZDpzLWeifU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffPBMGmDgH6h543l+C4ytbpoox9bLStbkW2yhbXDwVnM/C+O+ss5/QXAix5QeWV8xhklnEFjp+E4jqw2e+Ep0l1UXRRjsgfYTIBOg+HVCwuNu0amP9v9yaB4qB5wfyVfLlX9AITm7bUozz7DkzMAjfgpDQB2L0B34UxRU6f74gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsT4OA1c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bl4yvrjv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsT4OA1c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl4yvrjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783435682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7JqovvXzMlh5rauQf8957U0jSCHUoUql6bim5TQYvA0=;
	b=JsT4OA1c9QGSZCwg6jyEepLh7f2k6gp20qTNFWSLAZA6UZcVO9uv6Zr4jgXJg8G6CITuJU
	8WMZGjHwvQa3fKizhp+xVpriM+xdEJFxW4kv0VC/jW0CuxQsH3+3Ieyvq68jdoehbdOoeU
	DmlRCGaI4vQ3QqM+0s5Q9iUQ2zs/I5w=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-uGmxJu5SPsuKxNdR33LaOg-1; Tue, 07 Jul 2026 10:48:01 -0400
X-MC-Unique: uGmxJu5SPsuKxNdR33LaOg-1
X-Mimecast-MFC-AGG-ID: uGmxJu5SPsuKxNdR33LaOg_1783435680
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-44d2204d393so3603338fac.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783435680; x=1784040480; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7JqovvXzMlh5rauQf8957U0jSCHUoUql6bim5TQYvA0=;
        b=bl4yvrjv92eOgA7GRUTC13AoObBdIdGWII3agZYDaWAkG7RLbRpaDGYZ8TLwsnoI3T
         fM2XggnOGJstBW020P2U6qiOdHbZCiMUaSpSRsS9BzGAa40Pc/lmudNNC5Se95UnuiPi
         zxDeqo5Nv8a0CAGQVwUS+s8d93dlf2DuPH4TmS4SW/Vrlcu33Vs6NIsZRmCx/W9J2U5C
         LKGQdvvuNFyqeIakSW8cWUI4YLE6Wf1Rdukb9sXZvl4wl15EHmnb6D8jKe71pRRuQSbz
         EAkNuI9/rZgQsZTU0sAB8TfMuCvG4kyO/IToPq0++SKMLU2zJ0nSIMFFUQcNbg7ajCZf
         o6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435680; x=1784040480;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JqovvXzMlh5rauQf8957U0jSCHUoUql6bim5TQYvA0=;
        b=rd+Emc2z0GEVgkqIFUpOG0O8ow9Z6qyhNPetGENAKkKO0SR1r/Srs9IuiAXnFP4Dgu
         vGlV/RRwryaPqB4S6DxSUT3j+3bvHbLIwP1Op7rpb579xVvATD68ALEPHKFklr5Rxr0G
         RQpJxws4VxSymptByKZGMWnyU7FxbYpc6Np7HFWip7uFP9lTpQU2neVhq+qH7YLQgYc/
         ZAa1UUxlvqvcsLuOPNHTSMxmsW9nNiznMKD5fGj/g7dLI8YpMBPwWzAE7YQl15fNyXWl
         FlENtgOcR0PrlsGzWHMjt2k+dZUqwXSMKf6P91X9M3URN61bV9VXDm2XomORNnF3hlPa
         QjEw==
X-Forwarded-Encrypted: i=1; AFNElJ/pzslZh4zfu4bnOkYbCBTTx1uGAjDm9Xu87lWr+DTtJSNkuPhKSFCXf7FaUemdh9sWk51fjqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlZ9oQ/gs9ryeOgG3UE7jTLxUEzvw3wmuL4fG7kZ1ffFIWnMA
	z2MUSoApHr/JUpGlKcVJa1BDqSJNiz6LX38hmsxLsQ1SPR8n33sMtuLTHSEm94WcPU6Y/psGrOJ
	9n0fXQG64iIzqUIW5aaqjnwXIRUbqRPh3SEf6tL8yhRoPOL/Y6lRXqbNu3Q==
X-Gm-Gg: AfdE7cm0gQEGIrNiaQd9PBnq0XW24p5DrM2t4p31JMqOCPLCfgWeLJqllsD1UVGjOt5
	DQ3iIDvbT1ExuEqBh+6YEBO3Ml1O3iS/ib/b8m4wcfFr0uJZf2zsFHgqWcjPXuEzPicn0bOcdQQ
	t5SOykgR2ZgftKirE1YE4q0vU1BnJjYob5U9Cq9Byv84qo40bmawH76Zbw6ghIM6MIjtQvj8XnN
	DTNaxqQF4OTn+0DwJK9u6b/N2dD8nzlOlqyqpHgw7kdib2erT5njuyqOFl/ulG2m+/mtxa5PA1i
	j2TB77kZUN2cAI3eS4cr1HGYaqUbKhdUDc4O37spweSkBFQBb9t6FA4Qyz6EyAK9jgLXJyPk1Aw
	PTfecOqMu
X-Received: by 2002:a05:6820:1f02:b0:6a0:e1d4:7fdd with SMTP id 006d021491bc7-6a3553de9bfmr3896710eaf.23.1783435680180;
        Tue, 07 Jul 2026 07:48:00 -0700 (PDT)
X-Received: by 2002:a05:6820:1f02:b0:6a0:e1d4:7fdd with SMTP id 006d021491bc7-6a3553de9bfmr3896690eaf.23.1783435679782;
        Tue, 07 Jul 2026 07:47:59 -0700 (PDT)
Received: from redhat.com ([2600:382:850a:55b4:731e:b0d4:e0cc:410])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a3103e064esm10772021eaf.14.2026.07.07.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:47:59 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:47:56 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v2 4/6] clk: mediatek: mt8135: fix memory leak on module
 removal
Message-ID: <ak0RnIsPqT8fQ7c1@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-5-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074839.240676-5-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Tue, Jul 07, 2026 at 04:48:33PM +0900, Akari Tsuyukusa wrote:
> clk_mt8135_apmixed_probe() in clk-mt8135-apmixedsys.c does not call
> platform_set_drvdata(), but clk_mt8135_apmixed_remove() callback calls
> platform_get_drvdata().
> This results in platform_get_drvdata() returning NULL,
> which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
> This leaves clk_data unreleased, causing a memory leak.
> 
> Fix this by calling platform_set_drvdata() during probe.
> 
> Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

