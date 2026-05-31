Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6743161BE
	for <stable@vger.kernel.org>; Sun, 31 May 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257708; cv=none; b=AlNPwvcfIalkqdLb0JntaGokrct694HMMiJGTwmw5ABBNqZVM5gHdWEiT1SCl3K0qT4JS8vG72swLUaxVGnMm1p4UWgQYkuI1IgdSkjOAtaZxYsBk7c1f1lRDMmCTLQ/xOLwuvZnyC5w6uy9WVBu733Aaf66JfLFNptlps0wvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257708; c=relaxed/simple;
	bh=q28vvrdEPiKApq9SxP0QpNQPB9TQ84GLDcQHQxOK18A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umdrE/vpvNhc3JpViKVPbc/JVuSrFM7zThS5FuIMIIdpr3H3RSj3eoRH+5y4JgdHdPbtFjH9TGjYORSdVTdTE5cLN9rph7x5XcWPZMWmwcFvvBlFpf9kStJULqzDIhm90M+qlXmQH4aEVXPK/jhsnqZT0dWyB48XbN2aoLOtmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZYltk7Yi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oo6bgMkJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZYltk7Yi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oo6bgMkJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZYltk7Yi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oo6bgMkJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZYltk7Yi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oo6bgMkJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92FA3674E3;
	Sun, 31 May 2026 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780257699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2eHy+yLhrpbpMQLr6C2OcfliHr5ktRiooZtRZfHTn4=;
	b=ZYltk7YiSV7VEb7zsRW1W1Cp9G5d9LUitdcsGqgSbu4Ck82ZnA5ZSn2qMjYxQXU50UXGih
	HVQNz4BZQ4DD2RSo/MliD1bCDe94popFhOyywlB4OUz3P8rzzq5IBruiuhpKVgdLzFTiwa
	7tsBbclKo5WSVN3mcZaV0KuX4YvDnWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780257699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2eHy+yLhrpbpMQLr6C2OcfliHr5ktRiooZtRZfHTn4=;
	b=oo6bgMkJ2/iFj1VmNYjl+zk+0D77p4c9UQPBaXeNQ7mJa3DZCE5WBXl+3A/ZAcUYqFnvPR
	Io7mx03SeiDes5Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780257699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2eHy+yLhrpbpMQLr6C2OcfliHr5ktRiooZtRZfHTn4=;
	b=ZYltk7YiSV7VEb7zsRW1W1Cp9G5d9LUitdcsGqgSbu4Ck82ZnA5ZSn2qMjYxQXU50UXGih
	HVQNz4BZQ4DD2RSo/MliD1bCDe94popFhOyywlB4OUz3P8rzzq5IBruiuhpKVgdLzFTiwa
	7tsBbclKo5WSVN3mcZaV0KuX4YvDnWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780257699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2eHy+yLhrpbpMQLr6C2OcfliHr5ktRiooZtRZfHTn4=;
	b=oo6bgMkJ2/iFj1VmNYjl+zk+0D77p4c9UQPBaXeNQ7mJa3DZCE5WBXl+3A/ZAcUYqFnvPR
	Io7mx03SeiDes5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E10CB779A7;
	Sun, 31 May 2026 20:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BXH5M6KTHGr1SwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 31 May 2026 20:01:38 +0000
Message-ID: <2fbe241d-16bb-4d63-82e0-a44523de5ee7@suse.de>
Date: Sun, 31 May 2026 22:01:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hsr: broadcast netlink notifications in the device's
 net namespace
To: Maoyi Xie <maoyixie.tju@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jan Vaclav <jvaclav@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Taehee Yoo <ap420073@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
 <20260527075924.2707856-1-maoyixie.tju@gmail.com>
 <21df0b14-f530-4e9a-931a-21154ec18c78@suse.de>
 <20260527161849.738b7f1f@kernel.org>
 <CAHPEe=F+ii=GgNorkhYJYXZAa4akxjKxG+qFr_H-USQE1F8bRQ@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAHPEe=F+ii=GgNorkhYJYXZAa4akxjKxG+qFr_H-USQE1F8bRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]



On 5/31/26 12:23 PM, Maoyi Xie wrote:
> On Thu, 28 May 2026 07:18, Jakub Kicinski <kuba@kernel.org> wrote:
>> Not sure TBH, we'd need to take a ref on the netns and allocate
>> a tracker (on DEBUG kernels). One could go either way.
> 
> On the RCU side, you're right that moving the net out of the lock
> means taking a ref, and this isn't a hot path where that really pays
> off. So I'd lean towards keeping it as posted, with the multicast
> still inside the rcu_read_lock. Fernando, thanks for the suggestion
> either way.
> 

In such case:

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Keep it if re-posted to net-next please.

Thanks!

>> I'm replying because I wanted to question whether this is Fixes+stable@
>> worthy. Sending the notifications to the namespace where the device is
>> makes sense. But it's as much a behavior changes as it is a fix.
>> The commit in question was merged to 5.6, real users clearly don't care.
> 
> On the Fixes and stable tags, my thinking was that the init_net side
> is an information leak. A privileged listener there ends up seeing
> ring error and node down events from devices in other netns. The
> payload carries the peer MAC and the slave ifindex. That was my reason
> for tagging it.
> 
> But I see your point that it is as much a behavior change as a fix,
> and if nobody has hit it since 5.6, the risk is clearly low. I don't
> feel strongly here. If you'd rather take it as a plain net-next
> improvement without the two tags, that is completely fine by me and I
> will respin it that way.
> 
> Thanks,
> Maoyi

