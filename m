Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC64AC16F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824375; cv=none; b=IWTIEgVjvYom93vKJywHiF7aa64iongXJ8AMBZGhn5xhhxQHTRjmoIRq3qOXPb3sqrfbVUPo85/oqdy/ImXAhLy9yZTo91lyvwkuCPE26Gi0O3F/9dBrwam1FFpkByo0CoFQLu/xXVvIohpK8/lcfR1ziwZgJ8z9cPP5uU7PIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824375; c=relaxed/simple;
	bh=ra774RX9pUQl5A4C8UsYClxHID61Qm4LEn/zXODQirE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p32wl2fVZthnHV/zpI90G3JqAljC5WrQ48aItIvcZF8zhHZPG1MMN2FF1qdnWdFcH2zuxylliLgYu7HsCqW/5zwM5m115QKAyZl7ofu33mVNwpt6hFAjffsZc2qMeMAATNfHj+29/fI+gQcqOffxC/1kJBOwubrb1u0n3O7Vh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=bjR3nBK2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="bjR3nBK2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33e6279a1d7so392359eec.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791824370; x=1792429170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2A8uM5YoDGAXJ61F13Xmmod47Ap3MAHsB+2T9f5DjhY=;
        b=bjR3nBK2v0+0meWFE19JFPEGPGztpD1BQlggW03iTHAiEMgMS7tlX02qUDp6jCQdi6
         Gpf3WISs0UjLqLjdvYWUOZdjFASLqtua6UfJtqOFEV6PHS2KEODJMR3rHi3AH3RmfbNv
         d52qeDdxOFeEcLU1YTefyP3hzJEQlRDMFGTYeIs97WdX/Wd3WmKW4FpnnRYP3KnBgChq
         5lAxAB4f7xo6Y7iab611oCrstaB3flCV2YGXrtDrAoo1RLjYntjj8ERPjVE6JocFJ1ir
         51dgE7HRAo4XD1vqufqygtKNrcldd7/7QQUTnQYIL1qbJaCEatFxhuEb8A45NAbBkZg7
         1gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824370; x=1792429170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2A8uM5YoDGAXJ61F13Xmmod47Ap3MAHsB+2T9f5DjhY=;
        b=0mFbA5Cyb9cCF1vQkUfUYbIlTSnvt30hdiOk7QzkdBUc1t8E+L9m53r6UPAfFUBOFP
         ccxWOFWPAA9yGqF6R56QwFqts1+JUDEQ3pLfbkWnFSF6+f98qizMSRyTQU3Yx29E0rpl
         CYscNxCVt13JiSdA1stEWk1BHGvvEDxd4IYFL9ORLwXCz6BIoB24Zz2Y6nXkG7ezDquu
         Gwbup4pj+y5mZlqQp9CajdzeHnu62SoT84a7JzOKFeglyO40S1nxolQEeMO8aOjTNjdw
         8ZSLMvLdS2MSR0o2YPayuwsW/wOoYwCoqEVcXjGti2XtOSn6tVS5RMuKtS26+17uI+zd
         lMTw==
X-Gm-Message-State: AFq9FYKRnj6NWVJFYo1ZPrkdY6u6Zl8GBBHzpcBrZNQ1Ay4XVjamLcpU
	+Y/Mr3yh4JFKcOvfZtU6s+kcT0L3UTJCBZ8Zs6cxiLSkQ8qEadB6B/FhMkkfxjU/mCgBJbsTcyB
	wYa3E5VIbrw==
X-Gm-Gg: AYBFou2dv+hS3CFBRnAH7udrKC9zuI3iE1b5h2b8lLiuAOQLipw8CrngG9nnT1UMVlk
	WHcS9SZW+EpY+6SqXUs4ZKoGaYUWCRq96FWAbovH9JwXWzvZuLGHYY19ufXYnGq7Q5hbWVambSj
	rJQmamJOsfZP9Sf//nNTmG6wwcZehsMquGHOtFPPHx90ESwzsylffeS24Cf3TfSyItvxVr5yt22
	ADcSeJRNtejA85FLJ5ndV3YHNEILKrhwUo5EmRA90hh64wjAtTYzazpdym5ejqp3UI4Ry+7wtZu
	c6t1/VyYqU1Kiu7pEjKNXR7+NyukR2iQiYax6jZK4lBtExDEAnpT+efAMuofWaHTlgWXRoaZK8l
	+X3NoUq/9lSHPTHpIxUXFm0NmvayDTX0RUjr7YXT7rfSXEE7f8XJcEzBsM2oyDSAABsAiAPy15c
	4ro5NrwDQdDnjGS6fuJbX5DWEUMBF0DCnPgF+smRIpsx8b/cjW+vedLSWcpCXFexrkj1znE+dcV
	iuoPNn7/QGyejAj+r5DcVAY8vqTvttXHd4p+RFLprTgbPcvv3NAGkXAfARqvyYlnS/4VJQi5whH
X-Received: by 2002:a05:7300:aca5:b0:358:1f59:48c9 with SMTP id 5a478bee46e88-3581f594a27mr15009040eec.24.1791824369666;
        Mon, 12 Oct 2026 09:59:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:1464:826f:d188:9e33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm34296900eec.28.2026.10.12.09.59.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 09:59:29 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 0/2] wifi: ath12k: fix M3 buffer reuse in my CVE-2024-40979 backport
Date: Mon, 12 Oct 2026 12:59:23 -0400
Message-ID: <20261012165925.32575-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and ath12k maintainers,

My backport of 05090ae82f44 ("wifi: ath12k: check M3 buffer size as well
whey trying to reuse it"), which landed in 6.6.158 as 9a38ba5561d9, does
not match upstream. When the existing M3 buffer is large enough, it
returns early without copying the new image or updating its length.
Upstream copies the current image into the reused buffer every time. In
6.6.y, recovery or resume therefore keeps the old M3 image unless the new
one is larger.

Restoring the copy needs one more upstream fix first. Once a smaller
image can be copied into the buffer, m3_mem->size can shrink below the
allocation size, and that shrunken size is later passed to
dma_free_coherent(). Upstream fixed this in 00575bb44b2c ("wifi: ath12k:
fix reusing m3 memory") by tracking the allocation size separately.

  1/2 backports 00575bb44b2c.
  2/2 fixes my backport by restoring the upstream copy on reuse. It has
      no upstream equivalent; upstream never had the early return.

6.12.y already copies on reuse but lacked 00575bb44b2c; my backport of
it is now queued for 6.12.y. 6.18.y and 7.2.y already have the fix, and
6.1.y has no ath12k driver.

Testing: both patches apply to v6.6.158 and on top of the current 6.6
stable queue. An x86_64 allmodconfig build with CONFIG_WERROR=y is clean,
and ath12k also builds cleanly with W=1. I tested ath12k_qmi_m3_load()
and ath12k_qmi_m3_free() in userspace with firmware and DMA stubs under
ASan/UBSan, covering same-size, smaller, and larger replacement images,
plus allocation and firmware-request failures. I did not test on ath12k
hardware.

Previous series: https://lore.kernel.org/all/20260929025856.85683-1-artem@trailofbits.com/

An LLM helped compare the backport with upstream, prepare these patches,
and build and test them. I reviewed the results.

Thanks,
Artem Dinaburg

Artem Dinaburg (1):
  wifi: ath12k: copy M3 firmware when reusing the buffer

Baochen Qiang (1):
  wifi: ath12k: fix reusing m3 memory
