Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798920;
	b=NHlQ74aare7YM/D/vscSNA1W8ifRSGjzUIsVcyPcbkS21TfN2ZJxDKva0kqvOKviPpbO
	 JOswCOKasxJw9WQfTS/S7+BPa3yYRW9tMxVqemjdXcQhwz6zj7B86aerks0nBlNWvGZTq
	 xj+QcoH9iCXlIm9GQdqAbqdKgRwz98gKykrxlovuMMOq6b6a4HnKF1VIOK5vnk0JHYyT0
	 wdIKTdPwZIsRMK/vi5eNmAF2pFoWxW2jLOGQYJUfsDmZ5E3MUBdWNyETSIjJz8kGBDI5P
	 Ba3QOCjSUVwUyK5Xnr19A9IQOi0qNgQ/mCp9da6ZVhhjYZSJIV+gqnPurztnEjvaISA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CusP5iuHTQw5y390mYkZWLQu5qzJlFufNmxP7wYDVQ4=;
	b=oiE7oc7jlIS+OgC7N//iDITwBjLcGuDX4ufLPu00S+nr2kDB54wHuNMKYok+wxAt/sG7
	 33F2teltBKVYcVp5pDrx/NTi2ji11DnRy+mKh1pI34NzMbv6netrgc5kJAxY08hkap7J6
	 FPhvJodbrEihJAUaQY3jfyUAmFqafsR/5Y4qaYJxl5W32l3yH50E3rDQo7psvJtLe7lA/
	 xrlQBivooZWk1dKDXrrgshlyQ5NXfaeJZnvdhYaKXLNlY/Dmbak1PCzIHJUeLoo3FXNnC
	 kVrd/uLxv4y8TsJ6DI3hzEiFFJZs2sjlmnXO0xaFpDvYBC/xfSE6rowbXuKSrL0IZ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeYi0OkW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F1606A32A
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeYi0OkW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A33D1F0089F;
	Fri, 27 Nov 2026 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798919;
	bh=CusP5iuHTQw5y390mYkZWLQu5qzJlFufNmxP7wYDVQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeYi0OkWN5ppbTaXrUv6iFcz5Nx1Xkz5a49XfqbZ2mkuahsqVuuU0z8dtjXmvhDyp
	 UxNo3dc9+cX62dZDYoV5nOUvaf10qRNm14cqRCZ2aroVwtVcy2+nmirmHShiaNq/nI
	 IuW1SoGiMOD998LMyrdjj3a73YieNle0AqAp7Kf/HKIqTUG6nuBeUKUSfoNpGoO+cR
	 GvqoJUUaTkCwO//xhVjyvbhw4eZ8f5jpjGBKACDiPbpcpoCLQa5V7LihZvTOvPyh1F
	 2NKiqEcj+s2bqkvXr6QURZVVOskQqBFcX4Wenk+ENjDf7Mp1U5eyTxoSVdNQAHc+dt
	 qYgibniac2nIg==
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Dipietro <dipiets@amazon.it>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH 6.18.y v2 0/2] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 27 Nov 2026 12:01:03 -0500
Message-ID: <2026-11-26-1-daily-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5b47ee1e-0b0c-4b0c-9db9-43c9fbaaec96@kernel.org>
References: <5b47ee1e-0b0c-4b0c-9db9-43c9fbaaec96@kernel.org>
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

> Oops, while checking that I realized I don't like that this was backported
> without also b480cbb071020bd590a0dc0166635b448e9fc46b and especially
> 9f2fd03c9bde366c928c9242fc9b2e2c5111a134. We didn't initially thought those
> worth backporting, but now they should, otherwise we have a weird
> combination of behavior for highatomic pageblocks in the stable kernels.

Queued both for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
