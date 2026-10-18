Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF187424D57;
	Sun, 18 Oct 2026 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348086; cv=none; b=JgmXIfBPPMl3xzBgr0w2WcJwCEhEJueELkV+7mExG0kTlzLllngL7kShxgE8P5TDvSfnoqWiVKwi4FOwXOUq6wLgTX1/cMXI4GUpt1lkQoa/YNWoSA5+CnZwyJJ4893S732lFZwYdpRtmPf2Qp0uiS1IGoLWhyLr2w2LD8QASKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348086; c=relaxed/simple;
	bh=chMvDAUU4VpeytL4Mpotw5b6XR43myRzd/o3SsR5a6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEWX8vdrfl0HhMDuVmotw4G/JYkLbX63tyjY3jlZ/I+wyEPkzj7zyxYT3BiQdERDuzeuaPT3O3V5EevlsXn9yZ6Z4jUz2NSZagzJZGrGpwwXZ395Sk7RYpTmnEuT/Xvb91kvFL2rUeOkuZL9Efxc/upNPSTRn7grMVAzl/WO6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=u1Ozfy3j; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=u1Ozfy3j; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="u1Ozfy3j";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="u1Ozfy3j"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id C4741A1D5E;
	Sun, 18 Oct 2026 20:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1792348074; bh=chMvDAUU4VpeytL4Mpotw5b6XR43myRzd/o3SsR5a6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1Ozfy3juQKRWTtw72rsBzlvkFPj/uRH1U5302uzraAK8ryL4kIqBR7FMBmfM5weM
	 6ce1vth3HIGeOq6vzD0MNkKXiptffY0gAtSrp47pPnBG75Y0hCpObs1XYYdy2tYNer
	 iJ1E4tX8E5aoWttUW3b75P/AxrLdJj27CWJSogqAqfaqS8HVkHj3aXc/h4MOr/qG7z
	 tgmhXeE1LXHvcU3AMKW7rXMizW/YxthbAvqmBiDAqj44AIyqENQ+v+p4oAKcitgHRY
	 m3IlmheBq4eXEPsgh7lmubiEXMtSvgMK/kqDv4gg8aEkLyKiazlw+lZ0gButXrfTwx
	 13tyswKvbXfkA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gwWvX0cmKh7; Sun, 18 Oct 2026 20:27:54 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 96D1BA1C00;
	Sun, 18 Oct 2026 20:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1792348074; bh=chMvDAUU4VpeytL4Mpotw5b6XR43myRzd/o3SsR5a6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1Ozfy3juQKRWTtw72rsBzlvkFPj/uRH1U5302uzraAK8ryL4kIqBR7FMBmfM5weM
	 6ce1vth3HIGeOq6vzD0MNkKXiptffY0gAtSrp47pPnBG75Y0hCpObs1XYYdy2tYNer
	 iJ1E4tX8E5aoWttUW3b75P/AxrLdJj27CWJSogqAqfaqS8HVkHj3aXc/h4MOr/qG7z
	 tgmhXeE1LXHvcU3AMKW7rXMizW/YxthbAvqmBiDAqj44AIyqENQ+v+p4oAKcitgHRY
	 m3IlmheBq4eXEPsgh7lmubiEXMtSvgMK/kqDv4gg8aEkLyKiazlw+lZ0gButXrfTwx
	 13tyswKvbXfkA==
Received: from samy by end with local (Exim 4.100.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1xIVbu-000000024zb-14Km;
	Sun, 18 Oct 2026 20:27:54 +0200
Date: Sun, 18 Oct 2026 20:27:54 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
	w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] speakup: Guard late sysfs operations on speakup_kobj
Message-ID: <atUPqhnnTnPVPSUH@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
	stable@vger.kernel.org
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
 <20261014071713.321914-4-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014071713.321914-4-xiehongyu1@kylinos.cn>
Organization: I am not organized

Hongyu Xie, le mer. 14 oct. 2026 15:17:12 +0800, a ecrit:
> speakup_kobj_init() drops the kobject on its error path and
> speakup_kobj_exit() drops it on removal, but neither clears the
> global pointer.  When built-in speakup fails late in speakup_init()
> (e.g. a kthread_create() failure, whose error path runs
> speakup_kobj_exit()), or when the kobject setup itself fails, the
> dangling speakup_kobj stays behind: a later insmod of a synth driver
> then reaches sysfs_create_group() through synth_add()->
> do_synth_init() and dereferences the freed kobject:
> 
>     boot (built-in speakup)         later insmod (synth driver)
>     --------------------------      ---------------------------
>     speakup_init() fails late:
>       err_speakup:
>         kobject_put(speakup_kobj);
>         /* speakup_kobj stays set */
> 
>                                     synth_add() -> do_synth_init()
>                                       sysfs_create_group(speakup_kobj,
>                                                          &attributes)
>                                       /* freed kobject: UAF */
> 
> Clear the pointer right after kobject_put() so the late
> sysfs_create_group() fails cleanly on the NULL check instead of
> touching freed memory:
> 
>       err_speakup:
>         kobject_put(speakup_kobj);
>         speakup_kobj = NULL;
> 
>                                     sysfs_create_group(NULL, ...)
>                                       /* fails cleanly: the NULL
>                                          check is sysfs's own */
> 
> The removal side needs the same guard: when the kobject setup
> failed, a first insmod of a synth driver fails in do_synth_init()
> (synth stays set because that error path does not roll it back),
> and a second insmod then goes through synth_release(), whose
> sysfs_remove_group() would now meet speakup_kobj == NULL and crash
> on the NULL kobject:
> 
>     first insmod                    second insmod
>     -----------                     ------------
>     do_synth_init():
>       synth = in_synth;
>       probe() fails                 synth_release():
>       /* no rollback:                sysfs_remove_group(
>          synth stays set */            speakup_kobj == NULL, ...)
>                                       /* NULL kobject: the crash
>                                          the NULL clear above would
>                                          itself introduce without
>                                          the guard below */
> 
> Skip the group removal when the kobject is gone, mirroring the
> NULL check that sysfs_create_group() already performs on its own:
> 
>                                     if (synth->attributes.name &&
>                                         speakup_kobj)
>                                       sysfs_remove_group(...)
>                                       /* skipped: the kobject is
>                                          gone */
> 
> Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
> Cc: stable@vger.kernel.org
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

Samuel

> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/accessibility/speakup/kobjects.c | 2 ++
>  drivers/accessibility/speakup/synth.c    | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
> index a73b478e06de0..e1860f8d9d422 100644
> --- a/drivers/accessibility/speakup/kobjects.c
> +++ b/drivers/accessibility/speakup/kobjects.c
> @@ -1041,6 +1041,7 @@ int speakup_kobj_init(void)
>  	sysfs_remove_group(speakup_kobj, &main_attr_group);
>  err_speakup:
>  	kobject_put(speakup_kobj);
> +	speakup_kobj = NULL;
>  err_acc:
>  	kobject_put(accessibility_kobj);
>  out:
> @@ -1052,5 +1053,6 @@ void speakup_kobj_exit(void)
>  	sysfs_remove_group(speakup_kobj, &i18n_attr_group);
>  	sysfs_remove_group(speakup_kobj, &main_attr_group);
>  	kobject_put(speakup_kobj);
> +	speakup_kobj = NULL;
>  	kobject_put(accessibility_kobj);
>  }
> diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
> index 40870949b3c6b..1af80eb116af6 100644
> --- a/drivers/accessibility/speakup/synth.c
> +++ b/drivers/accessibility/speakup/synth.c
> @@ -580,7 +580,7 @@ void synth_release(void)
>  		wake_up_process(task);
>  	rcu_read_unlock();
>  	wait_event(synth_catch_up_waitq, !atomic_read(&synth_catch_up_count));
> -	if (synth->attributes.name)
> +	if (synth->attributes.name && speakup_kobj)
>  		sysfs_remove_group(speakup_kobj, &synth->attributes);
>  	for (var = synth->vars; var->var_id != MAXVARS; var++)
>  		speakup_unregister_var(var->var_id);
> -- 
> 2.25.1
> 

-- 
Samuel
<D> m'enfin, le 5 juillet, le mec vient visiter le labo...
* D a marque d'une croix rouge le 5 juillet sur son agenda
<y> niarc niarc niarc
<D> cet homme va souffrir
<B> c'est donc le 5 juillet qu'il meurt d'un accident de la route écrasé par un truck muni d'un pare buffle
 -+- #ens-mim - repaire de terroristes -+-
