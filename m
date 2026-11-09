Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205648;
	b=y9Xf3DCcDLqkV9UOinoUPsc4EoYg6LpTunTrTFGd85XXByCrc7aC/bLRtmoeKFD+t6RE
	 OKm+YIQ2nZnSa1WDmbJDKrBSEHcU8aWMGqqLPIIJU59w1X/ZLMSXcW4YoTE77u29WsGYl
	 2XI43W2FwNK/UaqkGf1pAA+PwdxMo85FMQwZLqwFKwio782QtkdL2ieu7yAzE2A52iWCR
	 Zgmlnut5rdB4xQHlQQBNZBo1FwzBM7KFVWYErQ3LOoqTaDO6dKadbmTDAvs3j/yrGabwX
	 7MkSY9+FJdqXhFdoX1tHvVWkxvYZQQxz4yGvAPT0kKHKcAv0180gRq1tjxLTWv3tyKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205648;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1LuLFUmvB7Uxv5vtQr8Gi7eE2ebp9fpE+myiUoa3eng=;
	b=UDb4ztsa8umdM7TIde+95+sftvfC9kU6KKRTDxJiFsZvIVWIn5HwhX6kp4F/1SKW8XA+
	 Q08XgYBrfUiWtuWEbxR7WlKu58D/kPsoxDaQJ3WQUOc7Pulb7BorzoEGfa8CYDMZwEj3n
	 1CriTyBInNi7WR9v6DmTpfUj0Ne57nAWkEB5GP3L6kzdw0eZpLWNEvyH//k7c9iEx8Flh
	 ttb2BM6USUZuLSG8xTMWRyJfdEfTSE8Q1RD+XnwkIXRJCtglcdB/ifO8bj/WFqtGtTsei
	 phYT3CIYvTHhzmzVozv39dS7RvHeTryshloRrZ2VrgaIDA43V7rPdAmjvMGX5qzPdAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5wUT9KM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8730606A321;
	Mon,  9 Nov 2026 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5wUT9KM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0968B1F0089F;
	Mon,  9 Nov 2026 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794205647;
	bh=1LuLFUmvB7Uxv5vtQr8Gi7eE2ebp9fpE+myiUoa3eng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5wUT9KM6pas7Qt3UYvT9E6yOd8Zd7HUkUZoGH90AtOkyPTgw4MVb5WCGe6Sy63xL
	 6qmTrDMoj27dk/d3CV5iC9wOMo46zpeHg6beYoj3zY1Zav1aGHZk6u1iP7N+8nygMI
	 NT8zY9ElkHrEnJqoaSjeCf+nD1gYGuBNKzf2rs/w6368qNzXS8WialmakudKCAZBDR
	 +HvGOI3ez6FVkARBCG5lui2tgoAmbOvJpBftEiscIqwTzPPkVIyhA1MUfAmpbsrV3X
	 tjsYhZdIWbteaToaekBAoAa38sOVgwznY6xVJ5hgacnMb72bE2e+dEj3Sb+DNdrB9X
	 TWLsYVtVloXUw==
Date: Mon, 9 Nov 2026 11:57:21 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: Hongyan Xu <getshell@seu.edu.cn>, Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivier Masse <olivier.masse@nxp.com>,
	Etienne Carriere <etienne.carriere@foss.st.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] tee: avoid accessing dma-buf shared memory after put
Message-ID: <avFnybu7UDEdva94@sumit-xelite>
References: <20260806060727.191-1-getshell@seu.edu.cn>
 <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
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
In-Reply-To: <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>

On Thu, 05 Nov 2026 at 13:56:51 +0100, Jens Wiklander wrote:
>Hi,
>
>On Thu, Aug 6, 2026 at 8:07 AM Hongyan Xu <getshell@seu.edu.cn> wrote:
>>
>> param_from_user_memref() obtains a temporary reference to the dma-buf
>> tee_shm wrapper by ID. If closing the shared-memory file descriptor races
>> with the ioctl, this temporary reference can be the wrapper's last one.
>> tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the function
>> still reads ref->parent_shm and ref->offset afterwards.
>>
>> Save the parent pointer and offset before dropping the wrapper reference.
>> The additional parent reference keeps the parent shared memory alive for
>> the parameter list as before.
>>
>> Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmabuf file descriptor")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
>> ---
>>  drivers/tee/tee_core.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 1aac50c7c1de..489c39d5b35f 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_context *ctx,
>>                 }
>>
>>                 if (shm->flags & TEE_SHM_DMA_BUF) {
>> +                       struct tee_shm *parent_shm;
>>                         struct tee_shm_dmabuf_ref *ref;
>>
>>                         ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
>> @@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_context *ctx,
>>                                  * list instead of the shm we got with
>>                                  * tee_shm_get_from_id() above.
>>                                  */
>> -                               refcount_inc(&ref->parent_shm->refcount);
>> -                               tee_shm_put(shm);
>> -                               shm = ref->parent_shm;
>> +                               parent_shm = ref->parent_shm;
>>                                 offs = ref->offset;
>> +                               refcount_inc(&parent_shm->refcount);
>> +                               tee_shm_put(shm);
>> +                               shm = parent_shm;
>>                         }
>>                 }
>>         } else if (ctx->cap_memref_null) {
>> --
>> 2.50.1.windows.1
>>
>
>Looks good. Sumit, do you agree?
>

Sounds reasonable to me, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit
