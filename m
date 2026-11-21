Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274871;
	b=TexKhepZvRomQlmVRf6ETnvaPU/hs+6Q3FX2PqhgfYIdkZfLASH42M9UKqahZuSEFxlp
	 5x1vfKv3oGnx+QNo0DxNZ7ZLTtzMtqk50JG3WcBP2ZgTVq11WmjVQsoOkrQaDDxYMzsxQ
	 9X6K+6Wdody5JW2uW+v9Zb/meytxs3m1a5zliFh6g6Y8x4TIAqAJhlcXuWn+NUS3rMMjZ
	 yHQi+RwcltI42w7oX6aPTrABz4tTfToELrIC866YlkwukcxRJpDkrlxCWK4v39iElQ6Ca
	 dpBxeOPQrGXcTmoYeN1tbTUnRaEDF9c79zLGL5Eu6tm3+8Ha78Ty+SOiPKdtm6T2H0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ThTgZI/78437YCcIY9NTTebxpuiG9tbBO0b5jtrP61w=;
	b=2ZwHYnkLLEjj7bfJYyQq3SYAa7BgzoNWp7KT1EuF3r4CtgpjdacSG80qnQNHLorSPBwv
	 L8urZ412Lz+kV0NMbzJlA2a8AOmj5oPGvtiAy4tzxTx6Ih3iumJ6wo+JkHHlLkcucQgmV
	 wRFHuzlMD2dxtYaRFUtXZL5STXHtPlhqCJLTBVjRC4VUt9sd/seHlABw+XrWoHNfDNHxF
	 Omwu1h5Zri6Dl+K4vvJMtEI1wT8E5CaFLQa1368t79WAz9tUjaEMD0YxA9XPod2zYqGya
	 x0giiUeKmnVp+vteiZYfvxCERAraiDRnuWFc2XcCEui7aMUo4YRCJKRi8/Ww6OO/O+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVxmQRBx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476E606A333;
	Sat, 21 Nov 2026 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVxmQRBx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D128B1F000C0;
	Sat, 21 Nov 2026 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274871;
	bh=ThTgZI/78437YCcIY9NTTebxpuiG9tbBO0b5jtrP61w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KVxmQRBxz+QM5ZHtPOl2w+IQgYS6UhxAUlvaExTax1UdLW4txNV5Z+55klB6kYlfj
	 eYlDVP7ZK8f3tidjFQ9O8Q6GIOVTqJpPpclHZ7I0rZvLEPoZFDKuT7XFqYZ2FyquV2
	 nuJzvQp96QuQivts5rv40mXW0tOiECOpJwtEKXGObURGDM8xMqQQVudi2oyxPSa+1Q
	 gnZCSDlgqGhNqA6US10BTA1cQ8NW+IwOFbY1S9dHPoiLixDIhMGJNdDIWNOVgMFkO1
	 qAJF5/Q60h7uo20U0lYUQvnksTx89a4SVw3UmmfArk0BTxmpg5GUfZZ0pCUP1HuXJn
	 Vig3w6ij6U9tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Florent Carli <fcarli@gmail.com>
Subject: Re: [PATCH 6.12.y 0/4] sched/deadline: dl_server fixes from 6.19
Date: Sat, 21 Nov 2026 10:27:32 -0500
Message-ID: <2026-11-21-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120181949.7528-1-fcarli@gmail.com>
References: <20261120181949.7528-1-fcarli@gmail.com>
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

> This is the 6.12.y backport of the dl_server fixes discussed in the
> parent thread: on 6.12.y, the deferred fair server can run a
> SCHED_OTHER task ahead of SCHED_FIFO tasks on an almost idle CPU.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
