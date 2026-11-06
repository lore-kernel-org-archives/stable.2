Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960218;
	b=TozrQS2zvMPbA1zEYPFRgjYFVku0wdsGYOPYjbY8ek4DHML2cmUrgpzxkbN2rQnr7zHY
	 5ca5KoFPmytBoGSOomPyX/yigdMh1zAr1dZD02cmnyTVczmYc6I+S0+5biLh8utD2e5k3
	 8mdXttiIGdfcabbBuFlz33u0h6ZJOY7n3EoEX/B4xo8t4RPc2IrlQKFCd8B+f6lE0kc5C
	 bBtGcq6NaQeiKu/YU6uuUzG9VlQ7pzAk85CK3UyuHjy6sHnisP/mv5B+/0vhoQdO9ch9/
	 gUTKrOlKazEl+fYaN41vgPC8I/1cvMDIF14PRuQez7pe2gVGX4NFvFlUL4ihhgUCf8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960218;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8oRd22s00j3S8y/WVhMir3siqAHME1vEF2A6XeLZepc=;
	b=MOyCUID9uG3ozu6SFXT9wf7H5TO0UfG1MYFrz7KtwLOGKY0HGQLpKfau0k65ytT+mHhW
	 xY4HgZmKh+mEWRwGEA4TddhBvjszNBKBrX1OBWiL0M5tJpjWnWufWxMjBpHFNwmSCC8jo
	 Ax0S/xWIu2uTPk/bq5DWuCB8IrmnE69gY5uMT6N7MSpcL/ksiKe0X+4yi0/tRTStVq44D
	 jgCWc8QOf025XQUHMmsJHt+kUKbcbHGgDVVIc9OP0jmIreCah0q3d9tSbQ7N1uvFB2M+A
	 9cNuqPUFL3t/FbGro7lXUiuPU4LESl6OxdgpNArnPGjC34JoI1bB8Cifz6GBkpduGmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GG0+1x8w;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61399606A32E;
	Fri,  6 Nov 2026 10:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61399606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GG0+1x8w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	From:Reply-To; bh=8oRd22s00j3S8y/WVhMir3siqAHME1vEF2A6XeLZepc=; t=1793960215;
	x=2109320215; b=GG0+1x8w7O8QoScE2AcODMLwjedwY/J2ZKOa73jxL99jL691IA3V5MD3ZTnQN
	u5aFwWJCBsyDLYujO2iXSPYzN6es4W/1WvPKbvTkXbFjI7DvuFlImEm+k8BWA7BT4XEjD4jsr3Nw8
	VUwkJ5/huAUZtn8rkKYZ9jrzCFZqSbZXkRKzw2OD46yavMDgdBz/Q9QZ4LvfSoknG8qa1AHgosgHL
	J151ai/14cxvjJrBZf4BurzN4/BHuuhsr+j0W4l9y6lX6QzDGhq9iS8m7vS1/DChaKa6wcTZadnxB
	cqePH1rPr7Kt1AA1WIylx1nwx7e+GwCg/I1ofGYOgwXPZM9Ixw==;
Received: from bl16-24-61.dsl.telepac.pt ([188.81.24.61] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xPH06-004J48-Pq; Fri, 06 Nov 2026 11:16:50 +0100
Date: Fri, 6 Nov 2026 10:18:27 +0000
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mszeredi@redhat.com, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH] fuse: fix 'inval_wq' parameter setting during module
 initialisation
Message-ID: <au2pczAGgWeloIkw@igalia.com>
References: <20261019125329.17932-1-luis@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019125329.17932-1-luis@igalia.com>

On Mon, Oct 19, 2026 at 01:53:29PM +0100, Luis Henriques wrote:
> If the fuse module is loaded with a 'inval_wq' parameter the inval_wq_set()
> function will schedule work into dentry_tree_work.  However this worker is
> not initialised at this point because fuse_dentry_tree_init() will not have
> been executed yet.
> 
> This can be fixed by delaying the work scheduling until later if the module
> is still being initialised.
> 
> While there, also simplify the sched/cancel by using mod_delayed_work()
> instead of schedule_delayed_work().  This will result in having the period
> being changed immediately instead of waiting for the next reschedule.
> 
> Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Hi!
> 
> My initial approach to fix this was to use DECLARE_DELAYED_WORK() to
> initialise the wq statically.  But this would then move the problem to
> fuse_dentry_tree_work(), as the worker could still be scheduled before
> the module finishes initialisation.

Ping.

Any comments, or suggestion on a better way to fix this problem?

Cheers,
-- 
Luis

>  fs/fuse/dir.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index e49b4e874b15..23c8259725c9 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -43,7 +43,6 @@ unsigned __read_mostly inval_wq;
>  static int inval_wq_set(const char *val, const struct kernel_param *kp)
>  {
>  	unsigned int num;
> -	unsigned int old = inval_wq;
>  	int ret;
>  
>  	if (!val)
> @@ -62,11 +61,14 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
>  
>  	*((unsigned int *)kp->arg) = num;
>  
> -	if (num && !old)
> -		schedule_delayed_work(&dentry_tree_work,
> -				      secs_to_jiffies(num));
> -	else if (!num && old)
> -		cancel_delayed_work_sync(&dentry_tree_work);
> +	/* Only start/stop workqueue if we're past module initialisation */
> +	if (!module_is_coming(kp->mod)) {
> +		if (num)
> +			mod_delayed_work(system_percpu_wq, &dentry_tree_work,
> +					 secs_to_jiffies(num));
> +		else
> +			cancel_delayed_work_sync(&dentry_tree_work);
> +	}
>  
>  	return 0;
>  }
> @@ -224,6 +226,14 @@ void fuse_dentry_tree_init(void)
>  		dentry_hash[i].tree = RB_ROOT;
>  	}
>  	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
> +
> +	/*
> +	 * Start workqueue immediately if the module was loaded with the
> +	 * 'inval_wq' parameter set
> +	 */
> +	if (inval_wq)
> +		schedule_delayed_work(&dentry_tree_work,
> +				      secs_to_jiffies(inval_wq));
>  }
>  
>  void fuse_dentry_tree_cleanup(void)
