Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452236;
	b=skXshbvF3D+XiA6j60LqN604gFYn7h+kwx7x5L119HrXcJu5f/uQc1qWEE7r+/gDb6Wl
	 nauSnKHj86BCJdku76HepAGjwmiDS+aqs+Wi9BBzdD4jkag3sBti3pucWPXZ+FnenTNJw
	 4A7qm3Tjis06vT7t3IpnXYb2BIphg2FT1LmkIdzMH8OaKhYbHj1DBsU9AO3eY+27TRYOV
	 P38bQrijYw2J4JG8c+YM0rahoyN22Duu1jq8NJzXjyAW1gLKBSjr1V6/aBFn0dhpUreVM
	 ZJI9Oo9jmMxJjPJZUjfZ7yvm7r+GZq9rq2Ba0TK437cx+WzVyFFf7XHxk/9J4jjX+OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452236;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rs+CcN71c0Fi1/KME24fU/+FqAEJoRqbsSd1mHJLo5s=;
	b=GVr76JWXJX7SYZ8J0mBj/HmXq6iozY2DedT6iZs9DaaIgzYTUCsM/QUDyF2Y/QhHJZes
	 fJxI9X/8g8Jb/UqiiFiPqbt2TlLrQ53sj/NIF/PZ7asFEiqTZF/EwwZc+v/1Fm5TECIDb
	 XFQ1yLPLN24uxODQFbXw89FbHpsZDRgzB0etAUP6s0kBIxW/YuUGgGRfeiDvpe8zFVfp7
	 k/9xmp+OfbcJyE8cAEviobqkq5vXZwaJTNUyCFKwlNuEXU0iMYvlhfLDe+EuMTAC/LTHI
	 1GqIwTH2vzZxnWzwtSUZMR29ca8NE92PTKlwJhwsXgZ//c7+CtwN75jnJ9smNm4MhyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUIJxoyw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D6D606A31A;
	Mon, 23 Nov 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUIJxoyw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184B11F000D0;
	Mon, 23 Nov 2026 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452236;
	bh=Rs+CcN71c0Fi1/KME24fU/+FqAEJoRqbsSd1mHJLo5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eUIJxoywufebTbJfzuPZAEBRRY74GRd1ScI2vtPbTncPWSZ6v5NL0meYpV84J0aSL
	 EoQmp7bLEyLIr6yEDDVn+ySZ3daJiu7s4mGkeoGF1XF3YTZ/kuEoBRoGUH6YKEVq+p
	 wgYPVt9yuBDFwbAUalV9l7yifFlNEOOAcOOiUQ2nWKoNBZC0in9aBrSKqLdq6J94iu
	 +pYQZIZ2YWO/6FOaGn4nIci1NxbLY/RL6j8LOIxOt7sCh0YglUVA+GzVHaVE/0H10X
	 SeNCwVDQ7Uk4k5mbl4Cb4IvQVt2psJ5yjJRz2TUH9mBUn8LoWKpsHv0bqaTbmcxK8L
	 Zzr4NldKiCy9Q==
Message-ID: <ccd35073-e77a-4864-ada0-4b43329e8ff4@kernel.org>
Date: Mon, 23 Nov 2026 17:43:50 +0100
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
Subject: Re: [PATCH v3 2/3] selftests/mm: fix false-positive and racy KSM fork
 test
To: "Xu Xin (vivo)" <xu.xin@linux.dev>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 donettom@linux.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261123034136.209410-1-xu.xin@linux.dev>
 <20261123034517.236914-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20261123034517.236914-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 04:45, Xu Xin (vivo) wrote:
> Currently, test_fork_ksm_merging_page_count() passes wrongly even if
> fork() fails to reset mm->ksm_merging_pages, because the child process
> calls init_global_file_handles() -> ksm_stop(), which unmerges all KSM
> pages across the system before reading its counters.
> 
> Fix three issues in test_fork_ksm_merging_page_count():
> 
> - Drop init_global_file_handles() in the child process so it does not
>   call ksm_stop() and mutate global KSM sysfs state (unmerging all KSM
>   pages across the system) before reading its counters.

Right, that's not required just to access proc_self_ksm_merging_pages_fd.

> 
> - Use '!!' in exit(!!ksm_get_self_merging_pages()) to avoid 8-bit exit
>   status truncation (e.g., 512 pages on 4 KiB systems truncating to 0).

Ack.

> 
> - Introduce ksm_pause() to pause ksmd (write "0" to /sys/kernel/mm/ksm/run)
>   before fork(), preventing ksmd from scanning the child and incrementing
>   its counter before it is read.
> 
> Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
> ---
>  .../testing/selftests/mm/ksm_functional_tests.c  |  8 ++++++--
>  tools/testing/selftests/mm/vm_util.c             | 16 ++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h             |  1 +
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 135191f99962..b871d5656688 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -668,10 +668,14 @@ static void test_fork_ksm_merging_page_count(void)
>  	if (map == MAP_FAILED)
>  		return;
>  
> +	if (ksm_pause() < 0) {
> +		ksft_test_result_fail("Stop ksmd from running failed\n");
> +		goto unmap;
> +	}
> +
>  	child_pid = fork();
>  	if (!child_pid) {
> -		init_global_file_handles();
> -		exit(ksm_get_self_merging_pages());
> +		exit(!!ksm_get_self_merging_pages());
>  	} else if (child_pid < 0) {
>  		ksft_test_result_fail("fork() failed\n");
>  		goto unmap;
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index f26f9e4bfdbe..e638475543e6 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -1080,6 +1080,22 @@ int ksm_stop(void)
>  	return ret == 1 ? 0 : -EIO;
>  }
>  
> +int ksm_pause(void)
> +{
> +	int ksm_fd;
> +	ssize_t ret;
> +
> +	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
> +	if (ksm_fd < 0)
> +		return -errno;
> +
> +	ret = write(ksm_fd, "0", 1);
> +	close(ksm_fd);
> +	if (ret < 0)
> +		return -errno;

Could close() fail and set a different errno? Unlikely I guess, so this is
probably sufficient as is.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
