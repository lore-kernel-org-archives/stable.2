Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018163346BE
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373028; cv=none; b=fnhuWOGsq7SSBIU4BoA32TFdd7nPzzHVBPNYpvOCum5FzETfO0vvP95mIbaW1/MxwAKhYjJtARGWIyZ4JAXKCMv0YuAyiBU98q9pdX7dlJwklZkLDjWgexpJ/1zG5//dSGkkHubCxcQ/MKXVfeXPAWA3tlMLXgi30ItiX+we2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373028; c=relaxed/simple;
	bh=7L3O1feyJD5pOVoRPkZGuwoiYEelArAZNb+zuMIgWmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5TTYGsRCW7xBEp6n50ZoCNzcdKygAAwWISIR9p/RPwii7MFDmX1nAHjIH+rivzHXOSBNQ1atnPmaguPT5D+HGXPfZK/2/RBh7rmQE2/YvQz8ZNui3nja1BKKd0LTDoCDfiH/5fGvbbTWHLWnzUxZXnjGtY+FTeK9tkpjG02XGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QsQknE2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1bbqHuar; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AOCAqeV3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtajtCqB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QsQknE2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1bbqHuar";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AOCAqeV3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtajtCqB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 200BD21D73;
	Mon, 14 Sep 2026 08:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789373011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq+nWrnQS4dizhiKfo1/YZ6LijxjTogwkXIGHryHvOY=;
	b=QsQknE2V8OG3fo1bGRvvpbHnx5uBJDR6D4FSyURfO9vT9GS1fWRiybehHVgCg6Z++Mq3OA
	YsCShBm3+jiSjhLziaip0OC56mmC4145DtrvmrF2T/A/YNllKJalwHGkLXCAC5TDqpRg2n
	ne6LVEGZerjCKwLRxa3I+mIGIeZ8M3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789373011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq+nWrnQS4dizhiKfo1/YZ6LijxjTogwkXIGHryHvOY=;
	b=1bbqHuarqjIGjJPDcWzLiHsAeKPkaHnY7Dngmzv8VyMoVhnf0+TjMUm1Gt+5W0GQH2qr2I
	C1OGu5n1HUga4HDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AOCAqeV3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dtajtCqB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789373007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq+nWrnQS4dizhiKfo1/YZ6LijxjTogwkXIGHryHvOY=;
	b=AOCAqeV3jaYwkGB4NrKNdY02opUuEN4sVaHbIVoYMjnHXCED062RipooTI457LYiAsKUID
	QMxS/zAJXsV2Wch/qGe1naUBiZEDL29KxIpRG+Eyn7NIzT7cph6GUy1Pva1+jf9oWQ9KvS
	paaCE+OQ88yylAcMv+YiddsQWvz39rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789373007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq+nWrnQS4dizhiKfo1/YZ6LijxjTogwkXIGHryHvOY=;
	b=dtajtCqBEWnl6u3vAnkFpZ19dXVybupPizBJkKcNWnxnou6nvgIN3QckfMtJXus3CTtR/s
	uTSX8rxvdDTadHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E673A13515;
	Mon, 14 Sep 2026 08:03:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Abk4OE6qp2r7eAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:03:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F0DFA0B5A; Mon, 14 Sep 2026 10:03:18 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:03:18 +0200
From: Jan Kara <jack@suse.cz>
To: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] writeback: bound cleanup_offline_cgwb() rescans by
 rotating scanned inodes
Message-ID: <xt43htg7oizkvnplkv7cpd4misrjraxvwcmnasjkw3gwlnx2ol@z47ricmauujf>
References: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 200BD21D73
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,msgid.link:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email,suse.com:email]
X-Spam-Flag: NO

On Fri 11-09-26 18:49:49, Patrick Lu (Anthropic) wrote:
> cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
> per call and is called again until the dying wb is drained, but every
> call walks wb->b_attached and then wb->b_dirty_time from the same end.
> Inodes already prepared (they stay on the list with I_WB_SWITCH set
> until the switch worker runs) and inodes that cannot be switched
> (I_FREEING, I_WILL_FREE, !SB_ACTIVE, DAX, already on the target wb)
> stay where they are, so each pass rescans a growing run of them under
> wb->list_lock and a full drain is quadratic in the number of inodes on
> the list. With ~17M inodes attached to one dying cgwb we saw this end
> in soft lockups, with CPUs reported stuck for 21-48s.
> 
> Walk both lists from the oldest end and move every scanned inode to
> the newest end, so the next pass starts where the previous one stopped
> and the drain becomes linear. b_attached is unordered, so nobody sees
> the reorder there. b_dirty_time is ordered by dirtied_when, but the
> oldest unscanned inode stays at the end move_expired_inodes() picks
> from, sync takes the whole list regardless of order, and prepared
> inodes leave the list as soon as the switch work runs and get a new
> dirtied_time_when on the new wb anyway, so the only inodes left out of
> order are the ones that can never switch (DAX), and only on the dying
> wb.
> 
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Assisted-by: LLM
> Signed-off-by: Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>

Looks good to me now. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Seen in production on a 6.18-based kernel: with ~17M inodes attached
> to one dying cgwb, a node spent 36 minutes in back-to-back
> wb->list_lock holds by the cleanup scanner (~6ms each, ~46% of wall
> time, starving writeback on that wb); with v1 of this patch the same
> workload drains in ~30 seconds. Also seen on stock Amazon Linux 2023
> 6.12.68 as isw workers spinning on the list_lock in
> inode_switch_wbs_work_fn() while cleanup_offline_cgwbs_workfn() runs.
> 
> Tested v2 with a QEMU A/B at 100k inodes on b_attached and 100k
> lazytime inodes on b_dirty_time: the per-pass scan under list_lock is
> flat on both lists where unpatched (and v1 on b_dirty_time) grows
> across the drain, all inodes switch, and on-disk timestamps match after
> sync. v1 was also run patched vs unpatched on production-class hardware
> at ~17M attached inodes.
> 
> Josef Bacik's patch making the drain loop report a Tasks-RCU quiescent
> state [1] fixes BPF/ftrace detach stalls behind the same drain; this
> patch bounds the walk itself. The two are independent.
> 
> [1] https://lore.kernel.org/linux-mm/20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com/
> ---
> Changes in v2:
> - Rotate b_dirty_time as well, walking both lists from the oldest end
>   so the expiry still sees the oldest unscanned inode first (Jan)
> - Drop the unrelated comment updates
> - Kept acks from Tejun and Roman since the b_attached side did not
>   change
> - Link to v1: https://patch.msgid.link/20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com
> ---
>  fs/fs-writeback.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e744f9f9d43f..ea3eb40bf828 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -727,19 +727,34 @@ static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
>  				   struct inode_switch_wbs_context *isw,
>  				   struct list_head *list, int *nr)
>  {
> -	struct inode *inode;
> +	struct inode *inode, *tmp;
> +	LIST_HEAD(scanned);
> +	bool full = false;
> +
> +	/*
> +	 * Walk from the oldest end and move scanned inodes to the newest
> +	 * end, so the next scan resumes at unscanned inodes instead of
> +	 * re-walking an ever-growing run of prepared and skipped ones.
> +	 * For b_dirty_time this keeps the oldest unscanned inode at the
> +	 * end move_expired_inodes() picks from; b_attached is unordered.
> +	 */
> +	list_for_each_entry_safe_reverse(inode, tmp, list, i_io_list) {
> +		list_move(&inode->i_io_list, &scanned);
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
> +	list_splice(&scanned, list);
> +
> +	return full;
>  }
>  
>  /**
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
