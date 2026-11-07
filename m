Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071394;
	b=csOp5AWD2K0R1TsO9J86IMXiHi08JSe3lprygxqsezilxI0HWbQFpl/7x10PwDhO/kEd
	 JOZnM8rc5a3LtSZbWE0PMyRrLrTaB63THlRNlbZgS1AM8JVJ895fpFm6Z2nMlKLmzaJ8x
	 xHRC2BlT5qdMZwkVpNXtMILohKumZUcqX+9ITQYXIwIHnTgIzBt52oaEMpHEJjwKq8rpe
	 WQ/mZow9Fj+KRG3kgeJ+ICvcUTFUH1uH2SD/7JHa7eAUhEH4/Pkx9G+/7u7eVHGiZojd1
	 Qwf51Hi/xLDu3M1h/PKoaogpguvw6SPufxayU7Kqkny0L2w5ckJ714zcZY31wzvj80Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NWXaOqajtyjaMrdNhDJigM15Pwyn0MgbFmowXImwBVg=;
	b=gX5M7qLY9HinReriqzMPB2GifKKlGM6CIZz0Ef8vS0VbwPx4sBC4EojAUYXbPklQJzxw
	 01RH5ySdPMrotf7J08jo1olmd81vihGZOkcbZYoN1AIxhZ82f2rOGDGgHOBE525o7bJWX
	 PnxaUXUzdeYmhIRNOWNLYhgZZmaeyltUJTXAdlczwi88jHsW3kUPeGpPQCXuTNBFQEcp5
	 q5TQG9aezau6cJs0Rx/qJ3N7xMXspkSImfmlzUDCnPoOzUyCOTfdBY9X0j9+091jUMgvM
	 t61zgGggz0qqlQbvDmO1tebjxOzoAvp7LR8SDBJc2zFJrEazKQTRUABfcaTPnJ05v3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAV2LwDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAV2LwDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B601F0089F;
	Sat,  7 Nov 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071393;
	bh=NWXaOqajtyjaMrdNhDJigM15Pwyn0MgbFmowXImwBVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fAV2LwDlxnHi0ODXcerQK6JDj8AbS80HCTYkXtEbAaI2W8db0XjuOk7U+8qIM4mWW
	 +t4VejS6hoEQacVgBzhkcw1EP6bcH34EktGkzdny05Kjd/5wg1rLC2mCSN7kJ2T4pR
	 OkP0ogZuLZ1fj0HEGrScZKIUjPUILszRzEBxsVp4GF08pf+Bm7AW5sqD4NH8m9KUKg
	 K0TKoDbckNMpmahbWT0U06OpZWVQwQ4hIHcgN3S1gi5x0iFQm2Xj0jZz1fGfabbUt6
	 1ySbPbIJbH6fTnoBZLAzhwVP0gOdzht072CKOU9VMneLIk8aKOEdiE5m7IZdk9O0vk
	 ++QVzKKx1ZOWw==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: return an error from damos_commit_filter_arg()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 09:09:45 -0800
Message-ID: <20261107170946.102430-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107062110-failed-5.10-6f276422aded@kernel.org>
References: 
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

On Sat,  7 Nov 2026 06:21:10 -0500 Sasha Levin <sashal@kernel.org> wrote:

> The patch below does not apply to the 5.10-stable tree.

5.15 is the first release that got DAMON be merged.  Why are you trying to add
a DAMON patch to 5.10.y?


Thanks,
SJ

[...]
