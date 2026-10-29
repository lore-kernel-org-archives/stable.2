Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304157;
	b=TQ8s+QWWxO9u4QBm+s/gW0plWW/IKMdfd2BLRf9wyJSKgbW+yApiWbmAHUrLgD/6N5K0
	 9dMehuVzC/Dq+ngyy/k7PF4SFZ2cGBuG2zSzfKmyCI0jnR4Q2oqnUjW8g9CXDe2fLQsHl
	 8CcfolNtFo0LMX06RPxZKIb3MZEMiTOtczACNc4l/oWo4jmo2Xi+B9JbqhaxO/7P+p80m
	 +ZR9OPqqBtHWDpE104pfINOXf20VYnUQFSri18shp9wF4+nXYWxyfH6+SipSQX0Iy03cJ
	 gwSbPu7Mb9XkK+ClOU+HKUmhHyDeD/qkUVO1CMmlUTR5eK+SZauf+YKL4QsKauP+bLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304157;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zKBj/4/nslR1aXuIkz63N04FOxASl+KN0QZ/uCoAH4A=;
	b=hyjEGd93xb5kkyP3qfjG4L6uajp32+fkIETsxwbu1PQS8TF9I+PToDAywO91716PlLaQ
	 yJFSc+/DnG14MQ45/TpB7ttKCsFhH8gW/dxUEqAu9z48aHqefsKJ3oel8M+FXKomscOyv
	 m0B6pJ6yocETI2fn6Hg9urT79ozi+Yta45Gh4+TA/G1CNmlhqhG13zAScql13Hdj+XAmP
	 Y2F8aYC4XuPP3NfUhHqXt2KUnP0OS4IW/3nKbRw0+oTZ8D7q4TR6U54D8kiXBMFIeVuY4
	 XlQXuwfX+HaTgGmTVDkLJ3LbUJL7SI0Jd5u50bHpvv/2PcZMaDbt8+846e/3j5RKm5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="vdi5/0Zd";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE1606A31C;
	Thu, 29 Oct 2026 20:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCE1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=vdi5/0Zd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zKBj/4/nslR1aXuIkz63N04FOxASl+KN0QZ/uCoAH4A=; b=vdi5/0Zd/6Xz6Rp5HRC/mveyI3
	4PI5bZgyL7DpIZESI385vlS1aDjzpPHdHKr7jzWQcXtFsr95tO9srXq+1SgTUmlFOj/tWhJQmDW0i
	FxJi7u26tzbINCzg9qdzAh3Q6+dvF10rGd28LSuLLKO7GyEJqFu3OMkb+Pm7BBtaY573EtGmxzVo8
	WkAB6JrFiv95j5scLqaAOPgc8+fCUDhlS1/RK4G9t7pKEp51QcjGc7uoE52v0TLYQsln5hO5AhWtz
	ThWjNUm7ukcilSgqnTpFvcpa/QsJ6WR4BTVMl70JrtcN4gHBjzdFOa54C1gl0wgblNhFj6WvNeUIN
	7urNr9NA==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWKX-0000000H1uP-09fx;
	Thu, 29 Oct 2026 20:02:33 +0000
Date: Thu, 29 Oct 2026 20:02:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Liam R. Howlett (Google)" <liam@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
Message-ID: <auOmWM5uiQC9LPwx@casper.infradead.org>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-5-liam@infradead.org>
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
In-Reply-To: <20261028154218.1668182-5-liam@infradead.org>

On Wed, Oct 28, 2026 at 11:42:18AM -0400, Liam R. Howlett (Google) wrote:
> Below, one CPU adds an FDB entry for an RTM_NEWNEIGH netlink request,
> while another CPU is inside vmalloc() or vfree():
> 
>     RTM_NEWNEIGH                      vmalloc() or vfree()
>     ============                      ====================
>     spin_lock_bh(&br->hash_lock)
>                                       spin_lock(&vn->busy.lock)
>     rhashtable_insert_rehash()
>       kvmalloc(GFP_ATOMIC)
>         vmalloc()
>           spin_lock(&vn->busy.lock)
>             waits for the other CPU
>                                       softirq: a frame for the bridge
>                                         spin_lock(&br->hash_lock)
>                                           waits for RTM_NEWNEIGH

This seems like the kind of deadlock that lockdep can catch.  Why
hasn't it?  Do we need to add a fake lock for RTM_NEWNEIGH?

