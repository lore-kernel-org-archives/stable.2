Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615929;
	b=wyt9npJQX4lNnxxrEpyNXisWRubZJjzREsXqZ6ebeyxTLe0SD9Oec7TG8YuCzf/9Q/HK
	 xNVxixiUcfaSkStO2scdPosLDyD3gjQPXURJSk/uV3272d8jRCSUOwglWJbvzUQM9HqF2
	 ZhGSth0O9aFtcBXZiSYYnzzvXfH452eDdHfbcWESAx1Y6ocafhHX9zm1ZAUvJ95lyD0TF
	 m+F85w6tnJ11eb59+F+c1B/zNHmNLbKBsgXga4gxvTqCqQi9YawZke4xVmr9nPng5sMwP
	 uwVKppqcK1Oums56lAebnEMxmU0gmsrMAmXmcTpAzp13a+kPw59uileX9hWEat7lJNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615929;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=yxByIp+BRQ45lm6s/KrMo/g3bB+LI5+aMluESHz2LE4=;
	b=0JQ6k41SUVIpCv2RElq5rauzebglzM8fN84Fdx2WXcEjnQHLjGOU6zm9dCmtHK7cn/RP
	 B9dyu2NNwc9jhkVda1zd1Q2KCWZDVBm50QnyOx2RuzaPFJx8USjCOmALkLxjr1jeD/oSg
	 e0cneeYYAzOocGMNQ8l8+AicL7KlkRrrW69otJnKfpvedNpMI5b5ZLI8z3Pd3nYJoaMOZ
	 h+34lap5Hn3ICESGxqpynPOFk2IfhrNiXsUVHuF5Fq0W+D68Vg7OxF/DRe5QRCJ2i4mIK
	 yXPz9QVERV4ltkkTv5C+RWZazbO0kmNFf9YCOCNeWkwsIqJ2wlmgrRNe1l0DJE+1JyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGk0DEfW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24319606A6A8;
	Wed, 25 Nov 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGk0DEfW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795615928;
	b=nX36/D8j8bEnL/CB99waH7gD/qxTw/XuQ4FLRud+a9ZiCbl4XhScl8Vq51t9mtYMvI6I
	 DTM0YRIJr/Hkggtwy4q9V5aG8ip+9HHx3bqtQZn2djN7iWxBxr4kvOKX0qw2xaohhH8Ij
	 tBFmdxRE58A/TbM1p4HQfn8q5+GY6nluYPIED1Vlzewymt599qnARVUE/rs2bWlWEqNkz
	 1cRy+40mwj2NhfX5KtOqR1Pkxlh3DTb3abBij8PjYKrCw2TnnWO+1pXBmwqK7tt7OImtD
	 IlHqU+Jy7dj6AtLxzRvChRbHm/+j4OMmFXVMxWws5gQ5dbUV/tllK8DDvw8kwvvGbNg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795615928;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yxByIp+BRQ45lm6s/KrMo/g3bB+LI5+aMluESHz2LE4=;
	b=qsVuOpGlrQCRc7gT9ut5dpP+tjw6U5OU8Drj92m7pFdKuVWeORQqjQeYyQ6fcY/W5OXB
	 kWOdXY29rKzQdY6cQ6cv+Bzo57vacqKAx3fYJVjwRNBOFrYvQ2zWCqGWOyJf6mKK8iyBZ
	 WrsLy4rqKNDMoW2MuTOW7kH507hb3vbFqju9pIyBmeUfpCNiqMkm6zQ/WfxyFbs9DqKV4
	 DRypMJAemXc+lAgUcT2PS9Myhuaj0PswSwezbuzYoMV2Q5+hHH7Dun8xMYOhfi8iuAPVZ
	 5nmKCNjbloRGzBuU+O0xXRZjhK+cu6uED+g6UbzFEVDFY5UUwLEqkAovZ0rB9agqO9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 83BB21F000D3;
	Wed, 25 Nov 2026 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615928;
	bh=yxByIp+BRQ45lm6s/KrMo/g3bB+LI5+aMluESHz2LE4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=bGk0DEfWrPWGSKYEVB6z41CYWHkmURD3nQZuC+aovIi9NlNZMOeYjnisCCRETdgAA
	 wl/Cxc/ffDPKJVkUFq1FFWz42IjUFLWtEizmgJxNklGgu2fOkhbf0bZMKslhPtTFrQ
	 D9iERs5d/d/yEcBEe7ZWLR1WKcB2dKRXAOYlfz/u28y17wc9EutFFaikvigBRbaJ52
	 YQO7j0/mEyD91nB4Mkp/buxChyolXP5BEY2yP2nH9P/l6yiucSP1DbmuEJtNx43iw1
	 a/GvHQhGfZM3YfFfGWcyVhunPsY/vJQoHNcB9CQepAj3SrPd8grOon8pLdTIYIPP+s
	 RfNw6lWscc5QQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 106EA4CEEA;
	Wed, 25 Nov 2026 14:11:55 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Subject: [PATCH v4 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Date: Wed, 25 Nov 2026 14:11:49 +0000
Message-Id: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
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
X-B4-Tracking: v=1; b=H4sIAKXsBmsC/4XNTQ6CMBQE4KuQrn2mP9CCK+9hXNDygBpCkRaCI
 dxdwI0xGpeTzHwzE4+9RU9O0Ux6HK23rl1DfIiIqfO2QrDFmgmnXDLKGYRigmpAH+A+uIDQuaY
 BWipdmiTLKNVknXY9lnba2cv1lf2gb2jCZm2N2vrg+sf+O7Kt9+diZMAgY1meqpRxNPpcNrmvt
 Qv+2GIg283I3yH+A+JAQSWxMBI1L4T8Bol3KP4BiRWSeSq0VlIJFn9Cy7I8AbEYblFgAQAA
X-Change-ID: 20261021-tdx-guest-quote-poll-0f7bfc59900b
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795615914; l=2878;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=rqc80yhWsP3LWWLdVctDJ2+6rWedrVjJDW+t69zJnTU=;
 b=acqVLl+jCT3l8+VqkGMFlKvtMTzFpveSM0x23jDxqCPbhq7o2cbM01ORQjkjpNa3AjmR2aJJF
 SpkgTAREz+FB6mZAwAgXhcB7YWQP4XqTb0Y9D9iCUD1OmOrhXf1lWfy
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net

Getting a TDX Quote takes at least one second, because
wait_for_quote_completion() sleeps a full second before each status
check, while a local Quote Generation Service answers in a few
milliseconds. Patch 2 rechecks the status every 10 ms instead.

In v1, Kiryl noticed that the same loop gets a real timeout wrong.
Patch 1 fixes that on its own, so that it can be backported; patch 2
then replaces the loop.

The GHCI SetupEventNotifyInterrupt mechanism would avoid polling
altogether, but it relies on the VMM implementing that service. This
series keeps the existing polling model, which works with any VMM.

Jun Miao posted a patch for the same latency in September [1]. It polls
every 2 ms with read_poll_timeout() and lowers the timeout to 1 s. This
series keeps the 30 s timeout. Patch 1 is needed for released kernels
either way.

[1] https://lore.kernel.org/all/20260917102202.750895-1-jun.miao@intel.com/

Testing on mainline 7be4bc52fd9e in a TDX guest (KVM host v7.0, QEMU
11.1.2, TDX module 1.5.34, Intel QGS, guest HZ=250), through
configfs-tsm:
- Latency, 120 back-to-back Quotes: 1021-1024 ms each before (v3
  numbers, same setup), 14-20 ms (median 16 ms) with the series. At
  HZ=250, msleep_interruptible(10) sleeps 4 jiffies, 16 ms, and the
  first check right after the request almost never succeeds.
- Stress, 1000 back-to-back Quotes: none empty, 14-21 ms (median
  16 ms).
- Timeout, with a QGS socket that accepts and never answers: the read
  fails with -ETIMEDOUT after 30 s. Patch 1 is unchanged from v3, where
  the lowered-timeout test showed the fix.
- SIGTERM to a reader waiting on such a request: it exits within the
  same 10 ms tick of /proc/uptime.
- W=1 build of drivers/virt/coco/tdx-guest/ and checkpatch.pl --strict
  are clean.

The patches and this cover letter were written with an AI coding
assistant, Claude (Claude Code, model Claude Opus 5.5), which also ran
the tests.

---
Changes in v4:
- Patch 2: recheck every 10 ms instead of backing off from 1 to 100 ms
  (Rick). Title changed to "Poll Quote status every 10 ms"
- Patch 2: changelog says the first check comes before the first sleep
  (Xiaoyao)
- Patch 2: dropped Kiryl's and Sathyanarayanan's Reviewed-by, since the
  code changed
- Patch 1: collected Reviewed-by (Xiaoyao)
- Link to v3: https://patch.msgid.link/20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net

---
Moe Mahhouk (2):
      virt: tdx-guest: Fix timeout detection in wait_for_quote_completion()
      virt: tdx-guest: Poll Quote status every 10 ms

 drivers/virt/coco/tdx-guest/tdx-guest.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261021-tdx-guest-quote-poll-0f7bfc59900b

Best regards,
--  
Moe Mahhouk <moe@flashbots.net>


