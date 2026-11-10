Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273932;
	b=hcZZ6hz0HCeamuY3nDQoTgHbvgCFVKDChCUmOkWHT2qk2JQ6G4Iw2jMsQFrzMcrhtGr6
	 D+hyTi+11t9t/S69rY0NYVY8Qomx9OJePKYHN9fufatxGXq+O2MxEhl4IjrR+zGdeAsEL
	 pfgDIkM03usV9tgvIcN1J9fgUgfNqcTBc1bC1jxPcU+/cGpPIIKz8m4LDyyUvmVoMC4Wp
	 /mHoJgwP2UZQlQW13nMnikQAdEyselB8QQshX3X8ZgQZW0laa1lPxKErbx/FnXReNvdR2
	 HtZ3IQrugWfsM/ZDTzfA9o/+ToaC9EnCzLOqgH2VlgCo2dEukxOEbi0bvOupr/uj61w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+xQ8NkrW3+jrIIk14HKCT5bKo77gQIEAuto0LLmqcIo=;
	b=J91bg1NisSTY12iDqOj93tL+emruIOA6+/oVX4y9uOakjdUM0pLKhTw9zKm+yxONRi5m
	 qOCvWKf1a9of1S7b0RFE3H9huJdRAY4W7QERW2Ej8M/kLNq+r3OFmdwP6iv/OFWDiRnap
	 CdNXHUa/L8nZ+tlJ/Gf78ge7M5uR2r/vml4qRILGEXsPta/hfx8NaL066bnOpf+Ywxj+v
	 EeUIvye0aSFGE8a/IlxuHNj6nPtLjMRn7Jm36mjo4/Wrr5tVGXyIJz0MNu/GPgGes0uYu
	 BXfBBuWBJ1uTgEx30Bvd7fxiLWx0Ur1eNXT45+sMW0+6VAoq5r4VGD99O0wEudI2jYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzBTFGav;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEB606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzBTFGav
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724721F0089F;
	Tue, 10 Nov 2026 01:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273931;
	bh=+xQ8NkrW3+jrIIk14HKCT5bKo77gQIEAuto0LLmqcIo=;
	h=From:To:Cc:Subject:Date;
	b=nzBTFGavHdgAMY9nqz2/cZ1bBa1EIUiZEzfEwl10s2lt3Dp8vOI0nuOJJBcj3NCOw
	 VLCOWmJYt+R8RXhz0WG9cqn4Y/6/jlppiwj4icK8tfqzkNxCrKwOgijKG7dcL3Wf77
	 /z2l9O/2Qu+EDyP85MANUutlRvWkTFT8k3e+nL0DO/gbv9VnViHkYS+dJfr2IbeNti
	 5VP0NbOJe3hn6UEY271RmeDhTlS2Hty9fVOOrNiTPV3klDtk0ixEb733PlCbnwzFva
	 j3oHuzQ5Mwz+uSpCDCPknykkQthCJItiJaoZ5repcxy/DglRY7DT7MpTabIc+x7Aic
	 af+9nYfRIaEXw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:30 -0500
Message-ID: <20261109202530-failed-5.10-1025b76d1328@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1025b76d13288a311e8259a0eefde0854fa63c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202530-failed-5.10-1025b76d1328@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1025b76d13288a311e8259a0eefde0854fa63c41 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 6 Oct 2026 19:38:15 +0200
Subject: [PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes

When more than 4 GB are transferred by the throughput meter,
batadv_tp_batctl_notify() will cut of the upper 32 bit of the u64 counter
and thus under-report the actual transferred bytes.

The data type of the temporary storage variable must therefore still
continue to use u64.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-08bb3be4-6c6a-452d-b4e4-606940c6cfa5
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 022eb13e8ec47..56feb02d2b7ef 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -221,7 +221,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
-	u32 total_bytes;
+	u64 total_bytes;
 	u32 test_time;
 	u8 result;
 
-- 
2.53.0




