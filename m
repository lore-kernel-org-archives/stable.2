Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507496;
	b=I8SPkh4XzUbN6f2Wi0xn8TIh+Hs5hWC8UxsCDWWS7yaMyF5UCNXxGnKEXQki92X613rq
	 S52Rnxh/yHNYUyQUxwNWnl1u85/n/37gSekbi8hbIBuIlQk22bzOvkQVjhGLEF9wTkJHP
	 RrvBIM7ioHHzUrdLN1qyCsZH32PFZnWToxG/N9CnzMo/qpFi+/0CQsPkjE4vrfyPgeokg
	 a38C8MDocaRKhRw/JfzGE1Lkf21Gu3a0lqRebyEJzLLHcrydU3tASuD72ksrbPheR1IpK
	 WRs8kFu/bik4RSTen6fL1T8N5XmG1cMkFCuCRwxLH7LdbKHmH1P09Ygd85J7pw10pUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507496;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Hs9uypOQfbHnpPTNW01WGbHmNfbbsXyvVNcORTX/v4U=;
	b=toPMQirQokue0U2SQwHCmoInLEOPnBgeEWBJmrPNqKSU8B0d5oCHAUCpyfhaKC/YfuPR
	 iEFp489uitSZZWsC5lX5NL2SXOxs4DJMLkY/mqYYrnq39oTUhVGu4oYHVmUq9Gb1B6DR2
	 0eRIrOuZV+PldoSvRXkakG6mgoaXQDFDqEhOqWiiyg1K6rI01LHal5odnd1lnFFEdVICi
	 uux4ryZ8GUnsRlpgk9+lXZt6rb0lEf38H9RdGirdecsLBwsfC1V9bKBXgWu2ubumA9WXb
	 N6aduD/vNAR732SCrPZCxGerZ7kkFfNF8d7hQTqsPyMO8nmkEZ9u16NiYo1UQAinyrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFe2Ckdo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBF606A31E;
	Tue, 24 Nov 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFe2Ckdo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994DB1F000C6;
	Tue, 24 Nov 2026 08:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795507496;
	bh=Hs9uypOQfbHnpPTNW01WGbHmNfbbsXyvVNcORTX/v4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CFe2Ckdo05q1ECZMujaLOsgd95d45YaQcTFQjQENKNZOWMloqihcy4iIcN9C7Gq+k
	 RD3lbkHVphvpE39yR5DHEofBUlYLbLvm3Lb9B+7EX5HwMJj2xmNb/3WMCPXPCylXCZ
	 SkKnV1X6dv0b9abphEgwbPKztrMAtNrmJBGzH4sn5tzqjYVotq6hYDgErV4MUwzFB0
	 fiw9Z3wdVQxhZUoauY61BLbBVAhKRBY1MsjEQZABlB6K0N7H1UEXl3n2x6Kb2wiGD7
	 cC8B/cFFDrTJ3RiQ36WZnqJrEaeJiTSUfb/DgrKAErk45XfLJsipmq/HBFbVAbE3oW
	 gI9p7mB0NmQwA==
Message-ID: <c4f270f1-3196-4ae0-8a7c-7b61155285ca@kernel.org>
Date: Tue, 24 Nov 2026 09:04:51 +0100
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
Subject: Re: [PATCH v3 3/3] selftests/mm: verify ksm_zero_pages is not
 inherited on fork
To: "Xu Xin (vivo)" <xu.xin@linux.dev>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 donettom@linux.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261123034136.209410-1-xu.xin@linux.dev>
 <20261123034548.237302-1-xu.xin@linux.dev>
 <16d172a9-bf5c-4a69-93d1-b48cd53b67b2@kernel.org>
 <awT6Yc/rFuyp2r13@dgvxl46587.localhost.localdomain>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <awT6Yc/rFuyp2r13@dgvxl46587.localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 03:45, Xu Xin (vivo) wrote:
> On Mon, Nov 23, 2026 at 05:49:30PM +0100, David Hildenbrand (Arm) wrote:
>> On 11/23/26 04:45, Xu Xin (vivo) wrote:
>>> Extend test_fork_ksm_merging_page_count() to enable use_zero_pages and
>>> merge zero pages alongside non-zero pages before fork(), verifying that>
>> neither ksm_merging_pages nor ksm_zero_pages is inherited by the child.
>>>
>>> Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
>>> ---
>>>  .../selftests/mm/ksm_functional_tests.c       | 44 +++++++++++++++----
>>>  1 file changed, 35 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>>> index b871d5656688..0e128c579d5c 100644
>>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>>> @@ -655,45 +655,71 @@ static void test_prot_none(void)
>>>  	munmap(map, size);
>>>  }
>>>  
>>> -static void test_fork_ksm_merging_page_count(void)
>>> +static void test_fork_ksm_statistic_count(void)
>>
>> "statistic_count" sounds odd. did you mean "statistics" or "counters". Below you
>> use "stats".
> 
> Yes, I meant "counters" (my phrasing was inaccurate). I will rename it to
> test_fork_ksm_counters() in v4.
> 
>>>  	}
>>>  
>>> -	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
>>> -
>>> +	ksft_test_result_pass("ksm_merging_pages and ksm_zero_pages are reset after fork\n");
>>> +unmap_zero:
>>> +	munmap(zero_map, size);
>>>  unmap:
>>>  	ksm_stop();
>>>  	munmap(map, size);
>>
>> This ordering is odd.
>>
>> Why stop in between?
>>
>> Also, I suggest using a single label, like:
>>
>> char *zero_map = MAP_FAILED, *map = MAP_FAILED;
>>
> 
> Agreed, the ordering was just kept from the original code and looks odd.
> I will unify this into a single cleanup label in v4, unmapping both
> regions cleanly before calling ksm_stop().

Thanks!

-- 
Cheers,

David
