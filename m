Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273625;
	b=CNOGqzKA1MWrhfRfbuxuWsz3y4AmfmnFfrvgsQe/08O4sOGNHBusPEli0UjgIb1bRg9y
	 lZ8qcgy6Jr9fVdnGRoHwqaV4+lpln6xMym+8mvTCwEG2vHPPuMKTzNJ6L5QOs9cWowL/8
	 Km4BI6kgWUe+OD8LaBNjzu2x9/v2Nsf9c0niGtslMkNYG99Jv8cdqfBBPgep8VZ/EI8Qe
	 W7VpRW1siRYA+NESHxlZnakGC9hp5DHCf7bhqo3FKMfYCXBHUfT9LEfrlq++xhHsI4H2K
	 2h1T8C9iYIR53NM+O5cgcjmiaGfUUe0H060T3TD27/2S1ZmcD+pWyb/HQdfhUZoPsbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+zGlPHhJPjqlcMCWAWxhoPZW2aTqOcWD4eeMRrHNsUI=;
	b=HxGWinCjtSO53fYgUU5fyOWvZ2hmVPPwo0nBzWs6qxnAQ3R0KTv9Ly/klxzC4JLn3m9h
	 yK3uz/v9hCmofqqCwPgZ8uReUbbAMl6jiBmiRWxA2fzw1mUdua5ewsZSUNBhqY7FbyZdT
	 SsER89pgSn9GwHTXucgzIw58OO7DRWhWKRD64WxqZyYw6hhNaZbDogij86L1LzJ5OrTHm
	 t3kfkMQzInfiL2zR3Dpof6q1IB3nJuX0/6o4ueXQDPePawPSskhJ4a49YEm7rA+FijDoN
	 IIAtccNHzF4L2S7Ap0+Z0sAydiYZjrMsYr80ZOMdRB7G+FssOlJPjzoXt2ngqFQbi0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZqiigFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550B60A260F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZqiigFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324E31F0089F;
	Tue, 10 Nov 2026 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273624;
	bh=+zGlPHhJPjqlcMCWAWxhoPZW2aTqOcWD4eeMRrHNsUI=;
	h=From:To:Cc:Subject:Date;
	b=fZqiigFNa2RaJMqmk57WNkZVSttE+gjvK0L97d+3jZTAhMA0VeHSthGSy4ns+fGzu
	 7F0rHOZIhIF6iCwFWwLgA4kwSel25TrS/FSRaA+xFN7wFOog8USkVDidMnnPi5RUcu
	 Py9ve+cHH5SLwnXMgEceDrOp5JTPM8Bhf/1TKlsOLwhoja1UVjnEmekwl569i6AWhY
	 uiI7E3n/fwHGbXWdP3U5MhQx4NJR8TyG7+EpmI49dmSsPhLqMzEDwgjUJqFAUrV111
	 j5MIVyFGr/07RHTnXoKd3sxJZyyX2KBJ+Jgj3SJXoBPzPh3us+cqw8/qqhpqIuoSaE
	 e2aBj5KInqp2w==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:22 -0500
Message-ID: <20261109202022-failed-5.15-1025b76d1328@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1025b76d13288a311e8259a0eefde0854fa63c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202022-failed-5.15-1025b76d1328@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




