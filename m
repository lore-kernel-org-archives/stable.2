Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83323161A3
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435724; cv=none; b=hm+wCz81oikmexES+LPj57Hd/tiBqRsomMhbjvouMa/fDn3ctBGQvtfFTwFBtxbNNwQD7H7HOz6gTh4an97+/OYYjy/H663gvrRm2V5HWOf50DCkAoCV1N+eZd0sbgZZOndu9g27EGvWQ0BPS6HvlUG/1mReOLKVi9bGOsO3gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435724; c=relaxed/simple;
	bh=3pmfXR4Jnv2/fQCMmyH1XbyAye1yx5cOX75L1MFZJgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK2igh9D2Njz7U/8o0Cp3oN1hJJC5GP7QcmkaRyb4499FaVEMWY/X18ydfOah+TvG7OGhflOko73NIeyenkQXGfZlJiDO6M0CtVaInyMzEbghStYckPivqMnrKv5PQRXhAFe3KdO/hjEoOrhK4+z5aeyM6qVpXt8+wEDU1yZGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ay/6FBon; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqMorVR6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay/6FBon";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqMorVR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783435722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h1r3uOYYLfyHkYl7JQXo9+dI1iFhQk/Yi77FdFZjY7s=;
	b=Ay/6FBonifhOZVCrnhuIm13bEyWzTvphdEtGscors/x5YdbPEwJTc+5Syo35zwd4vpyQAO
	1lPcyqGfDGZ/gJBj7ItOgbKwx0oUq76Nx4OZaZmCaNq+de87jCsFwq4e+nOcns8rFv4vJL
	Asd+cl2y859d/h8+M+Wb84KSdkjUDQE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-gB9U-_vSM9Oc12kyBQt-Kg-1; Tue, 07 Jul 2026 10:48:40 -0400
X-MC-Unique: gB9U-_vSM9Oc12kyBQt-Kg-1
X-Mimecast-MFC-AGG-ID: gB9U-_vSM9Oc12kyBQt-Kg_1783435720
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9f1ee3ce4so1041302a34.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783435720; x=1784040520; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1r3uOYYLfyHkYl7JQXo9+dI1iFhQk/Yi77FdFZjY7s=;
        b=TqMorVR6/F1CnXkbJSyDnj2tqvxHIhD6a/zEqIAFiBFBiP55xVrFPHoftng7y1MM1a
         ZFkZgIyipwl9nvdREDO8nA7W4TPf80B6voOwEZpIFKWNfM0/M3npB7+1/wxgSStdPU40
         BvFuwOHEni6HiWCE7mFNs5w5uyUPdx16A3T+WzV7CJccZgUNDlwrOAoC24EJKiAKrlzf
         RdK1OlIQyyzB+8O8vOqWKi6rPT635PDlD4Y2N5KimRAG44U3zA8KpSiUwAw2spr07+nB
         foNM0EHAtfg+NoT9HCZKZmeDqEsik0fpH2AsY4sCSWvQY4t3gCLtrlV4ePjU180cMtNQ
         boRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435720; x=1784040520;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1r3uOYYLfyHkYl7JQXo9+dI1iFhQk/Yi77FdFZjY7s=;
        b=kEHXphffMUHZdDsMV9SIJeDSh86lHrStNe4uk6BMURjwmBgw7hgaxrYX68bPubrfFC
         NB6dSNJbl3H4N+ERpl+iyc00t9/PrzhQmoYxrUL/gipCYXzJDn74mavDy2MEGHSFlyv1
         cS32PIJXhnEBC/TvV3c1BboVrDN47l4R/y+eHX/9I3UOzlgxyy77vRefnpBdNY6tc40Z
         u9+hUysK0pll7+usgwo1L4CJcMSC1BanFmk2Q/B6Y9WVB7enJLLP6zB3SPF2WjUJ1JS4
         C3ixPwBFNuJa0etEHYe7nMgzEUvx8wq2f6feV2+jTe+3OV3xLI6QcksTm96s0/UE/KQm
         ELrA==
X-Forwarded-Encrypted: i=1; AFNElJ80penQWmaT9te6F6xGMMsjUiRVIG0ABv+qNu6YkXLZLPrsIR5BZfsCwQw0GN6brN8QWTBb80I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9AIOAhj80Zf2+lvLNobjWlhwJBtMDEF2G4Rxh1373cvDkpc4
	7x6+z0WWX5+/wVq4i0AvEo0BK3dCftXD6Vezzrj20UhYHdAVQ8+qeKq05iD6XzQ7BE6E0rl4PH3
	QoQGJV0TZBLF8/UAXVnT5IkpAI0letEhHY69jXWBcdk4fs6j8rDNTDKBtYA==
X-Gm-Gg: AfdE7cn6PAm3JvmWk6zx7jqPTAlbtDY+P2hiINEG8h8Otclkiaot/24OWrWLYrH8wwj
	giz3H+GZ7MrW/SR7Is1aTIBOlkmnHFaNZ09jpi5kjY4/CRvyYWEqSFoUJlBDk38NFFxjavnhPN7
	U2OWIQJSYGuFyQVxjT3xOSsju+o4E459HDDmqa2kwAq49fPHjTkHgnUb7QhxlCeBYQOFdPSzL6+
	gZt3ZuMiHNjI/GL6ph7ZG/7TqqDpvIcofGdxwxym/0WbeZkdxNOyFj7fqV2SkiOFD4QC9NJGXRM
	LFOU5MAWX4VbeU7WkKWk7qw/eeJsYmWAow3EUoW7f5BliiE58NtNA6WcwQHnBFoOIufZXK+UhZb
	e1IBMDOsf
X-Received: by 2002:a05:6830:828e:b0:7d7:fd71:f2d4 with SMTP id 46e09a7af769-7ebba10d518mr1910792a34.3.1783435719961;
        Tue, 07 Jul 2026 07:48:39 -0700 (PDT)
X-Received: by 2002:a05:6830:828e:b0:7d7:fd71:f2d4 with SMTP id 46e09a7af769-7ebba10d518mr1910777a34.3.1783435719482;
        Tue, 07 Jul 2026 07:48:39 -0700 (PDT)
Received: from redhat.com ([2600:382:850a:55b4:731e:b0d4:e0cc:410])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544fcb06sm14123177a34.22.2026.07.07.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:48:38 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:48:35 -0400
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
Subject: Re: [PATCH v2 6/6] clk: mediatek: mt8192: fix memory leak on module
 removal
Message-ID: <ak0Rw5krDlc_ZXQn@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-7-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074839.240676-7-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Tue, Jul 07, 2026 at 04:48:35PM +0900, Akari Tsuyukusa wrote:
> clk_mt8192_apmixed_probe() in clk-mt8192-apmixedsys.c does not call
> platform_set_drvdata(), but clk_mt8192_apmixed_remove() callback calls
> platform_get_drvdata().
> This results in platform_get_drvdata() returning NULL,
> which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
> This leaves clk_data unreleased, causing a memory leak.
> 
> Fix this by calling platform_set_drvdata() during probe.
> 
> Fixes: 124294ff468f ("clk: mediatek: mt8192: Move apmixedsys clock driver to its own file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

