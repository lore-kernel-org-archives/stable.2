Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273034;
	b=pgtliLhtEfuL8GdjGjRhpWsOrZZK7nhLXtfhv4r7gHJ/2ToFRZU8LUBBOwRLM6+c3U/v
	 wpD2u0SIuRVfX0No0OQ18p559f/e7RVNG0ZZO61kdZ5eIqourlrw3SKYLvZyobXQ0L7bw
	 yGRVbq3WzskTJ7FHxVlR4PbQ4AI3n87GrgB48I4Hh50L1I7OfWdTuTIo2v/Wu/GKrBU6Y
	 Bd2e37onVyP2MLaha7/NRB+21e43+LLSIgagxTouXKWb8kc8xaz8/vKCwL36R6R/pzjGJ
	 ChkwYLKaFHwySMytE07+peiegJ8LBMGKZD976KZEjU/jKTYfaKY8opOlBL+g4joQg3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AGXdznPIZqjQm8rTLQofH70r4UddtoWo7eL3oRTR2t0=;
	b=ztsQ+7TwD8p5OjPLNERY9T/nUQB8m9mxtcVsI9OoX3lB9GnZjHsOOXX6LDEOOTBXsG71
	 11mt4VG48v8Tr1e9uNloc6Q4Whc930upQQvGg/lQT13m46xJ34b330NmnpCpgoJO2UZIS
	 HOTwCCa3hehHvuJIOHVhL6geiVzB5vn+ohh//F8HMv9Bw86pOWxb5vZMnciixtp3jaXW8
	 Wuo9sNz9KwQv4F5j2tYCfUBn0bYUpVoZzk6BE7boLhSOe+J8HE/CyvXggg6rReknelN5G
	 UPvhQi6kD/fDniHaXwsrAKAwtZHEAHBOLsZ0yfVoYzgtpNpWWvDYlzDkbG3u7M6i50A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmoXyxZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmoXyxZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AC51F0089F;
	Tue, 10 Nov 2026 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273034;
	bh=AGXdznPIZqjQm8rTLQofH70r4UddtoWo7eL3oRTR2t0=;
	h=From:To:Cc:Subject:Date;
	b=mmoXyxZliMz7WAyazD76bah4PKQokUKu1moN8Ef2MsepVFq2eT25WLMbY8d8M2gSL
	 yi9QwWfAZk1UV/BCDvZcTfVHnK9o5xlUnx6pcm1roaAvXGD/JHyg65j4i+/y+Y2MCE
	 Fu/IJw1gHPTp/UivdasH1u0cMrva5j0hjgNJppoeZb7lsRXx0t0jRJ4HuXHdhjF83I
	 rMyjCj5qwlIIZZFzCeB1BmKH7uV1JQiYHySR2iHm+Nx0HseeGj8V7WDuDRsvasrOs7
	 t+b3GT3SZdbqJhhk7SQOjLRzOE6uUACrsA1DG7Js8iljZsBJoAld+BV6R6f5jWkWCO
	 q8CoVHFjAI59w==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:32 -0500
Message-ID: <20261109201032-failed-6.6-1025b76d1328@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1025b76d13288a311e8259a0eefde0854fa63c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201032-failed-6.6-1025b76d1328@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




