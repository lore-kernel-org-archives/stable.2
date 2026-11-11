Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412527;
	b=y+s4wyl6CotYvShu3rdJmgdKgGnb+f8tVoP2+BxbeCRIsk/28BJU6L80MdFtSnMEfgD4
	 zDDokDHdCRPi3a7nrLCciC+MABAzUslhxb74pbC07XDsIiu7A4BWyNceA7d/0DLRG1/Sk
	 UUoeGrjc0Fjs8IRF+kkCBZK1GSUmYIfK2i2hmFzT0mcwx/S9ouQaM5wi2xnlenyAVzJls
	 hGOwH6cTadBiT231DW3PuCwL9/LMdLBdHOZ0cHqj/L6iVDsuuQWR6VVSAvQPL5IHliNoc
	 m1ULOJbNPVNmyQXWZLMdWdgPJaOV2slm9I+KhcA6mLOTZZDRam2iKgQTXhpbxwY7opQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=04N3i2rlHwXk7silDy2AMMY9keO8OlYEIpIsofEO62s=;
	b=uL1ot5n4CSvBSAAaonoGUloJy8qTJrWsHc5WnSsXAyjdfV59Jmghex7SevoOjVlYBCQa
	 +e86ZKg1U0VLCP9jHqDfSYMki09e6Sd1ra/FO29wWF0d+zIXD9BgXI5tYmdsORvkigp5i
	 YZDyHjIJ7FFlXvdw4PAGC6MJc1UBYwHw+oul4PbOpfYbhlvWMepY0Xf7vax9q1OrS8COO
	 eCLv9zmFxAh6zIedzMCgRyYRuVESlq7HZ4sg7h7AC5SlBsgWGumg2J5U1zLzQx/0mgyf/
	 LL0mDwc5YhmNsyvYDuvzhuMj4NZSa4yoAwssdiR6je98QlhzTQXhfmrukTX3Srrucyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY7JyqDe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D745606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY7JyqDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576BB1F00A05;
	Wed, 11 Nov 2026 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412527;
	bh=04N3i2rlHwXk7silDy2AMMY9keO8OlYEIpIsofEO62s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WY7JyqDeZl+183UsmpK9YlUn30IZ9sQ2HW/WpIyJRnpoYoDAEqmJl6Oz4tAShV1xc
	 Ty9D0UHD5Ba4u8zNe4GxXbwDHzSpzolPtxurJSR+fzyGS3yJyO+R5mCCcFEe48zMOu
	 Kc/P95p9JIU/QOI3r0u2dFO6ZBbaq6YHw4kaFg5jcYmXnG2NSahdlKKzbesoQ7WtlB
	 EtOcGnefon3AHJaUEgKk6Ho/nIhBabIwoMN/DlBps/qEkPAJ4KVbnPIchNNXb5y3LR
	 Cp9VPl7kkXXIZBf1XLxKXFWfc3WtioeX9ch6000sgtKN+dfWaPm4OeJ9L9nXw/8Rou
	 PGY4zRHHm69IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] kernel/panic.c: format kernel-doc comments
Date: Wed, 11 Nov 2026 10:55:22 -0500
Message-ID: <20261111155515.2677444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052212-failed-6.12-ed9e4c1ff15d@kernel.org>
References: <20261107052212-failed-6.12-ed9e4c1ff15d@kernel.org>
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

From: Sravan Kumar Gundu <sravankumarlpu@gmail.com>

[ Upstream commit 85915c6cabf74d1f693fd09d95c25d838b82c840 ]

kernel-doc function comment don't follows documentation commenting style
misinterpreting arguments description with function description.

Please see latest docs generated before applying this patch
https://docs.kernel.org/driver-api/basics.html#c.panic

Link: https://lkml.kernel.org/r/20250516174031.2937-1-sravankumarlpu@gmail.com
Signed-off-by: Sravan Kumar Gundu <sravankumarlpu@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ed9e4c1ff15d ("panic: restore variable arguments to nmi_panic()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261110183723.3255298-1-sashal@kernel.org>

 kernel/panic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 16c21189c8da9..d5307a8e89283 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -325,12 +325,10 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 }
 
 /**
- *	panic - halt the system
- *	@fmt: The text string to print
+ * panic - halt the system
+ * @fmt: The text string to print
  *
- *	Display a message, then perform cleanups.
- *
- *	This function never returns.
+ * Display a message, then perform cleanups. This function never returns.
  */
 void panic(const char *fmt, ...)
 {
-- 
2.53.0

