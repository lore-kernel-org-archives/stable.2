Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD13D567E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000964; cv=none; b=dEX8DmCGbe9SHXGc8mubU5ueEnyrSYMN8trsK7lpOUEBEZjofvPwD7FlkO0dSXykYSaJ8H9ReI73Y8fpaupP/PvZZz34Foo+lhI8U3uDyJnCkUeMISAOc/Vz/BwB2dTt2nGZREXtfzlQGCD3lRXmB2ledcqliAVSGdJb3Pg/obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000964; c=relaxed/simple;
	bh=ZADYxEHgY31ANtKR20Ns8KMjFX6OJPTaHjT95ujZpn4=;
	h=Mime-Version:Content-Type:To:Cc:From:Date:Message-Id:References:
	 Content-Disposition:In-Reply-To:Subject; b=Hq/22LJhmPZSwrdLF2EsMZrdm0hsMHyd8Gns3YiBK7HHFl2gcvuwtjECqVnWtNp8sDUPRaSVTlUOY3jBFyiIkTgHdotAbgHFV50yYAgnWdvgCz03qOAsp4vhOGsvcBd2fuRmBVFyNa69rrxXSRvrJ6KP4Twag3ZQX0wDykTPaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=E6VD3DQy; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="E6VD3DQy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1786000949;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sPD70un3PjIGrmRayhxfejfWv+8T4Nu+q/5HU8PUOUg=;
 b=E6VD3DQyIGJ6XuIdLEfmS3Q3AFr1fbjBtHvtNi6M6ht03hnFf6/DdEJrTro1zFBoj8AsOU
 t/0+Jt7buutUbcM2xtsA0skEMhe9Ex5oVg+K5hc+uc6pZcNvbzlHObt8mYO/5DRwd8FwfM
 Fh4VA8ls2rCGQbWEo1FvqRKqGWkrZtjyohEIljwTzhYywi9sLIdv9WlOSl0Wk93Udd2cNy
 HtLGp29ceh5s5BmskzOz6+vswpbQBCwzrz+RRTgqaNiOsGQl8d+D6o38fdbQivudM28kn8
 FBDNDl7XjpV7Mrc7TJpMEmNR91kOmRN7fnODEPUvhKy+rfmM9XX43M8LjTvflg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a743634+f78ee9+vger.kernel.org+colyli@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Ramesh Adhikari" <adhikari.resume@gmail.com>
Cc: <axboe@kernel.dk>, <gregkh@linuxfoundation.org>, 
	<linux-block@vger.kernel.org>, <stable@vger.kernel.org>
From: "Coly Li" <colyli@fygo.io>
Date: Thu, 6 Aug 2026 15:22:25 +0800
Message-Id: <anQdWeHd2EDZtkzp@studio.local>
References: <20260709131904.596684-3-adhikari.resume@gmail.com> <20260721164027.637078-1-adhikari.resume@gmail.com> <20260721164027.637078-3-adhikari.resume@gmail.com>
Content-Disposition: inline
In-Reply-To: <20260721164027.637078-3-adhikari.resume@gmail.com>
Subject: Re: [PATCH v7 2/2] badblocks: validate sector range and shift before rounding
Received: from studio.local ([120.245.64.97]) by smtp.larksuite.com with ESMTPS; Thu, 06 Aug 2026 07:22:27 +0000
X-Original-From: Coly Li <colyli@fygo.io>

On Tue, Jul 21, 2026 at 10:10:24PM +0800, Ramesh Adhikari wrote:
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
> Add an explicit s+sectors overflow check and cast the shift
> operand to sector_t so the shift itself is never performed on a
> 32-bit int, and detect post-rounding wrap by comparing the
> rounded result back against the pre-rounding value.
> 
> badblocks.c does not itself bound bb->shift: every caller except
> drivers/md/md.c always leaves it at 0, so the one caller that
> populates it from untrusted on-disk data is responsible for
> bounding it before assigning it, per struct badblocks's shift
> field documentation in include/linux/badblocks.h. That md.c-side
> bound is being sent as a separate patch.
> 
> badblocks_check() returns 0 rather than -EINVAL on the wrap case,
> matching its existing "0: no known bad blocks in the range"
> return convention instead of introducing a new error path callers
> don't expect.
> 
> Suggested-by: Coly Li <colyli@fygo.io>
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>

The patch looks good to me, thanks.

Reviewed-by: Coly Li <colyli@fygo.io>

BTW, the shift overflow checking in md raid code is accepted by
md maintainer, so you may submit these 2 patches with my Reviewed-by
to Jens. That's enough.

Coly Li

> ---
> Changes in v7 (per Coly Li's review of v6):
>  - Simplify the overflow check in all three call sites from
>    "s > ULLONG_MAX - sectors" to "(s + sectors) < s".
>  - Drop the "bb->shift >= BITS_PER_LONG_LONG" guards in badblocks.c.
>    Only drivers/md/md.c ever sets a nonzero bb->shift, so the bound
>    belongs where bblog_shift is read off the on-disk superblock, not
>    scattered through the badblocks API. Documented the caller
>    requirement on struct badblocks.shift in badblocks.h instead; the
>    md.c-side bound follows as a separate patch.
>  - badblocks_check() now returns 0 instead of -EINVAL on the wrap
>    case, consistent with its existing return convention.
> 
>  block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
>  include/linux/badblocks.h |  6 +++++-
>  2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 1f786b193fb..728b59a1a5d 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -853,12 +853,19 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
>  		/* Invalid sectors number */
>  		return false;
>  
> +	if ((s + sectors) < s)
> +		/* Range wraps past the end of sector_t */
> +		return false;
> +
>  	if (bb->shift) {
>  		/* round the start down, and the end up */
>  		sector_t next = s + sectors;
>  
> -		s = round_down(s, 1 << bb->shift);
> -		next = round_up(next, 1 << bb->shift);
> +		s = round_down(s, (sector_t)1 << bb->shift);
> +		next = round_up(next, (sector_t)1 << bb->shift);
> +		if (next <= s)
> +			/* Rounding wrapped past the end of sector_t */
> +			return false;
>  		sectors = next - s;
>  	}
>  
> @@ -1061,7 +1068,12 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		/* Invalid sectors number */
>  		return false;
>  
> +	if ((s + sectors) < s)
> +		/* Range wraps past the end of sector_t */
> +		return false;
> +
>  	if (bb->shift) {
> +		sector_t orig_s = s;
>  		sector_t target;
>  
>  		/* When clearing we round the start up and the end down.
> @@ -1071,9 +1083,16 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		 * isn't than to think a block is not bad when it is.
>  		 */
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
> @@ -1303,12 +1322,19 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>  
>  	WARN_ON(bb->shift < 0 || sectors == 0);
>  
> +	if ((s + sectors) < s)
> +		/* Range wraps past the end of sector_t */
> +		return 0;
> +
>  	if (bb->shift > 0) {
>  		/* round the start down, and the end up */
>  		sector_t target = s + sectors;
>  
> -		s = round_down(s, 1 << bb->shift);
> -		target = round_up(target, 1 << bb->shift);
> +		s = round_down(s, (sector_t)1 << bb->shift);
> +		target = round_up(target, (sector_t)1 << bb->shift);
> +		if (target <= s)
> +			/* Rounding wrapped past the end of sector_t */
> +			return 0;
>  		sectors = target - s;
>  	}
>  
> diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
> index 996493917f3..5d88992b55a 100644
> --- a/include/linux/badblocks.h
> +++ b/include/linux/badblocks.h
> @@ -34,7 +34,11 @@ struct badblocks {
>  				 */
>  	int shift;		/* shift from sectors to block size
>  				 * a -ve shift means badblocks are
> -				 * disabled.*/
> +				 * disabled. Callers that set this from
> +				 * untrusted/on-disk data are responsible
> +				 * for bounding it so 1 << shift does not
> +				 * overflow a sector_t.
> +				 */
>  	u64 *page;		/* badblock list */
>  	int changed;
>  	seqlock_t lock;
> -- 
> 2.43.0
