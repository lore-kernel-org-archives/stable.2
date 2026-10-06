Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B083B71DC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276034; cv=none; b=J9ua+FW/wbPveFv4SNC2Wvixfo9T2mlD4cVLWJz4Prb3+2ou7jkl/XDidMSRWYTvD4GspMmAvzl0w3u2s0o09QKY+DkWZK6AWzE9Qp71cEtGVhXSoVTvDVK0rywSvbXQx+AA6CuXsdOF6hv/rrFGIxarwoKaEzFO23+m2crxUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276034; c=relaxed/simple;
	bh=xxSTO/xdQBco7iQpYIT0E3BtjsQC7FGn/b+5e6zl/4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOqo2mzAfP9tvG55TGqpVsVAQo6OTrugZltJ6rjoriORwt6HcM1t5knnArxpgwEm8hZI7OW9pyCm1SMdD9f0+PbAK6hnGkoszFFTHuWjOWRVjytLkENAIMqc7vg6PiocGGy0ZDUh3oCikB4/nS7YRVw/wC2ODgvRZzpj6XHGerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=YsdyO5nA; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="YsdyO5nA"
Received: (wp-smtpd smtp.wp.pl 27085 invoked from network); 6 Oct 2026 10:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1791276024; bh=u32rIA+ebJvRNAzsi0CEVF/UH8RYqLgEbKPGOr3aUIA=;
          h=From:To:Cc:Subject;
          b=YsdyO5nAov4/rdsWF5G6OERvOS5oBxNUv4HQLw5pPM+TuxDbNLJU+4FS0r3IyvQEh
           WnQsQHDmWLgNKAMJHiNeS617RV8CgnHYtREnVSPUo0r6mNIl6YV50zeprfm6RDqqN8
           vhFaPy3btGJZbAPtq8XnHtpTZnZcA/iFPUf5MvROobjE+EKMK+Qsucnzx1bFX+AfFC
           tANjK4QXVqFvyupXs4OqJU5q8qd2FiqCqKmasNtqA+uKLh+ahNqhzDFhjq26Je7tsV
           dd0EfQyWK8PrzBDjJxC4HKTyXXhuivRZ2d9IGMJDldRUV1swMlxS+Su9M0CJkAdmwi
           vN7sDP426ZtcQ==
Received: from localhost (77-236-6-58.static.play.pl [77.236.6.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <runyu.xiao@seu.edu.cn>; 6 Oct 2026 10:40:24 +0200
Date: Tue, 6 Oct 2026 10:40:23 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] wifi: iwlegacy: serialize watchdog updates with device
 teardown
Message-ID: <20261006084023.GA28327@wp.pl>
References: <20261004114519.1233305-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004114519.1233305-1-runyu.xiao@seu.edu.cn>
X-WP-MailID: daa2ea11ae5572eb5b65c94f5f4eaa40
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8eNh]                               

On Sun, Oct 04, 2026 at 07:45:19PM +0800, Runyu Xiao wrote:
> The writable wd_timeout debugfs file changes il->cfg->wd_timeout, but the
> iwl3945 configuration is shared and const. The handler also rearms the
The cfg in il_priv is not const. What would possibly make sense is
take _all_ modified fields out, and make it const then.

> watchdog without taking il->mutex. The down paths hold this mutex, delete
> the timer, and then free the TX queues, so an unlocked debugfs write can
> rearm the timer after deletion. The callback can then access the queues
> after they have been freed.
> 
> Store wd_timeout in per-device state. Serialize the debugfs update with
> the down paths and only arm the watchdog while TX queues exist. Use
> READ_ONCE() and WRITE_ONCE() for accesses that do not hold il->mutex.
> 
> Fixes: 1dc80798a8ca ("iwlegacy: constify local structures")
This is wrong tag. At least for watchdog stop races.

> --- a/drivers/net/wireless/intel/iwlegacy/debug.c
> +++ b/drivers/net/wireless/intel/iwlegacy/debug.c
> @@ -1284,8 +1284,12 @@ il_dbgfs_wd_timeout_write(struct file *file, const char __user *user_buf,
>  	if (timeout < 0 || timeout > IL_MAX_WD_TIMEOUT)
>  		timeout = IL_DEF_WD_TIMEOUT;
>  
> -	il->cfg->wd_timeout = timeout;
> -	il_setup_watchdog(il);
> +	mutex_lock(&il->mutex);
> +	WRITE_ONCE(il->wd_timeout, timeout);
> +	if (il->txq)
> +		il_setup_watchdog(il);
This will not work for 4965. Possibly il->is_open could be used as
check. But maybe we should just remove possibility of setting
wd_timeout, I need to think about it.

Regards
Stanislaw
> +	mutex_unlock(&il->mutex);
> +
>  	return count;
>  }
>  
> -- 
> 2.34.1
