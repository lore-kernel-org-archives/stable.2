Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272776;
	b=E2AISeltfljSmsRAfg6uBbeMnKZ9Sck981t0vhD5N1EmDzlPmD6xaQZPv4WO4QNuAlmr
	 CV+ZBeqWKNkPp6Pji5ilTPORbiq+HzOOglS8A2lQ9f1ye+C2hsEf0A3Qqu0ZU/hY4UPy6
	 UAUL/QBzrSXkcbQ8Ll8YJ1Jh1YvSCyRnieu079LXl49R5rwSwHG3YsnMsLCYaOzzl0bGA
	 80DahJ8Y1nBNFVPvr+vwtcvfy+G4jGT+8q4ZGlVWantgi+liuuJ3EfwTza4aJxQfsGwRq
	 6NkvQ5+umXNUlaJgwdAg6SbrywtAmJprEXPDcbI347Az2T3cBGjjy3qI8ecQJy5s9ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R+HS6o6e8TsK9cgp1q+rtC1X2LtdwaY+mjJn9v18sgk=;
	b=pG+P1WBrUQJMjiwJabl5iXGc8oRB2xeXAxN1PPXYoedV3eth1A581RqLDYB6ZEUrGn/I
	 MgdQRpXIiVNQetKy+kboSa5idWoceIjVvLOoFqgxgNJck8YlZZYGBmnvms3VjVtvjeD/W
	 FzmKHE28bxbYUChufH0M53DainhiV9XD5m1xguZLq3UuyvTNY7u0Q7hMpWs99rTs8p3HB
	 FwwYaDrgOCV9QbNEizi07a24YbXiHBKPEGk+iedDKXJ/NNGGxPV6OB5kl0adKZqNSWxJd
	 7DXQsMVIy2jYyP5+vdMWqBMNNh7SeWDWwoOwYVeHYx7O/259RIfq951k6OY69nj61oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ko2Cu6/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BD606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ko2Cu6/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DA81F0089F;
	Tue, 10 Nov 2026 01:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272775;
	bh=R+HS6o6e8TsK9cgp1q+rtC1X2LtdwaY+mjJn9v18sgk=;
	h=From:To:Cc:Subject:Date;
	b=ko2Cu6/iuB2B8xTIQfXITEX+C00rrNP11q8CuP7nZpTYbOdBYAZ+mBLnsnRWFO+al
	 yUasvUzaoYf8am2wLtP8h1U5U6wyZAtpVhfcy3nFe2YPfn/tTWhEqKr9ni8io3Hr/i
	 4Ql7WACXLMUJCry6cFVSnPY35ersaGVyzhXp9q/dbkId30Xws0ToUTj0Vts2GrFnhi
	 c81ZEYdFbMPBk2eZB7AV9WMAlYnVnjI+bjY39pvPAl+4huzANHULoQaId6xsCuaTnj
	 LYplfgho2C+3i+0JLwsRaFfcpQUiT5k8asXOcyBGJmbi0DX+ElLCXXg3Qy6/BzKxh4
	 4hQhgoIIcFuug==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:12 -0500
Message-ID: <20261109200612-failed-6.12-1025b76d1328@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1025b76d13288a311e8259a0eefde0854fa63c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200612-failed-6.12-1025b76d1328@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




