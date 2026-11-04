Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802758;
	b=v/G8x3A95sMONVBeFajJWERbDTnIJEYMD61V4exjy61LCXDefudX1JCjgoUALXYO8t1n
	 0U/zIOGcI7I4Z7DWHsR/j8XoT7nijW2ndh+fXZ647xmnqXJKGfdOtT4GqQ4RhoqbkLiU5
	 OoWlW1qGeZmoZ+m4qWkKMjO9N2xaFv7UVMWuyOJ3SvTgBAFeibMZC4vnmObkNWBnjRFnB
	 6cee6XvN64WIbhbElRZAx71VvlbjSVKt12fmlYO/svYPEWA3HkhK3p0W9Oe7mySseM/HS
	 HPPzpCsi+rQ10JDOoGjs+SgXXQnBNG8KNlmaeizCJgnhNPYQvN4TjEeReKbFSvMmhog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References;
	bh=nQeS5Lk1UtDT47XmIqhRscqhps77QOPDmfqkTQTRxLI=;
	b=nf8s/vSTpT9Vnr73j/jwdCHvGz4BgnIZyUY4ROBLK2PISLJ5Vkz2+Aw80QxpDbyy3nx+
	 DWmUE23YdK9EHYixZyw+e7x2OXD6z2aCrHvcgvoRTYcEME1XIJlr1dZtMKi2piMn1eLvr
	 1wmHPR5oYmx44Dd4uxi0j5VhRWv0STh+Gfm3vlVkNhfayeStA3LfOiERB1vBd4wRR1dEG
	 kOnFPaz7M5MilvGEbSsk5ayYaXLbqbeXSEWRLj0dqHxezqJbSyMBPQNNtv3zwPRr5AwKs
	 xyHKM/llv93bAruBIuNJp2IHcZzc5xquBsKdi/JSgc7yHZ3j9hsd7yr/Ydn5LUoxamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=OTR1z4e2;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6F606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEE6F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=OTR1z4e2
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso453530137.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802757; x=1794407557; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nQeS5Lk1UtDT47XmIqhRscqhps77QOPDmfqkTQTRxLI=;
        b=OTR1z4e2AwCztFdqQd6BoNhDjxmHadtCoFYWTP7LvndSreX3RnlfONzVj0EVlzzVBj
         8ecbxElNhPWGbxEkNiwkvxC+6vViqqZ5RSgaJBgxENvGI9SoZLa8vovYIyre1CjJ3LY9
         SpwbpPlhI/UrCeLGXvQwmP0Rf/2CUSD6p1JD1zs86OB3l8F0JLAdodCl9QsK537oNMNF
         xEqZXjJH1GA5hrI4WyOF9yrExDpzBec68yf+YjPE4onHIAg/2BJ5TmGLOhnU4aXxm7A3
         2ydfdeuaxx8Igp7zmzteduuL26H8TxMpWvm39cCZkUng2TkwCbZuGU5xJ/HPzPIZvKOm
         MTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802757; x=1794407557;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQeS5Lk1UtDT47XmIqhRscqhps77QOPDmfqkTQTRxLI=;
        b=Uhmo5UVbPEvggKznF08p36epi5xFQMEllu7gxBVaCLLrkWludCnq3hCobMxuzT1qIb
         rr5EmbCHYslPVm4BIneKC9XMse/Dc8Db3Zo02qFinqbXXvMn0J5lv3wmVlO3GiKy1DVw
         omKJ4woxnHqXO6I3kHH+y2aXtF3TOToEIMAiIiv0FQ9+nCP6J7iit2RAGmV0vEUAXg7F
         YIdLwIPlrqZJIjr0d2+uX5Fhhb9K3UP4MLxEleKqwrspeMkpHuH1LQktx5iZ+Tstsi0x
         SJgD+A8s9Pyu84NhexYB4NNqghTjJ452xc/KvVRKkejnz1+9Y4sqEXigwsLZuWEzhBb8
         L9ww==
X-Forwarded-Encrypted: i=1; AKwUvBxij0APZdacoS7FQta4lqtAAOqVjNYwhWqd38Na/tScafWz8YFRpbG7popqpWLgWoOEHjhy3M8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mEgVC7k2Nk7I1My8e6pHU6QGbEcHoC0batCY8YxBd6/vkZRkY
	gny4XjOeo9cqw0wx2SSLlcwUhORbVMGMMnM5nVvGuRYDj7SVUvEyG6RnQPiZFXnajSE=
X-Gm-Gg: AYBFou30bD4jlRT/xCZIwNVlfL10pma84dxdRO9Kgh6CubIytzkVKP7Rvo1H2GXWNbq
	LDL/PLellej+Z1nRT2S2NPQjxo63CdheFHdGfdoxjQq61Rs5U6m9c6b1ubZpQaOmNcCoky/yxT6
	H8SQltXn3V2xv0UkyyNvhUz9ITWEbjSQhjpcYZB/dcd9n8i2jCo8pS/YImeTqKWSenbyC2co7Z/
	4mhnYnLkU+48PEELAWjGLXLadmMOwd34pSu6C/1s9kIri/9G2fAcc9xWMSGd3ERYQOEtm/5xOLR
	Eu6UVb87EDGYRPtwjI5V5rJYPtukiT7eb860NBkbH3oPaWYvVtWXpnB5DZYdqCg2eX26qiKRJoG
	pA7mkAiaCCuzAhJMKFjD4YwTEOHlDsAsd0tmIat1dcPcWC7WZYY7FfvXzIXr5roKmWqlkrhjYLI
	LczgE41+Sx3vTvyIMNkshXJz+p83MVvBsxmwHK0z2j7imIRtGTQOB39anGoIrL0cMvJL6IDE1j8
	05tLgrE0OAFC+grW0JrLBpSqArtku8sjrGKntmrQuvgGkQ/FlREibTvCISy8lT8tNrhBR8n/5Tr
	O6KY6oCizzND+iLbcF44mGFm/Ocaz8c=
X-Received: by 2002:a05:6102:6107:20b0:7d2:7be1:271f with SMTP id ada2fe7eead31-7d27be12fabmr472050137.31.1793802756625;
        Wed, 04 Nov 2026 06:32:36 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e75b24asm20104976d6.39.2026.11.04.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:32:36 -0800 (PST)
Date: Wed, 04 Nov 2026 14:32:35 +0000
Message-ID: <d2efe4f22fe0ed9390e4d9224b81d78f.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
    "Liam R. Howlett" <liam@infradead.org>,
    David Hildenbrand <david@kernel.org>,
    Vlastimil Babka <vbabka@kernel.org>,
    Jann Horn <jannh@google.com>,
    Pedro Falcato <pfalcato@suse.de>,
    Muchun Song <muchun.song@linux.dev>,
    Oscar Salvador <osalvador@suse.de>,
    "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
    linux-mm@kvack.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm/mremap: fix accounting on a partial move
In-Reply-To: <20261102162304.c3585fc3fb88644118c152d7@linux-foundation.org>
References: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com> <20261102162304.c3585fc3fb88644118c152d7@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

On Mon, Nov 02, 2026 at 04:23:04PM -0800, Andrew Morton wrote:
> So we have two userspace-visible accounting fixups: htlb reservation
> leak, Committed_AS if mremap's unmap failed.  Yes?

Yes, though the Committed_AS part is two bugs, patch 3 charges memory
that was never accounted and patch 4 loses the charge for the whole VMA.

The text you quoted is the v1 cover, which I kept below the changelog.
The "last patch" it talks about is dropped in v2, so only hugetlb splits
ahead of the move now.

> How come the first is cc:stable and the second is not?

The reservation leak happens on any partial move of a private hugetlb
mapping, nothing has to go wrong, and the huge pages stay reserved after
the process exits.

The Committed_AS bugs need an allocation to fail during the unmap at the
end of the move.  mremap() checks the map count and sealing before it
gets there, so what's left is small GFP_KERNEL allocations, which in
practice means a process that is already being OOM killed.  I only hit
it with fault injection, so I left those with just Fixes and let the
stable folks decide. If you want them cc'ed it's no problem to add.
Thanks,

Josef
