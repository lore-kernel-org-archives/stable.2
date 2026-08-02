Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2631197C;
	Sun,  2 Aug 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695820; cv=none; b=Hpq17DstQEVxYi5MopZtalXyEvmPOoNqy+HtmXQ7PhOUv2UF4q+4D9O7H9baposdOwuLYAJhqBbL12ZPhVDoQIBnF5iiWlsBxDZFjh0ySGUjuTmnVQYyE1T0mV4u8Oq3gwVery3xrpPvp261LaimifrKwBIdk5AyUPNkdBC6OQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695820; c=relaxed/simple;
	bh=qbkol7+ZzxSuj0gkeNi/Ia65PjG/Rv2B7E6FP/n4d68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lYMNH+OpSiolbNROF+dbBXtJOekbUXz2/qlWNrjTEX2Jb/VzmyLQHPIhXNnvbS4o6j/t3aBPvX8Kn1VXonUWkEw8qiFi8LjfUQMsf1np6socThnyX2KL9YyH/IleAu+dc8IzmrSke3Na2j53Nar4qctvngXd1mCg3bKy7B1Musk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aejHb3Ca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aejHb3Ca"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00165C2BCF5;
	Sun,  2 Aug 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785695820;
	bh=qbkol7+ZzxSuj0gkeNi/Ia65PjG/Rv2B7E6FP/n4d68=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aejHb3Ca7+NCLXK9SGAT15rM7J6xIlVddsZhYIaOrPiO8PYbRi2sehCpz1PdOaO1k
	 Ib9o4Hi5z5gNC1UP6Eeph1IZdRPSluiiIdk4yiHGcGnB+2U8liLt844lWwXcxXwB9V
	 cBHm9OkRv6iZ4X553xBQOfFP4yX/MHbhtWuisvXl2+gJvGrjStdab0B/cmvudytucT
	 v5BQVMQmG9df253mTg/872BSHDG1bZaqLCg3/hO69mM+7XFF1k2ivfdrcq8XVWtns8
	 3NnZtNZOw5FHALdocxTrX6e0owQMojr0xjqzodLlEfRLhW1FLV+3ybcA2zeRcmXS0u
	 NL3U3H3FiO2gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DE4C55174;
	Sun,  2 Aug 2026 18:36:59 +0000 (UTC)
From: Jiaheng Zhang via B4 Relay <devnull+lurenjia534.outlook.com@kernel.org>
Date: Mon, 03 Aug 2026 02:36:52 +0800
Subject: [PATCH wireless v2] wifi: mac80211_hwsim: drop frames with invalid
 channel width
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mac80211-hwsim-invalid-width-v2-1-73724b7a216d@outlook.com>
X-B4-Tracking: v=1; b=H4sIAEOOb2oC/42Oy27CMBBFfwXNmimxhfJgxX9ULMbOFE9JbOQJS
 RHKvzdJxb6rq/vQ0X2BchZWOO1ekHkUlRQXY/c78IHilVHaxYMtbFnUhcWe/CLGYJhUepQ4Uic
 tTtIOAZuqqo0rmaqyhgVxz/wlPxv+EybJ3LEqXP4afbhv9sNKX7eOlNFlij6s0Xt96Eni2gfRI
 eXn9nQ0G/F/p0aDBptj2zhHlrgszukxdCndPnzq4TLP8y/6W0VnBgEAAA==
X-Change-ID: 20260802-mac80211-hwsim-invalid-width-97781b6ea768
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+435fdb053cf98bfa5778@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jiaheng Zhang <lurenjia534@outlook.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785695818; l=3238;
 i=lurenjia534@outlook.com; s=20260801; h=from:subject:message-id;
 bh=BEm/DevqbcVuAp+oAP+KtQG1eYVhSPXPqK+tv0Hh/DM=;
 b=MQq4rxQlpM2MuCmPTCClzJxmVSfRJZra+JSNyjW9pAW3QCGdolvJvYKfyK282QfXUKK01AEpH
 m8EG+zVpaS/DcG2rlnsVj7Mh2M+j1rmVKGn7BLFmB2e8Ql3wjlVFEMl
X-Developer-Key: i=lurenjia534@outlook.com; a=ed25519;
 pk=nMa0OcUJYxnaGbhs5f95IwVQ7sPrWI7It3LMsh0BJX4=
X-Endpoint-Received: by B4 Relay for lurenjia534@outlook.com/20260801 with
 auth_id=906
X-Original-From: Jiaheng Zhang <lurenjia534@outlook.com>
Reply-To: lurenjia534@outlook.com

From: Jiaheng Zhang <lurenjia534@outlook.com>

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
Signed-off-by: Jiaheng Zhang <lurenjia534@outlook.com>
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
Changes in v2:
- Use my real name, Jiaheng Zhang, in the author and Signed-off-by fields
  to comply with kernel submission identity requirements.
- Explicitly target the wireless tree.
- No code changes.
- Link to v1: https://patch.msgid.link/20260802-mac80211-hwsim-invalid-width-v1-1-94d9bba2ae60@outlook.com
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
Jiaheng Zhang <lurenjia534@outlook.com>


