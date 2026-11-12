Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488169;
	b=cLoHSkAS0bBbyMUKXgFKxQ6/tS2kYah7IIW9CPfdb5wU4DhQZ7zmRGEKOV7Jb0y/yw0z
	 mCZdhYzMKCoRMjxfjJPauDB/m2OQMa7X37TRENgsyu8/2fxCv6jP38l7fIvjYo/cC647p
	 1/x7c2POCm69fwGSIMSqcsKfpfxOWYxptvd7JrVJz6V6QA+PNHm1+ztrXDZHW1qp49K9/
	 JUba/UB5TTCmgMZ55gfjS8TR/nNXVg7qv6ZS9HRaJfEPYOFFhaWdJdnLRvWkMXvut3zal
	 TtkjCHaavov9EwfIMu69Q9Lh5BOgdfi6Iu2lcSjzZhgDdgl5mdcV51Uw15Ym0PRRjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488169;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=9zpmpXZL2AGBZ7N2dDO3aafaZXcocghDPR43dgCZPFw=;
	b=rin0bk7nEaLZi4HkMn8iFBcu27Dia5jqVTNiUuLLa9znqq+wDAj1Tr42cTsSWPdoahM4
	 AX4q5cBkQZRqn2yFoYsFGcJUQBi4GKYb25dmKHaQ4GjBK9Gi19lgOlpHfvqkj8fnXNSgq
	 SkvK/MqjxOYMwh3JLAoHxGWUyfLi7z4clSd2HjUqjPaAhIMtYxz5G6rSUnZm4XJdTty92
	 5bvBTdl/KITzhRkX5Ugpqgk1Qm8zOF9cwEVu2BWvN7q/Bu4kDvdWC7yQcD1hongELQuq3
	 KbIv4/p8d20s6kP5vQAeA0+zpAsLsP8DXLBgOc16DnRomRPyOLcURHX5Qqi1zmYVSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ME2y9xyQ;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B52606A321;
	Thu, 12 Nov 2026 12:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B52606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ME2y9xyQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9zpmpXZL2AGBZ7N2dDO3aafaZXcocghDPR43dgCZPFw=; b=ME2y9xyQSgXxQ/87K9tSVQ83O7
	F2/nflMo9ecPeWDp1J8M4EtGVEIs1AEiHz6LQd1v9htvVHsjsSY2UrEeH9yOH1gw/6RxOfsGcrZHM
	1BQoJsBMcG+J3UXC35OcOz3qXJgXim4CTnqYStGIitVvQ/LGQpRYB2NjvEAnNgVbfnU0Q88kGHIVS
	L+Nctk2b3FYbw4P6c9AaTeZIBYJfA4zOhViJEknSQfYjIvKHIqVL43in3T9oLi0hSJmrvM25DJ1MU
	JQfnrcYzZX/xM+Ho6zCKi8RB7SKoLT/dF2nMh+XgBhn1gZLPT2YfjDp3LoVzVB+VNDnN75edvgIWI
	kZH9hgYA==;
Received: from [::1] (port=58526 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xRULY-00000003KjR-3O2T;
	Thu, 12 Nov 2026 13:56:06 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 13:56:06 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush
 Yadav <pratyush@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] ima: fix kexec measurement buffer overflow after failed
 loads
In-Reply-To: <0d1363e419054c1aa1b0bfee645314c7e4aec0f5.camel@linux.ibm.com>
References: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <0d1363e419054c1aa1b0bfee645314c7e4aec0f5.camel@linux.ibm.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <4edd198bb0e2b6010b438701994394e3@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-12 03:07, Mimi Zohar wrote:
> On Sun, 2026-11-08 at 19:04 +0000, Jérémy Jean wrote:
>> When kexec_file_load() fails to install a new image, it can leave the
>> global IMA scratch buffer larger than the IMA segment of the current
>> image. When that image is executed, ima_update_kexec_buffer() copies
>> the larger log past the end of its reserved segment. In a test, KASAN
>> reports it as:
>> 
>>   BUG: KASAN: vmalloc-out-of-bounds in 
>> ima_update_kexec_buffer+0x265/0x280
>>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>>   ...
>>   Call Trace:
>>    ...
>>    __asan_memcpy+0x3b/0x60
>>    ima_update_kexec_buffer+0x265/0x280
>>    ...
>>    blocking_notifier_call_chain+0x88/0xb0
>>    kernel_restart_prepare+0x18/0x40
>>    kernel_kexec+0xe4/0x130
>> 
>> Limit the dump to the smaller value between the scratch size and the
>> installed image segment size. Update the IMA mapping only after
>> machine_kexec_post_load() succeeds.
>> 
>> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to 
>> execute")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> 
> Thank you for the report. I agree with Mike that the 
> machine_kexec_post_load()
> reordering should be a separate patch.
> 
> For the overflow, rather than clamping at execute time, how about not 
> changing
> ima_kexec_file.size for an image that isn't installed?
> 
>   1. Set ima_kexec_file.size only in ima_kexec_post_load(), from
>      image->ima_buffer_size, and stop ima_free_kexec_file_buf() from
>      resetting it.
> 
>   2. Reuse the buffer if size >= segment_size, instead of only if they
>      are equal, so the buffer is never smaller than size. The buffer no
>      longer tracks size, and with staging the list can shrink.
> 
> Please don't remove the "segment size can't change between kexec load 
> and
> execute" comments. They are still correct.

Dear Mimi and Mike,

Thank you both for your feedback. I tried to took them into 
consideration
for the v2 I have just sent. As requested, I split the fixes into 
different
commits, and try to address the bigger problem in this new version.

Best regards,
Jérémy
