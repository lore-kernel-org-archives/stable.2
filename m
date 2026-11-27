Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798952;
	b=jK4BNTKlY2sJIa6PBxAb50s+0zb0dOxGgQ5MJMMhTkUUr6ia/LUEHz5+A37x2mebExoE
	 h4Ye4iZmn4tjUXyn8V05OFKnzcuBpfWS6YULzvNk2pG5la/5jiQzMfuO+bZjqpS15sdQc
	 QC0Y8GKT/jl28QFdOgcxGUNZMh7gvDvlu1IQ0g2KV7L+HNk2FFeGWCcmZS9PhaoDqsl5Z
	 LbQfEp83lEC5BqVUv9iA/IeFIrbGXm2nc03tHwijoNdtxjre3HEJCl1GkI25gZCpodvFA
	 NLPaPxZfoVcbFXdWcXyR838UejFNbO6EZZfNoozzRKH+LEfu+xshOYdvsgLVNOs7BKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hxH3SKoTtlYhP+9zufXpBuANDSaQYvVrNJsWpk6XohY=;
	b=CA2OSOt1arUPWPtRUCVGDq04CDm+emaffO1BljT2EUWmqlIEuLQRagL/o94fqWo2QB4R
	 L2PGcyaG8y2k+xQA/BmSUhGtknH9PZpJVDwKecS7ma6ntyQcuhXm/xHSJsw/kkddIcxF1
	 cTSjac2q3L34BRh2GIC3aginL05Vi2AWDezIacNyXyBMQvjo/HP5kkOU+lbFWfJ1tcCVr
	 F8WUGwRDYCMjqGWIRRKmUfx/MYJudoXJ5vxvo8jvg2XJlvbjfSGtYPeEvFCmTLG9yXFNV
	 WlhqV+4oEpkHRgNA7+DiFc0x3tMJx6SHB9Scu25GCDDRBEDySKeMeuaTSOSOX4GzFrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBVyBRi8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE4606A326
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBVyBRi8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2113A1F00927;
	Fri, 27 Nov 2026 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798952;
	bh=hxH3SKoTtlYhP+9zufXpBuANDSaQYvVrNJsWpk6XohY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HBVyBRi8xc1xoiTcmZt7YRxAxSEUpP4TK3AbbjQBo4NZkVh6wTvcdgrnwQ/NhiGVX
	 tg/moF1U3KySpXfluSOANAj4xvPM5v1pIzYGhrWSf8E0HCZI70HPYsKUCWukltxt1Q
	 DQmeqAa7U5lXLgdLVCP2hzauanzk6v6d1A2EK51kBSa9nuU3+Z5x9gqrPkw0MCO0tV
	 0IuLsT7p4r7Ol5sJzVrClntRPnZZmPMx44DHV9W4OEZKxZhCNUOJMXuJCJ5wfMQKfm
	 c1bVKEwMiRqibX3zOfHbkR6TQPGrbtLHUJPaPnViLQSzcfvlawYDVOAvPVYC5gSip8
	 uG8etJ0ZCY3og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: Re: [PATCH 7.3.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Fri, 27 Nov 2026 12:01:21 -0500
Message-ID: <2026-11-26-1-daily-reply-0033@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125130843.3343543-1-imv4bel@gmail.com>
References: <20261125130843.3343543-1-imv4bel@gmail.com>
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

> The following state transitions have long been a playground for
> syzbot, and recently AI joined in, reporting a lot more bugs.

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

7.3, 6.18 and 6.12 already had patch 1 queued, so only patch 2 went there.
On 6.6, 6.1, 5.15 and 5.10 I added 404381b4f105 ("tcp: Set unhashed_state
in inet_twsk_hashdance_schedule().") between the two, since it fixes
patch 1.

-- 
Thanks,
Sasha
