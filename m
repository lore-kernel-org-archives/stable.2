Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886186;
	b=R8NV2Efr26sucAcst4ec2LXTpzSTU8IV9/UxKU2XJmy4qqcZNyMIdVThQbA4BY8PNMjw
	 qZdnpmFuWPNBDmAoKHUT7S/8NbZypeYTFzEDk+Py+fLve4B7eoMJCnLy/v0G6/Be1RQpQ
	 cmRQSWRcYW2NUYJgEMs1P0bQT2cxkF7fldYeE9gCVZWLcSI8AB9fKdy1DwLB14LlYNS71
	 gVdAmbYo7LxcsE02JZhG/8wUi69Erzyf4o/ox+GsbzezCpy4aYhtjQLQF3ArcFtR7AWry
	 eCJt1ULPiyxEcXykfHa60+CKbiJQ6HGw/UZAslNpuFR7g8GhYY7Kc6sc8/I2TY4iSsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886186;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VlgS4kPQ1tkST4DxH/0zqX7QYY95b8QOwNrfulz9Nqg=;
	b=hecQ9nE3iLVB/1ZsnTTe8XGZOxgnMU6y6w2zxCOcUN1YoUSpG70Y6jPE0VFAx+vEHAk5
	 NLuRaljKtAJi7vk2Frml5j17cWY1dIE4uNwsmQ88WyeYzJmSkcHNscOwcZ9ZblSeSANuT
	 AB4HRC6SGqn2gk4JJcpjNsJDoEStx4EEuzOHpQ57yHs+GvLsfKqYOTe78+tfEJBQFejkz
	 hahYLauoOKF91FpxmffzrBXofzhfqxzISKaaie+gWpVr34iIDxx61ldJaI2cGLdTJPeRM
	 i+EO/wbYvDoyibCbYwagdlRKv9iLXdYq7sWoHASZOsDh3ag/esax3s6w7S05/YaQV5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=VSGG30xy;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B6606A32C;
	Tue, 17 Nov 2026 03:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF2B6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=VSGG30xy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=VSGG30xywvYNxyhwD7DhlCZzA6S/Hc3I13cUsSTpev6N4fHvZPjuawyOuoOpxegDZJjZCfnM5X4Ub
	 dux9gOsPPRZvNk84Wwjm06X1DJV9xMiE3f9rumGU8wLpowTTnnNNeGgejtPpQKnnyMk8phH8GqwE1Y
	 tlYH+gxpUcWmmWT4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66afbca237a0-d183c;
	Tue, 17 Nov 2026 11:29:39 +0800 (CST)
X-RM-TRANSID:2ee66afbca237a0-d183c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26afbca214b2-a19d2;
	Tue, 17 Nov 2026 11:29:39 +0800 (CST)
X-RM-TRANSID:2ee26afbca214b2-a19d2
From: guohongyu <guohongyu@cmss.chinamobile.com>
To: lachlan.hodges@morsemicro.com,
	dan.callaghan@morsemicro.com,
	arien.judge@morsemicro.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: [PATCH 2/2] wifi: mm81x: bound disabled-channel loop to the allocated response
Date: Tue, 17 Nov 2026 11:22:27 +0800
Message-ID: <20261117032227.154874-2-guohongyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117032227.154874-1-guohongyu@cmss.chinamobile.com>
References: <20261117032227.154874-1-guohongyu@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mm81x_mac_check_fw_disabled_chans() allocates a response buffer sized
for ARRAY_SIZE(mors_s1ghz_channels) (26) channel entries plus the
fixed header, but then iterates the entries with the firmware-provided
count alone:

	for (i = 0; i < le32_to_cpu(resp->n_channels); i++) {
		struct host_cmd_disabled_channel_entry *entry =
			&resp->channels[i];

n_channels is a __le32 filled by the firmware response and is not
validated against the buffer size in any way.  A firmware that reports
more than 26 channels makes the loop read past the end of the
kzalloc()ed buffer into adjacent heap memory and interpret it as
channel entries.

Bound the loop to the number of entries the buffer was actually
allocated for.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Cc: stable@vger.kernel.org
Signed-off-by: guohongyu <guohongyu@cmss.chinamobile.com>
---
 drivers/net/wireless/morsemicro/mm81x/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/morsemicro/mm81x/mac.c b/drivers/net/wireless/morsemicro/mm81x/mac.c
index 0fa80b1488aa..953958bf1241 100644
--- a/drivers/net/wireless/morsemicro/mm81x/mac.c
+++ b/drivers/net/wireless/morsemicro/mm81x/mac.c
@@ -288,7 +288,8 @@ static void mm81x_mac_check_fw_disabled_chans(struct ieee80211_hw *hw)
 		ch->flags &= ~IEEE80211_CHAN_S1G_NO_PRIMARY;
 	}
 
-	for (i = 0; i < le32_to_cpu(resp->n_channels); i++) {
+	for (i = 0; i < le32_to_cpu(resp->n_channels) &&
+		   i < ARRAY_SIZE(mors_s1ghz_channels); i++) {
 		struct ieee80211_channel *ch;
 		struct host_cmd_disabled_channel_entry *entry =
 			&resp->channels[i];
-- 
2.43.0



