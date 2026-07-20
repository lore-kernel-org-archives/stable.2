Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E603C37A5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533269; cv=none; b=BJGnk5vMF/ryuKenNlZYb/vbcl+0BdokTpbZCrJYNQsEHfCni9Bp+I0a7SeKS8mAkKhaup8ojVCcrmNVroFNSvdG+g2GjtdsctklFMgz3uJvEVvmdt/NxdozhgXzb0ljk2on3EbktGb07YQ2zSXqXlCmALtob4MjPJYm4UtX4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533269; c=relaxed/simple;
	bh=GJsCmat1hRpSTTi8Jy5Fbyl94M7vKo1fTQS3yIbp2AM=;
	h=Content-Type:References:Subject:Date:Content-Disposition:
	 In-Reply-To:To:Message-Id:Cc:From:Mime-Version; b=t0Dj6qcPSxiimGWlUrbPIO3dHfAqh6mI26zXW8EHWKmAmfjSTBdAfC5sA3mSF4uMPgL1fssBx2djX9hgW44LQnZ88vv+FRNl/QC5JRE7lvVto4R1PsIjalSQfBw+XScmCzhkQ+c630FReGiHFmpMgOREZW+qx63aRzrPg6VCFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=SJkRvxoK; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="SJkRvxoK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784533256;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Wvo00PZl3spFY06IhlvZ5hCo9iup+BJRni0UaNgUr5Q=;
 b=SJkRvxoKyDql2bfSlqKx3WlXbv8zBu9m7P0kktVWH25bmi89MjBkaIG6EsXjIPK9v/hTML
 pSHQd8tmgAJpNKe5N+bhGvWnB6s1LsahBHjpqP46oA+qylxQjSZ+p0dIXyElb+W71auDS4
 1SA3tcmRZCUsDZG/LCHATQSJCmW0WsjLGiPir4BYpgc1ecpklK+UcXr85hHltEz6+gTW9Z
 6/np28gpLMKV6K6MqDDYMb6jr1oAGG09rpiAqrSqsLfPzfT4KNE2XhUyqKh+EKvZ4t9J3d
 yCWF64Q05Sg5FwdiC9TEtEfDNUkhs14/eRlshwKTlmfj11xL6OlfaNxYA4Ov/A==
Received: from studio.local ([120.245.64.95]) by smtp.larksuite.com with ESMTPS; Mon, 20 Jul 2026 07:40:54 +0000
Content-Type: text/plain; charset=UTF-8
References: <ak9CC591ivuQ4BP1@studio.local> <20260709131904.596684-1-adhikari.resume@gmail.com> <20260709131904.596684-3-adhikari.resume@gmail.com>
Subject: Re: [PATCH v6 2/2] badblocks: validate sector range and shift before rounding
Date: Mon, 20 Jul 2026 15:40:52 +0800
Content-Disposition: inline
X-Lms-Return-Path: <lba+26a5dd107+4bae4c+vger.kernel.org+colyli@fygo.io>
In-Reply-To: <20260709131904.596684-3-adhikari.resume@gmail.com>
To: "Ramesh Adhikari" <adhikari.resume@gmail.com>
Message-Id: <al2n2XTby-qqTH53@studio.local>
Cc: <axboe@kernel.dk>, <gregkh@linuxfoundation.org>, 
	<linux-block@vger.kernel.org>, <stable@vger.kernel.org>
From: "Coly Li" <colyli@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Coly Li <colyli@fygo.io>
Content-Transfer-Encoding: 7bit

On Thu, Jul 09, 2026 at 06:49:04PM +0800, Ramesh Adhikari wrote:
> _badblocks_set(), _badblocks_clear() and badblocks_check() round
> the caller-supplied [s, s+sectors) range to the current bb->shift
> block size before touching the bad block table. That rounding
> was not defensive against a few cases:
> 
> - s + sectors can overflow sector_t (u64), wrapping the range
>   end before it is ever compared against s.
> 
> - bb->shift is a plain 'int' field, populated in one case
>   (drivers/md/md.c, from the on-disk superblock's bblog_shift)
>   straight from an unvalidated byte with no upper bound. Shifting
>   by an amount >= the width of the shifted type is undefined
>   behaviour in C; "1 << bb->shift" was shifting an int literal,
>   so this was already undefined for bb->shift >= 32, let alone
>   the full 0-255 range bblog_shift allows.
> 
> - round_up()/round_down() rounding a value near ULLONG_MAX can
>   itself wrap back to a small value, so even with a valid shift
>   the rounded end of the range could end up smaller than the
>   rounded start, silently turning a small range into a huge one
>   (in _badblocks_clear()/badblocks_check(), which round the end
>   up) or losing the range entirely.
> 
> Add an explicit s+sectors overflow check, reject any bb->shift
> that is too large to shift a sector_t by, cast the shift operand
> to sector_t so the shift itself is never performed on a 32-bit
> int, and detect post-rounding wrap by comparing the rounded
> result back against the pre-rounding value.
> 
> Suggested-by: Coly Li <colyli@fygo.io>
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
> ---
>  block/badblocks.c | 52 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 1f786b193fb..00a59729600 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -853,12 +853,23 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
>  		/* Invalid sectors number */
>  		return false;
>  
> +	if (s > ULLONG_MAX - sectors)
> +		/* Range wraps past the end of sector_t */
> +		return false;
> +

Yes, this is necessary. Hmm, if I write this, maybe I will use,
	if ((s + sectors) < s)
		return fasle;
This makes me more comfortable.

>  	if (bb->shift) {
>  		/* round the start down, and the end up */
>  		sector_t next = s + sectors;
>  
> -		s = round_down(s, 1 << bb->shift);
> -		next = round_up(next, 1 << bb->shift);
> +		if (bb->shift >= BITS_PER_LONG_LONG)
> +			/* Corrupt/unsanitised shift value */
> +			return false;

This bb->shift overflow check can be avoided. See my finally comments.

> +
> +		s = round_down(s, (sector_t)1 << bb->shift);
> +		next = round_up(next, (sector_t)1 << bb->shift);
> +		if (next <= s)
> +			/* Rounding wrapped past the end of sector_t */
> +			return false;
>  		sectors = next - s;
>  	}
>  
> @@ -1061,7 +1072,12 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		/* Invalid sectors number */
>  		return false;
>  
> +	if (s > ULLONG_MAX - sectors)
> +		/* Range wraps past the end of sector_t */
> +		return false;
> +

same
	if ((s + sectors) < s)
		return fasle;

>  	if (bb->shift) {
> +		sector_t orig_s = s;
>  		sector_t target;
>  
>  		/* When clearing we round the start up and the end down.
> @@ -1070,10 +1086,21 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		 * However it is better the think a block is bad when it
>  		 * isn't than to think a block is not bad when it is.
>  		 */
> +		if (bb->shift >= BITS_PER_LONG_LONG)
> +			/* Corrupt/unsanitised shift value */
> +			return false;
> 

This bb->shift overflow check can be avoided. See my finally comments.

>  		target = s + sectors;
> -		s = round_up(s, 1 << bb->shift);
> -		target = round_down(target, 1 << bb->shift);
> -		sectors = target - s;
> +		s = round_up(s, (sector_t)1 << bb->shift);
> +		target = round_down(target, (sector_t)1 << bb->shift);
> +		if (s < orig_s || target < s)
> +			/* Rounding wrapped, or range collapsed */
> +			sectors = 0;
> +		else
> +			sectors = target - s;
> +
> +		if (sectors == 0)
> +			return false;
>  	}
>  
>  	write_seqlock_irq(&bb->lock);
> @@ -1303,12 +1330,23 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>  
>  	WARN_ON(bb->shift < 0 || sectors == 0);
>  
> +	if (s > ULLONG_MAX - sectors)
> +		/* Range wraps past the end of sector_t */
> +		return -EINVAL;
> +

same
	if ((s + sectors) < s)
		return fasle;

But I feel returning -EINVAL doesn't follow badblocks_check() api convention,
and has potential risk to break the caller's code.  IMHO it is better to
return 0.


>  	if (bb->shift > 0) {
>  		/* round the start down, and the end up */
>  		sector_t target = s + sectors;
>  
> -		s = round_down(s, 1 << bb->shift);
> -		target = round_up(target, 1 << bb->shift);
> +		if (bb->shift >= BITS_PER_LONG_LONG)
> +			/* Corrupt/unsanitised shift value */
> +			return -EINVAL;
> +
bb->shift checking here might not be necessary. See my finally comments.
And again, returning -EINVAL might be risky here.



> +		s = round_down(s, (sector_t)1 << bb->shift);
> +		target = round_up(target, (sector_t)1 << bb->shift);
> +		if (target <= s)
> +			/* Rounding wrapped past the end of sector_t */
> +			return 0;
>  		sectors = target - s;
>  	}
> 

I feel you can avoid to check bb->shift here. Except for md code, other places
all set bb->shift to 0. So add a code in md.c to check the shift bits when it
is loaded form on-disk super block, that should be enough. and one line
code comment can be added in badblocks API that caller should take the
responsibility to make sure bb->shift won't result overflow.

Thansk.

Coly Li
