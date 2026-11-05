Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852126;
	b=Po+x0q8JfmsY7F9BeVaZJ1rpVH9bljQ3mEZhCnqpeqrU8AAC1AMvJH9HUeUR8qXtLY7n
	 6T0VK9Gmg5jjqwyQsl90VhX4RDpSabWIEYhQcTsD1+bvjUs0JSxYt15C9F4jRglG1id+B
	 GmnW+0gKNbnuegYP3sTdpb1UXvV29+zIv/QvDI+omqWvhhY8RvJDAA/3gNCTdueVywh+J
	 I/ZIjqvQvHH3MFbAZHjAJNlbglfjWUWjU1KwsfZJgLak+eGDLdnqSSw1QCm+CYe8O2kDF
	 BhOQJBmvpIZCGZNFHw5zCp6fEE6MJss9iYwpcV0LzIGNuMrbQTU1W4p1PlmaRvkohaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=v/dD+gCFKnFrY8PCehbOuNAzOY6DsEVbOoYKofj71BM=;
	b=YyN2VoXr4w+VG0p2D2ZGHFDED3TFhf6UR7Y+s8SFDweRKjN6gz3wveiLTcX4yKAQoQGu
	 gu+Bh6VAppjXp45oMjrkGYgR5DmkBxmX7mkceqpgMt7femOC2b6PmqzkI9Mdfrvw0nSPZ
	 XbBsh1nhd9kdZ0Mxx3rBLR4G5O+SMlFXPHXuBbAfm72bmegoQ14CqI/NLyJt01hNrW1SO
	 2QicCvzzCilEiCEvRgR2Fz08eytQQCMwbkNy5mYUdPbD7V+v1njgfsZl31EI1ULKYPrXS
	 pMxyipLA6j03iL9EHs2xrC6CHbpCeK8E/I9NgvfvTS8v5w/LnXyQatRsTVYYN/gUKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KJOhIdc;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D0606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742D0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KJOhIdc
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1103496a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793852126; x=1794456926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/dD+gCFKnFrY8PCehbOuNAzOY6DsEVbOoYKofj71BM=;
        b=0KJOhIdcNUHNh+hpMXflfbO1b2pSAtdJ4Yxe1HdD3RiIbZgv5eF9L95iNtGkRefRG+
         xhRfJsG7UPsTxI8aOUc6LjGjNi8dWWq1jJKUb8Bq+QbuLWVuvv3SrTPVVvsxPoqW1gf7
         rU4v3DCJ/luDVStaJHpRseR0cz4KnSX5ZoZYw8CwZJO6vAIKVaLfZti006GIcsBJjt/4
         jxigIcNr5xPTDyPadQQIDWPkzDfAImALT6hkCPegisUNo4pWSqdSREZ2pHjH3DEAmLcr
         it7bazSZqAVe9TWf4VDdAusFcpyIvb7/vdUTTKOphfMTEENlLWyq4UVd0crxlBGA8mOI
         9lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852126; x=1794456926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v/dD+gCFKnFrY8PCehbOuNAzOY6DsEVbOoYKofj71BM=;
        b=hUxEvc36LDvLgs8yGUrqlbuZza6aE5z1fkX/h7AlS3xklV1DeYvMpoQEygue9uvCCj
         xbMgVs6/P0GE6KaIfwspoNWpc2Pbl5dOpFSWFw4ijbpNVW/gGVjg79omX07TL6pzNsN1
         Zrk2pkm4OG398k20rZLZEGCnMLjHgVPv7n993jnMkPwWwe+kqatqPcK7EITIavyNf3Ga
         2knh3TI6K8ouwOUiiMYMf3uKxy0eTu/v8Ew/oMhqOERhxdGFOvyXn08djcB/uNQ848CB
         akhOn2Ys50olA2IW8rZcwmIba4aL8daXAHIw2/bsI6Raa6ILcJ7+dmu9xEloT/SsVAqh
         yK3g==
X-Forwarded-Encrypted: i=1; AKwUvBxUAMmIqLyJEXTUNzel3P5/m/qJPRZgwRY7gsTEg7XYqvWyywNSIhM4dZkEWXWWT+UiIjRIKKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cGZJIqY5MOQaqVkl5pjuPxfk1Gctvsz/oqLvvfGWnYl2d7wZ0
	gnnyXWxMAFprzMzG0D3IxaA2xmbPMu4gPwzwpTIleOvvsPsdNPgbnfq+
X-Gm-Gg: AYBFou0ESqClcWO5+yX5SCR9SP4eeyA8/e5reBLWmmufKv4xxiUCMh4OEFEOPg8Qpfd
	fKbV7RLTJXdR01T8gSljFkYA8ydngY0GZq53/ZXeUn8nVTMliWTkZlSxWiz9dRlT3vxIXdss7B6
	TtTeHjoJW5OYkL6d6yAxoZJZ4K9Y391BrprWHu6X9eE+AANO2B5jrkWfeFvMoJ+5i+zpbobREgA
	tOxAEOUuaU35EbV3BJiBe61BbgFroTm16J4E4113jInAnQXh0R5HKuAs2a4rg/Dsd28wmQp58Xq
	Txg+jAmVV0dIZTzVuhVZhaXsoLWOgCBKTMBSp2n62ZbZDT2bC17LtfwT7IfknsCFi81KQ3u3caW
	CcvJkXyyFg0BArYuKsJMXvAVl14Ga2fvyc1qfskEomX+0a08ANRCfcI6vopOkAYZAbnJPMqTAo5
	tFG9b05+FMLvk/M5MHhkB2DWsQ9CU4AU1Ghd7fmIQC+gUjOlDF0uZWd4krpS3wgMCeyn26v3Oza
	0MLzWLT33wnu1z+gOea+fJK6nJtAn92c6KK/sxdCpBLlgTgUSSK4pSRgLMAHvyMHdARsNrkivHF
	F9axPD+G5GKkWFL9x33RDHptJ7OjMF6WnqbzEVae/jk2DtqXGSNTUchbkf+uMfJ+7owl
X-Received: by 2002:a17:90b:280c:b0:3ac:9669:846b with SMTP id 98e67ed59e1d1-3ae895746f6mr15584115a91.9.1793852125571;
        Wed, 04 Nov 2026 20:15:25 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3163383sm1625591a91.7.2026.11.04.20.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:15:24 -0800 (PST)
Date: Thu, 5 Nov 2026 13:15:19 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, ncardwell@google.com,
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com,
	weiwan@google.com, sd@queasysnail.net, jiayuan.chen@linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
Message-ID: <auwC161B4g61ptG4@v4bel>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
 <20261029214219.1035176-3-imv4bel@gmail.com>
 <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
 <auqJOj7RVCWn7Ucl@v4bel>
 <7f8bd24d-7538-423d-b2a9-f5b0eae99d41@redhat.com>
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
In-Reply-To: <7f8bd24d-7538-423d-b2a9-f5b0eae99d41@redhat.com>

On Wed, Nov 04, 2026 at 08:59:50AM +0100, Paolo Abeni wrote:
> On 11/4/26 02:24, Hyunwoo Kim wrote:
> > On Tue, Nov 03, 2026 at 03:49:40PM +0100, Eric Dumazet wrote:
> > > Le jeu. 29 oct. 2026 à 22:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> > > > 
> > > > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > > > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > > > atomic_add_unless(), which provided full memory ordering on success. The
> > > > commit removed that ordering on weakly ordered architectures, allowing
> > > > accesses after a successful reference acquisition to be reordered before
> > > > it.
> > > > 
> > > > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > > > lookups and in inet_twsk_purge(), where the socket is validated again
> > > > after taking a reference.
> > > > 
> > > > bpf_sk_assign() can receive a socket pointer obtained through BTF
> > > > without a reference. Use acquire ordering when it takes its own reference
> > > > for a refcounted socket.
> > > > 
> > > > Use refcount_set_release() when setting refcounts in the SYN cookie,
> > > > TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> > > > TIME_WAIT smp_wmb(), which separately orders the refcount store before
> > > > ehash publication.
> > > > 
> > > > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > > > Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > > ---
> > > 
> > > Lack of links to prior versions is rather annoying.
> > 
> > Is the cover letter alone insufficient?
> > 
> > Should the changelog be in each patch?
> 
> Ideally the cover letter should include a very quick/short overview of the
> changes, and a per patch changelog should include a more detailed list
> (no entry added when the patch is unmodified).

Understood. I'll do that from now on.


Best regards,
Hyunwoo Kim
