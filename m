Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268496;
	b=n1y8hdEaOA6Zk5+i0DHxmETdwQ8HAs4FKcPd6fqEsIA+mvoWRzCbyNRls4Yh+9GFWHfM
	 +/lDoZ1+z/RQ8P/LT74O/mPWY+EYUd3wBfQeMKoYsOMQsYNQBdYf9Td5kymGUrhGcLyWO
	 SAFsDaSXfdAe6WAJY0Oguf+i8aP5drSszwd1R/dqTtPTnQMpnP4ubgGGYjuGDqHSkY+/0
	 D0K5Ai3y40kB7XOrI0ZYVcis2kAKJmpljPPfA4WewU79t/eZNW2UouJXF/QZLkY8cVvBf
	 eu31tYa6UTBomwlMLkTKZoTPbPM1S9KnOo2QXZerQQ3yh33I8pI3CIFYQsFAr0SVesw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YqJZ0P7+7fLRIuROPGM5CtyVNeaoNZ5CLQZzkAwMRGI=;
	b=j7aF8H/i8IA0XyvlFEeGWqeewSs/ws6fpNOe0iSlCyR8wu1xJihWwei5Va24mFSSwOsE
	 z4Mga9G2X7c7zeEvD8dyO26SNlFHrmWIZtL/2hUHHkVoogAPvnOaLuweg0arbrt77PS0T
	 aI+VZXZ5beK1su5ggsH+u634OmMRhGNU1r/PkcTtYm0jnKbVP2NQCGQo7T/7GFVfQ6X3R
	 kleubE+4Ut/9iPKmf8u9Wfx3ucUv88/PP9hMNYtRUF/a3/fQLC/HH1v/fedqDDd8DceQt
	 lBEx/rJQjjsnC5fOAzBky6+YDNhUDwHkfbFQadgX12OV8h9rozpCgEPoZiSNCIV5h6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W+1f/+mm";
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936A606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3936A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+1f/+mm
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso1966258e87.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268494; x=1793873294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqJZ0P7+7fLRIuROPGM5CtyVNeaoNZ5CLQZzkAwMRGI=;
        b=W+1f/+mmtUVeicMuk/ydwLlfIFytKQiJMmkoEo3ynnRRfaKT7HiLSfDiAd1/Y+PwhD
         8cfrCfRXamJpaAPt+sWuYsp7BdH5yz6uF3NU77u0Zj7LMibQRIglvylRCLJ0Qntw7rM2
         BbzvZSf5xbOzbQHuDIBrzREi0Ymns/KxwgPqynRUeTyJI+rxoHwyStZYDt7QrGJ2Hegd
         WwS3AFgQWxpcrih0E8/Dm+q0179BJUhZnSNN0Lgaw8UxVWfyauTB3/Q1gcCe4/aTuHXP
         DI20dQ62MiGtD07UdkgLwuEEcMmCwBlFxBXbVPyL2eFRAKI1y+W33XmqlUpXNupMzcss
         ws9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268494; x=1793873294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqJZ0P7+7fLRIuROPGM5CtyVNeaoNZ5CLQZzkAwMRGI=;
        b=nEPaD7i3rfrcUywWSjUKL4No6BY2FeTRBMuPYnIlRSt5juUG06TNJZDjyfCaQgU9ux
         HoVaKLm36PvyFDHzcVQve+Tf+XBz7iFkarb3p9PQWvS75DRzKh4jPjoqmvpZ/czQJ9O8
         Ge3+aoy4Jp8wBtzHw7okck3QNJ43W0Ce3lzLugzC2F1YJpfKPw1rBcxawNRibHF8dcRK
         5hiN0UrSs8ffouAX+v9VZ9xobhCs9HZUliUNLqq/c5a+8f4FzsLec68shPAECCT9BKT7
         uXgHLICm5yejaWGjyTIqJipL8xEsszlv1cXa1e8M0U7w7BKr2fu0qxl93P+nRiW5V0Ly
         vJmg==
X-Forwarded-Encrypted: i=1; AKwUvBz6SCsmQ3jZp5qLRk5aEibqaqHKIxNlOMlhs1Q9spelhDB/E+aR0rYe+ZIT7w6nCrLzI4IpxKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIa/wzEMogdJMUak0JzLOwdf8EDdMf4dkizJ8/AIVRBSy/Gvz/S
	lSKnd2XlF7n/LeleJUAss0KaxbpP+IU9+bZ8fTkI3f6FZRgpdoHlgDMx
X-Gm-Gg: AYBFou1wkXyGqhFIA+/oROf7axMgEDzcBrRNCOiHCk0NIxrRYQSfnECCUcv4mi6yeP6
	XxVzB5lv0An3GMwU2B3zVBRRs04wMtTOfXZP3d+8ay/S6JCqPKo3vbS6fcyYEWcpeEAXNUYJ7FB
	I2sCBNTZwkZr+Ewt3kTJeblzOuMF86cLhBnRjtSqOdCQraEYhZHkUCIMZ055yJaxo4iqOeksIy/
	G921wmcm2UtwgHWW8rMRjitEue6C1p/jTRceq9uTYo7g3c04GQcVH6nJOtuO2kY/ZsJvcTnPw6j
	zOE8iYpczDyDz/XK45oxMVRP9uCCCskWeDjp/bo6O8qi3C6PfppEbA38gPL0IbJwYSSV+ZIjBay
	WjcNBGqLXYOjNTxqT7ZO1pY6LOxPfgjmp4DWjrjByrdCjKtmOs+pM4uWd5G+pHvs4zsxfuOZ0zP
	gaw9J8PW/wC2B5LTmC0a4qVkzuMylSezLeK8MpQNaNkJpBRzUS40wiu6iolzKZdLszbURmNKuhD
	uZMWPnsoIKLaefFRivT+KMiO1Y8TVOY0VtM6Vtl3peG/DAdsBtnYu+rVqKshVSq28r/NQeH/XSH
	V2CfRoBljEKejdInP6/ekKMj3T5Oo+4v8CIw7OUliobdeLrCTVSDaJFGhDhlHsSOOMVg1y5tcso
	sZ/2l
X-Received: by 2002:a05:6512:2512:b0:5bf:d56b:a71d with SMTP id 2adb3069b0e04-5bfd56ba77emr273419e87.46.1793268494124;
        Thu, 29 Oct 2026 03:08:14 -0700 (PDT)
Received: from pc636 (host-217-213-144-15.mobileonline.telia.com. [217.213.144.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfca5bb57asm1109637e87.74.2026.10.29.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:08:13 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Oct 2026 11:08:10 +0100
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Liam R. Howlett (Google)" <liam@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>,
	Baoquan He <bhe@redhat.com>,
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
Message-ID: <auMbCuecFeRmBFSK@pc636>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-5-liam@infradead.org>
 <auKshDXKQXt1kvjy@gondor.apana.org.au>
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
In-Reply-To: <auKshDXKQXt1kvjy@gondor.apana.org.au>

On Thu, Oct 29, 2026 at 10:16:36AM +0800, Herbert Xu wrote:
> On Wed, Oct 28, 2026 at 11:42:18AM -0400, Liam R. Howlett (Google) wrote:
> >
> > Below, one CPU adds an FDB entry for an RTM_NEWNEIGH netlink request,
> > while another CPU is inside vmalloc() or vfree():
> > 
> >     RTM_NEWNEIGH                      vmalloc() or vfree()
> >     ============                      ====================
> >     spin_lock_bh(&br->hash_lock)
> >                                       spin_lock(&vn->busy.lock)
> >     rhashtable_insert_rehash()
> >       kvmalloc(GFP_ATOMIC)
> >         vmalloc()
> >           spin_lock(&vn->busy.lock)
> >             waits for the other CPU
> >                                       softirq: a frame for the bridge
> >                                         spin_lock(&br->hash_lock)
> >                                           waits for RTM_NEWNEIGH
> 
> I think this is a fundamental bug in the kvmalloc non-blocking
> support patch.  How can it be used at all if it is susceptible
> to such dead-locks?
> 
> And if you can't use it safely why don't we just get rid of the
> broken kvmalloc non-block path and have it always go to kmalloc
> like it did before?
>  
If we have a look at this as we did not have vmalloc() here:


     RTM_NEWNEIGH                      foo() or ...
     ============                      ====================
     lock_bh(&br->hash_lock)
                                       foo()
                                        lock(B)
     rhashtable_insert_rehash()
         foo()
           lock(B)
             waits for the other CPU
                                       softirq: a frame for the bridge
                                         lock(&br->hash_lock)
                                           waits for RTM_NEWNEIGH

Same issue?

I have a question:

GFP_ATOMIC/GFP_NOWAIT guarantee they do not sleep. Do they guarantee
not hitting ABBA dead-locks or they are not interrupted?

--
Uladzislau Rezki
