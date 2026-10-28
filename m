Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197199;
	b=rohMmFLV2HT+EP1SHFBAMtELXedZiwXA5IkYY1NamvKEM2dKCfytzL5+YbE7zIWg1m10
	 fpBKNy95c5IhTCKR+bIUWDBsi4K+q4TvhJGGqN9u4EfD4G4m2l7TCONjhpnSSUCVv7IBK
	 DkLP5LyFLjWZsutPTQDUvGGr5e0sKvfilofuxXCZ+lEnC/3G8p482leJZ49OgMS2RD/Q2
	 GmfnnCol0QGBe/GPMuOi9AtWJ80I2SY8lq1bPjrVYQMrfV0Oob274BmKptavdhXeuJLCK
	 ZuLkjhUwYst/1Gbs03UbApC32PaXWu2k2fKzpwBt0VtDzisuppJgOc+tEeVYWMSLp9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=66KvjC7o9TYJVmk4sgr3wFJ9czeGpidCIDPzYdjOH+U=;
	b=CKjdM3LjGc7WnUjMUlCBRVEiOZN8JFil6L49PK6QDylbNpaD+/UdmDthWdFuOsdgl+Xb
	 Q/AHK3mMikwsw1Bw0K7bi841veyBkmCRucZSToLcY/2VM4WxnraYaHznFheVWChipYegQ
	 rwgXChnyyNURtW8CuExVQk8lMeYoq/Lb5wOJg3Fn/g2JCv+C0ZkjEIh0qNFfMOuzGEhd/
	 ScazwtUryn4fWh7xbRjb6d3jiq84YbzxnsVcWxu2kJrPwDzivejrp+y1umHTBHf70n/rK
	 576Mx9/9MRE3XXy0KOOPZSoO6f8F8d7TQFY96NrafPmD6D0BkYe4wvdDGY7+LeIyp+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=peCWJaLY;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4A606A324
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A4A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=peCWJaLY
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so852419a91.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197199; x=1793801999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66KvjC7o9TYJVmk4sgr3wFJ9czeGpidCIDPzYdjOH+U=;
        b=peCWJaLYkOWLaEP6XA9dqQ39bpY31PQXgMA9w6j96UyOMBTw1LPEDgGfTcj4Y0CieM
         9IUt6G1CLYh755RA47HELiwSG4SVtmqf3taQBQVIy3JEiSDo+dQ+VykLg3sVy5MGt3f0
         SIVTnRm1avW0IuFhxWilD8khuW1A/Fu3+x7TEZ0SdCsA97iK/O+GXTC9GiztqB3qYpbc
         0J6vumpZX5jN/i6X3DBPRyPIoU1E2SM+bWo/2ODUNSOMoTpugjqxrnQo9Cw3Yc4oenXl
         oG6fK0v9sWEBGa02TnL4OmiJC8BarEN6ZgcKS2akv0RwCfL2ywYyF3eh70VumnHe+EXv
         VClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197199; x=1793801999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66KvjC7o9TYJVmk4sgr3wFJ9czeGpidCIDPzYdjOH+U=;
        b=TBuAzWpaJXmLQhol7lcdnGDAg73taDesMIkd32VI6ZqQEE21XO3pFl8vnNP/0QQNL7
         3Rlp//Yw8+yKBed6SNnNn7Q/MtlO+hIo4W3Y/vwKhWuT3r740mC65M5Xf95ELw1E/flp
         5CO65fWAGqGzIF6UyPCMFwBz3SBVqsS+rBSZHo8D07DfIRduCUH8m/kQwHIEfzsZdQxT
         62QkgKHNEADIUQNaN5hg0/sN3QMcjhpj3UpveKrYwFd64CHxvUWoIXFI/vnqMw+o10Zz
         kyQUwHpvNj49vJVQpzYTUFvH9zIaCewvAq3GL+YEEMfLSi5FosZHaBJ7lA3W90XnduHv
         Vm2A==
X-Forwarded-Encrypted: i=1; AKwUvBxI+M0aYJP+hysNlfdgvqT0sja4ovi98hnPMitxdGyeaBOsrrvCbw4VhtRuEfHG2eEbwiL2ILc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKD6EvTHaJ+S4z4vtvvSwjFOcl/MMOxumX+YnAuqRB7swvuJApO
	H1zibjFsVuBmuvax5NQlFk1sxAILKAi5nryTzDBN97JfkxerN8tKJTfi
X-Gm-Gg: AYBFou2Mr3BdiLgWWnrdeVUBS6IW5Rh1iFvGY978KVEzrWHKqb8pnZdAfQ1wcFXlcQ+
	XC1GQz3OyLptlgVVT8BfxDcC9Jkq3NtKMJ5Fiww3dlG1j4pNtF3X8si8z/I9C8J/TbXJA9UQPGk
	cB9/6ZR6CPWDz+6m2sU407+g2n3dHeMXhZZi1Yas0feDeIYaotR3XQ6XVGI+4fqFXcKceZUESt7
	594k7H9/mFBt7VGz8cNOnSOXtnqADE1ZaZGnyraGxYsV/y6D0iTFLurvBQWxYm/zWxGFygDmdSQ
	m4BKrm67XAMRqTRvO6zA39jgnF39IfbCo+D6+HZd5ZnkjJgDDZjIVzjf9R2PAK2yhyern96AK3+
	N3DZ+w+YP9wfexKTd6koqEPEK22DbHlGjnpb4OwUjexEu1i28xq4u3d/9hCx7jfeVPwQcoQpXDq
	2oaG1/ntsbFjffaDpjIEEZJCAe8aT1m5i/yxEm4qifv/Bl7sxVzp/qVFSBdFz+0eFdprRofE4Qu
	Icj/oK7jBxG3hi4nxv/LmfduyqMjM/awVmBLvyFkPVmS5OlY2t14TFfEeJ2NCT4rB/IG7mOjbs+
	MdnG1i8YdqEjr66dhxP4c4i14yFbU76StO97irOMJy1+xlz1TRyOxWnPPGtzqljIsD5e
X-Received: by 2002:a17:90b:1d44:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3ae57f638cbmr1762004a91.20.1793197198315;
        Wed, 28 Oct 2026 07:19:58 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9f286fsm3290141a91.15.2026.10.28.07.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:19:57 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Ville Nummela <ville.nummela@kempower.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Marek Vasut <marex@nabladev.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Stefan Hansson <newbyte@postmarketos.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] wifi: rsi: initialize background scan completion data
Date: Wed, 28 Oct 2026 22:19:25 +0800
Message-ID: <20261028141927.9306-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028141927.9306-1-enderaoelyther@gmail.com>
References: <20261028141927.9306-1-enderaoelyther@gmail.com>
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

Background scan completion can expose uninitialized timestamp and BSSID
fields to userspace, while cancellation is reported as a successful scan.

Both completion paths allocate cfg80211_scan_info on the stack but set
only aborted. mac80211 copies the other fields, and nl80211 can emit the
14 uninitialized bytes when the stack value interpreted as TSF is nonzero.

Zero-initialize the result and mark cancellation aborted.

LLM assistance was used to find the bug and review.

Fixes: 7fdcb8e12660 ("rsi: add support for hardware scan offload")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: W=1 module builds with MODPOST passed with CONFIG_RSI_COEX
enabled and disabled. Not reproduced; RS9113/RS9116 hardware was
unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 5 +++--
 drivers/net/wireless/rsi/rsi_91x_mgmt.c     | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 3faf2235728b..27bfdb6affaf 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -276,7 +276,9 @@ static void rsi_mac80211_cancel_hw_scan(struct ieee80211_hw *hw,
 {
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
-	struct cfg80211_scan_info info;
+	struct cfg80211_scan_info info = {
+		.aborted = true,
+	};
 
 	rsi_dbg(INFO_ZONE, "***** Hardware scan stop *****\n");
 	mutex_lock(&common->mutex);
@@ -284,7 +286,6 @@ static void rsi_mac80211_cancel_hw_scan(struct ieee80211_hw *hw,
 	if (common->bgscan_en) {
 		if (!rsi_send_bgscan_params(common, RSI_STOP_BGSCAN))
 			common->bgscan_en = false;
-		info.aborted = false;
 		ieee80211_scan_completed(adapter->hw, &info);
 		rsi_dbg(INFO_ZONE, "Back ground scan cancelled\n");
 	}
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index d9dcbb255317..9ceb6cba3546 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -2107,11 +2107,10 @@ static int rsi_handle_ta_confirm_type(struct rsi_common *common,
 	case BG_SCAN_PROBE_REQ:
 		rsi_dbg(INFO_ZONE, "BG scan complete event\n");
 		if (common->bgscan_en) {
-			struct cfg80211_scan_info info;
+			struct cfg80211_scan_info info = {};
 
 			if (!rsi_send_bgscan_params(common, RSI_STOP_BGSCAN))
 				common->bgscan_en = 0;
-			info.aborted = false;
 			ieee80211_scan_completed(adapter->hw, &info);
 		}
 		rsi_dbg(INFO_ZONE, "Background scan completed\n");
-- 
2.56.0

