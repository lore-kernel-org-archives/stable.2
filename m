Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574999;
	b=TmRaCqa7Kjh7SIgyW28o/Ex5QrBN94J3O7Rre7mgPizL5a92Wzg9Ebt0oePL2OZQ7Fjt
	 1/cXXiH41qQAUdjpYWm5M/68FvVI/dg4FqewOGUPDv7KONnkGoPborSDG0txfrK5ms3+i
	 rxBA9YcfyADJiQkniJ6eGLqYugR1f/cHE+QIPOuxcCtMSNvx4mqIFIeNFjDshKy6BPys1
	 OzOlE4YwOknMbX6LgiIL6aIzCZoSbDwnRk8RXLx349W/+oLu1LOTu+OmnTVQHxE4Gu8mj
	 /9SR9/xedDyCjdyYEvCCWO5Tbi422w6HESEU+JH2GlpsQgpN12CMSgvFUiRG4slISng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574999;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=atdp2aydRKXMXDIBngPs3VoW6SW6B3JnVooZbiegGyo=;
	b=fiFBw4C8x4UU0QarbkD2c/lJl3Mbctesfs0x4aEku4cwFli46Yo/ZRMNAMs30HGHTRRC
	 3xlBjgogkX4/TfIRFhDa3+8iUVlHIbguyLMAI9geKzW/qi5T/ErAEnzPuo8ANED3HzkGE
	 W8gSHNh1Eihn/FwDEwo8XnJFUMcqgx+GcObc7L6Z3DK8u3me2m3s4O8EyZbtB1qSXtd3K
	 nEMABxDpacQT8mteTecTgMI0NWesKjzT3xJ8YS0NIQUBFlZTsMWo2de1s9JdEdrEdYnGR
	 nyfWONMjcZZ7waGhvTGNs6JgD0z1K87cqdzm7pzwQUoItxnC/+dTGeqO6aHeZ0jbHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gondor.apana.org.au;
	spf=pass smtp.mailfrom=gondor.apana.org.au;
	dkim=pass header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=LTM9AkCn;
	arc=none smtp.remote-ip=180.181.231.80
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC320606A323;
	Fri, 13 Nov 2026 13:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC320606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=LTM9AkCn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=atdp2aydRKXMXDIBngPs3VoW6SW6B3JnVooZbiegGyo=; 
	b=LTM9AkCnC6t33+hNMotrxV1KakbzcP9xVuiib1rfU38aLSyOpkPkovxRZnCfqm0C9y8wd++cDSA
	r8x+EnfFoHib35KD7OiQp1BrxbkivMQ2nlJwwL1n/LdWXNr+S2dAh89CYxJ8HJx8UH2b8GFkwvUqg
	NeYZI2agHB926oPEhvyV2GvCAeP5Bzp4Ujfa8WvuSAuOszTI0LdHGf2OlFBlf+Y2l92wK5wV+qfpW
	OSwjjtJ/QpRqmXkob/PvIDtaoT8YqZsqurk5O1O0Gy1AvhxF6kxNs8KxHoyfCcv3zuMc80wpO+3DC
	RBufQeGqrwkPvaWEY4SVtpHLT699JvIPIhyA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xRqvc-0000000EfC0-3U4A;
	Fri, 13 Nov 2026 21:02:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Nov 2026 21:02:52 +0800
Date: Fri, 13 Nov 2026 21:02:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [PATCH] mm: kvmalloc: Bail if called with soft or hard IRQs disabled
Message-ID: <avcKfEvln8_2a7fJ@gondor.apana.org.au>
References: <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au>
 <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
 <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au>
 <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au>
 <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
 <auy-7TvVzJ-VCrG4@milan>
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
In-Reply-To: <auy-7TvVzJ-VCrG4@milan>

On Thu, Nov 05, 2026 at 06:37:49PM +0100, Uladzislau Rezki wrote:
>
> Probably the simplest option is to return NULL for non-blocking vmalloc()
> allocations when BH are disabled. That would address the reported
> rhashtable deadlock.

OK let's try this patch:

---8<---
The function kvmalloc may call vmalloc under the hood even when
used with GFP_ATOMIC.  However, vmalloc uses naked spin locks so
it must not be called if the caller already holds spin locks that
can be used in hard or soft IRQ context.

Use the heuristic irqs_disabled() || in_softirq() to detect such
callers and prevent them from using vmalloc.

Reported-by: Liam R. Howlett (Google) <liam@infradead.org>
Fixes: c6307674ed82 ("mm: kvmalloc: add non-blocking support for vmalloc")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/mm/slub.c b/mm/slub.c
index 45e077c7526c..18bc70f44e22 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7139,6 +7139,14 @@ void *__kvmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), unsigned long
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
+	/*
+	 * vmalloc uses naked spin locks, so it must not be used if
+	 * the caller already holds a spin lock that can be used in
+	 * a soft or hard IRQ.  Use heuristics to detect this.
+	 */
+	if (irqs_disabled() || in_interrupt())
+		return NULL;
+
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
