Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B273F3294
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568242; cv=none; b=N234jjm5aMuvoBggzQ0xV9nM8ObiU7u3SIRGw/wyOspr1AD1HJovWlar9qplBggd0t2gslFKVxltwGcIyFRVegZTp/TjmgIps4bYyDDGlbM1d4xa1tLvRoVrte4z/BCqO5pSZcPpf/yraRzWH7Thf1V8Pr9r8t1y7o6gY8ih86E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568242; c=relaxed/simple;
	bh=AdTE+vvMOTXSMGiO8D9OEhk9PjHBOyUBg/QEiNWXRoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEeRGB0IRX7j4DY1OT4vzLau6oEN4THuLihusar/yPFRGowTAWp8cATApn4y12RNIEU7QaA+EcQFO6YWgsym49ianvzZ33VFDw8iq2XjYqbHfMf0dg9AFVtITJHwt7iUxqnszadQGXDVTU9+7M+PT3eSJeEMt8mFjw7qD9MfG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bv7N5qxp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qnSyxlD7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mVuWLki9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiRn8/G5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bv7N5qxp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnSyxlD7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mVuWLki9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiRn8/G5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8145686738;
	Mon, 24 Aug 2026 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787568225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAqnFNQfpkjimKpQXv8mitMgk3RGxzvWI4q9JZf+DRE=;
	b=bv7N5qxp01TDFnTXwZwfHk4RXo+HcydS1H9aivw1T/THNK15Zh2SkKBL5GQuBI6iXjOoN9
	xpVEI6z7e28PF6jmTeYjAYBj4+p4bw6cv0C+gpTOl4gACQAK8T6TY/Ek0bZYLdIQw9hzfw
	f6hwhBY+eL5Z+Fauiac+8zvdfz/drqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787568225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAqnFNQfpkjimKpQXv8mitMgk3RGxzvWI4q9JZf+DRE=;
	b=qnSyxlD7fNpTKWDjjSAQB5gffnVFXWaqrZNOv/jtsTkpyPpfiU+5mzywlsIFcItJsBv7l7
	2wb9jzlK/IM2jEAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mVuWLki9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tiRn8/G5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787568221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAqnFNQfpkjimKpQXv8mitMgk3RGxzvWI4q9JZf+DRE=;
	b=mVuWLki915J/OvvIftApS/3R5nVwP4h7nWHOxhFQcKKdbHO7N4Sh1EFQBOMOlYD+/DtQbF
	UVAW330XeRpmHUahoJ796/lCgbxof9fkdPqLAR+JgJlEgzKjMp7xGRBEiXygxvyde4ofUh
	fFD2WXkEu2SuE85Yx3K7146H/Zjzbc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787568221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAqnFNQfpkjimKpQXv8mitMgk3RGxzvWI4q9JZf+DRE=;
	b=tiRn8/G5+I4upmY+zQp6/HqT5SKrfeKWujAb1PBJakH8yruk5FW0VcIt3DsEs/BHhPKVS0
	wWSluZcE0uvIMzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD10F1333B;
	Mon, 24 Aug 2026 10:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i/w0L1wgjGqDMwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 24 Aug 2026 10:43:40 +0000
Message-ID: <fdc1dcad-d061-41e9-b256-a6658cec6f60@suse.de>
Date: Mon, 24 Aug 2026 12:42:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: specs: rt-link: fix ipv6 devconf doc
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260824103816.40040-1-ast@fiberby.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260824103816.40040-1-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[fiberby.net,gmail.com,kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,fiberby.net:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 8145686738
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/24/26 12:38 PM, Asbjørn Sloth Tønnesen wrote:
> devconf is even odder than described in the blamed commit, where bpth
> IPv4 and IPv6 are described in an identical way:
> "u32 indexed by ipv?-devconf - 1 on output, on input it's a nest".
> 
> There are two issues with that line for IPv6:
> 
> 1) The subtraction is an IPv4 specific quirk, to avoid having an unused
>     u32 at index 0, thus saving 4 bytes per net device being dumped:
> 
>     - In include/uapi/linux/ip.h the IPV4_DEVCONF_* enum begins with
>       IPV4_DEVCONF_FORWARDING = 1, so the enum starts at 1, which is
>       the reason for the subtraction in the IPv4 variant.
> 
>     - In include/uapi/linux/ipv6.h the DEVCONF_* enum begins with
>       DEVCONF_FORWARDING = 0, so subtraction would underflow.
> 
>     - ipv6_store_devconf() in net/ipv6/addrconf.c also doesn't do the
>       subtraction in the output path.
> 
> 2) Setting IPv6 devconf through Netlink is not yet supported, as
>     IFLA_INET6_CONF is not handled in inet6_set_link_af().
> 
> Fixes: 720447bd0b24 ("netlink: specs: rt-link: remove implicit structs from devconf")

Does this really require a fixes tag + stable Cc'ed? In any case, LGTM.

> Cc: stable@vger.kernel.org
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> 
> Fernando, please remember to reintroduce the ", on input it's a nest"
> in your WIP/planned patchset that introduces support for setting IPv6
> devconf via IFLA_INET6_CONF.
> https://lore.kernel.org/bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de/

Thanks!

I will make sure to reintroduce it, once the netdev is open again I will 
send a patch implementing it.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

> 
>   Documentation/netlink/specs/rt-link.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index b80c2ac3ac31..00c915031efd 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -2218,7 +2218,7 @@ attribute-sets:
>           name: conf
>           type: binary
>           sub-type: u32
> -        doc: u32 indexed by ipv6-devconf - 1 on output, on input it's a nest
> +        doc: u32 indexed by ipv6-devconf on output, input is not yet implemented
>         -
>           name: stats
>           type: binary
> 
> base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e

