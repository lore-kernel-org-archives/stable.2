Received: from out28-134.mail.aliyun.com (out28-134.mail.aliyun.com [115.124.28.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD6480DEA
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709475; cv=none; b=p+tMM9RNjod0n5nvPpcZYanTTZdpLRL/tAdIU/EGeK9agQsQnMLZ5U9jM1G+FuSiDLcu6Ycm93CPJG3m94th1sD42pZJw8lEL8wDjMj55+B8Rirol6dfSyAqf75lwpEJqaIU13E2MpQ01yTb2yTjiFiROlojrGSnsSc1w0D1kO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709475; c=relaxed/simple;
	bh=JDITdoNQe6JysXQwdncGz5aHwM8xnjrR1YGJSUXmcTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xc4GLMuaLt++zghT0Tq/oG/lEhG+vY+iB4yw2x5XyxUDVc0hXKTa5c1OnQN8SmJCnePTyBwp0wdpXWrjWwezJa+Xs3255C/JYPBrdf/cK6ZhejFCKIVMESxJFA3aKuU9BE+5VY1m+OlBCPmTTV3XjV5FsxsI5s5PIauAteWxqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sigvoid.com; spf=pass smtp.mailfrom=sigvoid.com; dkim=pass (2048-bit key) header.d=sigvoid.com header.i=@sigvoid.com header.b=jhKYziPx; arc=none smtp.client-ip=115.124.28.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sigvoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigvoid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigvoid.com header.i=@sigvoid.com header.b="jhKYziPx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sigvoid.com; s=default;
	t=1781709463; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oSWc9sSlhXbpQOqYnu9ZH7ql4C5+7+B5hkIhJzZFNDU=;
	b=jhKYziPxMCom0+m9IbaHBnbqyIDVm8Jw4QOFZ4+xRPsrOhkBqpgxSMvitTZpMnyHjah92avulsK9LQQfuOg+XF2Qz8n63ewMhVeyyATx1pC0iejm4y4sIcssPgwmZ0bAmRgtDj2f7nREbU8QTqxc8MP/Hcjik9rJpeBosrH1KlDe8losvamMloBcHTKey2VfVN+NEDmUtTh4RnMO9oRohnpXfO0OEDoPXidVat9vmjagmjF3yPkcMHLZbNjUElG+GkeaikrmC/+t1shU76gj+ppTGJEj8DuVs7365cIbWi4u5ZZVwBgYSDvU60Q+akD0iq7h0XdyYPIkfatCWdrmKQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06689589|-1;BR=01201311R171S32rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00466299-0.000278393-0.995059;FP=13590277443709849546|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=yingjcao@sigvoid.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.i-qcTA6_1781709439;
Received: from localhost.localdomain(mailfrom:yingjcao@sigvoid.com fp:SMTPD_---.i-qcTA6_1781709439 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 23:17:42 +0800
From: Yingjie Cao <yingjcao@sigvoid.com>
To: yingjcao@sigvoid.com
Cc: stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: fix negotiated TTLM skb allocation
Date: Wed, 17 Jun 2026 23:17:14 +0800
Message-Id: <20260617151714.24458-1-yingjcao@sigvoid.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The negotiated TTLM request and response allocation only accounts for
one TTLM element header. When downlink and uplink mappings differ,
ieee80211_neg_ttlm_add_suggested_map() emits two elements, each with
its own 5-byte header.

With all eight TIDs mapped in both directions, the helper writes
42 bytes of TTLM data, but the callers only reserve 37 bytes for that
portion. With tight skb tailroom and CONFIG_DEBUG_NET, the next
skb_put_data() is caught as skb_over_panic; otherwise the write can
corrupt skb_shared_info past the intended skb data area.

Account for IEEE80211_TTLM_MAX_CNT element headers in both negotiated
TTLM request and response construction paths.

Fixes: f7660b3f584a ("wifi: mac80211: add support for negotiated TTLM request")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Cao <yingjcao@sigvoid.com>
---
Based on wireless.git main:
ddd664bbff63e09e7a7f9acae9c43605d4cf185f
("Merge tag 'net-7.1-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

The crash proof used reports/poc/ttlm_force.c in a
QEMU/mac80211_hwsim environment. I used hwsim because I do not have
physical Wi-Fi 7 MLO hardware that satisfies the negotiated TTLM
prerequisite.

Local validation:
- git am on the base commit above: OK
- git show --check: OK
- scripts/checkpatch.pl --strict --no-tree: only the expected warning
  that my shallow checkout cannot resolve the older Fixes commit

 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b98ddfa30..0b6626a01 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7998,7 +7998,8 @@ ieee80211_send_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
 	int hdr_len = IEEE80211_MIN_ACTION_SIZE(ttlm_req);
-	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
+	int ttlm_max_len = IEEE80211_TTLM_MAX_CNT *
+		(2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1) +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
 
 	skb = dev_alloc_skb(local->tx_headroom + hdr_len + ttlm_max_len);
@@ -8066,7 +8067,8 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt;
 	struct sk_buff *skb;
 	int hdr_len = IEEE80211_MIN_ACTION_SIZE(ttlm_res);
-	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
+	int ttlm_max_len = IEEE80211_TTLM_MAX_CNT *
+		(2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1) +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
 	u16 status_code;
 

base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
-- 
2.39.5 (Apple Git-154)
