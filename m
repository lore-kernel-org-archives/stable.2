Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612167;
	b=MnElr2mLrCtTyO/Si4hZhbw2eZO7PlKIjZyTosLLJYJsDnmzrvCWoq0bSm/QxTViXHIT
	 YR0kAX03e5u2eBpv7StmspGVV0UorMtkeo4ZBLxiiQpihHYwyU4KHGephJkhxJsQK6mwn
	 U8L1zgzRmI08qdOTM6cVOlcDaQJqP70DD5pmABmq7PmodPF1eVcLldOR7KCyk5JqMkWwz
	 E+J10u6Aq1XAJfsCRVlFAK1CBe86HKt9Br8kx7a1bVxbMza6OADnqMrc/UmNvz2qKcVPr
	 q8D9cegzIEX35zmtantFPWKEb6qzZNzM0pukA5agJinmgGKcbJKH5s60lptomAg7TPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612167;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4JlziOrXTNMS1OhckK/k5WsJMtCd7SWbYKjtbZqWsQo=;
	b=ZRvvnrGHo55FuQFVAC5NGqsjk5FWNdsJ09dlTK0Tnps4IVfBXShQOIqRxxDGmwNnNAlW
	 8zcFP/fO8BZvA3CzaMTJ7KiJtqkEW0M2kZpjv0+ddNHTbvCo0hOyF7FtcWlvWpu1vlDaD
	 hMuO/WJe/Z8Su3QJaUJDgSQrYlox1n3XFITY1cZByt+ipWcWanDVbIXiOe63Nr7ol98EX
	 nqXRFv195Ri4cD023mE0gsY+n36AxjSVwW5sMotNudzuLj0QWkQ5y0yLuPAhKqnL+5QcZ
	 kfmka2QutqbbLOVe454Cwunft3B7ubg04wTr0t2Ozmc4dBaNiiuTvkqYQpLzWimbRbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rebasedinc.com;
	spf=pass smtp.mailfrom=rebasedinc.com;
	dkim=pass header.d=rebasedinc.com header.i=@rebasedinc.com header.a=rsa-sha256 header.s=protonmail header.b=od+AOXz+;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934C606A88C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9934C606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rebasedinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rebasedinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rebasedinc.com header.i=@rebasedinc.com header.a=rsa-sha256 header.s=protonmail header.b=od+AOXz+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rebasedinc.com;
	s=protonmail; t=1794612162; x=1794871362;
	bh=4JlziOrXTNMS1OhckK/k5WsJMtCd7SWbYKjtbZqWsQo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=od+AOXz+19tDJkD+yV6nmkbza29Ypz/7Zj0wWY78Za4QOwmBBWpI/CR7Fi/fXSPxs
	 YRNv6O/JPFU1vrNIcwQV43MbD3+AEV4i+2vvVyI2yhCCOdHg8FiIHJvhYH1aog7pQQ
	 /G5I+gAwRKOElqpZCBXzSMgpaSe934imq3cDy+eZCbDEVtzK3WDv657PvVbjf7+6zX
	 7b+hFAz6Tv/KmuURSKtf1AmTtBxIjDCYq++Ltl1nlT4QMh//kkEWaka/GuwfN91dYa
	 iw6XhSIA4vVNoeWrgrtjANbUUC3uQrzGcfQnJ/g32NSrZWSoKNTlCWAYANauph1o5i
	 GpEa+e51zqUBQ==
Date: Fri, 13 Nov 2026 23:22:38 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: dev@rebasedinc.com
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Yufan Chen <yufan.chen@linux.dev>
Subject: Subject: io_uring/eventfd: registered eventfd signals only once after the cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
Feedback-ID: 231970246:user:proton
X-Pm-Message-ID: 474fd90d362d4966a5836b434317232f3aed01b8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

While working on my own async runtime on io_uring, I found what looks like =
a defect in the stable backports. I first saw it on Ubuntu 26.04's kernel, =
and I can't find any existing report of it.

A registered io_uring eventfd stops signaling after its first deferred sign=
al on kernels that carry the backport of cd305ee3633a ("io_uring: defer eve=
ntfd signaling when queued from a wakeup handler") but not 04fe9aeb4f3c ("i=
o_uring/eventfd: reset deferred signal state").

What I see, on Ubuntu 26.04 7.0.0-1016-aws, x86_64 and arm64. Ubuntu's 7.0 =
kernel took the cd305ee3633a backport through the 6.18.49 stable update:
 =20
1. A ring with IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN | IO=
RING_SETUP_TASKRUN_FLAG, and an eventfd registered with IORING_REGISTER_EVE=
NTFD.
2. Two IORING_OP_RECV on a nonblocking TCP socket. Each gets -EAGAIN, arms =
poll, and later has data.
3. The first receive's task work signals the eventfd. For the second, traci=
ng shows io_uring_task_add, but the eventfd never becomes readable, and pol=
l() on it blocks.
4. io_uring_enter with IORING_ENTER_GETEVENTS then runs the work and posts =
the completion.

Debian 12's 6.1 kernel does not show this.

What I THINK is going on (I read the source, w/ help from Opus 5.5; please =
correct me if I'm wrong): after cd305ee3633a, task work queued from a poll =
wakeup signals through the deferred path, which sets IO_EVENTFD_OP_SIGNAL_B=
IT. Without 04fe9aeb4f3c, io_eventfd_do_signal() never clears that bit, so =
each later deferred signal is skipped.

Where it applies: cd305ee3633a is in 6.18.49 and 6.12.114. 04fe9aeb4f3c (Fi=
xes: 60b6c075e8eb, in v7.1, no stable tag) is in neither branch, and I didn=
't find a copy in the stable queue. I read this in the source of the linux-=
6.18.y and linux-6.12.y heads, but I didn't run those kernels.

If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks l=
ike the right fix; it keeps the CVE-2026-80920 fix in place. The 6.12.y cod=
e differs, so it may need a small change. I will obviously leave the fix to=
 you, but I'm happy to test a candidate on the affected Ubuntu kernel.

Thanks,

Nathan - Founder, Lead Developer @ Rebased, Inc.
