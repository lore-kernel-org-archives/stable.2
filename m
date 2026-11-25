Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602870;
	b=eU1/AHV4lliJDm1SW19px2wj+So5b4bD/BCI2QBHrx3gG+x/qVepQOp2laqwtqWOD+Pj
	 YtS+gtxWFE/YoaIM68TQC4cbyXu6R9Rv/+YuM6nqvrfsGFUjOgNRH8B+HT4nFWs94dnPP
	 81FVp50n1JdmcJkMTzEHQFhH+IYfxOJyd0J6Q9hZs5qXeoUnkz5OY8+FdKWjkY3GX+g69
	 6D3ZeyhGwIKDwNjLPJzItLJb2CEgToJJF6VAM/9vSUYYbccxeO+Gt2cTne/2bjIdy5wSq
	 vmDZuC3B2zVFhlxoO8h87G5GmkfX8Gzixg7elniHzjdzCtetAcTwNv+cE0GYi/ZSFkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602870;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=tdhya22vdyYIHSX3+fZBmoDZgCjZPvVDp6y5gPGmsak=;
	b=qc5pA7281+3E/sqFShKOvmz4bYBZNgUs0S5JTKM3GrIlDj7uIGoNHKl2mGZ12LGOlqTP
	 po3aQtadUc8X7gzW/PzMQZgL58FVCj4BHLDE6Hpi13sh+27ZVHlIf7Cbx1rPh44xBDriS
	 Mn71WHyJTQMfUQljBWvyXnUi5xRKtMWKtra9Br9DVA2pe5v/nQafTFC7XoVGfdqJYLaPk
	 EgsAP+sG/Bg9dIGkmKgvtcIOTRFI6fZC+CURYy2htfSjss4UywJ8fKcqPkdSJIbx+3k0l
	 fOnrWY3YrAXB//70xW3Ut33n7Y0Yp2ZhFSngwpvSODxsWsuEdINWsgfF4Ap9bzSJEbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iN8YpcPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898D606A6AD;
	Wed, 25 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iN8YpcPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267CF1F000ED;
	Wed, 25 Nov 2026 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602870;
	bh=tdhya22vdyYIHSX3+fZBmoDZgCjZPvVDp6y5gPGmsak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iN8YpcPFgLq3Ri2n1gAGC2nZHiJrncVd6M197DiLdAr6J3kBkQHzdePhkrTwL80Km
	 v+aUnoO+CihNtpRc5OksZRDrS8ItGPFovfQAkctmKtJ2zdm8POxTPYt6lp635YOprP
	 i/CaMLVJCeIEjJyAXEIY7+T14JN9zgkvUn9sxo7g9RsaYmYQpAKo8gRoAwkr231egk
	 PS2shCOzZF4qHeID18481dK7TIoRJH52+2LxCOOdQp96IjFubsXBZfDK9+b9WcgakK
	 tC3pWrNE6ua3I/xS0lNteS6g+/LkZlbSFZq3dPJieIYPCaSaA9z43r370Z5ENQbvBf
	 z5pa6SJvPV7Jg==
Message-ID: <4d9417a1-eb75-4507-be86-a544437e3abd@kernel.org>
Date: Wed, 25 Nov 2026 11:34:24 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] selftests/mm: verify ksm_zero_pages is not
 inherited on fork
To: "Xu Xin (vivo)" <xu.xin@linux.dev>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 donettom@linux.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261124130143.128411-1-xu.xin@linux.dev>
 <20261124130343.131760-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261124130343.131760-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 14:03, Xu Xin (vivo) wrote:
> Extend test_fork_ksm_merging_page_count() to enable use_zero_pages and
> merge zero pages alongside non-zero pages before fork(), verifying that
> neither ksm_merging_pages nor ksm_zero_pages is inherited by the child.
> 
> Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
> ---
> Changes in v4:
> - Rename test_fork_ksm_statistic_count() to test_fork_ksm_counters() (David)
> - Unify cleanup into a single label and munmap before ksm_stop() (David)
> - Fix phrasing in log messages ("Reading KSM counters failed", etc.)
> 
>  .../selftests/mm/ksm_functional_tests.c       | 44 +++++++++++++++----
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index b871d5656688..7aadce09e6c7 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -655,27 +655,51 @@ static void test_prot_none(void)
>  	munmap(map, size);
>  }
>  
> -static void test_fork_ksm_merging_page_count(void)
> +static void test_fork_ksm_counters(void)
>  {
> +	char *zero_map = MAP_FAILED, *map = MAP_FAILED;
>  	const unsigned int size = 2 * MiB;
> -	char *map;
> +	long merging_pages, zero_pages;
>  	pid_t child_pid;
>  	int status;
>  
>  	ksft_print_msg("[RUN] %s\n", __func__);
>  
> +	if (ksm_use_zero_pages() < 0) {
> +		ksft_test_result_skip("Enabling use_zero_pages failed\n");
> +		return;
> +	}
> +
>  	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
>  	if (map == MAP_FAILED)
>  		return;
>  
> +	zero_map = mmap_and_merge_range(0x00, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
> +	if (zero_map == MAP_FAILED)
> +		goto unmap;
> +
> +	merging_pages = ksm_get_self_merging_pages();
> +	zero_pages = ksm_get_self_zero_pages();
> +	if (merging_pages < 0 || zero_pages < 0) {
> +		ksft_test_result_skip("Reading KSM counters failed\n");
> +		goto unmap;
> +	}
> +
> +	if (!merging_pages || !zero_pages) {
> +		ksft_test_result_fail("KSM failed to merge pages before fork\n");
> +		goto unmap;
> +	}
> +
>  	if (ksm_pause() < 0) {
> -		ksft_test_result_fail("Stop ksmd from running failed\n");
> +		ksft_test_result_fail("Stopping ksmd from running failed\n");
>  		goto unmap;
>  	}
>  
>  	child_pid = fork();
>  	if (!child_pid) {
> -		exit(!!ksm_get_self_merging_pages());
> +		merging_pages = ksm_get_self_merging_pages();
> +		zero_pages = ksm_get_self_zero_pages();
> +		exit(merging_pages != 0 || zero_pages != 0);
>  	} else if (child_pid < 0) {
>  		ksft_test_result_fail("fork() failed\n");
>  		goto unmap;
> @@ -688,15 +712,17 @@ static void test_fork_ksm_merging_page_count(void)
>  
>  	status = WEXITSTATUS(status);
>  	if (status) {
> -		ksft_test_result_fail("ksm_merging_page in child: %d\n", status);
> +		ksft_test_result_fail("KSM counters are not zero in child\n");
>  		goto unmap;
>  	}
>  
> -	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
> -
> +	ksft_test_result_pass("ksm_merging_pages and ksm_zero_pages are reset after fork\n");
>  unmap:
> +	if (zero_map != MAP_FAILED)
> +		munmap(zero_map, size);
> +	if (map != MAP_FAILED)
> +		munmap(map, size);

For that to work you have to initialize both to MAP_FAILED above.

With that

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
