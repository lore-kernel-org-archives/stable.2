Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794855366;
	b=EwCICwh9tlk9aTig2OXHNkgq8sGT1AgiecHBrWdVQLPz2bFy17OCVH1E3Lf3sbBgW2cE
	 XSISSnJ2qaQM0nSRPbrOYzqs4PFdczbgR2Q0oF4H+XVVO08DmekF25Xrhds4Yu5xLrXw7
	 WaaT1KLj+l8bt51C/KtFYxRPVokfPQn13iY8lH6epGC+UDToGNgnYvQvB5WKP2O/2ANzD
	 aR0JyXCCY4s8OLiWWBu6RmfIFRHc8aqjeMgIR6UUDZCkLDJ7QyY5CKD31WWOdrwB73Crc
	 TEU6bcrLOqRISuwO22X6KvNooMsG+cQlvuR6KJ6WwzdPPgSGYE2bQAbga9Xa+aKQsNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pJ3VePYLXSQe6BrY0Rbuq9cNJKXVi3VErXRi88A5vGY=;
	b=MWbiTYBlmZBNPnDiAjQX6nhiD385nPkGH/va0S1OVgMu6CtRI6fz6Xn1RGwmkKusxc9t
	 dMpjij0leeEUKkaBlML8NcLZE8lSoIPX0i4niSJC2fQrecapB7MKIUucdA6aQg1H5rKK2
	 KsgnlmtZ0cH4HGB0uRlyEg8g1I7swelxQxBrg6GjWXxebvQh1vzBV7h9ZPsVNvw5rq1GL
	 vkzzCdqin7ugvkS2ZHrP3L+aSu+L9CJtGDjE01zYO54WKWndbAeZTZZE+knuINAasccBZ
	 fCv7x2IviV+TImz5gLB/XPGMUHtyqhnAjltwQrq61V/BgnWIrfsacBKwtzbWUpvD/wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=f4j2uwvJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFD606A893
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFFD606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=f4j2uwvJ
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so1048826e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794855364; cv=none;
        d=google.com; s=arc-20260327;
        b=T8P9sY29gxYqFxUX0v9QP2HAidmfW1+Cg80AYUQxHUmDYqEgl4H6/catk9LRMH8v0T
         N/1xsxxbnxSNuhbqksqE0xPbuMd8KJeJqSpiqrUV+SV82T8grCWD47Gz+RHdOeGoitXd
         LvA8JPp7+KqaOn1NkkCUU71OiHyGHlGKwkLYSTOGygYI0C5xjHRHbknk1/kiKn1ax9ZW
         sbqboKEKql3B0gp8aKvU13/PxuTOQQgAh8ZWyFjYccseAJC+M9g5uSMLsehnqAGzShgG
         qRK6zbiXhsAGlHgmgxip1C8TvHcPBsS6P7Qc9LvgOVWw3OfkNNKJ4sctGA0kBkKefoFc
         z9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pJ3VePYLXSQe6BrY0Rbuq9cNJKXVi3VErXRi88A5vGY=;
        fh=Rm1Gg0tuOcUJKEACx6xADc6gchwWnCSLSDENioFEJOU=;
        b=HpUgcyifWO1V9s9GnUjApU5b5Gmo615B/U3qLFR8PbdBEOyX4YVJgQld3G631ovpsh
         1tVbY3Za4ILMiMZb0IBh/Zc46rRp/BoiPvnz4rGO2iIVChO6FUy4C77xK52EPIX8rVcT
         85q2dEXGTO2Mlnwmf58agrKC2BKpi0HZlxFCQySrRUBmpNvw0/RsLkKs9Zz6x5tNeNKh
         88MBZrHaDogXEshy0iRs8MI7sEv0JWLr5lOagxAmCo2hW2eeFt5dqTRBp4M/Nqx5sIZ8
         jX3Q86/AXWrHN7MiOC2qAMsW6ejHwd0kOHAZjVVlak2/XysJlwYl7BmurZTtD8c7ShPv
         hb+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794855364; x=1795460164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pJ3VePYLXSQe6BrY0Rbuq9cNJKXVi3VErXRi88A5vGY=;
        b=f4j2uwvJ+lHyrTAK7E5Dtl+M5bvamBrr6tzEfQoknmihhN2xaDOFSeiFQC7EokOwp9
         FkbrM0aMK7Smc4PSIjTgdcY8BHaxQ9mPWaS1UpPgIoSfLWYHXfhpCxX4eTSZNcmr5OTX
         o7cNGzWKceJXCB1lcrkgJs0NokQ3DC4lK2Txcbw7nVY0k8FUEDlWkVtXA0GpvFd+0xMg
         iHLiy63ly8w3NByFVDUXRalIbK4skjf70Mrr3u6qupmTZx6mxSuWIuwiyWzMyhnhQ4hh
         eaBj7LQV6a0E/pELWEaHa/PlhMPXLKUjdX34CtmYWWpn8c3dl15vksdun+k2C03nAQA4
         mi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855364; x=1795460164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJ3VePYLXSQe6BrY0Rbuq9cNJKXVi3VErXRi88A5vGY=;
        b=UZZf5gMWceEu2QI0ZubdtJQyYSVS4H1BR3qeouIXO/h6Hvaesc3BdWJarj8rIbxM3I
         wO7OhRw6c5TreIevEWDVfbvfExL5KXRYCzhPLSfUDPTRSeqlzddgMqMRSj7xkCK33aKg
         PF64wrDJgrie+fJyyyHMjDixFUs5Hk6AeXFjPVy+yebXm4Re0DAJdhV6aKacO69h/mqH
         CRraFvF146DFmNbPHuRHzciW3kwxQUOWHR+m9eHpnwtku6NXX4XE/xnSJaKg1u4RTv5N
         TueO5tHP6XYFQANSXQrkvW7lozd1lPXI3rRayZZ5QDVBUemEY6v/0k71GrfnYFP37J68
         e3Og==
X-Forwarded-Encrypted: i=1; AL+hErF6xGu3brtXcG1SJs4ASyKU/WpgEDK0RPX9ozkAObMzARQGLyUizO3osMRkfAbMglaVSzFcP/Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dWW3pJLiX7dlAFOEloR4HoddAIWihsCTn6oj9op5A9M3r8dM2
	sz+9/uylLZQcrLZwjSkWlwF1eHR27vJZ/9/Hj76H8zDAHaEi8TJIb3KHa3R5ujLo5cU71SG9u0g
	YiSSRIhmXWOnNeSuEB1Sii3WbASra70SEPhDFoCsgTQ==
X-Gm-Gg: AZFdTZcpt0biOhNOJ0ZuUWQrb4bdkHOLi/eHYyABaAX/KnTAMA6P7JDuWMloH7kzzu1
	gSXjgRdI3xcQksPdhm0qdLfd5/uGn1RsgU4vMOa1zNfAua0j2UJS1fihkLVfoCchiddCTQOxXrQ
	2XRR7g23gtcpLPYh4AL1DCxghO7m3xHRKhUJgIy3MenuPO1NtkGs7IwV6Th5eDgKisbG+Gj5zq0
	eOHB/Deo69PMl3nwiNjFbJHL5GMNxBOwhW95p7WD/6LBIuRzcfA2l1lLLMrdgh1ZMQ3FmIgk11Q
	HP0KC9+D7Cc5lyRc9dnujrwjhR1AqfT5PWTlACScKAEs84i0O7YiJnAuOYxRLz42KLsyGoiY8v8
	vW7l5DRrJjbJYLfLf2WteOpxM27xbtrIn/EAE0RVjxG8a/wHJAdQOH1554wC2qBO7pVkChL0RI6
	sqKlZNMYcQuZgyJKuZv7gwoYrO4yF0neGZLI20YEUKL1IykatR5lvMIMh+/oRJZ1CkjeIiGaa8p
	e9Wwd62kP228LuEFG3AI+v1iw==
X-Received: by 2002:a05:6122:4215:b0:5ec:3e18:a912 with SMTP id
 71dfb90a1353d-5ee34a968e1mr3829197e0c.14.1794855364480; Mon, 16 Nov 2026
 10:56:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112232444.2865382-1-rjethwani@purestorage.com> <179461232334.2199510.12258955725199996955@kernel.org>
In-Reply-To: <179461232334.2199510.12258955725199996955@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 16 Nov 2026 10:55:53 -0800
X-Gm-Features: AclHuK9aI72Wzc15wwlEEJSue0Lw3dqJipNrakxflrQi_c6kzLHMREGXD0OoOA4
Message-ID: <CAKaoeS2yeZ3WciKNtdp8ee+n+v+xc4+QAcwZU3-fzG6J28-5dw@mail.gmail.com>
Subject: Re: [PATCH net v7] kcm: reject TLS on attached TCP sockets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, sagi@grimberg.me, hare@suse.de, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:25=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The Fixes: tag covers only one of the two defects the commit
>   message says it fixes.
>
> --
>
> kcm: reject TLS on attached TCP sockets
>
> This patch makes kcm_attach() reject TCP sockets that already have a ULP
> installed. It also makes tls_init() reject sockets attached to KCM, using
> a new kcm_attached flag in tcp_sock. The kcm_attach() type check now uses
> sk_is_tcp(), so raw sockets created with IPPROTO_TCP are rejected.
>
> Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55=
@linux.dev/
>
> > KCM calls read_sock() from its receive callback in atomic context. With
> > kTLS RX, this reaches tls_sw_read_sock(), which can sleep. KCM and TLS
> > also replace socket callbacks, so detaching KCM can discard TLS handler=
s.
>
> [ ... ]
>
> > Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> > Cc: <stable@vger.kernel.org> # see backport requirement above
>
> [Severity: Medium]
>
> Does the Fixes: tag cover both of the problems described above?
>
> 662fbcec32f4 added tls_sw_read_sock() as the read_sock op, which explains
> the sleep in atomic context. The callback replacement problem looks older=
.
> In the parent of 662fbcec32f4, neither kcm_attach() nor tls_init() checke=
d
> for the other, so the two could already be stacked.
>
> If KCM is attached first and TLS_RX is enabled afterwards,
> tls_sw_strparser_arm() saves psock_data_ready and installs tls_data_ready=
:
>
> net/tls/tls_sw.c:tls_sw_strparser_arm() {
>     ...
>         rx_ctx->saved_data_ready =3D sk->sk_data_ready;
>         sk->sk_data_ready =3D tls_data_ready;
>     ...
> }
>
> On SIOCKCMUNATTACH, kcm_unattach() then writes the pre-KCM callback back
> over tls_data_ready:
>
> net/kcm/kcmsock.c:kcm_unattach() {
>     ...
>         WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
>     ...
> }
>
> After that, TLS RX is no longer notified.
>
> Before 662fbcec32f4 the TLS_SW proto_ops also inherited read_sock from
> inet_stream_ops. So in either order, strp_read_sock() would call
> tcp_read_sock(). KCM's strparser would then take raw TLS ciphertext from
> the same receive queue that TLS parses.
>
> This seems to go back to c46234ebb4d1 ("tls: RX path for ktls"). Stable
> selection uses the Fixes: commit. Would LTS trees without 662fbcec32f4
> (6.1, and 5.15/5.10 while they are still maintained) skip this patch? On
> those trees an unprivileged user could still stack KCM and kTLS RX.
>
> Could the Fixes: tag point at c46234ebb4d1, or could the Cc: stable note
> say whether pre-6.6 trees are affected? Right now the note only mentions
> the 8cc3aef0cb198 dependency.

Agreed, both problems predate 662fbcec32f4. Before that commit,
kcm_attach() only
checked sk_user_data, tls_init() only checked the socket state, and the TLS=
_SW
proto_ops inherited tcp_read_sock() from inet_stream_ops. v2 changes the ta=
g to
Fixes: c46234ebb4d1 ("tls: RX path for ktls") so pre-6.6 LTS trees
pick it up, and
the commit message now describes the callback clobbering and the shared-que=
ue
reads. The stable note still flags the 8cc3aef0cb198 requirement for
older trees.

pw-bot: cr

> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261112232444.2865382-1-rjethwani%40purestorage.com
