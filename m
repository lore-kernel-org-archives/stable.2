Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC32E06EF;
	Mon, 31 Aug 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160410; cv=none; b=fBJ82GN/gy+Mb/OrW4QeN/4rmb+z11tH+rJXJSPSzUUcmgZqjo9UjLQaRVBolP+JN8sWU4/qg3CAZY2TPitPJtYoswoDqJ2aZ2VA4ej9nZaZRQbqW5sSxjc6Ug9SPC82gV3FHmS+dqNxxPABngY8clTzuE4Llz1v+Zo/yntElaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160410; c=relaxed/simple;
	bh=46yFgve1CkzxL+QCcHH4HuvMCOJS22cKvWyl12A8JWQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DbJqTfv6zfc+U8WrfLpGnSqMCNG4EqbapTu68oQWplZZje1McoJ6SSDDDqjHae4snNV0PuJ37Dd6Mg9VWRvPIFT6ctgybJIAxJG51hUcQU1LIwrqBa2WIRB3yFCqS0JPdGJG/F5c9fG2ZdaqNnscDpFzjWNWvd9zpXWn+JHSCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVjeUAjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVjeUAjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC9A1F000E9;
	Mon, 31 Aug 2026 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160408;
	bh=0M6Hrs6288hztdqkb+2qq5X4G5RhlUeX9M9G/um6NV8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YVjeUAjLYX+dBGDms0EyyWQWUUKCwUAmfYC5lWMo1CiQVh0nAHR5TkE4Y5Mg1emph
	 24EjTcD8wA5ADmhR1iG8lfH2O7UaYM5Ti8scrcUe4RTgvnjJo0NjlFo71kHHA67CzQ
	 IwnADlLfQUT3MEF+ne+pHnF6Z4xhFB28zCSh6RY3ijfIecVDZKzO2gzWy4X8wxAwBb
	 3PgIt0RQyUJBDBwSlaRiYbctql+q4HRRG5FXXYmDSOurkrESEU1ZRmwMjQxrqWdlsw
	 9Tvy19LRUiG6iVHzWbENe6K0nB84/H3q/1+bxo28F4UVicDMkcnEBR7sZkLioYcn8z
	 nWdibIAqwlD8A==
Content-Type: multipart/mixed; boundary="===============1819113174079314233=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2db5c0839797c4c8e938bcda957fc96641a8ee63cb04e1df7d41d82126652b86@mail.kernel.org>
In-Reply-To: <20260831063226.621309-3-chenyuan_fl@163.com>
References: <20260831063226.621309-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Add regression test for queue/stack map size limit
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,chenyuan@kylinos.cn,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 07:13:28 +0000 (UTC)

--===============1819113174079314233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e179..a01a0bcbdee7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> @@ -2,6 +2,8 @@
>  #include <test_progs.h>
>  #include <network_helpers.h>
>
> +#define U32_MAX ((u32)UINT_MAX)

This isn't a bug, but would using UINT_MAX directly at the single call
site read more simply than adding a U32_MAX alias, or is the alias worth
keeping for symmetry with reg_bounds.c?

The macro appears in prog_tests/reg_bounds.c where it's part of a family
of short number-type aliases used by that file's range-printing tables.
Here it has exactly one use as the max_entries argument to a
bpf_map_create() call that takes a __u32, so plain UINT_MAX would work
directly.

> +
>  enum {
>  	QUEUE,
>  	STACK,
> @@ -101,8 +103,35 @@ static void test_queue_stack_map_by_type(int type)
>  	bpf_object__close(obj);
>  }

[ ... ]

> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	int fd;
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1000000, 8192, NULL);
> +	ASSERT_EQ(fd, -E2BIG, "queue_oversize");
> +	if (fd >= 0)
> +		close(fd);
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, NULL);
> +	ASSERT_EQ(fd, -E2BIG, "queue_u32max");
> +	if (fd >= 0)
> +		close(fd);
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, 1000000, 8192, NULL);
> +	ASSERT_EQ(fd, -E2BIG, "stack_oversize");
> +	if (fd >= 0)
> +		close(fd);
> +
> +	/* A normal-sized map must still be created successfully. */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, NULL);
> +	ASSERT_GE(fd, 0, "queue_normal");
> +	if (fd >= 0)
> +		close(fd);
> +}
> +
>  void test_queue_stack_map(void)
>  {
>  	test_queue_stack_map_by_type(QUEUE);
>  	test_queue_stack_map_by_type(STACK);
> +	test_queue_stack_map_alloc_check();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33365692838
--===============1819113174079314233==--
