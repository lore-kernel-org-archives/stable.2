Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549BE525A6F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553746; cv=none; b=YAws45n4UVtO+g0BubAg4DEI6+Y3eCCKuXoctlaYIR7kkvBA6U08qf8SFA8IoV8V5V7rH9MbEb3r5NnsvMQeVXwv8GDnDUBVdeKNasuFTHgl6tf6xUJYq9jwIwW83tcAXAHtvPdcAlal09c+YyiVk028H3ckgApk4mCArZpmNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553746; c=relaxed/simple;
	bh=PWJukDUqmQjG6nax1yH5sUt5blvqZCXFje4nnl7OmoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcfByiuI+4DBF7V1S923gXKKuQ1xFNmfLm/tWwa7UgWVfCABdZrX107dTgmPFHM76bmxUfjthCxrI1AdKVi3kTrITC1MQ3L9DXUH2WXuBD4hxwzlygGOs/ZmvPIKHdigdz4zdqYm9ehunK45pcRKC4Tt4a4kU3uP237wm2QQNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=B7HSMM7I; arc=none smtp.client-ip=95.215.58.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="B7HSMM7I"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PWJukDUqmQjG6nax1yH5sUt5blvqZCXFje4nnl7OmoM=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788553713; v=1; x=1789158513;
 b=B7HSMM7IwSo5NUxLvnaSWoS6kQJFXFUEcW+p9knhulztEaDupnbIBm0FMSwvICj5+7q534aZ
 bdOkr4LwGHK7hkDX7Tgk8oW1Q4s6I2+2vVUasGqYFBrCxLlZTxqEwQ25jqDQj1aCzTffZMSTBhJ
 KVNLdKQIHcLVE5pEDTBaeN4MXhsxwyAN3UO6WWty3xzOcGqBm+fez2kNEaLsTelho1Wp8stsqYK
 K0Ot5tQEbyh+nT+8cz8MMSTB3nWPvzNSR+1eVRcKRjrqlgEY25CnkRyQ2mTsKDHSp5RyP3fsRuO
 JDMEvIs5VaLb8vVh0OG4lz4DJExT1qz7hO1WRU00rUg5Q==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 32954092dbf4826d;
	Fri, 04 Sep 2026 20:28:23 +0000
X-Mizu-Trace-ID: 32954092dbf4826d
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexander Wetzel <Alexander@wetzel-home.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] wifi: mac80211: drop the monitor filter counts on stop, not just sometimes
Date: Fri,  4 Sep 2026 13:28:17 -0700
Message-ID: <20260904202817.12564-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bringing a monitor up raises the receive filter counts for every monitor.
Taking one down lowers them only inside the branch that retires the
virtual monitor. So an active monitor leaves an increment behind on every
cycle, and the hardware keeps delivering frames nobody asked for.

Dropping cooked monitor support indented the decrement into that branch.
It sat outside before.

Counts after each up, down and delete cycle on a 7921 USB part:

  without   cycle one ends at 1, cycle two starts at 2
  with      every cycle starts and ends at 1, in any order

Move the decrement back out so it mirrors the increment.

Fixes: 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
The counts are fcsfail, plcpfail, control, pspoll, other_bss and the one
that keeps TX status reporting armed. Changing flags on a running monitor
still balances, so only the open and stop pair drift.

v2: changelog rewritten by hand, and the counts above are measured on
    hardware.

v1: https://lore.kernel.org/linux-wireless/20260825043754.66918-1-lucid_duck@justthetip.ca/

 net/mac80211/iface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 43460a705a6b..9b400caf2765 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -630,8 +630,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 				hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
 			}
 
-			ieee80211_adjust_monitor_flags(sdata, -1);
 		}
+
+		ieee80211_adjust_monitor_flags(sdata, -1);
 		break;
 	case NL80211_IFTYPE_NAN:
 		/* Check if any open NAN_DATA interfaces */
-- 
2.55.0

