Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3417A300
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925805; cv=none; b=WhtJxz30LC4sUgRDljNdhl4/UpydvjOyzyOt6uSnGKOTo1bTMe5AIXVhdM1+0vTrIQOL0DGhuLVlRyL7wJ1bnyQSyuSrEoDoschLG+F8SqFLiuAtCjuPNcrC7A/cUlKdcXaGlTUZQx56o5RGSEwk7HH0/GrjJ1Mrhnh8pPoT+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925805; c=relaxed/simple;
	bh=1S4t/bd9Acp+A0Rb7ye2I50Hz9GjrmnkLGLh+nobMYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InrEPTPHq2CKaqdCr4ST0wSJC+KHcPGNsmnDml5wWbAqkdu7mGX8lIRUj1KVeuj5eJygSSZsFR0PMkKeGmUCedYO8VF8vMJ+TzUlmYbpd4scE2ahl/5OA80wydQduU9rJ01QH5q73CACWz9cHaUdBKnT7l7cVxp6dwkbibTA4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=rFR7crQN; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="rFR7crQN"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 7EC9E1D4A2;
	Mon, 13 Jul 2026 06:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 7EC9E1D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1783925802; bh=1S4t/bd9Acp+A0Rb7ye2I50Hz9GjrmnkLGLh+nobMYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rFR7crQNkFydK5kX8apYWuk9jNY8qCboDRlGGkrouWAJgmg+cHCaglyjX+mU2b+j5
	 4GT7kfVSRAicm3WAPCLytV0PchZFkM65kNIjlhwaLWluk3+hvwCYU+TvjieHftNvoi
	 ahDRxb9ztRBrMDMedkJUwioN3aSjQQGhkebKA0dI=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id R5j+CymMVGq5wwIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 13 Jul 2026 06:56:41 +0000
Message-ID: <ddc6ffcf-0981-41d2-811b-cd46d5ae5c52@dev.snart.me>
Date: Mon, 13 Jul 2026 15:56:39 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] exfat: bail prematurely from exfat_extend_valid_size()
 upon fatal signal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Andy Wu <Andy.Wu@sony.com>, Aoyama Wataru <wataru.aoyama@sony.com>,
 stable@vger.kernel.org
References: <20260713061954.19557-1-dxdt@dev.snart.me>
 <2026071352-bunkmate-anymore-0962@gregkh>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <2026071352-bunkmate-anymore-0962@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 15:53, Greg KH wrote:
> On Mon, Jul 13, 2026 at 03:19:54PM +0900, David Timber wrote:
>> commit 82a81a7352bcf5f2756ac33d47ee0582737e9a85 upstream.
> No this is not :(
>
> confused,
>
> gre gk-h
I'm sorry. I know. This still under review. Stupid git send-email cc'd
the list address.

Davo
