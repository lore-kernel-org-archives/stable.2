Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798944;
	b=CWNms0LsoQAs2xTeBaMka4brByYHZvxJgWRoMjvkXwUOcziSJvJlT8VY7jbQmuunGXQa
	 7HNLHy2F8t1fefwnUd5eqWZMnWm99bHtjTYYZ+MiU9FHXYSDGySEgg8g1WohZ9kDnsiCw
	 2LUp8Kx9TrxryQjwX67ZLMDqQZpcYFMmJy9iXyYuS/ShEHfNr6o2DteW54/iLkBrSehzD
	 LMuTZ+/7t7qbgVbbr55pn12F7M/Xoel5/TEpt3eksJXciry6A5JfO09tJlJWy37eMjsc0
	 IaErTaw+Y3Mnd7DSn6yg6KJuEjczWLsUqDfhXH2mAar6wyJMzPx+/0fwy8gLo/4wwlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798944;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KxLg6Gx/zGlioMjDG7k4tE06ODo1W3pNMbUCbFfp87Y=;
	b=hqout/7AmYXK5Xef8K0ULxrjdv4ca6sqjLBDIIbCsmriY7e5lYLQnam/aiiZov9jZwm8
	 uLUyMQPjsl/VpZaVH95jZfuCTm8Bd7iFS26RUG7f2u4bWUQcLy0+K7YbxqH1IXSgNqKsb
	 TxOi0bf2RSkzgjI0XZhiqKp73zRtaAlHLRZXz747vhliBk3CZ/acaN1YwH3LvbaQbWidI
	 29v9tMUGDeQLmECdV2B8sX3JCI6Ajj0E1P4AfHq0FZ9orp1hjalv5L9ajRiFptstKZAXS
	 EnPWDLsRf6gYiAhaK4stZjCSgZvA8rimf7cHcBiyKIHH5WhpWwZGat0+WDTnDhdNSiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBYG0roX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F026606A321;
	Fri, 27 Nov 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBYG0roX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967F11F00936;
	Fri, 27 Nov 2026 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798943;
	bh=KxLg6Gx/zGlioMjDG7k4tE06ODo1W3pNMbUCbFfp87Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZBYG0roXlSFQCiyazn2M6kil0iU0nWj+gXJJ8FjOwJGMNnIO4++FGk70E6LvTcGLI
	 pbGF8iqEAGEK/zRYx21P8HMuk1c2Tab1ZU7jI9pFwuxmfEED0vAwixWew1YjHqa4cK
	 IP6YuRLcvu7MTlSh3ubjMezkAcJwMxGA2EFqZMtKW/eNUoc1NJVvLH2LdeUBnvlWza
	 NtRJqvjCQrUD+8EWSVlZ2mkiYbfCMszP0LR2lig+fjt9uozxiWmBYzl3qo2La8TbIA
	 LW0ytFjitfhYIWaid4WO+Yg4jdbGmzCPKQ8AWI6boJ6d4rceYl6KkmSQlFMMY8VSNQ
	 IsMqNhea9ZK7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Song Liu <song@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	Luo Gengkun <luogengkun@huaweicloud.com>
Subject: Re: [PATCH stable/linux-6.6.y 0/9] perf/bpf: Fix NULL pointer dereference
Date: Fri, 27 Nov 2026 12:01:17 -0500
Message-ID: <2026-11-26-1-daily-reply-0029@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
References: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
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

> We hit the following problem on x86:
>
> 	BUG: kernel NULL pointer dereference, address: 0000000000000000

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
