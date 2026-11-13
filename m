Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598361;
	b=QpFF9KBWfj7I191P0ddxbEPy7OGILlOYCoDjD8WHEfUEgCBfS53eW28WVInLga+2NZQ1
	 rFbs0m54gfiYidzkCLBxDDjuG6HfDSBzQHwI871AX5S1oSwHiGqXVbjh3zNhpIXOQg5hq
	 RGlFbwsZ/dcSK2JIB8NUZpDgN9lHN9BrXdV8v6ALgtDncw38eXM/yLsz1jbGaQs8N+Jxy
	 MDw2kyiiGe0rfWnO2h5pt0KdvFq5baTBEMxEStYXJqt5234capM3SKX9RCqYoJ/3bjEJB
	 l/k5MEqTH46bqUhFQjbbxDk9biaUECI31/QjBVx8qAGY8wLlV9hU+F+2u0dw5Af08jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598361;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=9QUxF+6/St6GJYBN79ESjswsrFJX+8HRrNAXaxieR0M=;
	b=opxhX9kr4vrpZKxc6BEhUCLBLi/rC3HeVoZ9WdRowaW+W0F6I+TUb0m2UzWa/LNDBHY1
	 8a2Cz9+OWp2YEdszgWNl1Ebas6HdpbNPlxSDJwzqcH0UBx5o+dvV0r6J4NWQq15cl+xvv
	 nnECaqc0yAA49zzyD9fOVqWenFFUXuSu6XYzFllVElZeaVxY2J5cf7WkrJBQmwUAESXGf
	 AfvKmgufhV7n2cc086wHX9yiia2E7dGPCTywQ5aA23PkKD36GMJw2MM69q9P9ifXJvmmH
	 Aq3M9MvhJ6KUiTYBFjkhW94qTRMxKFqabj920kmdKVws1g0ZNCragBOx6CJXeqpL7Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=h1hHjBnV;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FA606A337;
	Fri, 13 Nov 2026 19:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC1FA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=h1hHjBnV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=9QUxF+6/St6GJYBN79ESjswsrFJX+8HRrNAXaxieR0M=; b=h1hHjB
	nVFaHIqI2nTShzgLNoBl4Y5xGKSecmcR6GbTJQmz0pm1IpOI6yeg0fukP7ofiUPwOOXA+2VKsqHL+
	TwbC10yORaJc+DtGy7kARpc+uz+0AMwzU7HUgmy9vsGqkb1n8jt37+vwqeHbfTT94QkSOHrCpQORt
	Wktad4Z0y3PQx/8jRX/MH2HHpYRItT7HgxIilq6e937mX9pxKs8xyX/RYyeptlmRvh86eXcK+XMoI
	g7R/YFsL/VwYT6WqLqXOSvdQpESsqIyxBeaqhHm8IzCaDFlVDo9+SW/J+vrFfa++RsK/Mh8wasuL6
	EfkDd93aQudu/SbBxdTH5qi6nuKQ==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xRwzx-00000004rZh-27Ev;
	Fri, 13 Nov 2026 19:31:45 +0000
Message-ID: <eba9d3df71f3f37bf7a318854a1ab6bf1cfb1981.camel@surriel.com>
Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to
 select_idle_capacity()"
From: Rik van Riel <riel@surriel.com>
To: Usama Arif <usama.arif@linux.dev>, peterz@infradead.org,
 mingo@redhat.com, 	vincent.guittot@linaro.org, kprateek.nayak@amd.com,
 arighi@nvidia.com, 	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, 	bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, samuelcrossley@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kas@kernel.org
Cc: Arnav Aghav <aghav@meta.com>
Date: Fri, 13 Nov 2026 14:31:45 -0500
In-Reply-To: <20261113153157.2495664-1-usama.arif@linux.dev>
References: <20261113153157.2495664-1-usama.arif@linux.dev>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-13 at 07:31 -0800, Usama Arif wrote:
>=20
> On a 72-CPU NVIDIA grace arm64 server, small reported capacity
> differences
> (1013-1024) within the single LLC activate asymmetric selection. Both
> the reference and affected kernels were observed with a zero scan
> hint. The reference kernel ignored it and still searched the domain.
> A latency-sensitive, wakeup-heavy production workload saw its
> reported
> minute p50 latencies average 129 ms on the reference kernel and 223
> ms
> on the affected kernel.
>=20
> Disabling SIS_UTIL reduced the aggregate involuntary context switch
> rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> raised the rate to 73.7k/s.=20

Afaik, the asymmetrical selection is supposed
to solve a very specific problem: when a task
requires X amount of CPU capacity to run, we
try to avoid scheduling it on a CPU that has
only a fraction of X available.

This creates the issue that a task that appears
to "need" exactly X, because it's been running
on a CPU with full available capacity, ends up
not being scheduled at all when the available
idle core has X-3% available capacity, because
that CPU happens to spend 3% of its time handling
interrupts, or running something else.

In that situation, it will be better to run the
task on the CPU with 97% capacity right now,
than to not run the task until a CPU frees up
later.

Things like SMT and power-driven hardware
scaling complicate the matter further, because
we simply cannot see the full amount of capacity=C2=A0
that is available on each CPU.

That makes me wonder if we should simply accept
any CPU that's "close enough to X" when dealing
with asymmetrical placement.

Say, anything that's above 3/4 of the capacity
of X would be considered good enough to run the task.

That still prevents us from placing a CPU intensive
task on a little core in a big.LITTLE system, or
from placing a task on a CPU that spends 80% of its
time handling interrupts, but it will allow a task
to run right now, when the capacity imbalance is small.

Does that make sense, or am I forgetting something
important?

--=20
All Rights Reversed.
