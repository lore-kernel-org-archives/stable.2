Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706750;
	b=voHgNVZNaIwG+wkHKOVm6Meei4q5PL8apCGY0zbVBXVXp49CHtRzAu9jrk4GRlaliHVs
	 Wbf2JbjgI9cgG8RuANmWdo/HveGVc6O+rErK++jfuANo7AKUoPcfE6+jImI2t75EPr71q
	 rVqW6sJCMcuNgAcN6Ncyf1wBsECQFtvCmV0LV9rj2ksRL/wexgzjXvWRna4TGoO2SK9AD
	 X/qRLv5rKEUbpH+b2/c14ii/8kQKEArWgi6dCGeAo9dY9nhspTKqRCXZyRft2NVxdLxgE
	 HYT1NEbwsubQH+yGQUNzeUb87pyN7hQ7bPxtTJY54pTGYZc2oRWCFFus3jqDcUZzS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iWyW+bGyGveMgmXtKW3uGBlbS+JH67BydEPcZUH8PVc=;
	b=IkAEp3QfMB7BaJ6MGsCX8q3HbvRJ8oxa+eUAkl4mqhLJDaNfZbDHwgBE2JfzLXOFAQtb
	 xXVxvP1YQ1kJBGMESQTLjqI2Uwhhxh18OlZ0YPS6QE4J7lwIJJ1ulAzP0ZEaGaEKh6FtX
	 KpH+M/uyF34YhliQeq5gfMCjjZPEMgVAkfnbij+FZ9bftSvi8r5vMsT8f4jK09u1qPA4D
	 YUY377JOtkCCVFT7GYgboyJrh7NSrgMKW8cAKACbd7vmdlEthSemUwc+DCl6yVkpkw2wq
	 WGO1GLEnNoRBVMJYSpu3lQ062XsgLlAxwxLvjDTSHBAySDuX0/TXnQjLYDWtfGTwVRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKoyMglv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E1606A329;
	Tue,  3 Nov 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKoyMglv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D621F000C1;
	Tue,  3 Nov 2026 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706749;
	bh=iWyW+bGyGveMgmXtKW3uGBlbS+JH67BydEPcZUH8PVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WKoyMglvOchDD2D5K5t6zuBBSTJeqjwBhmAjJHtuQuQrIMQn4TyLXg7poNkpL3+ur
	 ANeQ6Oy1q5X7Z9Hax5cjkJLaLfVpFFW0seUViNrnZaNMjX+4SdA1y+aM0NpktUIJVD
	 mdMxecqUxS3yjrc0yPHtRX2wlQV1cWukiFNUFHuKlPCXDKdj9TamuRJRpNAq0AcRjd
	 89/+N2XmDgCzG6Vay9XiZ5vM5yI4hftxzxHh0I5h9obnt8hFx1cEo17X3xdgt5WGjZ
	 7un3053U62ewJJuIWhJjsN1Or2XFE525Spv39c3D2y9uDWvxOmFvzl/AMlNW+67b8L
	 j4JURwckfmKTA==
Date: Tue, 3 Nov 2026 11:52:24 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Liam R. Howlett (Google)" <liam@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, Chris Mason <mason@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] maple_tree: Update internal warning and bug_on
 code
Message-ID: <aunI9hG6Qw8IQ1Uk@gremlin>
References: <20261103020724.2614498-1-liam@infradead.org>
 <20261103020724.2614498-4-liam@infradead.org>
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
In-Reply-To: <20261103020724.2614498-4-liam@infradead.org>

On Mon, Nov 02, 2026 at 09:07:24PM -0500, Liam R. Howlett (Google) wrote:
> When CONFIG_DEBUG_MAPLE_TREE is set, call WARN_ON() once per site after
> the custom information is dumped about the tree.  Without using the
> kernel's WARN_ON calls, syzbot will not catch issues detected by this
> code.  The BUG_ON variants now stop instead of dumping and continuing.
>
> Update the non-debug code to call WARN_ON_ONCE() as well.
>
> The userspace tests asserted on dump_stack() but only print on
> WARN_ON(), so make WARN() fatal in maple-shared.h and have the maple
> test exit with the result of maple_tree_seed().
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Lorenzo Stoakes <ljs@kernel.org>
> Fixes: f0a1f866aba1 ("maple_tree: add debug BUG_ON and WARN_ON variants")
> Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>

Thanks for doing this! This covers off my concerns with the userland testing
changes so all LGTM and:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/maple_tree.h          | 48 ++++++++++++++---------------
>  tools/testing/radix-tree/maple.c    | 13 +++++---
>  tools/testing/shared/maple-shared.h | 33 ++++++++++++++++++++
>  3 files changed, 66 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index e30e57f5f3df9..3a9751c6689fc 100644
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
> @@ -713,7 +713,7 @@ void mt_cache_shrink(void);
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> -		dump_stack();						\
> +		BUG_ON(1);						\
>  	} else {							\
>  		atomic_inc(&maple_tree_tests_passed);			\
>  	}								\
> @@ -722,16 +722,16 @@ void mt_cache_shrink(void);
>  #define MT_WARN_ON(__tree, __x)  ({					\
>  	int ret = !!(__x);						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (ret) {							\
> -		pr_info("WARN at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> +	if (!ret) {							\
> +		atomic_inc(&maple_tree_tests_passed);			\
> +	} else if (__ONCE_LITE_IF(ret)) {				\
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
> @@ -739,17 +739,17 @@ void mt_cache_shrink(void);
>  #define MAS_WARN_ON(__mas, __x) ({					\
>  	int ret = !!(__x);						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (ret) {							\
> -		pr_info("WARN at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> +	if (!ret) {							\
> +		atomic_inc(&maple_tree_tests_passed);			\
> +	} else if (__ONCE_LITE_IF(ret)) {				\
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
> @@ -757,18 +757,18 @@ void mt_cache_shrink(void);
>  #define MAS_WR_WARN_ON(__wrmas, __x) ({					\
>  	int ret = !!(__x);						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (ret) {							\
> -		pr_info("WARN at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> +	if (!ret) {							\
> +		atomic_inc(&maple_tree_tests_passed);			\
> +	} else if (__ONCE_LITE_IF(ret)) {				\
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
> @@ -776,9 +776,9 @@ void mt_cache_shrink(void);
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
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index bfe4b8626c429..846c67e20e82a 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36502,22 +36502,27 @@ static void regression_tests(void)
>  	test_spanning_store_regression();
>  }
>
> -void maple_tree_tests(void)
> +int maple_tree_tests(void)
>  {
> +	int ret;
> +
>  #if !defined(BENCH)
>  	regression_tests();
>  	farmer_tests();
>  #endif
> -	maple_tree_seed();
> +	ret = maple_tree_seed();
>  	maple_tree_harvest();
> +	return ret;
>  }
>
>  int __weak main(void)
>  {
> +	int ret;
> +
>  	maple_tree_init();
> -	maple_tree_tests();
> +	ret = maple_tree_tests();
>  	rcu_barrier();
>  	if (nr_allocated)
>  		printf("nr_allocated = %d\n", nr_allocated);
> -	return 0;
> +	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
>  }
> diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
> index 2a1e9a8594a28..5f827709773a0 100644
> --- a/tools/testing/shared/maple-shared.h
> +++ b/tools/testing/shared/maple-shared.h
> @@ -8,6 +8,7 @@
>  #include "shared.h"
>  #include <stdlib.h>
>  #include <time.h>
> +#include <assert.h>
>  #include "linux/init.h"
>
>  void maple_rcu_cb(struct rcu_head *head);
> @@ -20,5 +21,37 @@ do {                                            \
>      call_rcu(&((_p_struct)->_memb), rcu_cb);    \
>  } while(0);
>
> +/* Make WARN() fatal */
> +#undef WARN
> +#undef WARN_ON
> +#undef WARN_ONCE
> +#undef WARN_ON_ONCE
> +#define WARN(condition, format...) ({				\
> +	int __ret_warn_on = !!(condition);			\
> +	if (unlikely(__ret_warn_on)) {				\
> +		__WARN_printf(format);				\
> +		assert(0);					\
> +	}							\
> +	unlikely(__ret_warn_on);				\
> +})
> +#define WARN_ON(condition)					\
> +	WARN(condition, "assertion failed at %s:%d\n", __FILE__, __LINE__)
> +#define WARN_ONCE(condition, format...)	WARN(condition, format)
> +#define WARN_ON_ONCE(condition)		WARN_ON(condition)
> +
> +/* Once state for the debug macros */
> +#ifndef __ONCE_LITE_IF
> +#define __ONCE_LITE_IF(condition)				\
> +	({							\
> +		static bool __already_done;			\
> +		bool __ret_once = false;			\
> +								\
> +		if ((condition) && !__already_done) {		\
> +			__already_done = true;			\
> +			__ret_once = true;			\
> +		}						\
> +		__ret_once;					\
> +	})
> +#endif
>
>  #endif /* __MAPLE_SHARED_H__ */
> --
> 2.47.3
>

--
Cheers, Lorenzo
