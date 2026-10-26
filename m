Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012005;
	b=XbtE82zOJ+e34Zj2AabvfYm591SV8epKLTXJfVAtEc6vXVPD1uJrkNxbLR5nFc/IgneN
	 R/IF+ZDq+kJCMrND7evT7fA2B7IJRUaKFM4BBVANZHThBbLpMEBYIpNMRtLPJmwruYN2g
	 /ZO6DbOm7HiZsHYi4FinTvgc+Dc4Z9Lfng99bnSqmwcQU+Jqun52GaDir5k1BEP+6o1zy
	 JmI03+7ah3WfcnviMs3cx1MYY4ZnVjsWVf1+zReht2Qwy+/fAZJVcTz2sUbM+N0oZAb4C
	 8Muus0O3hrrF1uuhOpco8709WbqOdb0Pmhei3rqQm1rTn81AJF7vjUpOGgkXxPt//6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012005;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=k1RCdtni69C+1UVdBc+qzFQLzm/+KaRJzjIw3dpE2tY=;
	b=xr+/q/EKaHX8n3gYUiEq8B0qBzkXl06HRZzeJ+r5xg1K5oSfTy+VR/tN1RcBj3okulQA
	 92u+LeL/IuQd/8lM+K8VaJ1HCqlma/75EsO8J6NTut1DlPRvM1s6PMFiBNuL79znFt8hW
	 U4/ceBAn1KLTJdIFM8ynQQUlx96jr6HF87KxLTdSUKfpVQgBfufRqY6BoONFNXdlYzpDQ
	 RQ90Mw1RBuQfVsAH4KCbjCs3gvdt+pbLdMxFQemjY6aMLQz5GwK5/kR0+/OOqXG58G2ay
	 tfSfpSXMFYSOFLkk/DceD8cU21IOvoYNpM3Se296lDhrlLSOR2jDQIXnlEoik6TQeFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ed400UsX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUucHde+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xocIytMU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=R0i6ft9d;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40042606A31A;
	Mon, 26 Oct 2026 10:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40042606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ed400UsX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUucHde+;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xocIytMU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=R0i6ft9d
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F209F1F7A2;
	Mon, 26 Oct 2026 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793012002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1RCdtni69C+1UVdBc+qzFQLzm/+KaRJzjIw3dpE2tY=;
	b=ed400UsXAso6BW/wyEwJvJapoCoBHUou2hngO1gewoN3xPEXQBFrmiDVkL5L9vV0hNdJO4
	zeXA3NNR3k2aIgAiO2LZ4X8dgNzLEjgl8WTdN0n2U+C3Tj1fMTkp8RoqBkF6Y1XUKYr1WK
	3d1qE4nXnV/hHS4JnYJHBVx+1MiFZXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793012002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1RCdtni69C+1UVdBc+qzFQLzm/+KaRJzjIw3dpE2tY=;
	b=tUucHde+OA6NCb1T6GlA879m8xaqWIEj/4+VfyPKchB/+zoYdBTlyeexGxuWt9ogJEG2B+
	N956QSRYNZyJ+FDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793012001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1RCdtni69C+1UVdBc+qzFQLzm/+KaRJzjIw3dpE2tY=;
	b=xocIytMU6LwOXdZ5xAK0bkBCMoUz3UzVF0YWS9/4b6maSmG0c0LPItFSD0Wn9D3oDfad54
	tRjiVhPPqZV/BHYdddy8x783SR3E0d6WM3s1SHC+VpcyA91fMHhHciYMWRExrSsI/RyOHG
	tyuybgitcFAM2Pd6MGBhFL1Pdbyo9gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793012001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1RCdtni69C+1UVdBc+qzFQLzm/+KaRJzjIw3dpE2tY=;
	b=R0i6ft9dQL6XEhF6tpyEHkZcy6UN5r5YkOJP7d9NHmq8nzpuUXu311xWts6ehAGuN8XnXJ
	0geX/Ic2Me0chfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C777B13319;
	Mon, 26 Oct 2026 10:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ehm0KCAx32q/UAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 10:53:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4DD5DA1419; Mon, 26 Oct 2026 11:53:20 +0100 (CET)
Date: Mon, 26 Oct 2026 11:53:20 +0100
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
Subject: Re: [PATCH 02/16] tmpfs: keep the quota soft limits of an unused id
Message-ID: <xre5aqctyk464ao7gdrg4fzbamccmo2w5jnqxzultltfhm43gm@xtab77j3yetz>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-2-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-2-703206d5fa0c@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLazpmpqd3yhbh47n4yz1pekr6)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gourry.net,nvidia.com,gmail.com,sk.com,linux.alibaba.com,cmpxchg.org,suse.com,google.com,redhat.com,kernel.org,suse.cz,chromium.org,linux.dev,suse.de,infradead.org,oracle.com,tencent.com,huawei.com,kvack.org,vger.kernel.org,toxicpanda.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -11.30

On Mon 26-10-26 10:40:35, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When the last reference to a dquot goes away, shmem_release_dquot()
> stores its limits in the rb tree of the mount, unless
> shmem_is_empty_dquot() says that there is nothing worth storing. That
> function looks at the usage and at the two hard limits only.
> 
> So if the administrator sets nothing but soft limits for an id that owns
> no file yet, the entry is thrown away as soon as the dquot that
> Q_SETQUOTA used is released, and the id never gets to see a limit.
> 
> To fix it, compare the soft limits as well: an entry can be empty only if
> both soft limits are zero as well, which is exactly what
> shmem_acquire_dquot() sets for a new entry.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: de4c0e7ca8b5 ("shmem: Add default quota limit mount options")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: slightly adjusted description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Good spotting although I consider this pretty minor (unlikely setup proven
by the fact nobody complained so far). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem_quota.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index a3fa4bd93e753..43d3b4fd6cb1b 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -256,6 +256,8 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
>  	if (test_bit(DQ_FAKE_B, &dquot->dq_flags) ||
>  		(dquot->dq_dqb.dqb_curspace == 0 &&
>  		 dquot->dq_dqb.dqb_curinodes == 0 &&
> +		 dquot->dq_dqb.dqb_bsoftlimit == 0 &&
> +		 dquot->dq_dqb.dqb_isoftlimit == 0 &&
>  		 dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
>  		 dquot->dq_dqb.dqb_ihardlimit == ihardlimit))
>  		return true;
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
