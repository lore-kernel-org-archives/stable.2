Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146845;
	b=KkfIuUa8VZk+YomkHKYh/v0HdAMR0OxKVLUk2dsgk7XemII+2KB8iySJFGaHgG3PKT8U
	 QGONrbUq5S70g92pdgvBxk9T986Ukja4/+Sma66wLgL5evMOI7cQHsA07xQt96gspHKWi
	 HssxNmV5dCzupZHgJWCiKnwgcwIVpzeof9n4YPy6+lanY75Y47Dx9XMHmFBT9+izmOP6Z
	 E4QvsfIJmdErHoABelrCGHpFlVVnps/vYRHb7chqwp9aVzuLRQDs0okUw4rnLOalhxtg/
	 AtOevac+XHfsf7qVsqqa6SWwUPviGXyBh6CbTwkCZf0do160rEp2pJa7OwoaJdttgEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146845;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=wp7H0qwktQKIubHbagjHBZr6/G8XhijmuXZeStGP5Ec=;
	b=drgF4M4jcQjavSXMWZAvWB6/JtCGF649x9ISccC/cmr+IZji6sO0NN1EHVKuSZ3i6QNW
	 7pxwYBCY6t2c/6SYNKnuoRbWyY4Rb4CAGgUQhL33B4uGumIBe6uhEdt0uMq7RUOUitmhr
	 B91fV3WH726Po05RogX8fxiiFICZhJqCstMvdBe2qNx0Z/Hj7NcPkXWBIu342O9NxH1mm
	 H2YVXrhuBMSMtbRQ/eO2F54tE2OcDzU14ncZLBAnNMK2V9sglc4TpPyEpvkUjt9W2Qge3
	 QcL0yRK1ZK2Tz0jwdL/GjgbXSHDvD5Dj+mbxp6t04cXMxBT0P3Q0/AocU/QUzRKdooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ealWSAx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A1606A33A;
	Fri, 20 Nov 2026 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ealWSAx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5211F000C4;
	Fri, 20 Nov 2026 03:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146845;
	bh=wp7H0qwktQKIubHbagjHBZr6/G8XhijmuXZeStGP5Ec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ealWSAx8Yh0AmxVLJakJviPQZra82kSdiWOt+WN37PIaokoMXkGaDjdMNaUY0CENn
	 2IaxGvF46dIRvvEtWpD7j1+Pzka/7ahZB6gSiwCuNaJRtAHmhixIiWak380cLm7Csd
	 ozIRZhDqXG5g3Dks2katSigwdvx1YsO+566XlXGdmiJ2UtvdrByoDErv3SXe3AoDJo
	 TUtKgTKmh99SnmzeU4hbTgky44w2XevfwUJeAwsTP8fkRr++Apk9AiiA9bluurYd32
	 lZAwLmPvqiN/78seGTCjYH6rKT8ZvA8fTtYlw1Cs6RZwgXUVlnR2o/eRCiwVKRJE9g
	 m+Cbtfcp3vEzQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111101625.2204836-1-takano32@gmail.com>
References: <20261111101625.2204836-1-takano32@gmail.com>
Subject: Re: [PATCH v2] libperf: Handle an evsel without an fd array in
 enable/disable
Message-Id: <179514684440.638421.13429530060315684654.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:04 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 11 Nov 2026 10:16:24 +0000, TAKANO Mitsuhiro wrote:
> A group led by a tool PMU event is opened with the members' group_fd set
> to the leader's file descriptor.  For a tool event that descriptor comes
> from open("/proc/stat"), not from perf_event_open(), so a member the
> kernel refuses is marked unsupported; perf stat then releases the fd
> array of that member while the evsel stays in the group.
> 
> Enabling the group goes through evsel__enable_cpu(), which enables the
> members of a mixed PMU group from userspace because the kernel does not
> do it along with the leader.  The member has no fd array left, so
> perf_evsel__run_ioctl() reads its loop bound through xyarray__max_y()
> and dereferences a NULL pointer:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


