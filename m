Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B847044A
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140071; cv=none; b=K03Doh8R69E/cZZBVkYjafy5U2XHV/JVJhZ6NUssCi3DzQkkpeoOkracyPmg+LlCLMpTzsBImxrtTx5+4gF2NO/r+olbL5EYX4WAZLqcSlaDa+StyxD6L2VbUfzsvgUFcEzqnnYen2E13YpOML7OqRNF0RXGqF8XTBIX3jjHyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140071; c=relaxed/simple;
	bh=gcQPS/VSDyVq6/S/CsLiGjq6oJPO7r2cDpk7pBSMupk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjEDKH8LX4sk/GynTNB2ZFj1/DOwY8HvovM+/l4MwHqLyvM+gVvV5Qxla0KLeoy9Dxrp6n2+IhnLNnLCoL/wHbF4Dl5QDMK0qa4Q4+QFIUQ0X7GdDsatpmEqPD1DVewKd3t2zG5oC7EH+AJq24u4T/MFKAQool3JLQHPPY0pUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sdZOhMKN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/fN2Mi54; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gzi2SacI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c1VynHKP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sdZOhMKN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/fN2Mi54";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gzi2SacI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c1VynHKP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B428B84AE8;
	Wed, 19 Aug 2026 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787140055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QE/hfjMhgkzDlh9hMfKiRnQH4XhAoQAOprsScQVSDOE=;
	b=sdZOhMKNknm9d24MlImIN22+sda9pRFRa5fcR/2upNtJPwR7SBItToZcA4JyaML/5IN4Cn
	B1zC536NdPFzjUocqW96uSiCPuP0Dt+PQSz8+tnDGRD3nUFSMWwaiY0SKVvvCY7ruIr6ka
	Qj7p5QN8j8MF28jlzSgqPCa6q6Tj9hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787140055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QE/hfjMhgkzDlh9hMfKiRnQH4XhAoQAOprsScQVSDOE=;
	b=/fN2Mi54hPC2FdiZfQmZO24MkOlfismr3z/nJcZyavz6bmSKKOsEibZmwELitvJeuUNzVX
	tPYGI7HixpAviWBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Gzi2SacI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c1VynHKP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787140051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QE/hfjMhgkzDlh9hMfKiRnQH4XhAoQAOprsScQVSDOE=;
	b=Gzi2SacI9yFFLmNXhfHGlFqY0RcuenWSeNEaxCcCA1ewQDHwAix7DhC7Hw0b0z3elw/+TH
	elhb2Psr5i2p3uP9TsLSGVR+f2J4J/GLbHtaOhy5LhSWPkx0S2rVsP+C8Kn8B9cbddcW2b
	/ZVkl4fd7tyvIqbhagj4zwZsmPWCyo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787140051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QE/hfjMhgkzDlh9hMfKiRnQH4XhAoQAOprsScQVSDOE=;
	b=c1VynHKPN2WWzkWZZuc2YBuDsl192oGxejNcs+CvUo2L0MWKCRoGgl98MlQ4X+BV6u5qUb
	5ZjqFpa2G6lBK2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01EAB362E;
	Wed, 19 Aug 2026 11:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vR9JOdKXhWq3ZAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 19 Aug 2026 11:47:30 +0000
Message-ID: <3d78b662-85da-4571-9e6a-168bc5f43f7a@suse.de>
Date: Wed, 19 Aug 2026 13:47:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipip: fix skb leak in collect_md mode when
 metadata_dst allocation fails
To: Anton Danilov <littlesmilingcloud@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Thomas Graf <tgraf@suug.ch>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260819104338.432631-2-littlesmilingcloud@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260819104338.432631-2-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: B428B84AE8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/19/26 12:43 PM, Anton Danilov wrote:
> In collect_md mode ipip_tunnel_rcv() returns 0 without freeing the skb
> when ip_tun_rx_dst() fails to allocate the metadata_dst. ipip_rcv() and
> mplsip_rcv() are registered as xfrm_tunnel handlers, so tunnel4_rcv()
> and tunnelmpls4_rcv() read the zero return as "the packet has been
> consumed" and do not free it either. The skb is leaked.
> 
> The other tunnel drivers all dispose of the packet at this point:
> ip6_tunnel.c jumps to its drop label, ip_gre.c and ip6_gre.c return
> PACKET_REJECT, which makes gre_rcv() free the skb. Only ipip returns 0.
> 
> Jump to the existing drop label instead. It frees the skb and still
> returns 0, so the packet keeps being reported as consumed, which is what
> we want here: the outer header has already been pulled, and neither the
> remaining handlers nor an ICMP unreachable have any use for it.
> 
> Triggering this needs an ipip or mplsip tunnel in collect_md mode and an
> atomic allocation failure, which is why it has gone unnoticed.
> 
> Fixes: cfc7381b3002 ("ip_tunnel: add collect_md mode to IPIP tunnel")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude-Code:claude-opus-5
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
> ---
>   net/ipv4/ipip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> index b643194f57d2..ddf62b45566b 100644
> --- a/net/ipv4/ipip.c
> +++ b/net/ipv4/ipip.c
> @@ -248,7 +248,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
>   
>   			tun_dst = ip_tun_rx_dst(skb, flags, 0, 0);
>   			if (!tun_dst)
> -				return 0;
> +				goto drop;
>   			ip_tunnel_md_udp_encap(skb, &tun_dst->u.tun_info);
>   		}
>   		skb_reset_mac_header(skb);

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
