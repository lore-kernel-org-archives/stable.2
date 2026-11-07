Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049094;
	b=qTWZPeDteJjlcKWBJg2HK123B4KbKxaBiVqGP80eL1iLVQz7tDVhre44zokNdxxXegTS
	 JXdq6Z86kaUFdgddluaQzgrcnfxSQetliZ08isJe9ghcM7gGihbBBx7cMGFGOUVeF1gjs
	 23f2EM1e1iJNlIFv4e3aHxQodMsa446VNJcClLzTq7hXuaVCzuTiJTmVon9v+Ixl5jrqt
	 VSBzEkbnX1qcYsppfaPBGSR9rqPtFpiFVDNWpf6xXokEbSKjkZu7y5k9UsTArqsmRtm57
	 Vy8DtftbJGWp3no41mx2jJBVgEcwYfie0v/b36u2YspzCMmyWEbrXJUmzcJekHE7fPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f9+TzOrSRtWd/ZFZ9Vf5QqCDvEmP7szagmev3x/kekQ=;
	b=2Bq2hprcGIbyavZ9s33hYlc5kkJ0nHXwMQxk7viEa9oEmuaPi0nGvjvxp9w8IsNBzaZx
	 YLiChkSds95qKLE9KOHfkPXduUIxeNJxZiWc+H9oQ+MNsR1lDwV1jdqL0JTDm5ygiSNac
	 vWc+3nx1lHlBfHZgJF1kDuyiW88qOmrANihvyJ0FlZ1OliRD5+2oLb0K8WLwGiY8JcvSr
	 Zed10WjGQRL/pm9QbR7ZjhVkXMTYWdYPFTQorBcCgW97psYyl6Shcd1R2/Sh3lAPbWRLO
	 bNyh3brJyuNs1l2lp7knWJiqFfjl1R5CT+5b5JSXOz7OLA6tqRCW1nPpgsC+cy94wNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B73MGK1z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBC606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B73MGK1z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C4E1F008A3;
	Sat,  7 Nov 2026 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049093;
	bh=f9+TzOrSRtWd/ZFZ9Vf5QqCDvEmP7szagmev3x/kekQ=;
	h=From:To:Cc:Subject:Date;
	b=B73MGK1z1WwGiKjnL/vW36YbzWrFKhBN/e7RNqmV1dF+5MLGBa9Uw/pgjz0cU2Gjl
	 v7gCcICtw5plqiX2ePvGmCne/nO3G3hFv//07o9vCRE/6AOeHnVnET1T5Dh60OzDZn
	 Vk1lrA0vUaav+zq94Cc26kUZ0+GSTsjV733g6RGePPygvCB7RemTIcLPF4v/wzmDxj
	 BNeZ9a0Nssb/JRNHveZNyh/Ub4PceWgafRNkELCvBybwfD1z9olrIM7lu/4dPvnLFd
	 dYIEtZfZbxDB+lZ1S6/n6kkg6lGEbPI9ky2uDxgF2BKbp7g7lzjff1npc9YSdcLWM5
	 LABzfcOxw/lVg==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: don't sleep in the clk .is_enabled callback" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:11 -0500
Message-ID: <20261107055811-failed-5.15-61490ff518c7@kernel.org>
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
git cherry-pick -x 61490ff518c7b3ea3ff1cd16bbc012e9e4f1ab74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055811-failed-5.15-61490ff518c7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 61490ff518c7b3ea3ff1cd16bbc012e9e4f1ab74 Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 19 Aug 2026 11:49:20 +0530
Subject: [PATCH] media: microchip-isc: don't sleep in the clk .is_enabled
 callback

isc_clk_is_enabled() calls pm_runtime_resume_and_get() and
pm_runtime_put_sync(), which can sleep and are not safe here, as
.is_enabled must run in atomic context. clk_disable_unused() calls it so
at boot, and CONFIG_DEBUG_ATOMIC_SLEEP reports a "sleeping function
called from invalid context" BUG.

Use the atomic-safe pm_runtime_get_if_active() and pm_runtime_put()
instead. A suspended ISC has its clocks gated, so report the clock
disabled when the device is not already active.

Fixes: 01192aa1c5c2 ("media: atmel-isc: Enable the clocks during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-clk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-clk.c b/drivers/media/platform/microchip/microchip-isc-clk.c
index 24358d804e75d..66dc522a61908 100644
--- a/drivers/media/platform/microchip/microchip-isc-clk.c
+++ b/drivers/media/platform/microchip/microchip-isc-clk.c
@@ -98,15 +98,14 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
 {
 	struct isc_clk *isc_clk = to_isc_clk(hw);
 	u32 status;
-	int ret;
 
-	ret = pm_runtime_resume_and_get(isc_clk->dev);
-	if (ret < 0)
+	/* Runs in atomic context, so must not sleep to resume the ISC. */
+	if (pm_runtime_get_if_active(isc_clk->dev) <= 0)
 		return 0;
 
 	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
 
-	pm_runtime_put_sync(isc_clk->dev);
+	pm_runtime_put(isc_clk->dev);
 
 	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
 }
-- 
2.53.0




