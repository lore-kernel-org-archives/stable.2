Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900274;
	b=qadPzMI2TsGBO65IjuBsdBKRj6qWN73uD4J42hMxQmN9ncImhUnA3RhvzW3kC+14h5wn
	 ttSRS1ARTtc2HH8HuFm/KlYLSHSWDKYCTE+ty/TaJOXWANoFx35+OFr/bpPT1NHOvpAAp
	 icTZlKfgUF8hrtpfYdg7jtrT1gq2axPfxKyaKTJIUSlAd55VSbhDKMclyIsh83Y8aUiH8
	 sy07gKuhedfuNiclCApydvUa8R+HnHsejKKkd+F7Cgkxmh4yl7Ye4LF1RV7yEHhkcOhKq
	 DNSw+QoYKqG/nqJ+BmqBQ8RalhjmOQgldSGlASHET8mk57Mv24ilFjVaZ+eOz6n4vbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I/9VHkQVwisO5bupjKzX692XjiMS3IZKTYKgohOq9P0=;
	b=JqkevvAUx68td29GlLadDUtF9I5G/+SKi0ix1CpDLSfPxKjbyQ4qbFMI6woEhx+kls4a
	 DgxSfWCiykkJeGMV9vhXv76uUzWIGhX4+U+6Yn9kCSYBPkGZuRPqFqD39XusE1SbhkT3Y
	 XpepbzR1fQnXhEhO+qGwOKsubuyDfLUkeGlD/TqeAmhgqeSeU6SpAhMDOHRWdGpAv4Q8a
	 Trt5BVeBehZu3klPxZgSNjBcvVDS1u2MDdGxzRpKZNsdpF3jozM/nL9P1h2C2xmNOPWNq
	 wzGnVZxEWjRdA6Mih+3EhwhdHaI0/NkD1L2/34qlgH+XzyKo6YatFa5seTQ2e4gJx+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtW9JhWR;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553D606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0553D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtW9JhWR
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3512019a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900272; x=1794505072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I/9VHkQVwisO5bupjKzX692XjiMS3IZKTYKgohOq9P0=;
        b=rtW9JhWRKUehWAWBFJ67ewxZw5Sq5AhUkrmHEUH3E9xFpX2UZZEkcUkuiY0OXLiVso
         OvhBRgL2naJls/kePq+fHAMp05e7EuLmEzNHdMXYWf5cl26qeQMstIAAPpfohQ/tyLJK
         D2A9ITOnDfhb0hFaf3UvqqlV+4z7c5VzqSnG0HfJVhc1/2Yl5EovgXB3OeVnUKU8XXAQ
         9JJWaB5U4MlNr5hYUDqG5E6avjxl/dPr6VvsorTfUQ2QXiqULLgByCg3l6m7ywbSUQqT
         mAIyuL3AnkcP+4Mr1vkl4PPOwa4aIGT6i2Pqt9Jgyi0/bL+ZVNDMO4AXbGfBqgbjwRA0
         LhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900272; x=1794505072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/9VHkQVwisO5bupjKzX692XjiMS3IZKTYKgohOq9P0=;
        b=yFPupkOOMJUb0W1jfETU0XDRPDArTNu9GZT2vkCL0bE1ldj6UN/yk2qWIqL+7xf+gc
         1CVZZvKOxTBWd7uX9yqX+Iu434lQcpZ6i/SRmdnJDl8LmvHBjuhjree9PDoTPb04jzs5
         3cpep8uoQYVElHiHJ7/CiMYHkoZuxMZ/bSDex7PLkPMg8W9w7dJJ+gLHG//JRAfciBj3
         gYFHg35j0OY27yrpQKUArtVix5WXxl45pr/5V8dReQ7Sjc6NIO6anyiNtwm7vIS7UkuN
         fJjAVGjpAXYDn+4ytE9dx3pexLTlT65UY/MOWy1sEDpDUhnY4KNSubV6Y4Tiv/Qs8Gbu
         D5nQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3pRaqV4CAzcNIdmY54ImG+irRRqHmhh3ntIpVijV5XCYKT+xsJuxuWqE4c3LPPoGEafghKfo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6s+JLN3vZvHlgiPsQXYCCPIJHKeB/rHBPEiD2XqhBk0GLcj2U
	3wOs2WTieeLOsNtAja7KY+XD7Txfl8RrsYJKzr02fTth7MQTEaFjRABc
X-Gm-Gg: AYBFou2VgkeS7I/nMyVyO/LkeT7aTR/kq7GVHPP806rHtBxhQH3O+8GqascykVHPwpF
	2AAo+k+AV/bzc26vpmDi9ESdCC7loBUrUAMjKK+mB3mkHOEaBeAo6ps64GTXLsbrkbYkrv20awG
	TX7RXhpweBnEeMVYQ5KxEIlQID/aLBsC/KYtGb27BP0RGU34JSvQETInDxMs4pDlM1A4DQGbNKz
	/rF7UpwY2Gh60skh4q0eM2SHc8vWMpN4mk118RaL+A2nFCiAJVf3PFmCfCpzvoZQcSBgFLRxqLA
	c6FnAZTpXthlmMUI/7k/a8fBVLsaL6XfSZe4RbUe7azfsMmx8Oad5L1Cv+6rw9jjvjyUzGaM9tJ
	zVHBG4zNsu4Y/Xe5/tpaEfVWZtwIqFtSv6hJJ1lZe8QMfMz1tkneRRTi63PM6f+6Gu4JoKT/vby
	7k702ARAMrP6KSWFYzBwvtxSnGfuAx4Im9zqQz0c73PxN4pzIZKmuCRe562PzwswDQezGOP7AD1
	D9OX48XGUx44+JdTgYZ9981LJBqi771bYLgiFcNnKETmCz18b2Y9JLRhg/zWkFngCt4
X-Received: by 2002:aa7:d281:0:b0:6b5:916f:938c with SMTP id 4fb4d7f45d1cf-6b5916f94c8mr459489a12.41.1793900272060;
        Thu, 05 Nov 2026 09:37:52 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5876145a9sm494548a12.36.2026.11.05.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:37:51 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 5 Nov 2026 18:37:49 +0100
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>,
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
Message-ID: <auy-7TvVzJ-VCrG4@milan>
References: <auaFhOa5EBz4gJwK@gondor.apana.org.au>
 <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au>
 <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
 <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au>
 <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au>
 <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
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
In-Reply-To: <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>

On Thu, Nov 05, 2026 at 08:22:52AM -0800, Linus Torvalds wrote:
> On Thu, 5 Nov 2026 at 00:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Wed, Nov 04, 2026 at 12:11:24PM +0100, Uladzislau Rezki wrote:
> > >
> > > There are users in kernel. For example:
> >
> > Thanks for the list.
> >
> > > drivers/GPU
> > >     /* Allocate the file in vmalloc memory, it's likely to be big */
> > >     iter.start = __vmalloc(file_size, GFP_NOWAIT);
> > >
> > > AMD-GPU:
> > >     kvzalloc(size, GFP_NOWAIT);
> > >     kvzalloc_objs(struct amdgpu_coredump_ring, GFP_NOWAIT);
> > >     kvzalloc(ring->ring_size, GFP_NOWAIT);
> >
> > These appear to be executing out of process context without spin
> > locks so they're not really GFP_ATOMIC.
> 
> Historically, GFP_ATOMIC and GFP_NOWAIT have been largely the same
> except for GFP_ATOMIC eating into reserves.
> 
> But I wonder if we might be able to soften that a bit, or add a new
> form, because it looks like the AMD-GPU case at least doesn't really
> care about any kind of "don't sleep", what it really just wants is an
> "optimistic allocation" - try to get the memory, but don't spend
> effort on freeing things if there is not enough memort.
> 
> The AMD code in question literally has a comment that says
> 
>         /* Dump ring content if memory allocation succeeds. */
> 
> so while it's possible that it has some atomicity requirements, it
> doesn't look that way to me from a very quick look.
> 
> The etnaviv case looks to be the exact same thing: it is definitely
> called in normal process context (that code takes a mutex lock around
> it all).
> 
> So those two cases really don't looke like they are about "atomicity" at all.
> 
> > > net/ipv4/udp.c:
> > >     err = bpf_iter_udp_realloc_batch(iter, batch_sks, GFP_NOWAIT);
> >
> > This looks buggy in exactly the same way as rhashtable.  It's
> > called under spin_lock_bh, and the same lock can be taken on
> > the softirq path on another CPU.
> 
> Yeah, that case is definitely actually atomic and holds a lock. Not great.
> 
> Is there any way to limit the vmalloc() case to the actuall atomic one
> and just fail when it needs to busy-wait?
>
Probably it is not easy. vmalloc() takes several locks including
during page-table setup.

Probably the simplest option is to return NULL for non-blocking vmalloc()
allocations when BH are disabled. That would address the reported
rhashtable deadlock.

--
Uladzislau Rezki
