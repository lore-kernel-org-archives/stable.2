Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173494;
	b=TxrQRB/oUIp/VwNQAjKbuerlL1OEU387ydCzcVwv+rUq14QA3iBMf1OvkTBJhwqZKWdZ
	 w5tijORvOP/mnFc3HsgA2ixmPElSIlXnWH5FpqObyssnXq+I+JeGnT9HarkOwGTZWOG5S
	 zXab0m9zSV4fPgu0eL4gi94ioygWxRvJeARssaLxKcLSFakGSn9MfcAKs/O9bKbZ3putw
	 KPGIRxWdUvGEGy8GoBNVu8MRVf0gHMS06R+Rxi2qBUSppK9W8VnrTD34LCV8CweUINxH7
	 gTGTDuDR5LS3/Um7ZlEMrXCCGVwgZxtYhbFJC+/8iPDwBJAwVgMxOEwgmfv9yW/qlcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173494;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=+YPUd1A+Tni1ykAUPBPRwQdU08UbOgzbiWI7p3MD0jw=;
	b=fB6D45w0x1D/eeSmQyYY3tRwSOrwHwD/EM7O84ceDwpZzdgG1TapGiMRX9wktGJ7BmFB
	 H1j1mYVIe0zMMPZC3ov5HXAenrztXgtlWc3ml+DQO7yeGWVQZLJO6DnuWkoPYtjdF0DPc
	 7L1zR5c64R0AmkzBXia+PsQA3pw+NlFCAn6yBP26Ul0veqFK3oiYBw87z+XaOjw+G43K8
	 59Z6hyhIt10AL0TWONL6fYltcJDnQf3RhnCegfxRB30/8/qzXOxnn8PVddFz8KwfnOuj1
	 YS6iTQhQuJagX7GkksAPOOKQBOHo4rY1kpA0sHH47RVYjjudrPNWnfGlPatSwpGpJbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bMbiJjCc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="hDnrVQE/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bMbiJjCc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="hDnrVQE/";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209B606A32A;
	Fri, 20 Nov 2026 11:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9209B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bMbiJjCc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hDnrVQE/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bMbiJjCc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hDnrVQE/
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 962B7225CE;
	Fri, 20 Nov 2026 11:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPUd1A+Tni1ykAUPBPRwQdU08UbOgzbiWI7p3MD0jw=;
	b=bMbiJjCcMyUUJcVEwvo1IhmwvGLzep4NpxqrR8KDzQXDD6BCtEjI2g1bSA95jYjmPuB6pu
	NAkXozql5Rw7cRD3zFKtPmIa71ZuR7mBpgIBpIBqFZfFkTYqlREuZQ04YJMmfYRfkU+D8J
	p2YsdeW6POwWmicNUDtqjucC+CAu/gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPUd1A+Tni1ykAUPBPRwQdU08UbOgzbiWI7p3MD0jw=;
	b=hDnrVQE/iIgplAtFZA4Jph7UMKqOAzq1gOdZsyTuRLJdb0K7e+o6DCrWsTUv1T+LT1dfLv
	RAURDwQzO/U8CyDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPUd1A+Tni1ykAUPBPRwQdU08UbOgzbiWI7p3MD0jw=;
	b=bMbiJjCcMyUUJcVEwvo1IhmwvGLzep4NpxqrR8KDzQXDD6BCtEjI2g1bSA95jYjmPuB6pu
	NAkXozql5Rw7cRD3zFKtPmIa71ZuR7mBpgIBpIBqFZfFkTYqlREuZQ04YJMmfYRfkU+D8J
	p2YsdeW6POwWmicNUDtqjucC+CAu/gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YPUd1A+Tni1ykAUPBPRwQdU08UbOgzbiWI7p3MD0jw=;
	b=hDnrVQE/iIgplAtFZA4Jph7UMKqOAzq1gOdZsyTuRLJdb0K7e+o6DCrWsTUv1T+LT1dfLv
	RAURDwQzO/U8CyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E901342D;
	Fri, 20 Nov 2026 11:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E/bPGHIsAGvdZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Nov 2026 11:18:10 +0000
Message-ID: <ac558468-8e5a-4b1e-8d4d-591221b2dbf0@suse.de>
Date: Fri, 20 Nov 2026 12:18:09 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec] xfrm: iptfs: make room before copying a
 continuation in reassembly
To: Andrii Tereshchenko <opensource@andrii.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Christian Hopps <chopps@labn.net>, Piyus Kedia <piyus@iiitd.ac.in>,
 netdev@vger.kernel.org, ipsec@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <70d0cc8d-e2ff-4293-a416-eaf2705a0b9c@mid.andrii.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <70d0cc8d-e2ff-4293-a416-eaf2705a0b9c@mid.andrii.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

On 11/20/26 10:02 AM, Andrii Tereshchenko wrote:
> When iptfs_reassem_cont() cannot share a continuation's data as page
> frags, it linearizes the in-progress skb and copies the data in with
> skb_put(). The tailroom for that copy is never checked.
> 
> An in-progress skb started by iptfs_pskb_add_frags() has only the inner
> IP header in its linear area; the rest of the first piece is attached
> as page frags. Linearizing it with skb_linearize() grows the head only
> by what the frags need plus 128 bytes, so the following
> skb_put(newskb, copylen) runs past the end as soon as copylen is larger
> than that slack, and the kernel panics in softirq.
> 
> The copy path is taken whenever a continuation cannot be shared: the
> outer skb has a frag_list, has a kmalloc'd head with linear data, has a
> different pp_recycle, or the in-progress skb has used up MAX_SKB_FRAGS.
> So it is enough for the first piece of an inner packet to arrive in a
> shareable outer skb and the next piece in one that is not.
> 
> Commit 0b352f83cabf ("xfrm: iptfs: fix skb_put() panic on non-linear
> skb during reassembly") added the skb_linearize() on the assumption
> that the in-progress skb was allocated with room for the whole inner
> packet. That holds for skbs from iptfs_pskb_extract_seq() but not for
> those from iptfs_pskb_add_frags(). The netdev AI review of "xfrm: iptfs:
> fix runt reassembly panic from short inner tot_len" asked about this
> missing check, and it was left for a follow-up.
> 
> Piyus Kedia reported the same overrun and posted a fix that bounds the
> copy by the tailroom and abandons the reassembly when it does not fit.
> That stops the panic, but the inner packet, which is valid, is lost.
> Making room delivers it.
> 
> Make room before linearizing, in one reallocation, for the frag data
> that skb_linearize() pulls in and for the rest of the inner packet, so
> that skb_linearize() itself allocates nothing; abandon the reassembly
> and count XfrmInBufferError if that fails. Sizing for ipremain rather
> than copylen means later copies of the same packet need no further
> expansion. The room is measured as end minus tail, because
> skb_tailroom() is 0 for the non-linear skb. The reallocation is
> __GFP_NOWARN: a peer chooses how large it is, and its failure is
> handled.
> 
>    skbuff: skb_over_panic: ... len:2884 put:1442 ... end:0x6c0 dev:eth1
>    kernel BUG at net/core/skbuff.c:215!
>    CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 7.4.0-rc3 #1
>    Call Trace:
>     <IRQ>
>     skb_put.cold+0x1f/0x1f
>     iptfs_reassem_cont+0x242/0x760
>     iptfs_input_ordered+0x382/0x3e0
>     iptfs_input+0x24d/0x630
>     xfrm_input+0x12a5/0x29f0
>     xfrm4_esp_rcv+0x4d/0x90
>     ip_protocol_deliver_rcu+0x1d2/0x1e0
>     ip_local_deliver_finish+0x13c/0x210
>     ip_local_deliver+0xf9/0x1d0
> 
> An AI code review found this. It reproduces without fault injection on
> unmodified kernels: on v7.4-rc3 when a packet socket on the receiver
> clones every second ESP packet, as ESP input gives each cloned packet a
> kmalloc'd head, and at ipsec commit f0e68014f4ac ("xfrm: hold migrated
> states through rollback") in a selftest written for it. With this patch
> both run clean, and failslab on the new allocation only drops the
> packet. No selftest in the tree covers IP-TFS. xfrm_iptfs.o builds
> without warnings with W=1 under allmodconfig and allyesconfig.
> 
> The analysis and the patch were produced with an AI coding assistant
> and reviewed by the submitter.

This commit message is too verbose IMHO. It is quite hard to read and 
understand.

> 
> Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
> Fixes: 0b352f83cabf ("xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly")
> Reported-by: Piyus Kedia <piyus@iiitd.ac.in>
> Closes: https://lore.kernel.org/all/20261119142308.3272570-1-piyus@iiitd.ac.in/
> Link: https://lore.kernel.org/all/20260908224855.1591147-1-kuba@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>
> ---
> I sent this privately to the IPsec maintainers and security@kernel.org
> on 2026-11-20, before I had seen Piyus Kedia's patch. Changed since:
> the credit to him and the paragraph comparing the two fixes, the
> subject of the runt fix, the build sentence, and the stable address.
> The code is the same.
> 
> On ipsec master with Piyus Kedia's patch, the selftest no longer panics
> but fails: one of its two inner packets is delivered. With this patch
> both are. The selftest is not posted, as
> Documentation/process/security-bugs.rst asks for a bug found with AI;
> the IPsec maintainers have it.
> 
> More fixes for the IP-TFS receive path follow as a separate series.
> 
>   net/xfrm/xfrm_iptfs.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 0313a43aa8a9..9c8943991260 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -909,7 +909,18 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
>   	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
>   		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
>   	} else {
> -		if (skb_linearize(newskb)) {
> +		/* A newskb started by iptfs_pskb_add_frags() holds only the
> +		 * inner IP header in its linear area. Make room, in one
> +		 * reallocation, for the frag data that linearizing pulls in
> +		 * and for the rest of the inner packet.
> +		 */
> +		int room = skb_end_pointer(newskb) - skb_tail_pointer(newskb);
> +		int need = (int)(newskb->data_len + ipremain) - room;
> +
> +		if ((need > 0 &&
> +		     pskb_expand_head(newskb, 0, need,
> +				      GFP_ATOMIC | __GFP_NOWARN)) ||
> +		    skb_linearize(newskb)) {
>   			XFRM_INC_STATS(xs_net(xtfs->x),
>   				       LINUX_MIB_XFRMINBUFFERERROR);

Manually accounting room and need allow us to perform a single 
allocation but I do wonder, is it necessary? This is a very specific 
case.. maybe we can just call skb_linearize() first and then check the 
if there is enough tailroom and perform pskb_expand_head() if needed.

Sure, that will mean two different allocations in the worst scenario. 
But I do wonder if that is just fine for such case.

Thanks,
Fernando.

>   			goto abandon;
> 
> base-commit: f0e68014f4ac1653b2980ab76744f4dfdffdbac5

