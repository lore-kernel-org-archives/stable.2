Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845386;
	b=13WFF63MzE88XoHdnHnj0v9KRjuxQwzoJl1vtp7CjA/WH6Xuugy/TsIQKK3TMZVl8F+8
	 IBNhrseg7umMDYtgYQzxHZ+Bak8E95RB4cEzmqx4ZI7FTKmCDu9Ytkn0R/tgoFFu2nUpZ
	 kCQ94UQV8UapPrcUUztxSMoaTMFyCrqrBEeIiNZ9EFl6ZsEsC4djt8Sr49GezrFaK93Fp
	 /HGQ4gA4DSS62ABeRuFDIzKjxs2XICSrG0jQdqYSkHWOt7qdl5qT6OhOE26yeqLl49dA3
	 xfVBdI100CWiXX+URw25wmEiO84s3vcQp09PogQ/0WWjuzp4yYWhidmypPA56lqK3pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=O/mwZYYaBoMRcXn1MKOiGJvQffr+SWgcNW4Z7wvG98U=;
	b=oO0vuMkyJzaTDSA2SMHpY9Q5oQdfICjeseI5QQtDmgj2ioe4bCjxrdumPG2wiBEFNJHD
	 F+fF/bLTVTabX3FS6s8V/gkW7HIHiuWNuTOa83UeSa7Z6mkRMIqyDA8ZKFokdUL9xHA/y
	 yqp731NUSgYKl3oXt+uI8559WQMkxeuPaUfaTWbIxmbOek1MsStJZp1OCUOaO6ozmIEgS
	 D4Bxq+F82kak6+R3Hhw3q9C0tJ+BRkC6AwQZUsR9yW793p2ksIdbxCLcfmI5nxwxThz7V
	 KJErkH4S90lgo7dcdmWmcKxQ6bLWDOeZK2tLT2AgH3tgoZ5MJsuk9NcSDvyTbgzRncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Pwoj9ith;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F6606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Pwoj9ith
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ecd81cd67so46484096d6.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794845385; x=1795450185; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O/mwZYYaBoMRcXn1MKOiGJvQffr+SWgcNW4Z7wvG98U=;
        b=Pwoj9ithuYi/5fpoYzERLi4LsD3EQgXEzgL+h8/4anPHsJZ7zKgS7puJ446SO3SAbB
         W3q0/I+fZ7LsFa2hJniqO0eyxWwTRO2lIZiMrPejnATDLb7ZVkwcOJcS3JuThp/1ov1c
         uh+sU4u3QcN3E/nVGYI5boiGhypkvBsVpbKtyjdpIxRM3sme7xOwIpNARGf9pPi6ptr4
         qQacE8rnNtFvpW0JvJAfuFni3s5F2rE/ny/wl+xbkPOO8mTXCO/+/uV89aqC+MzP7S0P
         AwyDWvVIwvjwP5PWeC8DHD2u87uYLwrDzej4/2SF9O00iEmtPcoh1u6hGbMjh7A5uGlv
         sLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845385; x=1795450185;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/mwZYYaBoMRcXn1MKOiGJvQffr+SWgcNW4Z7wvG98U=;
        b=MAEd5Q5i7jRAhNC2PnHdtmllM1fd5/X6Ha6xFiS96JfqeIh5sjU2hVJ7TVyWEKoSAe
         ksdAGtLorGnDfj6C5Vl8YkywQT8s/4+LyVW+hyro8TOgmMTGgquwDxSR3rTJsgqH7IYH
         +mQCfDsvUEkuLFDmbbGJZsSsvCriKtLYRsAQnGouGIVJqYJpWhjDxl5NbiuIzb5REho9
         RRuSgHhWWwEHjwEo8poWDS7fvch6I0vnyhn6Me2pC+6gOIreBELjqO/IMqCzoSdYTU7G
         SI0YviXZ1VYq/4nsKqImkiIjXkR7lEzyRazcAKVQ6cjr/4LNevlm3lhFSojatpffrNsi
         PH3Q==
X-Forwarded-Encrypted: i=1; AL+hErGQCTzPi0466JJQu08FZuRijbfbnxSbGLpgXusgDe6s916Ngc5Oaa9/f6gee3KXO71TTIJOeAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/G0TZZXUXZglQ5DU9k9XBmFh4qpWEceR8VHttYnXYCHUO18OzD
	r5EjR5qBYg+ZYbP2bV3aCi48k3Wm2NS1MWW8zeMKYOdAsnEjh3vy+Fa2htD6HSuARweZTEISCir
	JMvAQ
X-Gm-Gg: AZFdTZcOX0O/30gDZXQ/HzGJ5sRV8jVbU2XRbjReu4OVZ/YjpHnNIo+ByQvRhz/7bzN
	u0Nv3NYy4nHDvB9eZ4t9ZI2PumrL+nfzeri3AmKUv58wTM8GTuiNbavc63KrexMNxtCVaD41djn
	ChDMVQQcibfq4B4PVlQYhjs7Puc3DhId+JQ4fOBZ8SpLw5UK+u4PUiq1/2NPFUPGXYb5pEzNpMA
	UYYmRKoAtDb7tXA/tg4u02pHprMrfRfzggKdC4tqbptjV0LAMHMIrA8ykcawdt4bzEe4FazIbkZ
	k57GwctIIhlTKAWNCeCzwWsWosnYMyM3BYDYR2TT8jLoJLjlLxREa5h36NZ2G/U1eGBeoY0LJC9
	H9SflZewuxQWlTjnamulh8TaMMBcYd+u/fppbuO9N7HJ8SrOu4iB6Wp3pGn6kiimbGEpOq6q6tf
	WxeKZWlPpb0yOMFQynNPvd4ma0W/djKTGU/braDbaY+zU2e6ETQxO4Js7vreYIujmt8Oy/6Xubj
	k9iiiDnb4yUVfpkbCh0zUp243M7D5BF49mE4SMqIZoQPP9u6V3qEMRTufhcz4P43M+KTPRTlOQz
	JLFcKurfNjn5oWrwAJ9ATuCvCC8xKqbL70/X0DliNI3/rN/6rHqZ4xNx29J4QX9FSkNfV48AXpN
	4ob95r2E=
X-Received: by 2002:ad4:4484:0:b0:91e:9ab9:bf37 with SMTP id 6a1803df08f44-91f2415f57amr132104666d6.14.1794845384821;
        Mon, 16 Nov 2026 08:09:44 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d6193esm88683016d6.19.2026.11.16.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:09:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, 
 Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org, 
 akpm@linux-foundation.org, kas@kernel.org, dave.hansen@linux.intel.com, 
 bp@alien8.de, rppt@kernel.org, stable@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
In-Reply-To: <avpAQyLCpJPKSpT-@nvdebian.thelocal>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
 <179464112539.482102.8723246686117488051.b4-reply@b4>
 <2fc85df3-cffc-4786-a7a8-0f0a6347fd59@kernel.org>
 <avpAQyLCpJPKSpT-@nvdebian.thelocal>
Date: Mon, 16 Nov 2026 11:09:42 -0500
Message-Id: <179484538296.482102.4367398493158269026.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 10:48 +1100, Alistair Popple wrote:
> On 2026-11-14 at 22:11 +1100, "David Hildenbrand (Arm)" <david@kernel.org> wrote...
> > It's writable by the hardware, that's what matters to core-mm, for example, when
> > it comes to things like fork(), mproetect() etc.
> 
> Except they're not universally writable by HW, after all _PAGE_RW = 0. So
> pte_write() is documented to return if it is logically writable, which of course
> is what hmm_range_fault() also needs for certain values of "logic" :-)
> 
> So it's easy to see how this is confusing and got missed. Anyway this fix looks
> good:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 

Thank's Alistair!

-- 
~Gregory

