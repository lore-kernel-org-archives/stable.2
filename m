Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664104;
	b=RAAUf33QIYeORx+u6zbEPvVg70IZ22q9I3trC+pl+8bBjHEsS2Cgvnjfchq6odAOG6hC
	 LDgtDIiNpZjjJk/AyBejxokINCpIiQjuTFC1dWCl65ZHLEWjCnuH6ZAhwiDI+GxxtzPk8
	 JaTFt0QsHcfbO5I9Ve0iOjXhtXOrfypRP+JtsMbu3RWUfRUCkByeIAYmF4d8OZVvDbMH7
	 Gfda8TyJIWICM4Gn/AW5hSkLFqZYQrgVMOwEBqA90wPnj+3Ea+fd9sOlY0ntlSZKfusHU
	 O9z8GxaFEoynTZ1l4K781436/+q4ecKNBhsHVEYydAqOy4IdxIrNWuJlqDEp6bWxhdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sTtJShm6kz41I4Yj0S715Z77CNoUEBmcRU05Q30aoJ0=;
	b=arVjAh7iu7H7bM4jqRFor2mmbA3RkfRW5LtV98CYmp8dkO8urjC5RiaSTsQOX7WEydAo
	 YZCtINAJKYiSIof5NADPpcGCupKdcSwo0mKHCNYzv8dondQk54EEzFXT0v0Ynq6eNhacX
	 derJHbvQg3xK+FY7FXJiv9a5JMSLsp+5CX18m7kCjs09P+Kp+floBo/WnbCXtjRL46fQg
	 /PIJAomITgs1C/CQYBg85xZkA7PYfMWhHI8WhKl41OxWhrg4LephUU4ekeDiVAuXLeLAO
	 9+ASzKHIqIRzGMY9EHZg8h9SAB028SHvkpWX4QofNeJN6LE8hV7+/esT2f9eR40wNtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etPTyJVP;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED5606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ED5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etPTyJVP
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so327065966b.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794664102; x=1795268902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sTtJShm6kz41I4Yj0S715Z77CNoUEBmcRU05Q30aoJ0=;
        b=etPTyJVPFLrjxK9f/QMKnsF23AfDr/jXmoolk1SORo17Sq8JiJJprSAhxb3TefyC3F
         NZO80RATPYVbFYH0bsTolGFRPqfHJq2iVn+Gu6oSt4bpptYPrSVEtw6QiM2Gv82DZy+y
         eoikJhY1vdoIt3hxrjXffHZQtIeEmoTqelQHf/ken+3RtpQ51Pb3gA1dqcQikhsc3UuU
         QfhHRts+3OnfzcNNHQi3E1Yp/DsDvMEbi0xYalx9SplH7i/S4BooPmnyPQoRwuL5G7XR
         l73cTHmLjBW2ISqqWIIVoC5YioIvxz9HAvH6KQZAewL+FisBYEKC5uhexEy/dzZ+r4+R
         q3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794664102; x=1795268902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTtJShm6kz41I4Yj0S715Z77CNoUEBmcRU05Q30aoJ0=;
        b=M2zaYwLc8/BLqWL+OXCQHAWa9WPW2OxzkKKLbIWUVzt+DF784IoZRjj5iIGUTHYL/H
         cD8EPmz1cMZygkZEl7/Gc2v/OowuxC2WHwyOarUetip5ZHqBimcDqlbGH5tnkn+oZPgV
         GkZd4gj18Fdj6taEZ9GQb3Z76MYpd2cTs7Z9tiFF+v166F4gxthqEVrYAZH4rYEfxu0c
         3mmkyJFidCf8Y5ny721NqpL3rQKn9xt55dsrHf+exaGBVr/3blFHNtybsVVrGp4SL35j
         bwZbVPP9qtuSuo+u+KZsHkUBt9brfoazx4Gh2rY2kkHiYOaQ2pyZ32JMS5nMrH9E4BJD
         GaZA==
X-Forwarded-Encrypted: i=1; AL+hErFit+DGCtzNCLVNe52Fqk1/zVOAOtX3JzxQd+rCrkGkzUcQuGCiXOpWu2iwHnXaJKv9OJ/PxCM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9R4M8dw9UtB2aP2Srk0HNDB0fKvdtIpLJq28uLRZYbiIntUEb
	55omHPHhuuGSLH9fzvfPNzDrRizOvnIEEp1F4oL9LZftpMe4j51cDfmO
X-Gm-Gg: AYBFou2PH2fRHc+WsvG4bfJRhth/CnNQKrI5P4RDX8x0JhTm3inT8lDl+O9raJmpEbZ
	rPfD/5Qufcft/qbFZ+8QbTYWA9cWJdIs/JlON8DA5NLN/Jq4tNgQqfA69pO+xWHtLjdDLJEVBap
	s4Q/nPFiI9TJpcWWN480MFtEImxjLjla18KyP8ZgG30zctI7+D5ckXbNjENvVqnK/PGDkbyV8Hu
	xFagvuas1BZda6Mj9dXBahnj/Bg/xRtsn01dSt+hEGTkhkwZmYAuwX8UDIznMD7vnJS3VtiOTGX
	Dk0oJR9HbkvsIEaWunHqi9uldFxjw4K7A7vsMqxCwicsVx3aBmQZNGK2Clo6Y39sttck2jWI4LR
	i9y78vtNMEJLtS90t3SeoZkODxg+vkstH0JfV70Lv0gW2Ykb5fI2Ggi1EbfdVuZ+pab9BOeC/wd
	9QX1zxlry4XhEaevQfDbe3PDledZELWapGFqJgvpTk+fG312ZH6jwyDASTSwobklQjm0JTIhFKh
	Yu58j4getkK9KL5IxZkzz9wK5EIqykQoten8K3rDzxeZ5Y7eWVVGjrR9h8bwFb4jgAn4Q==
X-Received: by 2002:a17:907:3e06:b0:c50:5186:a429 with SMTP id a640c23a62f3a-c50963c2b24mr502945666b.37.1794664102098;
        Sat, 14 Nov 2026 05:48:22 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm219264066b.0.2026.11.14.05.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:48:21 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sat, 14 Nov 2026 14:48:18 +0100
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH] mm: kvmalloc: Bail if called with soft or hard IRQs
 disabled
Message-ID: <avhmosPSEJOFCvK_@milan>
References: <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
 <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au>
 <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au>
 <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
 <auy-7TvVzJ-VCrG4@milan>
 <avcKfEvln8_2a7fJ@gondor.apana.org.au>
 <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com>
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
In-Reply-To: <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com>

On Fri, Nov 13, 2026 at 09:47:13AM -0800, Linus Torvalds wrote:
> On Fri, 13 Nov 2026 at 05:03, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > OK let's try this patch:
> 
> I don't think this is wrong, but I do wonder if we should at least
> have *some* way to detect these cases and report them.
> 
> Also, it turns out that in __get_vm_area_node(), we have
> 
>         BUG_ON(in_nmi() || in_hardirq());
> 
> so this call sequence already has a *limited* test for this all. It's
> just that it explicitly allows softirqs, probably because it used that
> bogus BUG_ON() pattern, so it wasn't a debug aid, it was a "the
> machine is dead"
> 
> I wish people would stop using BUG_ON() and friends. They are *only*
> valid for things where "something bad happened, I can't recover".
> 
> That __get_vm_area_node() is not such a case. That function has a
> perfectly well-defined "what to do in case of errors". It already does
> it for lots of other cases: just return NULL.
> 
> So using BUG_ON() is wrong, wrong, WRONG. Commit 04aa71da5f35
> ("mm/vmalloc: do not trigger BUG() on BH disabled context") was simply
> not the correct thing to do.
> 
> The correct thing to do was to replace the buggy sh*t-for-brains
> BUG_ON() with the right sequence:
> 
> -       BUG_ON(in_interrupt());
> +       if (WARN_ON_ONCE(in_interrupt())
> +               return NULL;
> 
I agree with this. The vmalloc() used to BUG_ON() if in_interrupt().
The easiest is to restore the old context restriction and replace
BUG_ON() with WARN_ON_ONCE() followed by returning NULL.

That would not stop machine but would show invalid callers.
If there are no objections i can send a patch.

--
Uladzislau Rezki
