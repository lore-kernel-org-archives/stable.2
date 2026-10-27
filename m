Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102166;
	b=4lmLAsPorfE2v6tr+OvkvrPVsdvEwHp1iJcKwUjb+sZ4zIraiuWqD6IXi5p8gV2HveIu
	 nnIgm+wLWi5rzZNjQW/cNBieMs7nqFPW3sPwtCZC7cdpIzcIQaaq6DmnMlJeqClbBiTlP
	 wmIpf7vHDhPmOF9R3Z4MVLZOVmPvJGC/gdKijLiVrNX+V1FhSY1slT29O/CTMD5t6GLGx
	 r6I9WLJRYft26I21TXU1e8DOJvb+dyg8ZLidl4N/0Q6Md4BKhs+/wcYZ/kpvpfpVdwKvU
	 vxRrDSt7RYCMOY1mJULNiElAi8melDgY/heDTf0P7a/613nx1UR8NeSdmn5/XUBDcVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102166;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=zrmpS+1ekB0Z2PHSHdRQQMGpqeQuw5eBW0k8NA/r2uI=;
	b=GSn3iN5ECqa1540WscCFWt88GcFSEaWD+DkErXrjmMnJSqFTV4KVESaKQySNvnwiiXVi
	 JETLBu0351GmDc2zMH47KXfV50CraNHSenNtRnSiZomOld+NUzOlNMnurpHDiD6isUlcI
	 Oqa0hZqDp2E2tzTVsX9ayyP9C/OABQ3ymrM396A80USWamR6D0HkhiME6L34A6Av7kQvR
	 hAeDmdPVVd/KRRa7oowvuU6jIjdC1V/gGlVqmaKwddqYeSRG8yzYiDQx81QLmOK/2f80E
	 aFYYyNGdGSglPyACb7e8Du8G4rxjq4GJcs9nVzOIs67DEAdKc/5IPQHqHEsNL72jgog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RDYbBM5W;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Om4iQt9Y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RDYbBM5W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Om4iQt9Y;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C8606A31F;
	Tue, 27 Oct 2026 11:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931C8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RDYbBM5W;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Om4iQt9Y;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RDYbBM5W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Om4iQt9Y
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADF7C1F74D;
	Tue, 27 Oct 2026 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793102163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrmpS+1ekB0Z2PHSHdRQQMGpqeQuw5eBW0k8NA/r2uI=;
	b=RDYbBM5WGI30gQrB819E2bvezVUH3VQfKEceXHyp1epw0WJgt18L6vV024u88ni42lbkm9
	G8HkngkwennDbJjEygM1PD1T7jcro/zcTwBie2G8AHnRAJLWJfnRd5S7nTizj1fIo+y94g
	n1EE/NoTGTEP8vKQ4Vo9C4nOhIgF4Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793102163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrmpS+1ekB0Z2PHSHdRQQMGpqeQuw5eBW0k8NA/r2uI=;
	b=Om4iQt9Yxxrqzb8auQ/4iHgxAUDW3rYMstr+szFfrnmbHUWwYBPZwsXGa1/TW6qQDP6LLK
	b8lNM8e7jTaqLfBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793102163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrmpS+1ekB0Z2PHSHdRQQMGpqeQuw5eBW0k8NA/r2uI=;
	b=RDYbBM5WGI30gQrB819E2bvezVUH3VQfKEceXHyp1epw0WJgt18L6vV024u88ni42lbkm9
	G8HkngkwennDbJjEygM1PD1T7jcro/zcTwBie2G8AHnRAJLWJfnRd5S7nTizj1fIo+y94g
	n1EE/NoTGTEP8vKQ4Vo9C4nOhIgF4Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793102163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrmpS+1ekB0Z2PHSHdRQQMGpqeQuw5eBW0k8NA/r2uI=;
	b=Om4iQt9Yxxrqzb8auQ/4iHgxAUDW3rYMstr+szFfrnmbHUWwYBPZwsXGa1/TW6qQDP6LLK
	b8lNM8e7jTaqLfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC2101321C;
	Tue, 27 Oct 2026 11:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e7lhLlGR4GohaQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 27 Oct 2026 11:56:01 +0000
Message-ID: <5fd819c3-9c6e-4273-a340-4ca190573cd7@suse.de>
Date: Tue, 27 Oct 2026 12:54:48 +0100
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
Subject: Re: [PATCH net v2 2/5] ipv4: fix shift-out-of-bounds in
 ip_rt_send_redirect()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
 Joel Granados <joel.granados@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 Daniel J Blueman <daniel@quora.org>, Jiri Wiesner <jwiesner@suse.de>,
 Gerd Rausch <gerd.rausch@oracle.com>, Oleg Nesterov <oleg@redhat.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
 <20261027104701.296240-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261027104701.296240-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,infradead.org,nvidia.com,suse.com,google.com,ntu.edu.sg,quora.org,suse.de,oracle.com,nokia-bell-labs.com,icloud.com,gmail.com,stressinduktion.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/27/26 11:45 AM, Jiayuan Chen wrote:
> ip_rt_redirect_number is the max number of ICMP Redirects we send to one
> endpoint; once we hit it we stop. Before that, ip_rt_redirect_load gives
> the redirects an exponential backoff:
> 
> 	if (peer->n_redirects == 0 ||
> 	    time_after(jiffies,
> 		       (peer->rate_last +
> 			(ip_rt_redirect_load << peer->n_redirects)))) {
> 
> n_redirects grows until it reaches ip_rt_redirect_number, and both
> redirect_number and redirect_load are plain proc_dointvec sysctls with
> no upper bound. Set redirect_number past 32 and n_redirects climbs past
> 31, so "ip_rt_redirect_load << peer->n_redirects" shifts a 32-bit int by
>> = 32 bits, which is UB:
> 
>    UBSAN: shift-out-of-bounds in net/ipv4/route.c:949:6
>    shift exponent 32 is too large for 32-bit type 'int'
>    CPU: 1 UID: 0 PID: 1845 Comm: ping Not tainted 7.3.0-rc7+ #364 PREEMPT
>    Call Trace:
>     <IRQ>
>     dump_stack_lvl+0xc1/0xf0
>     dump_stack+0x10/0x20
>     __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>     ip_rt_send_redirect.cold+0x2c/0x146
>     ip_forward+0x1ddc/0x2430
>     ip_rcv+0x2b1/0x320
>     __netif_receive_skb_one_core+0x16b/0x1c0
>     __netif_receive_skb+0x21/0x150
>     process_backlog+0x37e/0x1200
>     __napi_poll.constprop.0+0xa5/0x5e0
>     net_rx_action+0x4c0/0xf70
> 
> Bounding redirect_number instead is not an option: 0 disables redirects
> and -1 removes the cap. Compute the backoff in u64 with the shift count
> capped at 31, which cannot overflow once ip_rt_redirect_load is
> non-negative, and clamp the result to MAX_JIFFY_OFFSET: on 32-bit a
> backoff of 2^31 or more is read by time_after() as already expired. This
> keeps redirect_number as the limit on how many ICMP redirects are sent,
> and the shift can no longer go out of bounds.
> 
> redirect_load on the other hand gets a lower bound of 0. A negative
> backoff never meant anything, the old code only happened to treat it as
> no backoff, and once converted to u64 it would turn into the maximum
> backoff instead.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
