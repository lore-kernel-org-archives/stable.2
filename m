Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1572BD59C;
	Tue,  1 Sep 2026 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261639; cv=none; b=r6Hpo7N8cKtncVs+YijkuU5DDjsT7ykDD5FgW3C/0W0FklOUNewN/h2LLXxbz3JBBvwsFsu465W5q4AWubHHLIY2xnB7lIEdZnghGHCer7f2RXlnZunen4DIyxEynHUULRJvJOfcg2hZZ3hOYzrvqQOgV+g/eg6eKG08LHD7gN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261639; c=relaxed/simple;
	bh=sffXTPFZSPpQoSn04HRQbUmu3lL5q5NbBIaiJ1ZCaNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkF+7ZLyH1vb4fzVg7TqtXr2XG9B8iHzWWmYsfgqJWbsH/x1lICUZrjhwG95MVduzwNu3r47iDNo1Twi151TvUnYE56b+ON2gQaMU/YwuaYgwosuRURt8AtwDVnw9sxsuMoQtcOWcExjrGIn2MEtcCkj4AZEKTkOCzyGYio0aHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hf9JCTT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zkQg0tRe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SuFh1Pts; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5DItYMz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hf9JCTT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zkQg0tRe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SuFh1Pts";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5DItYMz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2F1D227CB;
	Tue,  1 Sep 2026 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788261632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtmIS6tKOUtReXnNNwZiRzWq/ytmd8xb/oWQMHMDyns=;
	b=Hf9JCTT93OXZ/HovKvZqdSQw7UXfAczrJ5NzJ4Nb5pULOtabheIYIz82w+ZEnf0Heh8OwM
	xZfoIk09wPhZrg1K75BFjjwdpg1W0TjziytqfwJGJE3wjMmzU6UYknWes2uc1TH6n3O61l
	zwYHHn0xNUQ3+iRECnPtVXkP5szqtSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788261632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtmIS6tKOUtReXnNNwZiRzWq/ytmd8xb/oWQMHMDyns=;
	b=zkQg0tRepWOfUXvYBHKDCXc2/skaHZFhTBnMedBGerxmfPS7RQRKs9Z+Q5tUAMowqtdPkg
	ka/ICtz7b+/UMMAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SuFh1Pts;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f5DItYMz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788261628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtmIS6tKOUtReXnNNwZiRzWq/ytmd8xb/oWQMHMDyns=;
	b=SuFh1Ptsic8yo8W/kOkebiJXJ2QZjJPuBovoFvsmsaR049SriUVd5dTaHPvIvTBBJ9+VFC
	YDlyFdorW6hu7MQSBhamlavB4MIXJaSeITu8FaF5mDMhxxA8nRdSvygNuzT4b/yVghgCHF
	AL8g1FPMh9UqiTw61NlynPnxO/YRCNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788261628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtmIS6tKOUtReXnNNwZiRzWq/ytmd8xb/oWQMHMDyns=;
	b=f5DItYMzVlrpMd30KvSv3Iz1t3rV/iQZ+ZXZRCuAlHHYTq9ddwVZWM+GcEVCa9b7COk7uH
	Bj4doxnEL/gPWADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B1471369E;
	Tue,  1 Sep 2026 11:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FE5vFPu0lmo6MwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 01 Sep 2026 11:20:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: zihanx@nebusec.ai
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	idosch@nvidia.com,
	kaber@trash.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH net v3 1/1] ipv4: fib: bound automatic table ID allocation
Date: Tue,  1 Sep 2026 13:20:25 +0200
Message-ID: <20260901112025.855917-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6f2f2a7a136aee005512a2e1ac8ede62ac8c7bb6.1788258884.git.zihanx@nebusec.ai>
References: <6f2f2a7a136aee005512a2e1ac8ede62ac8c7bb6.1788258884.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F2F1D227CB
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

> diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
> index 4edb0dca7be8..060501b376a8 100644
> --- a/net/ipv4/fib_rules.c
> +++ b/net/ipv4/fib_rules.c
> @@ -214,6 +214,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
>  	return 1;
>  }
>  
> +#define FIB_MAX_AUTO_TABLE_ID  4096
> +
>  static struct fib_table *fib_empty_table(struct net *net)
>  {
>  	u32 id = 1;
> @@ -222,7 +224,7 @@ static struct fib_table *fib_empty_table(struct net *net)
>  		if (!fib_get_table(net, id))
>  			return fib_new_table(net, id);
>  
> -		if (id++ == RT_TABLE_MAX)
> +		if (id++ == FIB_MAX_AUTO_TABLE_ID)
>  			break;
>  	}
>  	return NULL;

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
