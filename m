Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56259385D7A;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905772; cv=none; b=IJKQOLC4wLAFnUVYBbvPn8mII8MCiXCgLZ+bZJwRBU0kX1pNS9hoTAvpCiLmYH3dEvjEi19cPKpNMbxvG0Q2d12GS8N2+DHcJ0TI+W6aDmQ1TjbQzqmbCYL9OwufXBZZKzNhuM7Kr+fNxhSqDhDdnypbaIzsJdFm3TDiGH32/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905772; c=relaxed/simple;
	bh=C7iMPqjB6P9Qg3T5TaDcr5AHKJP1Kwje+7b4vnJCSJY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=javvrfZwtgRJiJWnfoqIwZkrmza6mn9Cmr1uJJKA0y7oKQvaIED2nMx1icgKVkRYOJpFQYeZxi87wAjGxnNfcy6HBiaILQH9RY9eIibnznNwuBD+d1Mlizf4gCwxdanxICO7MouzS92MAZFmAtuWIHxUqVIdyPSWVEV4ie653L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pak+w7dJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pak+w7dJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEC27C2BCB3;
	Sun, 20 Sep 2026 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789905772;
	bh=C7iMPqjB6P9Qg3T5TaDcr5AHKJP1Kwje+7b4vnJCSJY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pak+w7dJA518VcHNjVjj31wgk4vDud/pFOCFzi/Osg3iCq6fQEuxZsO9VhUkLr/nM
	 XCnDkeKgWtIEP2IgpEO6nhRuDLluHS5FSMnJvRs4Rd6pm8SN/3Xm1du3K8UjTQVVn+
	 5yAR8Gbo+gsDgF2bxuQGfLeMAIrxN7gcJhjcwgLu5a3DqIWywdEyvJZXCcRIcjkWw1
	 FlqATor4CFFiFPfwIx2U7tadi7LR5KO9S3NbROFTfxFAPC2XmjaPtS0DXi5Wt79amg
	 LRdsF8SNYgq8NOCSPL5R4KLs0SwRWSjbGPp8SC/nd0z+jUd8Dw+hcwx84b42fwNyV/
	 z7zT0K3Xb7tJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB740C982E6;
	Sun, 20 Sep 2026 12:02:51 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] pwm: loongson: Fix PWM configuration handling
Date: Sun, 20 Sep 2026 20:02:05 +0800
Message-Id: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD3Lr2oC/23NTQ6CMBQE4KuQrq3pf6kr72FcFCjQRFrSmqoh3
 N1CYiTKciZvvjeBaII1EZyKCQSTbLTe5cAOBah77ToDbZMzIIgIJDCB42OAN+9dF72DrX1CXFI
 pKOPYKArybAwm1yt5uebc23j34bV+SHhpP5j4xxKGCDKFm6rNJ1q2527Q9nas/QAWLJENQPYAk
 gHOFGkqxWkp1S9Av4DEfAegGUBaV6Rk0mgtt8A8z2+Q2rZHMgEAAA==
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789905770; l=2038;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=C7iMPqjB6P9Qg3T5TaDcr5AHKJP1Kwje+7b4vnJCSJY=;
 b=9TAWLI2ipQysFG5uqGcYQ6LMazBUQ3pQJHa9CvZt+BhBNy1FV4odRYp8thAN4UxlEV1rvqzWF
 PyBqJvQb3RPAAvamqJ5mb6gJ9Fv1jeZ1g/vTosgsTVvqJuv5erzaUwX
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

This series fixes two issues in the Loongson PWM driver:

- Fix the handling of the Low Pulse Buffer Register, which was
  incorrectly treated as a duty-cycle register.

- Reset the PWM counters before enabling to ensure that
  the PWM starts from a known state.

It also includes a follow-up rework:

- Use field helpers for period validation.

The whole patchset was verified on LS1B, LS1C, and LS2K0300 boards.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v4:
- Split the period validation rework into a separate patch from the
  functional fixes.
- Limit the duty cycle to the period before calculating the low pulse.
- Add a fix to reset the PWM counters before enabling, as suggested by
  Uwe Kleine-König.
- Drop v3 patch 2/3 (0de9b836a3bc), which has already been applied to
  pwm/for-next.
- Link to v3: https://lore.kernel.org/r/20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com

Changes in v3:
- Calculate the low pulse as period - duty after rounding the duty cycle.
- Handle LOW > PERIOD in pwm_loongson_get_state().
- Add a Fixes tag to the second patch.
- Link to v2: https://lore.kernel.org/r/20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com

Changes in v2:
- Drop the -ERANGE return change and restore the original behavior.
- Use mul_u64_u64_div_u64_roundup() to calculate the low pulse width.
- Update the commit message accordingly.
- Link to v1: https://lore.kernel.org/r/20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com

---
Keguang Zhang (3):
      pwm: loongson: Fix low pulse buffer register handling
      pwm: loongson: Reset the counters before enabling PWM
      pwm: loongson: Use field helpers for period validation

 drivers/pwm/pwm-loongson.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)
---
base-commit: 17dbb6938d3ab444cd6be1c95506450595a8800d
change-id: 20260612-pwm-loongson-fix-183763451e93

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>


