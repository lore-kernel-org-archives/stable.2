Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C5493652;
	Thu,  1 Oct 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862766; cv=none; b=SgiGOCUNfTe5EMkKP+QZdfUkXzt/vLyG7HsNK9HVDh5a8VQKwdb/Ir8MUbv7GKKoEcAyC8mdkQ2mvVaY4UAiGZJQCwy2HMhU77xleDM3NgqZ3n00Ex1T0dnmFO5+T1wYsBxsbEJ/8WIstYYucnRVVRuXkRSVoymVPdhLtVm5BbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862766; c=relaxed/simple;
	bh=KI/QFFNNiXAwgYr4zENKAEVgCpZEDqJx7KVCHRmtim8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKQKChUDuFED6zbl7xJY4GkwzQE88HQyDe3qSWX4rx8YB4Wd3io4fSsW1M4yThYxZu6yQp3HnrAcCFXx3ZNtR3K53YlXbtxPlxudvLhCxN36y0EHvlqVr+NhDCbkllHgsekppqlvaIWi/IYoKKpMHMY1eYs87PERNbgvmx6blV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWCnZXux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWCnZXux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578671F0089B;
	Thu,  1 Oct 2026 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862758;
	bh=E67Tl/yH+5uV9iIGrSXZqunBdrhk87Ysmx6mL8/6g0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWCnZXux1QXEQFx6YATsIbNaIZEia6eaL1syoncbj8ENw+3OtRT9bv4xrKVYnsTeP
	 C6PoW8IaYxiaHoFJlfaPZZt1N4dRw889JHBgKRnpJIMGNB2bzePkwkdzGlrl47Fxi/
	 AxWBoOQy0rhsZdIpfMRsdn1p9yB+hrjQjEuDWZAGiOjl7j2xXXY8VC5vnN8wswZsdE
	 cvhsHmzM7W+C983CKLa1Dj6VvNyIGcvlkzl46EgK+AjWrrIK5jjv3JDLtlSLyeqyOk
	 BPCI8sfXK8gwAUvI86QDKwIpLb7+Vzm8th/DAwcSXTL3qvlJ1uAO0vkAN3+CN0KU2Z
	 rdt2v5g4BYpFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH stable 5.15 0/2] perf build warnings fixes
Date: Thu,  1 Oct 2026 09:52:13 -0400
Message-ID: <2026-09-30-1-daily-reply-0009-perf-build-warnings-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929191541.264038-1-florian.fainelli@broadcom.com>
References: <20260929191541.264038-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch series fixes the following build warnings:
[...]
> Arnaldo Carvalho de Melo (1):
>   perf test bpf: Address error about non-null argument for epoll_pwait
>     2nd arg
>
> Namhyung Kim (1):
>   perf tools: Fix a asan issue in parse_events_multi_pmu_add()

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
