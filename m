Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609529;
	b=nPfrQrnxtiJTXEbMN7KjM41rPMubCts6kq7foSccKwgCydL4IyQSF2iFERtGHDadwiXV
	 gXFsbhzOXSFuYAR87txiRFl0ZLlb587TOLoGWiyKMIb827vgJ9qKEXiHE46hFopIrUaAl
	 8TeZcbKueZbVI9tqnyrN+suwT1AcIZXcHBlHMp58QVzBAeANKb3m0Z/QokQbr2AzQ1rVT
	 ZPUBrcu95dKL5UpPv0tatWx+MZ+TYcU/eurDGa3GjIS1arXwt0DcDjPy3wbT94s2QCUg+
	 bqHmKtf0MGoz4jn993swuAJ88wZB4AbvfsRG+X4ZXpBXf6g7T/EE85mL0WkUFV3V9+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609529;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3cweuxzJfLVp8WrEgRssiB6rvSwpbNFQB7nXvM8QjKs=;
	b=gh5Y9yEKXOdJT1+rzbi6QH7qMsxoPJwufs0slAl6ikvpQDK5c29uvofLsM0cNrM+spqz
	 Awrc4wrkOocM34BXJ88vqk5XGV6uEQjVQHcBumtj13y7IZAtLo+x4HhjMkZtez29a0/hy
	 3brNUFg8PWCaDkEVOSX49cPSEd0ir1YqDY5TFvxzg7womgBfY4pQtRSA1FxlLMKxw8aOf
	 gk7r70lm1U339uC1I6w02NVEhYacX4/kG5ZnXMDyi3GcQsyqFkFtDqvBJRRtfmvu59uUY
	 ZQpcjMXbmNVW2yA9MIy48qSZJG/BrBoqBGvxmyxWl1ht1pL33mldqJqOFcbOtK+dqLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fsAtUa/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B46606A323;
	Wed, 25 Nov 2026 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsAtUa/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A01F000C4;
	Wed, 25 Nov 2026 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609529;
	bh=3cweuxzJfLVp8WrEgRssiB6rvSwpbNFQB7nXvM8QjKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fsAtUa/GQdQKpLbKezuab3FKplO/4Br2NkD1n89RJ3iMTdAoahkjWcJPXxsWSi8Wn
	 nog33ezhVCvuu48Sy1UIvbrcI+h0DITF0u6TB6jjgYt6AREaUSjDecjOli1Y9HGfQL
	 MizGA3CxHe+oYjhf93JzEMDPhBDu12qXci6pRTgNGKFjoRGFQvHEXrj9CzPd6deYZv
	 WOyqwuXcpUGVFE1RR2X2B3qcgZX6xWSlR5aZ47sRkqXMDnVGACkc2FQ1yquoI5VcaV
	 FhkVHdWU5mUUi5C5qR8Yn7i8/rjxYcdBzVCmcIeoxKzjpBTTtWoQP5oOPlov7b5yNy
	 4+ey9tleeRBCg==
Date: Wed, 25 Nov 2026 17:55:23 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] tee: shm: sync DMA memory for the device before it is
 lent
Message-ID: <awbTs4Ad041c1AjO@sumit-xelite>
References: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
 <CAGgiveWm-xH_SjA5QrBJx6NtQhWyQWMw2FvfSd9SfG-wghpwmw@mail.gmail.com>
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
In-Reply-To: <CAGgiveWm-xH_SjA5QrBJx6NtQhWyQWMw2FvfSd9SfG-wghpwmw@mail.gmail.com>

On Tue, 24 Nov 2026 at 09:52:00 +0100, Jens Wiklander wrote:
>Hi,
>
>On Fri, Nov 13, 2026 at 2:22 PM Tyler Baker
><tyler.baker@oss.qualcomm.com> wrote:
>>
>> tee_shm_alloc_dma_mem() returns dma_alloc_pages() memory without the
>> dma_sync_single_for_device() that the DMA API requires before a device
>> uses it. dma_alloc_pages() zeroes the pages through the cacheable
>> linear map, so the zeroes can still be dirty in the cache when the
>> optee protected memory pool lends the pages and a Secure Data Path TA
>> writes them through its secure mapping. A later eviction of those
>> lines overwrites the TA's data.
>>
>> On an Eliza EVK with OP-TEE as the FF-A SPMC, a TA decrypts into a
>> protected buffer, a read of all RAM through /proc/kcore evicts the
>> lines, and the TA's digest of the buffer no longer matches:
>>
>>   frame 0: 0e534d8c..., reference d98ddba1...
>>
>> Sync the allocation for the device before returning it.
>>
>> Fixes: ab09dd6d9201 ("tee: add tee_shm_alloc_dma_mem()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
>> ---
>> Vincent's direct-map series [1] cleans the range in
>> dma_zap_direct_map() before the lend, which also covers this when it
>> can unmap. It returns -ENODEV without any cache maintenance when there
>> is no lendable pool and the direct map cannot change (arm64 with
>> rodata=noalias or rodata=off), and it is not a stable candidate.
>>
>> On a dma-coherent TEE device the sync does nothing. teedev->dev is not
>> configured from firmware, so it is not coherent today.
>>
>> Without the fix the TA's data is lost:
>>   https://lava.infra.foundries.io/scheduler/job/554467#L2262
>> With it, the data is intact after the scan and 50 lend rounds:
>>   https://lava.infra.foundries.io/scheduler/job/563840#L1979
>>   https://lava.infra.foundries.io/scheduler/job/563840#L2008
>>
>> [1] https://lore.kernel.org/all/20261111110738.872947-1-vdonnefort@google.com/
>> ---
>>  drivers/tee/tee_shm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 5c47a36916c45..70a273a425f88 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -297,6 +297,9 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
>>         if (!page)
>>                 goto err_put_teedev;
>>
>> +       dma_sync_single_for_device(&teedev->dev, dma_addr,
>> +                                  page_count * PAGE_SIZE, DMA_BIDIRECTIONAL);
>> +
>>         dma_mem = kzalloc_obj(*dma_mem);
>>         if (!dma_mem)
>>                 goto err_free_pages;
>>
>> ---
>
>Looks good. Sumit, do you agree?

Looks like a reasonable fix to me, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit
