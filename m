Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353963;
	b=LLACe1Km1lxpenZpsfWCrh7LO97yixeUFX3w/ywgYIjH4HWM5KW6GfIVa95mljICKsVM
	 m8zYe0ehqepWxfIPl7vgJnLiyTOlU0kMQ5NRAwAJqzoH51eS15pwTvZwJYOBnL6+uX8fI
	 MrKPdNt7ozna8NIFoshL3RQXhgawFWUXZtJs1xv3c8QY1NYlzDE8jD2HhKzZAZL9FokqR
	 7j4KaY/DKyarlmBFMRFko3WVmK51Tg7JQTA9678AAlZO5xk4jlnik3S/rvwC82aRxyXp7
	 H7djtzij8hWghe22B/WW5U3gYUMAVIDzWPa8un4wbIED4dKL11/VP/rgZNu9yOCLcsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2B3bjvz5/cRFhwo9ukB7ZLLCsSJwpiNTa01piLcwoAs=;
	b=JU4C7IMdkAzrTbk4mU/Qh+S4hDSUOtXN/A+CzsD/FccqEQOefaPhpf89k8JP3o87aWMW
	 C69o6XQeKzhJLIT5kNlKLk6bRCAeeeiwzGc7KowynIGfNUxH727rG5UOt+4RiZPcw2xrR
	 5a+OUVidsBsfxBEpxPVWv0BXT7rwbrPLiWJau2AiZ1VT230FeFETpkGFnxTfmrs6xauL+
	 EIPiOT28uUkqkGtvuC1zGJ+pQ/s2CQmL0yN1nHHWEH8zfrgCn90Y8HXNlB5f4KKi1pci1
	 GqnXfFpRlCJy/fyMsMcaZj5JhL73RD0Qd51VCCsUQ4oEV2HX4URrVnsd2cZsOA9E07g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bsuXLYgo;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2969606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2969606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bsuXLYgo
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4c9abc1824so69921966b.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353961; x=1793958761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2B3bjvz5/cRFhwo9ukB7ZLLCsSJwpiNTa01piLcwoAs=;
        b=bsuXLYgolet9UtrpUXTjhF0NtZvh4wUfphWhBPdTzAHZ+voK+TzvSJt4jqtpIr4hDY
         BC576Tfm8MvgNixvYZj6Dqi4K3sFXUSX/7ZAfmkSmMMCDN7GxC4LIVVNW4r0Hl+mplFs
         W2by6S5cSgPj0g0wmpKfwfNf/zqgAEOXhiapRngSS2+Fa9wKQHztRhPeqLJ2d8kb2IO7
         Pq0H2NawTdGX7CmkA2qi3LE66II3XNjS223Mo2JwjVI062D0QJpvSdz+nUrtA+uP1o+G
         Q76CkUSavVprulwf+DpSyGG/1MWy2CHk3nt+Xc9tqJwtIHmBIFhTi8Seu1+BLrOUwvFD
         2wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353961; x=1793958761;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2B3bjvz5/cRFhwo9ukB7ZLLCsSJwpiNTa01piLcwoAs=;
        b=CZE+avu80onLVEvs0WQ0GU51OXhWnBS+09ETFDBAUdO5tirT3bOthThXOL5gxMVygB
         nRi7iWVwfmlfszkASg+7Q48fzEHsOWUiKYrgVXg5leCFFPPnNdXU3XQCuwHgIQq/6Wlu
         VhMe39PBgYT2SjOOtmQxYD5Af1lgn5Aj/hdbG08U/VPIeVBPlrA0ouICAz1gJaMZu1EK
         fexhQlI8N74sAN7vloSKBbqK7Nf9UCFSSBlnFctlE33SJ1xtw+QRQPP1YFa0JYctq2gs
         AKFRfG/J7iscUmMy5aiNZBIwWuaeSlSwUIdYbST5QenqX3asCz/NSI6bIW7DmfSst3mq
         N66g==
X-Forwarded-Encrypted: i=1; AKwUvBylrh/ME172dqUt+POG3lEDK9p1xfM2+NhqRQe+XftgKdlqFrx1IoA7QnGRA7TJRmkcRHjJu0M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvOcgc+ArAmZ67Pge6TGh4eFbhF1F3UtExlXTXI7OwWpDuL+7U
	WKj8270aeCbV3fEgnKqpr44qZxmK88NE97yyiz6ORU1qlFL6fU256qMB
X-Gm-Gg: AYBFou3AT/am7pcxYJfoZbwvverYNmtu/r09JdaiiGBqoEiZtIOp7OFiLqwgI/2wlqh
	xoetWglNxSVmyPS64MEWTHLiS4EKmrhSePI6EHGwiWaf12+Ko49LGHkhjqEh6U4b9WbsuLRqQ9v
	SHZt+UDYF9G4R4RiDIT3NPZ11RwmWpqrx0ZOZBOqqna8TFCCJFlLWNuj8wXbaUM+N+Oa3novqqh
	pUu7LEHDSQ1TJjj2f+TyhefR5apFdl+3JperZ74oUHHBxyoHght4Vlms6NVsb7+Aay0ze+CgrQ/
	Rb0Dd4wWKBeiY3tfX4LGMjcJkpjQFOc12tNkSab3BejvcisV68WMgsMVaNVVwNDtu0HpK5aJYoi
	CBp2L/aiRSLx4KeBCgiY169VS0H8vchZD8F7/JLJCs/NhW+J722LNlpoFf+DZNL0ASmdjzdKQcL
	mOodOTDvzkXvvNhIwH+3SzvTUtLQtYLT+XKV+9vxgI3JCwOMXnP3Y7gtg3TxgrGFXT+XYtdNFwD
	F7y4TckxyC2SYmj/iDaDCIzAiH9TviMHNahQMAuUg++nuoxJwZk/22oLk/k234DqQFk7g==
X-Received: by 2002:a17:907:d26:b0:c2d:c800:d797 with SMTP id a640c23a62f3a-c4ca79478f8mr163699766b.6.1793353960890;
        Fri, 30 Oct 2026 02:52:40 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b1d556sm432290a12.28.2026.10.30.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:52:40 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 30 Oct 2026 10:52:37 +0100
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>
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
Message-ID: <auRo5WBj2OlKlWGW@pc636>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-5-liam@infradead.org>
 <auKshDXKQXt1kvjy@gondor.apana.org.au>
 <auMbCuecFeRmBFSK@pc636>
 <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>
 <auQhkHG6XlgNTdRr@gondor.apana.org.au>
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
In-Reply-To: <auQhkHG6XlgNTdRr@gondor.apana.org.au>

> On Thu, Oct 29, 2026 at 10:53:56AM -0400, Liam R. Howlett (Google) wrote:
> >
> > Given where we are in the release, this fixes a real issue that can
> > happen so maybe we take this now and settle the general handling later?
> 
> There is no rush at all since the bug that you found has existed
> since 2025:
> 
> commit c6307674ed82c0c57d6e1e3408e84ac449ab8e94
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Oct 7 14:20:35 2025 +0200
> 
>     mm: kvmalloc: add non-blocking support for vmalloc
> 
> Let's take the time to fix this properly.
> 
The problem with spin_lock_irqsave() is that vmalloc() path can take
time to alloc and map pages. I am not sure this is worth to switch to
irq-save locking primitive. So this is the "heaviest" allocator in the
kernel. Callers have to be careful how the call vmalloc().

IMO, this caller has to be fixed.

--
Uladzislau Rezki
