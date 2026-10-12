Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382D2DC76A;
	Mon, 12 Oct 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814051; cv=none; b=IN6+ggYJyVrYToViO/k4Lqf6tF4jlOYbf0UQMCfnrpoAX/vJJ1zO0xwgXxVZiT0/oZ9v32FpbPvhKtzk8caUleMozm8pyTJHpMXqsg15iLq11LAqu7QqkKCGjMpSD5EJ28F2Km2pptIdoTKJqQ4fo2l4Q6LZXRU6jTlO+t5yAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814051; c=relaxed/simple;
	bh=2aG/DogWSGTzP5ugFjBq1AH/kx5pc3t9kJDKFSOs67Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cb49OPMcfMnPXAk3oJgysvFDc5zhlWK66wcYaTIhXh3uo87VQd5fQA9Zczup6oU7oWvI6gd0jjf5VcnXH9NR4yFxzUc/dGceJIELgUWbGvmWiYqDXp/LrprOZ0brX0r4l3srqzv2LDtGjLJLGI3P23K1UP3R84thjMqFun9cK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=EH2BHVH/; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="EH2BHVH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791814037;
	bh=2aG/DogWSGTzP5ugFjBq1AH/kx5pc3t9kJDKFSOs67Y=;
	h=From:To:Cc:Subject:Date:From;
	b=EH2BHVH/SvqtD895MO6RcAoDY3odmFVRsMNOBgkxf82+fEFfSQa83DrhZVsNQ7bLy
	 aVXvLDD+7R8uLyI26PiZFnmdor6hSQfAnofQhgusVUSJGZPnAgi9kGFWzw9Myt2QEC
	 LNNetWkN3LuzrbDlSy+viYWJbOd8QHYucGesAoKzEP7kTnfyjeCN4xhdbbqrT7n6Ef
	 cGXR9/F05nTVajrxasPXK2LeIjoiPN+fWSwK9inVhXaznFzgsoPiR2UlMgRaPzJo9h
	 XLV+zwwmfoWZxPmtOYv2Iz1Oev06y+xuN8wssOme1Cj5b63zcbh0pHaEfY7Jym2X+k
	 re3sAKUBeqR6A==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id C97C3253AB;
	Mon, 12 Oct 2026 17:07:17 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 17:07:16 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.25.120])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j3K6C4ZB3z3KC;
	Mon, 12 Oct 2026 17:07:15 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Fabio Aiuto <fabioaiuto83@gmail.com>,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Navaneeth K <knavaneeth786@gmail.com>,
	Michael Straube <straube.linux@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>,
	Andrei Khomenkov <khomenkov@mailbox.org>,
	Dalvin-Ehinoma Noah Aiguobas <fliegbert2@gmail.com>,
	Michael Huang <tehsiu.huang@gmail.com>,
	Jinke Wu <coolbeaner@126.com>,
	Nikolay Kulikov <nikolayof23@gmail.com>,
	William Hansen-Baird <william.hansen.baird@gmail.com>,
	Serhat Kumral <serhatkumral1@gmail.com>,
	Nazar Kletskii <nazar.kletskii@gmail.com>,
	Jennifer Guo <guojy.bj@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	lvc-project@linuxtesting.org,
	stable <stable@kernel.org>
Subject: [PATCH 5.10] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
Date: Mon, 12 Oct 2026 17:06:40 +0300
Message-ID: <20261012140642.1076-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/12 13:16:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;patch.msgid.link:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206601 [Oct 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/12 12:26:00 #28677215
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/12 13:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Alexandru Hossu <hossu.alexandru@gmail.com>

commit f9654207e92283e0acac5d64fe5f8835383b5a23 upstream.

The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) each
iteration but only guards on i < pkt_len. When a malicious AP sends an
AssocResponse whose last IE has only one byte remaining in the frame
(the element_id byte lands at pkt_len-1), the loop reads pIE->length
from pframe[pkt_len], which is one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond pkt_len, silently passing a
truncated IE to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past pkt_len.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260522004531.1038924-6-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ mdmitrichenko: adapt to 5.10: struct ndis_80211_var_ie still has the
  CamelCase Length field and a one-element data[1] array here, so
  sizeof(*pIE) is 3 rather than the 2-byte IE header. Use the explicit
  header size 2, as the existing i += (pIE->Length + 2) does, so that a
  valid IE ending exactly at pkt_len is not dropped. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-64444
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 46ce8ca12c02..527121dbd1e7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1682,7 +1682,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + 2 > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + 2 + pIE->Length > pkt_len)
+			break;
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:
-- 
2.47.3
