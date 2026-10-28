Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194093;
	b=PO2TcocGQ4UBZGwl3kiFRwfqz3/65ps0rlMHcxXRTi3plwDB905TEMRuYt9FUhqL2Pnp
	 zT5CaF/Xt2xRz/RG8EZYsj/qYZXzN4rvDEvGmlnULAhjZ23fuPTuJRC3tEpbU6SOL/RP2
	 pCwb3PvI9EGhv+NR7k1YPo2HrjDADir76Ota32d7rrxzEBpVbvkI5W2bKqxgJZMnsi0Yk
	 F5R3qOduK0SWIMHyNXIAO7UUo1pz+Hr1AIZ5kJ0XEs0r2i0UlRMiX+0YcpmRhPirQcGU8
	 c9tNp3hK54qxePexICzvgSf8ZlNTUzuPLpTKsNwocD3OY46ApwWkvqcy/qRDc6kFSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194093;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=I1RNhY463TlUij+3G3iMbvuChAlQ+OLmz5YWd+MK6CA=;
	b=sTWss7lSIdVQT5IF6ebkiKsWX8HjUo06Jj59hhHN2nSnI/O3+W7ExDcyApveiuELqeZ4
	 ZyNN4lOStcqlLtnnfVXh1pcryH/rHy5d/uJ0tSDRCIc3VRvpzyeCLnocPmh/twRhuJNbG
	 t85B1jpyVrxiR0cNIL+8dZrrVSX/Avua4vFOj/6VrD/fLEAWIDJ3wMpMUfNgIpn1hxcDZ
	 RVRfTpOEBrNNoBnLPl3v11FMQGxK2gcCXri/gcYs7AMd93m053B1/bbvuWiStb6cVZQdk
	 gs30SbDVhOl7YQNWF67ELXYRXgp17yvAS+Xw17z+AP2QHOOvZx/NRnkoOVU/SGqvU3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ALg7S6VN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnY+bcNZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ALg7S6VN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnY+bcNZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B77606A323;
	Wed, 28 Oct 2026 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B77606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ALg7S6VN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnY+bcNZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ALg7S6VN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnY+bcNZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9819A1F7AF;
	Wed, 28 Oct 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793194090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1RNhY463TlUij+3G3iMbvuChAlQ+OLmz5YWd+MK6CA=;
	b=ALg7S6VNVeN7jO6Z7rlet/HLuKH1zkhEgjQR2Xvm4DkhHKhTBLq53hW/xC+fT4PpUaiCNz
	B9QXxj/DluV0nfi3hKw4vzd/L6Iy1o9tCnhLX2zduQQH0uhF/uKi8emqpuWoDssyk2EeP7
	FPOU2p73i8PKM79PYL3ibH89LPsH9Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793194090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1RNhY463TlUij+3G3iMbvuChAlQ+OLmz5YWd+MK6CA=;
	b=ZnY+bcNZGtDLLTNjb64cdXLVrUWCI/Uuh2kNnd+cr7Tj56tawriBozgiH7MF4GNYbyz8E9
	1a1ICcFS7uYeiiCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ALg7S6VN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZnY+bcNZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793194090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1RNhY463TlUij+3G3iMbvuChAlQ+OLmz5YWd+MK6CA=;
	b=ALg7S6VNVeN7jO6Z7rlet/HLuKH1zkhEgjQR2Xvm4DkhHKhTBLq53hW/xC+fT4PpUaiCNz
	B9QXxj/DluV0nfi3hKw4vzd/L6Iy1o9tCnhLX2zduQQH0uhF/uKi8emqpuWoDssyk2EeP7
	FPOU2p73i8PKM79PYL3ibH89LPsH9Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793194090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1RNhY463TlUij+3G3iMbvuChAlQ+OLmz5YWd+MK6CA=;
	b=ZnY+bcNZGtDLLTNjb64cdXLVrUWCI/Uuh2kNnd+cr7Tj56tawriBozgiH7MF4GNYbyz8E9
	1a1ICcFS7uYeiiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9661213419;
	Wed, 28 Oct 2026 13:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DfdGGb44WoUOQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 13:28:06 +0000
Date: Wed, 28 Oct 2026 13:28:04 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 29/46] mm/mremap: use pudp_huge_get_and_clear() when
 moving huge PUDs
Message-ID: <auH4NKaWuE0-8XBk@pedro-suse.tail5790ac.ts.net>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
X-Rspamd-Queue-Id: 9819A1F7AF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[64];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.01

On Tue, Oct 27, 2026 at 12:17:49AM +0100, David Hildenbrand (Arm) wrote:
> move_huge_pud() reads the old PUD and clears it in separate operations.
> Hardware accessed or dirty updates between those operations can be lost
> when the saved entry is installed at the new address.
> 
> The raw pud_clear() also bypasses page_table_check_pud_clear(), while
> set_pud_at() accounts for the destination mapping. This leaves the
> checker counts unbalanced for mappings tracked by page table checking.
> 
> To fix it, simply use pudp_huge_get_and_clear().
> 
> Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

At what point do we ban straight up clearing a PTE/PMD/PUD/etc? :)

-- 
Pedro
