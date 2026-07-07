Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9223315D40
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435657; cv=none; b=ZE5/ueWtATRDiCCMMSpq8jDjECAaWmoh8jLX99zs7gnhUeIHz4+2gIoFxfowSCKtKjtI7ZSkb0JCQpccmGydEvfUA6BYprm973ctzy25Pn+eetwqo4PSHrNxBOoyGkqc/wdr+qIyI5PhJoIenxoLwf1YxK8v1gsRpx+ySbMC9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435657; c=relaxed/simple;
	bh=XJf7mRPvEPWUYW+MYI8B+jzBAKagZwBRyuHNwT7cJvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWdlYr59oLCu0dzb/Xd3vpiwRZAhOM4dwGcQgnUFecnNcDPSQU5tlA6P/VVYnwcYCw0tDs6sADOfAflz83xJYxSrIDeLz7PZJOmGKuEsEU/iHPtMFS+g9xgx+uAIhLyKmyvLOf2GidFIz0QFDJ2+w+F0ewQ2S0Bj/v3ECzHT8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUca1w5x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLtz8IkR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUca1w5x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLtz8IkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783435654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ph7EonUkISD+ckd5Ulg8eFLpvpFj+V9UnIoIMQ3RmAQ=;
	b=UUca1w5xU/s6fBTBok09ONrpCNws7irYVfMqc9XJO8Zam3W7JJ+JBC5M+HzyeFXxt2E+vg
	uv4BPiezZ0xkliSIfdUHfC3ytGjUXKykZwC29j00Gx44s47yvo4E1haBw2TE265nuRZ2CV
	n8d3yHukaIUqG+rkSH2yeUKm8MQKa+M=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Ish4G2bWNY-GH9cnIw3wDg-1; Tue, 07 Jul 2026 10:47:32 -0400
X-MC-Unique: Ish4G2bWNY-GH9cnIw3wDg-1
X-Mimecast-MFC-AGG-ID: Ish4G2bWNY-GH9cnIw3wDg_1783435652
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a0e3320c53so5025339eaf.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783435652; x=1784040452; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph7EonUkISD+ckd5Ulg8eFLpvpFj+V9UnIoIMQ3RmAQ=;
        b=WLtz8IkR+AT2FuSqB62AhChVIqNONC91ZW+58KB5fYLzIYbCsvYv0dSRvIpsPiI2qZ
         Wi1AffkY4xiAdQeycG2GObf+0Dq3iWFpZgwf5G/zsfESbwaZe9FzmniqwGj3ZEBj8gbZ
         xcHLeG80y4MKi95N9DXixLCjfTjH+17oH8azWRAqpcW1iRXf+64bMhhvLXvEiJoSSJC/
         3HsqvUXT35g6oP0cObnlpnMMfI2hfVlzKbHlUOWhlzMOavcx5zo0WURs9NVgqIkMUznl
         cbrzrF6KqlmPa3vo0OkXN+BoDUO8fltAsjV3G7cwuRsum9Mm3hr1Q/hIAH2mVWIq9yXj
         Vhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435652; x=1784040452;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ph7EonUkISD+ckd5Ulg8eFLpvpFj+V9UnIoIMQ3RmAQ=;
        b=Bwyqp+nnhXfAvXHd8WihPjTD6VCG3OO49V1cSn1JAJXqtOIa5FMTMrJwe0fEaeHvB0
         PQOlap/FNnWBaq9afPnYgUw+uu9u3oCSDgsZc49uR/2AIq1y04Zwu/0FznIGz7gtVwfy
         eyryq1rJouu9SUPWRmJoGk/YZIEmUstjVuSOHfNth7xJB5JgH7x18Rv422NI4id/RvIo
         WwUZasww/xpEM7UzSlz3gIYt6cWF28fpQf6MRJ41oy3Xo0lWEeWICIUOpN+yIyXsPGFT
         bShvyZQv39miC8kGvmLM7Ih3NW5fiZPNKwYZ7OkCCxXii1X+a7hkcgRJLgwTPZvq7Ohg
         G8Og==
X-Forwarded-Encrypted: i=1; AFNElJ/6rUawL+FDQEthM97c/sgDddVd17fsH3Tmavp82esvuJ/kxBKH5K9zhSCM2PIzFIIpU2y8rNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+pIojfhjGzBTummLQVHjLBPjpNP8DJMGgOUHLRI17dv2g4V0
	gpjKlRU0l7sZ8QZk0jYAnEftGwc6+lwz9z0khK4zi6BEpgX0c/tBiMUOPdpZUrJLBJOqaGYoz6T
	v0tm50DHgHJ6zALOmcYpNyfhSNIRgI+CfhaB14VorueX62zYGAcgzjahYvw==
X-Gm-Gg: AfdE7cn9st9/3utMUoxFLxSt5cZvkUdoR+C0HMYUURZ3wYkffPlNZK1/lveJMLQw9wU
	prnPfR+sNjBzlgAUhZLxCy/IZcegB+b1KO0sGT+vVdaAr8/y1jzSwO066L4uQXknnDreuegcfQc
	j7n9Ho8c53UKJHUKf3zPLE5GUW8wnqVsputR3f59aJBGMa3WWk+f5CFvxDIzL2bndq6iK1uku7f
	RcjRv3KumEtS6Ep0WTrVJMcfIVpQlIy4Csf/1i3j9Y8rURk2CYjrdFVHCbEZAFWaSmj5f7xRkyT
	4TZHH61o5bgsMxRnVjbEnJ/Aa4jaWpqyP95ueRZ4CMNAFzTb603tiHEMS/E0aX4TD2QUP9J4Tw0
	Yr6PhT9Vm
X-Received: by 2002:a05:6820:a09:b0:6a3:2b61:4cc7 with SMTP id 006d021491bc7-6a355597cdbmr3682029eaf.72.1783435652001;
        Tue, 07 Jul 2026 07:47:32 -0700 (PDT)
X-Received: by 2002:a05:6820:a09:b0:6a3:2b61:4cc7 with SMTP id 006d021491bc7-6a355597cdbmr3682007eaf.72.1783435651367;
        Tue, 07 Jul 2026 07:47:31 -0700 (PDT)
Received: from redhat.com ([2600:382:850a:55b4:731e:b0d4:e0cc:410])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb54f775sm13945468fac.10.2026.07.07.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:47:29 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:47:26 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] clk: mediatek: mt6795: fix memory leak on module
 removal
Message-ID: <ak0RfpOX-KTT5IZt@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-3-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074839.240676-3-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Tue, Jul 07, 2026 at 04:48:31PM +0900, Akari Tsuyukusa wrote:
> clk-mt6795-apmixedsys.c, clk-mt6795-infracfg.c and clk-mt6795-pericfg.c
> do not call platform_set_drvdata() during their driver probe callback,
> but their remove callback calls platform_get_drvdata().
> This results in platform_get_drvdata() returning NULL, which leads to
> calling kfree(NULL) in mtk_free_clk_data(NULL).
> This leaves clk_data unreleased, causing a memory leak.
> 
> Fix this by calling platform_set_drvdata() during probe.
> 
> Fixes: 0d363282bb0c ("clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

