Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.185.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334122;
	b=4/MtNkdO1P9SrNZhf3jLpTBK3SRhiIiSss5jWA3UWx8dX1ktUwZybMHd6QLPUjCh3Y7Q
	 cBxGz+y3RbSj0nxW/E1f4nr0hqPWZtLWrn7odn5ArqcZRJYHVL2DqS/6BGSfXqo8cjcoR
	 Ro4XXh4YbEo18lbiUZbGydpWJaXY+Uj9i3Wq5SZLPB7zwp3VbxEx9Rq/mOCTox3EITYP0
	 r7tGE9qF9002rINyMk7LKldjsIWZ+ZtYTecuwd5LmVTUZgN+IpHgL738+CO4yN3/ajuGM
	 XSyb2XrNNKWxcJFIVyluXwTkBJtUUeVhncak2gq5brfX/ybKuljcwRmIhDs3vWvjh5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334122;
	h=DMARC-Filter:MIME-Version:DKIM-Signature:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Bar;
	bh=5hIUGEpD7xu25o65xOT4OWyzlA6UEfLQ8Gsc3unD4x0=;
	b=fQBjXBpccpggkO+kdaZd4cE/5Qzfz5NWBgg8bp8LVHW3USko0bOeEWAASw8xVXHEQ8C3
	 nE98h3lO6anLOtiDx3HD51/hCNXAa+Oym5IfaDwCW7iiZ2Hk6q5APzfxwckvqwNs6kp4K
	 iDCNdtflzrZ3rtQRLjVAJlR7Ns7pYBGfBlPmIqzLHGMVBAHEap5AsyNrGxQSEG5HrZYws
	 VTiF2J/1RR3/TROSDZJzNLk+cZPpgYHCqQgTWAazpuJnerXQtrBFrJvYFYalJz1Ml7qRR
	 oF++ZRv4Cwv/XuEserugQmRQ46JXdEO+4uHExjapv5XIicdFoi3wSEydCe7Pct9OOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=badcode.im;
	spf=pass smtp.mailfrom=badcode.im;
	dkim=pass header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=XFvnO4PQ;
	arc=none smtp.remote-ip=185.185.58.180
Received: from badcode.im (badcode.im [185.185.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2444606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2444606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badcode.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badcode.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=XFvnO4PQ
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=badcode.im; s=dkim;
	t=1794334119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hIUGEpD7xu25o65xOT4OWyzlA6UEfLQ8Gsc3unD4x0=;
	b=XFvnO4PQB2Z7FZKzl6GwGDc0qzJnZNX9QquVhkbhdYO7XsuUtrn6Ox4etDyROTT0PtPWaD
	y+TvtlebNkj8X8Y8oI6OFx2wOhnaitgB1PMDAaR/huBtRkYK5Vw+Rpmskhc1UEmENJ5GVa
	Iwak7U1w55988XI3RI7qY4sOhip129JAkGTa0i7peCSv0Q7rBxkwRGWgD26WpbeztuOVgH
	4S0VEo6G6G8Nf5mP3k0in6/06KEmJSyjMlwy3YA3crLAtuocHvVic42DvmjyBI1LANz7TG
	kTDp0hLri9lGw321M7Zu2CK9JySa09MmTaHOVGVGfubcoGzJgX7NvXYsubZ/dQ==
Authentication-Results: badcode.im;
	auth=pass smtp.mailfrom=alex@badcode.im
Date: Tue, 10 Nov 2026 18:08:38 +0000
From: alex@badcode.im
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: alexvancasper@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] wireguard: noise: recheck replay and flood under
 write lock on initiation
In-Reply-To: <avNLlkTOYf_yYTHE@zx2c4.com>
References: <20261105140815.92841-1-alex@badcode.im>
 <20261105140815.92841-3-alex@badcode.im> <avNLlkTOYf_yYTHE@zx2c4.com>
Message-ID: <0770649757ee4a30024424f66a16b964@badcode.im>
X-Sender: alex@badcode.im
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

I don't think it changes which packets take the exclusive lock. Before
this patch, every initiation that passed the read-locked check already
went on to take down_write() unconditionally to copy the new state into
the handshake. With the patch, exactly the same set of packets reaches
down_write(). The only difference is that a packet that lost the race
now sees the updated latest_timestamp/last_initiation_consumption and
bails out right away, instead of overwriting the handshake state and
generating a second response. So the time spent under the write lock
goes down for those packets, not up.

Everything else is still filtered under the read lock as before. Once
the first copy has stored its timestamp and consumption time, later
replays, and any initiation within the next 1/INITIATIONS_PER_SECOND,
are rejected at the down_read() fast path and never touch the write
lock. Only copies of the same initiation that are processed truly in
parallel, so at most one per CPU, can get to down_write(), and that was
already the case before.

This is the same pattern the response side uses after 2a73c9b2c0ca:
check under the read lock as a fast path, then check again after
down_write() before committing.

Thanks,
Alexander

-------- Исходное сообщение --------
Тема: Re: [PATCH net 2/2] wireguard: noise: recheck replay and flood 
under write lock on initiation
Дата: 10.11.2026 16:51
От: "Jason A. Donenfeld" <Jason@zx2c4.com>
Кому: Alexander Ildiyarov <alex@badcode.im>

On Thu, Nov 05, 2026 at 05:08:15PM +0300, Alexander Ildiyarov wrote:
> wg_noise_handshake_consume_initiation() checks the initiation's
> timestamp against latest_timestamp, and last_initiation_consumption
> against the current time, while holding handshake->lock for reading.
> It then drops the lock and takes it again for writing to store the new
> state, without repeating the checks.
> 
> Incoming handshake packets are spread round-robin over all online CPUs,
> so two copies of the same initiation, received back to back, are
> processed in parallel. Both copies can pass the checks before either of
> them updates latest_timestamp and last_initiation_consumption, so the
> replay and flood protection is bypassed. The responder then creates two
> responses, each with a new ephemeral key, and installs the keypair of
> the last one, while the initiator accepts whichever response arrives
> first. When those differ, the session is unusable until the initiator
> gives up on it and starts a new handshake, and an attacker who can see
> and duplicate initiations can repeat this for every handshake.
> 
> The window is narrow, since the expensive DH computations happen before
> the check, so it is between up_read() and down_write() only. With netem
> duplicating every initiation between two namespaces, no double response
> was observed in 200 handshakes on a 4-CPU VM. With a usleep_range(1000,
> 2000) inserted before down_write() to widen the window, 30 of 50
> duplicated initiations produced two responses, and in 12 of 50 cases
> the session was unusable after the handshake. With this patch applied,
> and the same delay, every duplicate was rejected and all 50 sessions
> worked.
> 
> Fix this by doing the checks again once the write lock is held, keeping
> the read-locked check as a fast path for rejecting replays.

The downside, though, is that now it means there's potential to do flood
attacks that take the exclusive lock, which is what was trying to be
avoided, right?
