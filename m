Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255606;
	b=g8pf5J83Nklv9csyid8P71ZhZJ8wly2AA/P77JlCbNqYGzdsqLGfB1DqqE//y/BylXV4
	 iM8FwPAjjOx8EUStD6EK5dTSP2uwT+QHv//NdpwT+FpZcC1OZTKMpGTayhnQIlSTuKUHA
	 WXPYyLEc3yLpirqMoQID32hpm6iihWh/T8eXJgZps6TAKDoBZ+GoiplY1JldXJfLqGVja
	 XFiYYVVD1FPRiSchRjQhYlycMvyLNUHqyuaPbHMLGsdHjwV2TLLiL3hyFMM4GYWVw5C4x
	 6U00nwmyw+VmKisMphFzX9ruF2ULjV1zlwoipUXFecIJz4YbQUiP9WjD1XqEttDAHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255606;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dKdPaLpeURROu7r1ylsmBxinR7thIXhk/SQaVUZfgEk=;
	b=4Akc0K8f6slhivjvA9EoVc5uiuaMkkng5fdhtyiefUnCb4qzKuOYV9gG4gRku10V5q3L
	 80g+MrMuMCs425SOUASKCPW8I6q1sNPkT76TUC0h/xmw0G1jRxdWLiq5sxFduzAKn6rDF
	 HXybccIUvVHHTz9Xpy6/V0ITcdADzqsEviMr9Msau40u2sSzlaDicwCVCnHgnvial1MLY
	 +nmwZYLRtMMSzWCynbNnh3m/3ivO5r7xq0kfOd0yL+EtQCnbW16Ova4vtG9vzaRtlgEJN
	 WDS2igqlfFjJhguMWHScZvL7p7nDVjV7DNvUnw5oN22I1BDfz7pLrKMTCmJvtZ+RRTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=c8dxMWIS;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39560606A31C;
	Mon,  9 Nov 2026 20:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39560606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=c8dxMWIS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1794248808;
	bh=i3ipDART78WTq85AmHOl70UeNqv+mMy5wJ+w7QZZGrc=;
	h=From:Subject:Date:To:Cc:From;
	b=c8dxMWISkWbhMvV1eJSCl5vL18TS+fRrVLNHKyNSUJwf88d4kBKdkFNvdF9a1GlDe
	 tlQZ+qX9plujkl8Ty/DGjPtj7h5/NtBX3+60lyonAxTqRPrEo7M96fMtjNO9n4Np5K
	 bo2gyzq5akNR4fYx/pMKoY7ztA/x7fUoONUlQMYc=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 740F540576;
	Mon, 09 Nov 2026 10:26:48 -0800 (PST)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Subject: [PATCH v3 0/2] futex: Canonicalize arm64 tagged user addresses
Date: Mon, 09 Nov 2026 10:26:46 -0800
Message-Id: <20261109-futex-tagged-uaddr-v2-prep-v3-0-3f5f2ef83138@gentwo.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYQ8moC/63PMQ7CMAwF0KugzBg1aUgrJu6BGFzipBnaIDctI
 NS7EyqGiomByfoe3refYiAONIjD5imYpjCE2OdQbjfi0mLvCYLNWahCGVmUBbgx0R0Sek8WRrS
 WYVJwZbqCKQl10exRKScykJcu3Bf8dM7ZcewgtUy4IpX6kMid0V+wBAm1tjW6hipj6qOnPt3iL
 rJ/F7RhSJEfy/GTetf8Af3l0zyzUkpqKi11Y3FtnOd5fgH/FczJWAEAAA==
X-Change-ID: 20261030-futex-tagged-uaddr-v2-prep-63ea40b5a22f
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Shubhang Kaushik (Ampere)" <sh@gentwo.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794248808; l=1040;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=i3ipDART78WTq85AmHOl70UeNqv+mMy5wJ+w7QZZGrc=;
 b=B4F5M1i6XMKJE3EJUI7+MnKXXrYiv2S4rG5EcnZ56MHtEdC/zLHUSEdbfBEArp3xCJX4pVf5V
 TGeYa2UM54MDAwgm9PnSk0t4oliEvcXWDZN4ypBXVRzO3EECLDeT2Cq
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

Changes in v3:
- Split the stable-targeted futex fix from its selftest, so the
  selftest patch is not Cc'd to stable.
- Add Davidlohr Bueso's Acked-by tag to the futex fix.

Link to v2: https://lore.kernel.org/r/20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org

Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Shubhang Kaushik (Ampere) (2):
      futex: Canonicalize arm64 tagged user addresses
      selftests/futex: Test tagged arm64 futex addresses

 kernel/futex/core.c                                |  2 +
 .../testing/selftests/futex/functional/.gitignore  |  1 +
 tools/testing/selftests/futex/functional/Makefile  |  1 +
 .../selftests/futex/functional/futex_tagged_addr.c | 61 ++++++++++++++++++++++
 tools/testing/selftests/futex/functional/run.sh    |  3 ++
 5 files changed, 68 insertions(+)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261030-futex-tagged-uaddr-v2-prep-63ea40b5a22f

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

