Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291038;
	b=K3gRRe5KRNvbDHNMDb94ffQQeVZJsOm7/r9YKsMI2htLo5QpHXkljBoMkyxXz8MG+Oqh
	 NDjKHea0dx0QQdgS1KPUJwhchMdu1uhr3CEfEO7UnG6JPuCeCs+UK5TKDHrz5MgzV9+c/
	 iOoBFrjE3Kncedwxd8FCdbRU20UQd62BnD5Ry9qC2h+/7rhmnzKmX8d1JpQQCafNc5Nbu
	 qfaxGC8uX5vFyICR/rha2bgSL3VnetJ71CBBbRGPy7R75bqjeC0/fgDwyAKmR3Qj6er+a
	 IwGCCikVCHR4J4bp+sKPMXLjeeU6Pv4x4KDzaAhoa+o95/in9lQDRGc9HRoA+WIdLWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=p7BExmyMwiDR5UEEieV2XRoxDfKEo1NhnCavqA/tY9Y=;
	b=Vu8jdi/wlTGolS95HxcWsfTlE4/TFQsdVQOejO53yG099FiRynLNf5AWOU0AD7zZv7B0
	 khgVFn1+j85/S9kJY+3gFxM0Vv6UcA5Ma3zyIg4yfZHOVM7lbsci/drJW90QirYAZ1U2J
	 D4BSPf3KWDqoUCHblp+dEBtEz8CvQeZ1HyXwMDG0Ej6HJZ7DxJ2i9Ka0xbuco54etiyH3
	 NTe67hBFc/0BeRJ6oxEESduD3F/wDpcefuL4IbRGP4EW3lYZW/IZxl2BDdIo+UoIFVeDz
	 gVrDhySFJl5AYjD0ye9iBV8NhIP3yQqUV7PrlAnDTcOBPsUmahkdzl7XiiO8zUeV4zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I5v0dbac;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D24606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D24606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I5v0dbac
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so22256755e9.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793291036; x=1793895836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p7BExmyMwiDR5UEEieV2XRoxDfKEo1NhnCavqA/tY9Y=;
        b=I5v0dbacQ4WP0S/nvP67diDEkx+Vv6y4Vjt08cxXyOXPUgCwobUt63/XJTKiQCkeWk
         tNluPM75qr/BN9xemD4XGZO2jsPx1WVjuYnfdUtrK3NsxN8PPZI5MpFNWjEKcF8n3shg
         0pVhoqq1m3uk/bsX5bpmUoeBd/ey5Ixjnxvb1K/MpUjTM5LLGhw96k9A0d8zjCcRqBrQ
         oAznT5mDL+wan+lDbK+hPt0BeO7CVqKDr7yFPUdCzozcckXOqKegEPLmSNI2PQ8bbiWk
         dMMUiyPg2vwginbUlo2u08eK+9QNSL7/hACAdzJibVqS/AbeQYPUktcNujs5tzy6Nf6q
         8KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291036; x=1793895836;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7BExmyMwiDR5UEEieV2XRoxDfKEo1NhnCavqA/tY9Y=;
        b=vjZCoRWrihDL96bwR7VHb0TL1BglW9L7cx0YWFb+Wab37PkM9WZnqu+IxyOY+UcSop
         T4yKyfGgo8cPzES0RmRoOiqJMEFYoPdiLy089U2qpCPgCwUv3qGGR7TreLtwUIz6cHI2
         cu6vgyAs3T4EO26j5X0niwrs/8gu+UDtBC3teSnQzh8gXxN/hUS+RxoU+Qi6Xpd7Hw9X
         F0OkPJD9RNt8eWgQvLJVCXLSko5PZJqoQl1LnSw3K3STJkY4cCHfdy3Ig0Yy2HsX5Ws9
         bFuLrJ8JCSl3v97Hl/ng6VN/9vQfIDrhbsKUBnbDhKQgOwGUfDCR50suqmRH7X7gOLgu
         j9jA==
X-Forwarded-Encrypted: i=1; AKwUvBz/eVx90her32Fb576TySwtXWuZY3YunaUGUUTogn9N5ltl4S1UAhchJlKsGb8odeMlzbFY0ls=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaABHWeYS0IOAkidwAPZgPUGM8K/TX5hTTuJTfm/gwOBQO/kIf
	5VP8C9Qe/NRgK0mnFhlkcmuVCtIaVCacrqJkvjNyoaapvObKoHsJpGGTsohjizQrIMc=
X-Gm-Gg: AYBFou1E8Q+W5YZtJDGODNM8bcoACv9wqLfYeFjYJY4D/knc2HGDEtHiwbgtXQ7YURC
	dUdf9u5XC8ZuOF8kVZUamYCZx0jCUDD2xjElHPraPwc8gwe6/BJKyfTnwnQ6zyj2MMeCdeOUylL
	9m/ur1y2tnSLJRA+WP8oHHxYvQhzLR8GQ5gWsRSvNj5Q9XPYiY9ql7VRMkA6tUeZLYUaR8IFnWw
	uTl0KEe1ZyLOyBuEUx1AuM96lXSmCY2spwFUELArMiyObkL6ebDVX1Ey/c0571F6yug30j+euKA
	jEK+mkWVzw0NbzzwcOnapDQT0PwTOISPwLji1DBig6DY/IPq8ySI9s7of4IogG+DCZouXyuO+i9
	fPLSdw7UvuyucwjAoGwYzsGqjfOQpkr+uqlinPvhShuxdUG5mwNLPK6TgS92l/VaE2A0FRkvCJo
	YtANv2y6xVNXH06p3nErSHDIsV5SAQubrS6vZILcwc6naMkDVUIVa0y53K9tipKchZEWETnBppf
	w858XyX+MN9KXA68wyrfaKjvg9e8ZnLLfp6pjOsvTxD8uPNi9FP8K/qpu3g/p3bAhVpiAhGd2c/
	RXpFgWaEKfD9+hS0giiqogBQC50/2SOP+XvqkOOO0G0=
X-Received: by 2002:a05:600c:34d3:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4a9643d37f7mr138287835e9.3.1793291036011;
        Thu, 29 Oct 2026 09:23:56 -0700 (PDT)
Received: from localhost (109-81-92-234.rct.o2.cz. [109.81.92.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7ee575e2sm75886455e9.1.2026.10.29.09.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:23:55 -0700 (PDT)
Date: Thu, 29 Oct 2026 17:23:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Liam R. Howlett (Google)" <liam@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Baoquan He <bhe@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
Message-ID: <auNzGgj3OqLTG0Cl@tiehlicka>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-5-liam@infradead.org>
 <auKshDXKQXt1kvjy@gondor.apana.org.au>
 <auMbCuecFeRmBFSK@pc636>
 <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>
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
In-Reply-To: <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>

On Thu 29-10-26 10:53:56, Liam R. Howlett (Google) wrote:
> 
> Sorry for missing the ML in my initial email, I missed it from
> get_maintainers.  I should have really clued in with such a small cc
> list ;)
> 
> On 26/10/29 11:08AM, Uladzislau Rezki wrote:
> > On Thu, Oct 29, 2026 at 10:16:36AM +0800, Herbert Xu wrote:
> > > On Wed, Oct 28, 2026 at 11:42:18AM -0400, Liam R. Howlett (Google) wrote:
> > > >
> > > > Below, one CPU adds an FDB entry for an RTM_NEWNEIGH netlink request,
> > > > while another CPU is inside vmalloc() or vfree():
> > > > 
> > > >     RTM_NEWNEIGH                      vmalloc() or vfree()
> > > >     ============                      ====================
> > > >     spin_lock_bh(&br->hash_lock)
> > > >                                       spin_lock(&vn->busy.lock)
> > > >     rhashtable_insert_rehash()
> > > >       kvmalloc(GFP_ATOMIC)
> > > >         vmalloc()
> > > >           spin_lock(&vn->busy.lock)
> > > >             waits for the other CPU
> > > >                                       softirq: a frame for the bridge
> > > >                                         spin_lock(&br->hash_lock)
> > > >                                           waits for RTM_NEWNEIGH
> > > 
> > > I think this is a fundamental bug in the kvmalloc non-blocking
> > > support patch.  How can it be used at all if it is susceptible
> > > to such dead-locks?
> > > 
> > > And if you can't use it safely why don't we just get rid of the
> > > broken kvmalloc non-block path and have it always go to kmalloc
> > > like it did before?
> > >  
> > If we have a look at this as we did not have vmalloc() here:
> > 
> > 
> >      RTM_NEWNEIGH                      foo() or ...
> >      ============                      ====================
> >      lock_bh(&br->hash_lock)
> >                                        foo()
> >                                         lock(B)
> >      rhashtable_insert_rehash()
> >          foo()
> >            lock(B)
> >              waits for the other CPU
> >                                        softirq: a frame for the bridge
> >                                          lock(&br->hash_lock)
> >                                            waits for RTM_NEWNEIGH
> > 
> > Same issue?
> 
> Looks like it to me.
> 
> > 
> > I have a question:
> > 
> > GFP_ATOMIC/GFP_NOWAIT guarantee they do not sleep. Do they guarantee
> > not hitting ABBA dead-locks or they are not interrupted?
> 
> GFP_ATOMIC and GFP_NOWAIT can be interrupted.  It's more about not
> waiting for reclaim (kswapd might still run) and GFP_ATOMIC might dip
> into reserves.
> 
> The issue is that kvmalloc() now falls back to vmalloc() for
> non-blocking flags (I am restating this to make sure I'm not missing
> something here, please correct me).

Isn't the real problem that vmalloc should use irqsave version of the
spinlock to preserve the locking constrains of the caller?
-- 
Michal Hocko
SUSE Labs
