Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1C51A12C;
	Thu,  1 Oct 2026 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862764; cv=none; b=HNDVmV1hktssfP2ts+gHSncrb29wYL3Vk9cGA3pdaJioR1GDd6rmC5wC6B9n490zqlz7ExZrXo00p1JNIuDHA7qIiU4rxrP+5XD8NIASwzJ/qNG7Nwha3KGYCvGFszCDU0CrkTZhTfK7SCsW+94K4CEJdsPy80Ej3uZsI93ugVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862764; c=relaxed/simple;
	bh=6zZtjUzuB43DWY728l+uMiW14T/qO9xbY9TRH8A8U3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjOh1dGVa57n+BgzIIXXzymefDESdM7DlYhlCc6Jw8VFUyDC+xo3URk2z1X/pA4mEy+L0paPl6NWqsjpEUVFAk8MqPCREFnSaoB1taTqbMZCr0yDVyeLUvLIKPL0cbR0c2lrGBg2z4Kk1mRYl2udNbcLm+qZ9P1UxTU3L/wXz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvrMyQhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvrMyQhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0D61F0089A;
	Thu,  1 Oct 2026 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862756;
	bh=AjYMSH3wzuUQl8tjppok7Nd7i2BUmJLKac/D5JU1aug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bvrMyQhx61yDiInINhXMbuKwEXPbdE+0hrVNVHx9oG2Yi9GqeWpWU2vGdNP3lBDbQ
	 s7Rf21iGlWjn8POVbvVMoWF2yfLhIwUWEIFJuS7I+rYFBBKlUZeA4vI9UcOOyj8AAR
	 UR+r54xO/W4W4yQIn6LAEaovGHDUsmJQxmsF4y4kFVBx803Xtv8JBCufOIFmmAB83W
	 3l4Q7Qhdp1w454l054QVgDel7i57kpm7urk1tbhEeUgUHv+/LkIZHWvvskd76R62Jy
	 xiQgkkqMFws+qu6h2dAv2j19/V0p7IJdlXqnjcZXw3hfXJFChElSWQOsxVac6HcZJ4
	 VWN3jnNGF+ISw==
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
Subject: Re: [PATCH stable 6.1 0/2] perf build warnings fixes
Date: Thu,  1 Oct 2026 09:52:12 -0400
Message-ID: <2026-09-30-1-daily-reply-0008-perf-build-warnings-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929191834.266354-1-florian.fainelli@broadcom.com>
References: <20260929191834.266354-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Arnaldo Carvalho de Melo (1):
>   perf test bpf: Address error about non-null argument for epoll_pwait
>     2nd arg
>
> Namhyung Kim (1):
>   perf tools: Fix a asan issue in parse_events_multi_pmu_add()

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
