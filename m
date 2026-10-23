Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754591;
	b=SVRo92PqFL6QeXgPsY8jYk0K17v5jX2MGq0hxHgUqry3w9N8nf8fv6vPFMwHucJDf/P6
	 gi6G8auV5PNKmjhE9teTooSiXTU1z3MxEXw6k+wyjKacFB88fg7RenJNlGq7U3PtZ//Fs
	 3J2HGhw2eUKd/SBLXtmqROPae9hCsPauRdqCJ0sv2cOGMK+XooJBVgrLdgaglInAWokiu
	 zUnhDzXIgIvwqgbQJBc+GEDHjhYlyYAYe3qciqjZNKPKg4x6eduIu+y/Gotjkm1LPiitO
	 b5PjhB6nmqZy0w1dgQnVho1pgGE6KiHMFSa0LpT/E8obiO2dAEt5UFgqkTQV2dIzf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754591;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=MWj9q4uajifA/Jb3vbzOHD2Z9r7aAIaHgsTHTJb/MnM=;
	b=3ImqFtYs/E/j+THhMIHbtEWip5fGxFcw7ticOd92zxBlUC0TeFCgegYxbRsrHalC48ZT
	 kTKvqptznwAgANzrvNNVSjOXw+i74sx0dopvKPOIn3v5G7K1m5Prfe0US35NZlQpML53C
	 y0lOcDgdAskOO6Aihg355wWoJh5XLoXLXNVDxFmLsu8xFVnX/H0fifcH7GyS9ZBJl1mQj
	 ggo+2IOHFYY7VpbT0TqoivJjP8iYHpnKPPeq2HqY9bgDY6tpywVFOBpstZaxzZpKbUnJz
	 lY6TZCCuDk33vTOJUNZuFQRep0ABcuiB/iifpBpWqE/v4E3Gw1G4D5c0v617LECU+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ikltLxiY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nMXFzyBD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j9FargvX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1ioqEvaB;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0D606A31A;
	Fri, 23 Oct 2026 11:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4F0D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ikltLxiY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nMXFzyBD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j9FargvX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1ioqEvaB
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBC9522142;
	Fri, 23 Oct 2026 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792754589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWj9q4uajifA/Jb3vbzOHD2Z9r7aAIaHgsTHTJb/MnM=;
	b=ikltLxiYqGewZaPR55z1hoUjQSG0CgtowBuDtRJdDCDaClMXN8iiYDJfnkhAHdmSZKc2Mi
	AqQK/M0cW6e1Mu5X1Z3Hg2CkcfMm24q8Ipoz/qeZNmjLWQ+ucuOW0v/TCE2tvo+HdWNsmG
	ozkzc7p9MZE8UwDKwNs4e52VU1+/BNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792754589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWj9q4uajifA/Jb3vbzOHD2Z9r7aAIaHgsTHTJb/MnM=;
	b=nMXFzyBDrzcEDDi4kKUbVpzee4xfT1GaAeczV9Ugw35IpYFEvjec7FCHBg/1w9ooltKEGn
	JnEstad4igfPHYAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j9FargvX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1ioqEvaB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792754588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWj9q4uajifA/Jb3vbzOHD2Z9r7aAIaHgsTHTJb/MnM=;
	b=j9FargvX71H/V4NpMX+jZAr7YfFCmnu/EzeyoKBiD3oY4NjExjyZP50IB9t9DVta1K4Wf8
	1dilqlo05sGILOIwYmGjVuUmsBAVgUOFER07wuAp1A8fIEXAxi9Q4MwmIcm3EGGKtHcz93
	X5G04AScj/a70by2J1UtKQZREXj/Ixo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792754588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWj9q4uajifA/Jb3vbzOHD2Z9r7aAIaHgsTHTJb/MnM=;
	b=1ioqEvaBJQujl2TSOEtmbQTYXJztPL2vNolxbQXCxeqaXlDxAV1uNh3b0oIgOt79FMnhQm
	xvf0D9H1gCJ+UrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C20133F6;
	Fri, 23 Oct 2026 11:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tAViApxD22qMQgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 23 Oct 2026 11:23:08 +0000
Message-ID: <91ffac70-3fd6-4644-bfbc-4710af1faa37@suse.de>
Date: Fri, 23 Oct 2026 13:22:01 +0200
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
Subject: Re: [PATCH net] bonding: fix out-of-bounds read of arp_ip_target
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, linux-kernel@vger.kernel.org
References: <20261023104528.232427-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261023104528.232427-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EBC9522142
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00

On 10/23/26 12:45 PM, Jiayuan Chen wrote:
> arp_ip_target is a module parameter array with BOND_MAX_ARP_TARGETS
> entries. In the loop parsing it in bond_check_params(), arp_ip_count is
> the number of accepted targets, while i is the index into
> arp_ip_target. Invalid and duplicate entries are skipped without
> bumping arp_ip_count, so bounding the loop with arp_ip_count lets i run
> past the end of arp_ip_target, e.g. 16 targets with one duplicate:
> 
>    BUG: KASAN: global-out-of-bounds in bond_check_params.constprop.0+0x1148/0x1440
>    Read of size 8 at addr ffffffff96e9ee00 by task swapper/0/1
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x91/0xf0
>     print_report+0xd1/0x630
>     kasan_report+0xf3/0x130
>     __asan_report_load8_noabort+0x14/0x30
>     bond_check_params.constprop.0+0x1148/0x1440
>     bonding_init+0x13/0xe0
>     do_one_initcall+0xe7/0x5b0
>     kernel_init_freeable+0xa91/0x1120
>     kernel_init+0x24/0x220
>     ret_from_fork+0x5b3/0x820
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
>    The buggy address belongs to the variable:
>     arp_ip_target+0x80/0xa0
> 
> Bound the loop with i instead. arp_ip_count never exceeds i, so it
> stays within BOND_MAX_ARP_TARGETS too.
> 
> Fixes: 5a5c5fd48e3b ("bonding: arp_ip_count and arp_targets can be wrong")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
