Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318769;
	b=OL+T5kYewf9FyjYKjOeHZ5AG98i0xvkRh1bNZrSh+pc1UOrudB3J8IiiAZWRoLOMglIl
	 Biwcrs6O/sGS0X8Rg9Yz8YkLIhuHFMclsKVx3Pp0In4aU8F2HXtLuX9odgcuSlVRKlMAA
	 AuLXagBjRgPiWLLKa7DgI3pMOxYRHch36LAQAu4uVKD3FWfZkhI3WUGU22cRAk8tnTm0b
	 kw0Lz5kIgoVWbabXcZ0V3l4ntESNw8VLhLMuoz1ekWaENLUnuH9or20sgIcjeYTmLxaco
	 K9G96fHnhcHdVSS8+1nUCHrzuNRRDmLZqgDamfP0ppptZ+AKV/D9KznXVmXxptTApwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ToK3LaG6t2y9Y6EGRLvRpjJAIvNFlH7kZUIxdiIEtPU=;
	b=DJquQ0f2XSdTRu+LqiDJ9zyy0/rmqNyuYpBY9Ebxa4BHn42gDxmnfzFpF26o8VJ1mOIi
	 69UcuvmBTcRfVdyXdSCtWdkxIjt9jQ+K4fEndoOXYid4wH5pR5ZXAHXdR2CESF9tQOatg
	 CZW6C2DKrEuTjQW1Ozi7oWqpUCAzDu1YayUJCrYIxg0yK0Og9WQxUhKhZ+6QtHpSWR0P2
	 TV38kQcCgKnylFdw2UTdkPic0ewfXRzU28bzOOOKZglljXw4K0fT5FzJcrtKC3Bu8ROCh
	 TjD9dk8l9FYG3qY0CmArh53UVCbRdOfjA+x5q2RTEnlD25Sm3UiecIni+m1m4cvNwHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3xVgitn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB55606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3xVgitn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96221F000CF;
	Sun, 22 Nov 2026 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318769;
	bh=ToK3LaG6t2y9Y6EGRLvRpjJAIvNFlH7kZUIxdiIEtPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3xVgitnxa0gwcUyho2UgUqYbpebkuVUsFGTpQ5XRyGoBmV8HCvOL5mFj0gtb4h02
	 Y4qtQTFpfIhKhKC+7pqexcO5RVSUer/VMsGWhD18l6TyP8W8MyyJexNcI6ydukOUGP
	 mC4yDWwxyrRQ/0d5yLeDA4L9FPcafVYZ0wHAyccZ8BPIfYL8MzHkzrzFCezzQtErdP
	 AEgP+LM2Ju8VO5eCSgyNun9y5Fm7cKMa5Mt4xzFtSTQah07w3pNs9NFYuPmRaz48z3
	 03cYb7K2vVw1jwo4FS+ZlEYRw+B2hNNloOkrEU1sXIO+jd8zawc+3y+D1NMkrtC6K4
	 O067O5qU3cZ8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.18.y 0/8] io_uring fixes for 6.18-stable
Date: Sat, 21 Nov 2026 22:38:55 -0500
Message-ID: <2026-11-21-2-daily-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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

> Here are io_uring fixes for 6.18-stable. All 8 patches are in Linus's
> tree.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
