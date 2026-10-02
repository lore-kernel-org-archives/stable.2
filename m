Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61254B8297;
	Fri,  2 Oct 2026 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950814; cv=none; b=tgGaUJoY0x9TdGP7519LSVkFRwlm9SxRRqvgNk2qnzsmeh4EHPCMeu/iSDOxj0rcNj4T4p6mfw7CRVP5azRpa4a+PqLuUqkijEwkYeHkEVjut6duSyzidqAY6J8B6lwJ4pSvXaBPP69uphGU+fdu3KGgsoWUJcXxiqZkE5L5D1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950814; c=relaxed/simple;
	bh=x7pCBYkup7lMyBNHRWBlvmijPYCfMr+HHILXsbWRZ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYIYyeqO6mic+ZLxObwB1nWhaEwsUMuuKXxar46nj8/7bkaRiFqk6C9ZBXs3OSOKa/Z2Em6hyi9E1HLUQAHERUD3ztWZTEWEmj0PTeevA737BkfP9SuDLA7HmrI0V+rVqY3mQPnXPMwsR50gRDl5m8M6KxBhXgkmb0BPq/rFRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlAbudz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlAbudz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E214B1F0089A;
	Fri,  2 Oct 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950811;
	bh=+jYPiTuD2TAh39F+Y9pWHVmbpS38eme3NTE6+OygEB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlAbudz1BVD+4PIWG2Ts6HjqPWHXmjoWwpR1YAXNQZ/K1HjmRNP8/gLAoYqjS9sDU
	 90WkxrGu1dsxVSvFFLBniUEoNk2qziIShURRfua/K5CigdzB0eW3tSp9rf1H7lB5PJ
	 aaA6NO/YJb/UCq3HuKA9UurfBIcD30ZigzARcno8odaKTJnIEiV5PWc14Gj/V0HYLI
	 einro9SyRKbZ7QY3U7usu66qyrsoONqZPcRxAnQhpCNOiuQ8RZolDZHC0PxgwEVysT
	 4lSvsZmAYGfxzgpOX4t7UUOlUP/I3Uzaw+PPmCQQFXM9Niid3M4aIBhvVJ3J8oSR+3
	 qb+VpHwV8QJQQ==
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
	Jan Polensky <japo@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH stable 5.10 0/2] perf build warnings fixes
Date: Fri,  2 Oct 2026 10:19:54 -0400
Message-ID: <2026-10-01-1-daily-reply-0010-re-perf-build-warnings-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001160114.801948-1-florian.fainelli@broadcom.com>
References: <20261001160114.801948-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch series fixes the following build warnings:

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
