Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210093;
	b=TSk/N4o73U7OQA6kv+Byga2cKv8mHMxLzQ3DvRqimF98yfTmy71uLTwETtb/bSPA6CZP
	 KuK133dFuHeLVqgHCxR6W1msyxiLEW5FEuG2A0rMXZQIXvbIl1KbZ0BsrOgd8osFBnm5Q
	 OJtD9rtxBGl95T0WRbHBDa+Ncrqb1kcZIAS6dbyJa4E63HDse5rH11HIdAu4L1qKTtTtv
	 dQFptozLXb6DqO7P8Qws7av7+LKHKDXUik7gu7lLbVxw3Vk2dMjC0JpsgvFgMvHw4SLnj
	 ZMTggUNG9WTG+z8AicudkF+kHpA0wPY5Hjc0E644l73MG5iTJetKcaBYuABmoaClv2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210093;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v6lgge4WdsOVmOEXha6YU4EWcAVpqL0HGPQBV5WSBkY=;
	b=lSOtuMtu8WbYTMtY/UFXdR20W+0caNbAGyXOsqMn/lv0RvvBJHj9E7nh221RJkU4aBDx
	 wX/MzaIdsG97vWodOzSzp7cpvi285sw37S4EQ41OvcZeDh7vF3PtdEcLuFp65jvpIR2Wt
	 /EMie3IabC4Tji1ZEjSGTWrJ8GxEPOx0wErnkm+dACt5L8oxV8apXVfyIfJhtO2M8TAgI
	 /DA5LHYWfQzYm76s4u8jHMgcesR/qXUu1Ll2D2v0fkDlz/gubQ1Y2LYejVWO4T7xEd+5d
	 wmzYBQA49aTc8cXI5s/ypiE7UsPuGxbRkLzl+Pl7aqV54x6QnPsYfsx/swGg9x3MMmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khWkVIOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C45606A32C;
	Wed, 28 Oct 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khWkVIOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A01F01828;
	Wed, 28 Oct 2026 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210092;
	bh=v6lgge4WdsOVmOEXha6YU4EWcAVpqL0HGPQBV5WSBkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=khWkVIOIxNRfDHMWRxAQtKPepjJau1mWH1tfNKVk66Ch1Lv9J7cPoDH51yRVQkwQe
	 lm9acNXE11ARvqj46A/Jyhi7EbsCe7jxWNp+QA+oIQecZm/cowX6xbtuw2ZcnMLeZW
	 F66i8Mn634THVYeZ8kW0a7P38yefWynfUloLYRA+QdcLjo8wWma67XNK0XQZydnh42
	 /vDm0n3McPffCVHg9YW7z8haJZkTA8RlJPH1/umGHKF2jPmhag50YsXMCtLexT4VbV
	 Ii/RzfMxlGoN8SWgNRUNR0nsu7SeT0M1r10FoZv6ArCr77yMxsJQbPadK4R3ESzy4a
	 4ho1RTRTgtRxw==
Date: Wed, 28 Oct 2026 17:54:47 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Liam R. Howlett (Google)" <liam@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, Chris Mason <mason@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] maple_tree: Update internal warning and bug_on code
Message-ID: <auImniguGIVq6c_L@gremlin>
References: <20261028154218.1668182-1-liam@infradead.org>
 <20261028154218.1668182-4-liam@infradead.org>
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
In-Reply-To: <20261028154218.1668182-4-liam@infradead.org>

ma
 On Wed, Oct 28, 2026 at 11:42:17AM -0400, Liam R. Howlett (Google) wrote:
> When CONFIG_DEBUG_MAPLE_TREE is set, call the WARN_ON_ONCE() after the
> custom information is dumped about the tree.  Without using the kernel's
> WARN_ON calls, syzbot will not catch issues detected by this code.

Mega nit but commit message doesn't mention the BUG_ON() bits :)

>
> Update the non-debug code to call WARN_ON_ONCE() as well.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Lorenzo Stoakes <ljs@kernel.org>
> Fixes: bf857ddd21d0b ("maple_tree: move debug check to __mas_set_range()")

LLM overlord says bf857ddd21d0b only moved it, and f0a1f866aba1 actually
implemented it.

> Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>

Looks sensible to me from kernel perspective, but LLM overlord tells me this
changes the userland tests from asserting on dump_stack() to just printing
something out on WARN_ON().

(BUG_ON() is OK, it asserts already).

However we really do need this for the kernel so CONFIG_DEBUG_MAPLE_TREE
triggers syzbot and such, so maybe the userland bit can be a follow-up?

On that basis:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Or... maybe just respin with something actually, can fix it by updating the
shared maple tree testing header to make warn do something like this
(schlopped, apologies):

diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
index 2a1e9a8594a2..112052e7201f 100644
--- a/tools/testing/shared/maple-shared.h
+++ b/tools/testing/shared/maple-shared.h
@@ -10,6 +10,30 @@
 #include <time.h>
 #include "linux/init.h"

+/*
+ * The tools/include/asm/bug.h WARN*() family only prints a message and
+ * carries on.  Nothing in the maple tree or VMA tests expects a warning, so
+ * treat one as a failure and abort at the site.
+ */
+#undef WARN
+#undef WARN_ON
+#undef WARN_ON_ONCE
+#undef WARN_ONCE
+
+#define WARN(condition, format...) ({					\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		fprintf(stderr, "WARN at %s:%d: ", __FILE__, __LINE__);	\
+		fprintf(stderr, format);				\
+		abort();						\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
+
+#define WARN_ON(condition)	WARN(condition, "%s\n", #condition)
+#define WARN_ON_ONCE(condition)	WARN_ON(condition)
+#define WARN_ONCE(condition, format...)	WARN(condition, format)

> ---
>  include/linux/maple_tree.h | 54 +++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index e30e57f5f3df9..0f96f1f19eb95 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -680,7 +680,7 @@ void mt_cache_shrink(void);
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> +		BUG_ON(1);						\
>  	} else {							\
>  		atomic_inc(&maple_tree_tests_passed);			\
>  	}								\
> @@ -696,7 +696,7 @@ void mt_cache_shrink(void);
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> +		BUG_ON(1);						\
>  	} else {							\
>  		atomic_inc(&maple_tree_tests_passed);			\
>  	}								\
> @@ -713,62 +713,68 @@ void mt_cache_shrink(void);
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> +		BUG_ON(1);						\
>  	} else {							\
>  		atomic_inc(&maple_tree_tests_passed);			\
>  	}								\
>  } while (0)
>
>  #define MT_WARN_ON(__tree, __x)  ({					\
> +	static bool __warned;						\
>  	int ret = !!(__x);						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (ret) {							\
> -		pr_info("WARN at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> +	if (!ret) {							\
> +		atomic_inc(&maple_tree_tests_passed);			\
> +	} else if (!__warned) {						\
> +		__warned = true;					\
> +		pr_info("WARN at %s:%d\n",				\
> +		__func__, __LINE__);					\
>  		mt_dump(__tree, mt_dump_hex);				\
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> -	} else {							\
> -		atomic_inc(&maple_tree_tests_passed);			\
> +		WARN_ON(1);						\
>  	}								\
>  	unlikely(ret);							\
>  })
>
>  #define MAS_WARN_ON(__mas, __x) ({					\
> +	static bool __warned;						\
>  	int ret = !!(__x);						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (ret) {							\
> -		pr_info("WARN at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> +	if (!ret) {							\
> +		atomic_inc(&maple_tree_tests_passed);			\
> +	} else if (!__warned) {						\
> +		__warned = true;					\
> +		pr_info("WARN at %s:%d\n",				\
> +		__func__, __LINE__);					\
>  		mas_dump(__mas);					\
>  		mt_dump((__mas)->tree, mt_dump_hex);			\
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> -	} else {							\
> -		atomic_inc(&maple_tree_tests_passed);			\
> +		WARN_ON(1);						\
>  	}								\
>  	unlikely(ret);							\
>  })
>
>  #define MAS_WR_WARN_ON(__wrmas, __x) ({					\
> +	static bool __warned;						\
>  	int ret = !!(__x);						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (ret) {							\
> -		pr_info("WARN at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> +	if (!ret) {							\
> +		atomic_inc(&maple_tree_tests_passed);			\
> +	} else if (!__warned) {						\
> +		__warned = true;					\
> +		pr_info("WARN at %s:%d\n",				\
> +		__func__, __LINE__);					\
>  		mas_wr_dump(__wrmas);					\
>  		mas_dump((__wrmas)->mas);				\
>  		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> -	} else {							\
> -		atomic_inc(&maple_tree_tests_passed);			\
> +		WARN_ON(1);						\
>  	}								\
>  	unlikely(ret);							\
>  })
> @@ -776,9 +782,9 @@ void mt_cache_shrink(void);
>  #define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
>  #define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
>  #define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
> -#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
> -#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
> -#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
> +#define MT_WARN_ON(__tree, __x)		WARN_ON_ONCE(__x)
> +#define MAS_WARN_ON(__mas, __x)		WARN_ON_ONCE(__x)
> +#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON_ONCE(__x)
>  #endif /* CONFIG_DEBUG_MAPLE_TREE */
>
>  /**
> --
> 2.47.3
>

--
Cheers, Lorenzo
