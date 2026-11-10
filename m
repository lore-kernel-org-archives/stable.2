Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273319;
	b=n1n2OYzDxVLjYgYVw41Mt/XolPKfBtWJyITEC5CbS/+DQfP5+Hsp0iHkBghEm2DIoqbE
	 DCkbRzHSdFVI3ArZJFOC/0VaItAQcmYoifQMLdBupfAQIX+psyTsqPDL/PVNfuMZLfe0z
	 21wrZGdkMkmLYsAVWXOtS5Km8+Z0d/aAdhtSiXnLe/UtzdRBN/eD0hkfu6NJ2lwfWit2+
	 Lx9JsLXV2SbU6buv3OhvP64BrQvEJ4o2mL+XRbn0JZWn3/kFmKT2JZioxziQL6RndLlSe
	 OI4TIanFzbPOY+li9pCNsuuDbCQZtydBWFdE6iOSvDEeUBggahF9CrKhJ/knCpQeyQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hnhemp2KlA1wYvp+8iI2qlJ+X1KVzIs5QlkHXCDFc2I=;
	b=DTwUbauDPqdZoAaPBhlBzS73hh6Ar0ETV9tY3mRkRN2UiuWcLnH0xEaHVGBWt/s98kg6
	 Yb5f8bFX6YMIN6oNgom6TegZMuONIbdtOT9+8Z8v7Qrz5vYOU7leB1v6wYakuUJNY95th
	 HzB5M9BboeIT5LMRTQok0InweyjXaLh7/wUOOf3uIzKYOL1JAkSUmaX2ZDrvuwR9Zkm7d
	 n56jAkJXMAkL5jl4oPrsMzpY7dNLDiFupOkH6f/KCYE3FQAU8yGsFc5lRnQC3R0IJiB/P
	 yetAsyQcmU6n8PfnR9MrnG4a6kJ+JPcJkCgA46b4QgFMmOILxQ4NkwSeqTSsrB+OBmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nc/PkSKa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED29606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nc/PkSKa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D591F0089F;
	Tue, 10 Nov 2026 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273319;
	bh=hnhemp2KlA1wYvp+8iI2qlJ+X1KVzIs5QlkHXCDFc2I=;
	h=From:To:Cc:Subject:Date;
	b=nc/PkSKasgr69vnUTwKsH8cDytRAQj3S5uRGoLnauefd3LG2Yi4CjJ5+/SAFG8dom
	 Y/UWjCBJccYrAS0s8jywmlhJtEF6fCBV5yTc5AORpCLM7whmD3h9Gn9EMeXfPBuaDT
	 qIPMuzvkjZ9sly1mt+NqvpP2g/SLpNbVWNYIUWNHhRiJe1bBb3GwV9slNzvIKx6l1S
	 es6Ftx0Gq9Pb8CWn6plP6ZopG80m3g5iCkjBrLEEf3UW9wfxcY944G7qXD23vvFrlr
	 6XAGHtSNsOMpQYzgRlALEYuCE89fulg3c1BKCUyecXpWYMe/iPcvX81WxNQgLmRNlE
	 2XEIpog5/Or+A==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:17 -0500
Message-ID: <20261109201517-failed-6.1-1025b76d1328@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1025b76d13288a311e8259a0eefde0854fa63c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201517-failed-6.1-1025b76d1328@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




