Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42713BADB6
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695897; cv=none; b=EMKHNB71ZIgBF0h/ag+Q5jJSoFZbTH0m3Yr1Fvr19Ibw4hGYilQWXBvaoiTlsF8f0iwHyv/kZn4DPLbP6wpsE9bUhe74lhNb9/h+7PJGRwHu688IPQnvqe39AuOlN0APCp3t0QQWjTP2egV54XwAJ0nKpYFxC/m5WQzrG9NfYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695897; c=relaxed/simple;
	bh=fQfQsekhx9QaMzvkgFy4Hqx5jkFcBrc+bBJN6GqOpTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+Dx8mveEsB5MeBnkoO/1z9Q4Wth8a20onMrCZju/Lsm0a61gizW6hioig9Prrm4VeHaIJNsHZVnRyNb4lgm/uyFf418+GwrVqiOY5XoI1pIl0h6SSKBjpmkwZ/z0KdeAMJmje0F14j8LW0bXCoXbKESFnV9ESpozhIuqFLKdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=C2F/emPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxXItocf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="C2F/emPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxXItocf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCBF57A011F;
	Fri,  5 Jun 2026 17:44:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 17:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780695894;
	 x=1780782294; bh=qYyYm4jZR73WhnxcfvDFqge+O/InlhCJU/pio5LIcqw=; b=
	C2F/emPENq9CHTdBy8X6Yf+mTGGoU/pInVp6JD8HeeD0kPGVzOITyA0IbYL+lI+j
	SuGwAOKbcbfP0NCoS3Y+pLOoNBlw+pZq5M5UyD2FP05Bm3M3nIB+aRRqyO8UR8DK
	ENip0uuX/gJiu8NO7mf81V0SjnrzJNTu5DI8ZBt4jiFNNrC/+2K6Rvg388Hxahhs
	cOYRM57ss2ztNB4k3ECfj1PgEf8YMxth0cU0Sf91Edq4ttS36y4aoqAO6OGf5gYP
	HIdn1cw6JxxiEBrooXujsk1uDoiEE62IAEVkmHfNfkSri8/umWCr74sfD4SYWWN/
	6YIWYXMeej3N8z8BfGp4cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780695894; x=
	1780782294; bh=qYyYm4jZR73WhnxcfvDFqge+O/InlhCJU/pio5LIcqw=; b=W
	xXItocfvbK9YsYhzgLEmckfx30uQmHDYG4oTRKg4B6a+/3EdcXVAsVpquGc2iKlV
	YbPgYJEVH+QY2q66BAUul3aUNSf5vvSgVGk/5x7/cBR6jDXYuGvfk753dWHCuNj0
	mqWijfivJrsnmUTS+qPzypYbUuhmmjV05CU89AeggiWLB4Bs02IYsAcpOO2rsMDn
	4xm12fQyRHr9J/FTqHX+ZhSgPUMc12vKCdqr0EG0Vc5zurDa9vsXWDajH3GzxUU+
	TA1UTRZJlVIoApku9JGTGWc+hucHS1Ui8n98FCVyPIBodq18tsmA1Kz26KO4/U00
	X7bqQVc+rnWR0eEOWA/Eg==
X-ME-Sender: <xms:VkMjap1Ka0m3dyS_6NbKknyxLqAIdkD_ad_fyC6fvY-_tAHjPYA8eQ>
    <xme:VkMjahn9FBzkCBf_y8RfOrfkY5ZYB9rskN_JDNt3QwS_0KSdqsNkV7gCC8GpDMfhr
    hcNgHnL6yUjyVTg1FB_bD6DxDjgDHo0S3mCn8Ax9UzE2k9-dzYATQ>
X-ME-Received: <xmr:VkMjap_2dQYFLZQFmK7IEjxj_evDX0QlFaUutc-oy4sGSsGv0BsnaoZ7b5upgEbTO_M7qgBMjOvt49D4ipekMqo48emHvylWFIjLY7Mw5Jgy02nBCQ>
X-ME-Proxy-Cause: dmFkZTEWSdHk3xRBZa0qmSUWc3z/zdmki6fMjsNhDKOD89spuiMZmSMP1ZCG2UndExDzI2
    DK9++Umap57oXBel7MxNIcyVnSirbpUOc76MN404L3i1gZTu+pbKPCUSe5hdDVngKD7ebA
    Hb9UwAlxXUFOHlnRmAkqkogZEzlhrZGpd4P0NG26fLXMS0yTV3tnNGYdJU/TbIb3XpOknq
    GhONmhmTSAhQ/a5MT/KNzucdt2rsnFqusSWjS/MUkzmXuo+62ZG198I63vUgVcdDDvPHBU
    CAw7gIn6HNSDXcKVGlFAY9PZ0bRwmIBxQh8gfR7RL3Alb0YbProB0ae4syDtlGNOP3M9HJ
    9nFLHRmpdOGV97xae0589+jKm7H925zN6Rhv2NWoBt076tcHBckg4iJVms7TYiOulc1S1n
    0wGNTXEOVZqXCx8g6bHHx0Er3Pg2b2ek97JXmc2LuRN4y6VfqMJQw5js9wc4J2Smq/0yA3
    klw/T/gW6pWXl/U+oBYtCC2ZQ6i6yhIp/vr5futxDgZGRewmQXtMIqu0SkSl1tdk9A+Bb4
    lMr+ZjN/8MpgiFwKJo3hFpmjCQvjcUvlnCIR58JoLLT6BAtmanO1/s8hB12olbept+FX3G
    LM72P21Pp9TkTCvbyWbkOHr+KLkc+mVr0s0lP/dRZN2sfi0kJCLbdYf/+/pA
X-ME-Proxy: <xmx:VkMjamo1Xfx3KPGvt7FgADq2gH1H3gb25ELuoUKlbzJNXq2kS_pMMg>
    <xmx:VkMjailCnrFqj9MTsf69CgxDTFrXSMec-FocnVwASmKppKNod4Y_0Q>
    <xmx:VkMjathCEFN7yjkochr40uD20wfwHsZEasgnYreC2H5nm_oMDcpZiQ>
    <xmx:VkMjaqfg3TEorByA02IizY6XIexiVeVh7qZrR0z4g6MLjz2rAvmf_A>
    <xmx:VkMjajkDOkN1g65w1rq0nZWsTdBymXMJJS6k-ZalPwl_HURYXKrJ3vgO>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 17:44:53 -0400 (EDT)
Message-ID: <b4fb1219-fcaf-4f15-812e-3264162fb9ca@bsbernd.com>
Date: Fri, 5 Jun 2026 23:44:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fuse: fix EFAULT clobber in fuse_uring_commit
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>,
 stable@vger.kernel.org
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260605192708.141921-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 21:27, Joanne Koong wrote:
> From: Chris Mason <clm@meta.com>
> 
> copy_from_user() returns the number of bytes not copied as an unsigned
> residual on failure (1..sizeof(struct fuse_out_header)). fuse_uring_commit
> stores that residual in ssize_t err, sets req->out.h.error to -EFAULT,
> then jumps to out: with err still holding the positive residual.
> 
>     err = copy_from_user(&req->out.h, &ent->headers->in_out,
>                          sizeof(req->out.h));
>     if (err) {
>         req->out.h.error = -EFAULT;
>         goto out;          /* err is the positive residual */
>     }
>     ...
>     out:
>         fuse_uring_req_end(ent, req, err);
> 
> fuse_uring_req_end() then runs
> 
>     if (error)
>         req->out.h.error = error;
> 
> which overwrites the just-assigned -EFAULT with the positive residual.
> FUSE callers such as fuse_simple_request() test err < 0 to detect
> failure, so the positive value is interpreted as success and the
> caller proceeds with an uninitialised or partial req->out.args.
> 
> Fix by assigning err = -EFAULT in the failure branch before jumping
> to out, so fuse_uring_req_end() receives a negative errno and sets
> req->out.h.error to -EFAULT.
> 
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: kres (claude-opus-4-7)
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/fuse/dev_uring.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e467b23e6895..e33847436693 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -811,14 +811,11 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>  			      unsigned int issue_flags)
>  {
>  	struct fuse_ring *ring = ent->queue->ring;
> -	ssize_t err = 0;
> +	ssize_t err = -EFAULT;
>  
> -	err = copy_from_user(&req->out.h, &ent->headers->in_out,
> -			     sizeof(req->out.h));
> -	if (err) {
> -		req->out.h.error = -EFAULT;
> +	if (copy_from_user(&req->out.h, &ent->headers->in_out,
> +			   sizeof(req->out.h)))
>  		goto out;
> -	}
>  
>  	err = fuse_uring_out_header_has_err(&req->out.h, req);
>  	if (err) {

Oh right, I run every time into the same trap, need to set up some kind
of static check for {copy_from,to}_user.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
