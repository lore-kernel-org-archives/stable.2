Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40A399CFC;
	Mon, 24 Aug 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557647; cv=none; b=ZFoQQok6085xq9mDyozvAOJCNg0JU8a2EsU9QPONElE9XW0UidfdmJqkiYZtYI9cpKajF8LcQaBb8uQsStnYbHkEQcZnpJ/7FfNAXefcFt3rNlZeCI3vG84/rINPkyKucLw4vXz3RY6cyl+0JgfBqYD0BP7aAKYqZwHQjoyPISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557647; c=relaxed/simple;
	bh=BkVxzeXRrmErxQMyAj7+2qXNTJZhiEfY+yBOWS6vP98=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o3kV+3LRAt3aD52qeFqcosjbl4fLn3HTilpGWs5/nRD2SOYIWRz+okI0mgtx2fKAMh96ctDUlNUc7GJ8RtmjPtiDMm1xams5CIbA+kB9Hs5uFg/KWJi7LkIKUPd8xg2f/9I3CSRPbcsaFNVXK2YR8RQQae1bblE9dkHXNndCp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMM1gx0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMM1gx0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86991F000E9;
	Mon, 24 Aug 2026 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787557646;
	bh=hj7/s+j6NHMyFBaYg+JKp2NMB5fFO+T1WpKQCf87wwk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=kMM1gx0iiuqeD+Ra55RRDPhAsn33uc4wUkbkih2ERM0dY01vMN0FcnHevDdI9Q4An
	 qXdx8CN2viXPoFD+BQz9XVYmfP7yWJ/JA055TI+lZ/T/n3Ck/B/+t8aj1LVTTxFdRM
	 Hljj/EKiMZyUOCFhkM6XHSHwc6Jb3Sa9BF6WUfaHPIQbt+PVQmtHszMJmhTxj0cWKi
	 1K8h92hm2qx16n2bHwvIVUTwvab6PLkZgOYcTI7zUZDlo5ZSDzumV+MkeStr4gi99k
	 pLvE4kCkiJ9wWFsucd9gG/ojUN557BfgiExsRTe3D+k6tUIXyKoUt8CxDCaOQrnEFN
	 9KRgC+rk8t+2w==
Message-ID: <e85ca927-223e-4752-95c3-72edba41f16a@kernel.org>
Date: Mon, 24 Aug 2026 09:47:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sven Peter <sven@kernel.org>
Subject: Re: [PATCH] soc: apple: rtkit: bound syslog copies to the shared
 buffer
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Janne Grunau <j@jannau.net>
References: <20260822095121.53451-1-acharyalaxman8848@gmail.com>
Content-Language: en-US
In-Reply-To: <20260822095121.53451-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 8/22/26 11:51, Laxman Acharya Padhya wrote:
> apple_rtkit_syslog_rx_log() copies a log entry out of the coprocessor
> shared-memory ring using an index and layout that the coprocessor
> itself chose (SYSLOG_INIT n_entries / msg_size, plus the 8-bit idx in
> the LOG message). Those values are never checked against
> syslog_buffer.size, so a compromised or buggy RTKit firmware can make
> the kernel memcpy_fromio()/memcpy() past the DMA mapping.
>
> SYSLOG_INIT also accepted msg_size == 0. kzalloc(0) returns
> ZERO_SIZE_PTR, which is non-NULL, and strnlen(..., msg_size - 1) then
> wraps to SIZE_MAX.
>
> Treat n_entries as a count (reject idx >= n_entries), reject a zero
> message size, and refuse shared-memory copies that do not fit in the
> buffer. Rate-limit the new OOB warning so a coprocessor cannot flood
> the kernel log.
>
> Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
> Cc:stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya<acharyalaxman8848@gmail.com>
> ---
>   drivers/soc/apple/rtkit.c | 73 ++++++++++++++++++++++++++++++---------
>   1 file changed, 56 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index a3fdac8f6f06..63b85d082a7a 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -348,14 +348,28 @@ static void apple_rtkit_free_buffer(struct apple_rtkit *rtk,
>   	bfr->is_mapped = false;
>   }
>   
> -static void apple_rtkit_memcpy(struct apple_rtkit *rtk, void *dst,
> -			       struct apple_rtkit_shmem *bfr, size_t offset,
> -			       size_t len)
> +static bool apple_rtkit_shmem_ok(struct apple_rtkit_shmem *bfr, size_t offset,
> +				 size_t len)
>   {

This is only used in a single place and doesn't have to be its own function.

> +	return offset <= bfr->size && len <= bfr->size - offset;
> +}
> +
> +static int apple_rtkit_memcpy(struct apple_rtkit *rtk, void *dst,
> +			      struct apple_rtkit_shmem *bfr, size_t offset,
> +			      size_t len)
> +{
> +	if (!apple_rtkit_shmem_ok(bfr, offset, len)) {
> +		dev_warn_ratelimited(rtk->dev,
> +				     "RTKit: shared-memory copy out of bounds (off 0x%zx len 0x%zx size 0x%zx)\n",
> +				     offset, len, bfr->size);
> +		return -EINVAL;
> +	}
> +
>   	if (bfr->iomem)
>   		memcpy_fromio(dst, bfr->iomem + offset, len);
>   	else
>   		memcpy(dst, bfr->buffer + offset, len);
> +	return 0;
>   }
>   
>   static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
> @@ -384,9 +398,10 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
>   	 */
>   	bfr = kzalloc(rtk->crashlog_buffer.size, GFP_KERNEL);
>   	if (bfr) {
> -		apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
> -				   rtk->crashlog_buffer.size);
> -		apple_rtkit_crashlog_dump(rtk, bfr, rtk->crashlog_buffer.size);
> +		if (!apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
> +					rtk->crashlog_buffer.size))

nit: please use == 0 here since that's easier to read

> +			apple_rtkit_crashlog_dump(rtk, bfr,
> +						  rtk->crashlog_buffer.size);
>   	} else {
>   		dev_err(rtk->dev,
>   			"RTKit: Couldn't allocate crashlog shadow buffer\n");
> @@ -422,10 +437,29 @@ static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
>   
>   static void apple_rtkit_syslog_rx_init(struct apple_rtkit *rtk, u64 msg)
>   {
> -	rtk->syslog_n_entries = FIELD_GET(APPLE_RTKIT_SYSLOG_N_ENTRIES, msg);
> -	rtk->syslog_msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
> +	size_t n_entries = FIELD_GET(APPLE_RTKIT_SYSLOG_N_ENTRIES, msg);
> +	size_t msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
>   
> -	rtk->syslog_msg_buffer = kzalloc(rtk->syslog_msg_size, GFP_KERNEL);
> +	kfree(rtk->syslog_msg_buffer);

this fixes a separate memory leak, please split this into another patch.

> +	rtk->syslog_msg_buffer = NULL;
> +	rtk->syslog_n_entries = 0;
> +	rtk->syslog_msg_size = 0;
> +
> +	/*
> +	 * msg_size == 0 would make kzalloc() return ZERO_SIZE_PTR (non-NULL)
> +	 * and later strnlen(..., msg_size - 1) wrap to SIZE_MAX.
> +	 */
> +	if (!msg_size) {
> +		dev_warn(rtk->dev, "RTKit: syslog msg_size is zero\n");
> +		return;
> +	}
> +
> +	rtk->syslog_msg_buffer = kzalloc(msg_size, GFP_KERNEL);
> +	if (!rtk->syslog_msg_buffer)
> +		return;
> +
> +	rtk->syslog_n_entries = n_entries;
> +	rtk->syslog_msg_size = msg_size;
>   
>   	dev_dbg(rtk->dev,
>   		"RTKit: syslog initialized: entries: %zd, msg_size: %zd\n",
> @@ -441,10 +475,11 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
>   {
>   	u8 idx = msg & 0xff;
>   	char log_context[24];
> -	size_t entry_size = 0x20 + rtk->syslog_msg_size;
> +	size_t entry_size;
> +	size_t offset;
>   	int msglen;
>   
> -	if (!rtk->syslog_msg_buffer) {
> +	if (!rtk->syslog_msg_buffer || !rtk->syslog_msg_size) {
>   		dev_warn(
>   			rtk->dev,
>   			"RTKit: received syslog message but no syslog_msg_buffer\n");
> @@ -462,17 +497,21 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
>   			"RTKit: received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem\n");
>   		goto done;
>   	}
> -	if (idx > rtk->syslog_n_entries) {
> +	if (idx >= rtk->syslog_n_entries) {

Have you verified this on hardware? With the bounds check in memcpy this 
won't result in anything bad and I don't know if rtkit firmware treats 
idx == n_entries as valid. I *think* this is correct but it would be 
good to test this and split it into a separate commit so that it's 
easier to revert if it breaks.
>   		dev_warn(rtk->dev, "RTKit: syslog index %d out of range\n",
>   			 idx);
While you're at it, it would be good to make these rate-limited as well, 
possibly as a follow-up patch as well.
>   		goto done;
>   	}
>   
> -	apple_rtkit_memcpy(rtk, log_context, &rtk->syslog_buffer,
> -			   idx * entry_size + 8, sizeof(log_context));
> -	apple_rtkit_memcpy(rtk, rtk->syslog_msg_buffer, &rtk->syslog_buffer,
> -			   idx * entry_size + 8 + sizeof(log_context),
> -			   rtk->syslog_msg_size);
> +	entry_size = 0x20 + rtk->syslog_msg_size;
> +	offset = (size_t)idx * entry_size + 8;
> +	if (apple_rtkit_memcpy(rtk, log_context, &rtk->syslog_buffer, offset,
> +			       sizeof(log_context)))
> +		goto done;
nit: like above, < 0 please to make it easier to read.

> +	if (apple_rtkit_memcpy(rtk, rtk->syslog_msg_buffer, &rtk->syslog_buffer,
> +			       offset + sizeof(log_context),
> +			       rtk->syslog_msg_size))
> +		goto done;
>   
>   	log_context[sizeof(log_context) - 1] = 0;
>   


Best,


Sven

