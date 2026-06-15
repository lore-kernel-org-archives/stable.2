Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1125145B3F;
	Mon, 15 Jun 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522317; cv=none; b=mATRk1XJUGIjyM0TRdnkvXDPvroactHfT/dRWzDQfaAgXgkUgwHHyMrZ2of6da/HB2mZlKLDjQPhbTW0wLzzX5BwH8jIR11gjGnu2w2YU3RxVMUXa3QnRW504BDn21UHHLOIRiG2KTTX+zx8i2vBzb614K90WmuNBG3Bpqc5otQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522317; c=relaxed/simple;
	bh=0gwyROiMOHpdV2hu3dErFMBsHY+LszkmC9DeWK3L/yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A26xFVFBzJ0YPngLPd0fltQMeruhR9I5lUmQn0VW0ejLqMCr9U5IIPNtR1AyVNR0J6hloMK7DUdYT2WDjpr0IxzU2Zj5GQg5VLwcwiG7yLNGGKkdeoSeAGL/MrN1wA+05PHK+lQ3NJT0i/DWCI1jNJD20aqs5hBBgui3OrZiMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuSW9N7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuSW9N7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206551F000E9;
	Mon, 15 Jun 2026 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522316;
	bh=nlAdSspiA7Bhnac4eiBLskoKBbZVwpaObQnTtm83GQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RuSW9N7qBidJDiUteYXSIlCbwiCepLdxJpiPmiOtkdSBPqJY1xUbriVTtbYZCkHLi
	 1gohywC3PomqUI+T3gTvJ/+FpvnCQlTJpEijMmvWqs+is+WAOESNcSEDLV1Cs03Y0A
	 M+Wa834/pEMq5jlCBoHDlEPXIW93Z72kDiyZrIXhJdJBOvNmmSGDKryAjZ2T0SZ37M
	 GPzACIiBK2CqRIsCqDJmcTH9cG48yyTTPMpOdcxv13JjZbsK12qh0wWZjmWHDLMGE2
	 VjHTT7agteubUJPoLQ454uHikep72PR8XisfpGDzAW7KQyNyaxTdeQw6NlRB+hZ8IK
	 ckNyIpYvvvTUA==
Date: Mon, 15 Jun 2026 12:18:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Chun-Yi Lee <jlee@suse.com>, 
	David Howells <dhowells@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Message-ID: <ai_fWlr61AzrNrDz@lucifer>
References: <20260615104750.1000-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615104750.1000-1-jlee@suse.com>

On Mon, Jun 15, 2026 at 06:47:50PM +0800, Chun-Yi Lee wrote:
> From: Chun-Yi Lee <jlee@suse.com>
>
> Commit 651fdda8406d ("relay: update relay to use mmap_prepare")
> changed the `mmap` file operation to `mmap_prepare` for relayfs, but
> the lockdown check in debugfs was not updated accordingly.
>
> This prevents debugfs from being locked down when the kernel is in
> integrity mode if a file uses `mmap_prepare` but not `mmap`.
>
> Since the conversion to `mmap_prepare` across the kernel is not yet
> complete, update the lockdown check to look for both `mmap` and
> `mmap_prepare` to ensure comprehensive coverage.
>
> Fixes: 651fdda8406d ("relay: update relay to use mmap_prepare")
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> Cc: David Howells <dhowells@redhat.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: driver-core@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
> v2:
> - Add explicit From tag to match Signed-off-by.
> - Fix Lorenzo's email address.
> - Add Cc stable for backporting.
> - Check both mmap and mmap_prepare as suggested by Lorenzo.
>
>  fs/debugfs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index edd6aafbfbaa..08de6652a4f3 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -273,7 +273,8 @@ static int debugfs_locked_down(struct inode *inode,
>  	    (!real_fops ||
>  	     (!real_fops->unlocked_ioctl &&
>  	      !real_fops->compat_ioctl &&
> -	      !real_fops->mmap)))
> +	      !real_fops->mmap &&
> +	      !real_fops->mmap_prepare)))
>  		return 0;
>
>  	if (security_locked_down(LOCKDOWN_DEBUGFS))
> --
> 2.43.0
>

Cheers, Lorenzo
