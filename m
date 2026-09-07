Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DE19644B
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799180; cv=none; b=XjOCDWLpA8JmbiKJMb9fOuLmheT7JOccZjEB3qoEHFND9m83IzbIx+sBXeodGDBVavpEmLea7LQG9XGTZGGsJXt2gL5xDN1zb/OTaNkILQOqSIZM0aGZTBThrLbXczMu2awHV70BPgUpwhS+3DiSuBvmzzWG/JMHoO86KSaPa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799180; c=relaxed/simple;
	bh=JScLvDY1v4ZXDmdRrVKEysuuyxpgWjgoIm5gZeod+cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqexmywoCainQTtjdOKZsdyvgFti2oHwwvuw4oJ8S8C3JfD8c3zjaiN+s2cm7x+QGdl6QQL34/ZPyWmxCxd/JcXWJflOysCrNcNKpWHlomHYFBbTj8Pjs0OK5VfvjGpUvOcwYJ5I3eDU0tN6xawVKQo1QqWlYSP/+1ixY573DZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZrfW8Fd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZrfW8Fd"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2637dd37c1so236838266b.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799177; x=1789403977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtaQqVSlZuFX18DeVPVqwMKwClza0Yn6Bnu05r8m2bg=;
        b=gZrfW8FdDX8V0jv9m6KpwNKdrnt4lHPBlDsIEuo/LaVewlK1+CvQs/UHN3ZaPYfVsB
         HJV0VZeEyNTKTUF087+sbO7spEpAXS/Wdm891jOjqbSH6BQqgJidW5ZSKVQySIHqznzL
         TmcqLdrSRymDQyBPMPNnGQO304ljoODI0Y8GTIRHbVWtOrjLtP1+0WOJaEfWL7GMGm/r
         Vg461isbIpI8SY6exvzD94m+GsyO7R1yU3B4gwDNhGRsdBqU89KyzqMj4iHn74mJF8ds
         5wF45BYdDxtn8FLsfSh6dFcMxuS9vxBnuLUqimygEoRTXGHfMN4OcsvXS5eBvzPdTHbT
         WciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799177; x=1789403977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PtaQqVSlZuFX18DeVPVqwMKwClza0Yn6Bnu05r8m2bg=;
        b=B2zkjDvGV+TVyTu8t70dXMUt6iRqbJ/Ebg4MP+zme69sXHBCsSdovh6FnnMvnpb5r4
         LQ727TnNV/OktuncX24uixEgtSBdgd1P8nE8xsKzPuh+ijsULCtGyo56M8M2XI4cKXmR
         cCMhHY0Es52pQNQoUhLKaoUQWyEletPD3HIb9uMxcUOu/ZBnE1TJZoNe7Bn8/qxPQACR
         DldqsUVaSCrCX4kPv+Y86wA0g4qwljPtJOyd+FGve6d73O/sQ6qi9+ZRPMIscod3SRpS
         fskO/NqrDp39ihvM+yMw9HQWt6CrsPRtlvwZjyBjHKR4uw0Vaqk0S0srMHM2ufCo/lV4
         KZ1w==
X-Forwarded-Encrypted: i=1; AKwUvBzX7opYk6BUZoisUuT5sZ52gvzOu8Uy++tqrggU1f3roKZGJTzihxUpVQ0jewVzFYz1mTl3gik=@vger.kernel.org
X-Gm-Message-State: AFuF++kC5vMVtjWxahsqRBoD9z8K91+umTu487aoIC2/iPbrAXyu53Ta
	u/nylSgK9i2pxv8LyfqppgzWDvQFrgs+aPHPetr3ra1KYuvd9snwiW2TVqoxQR0a
X-Gm-Gg: AYBFou2GHvTtyK/JPH9tgYOZQB+Gm7xGpyqjHOSJfQxxIAQjChST4ht6JTVrFwxN8SP
	XTHha96DbLbhdZFPd6+7j615R7phxjOtrbBZmbh6ogbrVtCfYbKfZSDa1PzJoqrAXBaDssteJNK
	if+y7Q1EV4PXaKgobqfyR2FGChkO5fhl84blmXCNODehvnP6YCB+CNlLSlYBoaJaeVhPtMvdugp
	4FTulYFiHeAbjKVrkbVs0neq0bHSneOtiCMVhFFZIPECDSXMCLVOxPkuKhRGtN47aNshFc4Ys5i
	NiBcIGoaD8Lf1g4x3AhpzfoG8CGfpguc1v6a0oO1Kuu9UZYzYP0RVflt5PkMU4KXxrLag/i7gOP
	rSDSMzae8J8HY0wemICGAryJecrFsrADPFMXD3NgWVxY5XGsi0uFiPkEgpElLw/s2nJwfayAQs5
	UL8uApb5sTAlYnLY7CXLItfQ/YNTfTA6LnpmNPrJmESH2V39coe3/oAH5Fas5+pAnafzCL4J3+f
	Aw0UXcdDA==
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47b6 with SMTP id a640c23a62f3a-c261649567dmr733976366b.44.1788799176674;
        Mon, 07 Sep 2026 09:39:36 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b89sm483434766b.10.2026.09.07.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:39:36 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	Ingo Molnar <mingo@elte.hu>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 5.15/6.1/6.6 0/2] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Mon,  7 Sep 2026 19:39:17 +0300
Message-ID: <20260907163919.183961-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902122613.442176-1-alexevgmart@gmail.com>
References: <20260902122613.442176-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport fix for CVE-2026-80689.

Masami Hiramatsu (Google) (1):
  tracing/mmiotrace: Add NULL check for mmio_trace_array in logging
    functions

Steven Rostedt (1):
  tracing/mmiotrace: Remove reference to unused per CPU data pointer

 kernel/trace/trace_mmiotrace.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.43.0

