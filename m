Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEA5733E;
	Mon, 17 Aug 2026 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937128; cv=none; b=dvZrUyhzApR45KuYvdbSyW5lTIUwvShBbtFmBrlY/4cyHjf4MkWKkTn8tRPKOnOaeHTELANYWOZhUxWdgp55S825tPhIA4YxHadd/+s2OqYrpI4WWc7AG6sGWvMiTWOo+zXogaJE8f0u7Zm7l0WRUb8zLFJlDVqKihTV+Gy2Kfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937128; c=relaxed/simple;
	bh=56S7aaI6U1DzvrRpQNKYwOMN3CcPMU5b2OkuVKplr08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmrIbLQ/7mlIViDDN+oMPkvcNOwQoxTGDDtA77s12Icxs/vUq68GmKszTcLEHcAmrHRXSAe3MTumugH219u5mpDT0Q4aQwiuTO+rawtJCRP2vPYLW4i6qlZqL3ykOYPSMEBb352TwimnXoz4C9KHHYTDAk/sfcP4dlfU99kYE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1aLBwpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1aLBwpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621071F00A3A;
	Mon, 17 Aug 2026 03:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937127;
	bh=ExkQRG/PYDlUOP5QJ0lJRIBG1zmH2nssDc4otXCx5TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1aLBwpYI0Yja7V9/FRNjR9XY5MXrv4icefqBsxTvzhEXV/QlWeKF/OKSrgSvwjQO
	 b3qOYQI2ljUIsLOLHQ7pfcOYSYErmnefR7OCLnug5LGGOhUMIGvWTIICk/PxJk30hf
	 ddwJ5zMC1WO2K5sUPxKW5+t0yb3+7QH7yOhWBR5dCOvHk6dwbBQth60fZxv0u2RDQF
	 L2gKyexMyWKUpCRHoZ/NNu8PMtMz57dE/cN1LHCAO5AIz1lSSkI9YLukEcUMPDzFa+
	 NA8lPS89WyQt848t8tzarL6Aq1RyJ5VyBvO5VQBh2FBK7JqOxY8B3drUwOJlsXCXXw
	 5EUyUKP2KnJuQ==
From: Sasha Levin <sashal@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re=20=28SUSE=29?= <ricardo@marliere.net>,
	Michal Luczaj <mhal@rbox.co>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH 7.1.y v2 0/2] selftests: Fixes for BPF
Date: Sun, 16 Aug 2026 23:25:13 -0400
Message-ID: <20260816211000.7@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-0-c227473a2300@marliere.net>
References: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-0-c227473a2300@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider merging the following patches, found through openSUSE CI,
> for test_progs (subtests sockmap_basic and sockmap_listen):
>
> Changes in v2:
> - Corrected upstream refs

Queued the series for 7.1, thanks.

The kernel-side change these tests follow is released on the older trees too,
so I picked the same fixes up for 6.18, 6.12, 6.6 and 6.1 as well - 6.6 and
6.1 only needed the sockmap update error handling change, and 6.1 also needed
the test_maps.c counterpart.

-- 
Thanks,
Sasha
