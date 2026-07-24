Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73625364EA4;
	Fri, 24 Jul 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876347; cv=none; b=lp0/X9SoAyqYnfr8aLzv9F5Hj9zuXMmlIm4q12TbYZPWqy44Ed2fGO/WjGy8Kge9lF2uGT3TSM+Tq+OIaWV5CSNCF/PmdeERt3Fjk2Gfez1k0DgGGD1o5iv6cGPYo0oSqnl2kjS8VgRYN/1LbGe1oWk6isXBx4DNIOSqXpDLTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876347; c=relaxed/simple;
	bh=8cCYuV4DbfXkYj3PXfKCrn+j7b2Q7tOwHxIUQtUYcj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxmSMN0gw7WJsGKRlLWnuhpNCfX+VKExNxBl+Wh06vNAD0fh68/zoVUArpYuTH2gvOt9MJEDjfDFVmbHsYwjmrMVNvbVUH39wqqlnA34LN9hE9RUhlKCGydpumB0iFNo+HPcawo4eJQrrF74z6WHRqvLdatDjAABN7bxUqy9z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp34s3NV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp34s3NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA51F000E9;
	Fri, 24 Jul 2026 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784876346;
	bh=34W2CxNb0au0JerO6fdh6L8z/2HIrfq4Md0cDdHE9iQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hp34s3NVUDrcNbtQ3Wnm7+hmu6KzrtE6LI+1U404vlLV99F7l5BFzc2AN+CbtD3Jz
	 PSpBT32hcQp7D0VXRv++BhvsB32HBZhcfS7lHAKwEdr2/m3JOi2/U2IvZ4mLSWUsCv
	 jjann1p05IrnIDT4xPcgLVzt1oMlHzsJ2NaI74rqlO7CQ8i0hCn4AtyJvE52tq+Fz6
	 S1FMUe15cAijX4qrFqq3U77PEU/UGHKV/MBF7C2iVmAwSgB2AuGQw1nOu7aZK1BO4z
	 SKS8tGKLJtvBh4jJo7ndSceucKD3McDEUBKUOTpzgv4N0fMCd8nXRnrYbcXdiwwYrQ
	 5+u5zb4po7BBA==
Message-ID: <e7327736-219c-4475-84db-a25a25d1ec1d@kernel.org>
Date: Fri, 24 Jul 2026 08:59:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib/ucs2_string.c: fix out-of-bounds read in
 ucs2_strnlen()
To: Greg KH <gregkh@linuxfoundation.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20260723-fix-ucs2_strnlen-v2-0-9ea94e32a358@kernel.org>
 <20260723-fix-ucs2_strnlen-v2-1-9ea94e32a358@kernel.org>
 <2026072454-riverside-nuzzle-39e2@gregkh>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <2026072454-riverside-nuzzle-39e2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2026 at 07:54, Greg KH wrote:
> On Thu, Jul 23, 2026 at 09:40:31PM +0200, Vincent Mailhol wrote:
>> ucs2_strnlen() checks the current character before checking whether the
>> caller-provided maximum length has been reached. If the input is not
>> NUL-terminated within that bound, the loop can read one ucs2_char_t past
>> the limit.
>>
>> Test the length before dereferencing to prevent an off-by-one
>> out-of-bounds read.
> 
> That's fine, but doing that read doesn't actually "hurt" anything,
> right?  So this shouldn't be needed in stable kernels.  Or am I missing
> something?

I had a similar feeling and didn't CC stable on the v1. But following
my exchange with Andrew here:

  https://lore.kernel.org/all/CAMZ6Rq+Ax5MTs0Ke=XAB2JFX1KXuFas3B2eEMv+nQ4x7up2BLA@mail.gmail.com/

I think there *might* be some risk and finally CCed stable in v2. If
you prefer to not backport, that's OK for me. As you can see in my
above message, even if the risk exists, it is more theoretical and I
don't think it would provide much leverage to turn it into a real
exploit.


Yours sincerely,
Vincent Mailhol
