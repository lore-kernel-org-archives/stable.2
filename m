Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85229B78F
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925545; cv=none; b=YRSfgu6vv5vwhtdNJuQ34YqiwLaB6W2uT2GXGcfQKkT4ITLHAiKGFCf8M5mXKNqNsior6mk2z0LcVCj1UiYD6KgZlNjg3K3o+15nkA/RcOv5/QyETh7TCgdkdSXR1IiFfBr+GwJkLnuqFHcAFctrnVfUlEcCfcYVhQ9sYJYaOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925545; c=relaxed/simple;
	bh=zznIaWIb2kn7FFAybqoU2YhmCdczMn2HoA1qIP+QoRs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nwiomr49PbZUbfbxKHPGXcTV1QKeUFX5a4w+ioTeDDecpB/judyI5QRnOHd6UjDALZXrKiSXhxqeo8JUXafRde4WkWu7OaYhOYAAfR+gBcFEC/1K19XVRN9YWnKcshn3rjoM72dsv7/6RCJqNIljS68Mzdv0eBnYOlh64FeY9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEUXI96G; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEUXI96G"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074797dfa9so5922664eec.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780925543; x=1781530343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQrWfCUPb/iGFsQSPTg8c/hZ3vsvBFETCZvhQuNvMPE=;
        b=aEUXI96GU/9ERoEQSoNXGb1y35zSOP9KeR27C5aD0+v1gxPGV9NpeiWk/ykOd9Ludl
         ruNcNA4rsUTUJpp0UlCkNTVrHdl8lWUxaLrK64dWVbG8mEVc5bIBasjUdKyRZf9KZiA0
         eDkJDbsghIYSonxGb4VyyhyHc/Cpxk/RrBHbgtANE9tzumzBCYAmkg2CNuowmz1ppA6Q
         Aq44ZQVfkinjEPegZSooBLpTUkGLwBy2Mvz+sHsfvmc+LOsCr57+PFdo5/23aieeJiGI
         BnFwta3K5cKKGw4p8XLfvTtJgAQY+W5M3lIj7YohC41ZZKjTxP5GZQzCxuZNDbVWRapg
         tEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925543; x=1781530343;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQrWfCUPb/iGFsQSPTg8c/hZ3vsvBFETCZvhQuNvMPE=;
        b=dI+DTaST53Rc7sZ+2bngkFJH3ANitOg6Q0WdhR4pm4BSGA2ZI96iul6Xe12PqnBcFB
         ce+qDf/3c0rZwwFUP3sRTLHlMnU2xI0Y+a5GbNOfzxutWXrdgS1IZZEOdfyMnJSUx3mS
         /h3lA/xkebHUO+XpkcAZjRdblls1TB8F+UEEgbLRnnFI1U5fFq2NFo2Vo4x1c5lW4IXM
         xfxEKOMoUUUnHvGnHdCnOwkDpMyVD2QtHhyEqVS164+Dyh3NqnlBFulBQXKDYvgHzRyO
         pvThCrGiH7eQfRFesbEQzj/9EtHNM41GBU1f5O+bJMd2xrftMjLgrc0RflTqr8LntIux
         ddjg==
X-Gm-Message-State: AOJu0YwJ3KFUXNR2Brkby8X60Vgr2tqMi6QlSeq5D4/AAYS4WkzeibP1
	khDfyuJXqQvJ2BAwjD5ZjNawxpXyChjnZhEir6i+En9e+DbPiPZCl2T7em6OI9d2e2swDRy1nAS
	eJ4/379QzFgGpthtVUlfnZdJsEeAunP7usMPV1eIQxD+HpAAsNShKOyhq6sCJi/uDSvkhcOXJk3
	0E3UKYQCgVqcy50YNLe6yeUI5tRDxb/OADbXzdHs1ADsoZRDc=
X-Received: from dycqa4.prod.google.com ([2002:a05:7300:fe44:b0:304:1e27:a62f])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:168e:b0:304:630d:e4ec with SMTP id 5a478bee46e88-3077b272073mr8681528eec.28.1780925542521;
 Mon, 08 Jun 2026 06:32:22 -0700 (PDT)
Date: Mon,  8 Jun 2026 13:32:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608133216.1396790-1-cmllamas@google.com>
Subject: [PATCH 6.12.y] wifi: remove zero-length arrays
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: yichenyu@google.com, kernel-team@android.com, 
	Johannes Berg <johannes.berg@intel.com>, 
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com, 
	Carlos Llamas <cmllamas@google.com>, Lachlan Hodges <lachlan.hodges@morsemicro.com>, 
	"open list:802.11 (including CFG80211/NL80211)" <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Johannes Berg <johannes.berg@intel.com>

commit a85b8544d46390469b6ca72d6bfd3ecb7be985ff upstream.

All of these are really meant to be variable-length, and
in the case of s1g_beacon it's actually accessed. Make that
one in particular, and a couple of others (that aren't used
as arrays now), actually variable.

Reported-by: syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com
Fixes: 1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements")
Link: https://patch.msgid.link/20250614003037.a3e82e882251.I2e8b58e56ff2a9f8b06c66f036578b7c1d4e4685@changeid
Change-Id: I699f1aaaf11005b45a189bfe164e65c5e2c8a6ce
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/linux/ieee80211.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index abb069aa5fa5..85bf3ac6db57 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1266,7 +1266,7 @@ struct ieee80211_ext {
 			u8 sa[ETH_ALEN];
 			__le32 timestamp;
 			u8 change_seq;
-			u8 variable[0];
+			u8 variable[];
 		} __packed s1g_beacon;
 	} u;
 } __packed __aligned(2);
@@ -1522,7 +1522,7 @@ struct ieee80211_mgmt {
 					u8 action_code;
 					u8 dialog_token;
 					__le16 capability;
-					u8 variable[0];
+					u8 variable[];
 				} __packed tdls_discover_resp;
 				struct {
 					u8 action_code;
@@ -1690,35 +1690,35 @@ struct ieee80211_tdls_data {
 		struct {
 			u8 dialog_token;
 			__le16 capability;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_req;
 		struct {
 			__le16 status_code;
 			u8 dialog_token;
 			__le16 capability;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_resp;
 		struct {
 			__le16 status_code;
 			u8 dialog_token;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_cfm;
 		struct {
 			__le16 reason_code;
-			u8 variable[0];
+			u8 variable[];
 		} __packed teardown;
 		struct {
 			u8 dialog_token;
-			u8 variable[0];
+			u8 variable[];
 		} __packed discover_req;
 		struct {
 			u8 target_channel;
 			u8 oper_class;
-			u8 variable[0];
+			u8 variable[];
 		} __packed chan_switch_req;
 		struct {
 			__le16 status_code;
-			u8 variable[0];
+			u8 variable[];
 		} __packed chan_switch_resp;
 	} u;
 } __packed;
-- 
2.54.0.1032.g2f8565e1d1-goog

