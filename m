Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED745D1B5;
	Tue, 28 Jul 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255020; cv=none; b=QOJJcQkfNmnTH3+0RXZJhpI//gU2r37UGVe5kMJYuu+HMUhMt/xB/NjBNuP+rUBVZyZWyLmIB8t5Yv6b4FLhDJGK1XxI6SKTv6xcsw8kbfOj49Gs2go8+tV8MwOluXqWSUnwSPq/UwFQ2C6OVYiV8EsifzddWNmKSU8tGFr9uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255020; c=relaxed/simple;
	bh=WC0wAWcS+Rk5VPVSZWJtfj3D6fLcbIRrUEk+4PjdNJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEfeMPaedfMhY3UZDTi5s7/SzBQvg6G1SGGOEv5IJ/0u7w94kchZeKXmfaUORK9NOaPMl8NXAOEnLx6hxqjW9b6Ox1dwdDSU0CyepeIZqGpepDuJmcD6zwgW/TbOJ1tt0TDbCBBw2XMH0NVpi3581i7BOfgUw1LSrzPKXX1Wl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AplC9xsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AplC9xsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C0E1F00A3A;
	Tue, 28 Jul 2026 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255019;
	bh=XVEhoXX/Q81ghhTDpZ9XVZ6O3qk+9cBVqwxE1ASeBvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AplC9xsiT6HFsT7LA6g1z0RHeSIDXzjZnA9fzHlTvGqgMPX9oLhcrxRuHdNuYyn95
	 Ot7P+9rspPtpB9L/hmPocyobPhNMJO2FX+7GJfAPfuyaDxOtAt3ZI2iiAlxBy5DjkI
	 GLU8+eCrwfcWxQm5mHe/9LEsSfk20n8wAi86O+0rCHAUOv7A3DuvtNMZHSRTHK+R9O
	 Q0kMfztV9iJmUpPDFCua6vRibJkSVZelIdUVIR5s8AatAhJmnj/AZTO4Dp9JJy9V4H
	 uPVCAAGnbzLeN79jxg+ABGV3iEgowna31sglHHTXunEO79ny247NgTjhjgp/9X1mRI
	 mG8+bFkbZ/TRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	info@starlabs.sg,
	ast@kernel.org,
	lulie@linux.alibaba.com,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dust.li@linux.alibaba.com
Subject: Re: [PATCH 5.10.y/5.15.y] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Tue, 28 Jul 2026 12:10:00 -0400
Message-ID: <20260728155654.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728095435.115338-1-lulie@linux.alibaba.com>
References: <20260728095435.115338-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit ee861486e377edc55361c08dcbceab3f6b6577bd upstream.
>
> Usage of ld_{abs,ind} instructions got extended into subprogs some time
> ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks.").

Queued for 5.10 and 5.15, thanks.

-- 
Thanks,
Sasha
