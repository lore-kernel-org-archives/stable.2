Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECB19BC8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245428; cv=none; b=kLKy45p7m7Ou813c5ESsjkP+FK6H6eP2lgaAyBZhArpwzNl5xdFKAQbBhvMAKRyn/Cqguctb/7YhPECEOq7BEA73HElgdUT7RJWmkEI2uYZT3HAhO5bQMM90lQG2AjVndmbCaDulZkjmD8OYwEWCUc3/QAFtqwuFh6XzXL8/Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245428; c=relaxed/simple;
	bh=vuAgTIfHFIiUyV5bxaYoxFBiu5kUUbVOpcCA/rBiuqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/HgNHXDiIm05QkwI//jagDt0MQHmQI8kIcckVZmzebDl72X1ve69MtnYsg6eYTkVmSZWPZnoQn4qrkJ/gPynRQ8aEffkKMco383kkVQ7EQTiE24L7ZRorrZb3mPycglzSWVQPscGc7J9wmWnwKymhEMn/sBiHvmRS4B1JNu2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVzeJA4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVzeJA4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F86C1F00893;
	Tue,  6 Oct 2026 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245426;
	bh=VzKF7B3RgMWg0odaWI7jDBF2orwlK/EyNwvEGeGh8z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LVzeJA4idZWzDd8pkUqSiRbNx3vVCyoee73niI0W4KbBV+TUoXz4U4wTCCi+gfXbL
	 5ImpIJ/5W8cdTSr+LI57IFRfgMkYdCVs5yCOnR0et5lZ4rWYDWvbJxnHyjIQgw4EN7
	 LoMktll97xxiH8dyXf7lSPX4Ab0QzSDyjp80kFyz810UKDx3WYvC6rovLzyFi0BRfO
	 Nv7JutpCXNEI1i7eg1KlFf46YJqXVqK/chNEiNHPKWhGFg3BMQdr3oGarfUZqE6fzs
	 RM4S81wi/T3Z+d2c+hWjECYqEPcaa7ys15452OVaLETBRIoX2exj5wEfbUdyUg1qXZ
	 GfSlmiPUmrfYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] perf: Require kernel access for text poke events
Date: Mon,  5 Oct 2026 20:10:23 -0400
Message-ID: <20261006000905.3531398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100517-satisfied-tapioca-11b8@gregkh>
References: <2026100517-satisfied-tapioca-11b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit 357e8a77a501d96c9517f01f4a211eed5e9c9184 ]

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com
[ sashal: adjusted context around the simpler exclude_kernel check that calls perf_allow_kernel(&attr) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 013c3a4afb8a3..a64e0254e803c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12458,7 +12458,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel || attr.text_poke) {
 		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
-- 
2.53.0

