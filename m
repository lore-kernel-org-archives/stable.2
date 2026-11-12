Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507100;
	b=4ijmzUU+Sd9+oo6YodZS+9+AVJZ5ycGfnmO+3Um8YZjssnIfsBr64RjsyzkAJbL/bGk+
	 d61if0T/IyfY2EKrvQX99rdBnekXOjifQBMRUksVEG+rOYJ+XMuvLik8nUKEXkkFsG1R6
	 XMzL7pTucF7o4UepvNhA0q4mdpdSzwXPgP4gbJMHBAcejvD2vBsww/lUC5E12QnSc0m3F
	 dU4b5iQcPGM1BANqtcr69seJf3BpjU9PPth9uNRj9vNcck6r6wqWDVWSo4loW1+PJHq7A
	 Bd5dNlySdi0oHOOPnJPnyw+FtewBhZXsLMqT6UAYBX73fZqlggG5cajNUjPNYC5JWOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507100;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=LM8wBhNRNhOCG/pAJr6opW9xMvaqFILD9ZI28NtAf/s=;
	b=4iv1H1Su7Dp3yDzF4DXEYoc+BX3KYxeGWwWB5oTc/uSLsY+2oiXkwOIHEN5/vF4vgyu2
	 tC4TDc7AKVAmfvTtYfRfT34GTvRzb+uRNLC5PywaaponcfDmV8huUt2mQCOOr1DNq7Gk3
	 ybynlB3KyFc6IfEu/shd9tTJGdX2yYii/Dhn5+Aran6AoWJqpOUGTAJpruIHUXceyfIvM
	 bNR7YriSgjn0cjCobJKVSdqO8WXIgAuIxsDUSRLx7ZSYa0jXoEppXBoykxVlB8RFa76uV
	 oyV8eCyeS5LA2KAf3683oLFDhPUmttZnCprpewVVJ14B2v/zn6YXDvRghltVaYPCP0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bteK92xW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eq1GcahI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bteK92xW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eq1GcahI;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7B606A334;
	Thu, 12 Nov 2026 18:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E7B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bteK92xW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eq1GcahI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bteK92xW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eq1GcahI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 278691F7CE;
	Thu, 12 Nov 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794507098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM8wBhNRNhOCG/pAJr6opW9xMvaqFILD9ZI28NtAf/s=;
	b=bteK92xWwILulLFJBTyYTeH+vD3loZ4YW1kYfR6l+JJ99ue9NkjEXtGZeIHk1dNko/8Iis
	McWYgxcY6IyJu9HnmoN+WHAkBPRTVK/2zW/ugqe7dncGOmBEWr/SZxNmE6ZSylRusUnU0w
	B6T847t9NH5kQyNpQZoMZF7aXF7dqzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794507098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM8wBhNRNhOCG/pAJr6opW9xMvaqFILD9ZI28NtAf/s=;
	b=eq1GcahIE8BIo3ZdgeXKet6VrbMMzZCM9cN5wbkl6zNBSjDCscd/CsJ9HG8MvHYUH4boqk
	XpEzWctmukEgEdAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bteK92xW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eq1GcahI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794507098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM8wBhNRNhOCG/pAJr6opW9xMvaqFILD9ZI28NtAf/s=;
	b=bteK92xWwILulLFJBTyYTeH+vD3loZ4YW1kYfR6l+JJ99ue9NkjEXtGZeIHk1dNko/8Iis
	McWYgxcY6IyJu9HnmoN+WHAkBPRTVK/2zW/ugqe7dncGOmBEWr/SZxNmE6ZSylRusUnU0w
	B6T847t9NH5kQyNpQZoMZF7aXF7dqzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794507098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM8wBhNRNhOCG/pAJr6opW9xMvaqFILD9ZI28NtAf/s=;
	b=eq1GcahIE8BIo3ZdgeXKet6VrbMMzZCM9cN5wbkl6zNBSjDCscd/CsJ9HG8MvHYUH4boqk
	XpEzWctmukEgEdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0349413432;
	Thu, 12 Nov 2026 18:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FXq8MFgB9mrpKQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 18:11:36 +0000
Date: Thu, 12 Nov 2026 18:11:35 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: reject shmem collapse ranges beyond i_size
Message-ID: <avYBFPhB46XWAG4A@pedro-suse.tail5790ac.ts.net>
References: <20261112142335.2749597-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112142335.2749597-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Rspamd-Queue-Id: 278691F7CE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.51

On Thu, Nov 12, 2026 at 02:23:35PM +0000, Jérémy Jean wrote:
> MADV_COLLAPSE lets collapse_file() treat absent shmem pages as holes
> filled with zeros. It does not check i_size, which allows one present
> page to become a huge mapping that covers the whole collapse range,
> including pages beyond EOF. This makes those pages writable. A later
> file extension can expose their contents after F_SEAL_WRITE.
> 
> Hold inode i_rwsem in read mode while collapsing shmem so i_size
> cannot change. Reject a collapse if its page range extends past
> i_size rounded up to PAGE_SIZE. Keep i_size_read() outside the
> page-cache XArray lock because its 32-bit SMP reader is not IRQ
> safe.

I don't think this is an issue. shmem/tmpfs purposefully maps with large pages
across i_size, and collapsing across i_size is a feature, not a bug.

-- 
Pedro
