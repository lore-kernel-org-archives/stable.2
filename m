Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557264;
	b=bAUSVYjbZEiKWYH7hihYEbL10w7accg8NRBGPR+LpGqXHkrzZj/3NAp3whQyZNnV2Bm4
	 QvbFYINoetiyLZDrv7vE+K+c18kliVrrd5R/SJEkz7B9rUBo/RYpGeLx45/k8VZNWAd5u
	 L5YYq+tDoGIyJjYcYtluWTNiuZ0GNzNvrdP5+XFSdRibrU1ZlHOdXD2ct53VJPud7AX/v
	 2eX+La3123hATEDGcPQi8jy7TgNG+rUHo9N9ghD7JbDW5Aey6Nl/DV6Fozy1DMMKdDNvQ
	 cQRjjT1daePDXz+4+vE8fWkcmklGDflHT33njZD9ygAZpYQznWHKd1D9fHoDfd4wYVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VYhaZ8UGiw+YlICT6cuZY+47kv3MmX1z/3eT4sdMXTI=;
	b=hGJtaBf4bi89sXiVgaq780QJtr3euwvdfqIr3bmumCGp5cszBeKpuZHaBOckdBwrfm3L
	 NHd7TFZUtWbb+ou/laa/2yRKefqgsqe9aYnXHDZDIUEC05xXmPNIJ2pvudQgKU2ZgXGgu
	 8JoOJwENibRrjQM6Bhnd8F4a7BfswSQrifcSFXRX8bo/bTVtcCsgYMBAbCucfM0Ulx3RB
	 WaRRCV0A2WLTOOEKgvjkKAQzZ8Xdxmrf69HBLSF1sAH10rgNmeNHBbXycIWHrbraR2Lif
	 dXnQCMt+mSZnBLtGKVRj3gQR0BzAW079SCwiEG0n5Zt7gRQcYXV/0/DqRDIQKUUo5yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQYU01VS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2283606A32D;
	Tue, 24 Nov 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQYU01VS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0CF1F000C0;
	Tue, 24 Nov 2026 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557263;
	bh=VYhaZ8UGiw+YlICT6cuZY+47kv3MmX1z/3eT4sdMXTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQYU01VSY4vX+sjbQbe4c6VkSB0gsZ2dNNQyUjzPr11h6kxp+XHLGI/piPI+B1UeM
	 eRUe1De7GTvpy3OMo45cZ6m16ApzRLuHqFmgC/VuI1yJaDOiK87jAkWeCB5Tp+QHT0
	 vNtZ+nhubzxAPXsM+wKtAucuGu5fwIu3pZ4YjwTQiPzvK+WZGmL1inBKzz4fdOSMfv
	 dlYLUpjD3/VUOPgS82hY4iy7MAMQd6o+sVnEzBSfpc/ril2HHHOwOGEp1+UbEBJK5g
	 1RxVcindNxaBfEAQhYfDQ37uW15Pv/CepKQzGQLxhTxMfkTxJqA4HGLKBlSgS3Tvy/
	 pLHEGkvPsnszg==
Date: Tue, 24 Nov 2026 21:54:21 +0000
From: Harry Yoo <harry@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, 
	Lance Yang <lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ying Huang <huang.ying.caritas@gmail.com>, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
	Kirk Swidowski <swidowski@google.com>
Subject: Re: [PATCH] mm/rmap: avoid reusing batched TLB flush generations
Message-ID: <awYFSeZKPzqcCvW8@thinkstation>
References: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
 <awXQg94rksZvexZe@thinkstation>
 <1cd2306c-eaec-43cd-9d0d-92f8cb6e691b@kernel.org>
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
In-Reply-To: <1cd2306c-eaec-43cd-9d0d-92f8cb6e691b@kernel.org>

On Tue, Nov 24, 2026 at 10:16:25PM +0100, David Hildenbrand (Arm) wrote:
> On 11/24/26 21:50, Harry Yoo wrote:
> > On Tue, Nov 24, 2026 at 10:39:11AM +0100, David Hildenbrand (Arm) wrote:

> Hi Harry,
> 
> thanks for all that effort!

No problem, thanks for looking at the issue ;)

> > Uh, I spent a couple of hours to review and make sure this is correct.
> > I thought this is correct but then my claude flagged a race during fork.
> > 
> > dup_mm() copies the counters with memcpy() and it doesn't know the
> > ordering. When flushed and pending fields sit in separate words,
> > dup_mm() could read them in two separate loads, but in the wrong order.
> > 
> > It's especially problematic in a very rare (IMO) case where
> > flushed == pending + 1 becomes true in the child (which means the first
> > pending flush in the child might not be flushed properly).
> > 
> > fork				reclaim			another process
> > memcpy reads pending = X
> > 				pending++ (X + 1)
> > 							truncate()
> > 							-> flush_tlb_batched_pending()
> > 							-> flushed = X + 1
> > memcpy reads flushed = X + 1
> > 
> > Maybe reset the counters after copying mm_struct?
> 
> Resetting sounds in general like the right thing to do. Ugh, this copying of
> random state is nasty.

Indeed.

> The child never ran, so there isn't anything to flush for it.
> 
> So what you say is that the first deferred flush in the child will be missed.

Yes, I exactly meant that.

> I agree that it's extremely unlikely, but we should handle it.

Agreed.

> We currently have:
> 
> 	if (unlikely(pending - flushed > INT_MAX))
> 
> So I guess an alternative would be:
> 
> 	if (unlikely(pending - flushed - 1 >= INT_MAX))
> 
> 
> pending = x + 1
> flushed = x + 1
> 
> (x + 1 - (x + 1 ) - 1) = (unsigned)-1 >= INT_MAX

Oh that's subtle :)

> But yeah, let's just initialize it during fork(), thanks!

Sounds good, thanks!

-- 
Cheers,
Harry / Hyeonggon
