Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918645;
	b=PkfCP6svRac8UvzIbeQ3bWL6kYRArQzuumbIRGFGVRd+qQG4EIINZ4ou2aLVzcdxKMdA
	 RkwaNVCDEOVsWZNsXYkjPGXjzctuIxRiqrb4x3fU4JoY4RLrmxY1e4KMJXUEIg0sJz4Zo
	 9t97r0VErMxEGfejoOIV7H+5kZ8fYjmFzz9hECCps55iK+gNlauLh5NIlrUrj+lMS6Yt+
	 CZdBL5U3XYWC56AS35RJ+vu4B3Sd7hln4fuxMXXWJGpmNaY74GVBfCi180s10lCyA/cgz
	 YEX1p1+ycl5C6ZkuGz6P9CZ4eWQHPsOr9vmcYh0ewjeBNg8xftklSSdZwEzBrCQMGSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918645;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JxLJNgnKaaDtogy9UDJ+u4IBfGkMCrx4gqopdXLbwqE=;
	b=QWQpzRmG3SqCcOgsNuRcpSFtfES361UVccTUPfE70bpscByo4Ffb/3JUNjIJLAAOG5U6
	 5/+zKarn6ZtFTL+BeYB/yQ3jNOiKBkoLpFjKuDIORo2fWiGGm5gWIwD2cWty3dI2Ke9ch
	 qFG22bScaugQkSiDTa+U726sytVOtmBAhX5DbW2IysZpgWTYJRwDER2DAAL336qLHBv2d
	 etZ7PiLWXzDpPDKI/Yz9XtbhO1BwCyonxTPY7W8IiWRbipgQbSpBwjUkuVt1ndSd8Rbsw
	 dk45HnFAHcd81GHOmUr5ieb/NGC8lOLB8+33F+FL8ETWdH6K4fLbtxQTmxCIrSEZj3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.181
Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32506606D80C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32506606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vAPWWkIFDwbgy2wHFM/rAmP8el8Mj7wGKfgTaZhtpZ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793918642; v=1; x=1794523442;
 b=rp7glFqHvrLHbMfBSaPiYJG22IM71k3aN2mJXgKV8YPS9ZSnI0eD4CGSpjLSYsqaCbG5rVU7
 niGJGtmUA431/BKVodx+m/HkN3vVu/yDMxehWTLamDYafgLyUpZ6bt5suRnNrAgPbvce5imoIzY
 5T3SqgXEZUkCHeEd5Y8xay/Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 960618cb128bac7d;
	Thu, 05 Nov 2026 22:44:02 +0000
X-Mizu-Trace-ID: 960618cb128bac7d
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 22:43:58 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <au0GBdGqu6cv5PMy@linux.dev>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <aunPI5eOUOAEUa8d@pedro-suse.tail5790ac.ts.net>
 <20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev>
 <auxvLCiljPhy0n_q@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <auxvLCiljPhy0n_q@pedro-suse.tail5790ac.ts.net>

On Thu, 5 Nov 2026 12:19:13 +0000, Pedro Falcato wrote:
> Thank you. So, if I'm not mistaken, this is the race:
> First, you map/see this:
> 	[folio pgoff 4, length 4]
> Then, at some point in time, someone punches the hole:
> 	[no folios here]
> Then, at some point in time, someone faults another folio in the range:
> 	[folio pgoff 0, length 8]
> so you step backwards. Is this correct? Or am I misunderstanding this?

Not quite. In my test a large folio goes away and a small one comes back
below where the walk started. If that happens during the walk's first
lookup, the walk can step back. Krystian's fix doesn't cover that
lookup.

In your order it doesn't step back. The new folio covers the place where
the walk is, so the walk either gets it at the right index or skips its
sibling slots.

> If so, how can this happen while we hold the PTE lock? That itself should
> block truncation.

We don't hold it yet. filemap_map_pages() does the first lookup under
RCU and takes the PTE lock after it.

> Can you share the reproducer?

With the delays it can corrupt memory on a kernel without this patch, so
I'd rather not post it. I can share it off-list with the maintainers if
they want it. The 40 runs without a delay were on a debug kernel with
the delays set to 0.

Andrew, I can send a v3 with this case in the commit message if you
want it.

- Jose
