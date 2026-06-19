Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1990263F5E
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781843021; cv=none; b=dz+ylHUXhXlOmKlLe3iF9hGZif+i3RjbVkj0xIxIdEUGrNKBmNn3ySParo0RCRDHTuXaV7dX/e21S00xo0aqMXBne50aJ3vQ5lfGlSDA9ys+7LH5dtTQ6QveLasWksEz5Rs1sbyPCvWDWHyh25WijGCLpLIpsRgXBeNnIJcLuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781843021; c=relaxed/simple;
	bh=/e265C6i/biTzzYyRJtb7JuyV49cEBHj3hfmUf6eN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAfThfj+IYRH/38T1W3sJj4Ob46oFUT68tAvPWlalhVUpfR/aDWv03vQaA/aoA3lw1aXCP/l5vhu6+0SMkrubiuR2PQ8fMVnsDIRuhGEBZLuqa3JSr1GUpLaZUhtmWlwPpsxGznkVOW8caHeDTl6KRJRCxlYYL6a3l2sIoxEHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VX0uJ8OJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VX0uJ8OJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c07ea058c1aso216041566b.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781843018; x=1782447818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0soBiUkGzsvWXSaTMVs0Nu0PkgoN9UKZzGfSOEdsY8=;
        b=VX0uJ8OJBYuASLe1tCPTZxhGkfX3MOWb7zuhi/HSbyW3BFyanS0BX3FT+m6omLSGRt
         r9pWlKYmpKn9P9x+QqFK12+H+wpzaRMCM9n0lYcCGynXA+zY+PViiLzT/x3pXt+TeeJx
         UAxvEDl1o77Z+N/Wtz6kiQOJHOssPCUlYV6R6MlPdAN38vdeluo3DgH52wOKT4LDSq2a
         NJ7OSO2FL3jckDeCffRKzcHUZbBnjMoEP1bvQ9IWZY3QAnfngcEVJ+oM2PkyguMy7mnZ
         PgKB1l3PNzL1hhsJzlh0/pOmUtasxboWKFpBEZid57dpNzPcVCmZ5PD0vXZgVLIJ+CjZ
         EQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781843018; x=1782447818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0soBiUkGzsvWXSaTMVs0Nu0PkgoN9UKZzGfSOEdsY8=;
        b=Pi9sPFBIgr1sLgcHrBHomex1OUfxCU89P8I6eGsY+yewlBHYxXWS5hWS7OzEZNatjI
         B3MTA8iLal/kyzLwwIRFced4qWuzv5XSrmuNlEsV2CEoMr6kZl+34ZYzDdQRil1Li3Wz
         DaBy2cfOeTpIiN1OfEE6QqZw2rD9V0fjfAODy/qZv6q0lML0Gb2NwD8jeh091GG7JEf4
         QrUpm9xew6IVZxd4WqSB3oivc7m1ZR2mcj7bqFuFJZLTF1cvGnqYdQoqa6dbib8rJ2fJ
         0lAaXA4noRG6GlBOsiLUO1MH7fuM3PQUV+iEOTmjmv74pC3fMrnAyra10p1/Hfsc8glv
         p9Ng==
X-Gm-Message-State: AOJu0Yz4fbhO2GQQeCgll2WsIQCj5/TsHqDQNCPmB8++BmE/lvfKsmrZ
	N2vJ6UjGLnwvAmjMUPIFUS+b1LegWlZldcFBpl/2TMWWxetCiKfXiZ+ZsBbBbgQ6k8TY+BgRmKU
	h+j92yC5iHQ==
X-Gm-Gg: AfdE7cm2Nc4Gvt87ObpkAyWFkN6mlee+oWlXMsXNEJfDzWh0DekmEPl8J1gvdDXl8Ys
	7PMYRfwGCq7Fe/DNpNqlmoHsecO6YDxg9Aast9Sax3D64Z1lOhzBmsHotGJDqb6oV0KSBxGT0ZJ
	BuEPcF0/0tQ9NetQYWIGZJiZ/ibe94znBz+2fCCkQ7KM1M+Y7gV7QJeK58MaScVOB22Ad9NJOvD
	R06+vW2qBnnunIIYmRekw7MxawVyONWEUH2FcIRnqs3VMefp4Nrcrpykzb2dcCYZdzjqBvy2wvf
	iQgntFRwEqwHvUlj275h/WU0rMIdvV+GyJhyMuLRe4Gk0wVpcdPAfIpxadofE3clVjm+Nk3/CWb
	OKFoY9RCaWInMc+H2xefSaRRYBj3Ar4TZ8Bfcx/KCt/Czf/bhoKygN5kC/qQ6ozL+49Y5qqRMSp
	gdFWkRSG8Q4LtE2vQtq8ug56mc2K+m+YQhEJmeNgKI
X-Received: by 2002:a17:907:7b99:b0:bed:eb8b:d404 with SMTP id a640c23a62f3a-c097ae2db44mr85153266b.16.1781843018007;
        Thu, 18 Jun 2026 21:23:38 -0700 (PDT)
Received: from u94a (27-53-24-58.adsl.fetnet.net. [27.53.24.58])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0d8d471b5sm1081709eaf.8.2026.06.18.21.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:23:36 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:23:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Ihor Solodrai <ihor.solodrai@pm.me>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in
 perf_link test
Message-ID: <ajTEGXglAOmVhlir@u94a>
References: <20260618074114.16091-1-shung-hsi.yu@suse.com>
 <20260618-reply-item039-perflink-61@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-reply-item039-perflink-61@kernel.org>

On Fri, Jun 19, 2026 at 12:07:08AM -0400, Sasha Levin wrote:
> > [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link
> > test
> 
> Thanks, but will this even build on 6.1? it depends on the get_time_ns()...

Oops, yes it is indeed failing. Will send v2. Sorry about this.
