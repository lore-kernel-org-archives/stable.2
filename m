Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD36846F
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969935; cv=none; b=q87wZsiO3eFiBClScEAtPCEc9CPRmRb87nUg9cSKAtW5smiFn8fV7iVcS6PTzD3438f9vhKQLJffnAJlvFmvhxieVVevjcQyw4LCCXnV3CaERUhsxeQ0xZ9Ja0G3NOZ2OOv8NnmZxeStDLXt4Yn0ckeHRvHRT8jXBhn68ph8nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969935; c=relaxed/simple;
	bh=60jcPl+SA8Hh4HcH5iRJ05LTiYYC20gbXJ8CpQgcRfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgZeTJgDykkVOT/AP9a6XeWmEYYbkADPC2YelWuJiTpVixfSvq03gwIMwBcrYYEuM2sTP9FqDtdRP1vA/2OE2GWYXSyROerfkoR4nfbLWMC7VRDX8hVEskmz3bkjZ9NyCO6w1nSrl9tOVdqAbXCwGVtMPgJg3KHVTn80VzCsy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2lx0E6O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2lx0E6O"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45fe59255beso1539035f8f.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781969932; x=1782574732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUUOD7b/36M9dKLQSDarVR6usfGuwps6cFnOeuCQHro=;
        b=q2lx0E6OyvUuGDQ4XETsxTbYaec3A9xPpXuPL6WmZxcNmsSJllmwQITH3a11WNMdi8
         uA+ue8AInnW12MkALZ9YVyOoJQou2qbbRTqmks4gmurejfpj4FepafC/k5cKRkjQ9HNi
         u5nnS5LURZ6AvdAx0XTSAODiCYvcFDaJFj6Bw200JzjQUcbKYMXaG2GRRvkYs7GabOQ3
         b5OgSfglrgnFIUEl9/UtZpMFoMFELAGTrn5VBB2O7hIWw93zKvY22sfKTiojETjoErvs
         pM+gK5TyGA5LqTpm2gexYolZCVx42tjE/Ph0UFGMwNSEolcRRNpZ6YkfAkVk8v/23+Qa
         wgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781969932; x=1782574732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jUUOD7b/36M9dKLQSDarVR6usfGuwps6cFnOeuCQHro=;
        b=K8aEhHLJkDWwVvZ2mIRaglQ45Gs5D78PGSsFaa4h/78YeSsxMG55uwuWrG2zO5ucLN
         j6a1kCfVdaSciTy/alKrZ7il/azpRSkpl2XvHGs1hpfI3l3aq8n/V2rr0sjBg375i8Ew
         qiHUvxFiQbPbRSM+1Bgi+2wDkDXCc1cMinstJBCTspRC51cyRc5EWpiykoe9vtzbGvYK
         An5cf2dijHA+iPUeClNKtBr88XZauiCyhzF9/k0QHgWC7swgPExUrhz+x1yBHNOE3t6W
         88v7B6/wlhxspsk6me1K9G/hGq9TbO7Rr0fA+04piNagLqjavMQKRO6sQxg9ZpNezBh1
         ypKg==
X-Gm-Message-State: AOJu0Yz7ibNWXQqlU2F96AD/WBciB+WZa+UYEbH54NWnRF9mf/b8kHkI
	xPUeTEADO3YPWyJ0tCwrRS1M6B8popznJUJA+w95c81zw1uVsSRyYKrB
X-Gm-Gg: AfdE7cl0SrrJG6TTqnKbp1R+Koa+V+HgHNO7+aYVB5iViIdDzGdZNKfXuTAxAUA9SHe
	qkgP8pDZPag/obT8l3i9CoJmxgBHrOuGVEANd2DVsByc5eFY9YyZ7pmCjPsBx7NsV5ItL2xKQvf
	a4KlYIKAZjVqBnL2SckErMjDWDNlYP5XG7j5gOrxLF/xIyEvqe0tXSRZfrkyAz+dHO55HGp8Eri
	K2/y8uFLN3d3ptSGeM3dk/qVqf6E3dtN7dYkeO5JHXW7GX+l1hBsxuVDP5PKG09XWDC6x9LgZBE
	S7ZZWKxmymDaerQfSmkVwiTAw/vuVC1kAGaUpGadmzUWTILh07BbiKwQJskaRrCCEjn+pojBlXX
	9qMHTWGOVwe4FUx16bgNVogiip9N3GtsUxhHpkxYDq+Syvpa9kPo+ZKnkIn0+7ypmenbTZRN4Id
	i9LSQvsYOZDcV7YXEbVcSruXqL0lp8dKbJD4HwTNXCde7DgUm9GbXbcGbce3U=
X-Received: by 2002:a5d:5e91:0:b0:460:138d:c9b0 with SMTP id ffacd0b85a97d-4656d831749mr9818457f8f.2.1781969932103;
        Sat, 20 Jun 2026 08:38:52 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c698dsm9753509f8f.16.2026.06.20.08.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:38:51 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5E54EBE2EE7; Sat, 20 Jun 2026 17:38:50 +0200 (CEST)
Date: Sat, 20 Jun 2026 17:38:50 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please backport d289d5307762 ("ip6_vti: set netns_immutable on
 the fallback device.") to 6.6.y and older
Message-ID: <aja0ClbV7ocAlQ2V@eldamar.lan>
References: <ajODI0ViiySkNjK5@eldamar.lan>
 <20260619.0001.reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619.0001.reply@kernel.org>

Hi,

On Sat, Jun 20, 2026 at 07:54:52AM -0400, Sasha Levin wrote:
> > Please backport d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.") to 6.6.y and older
> 
> Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

Thanks. Can you please queue up as well the one for 6.12.y?

https://lore.kernel.org/stable/ajJ6TSzxuWdfQkxf@eldamar.lan/

Regards,
Salvatore
