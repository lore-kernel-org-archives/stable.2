Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B64156C6;
	Mon, 24 Aug 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574456; cv=none; b=jKYWNVJeNtpDSYQVR5DsDiM7OJ+YT/yyp2s3cmP5EmtN7CgXovd1dqHLrg4Cb4iNSTnOZTvuxm90bSkd85KlBgiTiKSiR5Wycu8rsFSwBZ6W3nFFCqtdbZbn2NgEDPlvjYszYapq1hCh00GfjXmuWQDR58bt2ICYDPtYky9HC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574456; c=relaxed/simple;
	bh=4txqTH0l5Wo4GujP7am3e1PJUprrwhWcfRAEUI1s2rw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LZh8Q4olyrzQXGwvlsot1yP2VC/pIfl1sMnvnK/MPqo8BOmpPJi9NWMlj891HLPSZSk7mq8WSom6dxrVYXl1Yg9VoIoq1WEvkKH1EZSC5k20uklcgbG0a84b+i0ifEZ+ODj1QiLqt/tVR0dskHPrpxpUkpBww93eakqT60J55M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cz3LPYS/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sH+9zCrJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WbTw2fdx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1UD1K44k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cz3LPYS/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sH+9zCrJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WbTw2fdx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1UD1K44k"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6A24E1F45F;
	Mon, 24 Aug 2026 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787574448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc/x1rdloXuC7dC57Av3Q7J3rtkSe30s8O/AlNDAFg=;
	b=Cz3LPYS/hTh9wJv5dmx8YNw4Y+pE8y455ihDZZBXbzrZ6wZo+d1gXZ/N2cIG71Z6P1HnKN
	mTL28UMRegSA2vHKrpbynAny7UGBpNl6JLFG67wIAmdSQd93+EsshOsCL4RVvptTJYglIX
	KvvFcR+yiVhDsubPs9Mt2kAxvt2bR7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787574448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc/x1rdloXuC7dC57Av3Q7J3rtkSe30s8O/AlNDAFg=;
	b=sH+9zCrJl170EN6he4XlJnFESe3Fm7VZ154Q/kgyI0MjRMNkh0i0hI3Mi9JfmHtGjGA5ft
	GChiD1zOOWohEgBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WbTw2fdx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1UD1K44k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787574444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc/x1rdloXuC7dC57Av3Q7J3rtkSe30s8O/AlNDAFg=;
	b=WbTw2fdxTm86F9SoLTPl9DnMk4ULh7ZKqOVhLkyvfhw5Q3IM15AuHG33aW3mkTALeyWtfN
	/Ns9VnAsJD++KGBGct/oyTAzIBtHJQt2kIQAW5smnTsb6Gr0YxaTpM2UK1wleTpTI5zlJ1
	0DoKTVumpLRiS4qCOmBmY6HOdH+tGUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787574444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc/x1rdloXuC7dC57Av3Q7J3rtkSe30s8O/AlNDAFg=;
	b=1UD1K44koEAJ8owi1Xp0Yp1EOOhzPIb9q1D9Fqma0FPGLEovKaYHX0S5kEQkjckmGZARbi
	JJcLabiDtd4F6ICg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
From: Miroslav Benes <mbenes@suse.cz>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org, 
 mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com, 
 mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org, 
 linux-open-source@crowdstrike.com
In-Reply-To: <CAOu3gNhgRTh8uZdfNf+XBpYuJWAFu5i+UNjQC2jce4DdRc-bGg@mail.gmail.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
 <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
 <CAOu3gNhgRTh8uZdfNf+XBpYuJWAFu5i+UNjQC2jce4DdRc-bGg@mail.gmail.com>
Date: Mon, 24 Aug 2026 14:27:21 +0200
Message-Id: <178757444126.29054.5684338666506602450.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=4txqTH0l5Wo4GujP7am3e1PJUprrwhWcfRAEUI1s2rw=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqwei5WvnB5uj5xa+XbSCZlfgas1Djn2fej6LN/87IPGj
 S1fGef5dzL6szAwcjBYiimyvN7rLGc4JddAs/rdXZhBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 zxDI0DFi4OIUgKkO1mH/7872nkNxb3aY3rq1MXkn3R7KVz2VX5/CYvlI5JWK0f0JErJJppKb1/Z
 VOWnkTLayan389HuGse3vXVobP+ilWQbdmSHNxV17O3qPxYTu6oWLjrS0hYfvZDP2nNzQ2ZP9K3
 aVf9vTB5X6Z08rzcv64/GveqO8rlWdtUNtEXP1VycLCea03Y+2XXkfq/F4u4j6/Q/LXx/IY626+
 q1pDkvtr8nxBleWPdy97/ovvjmfXRYtX/G2P6TT9FaHUU1G3/x3riEcarKBAhZW70J+LivbqsZ/
 68rsvyFCVXfKb+ncZzdes3jC4qNlQZxa8gFsi3XFk75qLVO/eG3OsZK49dVsV9YFzXS/FG2zrOT
 wj2NOAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [17.38 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.99)[0.997];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCVD_COUNT_ZERO(0.00)[0];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 6A24E1F45F
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 17.38
X-Spam-Level: *****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam: Yes

On 2026-08-09 14:32:16-04:00, Andrey Grodzovsky wrote:
> On Thu, Aug 6, 2026 at 5:52 PM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> 
> > On Thu, Aug 6, 2026 at 5:22 PM Song Liu <song@kernel.org> wrote:
> >
> > The bot has 2 comments.
> >
> > In my opinion, the test-breaking comment is wrong as he looked
> > strictly at this patch w/o reviewing the follow-up live patch testing
> > changes which update the tests to avoid breaks.
> >
> > The cleanup comment is valid but since we aren't sure if we'll need to
> > revert this change later if it breaks userspace in some unseen way, I
> > wonder how extensive the cleanup should be? Steven, can you advise
> > please ?
> >
> > Andrey
> 
> Gentle ping on this question above Steven.

I am not Steven but I think we should wait with the cleanup exactly
due to a possible revert. The same as for PERMANENT flag we talked about
elsewhere.

