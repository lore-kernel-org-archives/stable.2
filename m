Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185874;
	b=KVeNjx6Hlc0OPNoJSx5vHY3QZUVsf8VFmx4zAeiZWDPE4V1i56HnBiEKbNXGpaf/IwPD
	 G6mXVb7aF0dYiuAt1NzPvYIISZ/aQcP78wEQi1lRfMWDAnYL/hnwl/IaxYchcbzV18e/W
	 NEwJ/vpgImKSjQ0NYPgpAj7tyd6m+SAyBOFVKUJQfIF5xN3RZSJTPMJ+cggNcANuxhtN6
	 51gtoFlddyMZtQSkWWWeJhJVKTr+2k/hsEOR6HMi9vdrXAg45IuL/3DpL5TUj/mu3/GCo
	 gFJ0nUaSJg6Fsr/6D8tSfck5ez4188Cnqu3s2kIfYQHGlyCrqa39Ghn6nxjtCljnQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m38xEXFjByfiKAzO4g/0gPgc29AKU9uTE7VRz7Geb/Q=;
	b=Nm+BKRiCjrbjzmMMz4memgWPNB41ZUoopG5yuS5pFZgSf7eU6pQON4/t4PTUx7h3vFu0
	 zGDstEzsaj/MoiGgkdqGV+vb3B4UyMn7RrpkWXXkav37RUZQLHyrQ3XbLif6zuYCnaudK
	 3NCe9W7HibBHrJy9qyrGDL6qjMGtFRTU6A35f5CE8PR1MSzlHV5IIPbKGSu2T8sp95Oqi
	 xBzVo0mRMJUCRBZrvKv/dXqIIRt2P0UyreE8gZ0iHoygJKK7MeVES5ammCecdrgXluCgJ
	 IdREkEij1nag7NyjKJ4NYDWt960KfjZ75kRCaCVGReMMiGsjsH8ClOhPJwOj5hSKMHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RL/dp9Ey";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6B606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D6B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RL/dp9Ey
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-498f5fa5103so585836f8f.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185873; x=1795790673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m38xEXFjByfiKAzO4g/0gPgc29AKU9uTE7VRz7Geb/Q=;
        b=RL/dp9Ey9w11tTYSnWl/GfKTENXwG/NTsBETPFGblppDQ2px8PAe3X56P7oZweN1XC
         eo3I9BiL4fhxrOaVziS0QzQSh0P/l2gU1XFFG1aLIUf2bz2nH7bAugEIZKk21G3NvoDU
         ioMlLkbTNSL18YKm1GT4KKHYu20peTtSGG4aB5hXPk8gAq+HvxdRlOdnFhqOf/SYwEHi
         QNt/cJKkXEyF/b37VPqpy+p0E6Wd/Orz1e7xxlsGjP7qigYzw6gPtpAdtnuGIALnuEA7
         drhGHInsVCSxt1rp8XNZYbADgUQj9FKfgBs3DTtVZe9DHkr5ry1Az5JtH+OuDFj65/SO
         in4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185873; x=1795790673;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m38xEXFjByfiKAzO4g/0gPgc29AKU9uTE7VRz7Geb/Q=;
        b=Se1cvikmc0FVJSq7nl40U/11c2vwr661fAWDbL6aHQueJZvEDhlPjwGEoMMxOhAeei
         ZFyocO6c2Snr+4MGkjjgUG3hRuBKIQUzyx6EYK/Sj2rHjtDISakhvRm6iYiRzdpK7yie
         yV2cnKzaEJzjD+7ChVwOIuSDZLbxGvwSzwv0dFHLeXGFar4lC2H7ko98CHGFQb3H5usV
         ydOe1nz9rKRguGEIDeyfrpR4e+E20u0I542r2qgagY3JMPNEZeoGJY2ZtbHd3hDTEAnu
         fGnlNhqURQsA+7ris5Dt7BGcQypsVkxBT9pBAvX8JajE1P15M71Qr2sgN+gOUIccjqxz
         +yIQ==
X-Forwarded-Encrypted: i=1; AL+hErFVnUIKdHKS9CbD+Gyfypd2jasL8dpQu+BXYs4v1Up/RmccLkEVwCaOAwy0g8EVXIhUvcX0uzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LWWSIVMLfPsDrGTzc8/o35R4+OOzXK0Hets9DCDhtDW30fmNN
	yTwr0b6Ne9TjX0Las+1S7ooAvvGQzBi3g5/qWajFT8in5P/MW1DWldIQ
X-Gm-Gg: AZFdTZfDjOqOJt3dCHF8PYUtQK0DIVhxz2E66/jYVpVBcRLG6sV7lC+SoTnaA//pp4z
	X0hC55PD3BUl8irJr7vZjbt0t5Lv3anuczeNWTEQ7+/mxV+O/YViC4CS3b7Hq+1wdbGJBHBdhfn
	JrZiKlqVW2MfGTnqCE2QJovPpLfzCfQLm/m+xF8DVkIu/gAFobFUIlg7clV2eQK9tR7zdcK/Ydw
	rYZn48nQ9zNStP5xihIapGJfYXv0lCPcFWxdp904uOGSucwJzJELOXIO1/bDtoI03PeOIgctdYm
	vImlH+P8+FGXeWjBgCdspdnTC+NwlxgEvuwZ9N/dAe5FT6AL1JWNmtR6NoeZwwcqsfWQdaf0eOG
	eLZql74eqn/MXmbIPRZVqyHnwb5fj0k9kumgThmYV4Z2Ckc3m+Fgiew1C2ZG/yiV/DZVVLSpbB5
	NZinazXkMLh11XASMOXyQKo7RtVk1bW9iHpJL3qT1O7gsJVpFGi5oWylOwy8Q+j6Fe4s0mNsUtk
	1ScGlSFoev02NBG+VD0qmWTas+WYmBF1cdzM7c9UXyS9A0QFcJOUkeccdcKglpYfizBMX8hZ77j
	Qc+9gJJEN2hk7ONmwKs/UupsZZzwzWxCljIvqLimq9NTkNrtpX+hFHByuncol4L57j8=
X-Received: by 2002:a5d:5f91:0:b0:48d:f9dd:e3df with SMTP id ffacd0b85a97d-4abb386134bmr6418979f8f.18.1795185872700;
        Fri, 20 Nov 2026 06:44:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm5994516f8f.47.2026.11.20.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:44:32 -0800 (PST)
Date: Fri, 20 Nov 2026 14:44:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, yangzhen@hygon.cn, dengqiming@hygon.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
Message-ID: <20261120144430.0b1b43a3@pumpkin>
In-Reply-To: <22eb33f3-a6f7-43b6-837b-74c8f5a3428b@open-hieco.net>
References: <20261028235712.383977-1-zhang_wei@open-hieco.net>
	<20261120094627.513b216e@pumpkin>
	<22eb33f3-a6f7-43b6-837b-74c8f5a3428b@open-hieco.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 22:12:59 +0800
Tina Zhang <zhang_wei@open-hieco.net> wrote:

> Hi David,
> 
> 
> On 11/20/2026 5:46 PM, David Laight wrote:
> > On Thu, 29 Oct 2026 07:57:12 +0800
> > Tina Zhang<zhang_wei@open-hieco.net> wrote:
> >   
> >> The XSAVES malfunction described in AMD Erratum 1386 also affects
> >> certain Hygon Family 18h processors. Under specific conditions, XSAVES
> >> may fail to save XMM register state, allowing stale register values to
> >> reappear after the state is restored.
> >>
> >> None of the affected processors enumerate supervisor XSAVE state
> >> components. XSAVEC is therefore equivalent for their enabled state
> >> components and is not affected by the erratum.  
> > Would it just make sense to use XSAVES unless there are bits set in XSS
> > MSR that the kernel might need to request be saved?  
> 
> Did you mean that the kernel could prefer XSAVEC when no supervisor 
> XSAVE state needs to be saved, rather than clearing X86_FEATURE_XSAVES 
> on the affected processors?

Or when there can never be any supervisor XSAVE state to be saved.
I rather lost track of these instructions after XSAVEOPT.

David

> 
> That sounds reasonable in principle, although IIUC it would require 
> changes to the current xstate instruction selection logic.
> 
> Thanks,
> Tina
> 

