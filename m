Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606492;
	b=zh3CPJrxk98SDSARN3g1TPmwqAAizxt0umHtjEDrL7hbg8Nal+YCX0MONbfS3XlI3zkh
	 ZLV0b/i1zCvnMvqreGiuK0HImLxs72ixzMzkKT2rA/+wQ4ElpW/2CEpqVbQ1gLpzigKyh
	 Rt75l8mXmPxJJ0LQAhQcpehgOpycxsT0HgFAk2avxsFaEvcmW8ygio4KFUQGYDTT3LvQs
	 07w46XLngD5CiGrEiWVHOt6Lzy8l1aVMYJoJwicRH1A7s67JhbPdUztTkJ0gj+lrFrjiW
	 ZShliG9V8hU3M1ZyfzbZSBojBXD2BMq+6PpnT16MEQUnjqkp/lQ3nZzpqj42i7WTlzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606492;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Received:DKIM-Signature;
	bh=M3LbqulHgIFHqy4xTGBwg8cD2w7pi2PiEVunDW0r8AM=;
	b=MImOWXIu5yoD2yfvgNI2yQVxZ9xm6f6ewwbdXwig6o4fOIoYpzkLtVPm1g7fIW5LQOD7
	 gvyfdq/j3btNLzKniu2ZR2cK3yW31NZ23kxcPMX/YEpkQ5Y5KjiIVrtZquWb+aO6It9rp
	 x+JzfZ+iEoaNhWz96FmRpuwKpyNBG84EjcYAWZ8DpDQsDjWjNLE5CLTOjuKvLJkSwqZgS
	 YMX0rkR7v5yZV57zHdCFiAjJkeA7sLooV9NytW/++RywEepCExBF0VRgGO9LZuUAQ00Lp
	 7XFlylsD6sJYo8+QQuiS9s2okeinFeW/cP4iopQP+i+rR9oNX6knXT2blsTWQfPYHBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=NtEpMOwn;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDB606A321;
	Wed, 25 Nov 2026 11:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DDB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=NtEpMOwn
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev-bot+sashiko@kernel.org
Cc: Federico Musto <federico@rimpianto.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] net: atl1c: wait for in-flight RX polls before the link-down ring reset
Date: Wed, 25 Nov 2026 12:34:48 +0100
Message-ID: <20261125113448.99952-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179530311729.3135.17859147482038356358@kernel.org>
References: <20261117225521.19689-2-federico@rimpianto.com> <179530311729.3135.17859147482038356358@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id FE6BF981-8671-4084-B964-A086CA6A4F2B.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 12:34:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1795606489;
 bh=M3LbqulHgIFHqy4xTGBwg8cD2w7pi2PiEVunDW0r8AM=;
 b=NtEpMOwndgm1pz99T14/ibinvEfoVJkXgJzeywEO8nhtbV+mamLXGdiYumW3u3nkrDI6mFYG0
 bpRxKmfdOP3StKQ4ExfVeVwEdcACHZaz1LRKiKrT2MZr0Hxf+tglPXa3beRboCMs8OHimKZ8Xn6
 UxhDELZs8BSdBgIaTDBkW55CjrMZWj641Kif0nvgVWE6gcCAm22FrWTZOSJDxEWBGU6LwT0hGh4
 pRJE+iihZvgdfmhr67nXm+FgnBZWwF225rpPI+0gEBvxaZI8haDJwxVKpzjo2cqzHyIXSwt1n3X
 Pjx6xh6Ma/Rf18BCLw03GIc9yrhcnKfqHzr5adIZJM8A==

Thank you for the review. A two-patch v5 addressing the findings is
posted here:

https://lore.kernel.org/netdev/20261125113120.99743-1-federico@rimpianto.com/

[High] "This patch does not close the RX race it claims to fix."

Correct. In v5, atl1c_rx_poll_sync() returns bool and, when __AT_DOWN
appears while waiting, the link-down handler skips the reset entirely
instead of proceeding without having waited. Skipping is safe: every
setter of __AT_DOWN is a teardown path that napi_disable()s all queues
and then runs atl1c_reset_dma_ring() itself, so the rings are reset
with NAPI quiesced by the teardown that owns them. The handler runs
again on the next link-change event.

On the remark that the loop "polls another context's state bit and its
exit condition does not synchronise with the poll": the wait now pairs
with the polling side. The handshake is a store-buffer pattern - the
work item stores the carrier-off state and then loads
NAPI_STATE_SCHED, while the scheduling side stores NAPI_STATE_SCHED
(the cmpxchg in napi_schedule_prep()) and the poll then loads the
carrier. A full barrier between store and load on each side (an
explicit smp_mb() after netif_carrier_off() here) guarantees that
either the work item sees the in-flight poll and waits for it, or the
poll sees the carrier off and returns at entry without touching the
rings.

[Medium] Unbounded wait with threaded busy-poll.

Correct. The wait is now bounded: 500 iterations of
usleep_range(1000, 2000), about 0.5-1 s. On timeout the work item logs
a ratelimited warning and skips the reset - it never resets under a
possibly live poll - and re-enables interrupts, so later link-change
events are handled. The reset is likewise skipped when __AT_DOWN
appears (above). In both cases the rings are left to their owner and
the link-down event falls back to the pre-5e5c0964d9b9 behaviour (no
MAC reset), which is degraded but safe.

[High, pre-existing] TX side of the same reset.

Acknowledged and still out of scope for this series: it belongs to the
serialisation of the work item against the atl1c_down() callers, which
the changelog defers. Unchanged in v5, restated under the ---.

One runtime observation from the v5 hardware validation (emulated
AR8151 on a MikroTik CCR2004-1G-2XS-PCIe): twice, about 1.3 s after an
MTU change and immediately before the device signalled link down, the
IOMMU blocked a DMA read from the device to an unmapped address. Both
faults precede the link-down interrupt, so they happened before any
code touched by this series ran for that event. I have not established
the cause; reported here and in the cover letter as an observation
only.

pw-bot: cr
