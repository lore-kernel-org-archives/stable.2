Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245365;
	b=hjcuAoWfKAqvzCEH56VKkCeOzLWixqvs8q1HEoW8fRNXGMdKzYI/jOGCOGqrOY1M8JYW
	 7zwROPCnBPbOjzq4A4wGeHMmHSH1XGOQYcEYU1I9PkK9FftUtEAH3pgCMvS3oSPM84pCF
	 J1uhn+xrSkXdsafhpWPBkQIL7iWmh9O6CxUdgvGvo4RSSnYJKc4uHa3fPjHfSAYY7J2Nt
	 ZCnFqZPp0q4NfuaCEnw4QTL+3AxXPrYSRqVEoCphhLNXN+LClMD2UA33XUbLm7F6oNJeI
	 FOZ2ul7yKQnGEzgc1pRQWuLD+tAlQ7V7u6N/26jYg7F64eWWBzxgHW712ZibohbdeKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245365;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=olORNfTjVUYPDMp2DcsyDGVL+vmC9b6BSLlr9om20oA=;
	b=5m/m4RhCfs1moBzoVvcZ8aGZTLCkiUJI77zzTBOlhDpOnhEByP0O99P2LGdILzx8EMJ3
	 leDdstDV+bSTxtshACAS3wwRcQ+uNSJBJsx2RHyQ4PdTQYeSOx9ZlkEDJqv0M+f0aVWXg
	 0diy0RerJ6kD0dZhPpQk34dAGzd9tNz0xN/LsX2sQEE+9Tkxgkv5tIycA79f3NJRKdezb
	 Sg0CqVFhOy2EyROOcb4f/lObE1+ZbZMFWbsQDulyu+q8qvwpQu4vKMmRD0GU2bW5UJD3N
	 tjeWbOqcOm0HGWmFqaj6GNUf9VDvjLixK+QhYKhTwSrlX3vDRD/g31DpGGtPJH5liMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+Wb7hhg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA3606A326;
	Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+Wb7hhg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA281F0089F;
	Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245364;
	bh=olORNfTjVUYPDMp2DcsyDGVL+vmC9b6BSLlr9om20oA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k+Wb7hhgAXNyraYHbaY71E+KF0d1JTJMDgJz5Zl/N9saDb0THO03y0/n6oRQZTcMt
	 GywBVNtT8zWGIThBbo90uQ262MYlaK0QPVSYPnx3v3spEHPwxHAuriIZw1JkCtX/Db
	 +RivsnsYDZHnWbABt+EDMIgqYe0wupT9pqRelv9LB5fvNQVUJsYIUJlh6q9gdprs1+
	 OBomx/TmJb3RNfBBu/XK2bGgFuSikHu/3BX/Pqm3NIzpGGX2jhJwfHld/ekOjmBHYa
	 bmYonew6A3b6HeIiuitskLDU9G/FUeYoVlcO9b5prLCNIGs8IR5JNqMcEeBU5TYhTy
	 MzAgr7BuwGLWA==
Message-ID: <4e1b3b0d-f831-450f-9974-746c86ef0c23@kernel.org>
Date: Mon, 9 Nov 2026 11:29:23 -0600
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
Subject: Re: [PATCH] firmware: stratix10-svc: Use proper atomic to fix
 possible double free
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261101122908.46723-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20261101122908.46723-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/1/26 06:29, Krzysztof Kozlowski wrote:
> Doing atomic_dec() and then separate atomic_read() leaves small race
> window leading to double free in stratix10_svc_remove_async_client():
> 
> CPU 0                               CPU 1
> =====                               =====
> refcount == 2
> 
> stratix10_svc_remove_async_client() stratix10_svc_remove_async_client()
> atomic_dec(&refcount);
>                                      atomic_dec(&refcount);
> if (atomic_read(&refcount) == 0)
>    kfree(achan);
>                                      if (atomic_read(&refcount) == 0)
>                                        kfree(achan); // double free
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-506b1474-e503-4085-b62a-929cde036317
> Fixes: bcb9f4f07061 ("firmware: stratix10-svc: Add support for async communication")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   drivers/firmware/stratix10-svc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 88391ea161ed..aca4d354bdd7 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1444,8 +1444,7 @@ int stratix10_svc_remove_async_client(struct stratix10_svc_chan *chan)
>   	}
>   
>   	if (achan == actrl->common_async_chan) {
> -		atomic_dec(&actrl->common_achan_refcount);
> -		if (atomic_read(&actrl->common_achan_refcount) == 0) {
> +		if (atomic_dec_and_test(&actrl->common_achan_refcount)) {
>   			ida_destroy(&achan->job_id_pool);
>   			ida_free(&actrl->async_id_pool,
>   				 achan->async_client_id);

Applied!

Thanks,
Dinh
