Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B33C09FE;
	Thu, 10 Sep 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030016; cv=none; b=rEnw+AplRdSB7zL+B5wxw+UAjQnr6OFEiXqEqxSF8MEenG0BQlg2v4/vuIRVcIlEAdXuyfIZu5jI+fe6Gr0bJOAo9sGGGkPabA98Gguhl/IpRhnVea7nllBB2Y9dn1sjwvRtGpa5frf/tP/1QBWC3Cadi3VR9imSFN1B57tZs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030016; c=relaxed/simple;
	bh=ynSUx5O0vGrtBcIzhCFEUSn6SYgdZ8c7Coka6IHOtz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpamKgYWo1gJyydb+W+6/hZjtszRfKNwjEK6KspQG3Oyxc5MQ6ioDlKivipYnlBcEXtxEmKbOBoX/FBqTH67Tr2C7bNQ3wPVyQ8qiGAKexa7IfoPbf8BY26DdOy4EGq+n4eN3XfPT5WT3FknF7U9E+68DH0rASj2oi6P3lE58YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OPeZe2mB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUoJCIsW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TlFhXNxv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSMWN7e7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OPeZe2mB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUoJCIsW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TlFhXNxv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSMWN7e7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C1EE1FD87;
	Thu, 10 Sep 2026 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789030003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKFZgmV1DYh46za7nm6vYesF12VXdFrdx++kuKz7oSA=;
	b=OPeZe2mBCNSZG9faUGgW76QSzjbES5lqawHvTyLRKgx3eWE3s/Z+w5p57o6nswvvEI4xPf
	L1EqrGy8H7Ze4u0VMdtCOpD/O/YtiKx59L7biyAJuQJSrh9l30pjIoxPDNxTdDGT+mby2q
	N5dEbPyBHlKHVY5QEJM/0+xOR5PVF7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789030003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKFZgmV1DYh46za7nm6vYesF12VXdFrdx++kuKz7oSA=;
	b=oUoJCIsW/C800JcyNgaMTmZug869+ht/UC+RrRtfbMMXoo7o5RLWZnkyfm6P+4vB7BMSl1
	SMYzAmlb2pqh6nDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789029999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKFZgmV1DYh46za7nm6vYesF12VXdFrdx++kuKz7oSA=;
	b=TlFhXNxvk2ouWz3CBQCsAZH9hYkYbMu+7YKoQ68PEOkHWkgFLC1S9RcvzR010Rfk3zWdmE
	yUNSFotVPVC5LB6SpwtKPCct11BzLGnqH75n97I0Fer0vPb+kWkJC0tL7CkX9dzVdUKdJ/
	HqlPiLyHnjTfvG1gyiik3JkxPfuoURY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789029999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKFZgmV1DYh46za7nm6vYesF12VXdFrdx++kuKz7oSA=;
	b=iSMWN7e7+A/nJcB8ZGPd4+BYJR/w3drhvcON0l19ExQzzERsUwhnoRqgy2f04mkxMeWctS
	Hm0NKo3qHVp/9PCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60A2A137FD;
	Thu, 10 Sep 2026 08:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rZORF29uomolZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Sep 2026 08:46:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0D9EA12EA; Thu, 10 Sep 2026 10:46:30 +0200 (CEST)
Date: Thu, 10 Sep 2026 10:46:30 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Dennis Zhou <dennis@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Message-ID: <q6euw7q6hdfdzhadrwyc47j2lbev6kutm3vix7fi5v7aset2hq@kbv4uy55whd6>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email,suse.cz:email,suse.com:email]

On Wed 09-09-26 18:01:07, Josef Bacik wrote:
> cleanup_offline_cgwbs_workfn() drains a dying cgwb by calling
> cleanup_offline_cgwb() until it returns false, with a cond_resched()
> between passes.  On a CONFIG_PREEMPTION kernel that cond_resched() does
> nothing: _cond_resched() is a plain "return 0", and under
> PREEMPT_DYNAMIC the full and lazy modes disable it.  Since commit
> 7dadeaa6e851 ("sched: Further restrict the preemption modes") those are
> the only two models on the architectures with PREEMPT_LAZY support,
> arm64 and x86 among them, so the drain loop never reports a Tasks-RCU
> quiescent state.
> 
> A worker draining a cgwb with millions of attached inodes runs for
> minutes.  On a 6.18 arm64 host in lazy mode the cgwb worker drained one
> dying cgroup's writeback domain for over 11 minutes.  A BPF program
> unlink (bpf_trampoline_unlink_prog -> bpf_trampoline_update ->
> unregister_ftrace_direct -> ftrace_shutdown -> synchronize_rcu_tasks())
> waited on that grace period while holding the trampoline mutex, 42
> tasks queued behind it in D state, and the hung task detector fired at
> 614 s and panicked the host.  Any BPF or ftrace detach during a long
> drain inherits the drain's length.
> 
> Fix this by calling cond_resched_tasks_rcu_qs() so we do not stall out
> anybody who calls sycnrhonize_rcu_tasks().  We put this in a do { } while
> loop because if we have many small cgroups cleanup_offline_cgwb() will
> return false and we will never call cond_resched_tasks_rcu_qs(), creating
> the same problem.
> 
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

And I fully agree about the fragility. It looks as an oversight that
cond_resched() doesn't imply RCU quiescent period after the recent
preemption overhaul.

								Honza

> ---
>  mm/backing-dev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index cecbcf9060a6..18e999053bae 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -910,8 +910,9 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
>  			continue;
>  
>  		spin_unlock_irq(&cgwb_lock);
> -		while (cleanup_offline_cgwb(wb))
> -			cond_resched();
> +		do {
> +			cond_resched_tasks_rcu_qs();
> +		} while (cleanup_offline_cgwb(wb));
>  		spin_lock_irq(&cgwb_lock);
>  
>  		wb_put(wb);
> 
> ---
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> change-id: 20260909-cgwb-tasks-rcu-qs-42341609f3e1
> 
> Best regards,
> --  
> Josef Bacik <josef@toxicpanda.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
