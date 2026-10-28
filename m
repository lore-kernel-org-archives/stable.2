Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212666;
	b=UgwjdPrB6aG26mGai+WGsNnrco+/jJC1JD2R5OLbJ5s5mK37oXfZ72FFxiTaY8xn3aVj
	 9kVW9lGKXMak6kwbzxOIGNMxDEqO4l43fSEUcQ2VT+dR2QvxWKeax4hHWi/dma/ThHYGH
	 tW7mJjLoMQflF9rV7K2mwvl/k1r43JGUPH2cDqf/8zNbO4mx1+VxYQUdylZ9qKtCMuixT
	 eXsR3tvxg6ZsBFsjv5Jz6tw2jJ6wYlczSgRLRqcvKA+i5TyGGeeP0bKLv4LsMYz0EEkeM
	 VemTsecLw1Is1S4nhKXiN0D4PN1QWbT1lVfiQSkiq5JroSCUZBlqjQcTZ/+eNnZ6+YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212666;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=g52qDqbCr8uPmZi3S+SnsnfsE1Wav8hnqrD+It3yFgY=;
	b=SaYfAavVjGICoEfnAaI6grBZd6gpE5zBCx1fKtxr9sJmsONc9SrFmyqPkmdzoHBGSES4
	 8gOlCNlhAqsqolslVS/dsCQObIcnqhLOoe6QHfsJoCcS3d4OOaZSw32BXK8bqgKMXWaOE
	 hyRMfDnx/OWd/vja3iOO417a7dCf/o1E7gQgoHKRhI6/rg+0qjUcEpqsFYbvzb6/WecVZ
	 7YPFhaQcjEXyBEM8QGYLS2/zPhGd/z916Pgg2uuWjptNafvYEUOCPDMUsZshy/qegu5U1
	 fz1BCcfcWhUJXK8HBD5pnJBU1BAPGWcmzzbucIgDsY79C0jMWNNWQmq5Xffwvk9mPpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1RWlV4lW;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8286606A31A;
	Wed, 28 Oct 2026 18:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8286606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1RWlV4lW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g52qDqbCr8uPmZi3S+SnsnfsE1Wav8hnqrD+It3yFgY=; b=1RWlV4lWSXGhQErZ+rFG3aO3z+
	bSIhwsJuZHDAeYzFzYNYDnM7bnDGxSWIQmJUeBNpKzvYL9XEhcSioanid3Sj04ovj6veC3RJXfiB8
	BKTqsxnS9vaW5btcbryB7dk0UBUL0lXh7r7/ahjCzs6W0CZ1Q73/L9HyyOK71Eu0+2lp2CrvY/KFI
	Sa/lB9gz34gOTfhVtE1N5+0Ygw0ILo07BUrjTQmNt1SFCPDprdmolaHEFZE4x/c+9ny8qgDL72rzR
	cOoXdXtSxW6uGRwhhn+6BhldWxNEq4S4iv7g8H+xd51S4gdkMDgXFnYwh640yyk4Z5HZZaLY5ckHy
	e4LmRvCg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM8Wt-00000007lCO-3Yv8;
	Wed, 28 Oct 2026 18:37:44 +0000
Date: Wed, 28 Oct 2026 14:37:41 -0400
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, Chris Mason <mason@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] maple_tree: Update internal warning and bug_on code
Message-ID: <bdl7exlh542lhpn2qbiv4upq7bn4ugxbkntchjxnorbrr25rho@xyixysbubc6x>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-4-liam@infradead.org>
 <auImniguGIVq6c_L@gremlin>
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
In-Reply-To: <auImniguGIVq6c_L@gremlin>

On 26/10/28 05:54PM, Lorenzo Stoakes (ARM) wrote:
> ma
>  On Wed, Oct 28, 2026 at 11:42:17AM -0400, Liam R. Howlett (Google) wrote:
> > When CONFIG_DEBUG_MAPLE_TREE is set, call the WARN_ON_ONCE() after the
> > custom information is dumped about the tree.  Without using the kernel's
> > WARN_ON calls, syzbot will not catch issues detected by this code.
> 
> Mega nit but commit message doesn't mention the BUG_ON() bits :)
> 
> >
> > Update the non-debug code to call WARN_ON_ONCE() as well.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Lorenzo Stoakes <ljs@kernel.org>
> > Fixes: bf857ddd21d0b ("maple_tree: move debug check to __mas_set_range()")
> 
> LLM overlord says bf857ddd21d0b only moved it, and f0a1f866aba1 actually
> implemented it.
> 
> > Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
> 
> Looks sensible to me from kernel perspective, but LLM overlord tells me this
> changes the userland tests from asserting on dump_stack() to just printing
> something out on WARN_ON().
> 
> (BUG_ON() is OK, it asserts already).
> 
> However we really do need this for the kernel so CONFIG_DEBUG_MAPLE_TREE
> triggers syzbot and such, so maybe the userland bit can be a follow-up?

Wow, so any WARN() before... I'm trying not to think about it.

The change below is good to be squashed into the fix I sent.  It also
makes vma warnings fatal - which should also happen.

Andrew, can you take care of this or would you rather a respin?


> 
> On that basis:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> Or... maybe just respin with something actually, can fix it by updating the
> shared maple tree testing header to make warn do something like this
> (schlopped, apologies):
> 
> diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
> index 2a1e9a8594a2..112052e7201f 100644
> --- a/tools/testing/shared/maple-shared.h
> +++ b/tools/testing/shared/maple-shared.h
> @@ -10,6 +10,30 @@
>  #include <time.h>
>  #include "linux/init.h"
> 
> +/*
> + * The tools/include/asm/bug.h WARN*() family only prints a message and
> + * carries on.  Nothing in the maple tree or VMA tests expects a warning, so
> + * treat one as a failure and abort at the site.
> + */
> +#undef WARN
> +#undef WARN_ON
> +#undef WARN_ON_ONCE
> +#undef WARN_ONCE
> +
> +#define WARN(condition, format...) ({					\
> +	int __ret_warn_on = !!(condition);				\
> +	if (unlikely(__ret_warn_on)) {					\
> +		fprintf(stderr, "WARN at %s:%d: ", __FILE__, __LINE__);	\
> +		fprintf(stderr, format);				\
> +		abort();						\
> +	}								\
> +	unlikely(__ret_warn_on);					\
> +})
> +
> +#define WARN_ON(condition)	WARN(condition, "%s\n", #condition)
> +#define WARN_ON_ONCE(condition)	WARN_ON(condition)
> +#define WARN_ONCE(condition, format...)	WARN(condition, format)
> 
> > ---
> >  include/linux/maple_tree.h | 54 +++++++++++++++++++++-----------------
> >  1 file changed, 30 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > index e30e57f5f3df9..0f96f1f19eb95 100644
> > --- a/include/linux/maple_tree.h
> > +++ b/include/linux/maple_tree.h
> > @@ -680,7 +680,7 @@ void mt_cache_shrink(void);
> >  		pr_info("Pass: %u Run:%u\n",				\
> >  			atomic_read(&maple_tree_tests_passed),		\
> >  			atomic_read(&maple_tree_tests_run));		\
> > -		dump_stack();						\
> > +		BUG_ON(1);						\
> >  	} else {							\
> >  		atomic_inc(&maple_tree_tests_passed);			\
> >  	}								\
> > @@ -696,7 +696,7 @@ void mt_cache_shrink(void);
> >  		pr_info("Pass: %u Run:%u\n",				\
> >  			atomic_read(&maple_tree_tests_passed),		\
> >  			atomic_read(&maple_tree_tests_run));		\
> > -		dump_stack();						\
> > +		BUG_ON(1);						\
> >  	} else {							\
> >  		atomic_inc(&maple_tree_tests_passed);			\
> >  	}								\
> > @@ -713,62 +713,68 @@ void mt_cache_shrink(void);
> >  		pr_info("Pass: %u Run:%u\n",				\
> >  			atomic_read(&maple_tree_tests_passed),		\
> >  			atomic_read(&maple_tree_tests_run));		\
> > -		dump_stack();						\
> > +		BUG_ON(1);						\
> >  	} else {							\
> >  		atomic_inc(&maple_tree_tests_passed);			\
> >  	}								\
> >  } while (0)
> >
> >  #define MT_WARN_ON(__tree, __x)  ({					\
> > +	static bool __warned;						\
> >  	int ret = !!(__x);						\
> >  	atomic_inc(&maple_tree_tests_run);				\
> > -	if (ret) {							\
> > -		pr_info("WARN at %s:%d (%u)\n",				\
> > -		__func__, __LINE__, __x);				\
> > +	if (!ret) {							\
> > +		atomic_inc(&maple_tree_tests_passed);			\
> > +	} else if (!__warned) {						\
> > +		__warned = true;					\
> > +		pr_info("WARN at %s:%d\n",				\
> > +		__func__, __LINE__);					\
> >  		mt_dump(__tree, mt_dump_hex);				\
> >  		pr_info("Pass: %u Run:%u\n",				\
> >  			atomic_read(&maple_tree_tests_passed),		\
> >  			atomic_read(&maple_tree_tests_run));		\
> > -		dump_stack();						\
> > -	} else {							\
> > -		atomic_inc(&maple_tree_tests_passed);			\
> > +		WARN_ON(1);						\
> >  	}								\
> >  	unlikely(ret);							\
> >  })
> >
> >  #define MAS_WARN_ON(__mas, __x) ({					\
> > +	static bool __warned;						\
> >  	int ret = !!(__x);						\
> >  	atomic_inc(&maple_tree_tests_run);				\
> > -	if (ret) {							\
> > -		pr_info("WARN at %s:%d (%u)\n",				\
> > -		__func__, __LINE__, __x);				\
> > +	if (!ret) {							\
> > +		atomic_inc(&maple_tree_tests_passed);			\
> > +	} else if (!__warned) {						\
> > +		__warned = true;					\
> > +		pr_info("WARN at %s:%d\n",				\
> > +		__func__, __LINE__);					\
> >  		mas_dump(__mas);					\
> >  		mt_dump((__mas)->tree, mt_dump_hex);			\
> >  		pr_info("Pass: %u Run:%u\n",				\
> >  			atomic_read(&maple_tree_tests_passed),		\
> >  			atomic_read(&maple_tree_tests_run));		\
> > -		dump_stack();						\
> > -	} else {							\
> > -		atomic_inc(&maple_tree_tests_passed);			\
> > +		WARN_ON(1);						\
> >  	}								\
> >  	unlikely(ret);							\
> >  })
> >
> >  #define MAS_WR_WARN_ON(__wrmas, __x) ({					\
> > +	static bool __warned;						\
> >  	int ret = !!(__x);						\
> >  	atomic_inc(&maple_tree_tests_run);				\
> > -	if (ret) {							\
> > -		pr_info("WARN at %s:%d (%u)\n",				\
> > -		__func__, __LINE__, __x);				\
> > +	if (!ret) {							\
> > +		atomic_inc(&maple_tree_tests_passed);			\
> > +	} else if (!__warned) {						\
> > +		__warned = true;					\
> > +		pr_info("WARN at %s:%d\n",				\
> > +		__func__, __LINE__);					\
> >  		mas_wr_dump(__wrmas);					\
> >  		mas_dump((__wrmas)->mas);				\
> >  		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
> >  		pr_info("Pass: %u Run:%u\n",				\
> >  			atomic_read(&maple_tree_tests_passed),		\
> >  			atomic_read(&maple_tree_tests_run));		\
> > -		dump_stack();						\
> > -	} else {							\
> > -		atomic_inc(&maple_tree_tests_passed);			\
> > +		WARN_ON(1);						\
> >  	}								\
> >  	unlikely(ret);							\
> >  })
> > @@ -776,9 +782,9 @@ void mt_cache_shrink(void);
> >  #define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
> >  #define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
> >  #define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
> > -#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
> > -#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
> > -#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
> > +#define MT_WARN_ON(__tree, __x)		WARN_ON_ONCE(__x)
> > +#define MAS_WARN_ON(__mas, __x)		WARN_ON_ONCE(__x)
> > +#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON_ONCE(__x)
> >  #endif /* CONFIG_DEBUG_MAPLE_TREE */
> >
> >  /**
> > --
> > 2.47.3
> >
> 
> --
> Cheers, Lorenzo
