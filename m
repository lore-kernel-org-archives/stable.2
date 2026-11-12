Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482844;
	b=OvIJn8j4hVOWkB3nC2t8yIpOyRJAuceA4u3kSHpDBLEkPyoDiMjZ9CRE6Jnn2NhHfSFq
	 w980obskLQwr/z/zH7kSgCExR3hJKuvPDUoPyZ6dxBW1OUkb2kgakr5aJcPHVKemCAmff
	 OcGHzwItuDP/pGahCkpredyJnsKYTx0s53o6sJsKvLG/T+KCTLuXuS8JptRfmrW0xb2CS
	 Oz2ln2q4aCvv57dPhq50smNjnETgT9R/qxLhRrx5OBzj6fUz7hc09FjtT+P3it6Y8BpT5
	 vZDf8sh1zC8E7TLhUXf45zHykxRygXwLWBHp2TFGJLQtM2WiszE9tyWcBipUT+gZ/qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482844;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=+qfAWejTqt9HBexVssaPLw0dtgoyKn0a3iu0Ya7NvI8=;
	b=NxnutAchuE6k4MPPRTmCvTMitX9TLXEliBYf7xnVPvcN0oo72IjZA/+L0XLdlJ2PjWEa
	 JSc45iisX4WUeA70jQvuQCjbhZpjsWIFFw8+GDcF63ph1tlZGjpMU10xpa8+gpKQoSRM0
	 hXR8QlhWYzgvq3V/RcYPfmlKkeGmVNdlNrTT++k/ES9Hv+5vPuNHGFyTvsbvhTKzRQtG+
	 leKoTQfHkvPjdk4TCKbt3U8EJREXj21w3MIeH1weqcbI4TUEM/u2dXCx8ziKhCfhOKmoz
	 i2a8dSCurKtDgw6lSpszz1wzeK35TDPzW2eZueUB77YtKGSwfEoiqVxP4mcj53nTv9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sM7KPGRL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gVQNZ2tZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sM7KPGRL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gVQNZ2tZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A2606B366;
	Thu, 12 Nov 2026 11:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505A2606B366
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sM7KPGRL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gVQNZ2tZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sM7KPGRL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gVQNZ2tZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44CA61F792;
	Thu, 12 Nov 2026 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794482841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qfAWejTqt9HBexVssaPLw0dtgoyKn0a3iu0Ya7NvI8=;
	b=sM7KPGRLeR5zKC6G9M7E71I+TyYl/b2I6VJz2zCNKtDRDd5in59lK7f9hvT3dGVdXNqUhS
	fTKlp1A453ihhrHCqUUBwCwJXhKxa6+zZHADXxkB5F6vdEkqOC+TgbtU2OO0eR8IjbBB4R
	gPkM1gxlMfTuqg+VMshA41ucEGTN7WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794482841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qfAWejTqt9HBexVssaPLw0dtgoyKn0a3iu0Ya7NvI8=;
	b=gVQNZ2tZMKKVdEHUKJ8nLTnuR3R3EyvsEkvOUc/dcVlKzdX84GpQyLU3dPhhTmn8bsiHjx
	Ff3efzWNTvBNcICA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sM7KPGRL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gVQNZ2tZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794482841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qfAWejTqt9HBexVssaPLw0dtgoyKn0a3iu0Ya7NvI8=;
	b=sM7KPGRLeR5zKC6G9M7E71I+TyYl/b2I6VJz2zCNKtDRDd5in59lK7f9hvT3dGVdXNqUhS
	fTKlp1A453ihhrHCqUUBwCwJXhKxa6+zZHADXxkB5F6vdEkqOC+TgbtU2OO0eR8IjbBB4R
	gPkM1gxlMfTuqg+VMshA41ucEGTN7WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794482841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qfAWejTqt9HBexVssaPLw0dtgoyKn0a3iu0Ya7NvI8=;
	b=gVQNZ2tZMKKVdEHUKJ8nLTnuR3R3EyvsEkvOUc/dcVlKzdX84GpQyLU3dPhhTmn8bsiHjx
	Ff3efzWNTvBNcICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A63AC134A0;
	Thu, 12 Nov 2026 11:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N8F0H5ai9WraAwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 11:27:18 +0000
Date: Thu, 12 Nov 2026 11:27:16 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
Message-ID: <avWicfogDlC5xLZQ@pedro-suse.tail5790ac.ts.net>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,linux.dev,linux-foundation.org,suse.cz,gmail.com,cmpxchg.org,nvidia.com,intel.com,sk.com,gourry.net,linux.alibaba.com,tencent.com,redhat.com,linux.intel.com,gentwo.org,nxp.com,fb.com,kvack.org,vger.kernel.org,alien8.de];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 44CA61F792

On Wed, Nov 11, 2026 at 06:13:16PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> It turns out that filemap_cachestat() can unwittingly return incorrect
> page counts, if large folios are present.
> 
> This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
> kernel if the input range starts more than 64 pages into a folio that is
> split during the call.
> 
> It can also occur due to pages after a large folio being skipped if the
> range starts in its second or later XArray slot and the call reschedules at
> that folio.
> 
> Finally it can be caused by pages being counted twice due to folios in the
> range being split or collapsed during the call.
> 
> filemap_cachestat() walks the page cache under the RCU read lock only,
> and for each entry it counts the pages that lie in the range. It does
> not track how far it has counted, so the counts are only right if the
> walk returns each index once.
> 
> But a large folio can be split during the walk, or small folios can be
> collapsed into a large one, and the next entries then cover indices that
> were already counted.
> 
> Resolve the issue by tracking the current index as one past the last index
> in the folio, and explicitly using xas_set() to set the current position in
> the XArray.
> 
> Additionally, add a check for folio_last_index reaching or exceeding
> last_index and break out of the loop if so.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: updated to use curr_index, fixed comments, updated commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
