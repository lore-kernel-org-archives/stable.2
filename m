Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971006;
	b=vtoBxXclb18MoUa0VYMeLgYfuDkOXn/Af1qI50d7FFpqOaULAIwIGzfsPD9OUjpeD5Pa
	 RHyCeALe7q7YGcyrarWi+di9x8W3TuOy/Ib5w4g3tzdGtL5Hpz1bGz4PTLjV9xyAIQprH
	 1A1u10DjAwYQkrbWh/cCegCNe86GKmoKbndf/tquRVVVKh6OsHwZkUpLbhyN1S6WX4VSg
	 cVgjUc0sVrT0oIRn0xAcmNciAhpK+nrCEVCGCQmCLLGDdLSOgyRusSjWJ9GzYPowfKMBe
	 UDUC3ZzR9349Bgo/VjuMd7zM1THyivgkQ3VoxPd+lK4ZqSIlZ5eh1IF88CN8ae4XEyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FqPmJOAbzYKkXYZ1yVKJ1pq2hTlTrr/whcSsc6WuBHI=;
	b=xJ5+b+NZT+rzsQzmNYNLhd3Msg11jFu+l6tAgRkpNvqXA5vfxUmx/2Eh2hAJ24Y5KBku
	 K/LQ54b17Y6tCtBRpISMWXBIbPCfZgXCnad6LkS1nbMj1tPkmaKF+Im2X4+TYrU4hMaKF
	 cIQDzIE8HkbPEXYY4CwOucFZLcOppUgogC4WypiUM1wUt/UUm+SPJ6IKhwYbnqrqIpYGd
	 o1RWoJkX1/sdxJUB498ssWZXrGetIeADeDRaWiuxAB3KVCq4ikEeW38lSqFeeEr3Sm8g/
	 /UZ/etm/tcUzb+la+fsayVHk43nhW+tcBmd/v9dse0T7/KfSJB0l6ml2Miwp72cOGgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxRq8lhN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5194606A31D;
	Sun, 25 Oct 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxRq8lhN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FC01F01828;
	Sun, 25 Oct 2026 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971005;
	bh=FqPmJOAbzYKkXYZ1yVKJ1pq2hTlTrr/whcSsc6WuBHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NxRq8lhN8LIRQF2MgCDMKbrFuz3yyqM7FyHuxLeQf6eFt8Wit5S0M8lzlETju1rhG
	 v0eq0l6WMW06+QpxoPTqN0UMoNclAO4uBHh1+h4wsXpkehtlucGyzZSuVsbRFL2YIg
	 NXr+1P4Qz8dMY6H7g+9zAw0AVXZ56achb43Q6gWqTjcX6hgGmxqolkgsq4IIgHtjwF
	 CKlCO1BwXw4kRInUIAQxW/Hwcah/NVhoxlWoVDtqStAM89JiVcTE9q8Pq+RVfPsN6h
	 mLFDb4X/2jx7ufkGmQluY5sJOoZBLawRJdU7uj72fEtaoWr1Fra7hZrv0DKTDN/QBF
	 fKCcJFU5a/DFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	lee@kernel.org,
	netdev@vger.kernel.org,
	Rodrigo Zaiden <rodrigo.zaiden@canonical.com>,
	kuniyu@amazon.com,
	Tamir Awad <security@auth.ink>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
Date: Sun, 25 Oct 2026 19:29:51 -0400
Message-ID: <2026-10-25-1-daily-reply-0005-af-unix-oob-skb-5-15-hold@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink>
References: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink>
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

> i sent the patch as a file, Thanks for letting me know.

That looks good, thanks. Since it's a stable-only patch, an ack from the
relevant maintainer would be great.

-- 
Thanks,
Sasha
