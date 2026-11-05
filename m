Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880836;
	b=n9goGMdlSQARvpNw0Q005v+wyT0k/zLYKCIV2OII44YRM1/pC0QchF/ecllukp/kKBUY
	 VMRRB3Aexdk36vEO2Wdg9hmMHQgJhZedRfWQs4cCMOPwBu/G1gGvTSl2F97KiMhdfeSiG
	 5M+KknVYMcfcQdAhQRR+xqeIbltS20IriMxDGTHTfYGOOupRWLdyneIg98ddCiLNynpsF
	 dpihmA1LKDr7K4oDAeiQUzx2ncE4/VmIVdz9Qs/b9ymhnQgF/Gi6lZHKWnHIoippAdUUx
	 Q094P4e+DGp7n6smpvodp6Wgiwoa8IiRP6NIQzgWG/it7MO4EAwTFTdarkOnq7FlONw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880836;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DsqgM0QBvrYpfH6mPkHRfI27cBP6lloybws40MK/kXM=;
	b=AIPaXiKvE5XViF8esgYYMZVTMcb+1mVYWaxj4kSXx64SKejVmKVKFGtrCoTA3Ambn+j2
	 3YoTYSfPUEl68pU10cZFwIb1HnMfGg0fmKM+YAcJQcj0acFfu3i38FpVFA947wv7mdwLf
	 Svd35ypv7JKdbEbB1reSUcY08bhg17Leuypddp7xl9ZziYhxKZJG4rRa60aRazcjuow46
	 PhTiLsHsL/y6OAjX+2MXEfUl3QpWChOa2a2d5y2Juv7SY407PBqF2yVIhCrQhc9OXXeCj
	 fLl6qC3jeV/81cSbM6Iz+ZzQHgUgs/PIAZkXK1w1bhNDGeUOP8R+pfc8j8XbDZGRwcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7YPv1U1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DC606A326;
	Thu,  5 Nov 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7YPv1U1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E5C1F000C1;
	Thu,  5 Nov 2026 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880836;
	bh=DsqgM0QBvrYpfH6mPkHRfI27cBP6lloybws40MK/kXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y7YPv1U168Z/wd7J4xYpngNS5hX7ML71bjwp3Izn2bQqqQ4obuvA3rmaFa03VMkzw
	 L4RbiRYzrnFiAguLYnitjWD0QX1Vh42s/IFGaKaf9flEThRcJNI5arvUARepwpnIIL
	 qZXToYJLvw9vnhQItEMfWSVB5wd+GcHH55TpZCVHWNq3RAUKCb3iJRh6rBj6qWP5QH
	 k0F5mvzZcvmCtlrDPf4LQDBRHGr6Cy3d7e1H7/nSPsn0F1xxhb8ths0yNEWYD/j4xS
	 kVAdgEoyNEZjUha53+CI0InOFE/L69Zz2KFw+Bi0az2nj1zD4it3f/YMw2Z+0tNeQq
	 cdQO2ASRQjqxQ==
Date: Thu, 5 Nov 2026 17:43:50 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: Georgiy Osokin <g.osokin@auroraos.dev>,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] tee: shm: don't warn on an oversized page array in
 register_shm_helper()
Message-ID: <auxy_pv57awSTf2m@sumit-xelite>
References: <20261023210238.551855-1-g.osokin@auroraos.dev>
 <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com>

On Tue, 03 Nov 2026 at 19:34:08 +0100, Jens Wiklander wrote:
>Hi,
>
>On Fri, Oct 23, 2026 at 11:03 PM Georgiy Osokin <g.osokin@auroraos.dev> wrote:
>>
>> register_shm_helper() sizes shm->pages from the length passed to
>> TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length above
>> 2 GiB makes the array larger than the page allocator can serve in one
>> block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_warn
>> kernel that is a panic.
>>
>> The size comes from userspace and the request fails with -ENOMEM anyway,
>> so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
>> warns above INT_MAX as well.
>>
>> Fixes: 033ddf12bcf5 ("tee: add register user memory")
>> Cc: stable@vger.kernel.org
>> Cc: lvc-project@linuxtesting.org
>> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
>> ---
>>  drivers/tee/tee_shm.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 6742b35..d539988 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>>                 goto err_free_shm;
>>         }
>>
>> -       shm->pages = kzalloc_objs(*shm->pages, num_pages);
>> +       shm->pages = kzalloc_objs(*shm->pages, num_pages,
>> +                                 GFP_KERNEL | __GFP_NOWARN);
>>         if (!shm->pages) {
>>                 ret = ERR_PTR(-ENOMEM);
>>                 goto err_free_shm;
>>
>> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
>> --
>> 2.54.0
>>
>
>Looks good. Sumit, do you agree?

Yeah, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit
