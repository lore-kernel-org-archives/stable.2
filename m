Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795786364;
	b=xVK75UKi7TY8zHM+GOvdewpPgc9GOj7ccimZQ3Wf6rl8nwyhLZhNaHXwQ81xDpTwGoqa
	 HWeFIesCfevDGgh+PxS0plnq9FSfLQv+60pCtKmtdemf2/GzaSDpe6hqvbC9LOA7esyKS
	 tG2P8oGt0tnHFmu6Iew++R6A202kVYcH2VF9Emm9P85t7wxhPJoUlOdT3pW0ZkuDv/BRo
	 RrmbrJMsJA6Ag5mIP1ktdoi5D8hNvash45QMsp8aiZfcFm+3eysmDCBaUKeo+EbagNMy/
	 E3KgTAjjBdKQ7Wiolfm8KZ/nwKx2gkXcPI0aZxd6arxgO7qCCiz/NCYm0dhrL0xKElg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786364;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=FYaCHv9PfTrF9j197iISEUnJnAYe3DT2PkbX2zQkyTE=;
	b=FIt8tv/BhXtA/Zr3GNC5hT+ajhiu+7kXAuNhKU5Eoi177lrquLIAX6X4gwJgPRaBRwEb
	 ym5zOVubgxu7SrnUS9VLgvVo1sN1EZtGmA5wNkEF6he8yxmCL5wSK6QQhYNU/EHFS09md
	 hidYpC0PTcYYHDbHW+U1TZF0DLMui6x7DJgzZDTncD/mndk2z8JbqA5O58GwmnZ7Qb8zl
	 lwKkzwQrX/kJ4K8Wo+LfCDtrhmu47rX123nlN7iEY7BkrmWr8hXULFRbdM28rvtDuzQtW
	 prVsa+4FAhFeRNkUGaewDhKVW7yoCKZX8tL+D+jPNg5Nh2OHcMz87KhTR7l/CGj1qpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOxqFb3J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1F606A334;
	Fri, 27 Nov 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOxqFb3J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795786364;
	b=oIbmA8DUozewKId9m5oiV3jVyUx1shSU79iEGmRU+qkj/zUuvq0zOa/8lQvdkhKzu96h
	 KHuoyJ/mQczXv7Z0VhrznObULtOVEY4b8TVxvWNUaaZYnK3zb6g9TzU4yiq/HbUxSRwbm
	 7X3AnL2aM/VHrBJDQJ8G66gLtA9zeDfgxgLXZhxvoJeHeNq3xQRAGH00HdOlt7QuAilLh
	 lH10RqLujmnSdcLrNgcsabipX+VcVFCEw/HLb7XLuy3q8l8tvz11+3TNfLyb0jKSnuxw/
	 eV4fV1EGEVE8MTODtGjXh6oYP4SNja5oEhgHH4sZrXk45jFp3oeGHKJ5rfBVjrVR5Fw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786364;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FYaCHv9PfTrF9j197iISEUnJnAYe3DT2PkbX2zQkyTE=;
	b=GN6zHinlTXb3sU+3br9XNE5tUV+5vptZbKB0HZV7DOQQtVHlR2/ZihEC1VTZJyVsACGn
	 WrVJVe5BHl9DEP2+twXvil+wiHRh3uduWq4WtSeFx1uqaAl0Je6s4EKJu1nLVX2cLV6E2
	 wuy8MMO1apDM69RIjBmjmMQYBla5pyIgeDw1n/EHqJPpn6xIwfY4E02BjPDRidzrumQ1M
	 IjfKWPtWE6JFxDd+KBE2ZteIVnDzRwp/z8nOWRgT05u4ynxWzBtnM38IxTnCkZVy+xRtS
	 I35j03jTfAxFcGUDAwQjnmirEYyHqlkJik3btm9p+BOpNPgYNitGixBGOQRf0sTvvag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8FFAA1F0089C;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786364;
	bh=FYaCHv9PfTrF9j197iISEUnJnAYe3DT2PkbX2zQkyTE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hOxqFb3JA6hcIFCblSmJoFT6ebqPTpkvQdHfCnkBX8oc67F67s/l+ulh0YjRa1fp1
	 0neWw76G73VsL72DD/EYV+uJlJlohiFOwXqnvRg1cw0cC21jSwJUPJ0WPQfj80vTU9
	 D43YnsnVS69bmUKZtkrzdpNifJ9tSI8UGMGWE819oCCx2aiSdYzr0jCscc3e4jUFxx
	 nJzGRU/45u5yL92vFyFPQmgAku7di053QPodsE+qHoxQnXP/mUM/gSksgRmoWkpPw6
	 yb+l9AxKzxfx5bvq2EKa4mdSd1Jk4hk4cFobgpPzKW4Lz7UVUKL3HBkaYZPbPR99IT
	 WC7cLYDUF7Zsg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0D39C4B808;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH RESEND v4 0/3] pwm: loongson: Fix PWM configuration
 handling
Date: Fri, 27 Nov 2026 21:32:22 +0800
Message-Id: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NPQ+CMBAG4L9COltDP6DUyUFWBx2NQ4ECTaAlr
 UEN4b97ISYSdXzfu3tuQkF7owPaRRPyejTBOAuBbyJUtso2GpsKMqIxTeOUUDzce9w5Z5vgLK7
 NA5OMiZTxhGjJEJwNXkO9kBd0ys/58YCu0Lcm3Jx/Lp9GskzfaPqLjgTHmEtSFTWsKFHvm16Zb
 lu6fsFGugLoP4ACkHBJq0ImLBPyG2AfQJDkD8AAiJUqaMaFVkqsgXmeXzSWr3k6AQAA
X-Change-ID: 20260612-pwm-loongson-fix-183763451e93
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Imported from f20260920-pwm-loongson-fix-v4-0-41b36b3c6497"@gmail.com, 
 Keguang Zhang <keguang.zhang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795786349; l=2157;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=CwIaW+A6x20ljgJSm9xW+J/vK0MOBDMKCU+FB1gyLv0=;
 b=6NAcs2SJLHuE760NzMBux45kv+OAp8njajZQqiESe4fV2avAdlB8WfGDHpkMTYoGeUQyl/7oz
 mCjOxkC69CEBs9LIattQo9rEIApBLPBv0UMTROPpKqXLwIPlAK2mdCL
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

EDITME: Imported from f20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com
        Please review before sending.

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
base-commit: 1ded7cf43312109206d02ef6150c9450818c239c
change-id: 20260612-pwm-loongson-fix-183763451e93

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>


