Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0641A515;
	Tue, 28 Jul 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231685; cv=none; b=NE5enV0IL390xilwCMmVO6uvr9SLQZggsbla6SMBN8DcvNs3AJMQFxWz2TxAyk20F0plzji7rxBofTQpP2jf7gar0Ru1NHfR07c7gi9jXQ+b86iu8wdoYGNbBJQ5fyU7INYoJ9i2O+jGiu3m4aD+hp6/QrE8+adUIOrpYteLyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231685; c=relaxed/simple;
	bh=Jfv0gHF0qSBOuTdBrzC/TRiXkEkvfk+0s6JsvU2f0eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6rf2zMwC402mHfkpLh78EdP4VMAhkp33Pz4xIrrDCVKNcZNiDHWyJqikZkkNje+NqapoWf1rfO3u2GR4Mpsgcpl+mX89/J0zwKu+s5THEdOvizO8WzmIaHcdRelHG63RBhouymuQLJ+tZpAkHkZ4CJVh27l6qaWM5niC1NxUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlX+bFYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlX+bFYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15371F000E9;
	Tue, 28 Jul 2026 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785231682;
	bh=ZC0iq1dogzcBmMyhVQ8EG2PIPDnoAF/WBKKc3QubIkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nlX+bFYVfYejFgL9cV2zBoYgH8E4URfnrbqbDSg2MbFRu5S9FG5uPIBEaYA9tMku0
	 kcqkowr3G8L/nmaXUdT7FOzFES4lPWpmgLUWxZD/u/OS5s8KVeK68Sy+JLWlC6ET9h
	 eR+r8CVEkFF5KF1+W0HJvgtRqr2seYxmx3Nzp2H8zecWjzc8cHwGZlUAA3wkWw9IYN
	 Chm5LaegHG7hfXNPDNeYNuF/kLbQf5/qR/Zdoei83jHgBBTLnfl6eicUphXz+RTbv+
	 y6FHYLS2vQGNYwRGhpXNdvmH3qgv6CDwwEQNkHwZqAcv4Qs1kj/lAngqRIJXF/2poq
	 JPurzSVWWMiHg==
Date: Tue, 28 Jul 2026 10:41:19 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, christophe.ricard@gmail.com,
	sameo@linux.intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: st-nci: drain se_info timers on remove before
 NCI teardown
Message-ID: <20260728094119.GS418547@horms.kernel.org>
References: <20260722034729.3254078-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722034729.3254078-1-fanwu01@zju.edu.cn>

On Wed, Jul 22, 2026 at 03:47:29AM +0000, Fan Wu wrote:
> st_nci_se_init() initializes two se_info timers (bwi_timer and
> se_active_timer) in probe, but st_nci_se_deinit(), the teardown helper
> that drains both timers, has no caller in drivers/nfc/st-nci/:
> st_nci_remove() tears the device down with ndlc_close /
> nci_unregister_device / nci_free_device and never reaches it (dead since
> the st21nfcb -> st-nci rename). The bwi_timer callback
> st_nci_se_wt_timeout() calls nci_hci_send_event(), i.e. it uses the NCI
> core. Both callbacks dereference info->se_info, and the bwi_timer callback
> also dereferences info->ndlc->ndev.
> info is devm_kzalloc()'d, so a timer armed during operation survives
> st_nci_remove, fires after the devm release, and dereferences freed
> memory (and a half-torn-down NCI core).
> 
> Call st_nci_se_deinit(ndev) from st_nci_remove() before
> nci_unregister_device(ndev): the bwi callback reaches into the NCI core,
> so the timers must be drained while the NCI workqueues still exist.
> Convert both drains to timer_shutdown_sync() and drop the bwi_active /
> se_active predicate guards. timer_shutdown_sync() is harmless for an
> inactive timer and prevents later mod_timer() calls from rearming it, so
> any residual HCI work during nci_unregister_device()'s workqueue teardown
> cannot rearm a se_info timer.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: ed06aeefdac3 ("nfc: st-nci: Rename st21nfcb to st-nci")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Hi Fan,

The AI-generated review of this patch on sashiko.dev [1]
flags several issues. I'm passing on those marked as pre-existing
there, as I think they are best considered in the context of
possible follow-up. But I am wondering if you could look at
the ones I've pasted in-line below.

[1] https://sashiko.dev/#/patchset/20260722034729.3254078-1-fanwu01%40zju.edu.cn

> ---
>  drivers/nfc/st-nci/core.c | 1 +
>  drivers/nfc/st-nci/se.c   | 6 ++----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
> index a367136..57dbc4a 100644
> --- a/drivers/nfc/st-nci/core.c
> +++ b/drivers/nfc/st-nci/core.c
> @@ -166,6 +166,7 @@ void st_nci_remove(struct nci_dev *ndev)
>  
>  	ndlc_close(info->ndlc);
>  
> +	st_nci_se_deinit(ndev);
>  	nci_unregister_device(ndev);
>  	nci_free_device(ndev);
>  }

  "Can moving st_nci_se_deinit() before nci_unregister_device() cause a
   deadlock with userspace operations?

  "If a userspace process initiates an SE command via netlink, it acquires
   device_lock and waits in st_nci_control_se() for the se_active_timer
   completion.

  "Concurrently, if device removal executes st_nci_remove(), it calls
   st_nci_se_deinit() which shuts down the timer without signaling
   completion. The netlink thread will hang indefinitely holding device_lock.

  "When st_nci_remove() proceeds to nci_unregister_device(), it calls
   nfc_unregister_rfkill(), which attempts to acquire the same device_lock.
   Would this result in an ABBA deadlock?

> diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
> index 607ec76..8ab18cb 100644
> --- a/drivers/nfc/st-nci/se.c
> +++ b/drivers/nfc/st-nci/se.c
> @@ -751,10 +751,8 @@ void st_nci_se_deinit(struct nci_dev *ndev)
>  {
>  	struct st_nci_info *info = nci_get_drvdata(ndev);
>  
> -	if (info->se_info.bwi_active)
> -		timer_delete_sync(&info->se_info.bwi_timer);
> -	if (info->se_info.se_active)
> -		timer_delete_sync(&info->se_info.se_active_timer);
> +	timer_shutdown_sync(&info->se_info.bwi_timer);
> +	timer_shutdown_sync(&info->se_info.se_active_timer);

  "Does unconditionally shutting down bwi_timer here leak the se_io_ctx
   and hang the netlink socket?

  "Because the PHY is disabled just prior by ndlc_close(), no hardware
   response can arrive. The timeout callback st_nci_se_wt_timeout() would
   normally free se_io_ctx via info->se_info.cb() and reply to the socket.

  "By shutting down the timer without resolving pending I/O callbacks, are
   we leaking this memory and leaving the netlink caller waiting indefinitely?

>  
>  	info->se_info.se_active = false; info->se_info.bwi_active = false;
>  	-- 2.34.1
> 
