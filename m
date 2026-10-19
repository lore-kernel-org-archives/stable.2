Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A34F4039;
	Mon, 19 Oct 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417189; cv=none; b=uJv+O+evIPaKddhuiji5Lq9od91G4glCehMlC49kBEJOUKFMD8HqZFkQ/xOp1Xqukmhs7L4f4PvU7Ka5cOI7F5cWS0g2MGHHnY8af0NPqIT9g1cbJs44k0QHTWrSPx4E/rSlCpKIQwnTJkPjn8zJrOLgTpmEeBo/6rIG1AtRAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417189; c=relaxed/simple;
	bh=rfPbKhCA+A6vIjorseDK6y7DZlhxJ9AuGFP0jPmcowI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2r4uo/CPNKX3QX2s/M98Bu8wCQ9SSxnBD5p1jS/hjrhaLgrueUKpSJu89SMoJp6lUxA0orFr1YzyjdmpIURhpn4Txp94KGh2a0kX5OjKRrAc3lAAHD+E/M3Uaf8EzdKzwiI4lczOGU+RN3WS8RZTzP3F+OozmEofrK4Ihk1UQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=wUxq30uE; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="wUxq30uE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792417181;
	bh=rfPbKhCA+A6vIjorseDK6y7DZlhxJ9AuGFP0jPmcowI=;
	h=From:To:Cc:Subject:Date:From;
	b=wUxq30uEEq+6qBHxxCpiLpx3FStes43U0QMsamzMCIbi/kBQP4xebe9S+3nB4MDKs
	 jPZ0Uxo5UmIgmJ0rQenUh8dWeIYQAJ9hO45ipZYqrfk3aBb7wmMA18dVmhb1D0XS3Q
	 s/Jc9uocR2m+cM91mj6fGXLkvK2f4WNJosId0RgXROb3aOSRvCM0lwB3SNirKhB53v
	 UJuyXLB4Jz4pYT+Lbo8nXGv1epz+GxbUZkdhwkkCsUbwHZIkIFmbTwzgP6pWFuzEvd
	 MgLZO4AD6+Yp43xn5X9skQn3Cvp3actzMrVV3ZxQTgBQMD558+XI1pyhUjOQbxDZ2p
	 2i/JjACnymXFw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 1A09F25871;
	Mon, 19 Oct 2026 16:39:41 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 19 Oct 2026 16:39:40 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.51.9])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j7c971tNmzqSH;
	Mon, 19 Oct 2026 16:39:39 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Dalvin-Ehinoma Noah Aiguobas <fliegbert2@gmail.com>,
	Andrei Khomenkov <khomenkov@mailbox.org>,
	Michael Huang <tehsiu.huang@gmail.com>,
	Jinke Wu <coolbeaner@126.com>,
	Nikolay Kulikov <nikolayof23@gmail.com>,
	William Hansen-Baird <william.hansen.baird@gmail.com>,
	Serhat Kumral <serhatkumral1@gmail.com>,
	Nazar Kletskii <nazar.kletskii@gmail.com>,
	Jennifer Guo <guojy.bj@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable <stable@kernel.org>
Subject: [PATCH 5.10] staging: rtl8723bs: fix missing shared-key auth challenge length check
Date: Mon, 19 Oct 2026 16:35:34 +0300
Message-ID: <20261019133535.1940-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/19 12:18:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206796 [Oct 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/19 08:59:00 #28702808
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/19 12:18:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>

commit 2c56ef658ac8c6bca36bc5574715e8f717207c6c upstream.

The WEP shared-key authentication handler uses the challenge-text
element's attacker-controlled length without checking it against the
fixed 128-byte chg_txt buffer.

In OnAuthClient() the length from rtw_get_ie() - up to 255 - is used
to perform memcpy() into the 128-byte pmlmeinfo->chg_txt, so a
malicious AP sending a malformed WLAN_EID_CHALLENGE element can
overflow/underfill chg_txt by up to 127 bytes. It is reachable over the
air, before association, during shared-key authentication. In the case
of an overflow, the driver can write out of bounds. In the case of an
underfill, the driver can echo stale buffer memory.

The challenge text is defined to be exactly 128 octets, which is
already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
element to be exactly that length before use.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Link: https://patch.msgid.link/20260720082409.168379-1-npetrakopoulos2003@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ mdmitrichenko: in 5.10 the challenge element is still looked up as
  _CHLGETXT_IE_ and the NULL check is the braced "p == NULL" form, so
  the length check is added to that condition. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-74649
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 46ce8ca12c02..eb1dab9c735c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1116,7 +1116,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (p == NULL) {
+			if (p == NULL || len != WLAN_AUTH_CHALLENGE_LEN) {
 				/* DBG_871X("marc: no challenge text?\n"); */
 				goto authclnt_fail;
 			}
-- 
2.43.0

