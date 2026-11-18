Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027773;
	b=SyxmoYmgzlUiZxoqOlkTd8dEI7YwVth6SiHFJDTbzSFU9JTh0h6XDblsINwS1A5sPxq2
	 xlB7QJWZU59VGJAQnETZvruSHwtQ/BihOzcwXXm2O8QkJ3YVKCAm6jyYrdAn6dpUKCQky
	 plqUQ8SNEPtjbXdy6ELhs573yX0BE0mkSUKv964PSZjjJfj6iWKYt8dp2hVLo/FKLY65Z
	 im9+fGDrTHylF9hf6B4ZIstsSVJ2C6MzLZphSzSeG23LgGKDnS7sX7GxzXyU+z6bk3JEf
	 S2Mh9wN++GES1mRvXiAf/cKsVrOyTZi9SQz5SUl2FdMydUO+EbhZgnhYAql//yt6jWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027773;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ySe4sgGyNO3dIkG0Xzd/JOiIpbog2yvKCpf8ED6IGp0=;
	b=FHrFxi9SePn0hNdfD/9QX7bn4XeFqnJYtX0F5uA1v9dOikov6xltggkG12nsslArP57S
	 i/xA/+DgsBwfmSoFHtHwbGVUZd2m04MagjWgfsKHCoHGZ2R3CTuJeuS+AyeFDXkD2MFfX
	 W2nCU1rL7DXo6G/12JXSTz7MaXbPgMey9afhOBeo9Y072FsGDPjBKxwDCAP/EtP3+zuT9
	 VTV0POkBA06RhPbJTgGSgMTBM/v13V1iTQW/VT/Lc+AXebC+OgLyyRaz0SnpXMHON1bLS
	 gzFdncJP9bcPNlIxqEWZnkeDQmb1dK+1UruhHf4IFRMBqAwfTgX8CoMTFmzdM/PZtIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pOv2r3lJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kDyAN+KB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3590606A335;
	Wed, 18 Nov 2026 18:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3590606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pOv2r3lJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kDyAN+KB
Date: Wed, 18 Nov 2026 19:49:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795027770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySe4sgGyNO3dIkG0Xzd/JOiIpbog2yvKCpf8ED6IGp0=;
	b=pOv2r3lJWjBQpXSJMgdtnxD9rKomrHcZOKxLP+gutke5QXmPo6yqRT/Gzx3bWtFVDgBo0q
	tRgKV7eEqW4uZCP3dA1jcXJVffIKEF7PGExoA6K76sYXjrKVplIMfmtAonYXg33qK0y9r9
	EmLujodKbHyco+5tJQSS2PDtMz00cBocQbcMTjDXFCgQGVlboSJfnn4Y9ryHZzB6wCxj/c
	4UqgLFpQa3Ndwh7u9QtSvkJ9ltxDku00DXDeVZ/PwgN0nuEPb26xUjt96178uvh/CJWrfc
	iItIs6fT66vre1sfWZVAcGXH5u9lzx3IznlbQXvC0b1p7nm/Vm/i+08X7gy8Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795027770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySe4sgGyNO3dIkG0Xzd/JOiIpbog2yvKCpf8ED6IGp0=;
	b=kDyAN+KB2VwWOnw/THAMai0mNSZwppMlcDqQ+cUKQF5IvjoPLmdj3AoOqt8xhCYIwyemW5
	E6I2URpe/0CoYZCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] locking/rtmutex: Initialize the ww_mutex context
 of a waiter
Message-ID: <20261118184929.0NSA7-Kr@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-3-mathieu.desnoyers@efficios.com>
 <20261116135857.5t9HGji5@linutronix.de>
 <de727dc6-cd11-4a7e-a853-aecd895685a9@efficios.com>
 <20261118144006.ms1fvDv1@linutronix.de>
 <56ded99b-9390-46c1-9466-0be0cbb9ee95@efficios.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <56ded99b-9390-46c1-9466-0be0cbb9ee95@efficios.com>

On 2026-11-18 12:28:54 [-0500], Mathieu Desnoyers wrote:
> Hi Sebastian,
Hi Mathieu,

> > I would strip that paragraph because *I* think it is more important to
> > mention the FUTEX case which no longer does proper chainwalk regardless
> > of PREEMPT_RT.
>=20
> One point. The two tests of ww_ctx in rt_mutex_adjust_prio_chain() are
> under IS_ENABLED(CONFIG_PREEMPT_RT). Without PREEMPT_RT,
> futex_lock_pi_inherit gets EDEADLK in both cases, with or without this
> patch. So I kept the PREEMPT_RT condition in the message. Did you have
> another path in mind?

Indeed. This supposed to be simple code=E2=80=A6

> With your changes, the message reads:
>=20
=E2=80=A6

Good, works for me.

> Thanks!
>=20
> Mathieu

Sebastian
