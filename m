Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021860;
	b=fseMYdWPmLL4vsB4hN15bXLbzLAAS1EDJ4oy0ArVSDH/WmXqi8OlouSDAKxZRJFHudgm
	 I/kxr9/7bAHRzJiOM3CQTau9VnWKl8pkkxadGbAhUFvhPpkc+yf6uMWdjW1pN5GSQAoma
	 2JorMMay8ZXUBBxo1sbXNyfg5hLhPB4ZbhUsXfBMvOLDVJ9f3nBeL/94fMuTAkI2NHd8I
	 4BBDimxI+YZxjdboauiLOzwOrcXsB22vwnbOkPU0InyDrWnehTi/HjBkZF3WDoL8VsAV+
	 dMOez5dDuqJbD3hi69vgCUr/VUks89Q7r/izckEBkR9KvsObOpJyr7mX1p4h+0k6EBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021860;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=TxJaVovbBuzNcz8Fy84RB6HU15y4oYzEhr8Gynqfeyo=;
	b=ztDOds+scrHtRBiYEwQDuqE54Tt8vmes2SR0ExPI22UBPQ2+eskAGAvEjvqG+FgqXd9c
	 K37Y/iGdsYSLYGKq2FOrV4kaNZV60IvB6Ch9JKQhpQVMJNg7JGSrHBBHt2L3uiQE59uFA
	 zLJQ2i4cCcXenkpSC4WqZxzrjzofJyI3HQlv4jgkrAUNS8Zgibj/djNgNLhvlt1MlkMO0
	 Lj+ymcj9VeF6bOeN+cnTKCBTNAogdTlb87xSh/mVZY6sFOq9gtZaLA0mEaSB4wwpy0qC5
	 LDKmKd5u7Rrh5beolvSHE9DNOuox/AJVh/FojDKucNGWAzPGiS8DNP573DIRGL6RULw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MN6mgPWu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=05B7c4jh;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MN6mgPWu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=05B7c4jh;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001760A6F4B;
	Mon, 26 Oct 2026 13:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F001760A6F4B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MN6mgPWu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=05B7c4jh;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MN6mgPWu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=05B7c4jh
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1CE51F43B;
	Mon, 26 Oct 2026 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793021858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxJaVovbBuzNcz8Fy84RB6HU15y4oYzEhr8Gynqfeyo=;
	b=MN6mgPWuP1dMIU3f6uNvt8/Zwy+Ji5bunevTMshqSLbx/zh7eOuT5DUVnLPIA5R8lA96xG
	obX9p/vOG6s2PCw2eLLOS/m91dwZCMm/coZmYjeUFVtlFNuYP0NpKdMocUAQ0cZuuepKxF
	/WUC6xGuccVuIWM+eBYLAzrnsWfDaNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793021858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxJaVovbBuzNcz8Fy84RB6HU15y4oYzEhr8Gynqfeyo=;
	b=05B7c4jhEIx+f0zNUnBKAC8V0BIWFbQHS1oOY3GwthoQn9LNvy9JCMPjHuZKtN16WgIctE
	3h0TmcLgdHqKQwBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MN6mgPWu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=05B7c4jh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793021858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxJaVovbBuzNcz8Fy84RB6HU15y4oYzEhr8Gynqfeyo=;
	b=MN6mgPWuP1dMIU3f6uNvt8/Zwy+Ji5bunevTMshqSLbx/zh7eOuT5DUVnLPIA5R8lA96xG
	obX9p/vOG6s2PCw2eLLOS/m91dwZCMm/coZmYjeUFVtlFNuYP0NpKdMocUAQ0cZuuepKxF
	/WUC6xGuccVuIWM+eBYLAzrnsWfDaNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793021858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxJaVovbBuzNcz8Fy84RB6HU15y4oYzEhr8Gynqfeyo=;
	b=05B7c4jhEIx+f0zNUnBKAC8V0BIWFbQHS1oOY3GwthoQn9LNvy9JCMPjHuZKtN16WgIctE
	3h0TmcLgdHqKQwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C196C13408;
	Mon, 26 Oct 2026 13:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWmlJqFX32rQfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 13:37:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E306A1419; Mon, 26 Oct 2026 14:37:33 +0100 (CET)
Date: Mon, 26 Oct 2026 14:37:33 +0100
From: Jan Kara <jack@suse.cz>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 03/16] tmpfs: preserve explicitly disabled quota limits
Message-ID: <ohklmfrgb2zpi3xm5nmlqmtum2wwoo33zd6cyjy7vq2t5r5rbl@qdhtgbfr67yt>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-3-703206d5fa0c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-fixes_shmem-v1-3-703206d5fa0c@kernel.org>
X-Rspamd-Queue-Id: F1CE51F43B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[32];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[suse.com:email,toxicpanda.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,gourry.net,nvidia.com,gmail.com,sk.com,linux.alibaba.com,cmpxchg.org,suse.com,google.com,redhat.com,kernel.org,suse.cz,chromium.org,linux.dev,suse.de,infradead.org,oracle.com,tencent.com,huawei.com,kvack.org,vger.kernel.org,toxicpanda.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLrfp3ibjutskb9r7un874bfh3)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.51

On Mon 26-10-26 10:40:36, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> An administrator’s decision to disable a user’s or group’s quota
> limits can be silently lost when tmpfs restores the mount defaults
> after releasing and reacquiring the quota record. This can cause
> later file creation or writes to fail with EDQUOT, even though the
> administrator has explicitly disabled quota limits for the user or
> group.
> 
> do_set_dqblk() sets DQ_FAKE_B when all block and inode limits are zero.
> This means quota enforcement is disabled for that user or group.
> shmem_is_empty_dquot() treats the flag as a reason to discard the entry
> from the mount's quota tree. The next shmem_acquire_dquot() finds no
> saved entry and recreates it with the mount's default hard limits.
> 
> If the cached dquot is reused, DQ_FAKE_B remains set: Q_GETQUOTA reports
> the restored defaults, but enforcement is still disabled. Once that
> dquot has been reclaimed, a new dquot enforces the restored defaults.
> 
> Remove the DQ_FAKE_B test. Only discard entries with zero usage, zero
> soft limits and hard limits equal to the mount defaults. Explicitly
> disabled limits are then preserved whenever the mount defaults are
> nonzero.
> 
> Explicitly disabled limits now retain a quota-tree entry, just like other
> limits that differ from the mount defaults.
> 
> Rename shmem_is_empty_dquot() to shmem_is_default_dquot() to describe
> the check for default values.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: de4c0e7ca8b5 ("shmem: Add default quota limit mount options")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: code cleanups; rewrite description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem_quota.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index 43d3b4fd6cb1b..d191ebda3f00e 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -239,7 +239,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
>  	return ret;
>  }
>  
> -static bool shmem_is_empty_dquot(struct dquot *dquot)
> +static bool shmem_is_default_dquot(struct dquot *dquot)
>  {
>  	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
>  	qsize_t bhardlimit;
> @@ -253,21 +253,21 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
>  		ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
>  	}
>  
> -	if (test_bit(DQ_FAKE_B, &dquot->dq_flags) ||
> -		(dquot->dq_dqb.dqb_curspace == 0 &&
> -		 dquot->dq_dqb.dqb_curinodes == 0 &&
> -		 dquot->dq_dqb.dqb_bsoftlimit == 0 &&
> -		 dquot->dq_dqb.dqb_isoftlimit == 0 &&
> -		 dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
> -		 dquot->dq_dqb.dqb_ihardlimit == ihardlimit))
> -		return true;
> -
> -	return false;
> +	/*
> +	 * Defaults are zero usage and soft limits, and the mount's hard limits.
> +	 * DQ_FAKE_B only means that *all* limits are zero, which need not match
> +	 * the mount defaults.
> +	 */
> +	return dquot->dq_dqb.dqb_curspace == 0 &&
> +	       dquot->dq_dqb.dqb_curinodes == 0 &&
> +	       dquot->dq_dqb.dqb_bsoftlimit == 0 &&
> +	       dquot->dq_dqb.dqb_isoftlimit == 0 &&
> +	       dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
> +	       dquot->dq_dqb.dqb_ihardlimit == ihardlimit;
>  }
>  /*
> - * Store limits from dquot in the tree unless it's fake. If it is fake
> - * remove the id from the tree since there is no useful information in
> - * there.
> + * Remove the ID from the tree if it has no usage and its limits match
> + * the mount defaults. Otherwise, save its limits for the next acquire.
>   */
>  static int shmem_release_dquot(struct dquot *dquot)
>  {
> @@ -302,7 +302,7 @@ static int shmem_release_dquot(struct dquot *dquot)
>  	return -ENOENT;
>  
>  found:
> -	if (shmem_is_empty_dquot(dquot)) {
> +	if (shmem_is_default_dquot(dquot)) {
>  		/* Remove entry from the tree */
>  		rb_erase(&entry->node, info->dqi_priv);
>  		kfree(entry);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
