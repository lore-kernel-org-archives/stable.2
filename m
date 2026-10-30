Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403355;
	b=uLQh23EDoR7fQksiDadp95M8H5wBd1fg8vsy8CYhb/gIMsxcqsUj+cRKOsbc5TzrWI8F
	 riInA8bqWSVQb+6chzR55oXzMPHejV7cBQp8r6+OFb3RTaA31vNhcRCDnarO1iXYq6sGB
	 BXoyHsqc2iMcqcVuIA8sRIUZXi6VVPvHds6D5UcSyXmvTbC4ytrcC56zUFI6jDYb4YliC
	 96QqLdzk2NaLfyINlT67Tmz3JaXmvYTc93ZXBuRaOTbRhWvdoTxh/gN7pqTPA5Rwc6nK1
	 jlfPTRz6ZW1czbturN1mImJVV0KL/IpfaWPOAq2Lucw20Wqzo6NztGDjm70Hcf9OZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403355;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+D8xcboleXFfNBz+9PzvAn1q+GlQ9WNruOXjhVP/aUw=;
	b=O+Yf7PktO42u3OfyLVAH7GrKTNDxbHV77NZrHD70YDpwOzqLgTZNRNiK6QDNeGeP0qRw
	 ga9TVRgfdfrPkILJmlGCuAhV1QN0xCWghwG353Hfkyx7TcdYqHedH05GwHhwzXqPyQ2Ah
	 6hVbtZdU3B3TQl5AVt8wKPQcZJxdiZp1IZFgl1zQsHIc4KZL3VJx+AXHM+oNFBmw0kQm2
	 b+A4XV+SONHnJLlpemxKDp2XLUf0+FzTHz+aC5sqeI1gnaF21E288EP/p8Ih3ksbaDpTf
	 0rmd+1LjSkXCjIxBKyU2u76OIovFnsRhC1Yo8ko06M/Nq4XqNgBvKvB0bIWC44nZqNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rhpJOnAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E216606A31A;
	Fri, 30 Oct 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rhpJOnAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D2D1F000C1;
	Fri, 30 Oct 2026 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793403354;
	bh=+D8xcboleXFfNBz+9PzvAn1q+GlQ9WNruOXjhVP/aUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=rhpJOnAaoWavHcYz9fkvOibpMLCZvyEgguAk12nBP8Vl9XF/CbhvY6V+X4ynA6zEz
	 BItzh890Hw05m728AHgLqE8piWUNTC1YShizEfl4SWLXsSy43B8x2EWFR5+VxNV464
	 apFM9h0I6Bj1+oUBUXxgPSawrJ4vTPHRdIaE/xpA=
Date: Fri, 30 Oct 2026 16:35:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry
 Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Nico Pache
 <nico.pache@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Tal Zussman <tz2294@columbia.edu>, Li
 Youhong <liyouhong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
Message-Id: <20261030163553.c5dec200dd39cec4695e545c@linux-foundation.org>
In-Reply-To: <20261030-try_to_split_thp_page-v2-1-c957c9b42eab@kernel.org>
References: <20261030-try_to_split_thp_page-v2-1-c957c9b42eab@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 23:29:13 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> hwpoison code can end up calling min_order_for_split() without holding
> the folio lock. There isn't really something that would prevent
> concurrent folio split. Consequently folio->mapping can get set to
> NULL after checking for "!folio->mapping", and if the compiler
> reloads folio->mapping, mapping_min_folio_order() would try to
> dereference NULL.

Bit confused here.  Is it referring to folios which end up outside EOF
which split effectively truncates, or did it mean to say "truncate"?

If the former, how is split able to folio_ref_freeze() a folio which
hwpoison has grabbed a ref on?

IOW, is the race against split, or against truncate?
