Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764879;
	b=UxPGP1jzZ/ZLZLXSNdpRDYawj2CEwDeY4qLZEcV8cc01452YCQZ59Iz0sFVDJtKN0ECx
	 jdj6RvTYv+c28gdN54Dm95XKaFcnvHB7y9DLY9VZ6TXoEo2GfeuuZMDeWww5sq460u2pK
	 GVQbToE+aYVPeGI2YePW3j0HSuc8dpGFt9qo7obIu3yLDi9tV9rvMLkuDeYSeDD+OFJp9
	 b6mHCLeg9omFt8i1NDoVhySSt+95fIMzrG1Slrqg47qehaKVHZDGORHrR8cP7/oUAbq7t
	 HTHp6TBENdh/MDkuP64IhDVVTCNRz9i5z2CUjVQrXWraTkQmllGLoHpXjpYyoDAtacw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764879;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=BBEA2A5/wv9EZ2RzYUwkVpvcPNMe+0Jgwndjloczj+k=;
	b=NESe1Qip1gzmb+z/cV792PtN3X+cUqSw6CX2V/L6hv7Dr1ftlIPopvJsIn30MfO8+Cw6
	 g6KErPf4CwJfCUsdXXmvOMa68q2jezeiKvRo9oTh9craNlhXLMY62/cXA/wjkcy515qvm
	 fEWm30NM12eRW6JzoZfZbLuONzdwdCQSm/NU8apE8admi8L7yiRcShW68/tSn9j5T9Alo
	 3Ym8Oj/cOC/u/YkNQl5K6TpndsyBhM0NsbEWlSBHHZxbliD37jOClvmttiJqm+ivu2bSY
	 IOPGW+ELB+vw4iP+wX/hkyHyA4tTWzE9FZ+RjmC4Dnl0ZlIH3fWkKrowUvHWVdAXoFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ng2qF7hR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MgSchCMa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yGutHxTo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Rle9Hhnj;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B8606A31A;
	Fri, 23 Oct 2026 14:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A73B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ng2qF7hR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MgSchCMa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yGutHxTo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Rle9Hhnj
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D51B92214D;
	Fri, 23 Oct 2026 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792764877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBEA2A5/wv9EZ2RzYUwkVpvcPNMe+0Jgwndjloczj+k=;
	b=ng2qF7hRcaNy2ATrLnQ6eDlT7wQhGB5Qr33toTJMyn9mwDdnsDc2Ese5GLTkXg6xLz7+TC
	k7DgVXMHOY8yL1Dd5YWAGSTVwFGX2AkdlwWh6RsO0Q09y2DfWYMhr8umXZvF/im+Erdf0b
	rLwl9XPRsat2o3xyP84a6XYKc7RD25c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792764877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBEA2A5/wv9EZ2RzYUwkVpvcPNMe+0Jgwndjloczj+k=;
	b=MgSchCMaqoujTtjSE8rR24OlL3dr55KyMilSkj1AVRDxeoPWW3PehKviJctfc/vhqL60kR
	z+R9bOLNbhhadSCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792764876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBEA2A5/wv9EZ2RzYUwkVpvcPNMe+0Jgwndjloczj+k=;
	b=yGutHxToPWEHwo2Hu4DOv9mcWnFtmNB2u9fICNq57oOku78P4A8WM1Ca+MkuWMULIKrJ6B
	S0fF7EX8ntldA9pKL2iw5FgF9mORCJePfpGKtKHbQpQB6QK94q8B2nv7OX3TeIny4qu/BP
	6WGM9dCoc68PXeR+aPhCNYy3vDTl6Ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792764876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBEA2A5/wv9EZ2RzYUwkVpvcPNMe+0Jgwndjloczj+k=;
	b=Rle9Hhnj6EYbet5UXwcNoO2EAbMAyy1Tgo8SqeZ78QQoBIqoyMAw7G8k/BBCasZjLdq3JT
	3ELz6NKfL7PYfeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7CDA133F3;
	Fri, 23 Oct 2026 14:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M74QHstr22rOeQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 23 Oct 2026 14:14:35 +0000
Message-ID: <30d58956-89b3-458e-bff8-69cd86f38415@suse.de>
Date: Fri, 23 Oct 2026 16:13:33 +0200
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
Subject: Re: [PATCH net 3/5] ipv6: restrict mld_qrv to 255
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>,
 Joel Granados <joel.granados@kernel.org>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Flavio Leitner <fbl@redhat.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-4-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261023091419.167088-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,nvidia.com,google.com,nokia-bell-labs.com,icloud.com,gmail.com,stressinduktion.org,suse.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/23/26 11:13 AM, Jiayuan Chen wrote:
> net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
> into the u8 inet6_dev::mc_qrv, and every MLD retransmit counter derived
> from it (mca_crcount, sf_crcount, mc_ifc_count, mc_dad_count) is u8 as
> well. Anything above 255 silently wraps: 256 becomes 0, so no state
> change report is ever retransmitted, and the first MLDv2 Query received
> on the interface then trips the WARN_ON() in mld_update_qrv():
> 
> 	WARN_ON(idev->mc_qrv == 0);
> 
> A plain bridge with mcast_querier enabled on the link is enough:
> 
>    WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
>    Workqueue: mld mld_query_work
>    RIP: 0010:mld_query_work+0x1fd2/0x2cb0
>    Call Trace:
>     <TASK>
>     process_one_work+0x93a/0x1b20
>     worker_thread+0x6d0/0x11d0
>     kthread+0x358/0x470
>     ret_from_fork+0x5b3/0x820
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
> Cap the sysctl at U8_MAX, the largest value mc_qrv can actually hold.
> 
> Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
