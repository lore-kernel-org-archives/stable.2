Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272543;
	b=CtIcnl3DxbfejBxkIu8giSdYuvPdaxG1t82zF35Yz5KAe/ybqsVH16XaRmOm3IdhQkQ+
	 sAugmqJTz99/OwfIuXJX1f25wFn4DIbCuGANiOutkyzKowGSDg/RjCsstdTIXUTymdzCq
	 qBtVO3TVdGPlE4yw0U4VI4YhgOHXOUgeHZLh1f6UOt9zmHTh1LD5pmAxC0m1/eZRExS/L
	 8SAoRXAxgW0OfSEhZdkqfs2I0idIXslXPh+EHMcDvhFrZq2LcqCq338qFMYiVJgRx5aiB
	 CicShpn8lNAoXZ8a37Wgd/3RnF2OgYqyO+CS6DYLeY02s5EtlaKs6UP4l2bb3XH1VRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=42lEuDITFCCwjjJtDKOc863i8nXo5kKnQRfesD1pnYA=;
	b=B4b1W4SBVPDvg3ihfytj3voOC7LeA6GrCjjTspSZ2/iiuxkIiLp2CMQjQbdKIBz9r2d5
	 gjvxYhPDTXhHKqw6omj/fDNJzl3XvdI0GicBETHTjAfJhRIRtqS4JjzhaUjJhO3QL/W1e
	 j9Ut68jo0HQlSVnF83eJGgZiHvgrkIxFoOjeDV3pdBLepLbhzzamfJcNPk1LEZ/BVC51a
	 NettYD6H4EcK018pB/+udVPFkNv4rKgF0f9DL+IPQT/YRShK9C1FVbj3sYzUIV/1qRekg
	 8W73h1CRGgSFmlixM8e4WhvhHb8SbJMNhAFTs+/nucms15Vl7NI/pGU1NWyCJkvB2xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJlyEuft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJlyEuft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157A31F0089F;
	Tue, 10 Nov 2026 01:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272542;
	bh=42lEuDITFCCwjjJtDKOc863i8nXo5kKnQRfesD1pnYA=;
	h=From:To:Cc:Subject:Date;
	b=oJlyEuftRWxRvrfSS4QV85RufLToYc4zxt+ZyHzoWxMKfGsZiZZxoVInM+BMNYZnB
	 xN3BqlE11f0z7vdwasXSFbFmHfzhNaW4TJuC4cU+w2xhyVTvY9dGTcIYiKav2qatcp
	 C/WbnN6uOCieTwkGgJqn8J8M7NIIF0CbsANcDltxqJMs799OlcSIXPG44pqSE98YNP
	 QMDvstYZtAl+6zB0SMlU7ziSdxZuYp2EhuO+n28r74sKn0qhU2OfRSi0xv7Tj6jgVo
	 PbAYoOJCtGKnGDJU11DXzyr9yYyDYLChfr8ZSdbI+Lm0DCKEyAnmpsPrO6yWQdeQVV
	 Y5EMvQ2byqARw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tpmeter: fix u32 truncation of reported bytes" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:20 -0500
Message-ID: <20261109200220-failed-6.18-1025b76d1328@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1025b76d13288a311e8259a0eefde0854fa63c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200220-failed-6.18-1025b76d1328@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




