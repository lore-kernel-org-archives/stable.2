Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992458;
	b=W013Jjxv8tkgrDpCCy5g12L2hJi5BpEvTYBeYtrtomfiE/sSai4u3slAOFoHgP4Y75K4
	 2yNil1OXID6fH8l1VtCmjewdze9S78uiK6cpoZi4LatQFOCj9eqmsKbVLtGv4BYj/XPcP
	 AgJgeySi1llQ+O7KqqCkoZWlQCwFgeTVeBqLbVVsqEEGpTyzJNz017VUpu6RjjChn0ZKK
	 MWxikg8EyWVmCR0dzbf1kWN4TV4R9gEdwKkFCzuoM8esexZKgL0bcMqO/lecizs2APcyR
	 qp38mCBWsI0hL2tdmaVoJRWM4jcjkroEzU7ZdN/0kv9oUTVc8SMxXbZXp64yNdTMi0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RCGPlQz9/nbP749pKlUHj7iqUI3R/GYuLrhh68VMhX4=;
	b=jX40e+5OqXPCo/91YBaTtoWDl30DAPhDNdBnN4XvWRrkxOyThc8sJ0eK1l0OaDQpO7NG
	 AZlSxOSXQlmKJsdEgKHVc7WJ/wAIurefvBSVS1Dmj1i+UhvctQx+tAQeB/DDtTlCODFNo
	 g2VnZx08k3yN0QOIXzkMTzfTfHwqR8lKEO9B2EskImg9XIfj5lc8+shkzG5iXwhoa7x8Z
	 qwYfcYbk8RfVOwE5dSXZbFg4GxlK1dsfsBVlD/UDkuSWEXAXs7dBhe5gtK3hirvJ15hTH
	 uJBDDl6LDE9HIyrQ3xc/VOHnTZaU+GdhfYa/T9XouWfX8o4D4h3nF6cQA9sHu+F0koQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=azji0Yvb;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86E606A320
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F86E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=azji0Yvb
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so3200781c88.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792992457; x=1793597257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCGPlQz9/nbP749pKlUHj7iqUI3R/GYuLrhh68VMhX4=;
        b=azji0YvbQpXonPfhYaQOd4vN8DayEMzg6nrWZ+k9qUgnGH+Qty9ZoVl2H1T0DpoB2Y
         S6PuW3zslfumGLO5cOFGQXqvB6FlhXNk1x3xWJzy9jzfdAYMeGnxpgXkO+CHEFl6ILHf
         CSe5/3oPDppMSzPeO+hbvs3/kG6jBs3+IA3yc65Vo3LWxwbW6oT0qRXAY3cp/bJesXIh
         9qjma+u8mCKxWUdvJR4ixY6vkgsuUSn/3KJHzOnsY+TMu7akbq7B+spnmniyndnMOXfs
         Or0qSgsY25u8uz1rqn7FjFgUDPMKRFbovrmNX3RwS6i4cze+wwfJ7njGnbzAQbv4UYjU
         UMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992457; x=1793597257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RCGPlQz9/nbP749pKlUHj7iqUI3R/GYuLrhh68VMhX4=;
        b=2IYpuFIvNqPZb5NuY26ntf7knZhR/v7xn+MBu/XdHY8pnhb/5fN78+ZLdwj0PrQM2c
         zFc3bqSyJ2/ZW+8mwBHkVrvsvwsG8keOSmMZImGA9N8xI5NKJe7zxgLa0QFaMBeeLHs0
         FS9ZnybcP9uGucGUCzJvTc/trW0AgSunQPJvm7vh2rnlp1bW9iP5XcIVyobPp8OHyIBQ
         Ot/vZdNOiap82LHpSfWr96/ih5QazDZ3c1SMtKKetvUu6MbDIuOm5GmpdjYfRbOrtJOI
         N6G61sRm6rIgCpfCTVk6Ua5VN7YC44/odehtu1tnn8hU36sagtf/Y8HhI4aKNHyDxfyW
         Ag1g==
X-Forwarded-Encrypted: i=1; AKwUvBwki8YQVXVVA9A2uJOVsDK8ggQU7grd51Ab8Scg1YB1IoooR42CKnFP6fHSrBbUaSAQJlVwfiU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIod30TGXx1hNIdQB2sxwDnlNttCoqyA+5w1vLVShv6TC9Fbt0A
	3XrndhNuXPH7X0WMF6/Paz/lw6LI+7niAZi7+kd7ZZtm5N8O9hD0caR8Rwlnw+vcJbc=
X-Gm-Gg: AYBFou2JQ0pvgB2R3t7bTlFo6jvGCz9KqYQWZAf8W+8DQRnjSFX0LyhIZRQEzH0403+
	6ffW4RjwLtTbxyeZQXHkDNL6HABTQQNRkr5wpC/HIOBVBnJ72mPDTHWCPKysQMpYORRXiZB+Anp
	Zl3Pc9S4hz4K/xPsVinsTFRTwWLUg7NgDHGMOngfMVMT/6PJVp0b++L2P1SdflM7BI1FoWAfdUy
	ZOMpHAP9NOnWOKlf6pgE+6OorQ8TKruSomh47lrUHfHbDJ98OUPpE6o7Xvgbbk+o+2TXW8znlyO
	Whf2eAvhZlnm5gUyibEDGDURQlWAPk/vwbr20MerP+OCBvO6C3yyBQQB1udi5Xt4aSCBgXh5NGQ
	FNVDhuFXLe0jiIrmUYu0c5oPV+EdKz+sRBRtS9Vq2u4KUDXo+zBCrXXw3o3y8IC4QkRHvmmKo8s
	l2M/3YmVUKNEtfFxtZoZGLUoaC+ICL8usVJ1JKRXYWG8+77MnvEtt/zPeQjKvtoKCpdwO0jo0LC
	LpOpKLskF6UgjWsmNvdxkudQFgf0PfibajWFxmWdyL4ek55j7m/z1SR7TfQV9wkOgxVJazB2OG4
	vJyXRZVxMCPF0cRiFVpACKBiDg==
X-Received: by 2002:a05:7022:3b8a:b0:166:f097:6f12 with SMTP id a92af1059eb24-19934a9278cmr9164130c88.15.1792992457049;
        Sun, 25 Oct 2026 22:27:37 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm21437866c88.15.2026.10.25.22.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:27:36 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/4] sctp: purge abandoned I-DATA fragments by stream and MID, not by TSN
Date: Sun, 25 Oct 2026 22:27:05 -0700
Message-Id: <20261026052706.187296-1-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179293012722.3134.13316596865856977030@kernel.org>
References: <20261024120627.837568-2-tim.budding@gmail.com> <179293012722.3134.13316596865856977030@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 12:08:47 +0000, netdev-bot+sashiko@kernel.org wrote:
> > +		if (event->stream < sid)
> > +			continue;
>
> [Severity: Low]
> Each call to sctp_intl_reasm_flush_mid() starts at the head of the queue.

[...]

Agreed. Walking each queue once per I-FORWARD-TSN would be a separate
change. I could send that to net-next.

> > -	/* purge the fragmentation queue */
> > -	sctp_intl_reasm_flushtsn(ulpq, ftsn);
>
> [Severity: Medium]
> With the TSN-based purge removed, what frees an unordered fragment of an
> abandoned message that arrives after the I-FORWARD-TSN naming that
> message has been processed?

[...]

> Should the commit message also mention the lost rwnd and receive buffer
> space? Alternatively, could these fragments be dropped when they arrive,
> or when the cumulative TSN moves past them?

Correct, and the commit message is wrong to say such fragments stay
until the association is freed. An unordered fragment of an abandoned
message that first arrives after the last I-FORWARD-TSN naming that
message, with a TSN above the cumulative TSN, can't be reassembled. It
keeps its rwnd and receive buffer charge until a later unordered skip
on that stream with the same or a higher MID, a reset, or teardown. At
the tail of reasm_uo it also stops reneging, as any fragment below the
cumulative TSN already can.

One late fragment is enough if nothing after it has arrived: the
receiver then delays its SACK for the I-FORWARD-TSN, the fragment fills
the gap within that delay, and the sender never names the message
again. With the last fragment of an abandoned three-fragment message
arriving in that window, that fragment stays queued (RX_QUEUE 1232). A
duplicate can't do it, as the TSN map drops the second copy.

Before this patch a later I-FORWARD-TSN covering its TSN would have
freed it, so if another message is abandoned later, this patch keeps
it longer. Without such a later I-FORWARD-TSN, this patch frees more
than before: in the same test, the TSN-based purge leaves the
message's received fragments above the New Cumulative TSN queued
(RX_QUEUE 2464 without the delay), and this patch frees all but the
late one.

For an ordered message the same late fragment aborts the association
instead: its MID is below the next expected one, so
sctp_validate_idata() fails. That happens on net today as well. I
could look at it separately.

Freeing fragments once the cumulative TSN moves past them doesn't work
with interleaving: a live unordered message can have fragments below
the cumulative TSN, and freeing those is the loss this patch fixes.
Dropping late fragments on arrival needs new per-stream state, the
highest skipped unordered MID, which must be cleared on resets and must
not go stale when MIDs wrap. I'd rather do that in a separate patch
than grow this fix (question at the end). Either way, v2 will spell out
the cost in the commit message.

> >  	/* abort only when it's for all data */
> >  	if (ftsn == sctp_tsnmap_get_max_tsn_seen(&ulpq->asoc->peer.tsn_map))
> >  		sctp_intl_abort_pd(ulpq, GFP_ATOMIC);
>
> [Severity: High]
> Can this branch still flush the whole ulpq for an ordinary I-FORWARD-TSN?

[...]

> A later patch in this series, "sctp: don't treat an I-FORWARD-TSN as an
> association reset", seems to address this. It drops the max_tsn_seen
> check from sctp_report_iftsn() and makes the stream reset paths call
> si->abort_pd() directly. This patch is tagged for stable on its own.
> Should that change be folded in here, or should the two be backported
> together?

Yes. At this commit an I-FORWARD-TSN whose New Cumulative TSN is at or
above the highest TSN received still takes that branch, and
sctp_intl_abort_pd() frees every queued fragment, including those of a
message still being received on another stream: the same loss this
patch fixes below the leading edge. If that message is ordered and in
partial delivery, its MID is also skipped, and the association is
aborted when its next fragment arrives. With this patch alone the
ordered and unordered tests pass and leading_edge fails. The later
patch fixes it. v2 adds a leading_edge case without partial delivery,
which shows the loss directly.

I kept the two apart because they are different mistakes in
sctp_report_iftsn(): the TSN-based purge, and treating ftsn ==
max_tsn_seen as a reset. But they share the Fixes: tag and the
symptom, so folding them is reasonable too. The later patch needs
patch 2 and the new pdapi_seq patch (see the reply to 3/4), and
neither of those needs this one, so folding would mean those two
first, then this patch and the later one as a single patch (question
at the end). If they stay separate, this commit message will say in v2
that the leading-edge case is only fixed by "sctp: don't treat an
I-FORWARD-TSN as an association reset". All three fixes are Cc: stable
and apply cleanly, in order, to the v5.10 through v6.18 release tags.

> >  			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
> >  						  GFP_ATOMIC);
> >  		}
> > +		sctp_intl_reasm_flush_mid(&ulpq->reasm_uo, sid, mid);
>
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. Does the
> new flush leave unordered partial delivery stuck when the skipped MID is
> the message currently being partially delivered?

Yes, and that is the next patch in this series, "sctp: abort unordered
partial delivery when its message is skipped". At this commit no abort
notification is sent and the next unordered message on the stream is
delivered as the rest of the skipped one. The uo_pd test fails at this
commit and passes from the next patch on.

Xin, Marcelo, two questions for v2:

1. Fold "sctp: don't treat an I-FORWARD-TSN as an association reset"
   into this patch, or keep it separate?
2. Should dropping late unordered fragments be part of this series, or
   a follow-up to net?

Unless you prefer otherwise, v2 keeps them separate and leaves the drop
to a follow-up.

pw-bot: cr
