Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF43B1EC8;
	Sun,  2 Aug 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672789; cv=none; b=HUbye5q6dPsNwd6/BcKKMDiqUo8JdS3BWzlDygaSpC+LJycLUB8gkDd87una2Ju3brbFppa6uGeqMg3DJPXQ4/DF64Z6atRuFgHlDEse3CtPvEqV84nUWQto08/I8l8Yvqgb7pAWJd1BoRQ4YoT65wTqIjxs1j6jPsMPayerZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672789; c=relaxed/simple;
	bh=WGFFdsRUYtTtbwa6B95ZHBXoVvi4dQVulYeTYwNSlW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b1qb9dnJytazAdaF3PlarKzi5wDAueaWw07ZX/8E/07G0iWwKaduGCpgFt7iz+r0f+7ux7X0eDFuF1Ib04iRw3m0vp6uw3OK3g2xnoEV4s1jpixzFx4Pe/72WpSp5I65lnGR5PnuVfehAjmiKJ4p7QlzchGr85JWMYCQjJ49Tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7idJfot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7idJfot"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1A85C2BCF7;
	Sun,  2 Aug 2026 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785672788;
	bh=WGFFdsRUYtTtbwa6B95ZHBXoVvi4dQVulYeTYwNSlW4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=o7idJfotBYjHgV7BD/qzIbHPVLcD/XoMUy9s8ojgK0jmAoCn2FWDW+ymSuUcPfIfO
	 OCdlDNhckDEQqpeiX0vKB9T0X3sNngjGCEu+6o12lMEGlGRvzcr4u0f5m7xG6po5gX
	 Etry41WpIN3wrC+UshFlToIF3Qc5RCWLodIyZbcNLmuVQGYrxhDVN9pvPumOP1M8sw
	 3XVaFmHzcQw/SzFoBwwIuXjQo9pqRCfpk5pISKa/cFPYOUSe+zUQc4uzs0HxFLddWy
	 uR7nyQ8GqNjFMbAdKCsGtoecesGadlA/lUjm3f8OfmoKRfNcZvw4FbDL2xD6iMBY1g
	 V45utSMzj6ogA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F55AC55177;
	Sun,  2 Aug 2026 12:13:08 +0000 (UTC)
From: lurenjia534 via B4 Relay <devnull+lurenjia534.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 20:12:54 +0800
Subject: [PATCH] wifi: mac80211_hwsim: drop frames with invalid channel
 width
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-mac80211-hwsim-invalid-width-v1-1-94d9bba2ae60@outlook.com>
X-B4-Tracking: v=1; b=H4sIAEU0b2oC/yWMQQ6CMBBFr0Jm7UTaBVSvYlxMy2jHQDUdBBPC3
 W119fN+Xt4GyllY4dxskHkRlWcqYA4NhEjpzihDYbCt7VrXWpwolDEG46oyoaSFRhlwlWGOeOp
 7Z3zH1HcOSuKV+SafX/5y/bO+/YPDXJvV8KSMPlMKsV6rZB5Z9TiRJNj3Lz8k8gGgAAAA
X-Change-ID: 20260802-mac80211-hwsim-invalid-width-97781b6ea768
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, lurenjia534 <lurenjia534@outlook.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785672786; l=2911;
 i=lurenjia534@outlook.com; s=20260801; h=from:subject:message-id;
 bh=/iY0dNxP0zkE1SAHnpQcq1gmr+HYoaV6xhQaYs/s9EQ=;
 b=DKMeWXh6UssVYnAqq0vsaXgnuNYEkVb3aQrBjTUK+Ujiq65tB29Nk01utpN5/qzZ5JsvqSm45
 og9bgY1+E4VCnN2H0C0xW6P9NBK78klLBwkOIJc5FaZzH+DLmEfqRpk
X-Developer-Key: i=lurenjia534@outlook.com; a=ed25519;
 pk=nMa0OcUJYxnaGbhs5f95IwVQ7sPrWI7It3LMsh0BJX4=
X-Endpoint-Received: by B4 Relay for lurenjia534@outlook.com/20260801 with
 auth_id=906
X-Original-From: lurenjia534 <lurenjia534@outlook.com>
Reply-To: lurenjia534@outlook.com

From: lurenjia534 <lurenjia534@outlook.com>

A frame injected through a monitor interface can request a VHT transmit
rate wider than the channel configured on the simulated radio.  The rate
comes from userspace-provided radiotap metadata, so it can be invalid.

mac80211_hwsim_tx() currently warns and returns when the requested rate is
wider than the channel.  A warning is inappropriate for invalid userspace
input.  Moreover, hwsim owns the skb after its ->tx() callback is invoked,
so returning without reporting status or freeing the skb leaks it.

Drop frames with an invalid channel width and release their SKBs with
ieee80211_free_txskb().  Frames with valid rates continue through the
existing transmit path.

The reproducer triggered the warning in 20 of 20 unmodified-kernel boots.
With this change, 100 iterations completed without a warning on both the
report baseline and wireless/main.  An E2E control also confirmed that a
valid 20 MHz frame was forwarded while a 160 MHz request on the same
channel was dropped.

Fixes: 585625c955b1 ("mac80211_hwsim: check TX and STA bandwidth")
Reported-by: syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a441a03.b42ede87.8e801.0009.GAE@google.com/
Tested-by: syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5.6 MAX
Signed-off-by: lurenjia534 <lurenjia534@outlook.com>
---
Testing:
- syzbot #syz test on wireless/main: pass
- original syzbot C reproducer: 20/20 report-baseline boots warned;
  unmodified wireless/main warned in 3/3 independent boots
- patched original reproducer: 100/100 iterations clean on both the report
  baseline and wireless/main
- monitor-injection E2E: valid 20 MHz frame forwarded; invalid 160 MHz
  frame dropped
- CONFIG_MAC80211_HWSIM=y/m runtime tests: clean, taint 0
- GCC x86-64 full y/m builds, GCC W=1, sparse, and Clang x86-64/arm64
  target builds: pass
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 75caa97bec..2d4bc3cd9a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2256,8 +2256,10 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		else if (rflags & IEEE80211_TX_RC_160_MHZ_WIDTH)
 			bw = NL80211_CHAN_WIDTH_160;
 
-		if (WARN_ON(hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(confbw)))
+		if (hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(confbw)) {
+			ieee80211_free_txskb(hw, skb);
 			return;
+		}
 	}
 
 	/* wmediumd mode check */

---
base-commit: 2812e64e1575e05500a35c405aaa6e99b7d7930b
change-id: 20260802-mac80211-hwsim-invalid-width-97781b6ea768

Best regards,
--  
lurenjia534 <lurenjia534@outlook.com>


