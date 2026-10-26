Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022593;
	b=Lg/3TVkhtr5Ws2Jge3ZP1Lav9R4of6/7ocWBb8RM53463XEVwIYN/UQu+LF5tIpscUS2
	 BE7HTDdQZoTOPa7AvKGOm0Q+uJcksX7XtEWgauqcRED2oF4TSC0qIfbFVKpYn53Ny/Bvn
	 JaIrGtv5x49mYmhCoK5LGgzN5+DveBCchi/6yATipLduOuFt0x3Yul9EOmbwAhYbhMLdO
	 rIS+zwGnULUF2PslEHOvlPwwqaP2tIcM8OpNq0wK38hKchUaZehF1fKrG3E8yJKps2Mui
	 3qo0FIxpT4DrAGIXv23mbpXLwS+EzqQ1FF8PNSQfm8tiMF/4gUYeIjIqllkqgN+J+VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022593;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=gw+DWrBcThdkD94LPR2Xt2VdzoiGn+S55/InX1ltsOA=;
	b=RvicEWYM1NDr5ZhzuhltWQJDsYL98kdAfPQkgz8slYxis351AWVwGDibtjOHxoZqfGeE
	 oIOfFTsMa4fAwIzQrEb2lOouOa0HnJ7NhBzFCMvmjQnFHPs8HLF6PaRFTIeu02LzEiWrq
	 /rt6iND3kA6xEpYL8qn/1S3zuiR4K3+/Yu8nRT/3d+PFHEdmEDjyi2mKG1zwEbYOf16DR
	 tbCcP/fs+AZcoDM+5aljPTzRH5j0NXWefmcfCTA4RPvO8xFv7m4QjMvR21iZVOu2SjUZA
	 pXtl3oCr9jT9W7a7w0OsuMufg9q0TD2bu3k9OUvuscdbmhwXhWq1Z4oNhN63vhTBu9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bDDhCwYq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4i+RWwt2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bDDhCwYq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4i+RWwt2;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5B606A31A;
	Mon, 26 Oct 2026 13:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bDDhCwYq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4i+RWwt2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bDDhCwYq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4i+RWwt2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 703A61F7F1;
	Mon, 26 Oct 2026 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793022590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+DWrBcThdkD94LPR2Xt2VdzoiGn+S55/InX1ltsOA=;
	b=bDDhCwYqko4Spqtn/GFssUjt3KhO6TLY0yoGN3uHLvrc10lcc/Rk3KBcvnyXc1lGnmF0zo
	zDg1TSaOVRSSbo5n9O79NLsNzqbOJzWwuQSDeBEEweJwcmQus0uBSq0Lto6pPrTUXqt16p
	3+UUpVcliemrFSyjci68XAtAkpCFH60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793022590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+DWrBcThdkD94LPR2Xt2VdzoiGn+S55/InX1ltsOA=;
	b=4i+RWwt2clyt3QcGQr+qFHHmtwtaBmXorY1fQMFlNGoQLuHIJL/ippU5nn279+kzZHUy8H
	hDe06thWEnOBUrAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793022590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+DWrBcThdkD94LPR2Xt2VdzoiGn+S55/InX1ltsOA=;
	b=bDDhCwYqko4Spqtn/GFssUjt3KhO6TLY0yoGN3uHLvrc10lcc/Rk3KBcvnyXc1lGnmF0zo
	zDg1TSaOVRSSbo5n9O79NLsNzqbOJzWwuQSDeBEEweJwcmQus0uBSq0Lto6pPrTUXqt16p
	3+UUpVcliemrFSyjci68XAtAkpCFH60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793022590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+DWrBcThdkD94LPR2Xt2VdzoiGn+S55/InX1ltsOA=;
	b=4i+RWwt2clyt3QcGQr+qFHHmtwtaBmXorY1fQMFlNGoQLuHIJL/ippU5nn279+kzZHUy8H
	hDe06thWEnOBUrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5F7C13408;
	Mon, 26 Oct 2026 13:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vtLFI3ta32qIDgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 13:49:47 +0000
Date: Mon, 26 Oct 2026 13:49:46 +0000
From: Pedro Falcato <pfalcato@suse.de>
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
	linux-kernel@vger.kernel.org, Eva Kurchatova <eva.kurchatova@virtuozzo.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 05/16] hugetlbfs: enforce F_SEAL_EXEC in setattr
Message-ID: <at9aZtyyhrilX9iL@pedro-suse.tail5790ac.ts.net>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLdb7soike877yjz3fjz6asqba)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gourry.net,nvidia.com,gmail.com,sk.com,linux.alibaba.com,cmpxchg.org,suse.com,google.com,redhat.com,kernel.org,suse.cz,chromium.org,linux.dev,suse.de,infradead.org,oracle.com,tencent.com,huawei.com,kvack.org,vger.kernel.org,virtuozzo.com];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

On Mon, Oct 26, 2026 at 10:40:38AM +0100, David Hildenbrand (Arm) wrote:
> From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> 
> F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
> not check it. As a result, fchmod() can change the execute bits of a
> sealed hugetlbfs memfd.
> 
> Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
> to execute bits when F_SEAL_EXEC is set.
> 
> This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
> fchmod() incorrectly succeeded after applying F_SEAL_EXEC.
> 
> LLM assistance was used to reuse the helper and revise the description.
> 
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
> [ david: use common helper; fixup Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Similarly:

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
