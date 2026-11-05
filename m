Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896258;
	b=wPrNl9LOseancUt7r+S9nXf7d4wI7gbfGeA/rO9/2JPP7mFkVStABLKZkToKeFssnMsn
	 619ozHe1MySws1onzq9Sh0oBHzD7i+kVF+jI9Z6gluOtfjvA1S+JvkPyqwL7TyzMq1495
	 jMvFwsrtAMXB53Z6R7/INyC681fFMjawdM8/keeKSl1ONgvCxu7SMiLauYxVbI5m2MMMN
	 gjUtYdcQ7Le9QmTMnZODkQJc2/I+FrrybTOdO/xm3UGurbvD2fr4cxZf6Br0jZbWTG6EV
	 OHN6lnRLmm6y8ogn41XkXoWM1g7dtiF73WkBm8NQGKfGSnHv0wKSZOXheRnXC9cYTJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=coQkw57ZP+vtxGOFNXxyJOYi0uTeh1KAeZgHd3m+lMA=;
	b=d7eLjzLUYZC0CBcd2GeLqhqCluFa3iR5g5KyGriz6LLzpccPAVoO92JWXdSWVWfNfHwP
	 Ru+O/YfhaVTK3XWsV0LTt/hlnxQoeYJQ8ChvMTp73i+Nyp5wc6EPsU72DaGilla0CK+se
	 mqSdMDLjce8/x3UCEekwzL4H6/KvbCHOpGX4q1p0RLQFuhMWLtXEUgOnhIjB/aIl6hae6
	 ySxMfYwCmKHJUScL6dpvLhWUgBzW7BVpYPGRyYoj/4zZP9LXU3JlKb8TdvbpSNBqbYBze
	 kRyfuHvx0rd1qs3FdHNLwSgC+VsqckxGzOtWaoOZ6TdHX32B+R3L0WfE7Lt809gjTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC66082BD1
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63AC66082BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4395d31228so344321966b.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793896256; x=1794501056; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=coQkw57ZP+vtxGOFNXxyJOYi0uTeh1KAeZgHd3m+lMA=;
        b=CD3Ttqf5zszqcjbxN8Xi3b1rXPhnPDw1fk3SypfzXbAaBeopoNnRx4zkNF9vtOl9H+
         foS8qfQn2ixtP3C9SmubaEL/td0XgU0ixSgsM6jBJZyw1HoUVjtpV3XAdI7/fDxbCtCA
         cAEgXGT6aaseqk36oCrkbqdIieqCFWmK2H0fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896256; x=1794501056;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=coQkw57ZP+vtxGOFNXxyJOYi0uTeh1KAeZgHd3m+lMA=;
        b=kTiNoIZRp/X5d5yaDnqIB/9awPFFXuFlvsE3dGyigPH8s+1SaljBSMsydYTBNKYW5s
         E9h4btcgHe8Lq8rvYc0RKY7WPcED+vZk3JRUko5v9ae8MtAZARvlmkNYIatpkZsNbpOY
         /I+7SAPakKTuNZyvnjBQ8HkGfgiaRAkOMU/x4qdGUjHlaJIRbg13NhBzVxaTFFHDWsad
         XNCEe0tnfjqv/PVx7faQY2V0NgS3VBllz5s40XB+nF1629GebuzlOrSQkBEycO6pGeWs
         aAKnawme/Qtlm3h/ezpkoYxlQfmQc7MEhU3+Ci5ZbFnQ95IfJWNtbEK3LtZhWLJwPBfl
         075Q==
X-Forwarded-Encrypted: i=1; AKwUvBwVYjVhYaiQsFLJxbvIr5Q+LfbbnaI8PQQa5OEa44AtClCU+tJvx+Telp29MC88JofY+PdnSUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nDzaLyU96RTPoeXOib8wYDe/CtT3SayCiALZI/Ys4R8y2Ey5K
	xgHHn5hESJe4fnx4JNYAzARz8OfJ3SQ8TWB7Ej/ccYVJrrf8GSA2pMRK/80kdNISvY4sZDhyH6l
	gVFeFDPc=
X-Gm-Gg: AYBFou1CCqW46R4AeCp7sdAbqGAC/k17HWQFBsbbT5mZCAC2vjRwRxJMWeW+5iu2lib
	J4f1VpU6BQsS/H8fc/TT/bX0oddkvjwboziQtlU8zPg4RVBAHccTftlg06/7EVvH+FTXLsvlH0b
	if42l5FAO51To/OrGNIIG6R0QZN/ZbOqM1TzgVpFE9cj7PbLzZc8C5yX/u0+QRt0Y4PkCl1GS3t
	63k2/b4zpBLk+FLIliUw7OSMtvnmVU/mADoY5J2Jn7+17C0AkZEhNJwMEz5nJez5pHpLtDMK85B
	mn3D4JYhG8TO6cRQjxZr/aNpahCnpjrWKmNVnRLp+r8HfhuFgD6J1iYr8nRu+E1x/PmLaFJ44Qn
	nFRA5Zp9OWl41TbG9WjLqupL7s/osa0aQOMxZWkbBWgC7cH3mpPMbMEkC9NHyiTrgpLA5Rq0tHY
	MaWUmJQFB5GqLQRJXOBnp3mElG7y52bout6XrLXVTyy0n3gryTb7G7xCYq/StXICbDqisqvBajD
	wRJBuS3mPd8qGlWD+DlbDZB1QocUAtbIrRaahZEDzqZyvx3BHVyXN0yVhSsIKyWzr6mYF8gBq/Q
	elMKE+kJqKjpQig1Yp3bV7ri1UOIBn5BiK3q1CUwhtS8hkL9afF6AlV3djxD8YGN+WL9nZVDhsW
	MUA==
X-Received: by 2002:a17:907:60d0:b0:c35:babe:ab44 with SMTP id a640c23a62f3a-c4d34efdb7amr5275266b.0.1793896255687;
        Thu, 05 Nov 2026 08:30:55 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e495f70sm187272166b.76.2026.11.05.08.30.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:30:54 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso332679166b.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxF0SayE/aNaElEavvXFEbUp6Z+oCtfqpbFcrXwEPfoHuAvSBq0JnGWZH7r7xOZJiHWR3cA+28=@vger.kernel.org
X-Received: by 2002:a05:6402:3899:b0:6b5:76b9:5040 with SMTP id
 4fb4d7f45d1cf-6b576b95165mr2666079a12.41.1793895788549; Thu, 05 Nov 2026
 08:23:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>
 <urkgmijyytg3rrislm5fdzmfggqavzpiry23f6lpkqonvy2tqx@d56stj3eixfa>
 <auaFhOa5EBz4gJwK@gondor.apana.org.au> <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au> <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au> <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au> <ausS3LQNkdc6lBy3@milan> <auxDm_YO4oACA_d2@gondor.apana.org.au>
In-Reply-To: <auxDm_YO4oACA_d2@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2026 08:22:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
X-Gm-Features: AclHuK_lYzOySVnPMTXkh-HXGHC850mf9gNJxZLEPPhkqoVD1gRX0QozBFysw7g
Message-ID: <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett (Google)" <liam@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Chris Mason <mason@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 00:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Nov 04, 2026 at 12:11:24PM +0100, Uladzislau Rezki wrote:
> >
> > There are users in kernel. For example:
>
> Thanks for the list.
>
> > drivers/GPU
> >     /* Allocate the file in vmalloc memory, it's likely to be big */
> >     iter.start = __vmalloc(file_size, GFP_NOWAIT);
> >
> > AMD-GPU:
> >     kvzalloc(size, GFP_NOWAIT);
> >     kvzalloc_objs(struct amdgpu_coredump_ring, GFP_NOWAIT);
> >     kvzalloc(ring->ring_size, GFP_NOWAIT);
>
> These appear to be executing out of process context without spin
> locks so they're not really GFP_ATOMIC.

Historically, GFP_ATOMIC and GFP_NOWAIT have been largely the same
except for GFP_ATOMIC eating into reserves.

But I wonder if we might be able to soften that a bit, or add a new
form, because it looks like the AMD-GPU case at least doesn't really
care about any kind of "don't sleep", what it really just wants is an
"optimistic allocation" - try to get the memory, but don't spend
effort on freeing things if there is not enough memort.

The AMD code in question literally has a comment that says

        /* Dump ring content if memory allocation succeeds. */

so while it's possible that it has some atomicity requirements, it
doesn't look that way to me from a very quick look.

The etnaviv case looks to be the exact same thing: it is definitely
called in normal process context (that code takes a mutex lock around
it all).

So those two cases really don't looke like they are about "atomicity" at all.

> > net/ipv4/udp.c:
> >     err = bpf_iter_udp_realloc_batch(iter, batch_sks, GFP_NOWAIT);
>
> This looks buggy in exactly the same way as rhashtable.  It's
> called under spin_lock_bh, and the same lock can be taken on
> the softirq path on another CPU.

Yeah, that case is definitely actually atomic and holds a lock. Not great.

Is there any way to limit the vmalloc() case to the actuall atomic one
and just fail when it needs to busy-wait?

               Linus
