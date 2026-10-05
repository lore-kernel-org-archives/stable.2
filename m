Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7282ED84A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187618; cv=none; b=lsdwpcEGjhUxqqcIQwV9DwyiJlG0ZWnlLBycaryVKplivhwDb1yPJCgj/hh4PdQU7zD473SNUfXipNSvJET9p6Fm+XMDBTkIlikM1KWGAdk6e8gidy8F+AkyvDNXpXEhveVoSk0GvT9Ku8FjtE1hlSugFt5Xju67kNqB6Y+LFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187618; c=relaxed/simple;
	bh=YepKt2tq52zcBuHMZboM6MbZEaZOLanYhaKyCPYKwMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ectLgg6VVLDUyYZXqQW7ORBRNy0hoThImC3DIcgXFG+6V0mXrMNNqsytJjLbaucFQOZzJMUuQPDItODYgJ7gMg0fEp/5vleAmtAU/jUZse0nbwdOSnn+DyUSiAaQQQaNEDKRomRGodKv/eqoBPVpEb4h9WPQakeJO5YEZUp9QgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNVFlJge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNVFlJge"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 73B6F1F000FF;
	Mon,  5 Oct 2026 08:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187617;
	bh=1p3shuG7d2kkRrydtMUVjfnvnFf6tLBz7SSd+tczzoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNVFlJgeiYW7FxV8qQeqM2FMsZeO/sHZduXTBVMYAaNOG3lunbSO9QVEcDhTiqof9
	 iSV+JBxoQOxX9fEZ+Nng+W3BfHvSi04WmzA2lWGTp3NPlaHjcYjDCrff2DFYX18qte
	 tu+XXQ4kG4eA/MSMS5Wg1p7skldY9xJOPUbvPw2Meko/0R/PZVLz+X8zgFXxxh8WDw
	 f9GDkV6z10r4X0QiibnkXWzvBzdBkp3sxAF3PATIk19uH+f57+1OdcQBGOTV3C4Pii
	 g0jMDt+qFLCfqf0f2k6eOinFW3W20mhryDnnuGO78obTEf5Hyt+BWFTfA4p9kf7oD6
	 Va5x9IR/+Eweg==
Date: Mon, 5 Oct 2026 11:06:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: gregkh@linuxfoundation.org
Cc: yijiangshan@kylinos.cn, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tpm: Fix auth session leak in
 tpm2_get_random() error path" failed to apply to 7.2-stable tree
Message-ID: <asNanSK7VMtbc9tf@kernel.org>
References: <2026100316-exclusion-mustang-f624@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026100316-exclusion-mustang-f624@gregkh>

On Sat, Oct 03, 2026 at 03:20:16PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 7.2-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1e2f9a611b334ce6ed1dc4a9e1587c7a11d2be30
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100316-exclusion-mustang-f624@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

I backported the other failing patch to stable kernels but this is
clearly my bad i.e. it does not need stable backport at all.

Sorry, can be safely ignored.

> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 1e2f9a611b334ce6ed1dc4a9e1587c7a11d2be30 Mon Sep 17 00:00:00 2001
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> Date: Wed, 2 Sep 2026 15:48:39 +0800
> Subject: [PATCH] tpm: Fix auth session leak in tpm2_get_random() error path
> 
> When tpm_buf_fill_hmac_session() fails in tpm2_get_random(), the error
> path returns without calling tpm2_end_auth_session(), leaking the auth
> session. All other error paths in the function handle this correctly.
> 
> Fixes: 3d9e043dab0a ("tpm-buf: Memory-safe allocations")
> Cc: stable@vger.kernel.orga # v6.12+
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> Link: https://lore.kernel.org/r/20260902074839.417419-1-yijiangshan@kylinos.cn
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 48cec39995fe..96e0e06bbbf0 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -281,8 +281,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  		}
>  		tpm_buf_append_u16(buf, num_bytes);
>  		err = tpm_buf_fill_hmac_session(chip, buf);
> -		if (err)
> +		if (err) {
> +			tpm2_end_auth_session(chip);
>  			return err;
> +		}
>  
>  		err = tpm_transmit_cmd(chip, buf,
>  				       offsetof(struct tpm2_get_random_out,
> 


Br, Jarkko
