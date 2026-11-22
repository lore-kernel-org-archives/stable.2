Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363071;
	b=wP9+T2qO0KE7fjMo4Hi43paZnqJ+mCWSjusLPsWgfjb15paEVT9LteIuMjhlg5IYLKCQ
	 M6F6kV9O8LMyZzlFamfw8l27iIgXHm2eJzIW2LwJkNF2a00mp1rQUZPo3F39A5bG8P/0t
	 bW5PHRmf1opx1YSi7OsrdnKrVw9vr+kptKOholPj6ypIL4o8YhFI/937A9fl2dF+xVfQr
	 ZN1UxC7LZBGrs7vSq9US4L/poalCveIAr45FsXA5kiX02e4M3/4wxuZbMSfxI10x8sVJI
	 XFLz5UT7iVnk+ZXbecjsdhPVtaSxVzGNPhwoH4N4oFua16NRBRFr9BqRKK00cqzBCrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=NcHYZCZqGjruQWjTBcuHdUshGK9b343QactbdxqWzZY=;
	b=JMM55WneGhlpaAQBTh36KqaLcXVJJZONUe7du/cAJi4EMdLsz8sTafYiDHWyZIt8+1ne
	 BlievGdsKN6KU9G+ygQGurBSRK+J3uhp7G84tBQquCeNlTu1dRNT8TvFVkqqPQBmzNGnt
	 CVVTlLdh9MX1wuuPHnGVdHWxGQ1gHNJ0KaLP62/Puc83Ers3nanDlNxfDtR5+cCdMQ0lU
	 dhLKDOk/7VYJ+8YLLcCLtWICAo8wdpRa35vCmVdDxd9Z6vLQR3HxUSO8anlThgXT/zgpM
	 YicP5JUzyxSje9mUWozvtQ2mrOLqeeK7lS+5VdRbZZrbTtIJjX6c8/6rD9+zh9bQvog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gZdD4iL+;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF4606A334
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBF4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gZdD4iL+
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55d30c054dfso29275781cf.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795363070; x=1795967870; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NcHYZCZqGjruQWjTBcuHdUshGK9b343QactbdxqWzZY=;
        b=gZdD4iL+abU4Mzjip+DJfEODgFHTCI/oDFfGXiCuj+fb+jKPYGI7fU5Sgn3OKHWLSl
         ragXJYpVwBDZStr52fuNAfmohtbdaYsnhDoCIr/svjFRJmIZCHi7Ru9d9vydEd0toqAn
         baTWTeB4acxxU3VXc0uEggLWh7HP+yqJ0s7U6ti7RR0836GImvv8X0OI/kYP8lePzEZC
         eehrQTypywKuGGgubg1kVEYsCcDER6mFlkdH8Pcm20SYXQiJ2OiXC5CxWfiFgOlE/k8f
         36xw0sAzSMKFNHofS1VHHizRRyysI5G6OKgYUYuD+fql9l8VwKW4DPFqanR9y2RUtV2M
         c+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795363070; x=1795967870;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcHYZCZqGjruQWjTBcuHdUshGK9b343QactbdxqWzZY=;
        b=vG1BOtvpIGsO0NQDCtXTmczCajXnVdvpyWOdzieH6evEOa5E0fWy5YPi7esVnsvEI/
         b9sVG7BU3anTn2ZAHojmBpZag5Xkp/wAkTG8Ecf9TU9cRZd2lidOuefEav0w026/S69i
         Q9jwLtTH8iZUxxzW6VSZt3DpxaR5ISPlETHlTn8Lqeo3aOMmQAvjnJGvZqZdEVbh2cTS
         sMW9frykgGMjopP8sjjBMM5wuF4KKivxl0ds+YAgZM+ZxQKdwp29SkSnbEcM15pJVXLl
         QECIiV5L9Wvx+6DsCy0CMQSaV2QD8Yh0sgx8pgUHp7Te+qtw/1gZkP4ZTm6IMOocYCt5
         kJSA==
X-Forwarded-Encrypted: i=1; AL+hErH5hT4a+6TdNJLXiZe++ql9B2tDfl1S9uo5CYVqRGkqszI1xsgtZyqM7szPrCAZmYicQh1cG00=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ShEQfdgf8RFNzg6gIPC+q+vLCQou9Wj4O+cMKW7X3IwMl4jIz
	Jq6cZlPrIVoTGHHeyMWlQRCsPN0kATpJ8eZCwp0p8Sz495i6AWa9yH+uQ/1wZgDkips=
X-Gm-Gg: AZFdTZfJ9S96TNT/YoNpNTTcTxxEByrB/mzoSrlvFrc1WYRBUaKMQkpDoA0/z82CgZG
	jS/BzkXMVSg25ByzBKGeY+0vCvJ3p6rixSKGaG9Fv4JSAcBl7hXecsnLgBUH6hnxOFVhktvt6ZI
	9DF4pr6jZPaAdOG9t0nLYimOwKABp84h8OsmKYeIMVIig5Igteio61DPfXKLrmUCKf2/10AOrQm
	kN7O35f/MVsRv4HqglQXV35iQfm1VQs3s+SjIanq6a67638Dx5JjNP0vhBOBTfzwUTGDNpbCthB
	rc5EX79YAcrvEDYl0jH5JQvpe/Wql/7wacrMZs4xCgkUcdy1HJtRVTbFKlQYU1KLrtOCexDtGYu
	x9nDzr00iFfapV8d1Yqgz2l3QBUwKl6vIxladjTsC7IeXdnEDMQ+hSd6gQyt/6Bp8oZYa/qOtU5
	uyzjecdINPXg4aZJmcMFChQTLSt0HynxbfiX++QpvCNYLxyYXAa9kWBeVrs1FH6rpgR294Yztb0
	k6dtHcFZjYd9i0Wx0hidv4tDVvxExbNgQ9zN2e/Q55/CM4pZkdV3SgojQXnMH7X+aEg9DowRw7k
	CLxcQ05GARjFxlA+1TjkhTkPh1WXh99dDEVq5SI9KPSxexEEtg++J5FFhiqrUPM8fSIeGnHjjhf
	qJJQ1Mf8=
X-Received: by 2002:a05:622a:1aa2:b0:536:719d:7974 with SMTP id d75a77b69052e-55d76a5212cmr163702871cf.55.1795363070036;
        Sun, 22 Nov 2026 07:57:50 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7887bec2sm76958671cf.22.2026.11.22.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:57:49 -0800 (PST)
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
Subject: Re: [PATCH 0/7] mm: reworked AI-generated VMA and mremap fixes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
Date: Sun, 22 Nov 2026 10:57:48 -0500
Message-Id: <179536306892.412063.18259419201274512281.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-21 16:02 +0000, Lorenzo Stoakes (ARM) wrote:
> I have reordered the patches here by priority, David - the first 2 should
> be prioritised as hotfixes, the rest can go in 7.5:
> 
> == Critical ==
> 
> 1. unmapped_area_topdown() invalid bounds - possible memory corruption,
>    triggerable by any local user.
> 2. Lock VMAs before mm_all_locks_mutex - system-wide unkillable hang,
>    triggerable by a local user with FUSE.
> 
> == Need fixing ==
> 
> 3. KSM unmerge only interrupted by fatal signal - silent data loss on
>    mremap() of KSM memory.
> 4. Uncharge after failed stack relocation - strict overcommit limit
>    defeated system-wide.
> 5. mmap() offset limits on mremap() expansion - invalid file offset
>    reaches the DAX fault handler.
> 
> == Hardening (no need for Cc: stable) ==
> 
> 6. Guard gaps on in-place mremap() expansion.
> 7. Non-executable brk mappings under MDWE.
> 
> As usual, please go through and check these carefully for correctness,
> sanity.
> 
> Note that one of the original patches was punted over to the BPF
> guys ([0]), as it doesn't feel that it'd make sense to change core mm to
> address it.
> 
> [0]:https://lore.kernel.org/all/awGZWsCp6v63H_py@gremlin/
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Was able to reproduce every issue and validate the fix.

Not sure I agree with your assessment of NX brk mappings not needing
stable, that's a pretty bad bug in my opinion.

-- 
~Gregory

