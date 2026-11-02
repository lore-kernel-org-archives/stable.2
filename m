Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618296;
	b=XM158de26T8togy++7D0MG+ReiZun1Tve4w43RkhfCkjMCF18STQcnRXszsH/vGSKbPD
	 Q1tEF3iHZNPRSINhW2G722fgieypdTcuCOgsJSNP5rCEVfANzEcZ2lzPbxab3L8ZshybI
	 5xeb6qG0I25d9Lp/EGTAJmGQu+E4tJz2NFeTV1L9ByR1W+gogMexLio8g38ZtB29dvi7G
	 r6H/uJKXp6LykzbgE01eSdDqIGCAp0E/hNIYSO4CYhZT30AtNdT9/hHvWl4aHc6AMLPUV
	 A7HsMj+MO3i+yLScCYGB5dHn5d/AFgQ1WRbwY1U5R4jAWgUzurHBXHJ8ZdaWsMj2oTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1yynEp54ZHg/bAl3tECuL99Dgvavr9fresZi3o0Y1io=;
	b=gh6k07C5ehf2z5+Soapdv3oFen/87fgy9GPUL7G15gSlRswMRW142BOi6b2R6WbksGft
	 yq62FQA4uvNGEtXrsmNUx3x/8eZim5Szi25ps/UH+m4TQJ9pp4JwoXp2/JxRSSbr9B0hZ
	 YV4v2E9Nhjr2nEdAsJeF33mdx3Iby9MiMfpGqJh+dLZBsP2/0gVQRD2PlaEKrKDs77kC7
	 dNjRxYVrX6clQhZ/hMdt/zDaMMHEjqeKIaOIDPxSg25/pLJwtjZTs6SKWWeM58w9Wsi0n
	 CIuNXwcc1t9ZAb0GTtOpmUQyLcju+vYYCvthC9ffBwfMLhNuGULiUFwgkXNYfonqMOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLXOpm8E;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5760A263A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A5760A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLXOpm8E
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso2405991e87.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618294; x=1794223094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1yynEp54ZHg/bAl3tECuL99Dgvavr9fresZi3o0Y1io=;
        b=HLXOpm8ENVpkY58LUtPdSmKtWAjb0kBQBWUI9OSY32i0qu+IF4ZGEGl8hOjOUqBPwJ
         qucTFrRAybe/WdWOvtPbOiR3zr+8hSiRo0D2S5QK8cF5RWRjPBVF4R6T74uwLPlEsVVM
         M3R0rOY5sP5zynRjiyNvFXxxqVyQAX8KbW2aEA4Kj6gSaWYc3cwmgu+Ve63x6rVk8Bx0
         fzeSkGIMJDt7Nd06VPOygUrVFuxvgrwQ3y/iplClvGv4nNyisUI58oXnw8xPB4oEP5iL
         oo+WmRiIVTNz7nx4soa4rvaeUAeBf+nZ1MxJEyN2xjM1jKuXKT7Su6H2jP65P+FaAfQM
         xkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618294; x=1794223094;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yynEp54ZHg/bAl3tECuL99Dgvavr9fresZi3o0Y1io=;
        b=uWnWHyWRRsn4lvbrHEP/X3HqZ9AC75GisszU+KCZr3ASkqzzu3GWfyT62//EAHJyV9
         /T08wc2G0V6X66LlcgL0dnP3kzAoZ0/rsbNdKeMqkANgavmXazxbre87qUAZdXtx4V5s
         /M2QO9Lf3n9byWBMq8xJdt4dERrz0ajbxpINKLRlYFgtOtXEtQb7XWX7e1cWkLfMKEy2
         KyWIz2oIi0mPsZnkaot34NBTVze4h28U5SFGrchL+QDAxhSdJId2Tl2Jhm58eq42mV9y
         vqbJDjWVBg6ADzlvYApEGYPb6gTbG0vOrV0J9mqX+nPINSzilz5ECoQgtMa5EHVvhmNu
         z0bg==
X-Forwarded-Encrypted: i=1; AKwUvBzKEKrAvrmnSGXpfGCO9pVEtVs/R+pn09mTEfO2JGeYXr6lavT8Qvy6NtnUCpdGE+gHdh8SxzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nxZpkrkbuc8fV0ZsSg9cOjnzB/jP6qUO+DUwT4CaSwIk7iRuK
	NWXNXDiQIDijiwVj0j/mnkaAvHlRDZbmRvRdxmp3P9Vmjf4sCp+pN/NW
X-Gm-Gg: AYBFou3FhmKqUoHwrAebaFLSzp3IsBrdUZxfLA7O639oyAKfInnpX1iPHGcTXYgYn5a
	oa6z103pKxtrU5XOpIaQfczai8RGegMEofJQBAk8QOKwJsvIB581VYKfUuCukfVo8Ho6XQqfNDc
	vS+cPxHSk/UQQrcRHqpvo+VhzZ8cdP1byHMTJy/pxe6HsC/kp+vQ/Z72Yw7zFXAOm+F4aUuxtfl
	fY+PUjS+g9+w2F709WILPp+99TY5ws5p0DMuNx0mrKv62LnpRqn4ALfQG5oGOueIoqWh+bGJOpj
	x6mvVc2Ujb1qX7zozDdEmaT2aErTMcBiD+uHz69olmukVqC6/DNyG7iWpnakSoY52ZPOG/S85OA
	qfHFs+itBoCUYb4vd7ENmU9j2X1MIpIu/gzhIjIkgVQ/LuY6cJ+9Ix7Lg5kIpf/u19Ysm/h2Ajd
	r8sL5AauMgeA/TV9osz7JUUB0jjjyjAaQF1IrSPWtalrKBVLBzCWxkBQMcoebPU8PLEi6P0za3V
	j2mIkX17Yg+gMhfsoxsTtjvJZa+TubnDaTpXxuvj5PnhMXVlMwJiMT3LKBgyYWc0yjIKZb59lZ9
	v/03xv6aMzfl72LWh8lyXo4vzI9FtLHTiOVZPNDSG2uRN2SB3uvAfA==
X-Received: by 2002:a05:6512:1392:b0:5bf:c9c7:eae2 with SMTP id 2adb3069b0e04-5bfd9596876mr3227650e87.66.1793618293591;
        Mon, 02 Nov 2026 03:18:13 -0800 (PST)
Received: from pc636 (host-95-203-3-139.mobileonline.telia.com. [95.203.3.139])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe074168bsm1622248e87.63.2026.11.02.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:18:12 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 2 Nov 2026 12:18:09 +0100
To: Matthew Wilcox <willy@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
Message-ID: <auhxcS4rtrPG3tVF@pc636>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-5-liam@infradead.org>
 <auKshDXKQXt1kvjy@gondor.apana.org.au>
 <auMbCuecFeRmBFSK@pc636>
 <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>
 <auQhkHG6XlgNTdRr@gondor.apana.org.au>
 <auRo5WBj2OlKlWGW@pc636>
 <auTrzlSFCWNJYisW@casper.infradead.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auTrzlSFCWNJYisW@casper.infradead.org>

Hello, Matthew!

> On Fri, Oct 30, 2026 at 10:52:37AM +0100, Uladzislau Rezki wrote:
> > The problem with spin_lock_irqsave() is that vmalloc() path can take
> > time to alloc and map pages. I am not sure this is worth to switch to
> > irq-save locking primitive. So this is the "heaviest" allocator in the
> > kernel. Callers have to be careful how the call vmalloc().
> > 
> > IMO, this caller has to be fixed.
> 
> Which caller, though?  Are you saying rhashtable_insert_rehash()
> needs to call kmalloc() instead of kvmalloc()?
>
The problem is that we used to BUG_ON() in vmalloc if soft-irq or BH
is disabled, i.e. for vmalloc it is incorrect state.

See https://lore.kernel.org/all/69ff8c7c.050a0220.1036b8.000b.GAE@google.com/
Two patches to address this:

1. https://lore.kernel.org/all/20260515153009.2296191-1-urezki@gmail.com/
2. https://lore.kernel.org/all/20261026102503.30860-1-urezki@gmail.com/

second can be updated and resent as it checks if the context does soft
irq processing whereas it allows:

bh-disable;
vmalloc();

forbidding this will address the rhashtable deadlock(discussed here) but
this will just fail allocation because it is incorrect state for vmalloc
and calling kvmalloc() for rhashtable will not succeed.

i.e. rhashtable context should be fixed also. This is what i meant by
saying: this caller has to be fixed.

--
Uladzislau Rezki
