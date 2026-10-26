Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992474;
	b=lDz6TY96dDh+qNhhYdd/QHn/Zuxxnsr4weNzN/XR4il+QXRXqu380YdC7lprPW9Kw+8p
	 f+tsLiHAiBmkPY+IYE1W24cXSA77rZD/dPhhZhfMpX5sTCYmRM+zWJ1y4rrmjyzYgwSpN
	 O8ZDkHDQgRsikQnJpVoUE3UIMJcSFIrpal5r8cQzWwe27QMEf5DqFpd7RKNJEwUchoZRI
	 pAGF1ccoNnfQhoLwWWZ3TAkon/C91aQtrAGtzOlHmYjc1QkkvWh8YLaaIUoHvj+0OnWbL
	 C8P/XKjz2WUVfafosGXLPpi7OArEQoV2yYe9Ue+6OfzQR+OY5BfB5QReJt52/vkkD0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c2vVLfr5r23oMNsvxAvIsVWSucEEuXtAs0YtxOnot1U=;
	b=rLjdE8ueTeQaeIKOKoXs8yLuuyVsqldy/MbsyYX2mgqJThv701HBsnUhTpRZtV3EJUbN
	 5r0C7vhoQrhf5lmoyQPvbDErDZp5X8q1t6MgKGUzP9VLACE8VtiO9di5rNGnOAtnIs6Aa
	 wZQ0Za7tYnJswlAm/E+Bqvm/y5AQAvg19HVy3jSoUyygq4+fmvULnb0vdZCtVj6dXbV8B
	 wM24m+KgzWCSkZFj7z6MN1Qhd3fQ+BivutxjSB9Kq94Z4CTV8N9HG5DFO5aTvx/x0OoQR
	 X0bCBKPLBH9EZWW+xE9bFJnAr7f+YDXaGyWgN5ANWAC2gWOvM31mjd6PYZOwky/08gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jMP/3eHG";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36973606A330
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36973606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jMP/3eHG
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-157fe9d771bso3099661c88.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792992473; x=1793597273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2vVLfr5r23oMNsvxAvIsVWSucEEuXtAs0YtxOnot1U=;
        b=jMP/3eHG+EcjoJUjkHbgDNSNscVw1lpaVMGVmlUpSZzj8OH+U3b1U1M2BhE2Mv8I9+
         vqrrRNa5OA9HhlhBVpqgpBpk+jw8d9HwWsf/blISembtKeT6gaD0G3HT7EacBY1BhFNA
         QazbKzpgew+ACfErhewIOJ3thbxuc2XrD5GfdKyk8zl6bM+EIWPMksj6qQ3oBrXZOzwC
         mpWCSIUiPObAEG/CqyHrzXy7Fa4E05tF/kJHXvIHnKYcNxDDGyyKgG36WcNdxV5hs+0E
         rXurmLsgyIVpwv09sjXTYPzp89m0LKWKukArbhcO9O1hgvfCJNbxYu4tl3umhJy8fGfi
         dynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992473; x=1793597273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2vVLfr5r23oMNsvxAvIsVWSucEEuXtAs0YtxOnot1U=;
        b=1sq0PC1GjQLmpNXw7IprC5gvI2KpTMgZ8jYXzdP/P9t/HxTUptvXfOZ3CmlRnsWvXQ
         Mz5jPgAlmYyME0X377/2/dWry1bzdLM5Ka2cmhcUz2MMkgLoS/riyb2/wk+RH5uLxCk9
         OrPbLmXTpLPUjTdRD10Aw5oL1dd1Pv55XGSlZI2HhHFiixxNXT6Neoka0L5UzqVy9mBB
         QThqhB8mj4UsaAgwiYHkqo9VAblLGYpwPMlJ0Lr2TKFu31tHHAMYHNKxHe0R4mNuBZI9
         xrGotEL14SQo2FZSZ7cTyTNhiZytURgLd2rIyI+ZE2/Ys2PLbGmIxfyXLgw7YfdQ5oNF
         gunw==
X-Forwarded-Encrypted: i=1; AKwUvByy/nYJ0RaJ7F4dRJuzk7K/ovB4Kcx9MD+PMUXVmaYCY06d6jvXxrdojrOTrkgXnaNeqhsQMC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL68EZOBiiEZaQ17SxwWAfUMhxrIe8xrJf3SVwog1HcqnTgTcX5
	WT+PXBHegf8qOWY7ZWzUgOXaRN1i+ZLSOPfZWMnOBqm/iZq1YNSMgFuN
X-Gm-Gg: AYBFou0G5EBH7B0VjI5vgNOLkSKgBH4fFSIXqnbq3VmI/W7nm9AXoCnXOhW0/zcKc7R
	OKcr11i3UvqdMTzatOjeZEf7JnlrQH9I3e3B82skhZhdk/FhjyZAhhchKngg0pm7Nd28JYYazWS
	+zkWtdtXoKcmJdM8EtH43IL02avARyr+OKO0OYHR2v5kGZ92AIUDSH6kLEKX/muUQTfJwvcpZrC
	vyNGoqa5Ii4qb7GO4ku25hkCN/ikgD0ifRi0TSVjYo3nxo8iAncm5zcoPQWbkxvEORVlwNXZAtp
	ugcUT2eaj+p9JsDmboEY4fobIoDHjNFhmZSri1tb0eoNT4CLfAQNtRKVbgRlwtvQVlMwrbrXhk2
	JL9BBwPKN5j6dxfKvVRPhNEEeKcScezVwE8R6Z5TvTQ5z/TqEHEQPnl1ObOxHvD/LorkbGh21Pp
	y46k7a/dYTIka3syr53+8TgHlGx10XnxiZQJAH5/r10OWZpUCm7yB49oETJLHRJNSB0yduJ77yS
	005DFvcCp5LasFC5aNWEWH3JOsV65obowqL3CQqmgAgixX/DMPz1KhKcVLIruBwk52piys/la3h
	mIwkRqxUjqGuZQPf6UPPDDujZg==
X-Received: by 2002:a05:7022:b04b:10b0:164:4e36:f956 with SMTP id a92af1059eb24-19935905c52mr8981726c88.16.1792992473149;
        Sun, 25 Oct 2026 22:27:53 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm25064523c88.10.2026.10.25.22.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:27:52 -0700 (PDT)
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
Subject: Re: [PATCH net 4/4] selftests: net: add SCTP I-FORWARD-TSN tests with message interleaving
Date: Sun, 25 Oct 2026 22:27:48 -0700
Message-Id: <20261026052748.187496-1-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179293012994.3134.15218902499880345860@kernel.org>
References: <20261024120627.837568-5-tim.budding@gmail.com> <179293012994.3134.15218902499880345860@kernel.org>
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

On Sun, 25 Oct 2026 12:08:49 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> This isn't a bug, but the deadline check and the poll() timeout use two
> separate now_ms() samples. If end - now_ms() comes out negative, poll()
> blocks with no timeout.

Agreed, I'll fix it in v2.

> [Severity: Low]
> Does the reset case check that queued I-DATA is discarded on reset?

[...]

> The test does show that MIDs restart at 0, because the marker is
> delivered. Could the test leave stale fragments, or a message in partial
> delivery, pending on the server when the reset is issued?

Agreed. As it stands, the reset test only shows that the reset
completes and that MIDs start again from 0. A reset is only performed
when the data sender has nothing outstanding, so in v2 the pending data
will come from two PR-SCTP messages that the client abandons while nft
drops the I-FORWARD-TSN: one partly received on stream 0 and one in
partial delivery on stream 1. The reset is requested once by the server
and once by the client, so that both new abort_pd() calls are covered.
The test then checks for SCTP_PARTIAL_DELIVERY_ABORTED on stream 1,
that RX_QUEUE is 0, and that a new fragmented message on stream 0,
which reuses MID 0, is delivered intact.

> [Severity: Medium]
> Can the RX_QUEUE check fail on a correct kernel in the ordered and
> unordered tests?

[...]

> Should this poll assoc_rx_queue() until it reaches 0, with a timeout?
> Or wait for some sign on the server that the I-FORWARD-TSN was
> processed?

Yes, confirmed. Lowering net.core.wmem_default alone wasn't enough:
there were no failures in 140 runs between 212992 and 66000. small is
then sent after all of big, but Nagle holds the marker back until small
is abandoned, and it then goes out in the same packet as the
I-FORWARD-TSN, behind it. With SCTP_NODELAY on the client and
wmem_default=70000, the ordered and unordered tests fail 10 times out
of 10 with "2464 bytes left queued on the association": the marker
goes out right after small, and the I-FORWARD-TSN follows one RTO
(300 ms) later.

Rather than poll RX_QUEUE, v2 will have the client wait (with a
timeout) until all of its data has been acked, i.e. until SCTP_STATUS
sstat_unackdata is 0, and then check RX_QUEUE once. The server's
cumulative TSN can only move past the abandoned TSN once it has
processed the I-FORWARD-TSN, so the check no longer depends on timing.
