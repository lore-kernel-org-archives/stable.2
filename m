Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07783470128
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858907; cv=none; b=d3LTC7758M/Rcys4Qb4PzP18XG6zLyVQI6PHPrieTbJH/btpPS2XXlWWgUlorDFpAJ5LoWNQuJjxrmqAsWrvclOwMxAItcbeinqa5z/QdrvYW09z1tqHcl+7T2EhEM0+6GQzwHfbTaO1R2R5tj0pR2o/8x2QZ/Sn1DAaiDJLJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858907; c=relaxed/simple;
	bh=Q//y5m5Yxd18sp0LOAnD3pfZW9rQUoqnCAMq/cVsN1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIAvjYP3tY+UQ1I97Cr6J6MHTCo3UkHhesxZqe4nq9WWVaRQp/nq0Kgj7CNPVsk6EQMuP1KRzf69r2BLZ8qaLmUPYIAQAe2xdviFZ63o/x9dNmJmBHena9ui3CkiJx5FXqhfxgEkEkvsxLxaqpDT1vaP1vCv80VlDDrQHSe1E4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=As+HP7Kk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="As+HP7Kk"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso7730439a12.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785858903; x=1786463703; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4xgJp2B/z+NAqHhu5Ojm/1pvtssSxY1YUWVWv7CENo=;
        b=As+HP7KkrSISBrbzeQNFg3nMS/h8wgkiMD2MU3ZPjLjmWK6Zbn+lv8Y3lrlF1kAZjg
         gzmr9WhhO2v6O3Kvsx6CTBHp41haaiphsvKFO8BHQ1NmKvNXmnkjSpXZonRlhjNOimzL
         bQCrVJj4nqUI+Ew+rST6/dLM+xSqRYwxr1AJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858903; x=1786463703;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o4xgJp2B/z+NAqHhu5Ojm/1pvtssSxY1YUWVWv7CENo=;
        b=N7B/U06PP81wHR6lFy3FTQ/u8XnYqkS0AYstN3qvNtE814whqHcR4AaL03Yc6Qe8Lg
         yXywsDuzJfmXk5ZFRyOvvd3cyh8h8CTgwcDNVnibGuzQRHiP+PA/tHV8M4jBYL41qum4
         zbocjVVT5RGCojWOKHHMG5pMaLPMnl9L1fVxZDENNyyvMFskLtz2//85wfBAq0oscwvy
         +PeKO4pRnsjGRgWx+vhdLtam7napZt0PAA+Thhab35zEbh2MMYBbWV0Jux9A3ewm9yM8
         VQGAk12Nhv4+Qh66+qpR1+vcz72NP0Oebof3a/Ue7xip2pxoF9choi9NxtqahPWT9ceX
         fIBA==
X-Forwarded-Encrypted: i=1; AHgh+RowF/61Y5VHnFDRF5qqbhK+ChEttTc+Z8s9axLl6uJ91ebTN3S2HSOXzairFl2gZWFluJGExMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vDvkew2Ze6Y5ZKgY+Qii5VAFd/R2s0IzophB4kJsVWjdMDBO
	u8HNsgCFUkaeEhBsEjm56jJ5JK+RAEWwQx+bqxqvzL8HEB4rnYQicwp5LBkY2NqocztO8q97zg1
	ZXC5mkKqi8Q==
X-Gm-Gg: AR+sD11JaRDdX2FtyIvABLHXDXFMVcK3xE19j2h3hmHwEj7pIqBCcyagp061yUsXxIp
	6xeWj5bJ90/WBM+QxjE++Muzk6fhjikaPwJ0mJ9nwglEXOJS2OHSYoy4oEWGltwloDXnmJlqnO5
	xsj2ekH9vixl+XgwwCXSXcG+m5Z0GopwnW1DalMwQrjVrh+SjUo+Gtv+rn2uHZBlrHtoj8uY0HC
	CYb/X3bxP3Yodje5mgNm4iAiHdzvbzwSDBpPnU4lWwgLT0bOaE9U43sE10BQKHpwGo4f7cyA+HS
	+WWFPO+UeQbwhC2BtUYe5/fKJYm+fqAnAhVvpSbYXb0WBcnsTBTWfz9ccG2M62q5NZ4iuE8vFqJ
	joP1RUdVLekNjRf+crytnjET2JArIfMIgxWQ/w5226LTny/CmNGsPxuNA+bcA0PaID9CVheAxe3
	JsFQK14ZEOsPiIaM/pEYCYwC+sxLNUtfNF6hrWpn5jIH1NAWUivjDBEAuzPO6d1R3eAjZXkeesz
	H5Crk5vmXYxr/aQ+jUG+RGnBgtjv+6RB8AY+A==
X-Received: by 2002:a05:6402:1cd0:b0:6a0:a644:355e with SMTP id 4fb4d7f45d1cf-6a14f0a1306mr3049a12.2.1785858902950;
        Tue, 04 Aug 2026 08:55:02 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a145c2a6fdsm289172a12.1.2026.08.04.08.55.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 08:55:01 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c26d7e951so10314966b.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 08:55:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RocVFeVaAfk9EiiFAg04+okeFUSBEUYJh2y2NBlvC2b4gZSRV4l+rH4BPYsHhSmmDlZ5dQIiPE=@vger.kernel.org
X-Received: by 2002:a17:906:5ace:b0:c15:a487:3482 with SMTP id
 a640c23a62f3a-c1fe7efc4bemr980444666b.21.1785858901284; Tue, 04 Aug 2026
 08:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804003708.49830-1-luto@kernel.org> <0adaae9e-7086-4213-811e-ba6e4181e145@kernel.org>
In-Reply-To: <0adaae9e-7086-4213-811e-ba6e4181e145@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Aug 2026 08:54:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiO8NDCyBYrDMpjh8zMKnzgD2XuPYo0nk4Hwgq44R_jKg@mail.gmail.com>
X-Gm-Features: AUfX_myhVk8FsTTBsauy1SMj6wBQHUdARrPzjNn3Fs3t9DNtnJgmwbJSdme97Ag
Message-ID: <CAHk-=wiO8NDCyBYrDMpjh8zMKnzgD2XuPYo0nk4Hwgq44R_jKg@mail.gmail.com>
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: luto@kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Aug 2026 at 02:49, Vlastimil Babka (SUSE) <vbabka@kernel.org> wrote:
>
> +Cc Linus for nerd sniping purposes

I don't know what to say - the patch looks obviously correct to me,
and I certainly can't disagree with the verbiage in the commit message
either.

The fact that the current code looks to be *so* broken makes me a bit
nervous that there's something subtle going on, but I *think* it's all
just a very non-subtle bug and it just happens to work because the
whole zap code typically uses the mmu_gather infrastructure and other
things end up resulting in the tlb being flushed regardless. But
that's just me waving my hands so wildly that I think I had lift-off
for a moment.

                Linus
