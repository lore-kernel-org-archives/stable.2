Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349124;
	b=MhgWmZfw/AKKb5rDC4tDx/rGXUQ6N0slFNuMv0Jc9LkU3h6BCdiC1pNkCl2vSD1xXdct
	 ZUelWWG1XsGKnn900uEU061W2gnKaHwUpp5LxpZYTNulkmluaTZKpuLNNkEO0dqcEAOWm
	 ehzpRONLv8UBXGjxYGwxRmGzqiMfVv0BYVP1NkkwO0Env5kA6Sz5un5XuH+zrITicAEnd
	 IEyjz2CZiFtdJcAEk5FvlX0o6UK3qDoDG4muqSjOieqIy/jCTBJtU4Q5Qyb9d9TOM+3Rz
	 U1NlprELTpwXSZgXzN2gyLqwQ6Y/3JkteGEwrVcHnFl4fIpYCwzI0YnLWLCOSUOaM4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349124;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fDbH24IqyXGeJwrHjekd3y0pkWs6pa3ajDlC4H0B9Rs=;
	b=BLvrHA0D4GQovJsSeS9jFIdeoXWuYfd/wR9N+7q73o5UKszKIOnic6fMsphj1UA1vE9F
	 o0PAzxHO1uilLTI4RPg0HWobSMfSDGrrE2nx7aiAGO90XzDI0GIuAcv2pIzbEVUJXaOv+
	 +ttHYPuQOXKnZB3AJlVW3KwVxht2Ld5Ryd01KHyW8Y+AG1xPQYSVV+UHaiwykn8jhVIXE
	 5fFEvLgapuyLjloAHNFTff383OIRz178NWok8MeXpOUYEPwqSLB7WN28sApWvAYa9bM+8
	 4LwdeAoCeIZZNvN8cqFhUbg8JuPIS/z6OFglJkzUNYCrwt0pUCwkSddcMUBQEmVUjew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KATnxScb;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2D606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAE2D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KATnxScb
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ucW0CbkgsYickmF4J+LbDhp0k/VR5j5+Ym5RT6WHGS0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794349121; v=1; x=1794953921;
 b=KATnxScbwb64vWmiiVtuCVXVGjDEVGbtOnd1iqIBXx5KJnfO9Nb2ZxFJWUwTE+Hrs5AEsKsz
 yvZnA0NemMEkt04T/1BB5QczwompSqODfu9lYqlkfYdD18QVO8OuW1fqx+vivQ2Cfce1t8fSzha
 5xT7yCctpxAYjRm1CitCAV7o=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 53003b696ba808b5;
	Tue, 10 Nov 2026 22:18:41 +0000
X-Mizu-Trace-ID: 53003b696ba808b5
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bradley.morgan@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 1/2] arm64/fpsimd: signal: Require ZA context when restoring ZT context
Date: Tue, 10 Nov 2026 22:18:35 +0000
Message-ID: <20261110221836.3265929-2-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110221836.3265929-1-bradley.morgan@linux.dev>
References: <20261110221836.3265929-1-bradley.morgan@linux.dev>
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

When restoring the signal frame, restore_zt_context() checks whether ZA
is enabled via thread_za_enabled(&current->thread). However, if user.za
is omitted from the signal frame, restore_za_context() is skipped entirely.
If the signal handler touched SME prior to rt_sigreturn(), ZA remains
enabled in current->thread.svcr from the handler context, causing
thread_za_enabled() to succeed and restore_zt_context() to write userspace
ZT data without restoring ZA state.

Require user->za to be present in the signal frame before restoring ZT.

Fixes: ee072cf70804 ("arm64/sme: Implement signal handling for ZT")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
---
 arch/arm64/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6a06a4e352b1d..20d5f19921e0d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -678,7 +678,7 @@ static int restore_zt_context(struct user_ctxs *user)
 	u16 nregs;
 
 	/* ZA must be restored first for this check to be valid */
-	if (!thread_za_enabled(&current->thread))
+	if (!user->za || !thread_za_enabled(&current->thread))
 		return -EINVAL;
 
 	if (user->zt_size != ZT_SIG_CONTEXT_SIZE(1))
-- 
2.53.0

