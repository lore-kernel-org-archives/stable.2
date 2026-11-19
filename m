Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107003;
	b=KH5PxwXQTfuHl3QEJp5By9WoSgVRXELNuoQXLbGIm9ztaLX+7USB0cc9gVOVY0Fv0/E2
	 1aCU/7C+ltiGHeQlaVdRgp9a9Bm045itSDSHi56r8Koe5DAEFBFIYh14uYG1fNcADlsGc
	 q+HQfZSvuo04Yywt1zXPi/gZhM/xkqfpuxTfJUGW887CYi/0G8kfjk/8D80HC1AOoh4ue
	 VdckelcmKWsm7CqV1HuPxPN6DUdHdPBRncnWSpP9FJkvMpKswSIeZql87Lqdqg6a9/NkR
	 i7UxwiOlSlP2yBRUuRd1huv5hzyhc+N7wUq3xQZk07XxSHfbex8XyaE8tVOT+ZlpmUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107003;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t7ZlhucEC/u0UAB1aTqRNEmwSPkcPE43eUSStCiHFrs=;
	b=3dM+JF2ZmV9lB1IlouZRf0CEiMKFT4FLHtBMp3DNWk0uzgxmffdjMTp7a0pOzLxMbcJW
	 omCNwi6HRl8vG7EQGsOKK0ugLr1XI+ArzW7fpoVzdQErj8AjRn7AFQ/NlVjsahq5/GA/q
	 HUzckO7w5dqX4vvW3AW/LVeszmZeAEXlv02cLrXkf60pQQGb1sdb6arHxBhU3rAR2sXy+
	 YaHduRPHjEHF+DRjaCgSueC3rbTdon1P7sdJMrbu1E0mGt0vtDqLZGhhsohhGGos4ukDu
	 f+WnMAJ5pr3JIWvG1mSddnYisHweYN7q9vx4+84ZCujwtFQHZrU8Lz23afz0CGZUbIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNjdYSJy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3A606A333;
	Thu, 19 Nov 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNjdYSJy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795107003;
	b=q1MN0i1PVYyL8JvN1aztRlH4RWk7jJuqztjfmdDb1UKoMJ95Dwzf7ZbpEoiUGj2soBaY
	 EUwhqhdSsu1uGF+ZRM43VGROU1RrNqhsaGUgQ2svNvJjKRSxB2HESToeET1BaudcDdBgI
	 qzCGfpd4zC/Ja0QnFO/lbSSqxV90D48KBQAG6CCevnzXC2fMwvPcLMhq8Ku1H3kTN78TZ
	 Sz679EalPVqXLp2WlplDzI8/1maCGeGxtGqoOuweahiX3gYWcn6lnPVWsUv0puGBVUsZ5
	 2k0aLPZKQQcZsjpkfvHM5lwrUE2pWCa1ivGUf8p1hWjDpDFioIo2+stDPg0PTWpqtFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107003;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t7ZlhucEC/u0UAB1aTqRNEmwSPkcPE43eUSStCiHFrs=;
	b=bnNy5eDsvw8lM4/J90PDiESX1IP1jfr3r+kf0gp+vuIdXKDFEY+Fp2ONnKGa2Ff6yikq
	 WCUkXgNjA7AkYJCrqRN3b/1s0wOnh71ydJkPPioUtEHiRSWkIzfyRPBSz3i54rUVdnh52
	 8Gd6ViiOlWOuIqHpfOBAeUAN9N3nDi7ozkot1q0Hra6ztgBrZpo9UXZLPz4ElIENfqtjB
	 bMywJfVoIi4YVR1lwKZZld5et1LyS5AM8Ob8oSdudpxzP0tGD4SATy79WdyG74aRrp1zq
	 1rgA/TNwwLAUhG24d7hVk6YAVygIQc+cQS30Ctoid0RMZpqJkOpSodN95wAYTCaiPtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 248791F000CC;
	Thu, 19 Nov 2026 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795107003;
	bh=t7ZlhucEC/u0UAB1aTqRNEmwSPkcPE43eUSStCiHFrs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QNjdYSJyO3j31eCA6WuQj9uLfDNvn5ooup+8cXstEogM4y9ruI09/rNPj3K+g/xO5
	 em9bQ6y8omWbVJz8QZXPKzO+xP6CwNxRHF5Y4N72sitDqXS2x9t/pzXY4aKypVoDf/
	 2GZyCTqVQ4YjBwHyFATh43ADLGZpw8ZazhKkCl36Hlt7nXuODBEdC82uzsPTEop4og
	 WwXA8JP1Lr3JMT7ih7sDf+O03gauzbc59267E2AacvfJqI8zRwyfhE311tdMPklQK+
	 Pj0GUNeWXuZ073kgwXvWoIa6IX3c2uHCR7F+VRH7EwdjxLp7nYPogopYq02lj06p3S
	 cj2hhTvIL5xrw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A5ED44B348;
	Thu, 19 Nov 2026 16:50:01 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 16:50:01 +0000
Subject: [PATCH] regmap: mmio: Don't attach the clock if clk_prepare()
 fails
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
Message-Id: <20261119-regmap-mmio-attach-clk-v1-1-91291802ac53@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDvQGNqiV5EuxmSio0YliVIQ7
 97YLt/i/wMiB+EIdXFA4F2iLHOGuhVgepo7RrHZUN7Lp1KqwsCdpxW9lwUpJTI9mmlEVz3Ivpz
 VmjTkeA3s5PMbN++/49YObNJ1g/P8AhNfZa16AAAA
X-Change-ID: 20261119-regmap-mmio-attach-clk-f95ad7fd33a3
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795107001; l=1957;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=i99wsC+7/XSg8MNOgqgqgUZ46RlYbMj6RkR/Vf2Of1c=;
 b=9jiDl8QoEqCknvUZMfHJ+ua9PFRbCuLKzsSUKI6x99WZcMsI0+i45tMlgFNggee5UeHYEJgsp
 6iRbXf9hNrcBfAAPty5w9VsnUBkl6THsynckgmxjhPdAbA0acQ3h+t1
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

regmap_mmio_attach_clk() stores the clock before preparing it. If
clk_prepare() fails, regmap_exit() later unprepares a clock that was
never prepared, and the caller may already have put it.

Only attach the clock once it is prepared.

Fixes: 31895662f9ba ("regmap: mmio: Add function to attach a clock")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/179493691305.3136.16311404541139130213@kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Found while fixing the error path of of_syscon_register(); that mfd patch
is sent separately and neither depends on the other.

Tested on an Orange Pi 5 (RK3588S), 7.3 with KASAN, together with the mfd
patch: with a forced clk_prepare() failure in of_syscon_register(), a
use-after-free in clk_unprepare() is reported without the two patches and
nothing with both. This patch was not run on its own.

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed every change.
---
 drivers/base/regmap/regmap-mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 1de2278fa572..6adbc950877c 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -590,11 +590,16 @@ EXPORT_SYMBOL_GPL(__devm_regmap_init_mmio_clk);
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk)
 {
 	struct regmap_mmio_context *ctx = map->bus_context;
+	int ret;
+
+	ret = clk_prepare(clk);
+	if (ret)
+		return ret;
 
 	ctx->clk = clk;
 	ctx->attached_clk = true;
 
-	return clk_prepare(ctx->clk);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(regmap_mmio_attach_clk);
 

---
base-commit: 50b3d8bb527b11384153c4ca854c8610f4a55649
change-id: 20261119-regmap-mmio-attach-clk-f95ad7fd33a3

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


