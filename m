Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917504;
	b=YCi0MHJeL14XQUPr5nZ/VqMFr4quJjL7mZyQGnTA8/aBokf0zz2Ov9NH4FfAYYSvPrlq
	 CJ8pwrbAc9xCGcekHkv7wZB3Kda78XvbF8yTDuss3UrDGvf9BuPrvO1Txj4h0SybDEnKe
	 gFEZH/GtvRZiVm/iTedQ6TEOjD04f/n8KH19rKG5BHgktGvaExHl3bGuLq6+7doD5CBHU
	 I3j5Irm4ssYxgNWf6IoLbcBUOojwR79EV5yV13q4JY3YqVSgZLWgoAg0GuRnHIjzy3Jb3
	 oR0rJHEgPZU4BIwYcCorW2CFgVJPOP2HD+p6wNum4GlJcpEhHVARZtwtPna2EHZqgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917504;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aC+qtiKQ023bm9o1O7eQng0BAlQQoW+kw14Srbp6hgo=;
	b=av9nxkBRn9t60B4wXQ3yn84OZA/OmbAFW0C303z34QQxcCHh0/pVL4KWLev18YpK3aa6
	 pRZTNL8VtYqzo+AjdfNf+PzqXVIpbJyofBcqBPtM8+LioayusxveNEDdHypl0Vq7f/i1r
	 ef1njRCtc2MbxcYiBSoZ1F2ydEcUtl5+h0NPbdlx/rCXKRY2Yt5NRemniyCqAzkPdINTo
	 VJQsMELC2BZyZKQ70QhAsABWJiYQOTVtVUhktelSpL1ipM2hl5fUN1+9t3KTPZkafh8E1
	 Ol0c4v1KHI0gr233863Wj904lbFHdwZPgHkkFSigh/Mkj/eW/boY0JOsN8hFQJvkeZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AYAz30az;
	arc=none smtp.remote-ip=91.218.175.79
Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A414606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A414606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AYAz30az
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aC+qtiKQ023bm9o1O7eQng0BAlQQoW+kw14Srbp6hgo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793917501; v=1; x=1794522301;
 b=AYAz30azCfWtJi1XhwIimMgcURpfEy0+zG0xXZfrF+xJ9lC7/lJRwLDrYqh/z84ZwQmtQxLH
 Hgq8aN7d3+vkw4FG9a47NnQYU6U9wdbWU1Ncmtm9O5bQOVgE+zY58jOtFPOQR6VkJqNwwZnS6zZ
 vLrR3kMTUDPyka59IQFTAWg0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 204d4cc12b5d9ed2;
	Thu, 05 Nov 2026 22:25:00 +0000
X-Mizu-Trace-ID: 204d4cc12b5d9ed2
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 22:24:54 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Krystian Kaniewski <krystianmkaniewski@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <au0CJvc-OwFbL6lm@linux.dev>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <20261102092750.e53073b2c7b872f9d70c0711@linux-foundation.org>
 <20261105-jf-filemap-v2-akpm-testedby-reply-r1-36ef39856b46@linux.dev>
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
In-Reply-To: <20261105-jf-filemap-v2-akpm-testedby-reply-r1-36ef39856b46@linux.dev>

On Thu, 5 Nov 2026 22:13:34 +0000, Jose Fernandez wrote:
> I ran it under the stress test from my reply to Pedro in this thread.

I also ran the check_multi_find_4 test that comes with the patch. It
fails without the fix and passes with it. The stress test only ran with
the fix applied.

- Jose
