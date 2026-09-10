Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229CA3EB11E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039517; cv=none; b=NaQAnIRHPE53P9+I4Rm4ROABqMEZCu39sG0oLCLH/F/dbD8BlkuQ/Sne+AIBxA3jA9BTO1g/ZzDdnWIbF43iwo0c4EXxU3wU6+gc5kekXyYopGlN1RxRKE7DhWcbw7QPPJeytHBVKjk5oobJm1DkKDxYwKUafu7Nvs0qDrkjd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039517; c=relaxed/simple;
	bh=Ok2rWjqDwyoQUWviMsDqNihKaJmVy/EFBU5yzCIP6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huchx9ILhETmCkr78dpPFcws2FrS6BvbFPuEv2nqtfJB2xFBT9aT1FiEWTmL6ggIHVqYH5sgIrp1nA5AHTLXAedElnkop2747qlmZTsYnehO8ubYwAjzbaI3k84rD90byxjB6N662jmr2JJeN7eWVBrudJFxjNIsiQ08tv6w21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t5j8XbhQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQ0rH2MX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sWm6MCGI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uims9Jbt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t5j8XbhQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQ0rH2MX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sWm6MCGI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uims9Jbt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 808E621C15;
	Thu, 10 Sep 2026 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789039501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPN1BA8/VlwYKG9BYv9LeApz8G2/avpXWiTxQBOb5FI=;
	b=t5j8XbhQgEKCpoUU5ZC4JxMiQMklEuM+OHnH/ZXiSchomhMCJklPwxNLoCbM6TEdSH8Ybp
	BpXaXr+awQh9XpdyL9Xlk9T8SIffKTFuX1z54KVR6CVvIEGRylMMsyOW4xm8neF9+efrbU
	g3Y7XwhHosFlKEpAjg1LEq6aniNyUFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789039501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPN1BA8/VlwYKG9BYv9LeApz8G2/avpXWiTxQBOb5FI=;
	b=KQ0rH2MXraL/UOZwVElkZQDdJByn0AnBw6HJ5PHG8OV1MPyFWjZdiMLa3sN7QVktpCZE3W
	gQ43Lp1bDBR7+TBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789039497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPN1BA8/VlwYKG9BYv9LeApz8G2/avpXWiTxQBOb5FI=;
	b=sWm6MCGIfrlDqlHXV8pzBeLbiAeYCwYicqxvkTgCAIavcFniTHvVsEK32JDjmv0t03/5NQ
	ji1RuiAV5pgKjaSA3WWd9gmmqfLnfB45gx8ZBboJ09US1RcPjsdxLJDXtgiH/0KPuhpsLX
	6rDtiJ8hrq27McEf3INF6jU9VWbDo/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789039497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPN1BA8/VlwYKG9BYv9LeApz8G2/avpXWiTxQBOb5FI=;
	b=uims9JbtpdBbtS6EqJAA5f+UCkkMipwfIKyUFZmnvnaJ6lL5zd9IwvdulumwNBKz+DItQM
	BbK3UOb/947YFHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B1581321C;
	Thu, 10 Sep 2026 11:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sNlKEomTomq3CQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Sep 2026 11:24:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1F32A12EA; Thu, 10 Sep 2026 13:24:52 +0200 (CEST)
Date: Thu, 10 Sep 2026 13:24:52 +0200
From: Jan Kara <jack@suse.cz>
To: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dennis Zhou <dennis@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] writeback: bound cleanup_offline_cgwb() rescans by
 rotating b_attached
Message-ID: <vciagp74qvys2zdbsfcr2brhbv4uyabvm67czm255ascytesjz@n6q775zxxwvb>
References: <20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Wed 09-09-26 18:50:27, Patrick Lu (Anthropic) wrote:
> cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
> per call and is called again until the dying wb is drained, but every
> call walks wb->b_attached from the head. Inodes already prepared (they
> stay on the list with I_WB_SWITCH set until the switch worker runs) and
> inodes that cannot be switched (I_FREEING, I_WILL_FREE, !SB_ACTIVE,
> DAX, already on the target wb) stay at the head, so each pass rescans a
> growing prefix under wb->list_lock and a full drain is quadratic in the
> number of attached inodes. With ~17M inodes attached to one dying cgwb
> we have seen this end in soft lockups, with CPUs reported stuck for
> 21-48s.

Hum, somehow I've missed this case when fixing slow inode switching couple
months ago. Likely because I was more focused on the b_dirty_time case back
then :) since that was what the user was hitting.

> Move every scanned inode to the tail of b_attached, so the next pass
> starts where the previous one stopped and the drain becomes linear.
> b_attached is unordered and isw_prepare_wbs_switch() is its only
> walker, so nobody else sees the reorder. b_dirty_time is ordered by
> expiry for move_expired_inodes() and keeps its current scan.

OK, but isn't there the very same quadratic behavior problem with
b_dirty_time scan which you don't touch (and where your trick cannot work)?

								Honza

> 
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>
> ---
> Seen in production on a 6.18-based kernel: with ~17M inodes attached
> to one dying cgwb, a node spent 36 minutes in back-to-back
> wb->list_lock holds by the cleanup scanner (~6ms each, ~46% of wall
> time, starving writeback on that wb); with this patch the same workload
> drains in ~30 seconds. Also seen on stock Amazon Linux 2023 6.12.68 as
> isw workers spinning on the list_lock in inode_switch_wbs_work_fn()
> while cleanup_offline_cgwbs_workfn() runs.
> 
> Tested with a QEMU A/B setup at 100k attached inodes and patched vs
> unpatched on production-class hardware at ~17M attached inodes.
> 
> Josef Bacik's patch making the drain loop report a Tasks-RCU quiescent
> state [1] fixes BPF/ftrace detach stalls behind the same drain; this
> patch bounds the walk itself. The two are independent.
> 
> [1] https://lore.kernel.org/linux-mm/20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com/
> ---
>  fs/fs-writeback.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e744f9f9d43f..69a452b12b12 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -725,21 +725,37 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  
>  static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
>  				   struct inode_switch_wbs_context *isw,
> -				   struct list_head *list, int *nr)
> +				   struct list_head *list, bool rotate, int *nr)
>  {
> -	struct inode *inode;
> +	struct inode *inode, *tmp;
> +	LIST_HEAD(scanned);
> +	bool full = false;
> +
> +	list_for_each_entry_safe(inode, tmp, list, i_io_list) {
> +		/*
> +		 * Rotate scanned inodes to the tail so the next scan resumes
> +		 * at unscanned ones instead of re-walking an ever-growing
> +		 * prefix of prepared and skipped inodes.  b_dirty_time is
> +		 * expiry-ordered and so must not be rotated.
> +		 */
> +		if (rotate)
> +			list_move_tail(&inode->i_io_list, &scanned);
>  
> -	list_for_each_entry(inode, list, i_io_list) {
>  		if (!inode_prepare_wbs_switch(inode, new_wb))
>  			continue;
>  
>  		isw->inodes[*nr] = inode;
>  		(*nr)++;
>  
> -		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
> -			return true;
> +		if (*nr >= WB_MAX_INODES_PER_ISW - 1) {
> +			full = true;
> +			break;
> +		}
>  	}
> -	return false;
> +	if (rotate)
> +		list_splice_tail(&scanned, list);
> +
> +	return full;
>  }
>  
>  /**
> @@ -747,8 +763,9 @@ static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
>   * @wb: target wb
>   *
>   * Switch all inodes attached to @wb to a nearest living ancestor's wb in order
> - * to eventually release the dying @wb.  Returns %true if not all inodes were
> - * switched and the function has to be restarted.
> + * to eventually release the dying @wb.  Returns %true if the scan stopped
> + * early after making progress; the caller should call again to continue
> + * draining.
>   */
>  bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  {
> @@ -783,13 +800,13 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  	 * bandwidth restrictions, as writeback of inode metadata is not
>  	 * accounted for.
>  	 */
> -	restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_attached, &nr);
> +	restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_attached, true, &nr);
>  	if (!restart)
>  		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
> -						 &nr);
> +						 false, &nr);
>  	spin_unlock(&wb->list_lock);
>  
> -	/* no attached inodes? bail out */
> +	/* nothing to switch? bail out */
>  	if (nr == 0) {
>  		atomic_dec(&isw_nr_in_flight);
>  		wb_put(new_wb);
> 
> ---
> base-commit: e14d4302cbd0de773960bec33c2281508c8d8855
> change-id: 20260909-wb-cgwb-rotate-f17a75facfdc
> 
> Best regards,
> --  
> Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
