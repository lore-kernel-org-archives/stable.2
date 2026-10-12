Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB254AA419;
	Mon, 12 Oct 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820116; cv=none; b=LEClA5R20UCr9348qyqaZORP8BPPFOWHO7L5SY8KtRFeMX/JqyxpUd/8EyJkmz/RS/VPAJ6J8xkqmuQlLkcYr3lTPxbwClAVgqf/+Q2Q3KkUDj7C0/tg4qFAiLNwZ8JCvEBQ9a1AbVw0NeTnxk7cwBGxHgpocnVkCvC9W75cbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820116; c=relaxed/simple;
	bh=cxVLDvQgMQwu4Os1vRGM44MZqtkcuWvleffo1cDkrE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdRKM0jbkbOCjKrQsbRyFp3GUTK3gEWCPyzwdWOT/P5nrnR6vKDacgeu6+11C06AMr8qMHow68EidX5xIQuQW99wGAy/3nA0wTJzfXpsrInE75tmDdIpdHZyDXQaqp7XFQ+9ssi4In3x93NkFv15AQcWA2b7tSi39IK5O7JBjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=nso6GGq8; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="nso6GGq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791820108;
	bh=cxVLDvQgMQwu4Os1vRGM44MZqtkcuWvleffo1cDkrE4=;
	h=From:To:Cc:Subject:Date:From;
	b=nso6GGq87KeuU1FB+v4JNhRwRYkfboYwmvbLrpMM/+SeZK0Up3LxnLWIErOhqgAuW
	 RsMRmwdY8vxWe04ttEc+gcSiJURhuqsWpsmvsVHeD+A4hEJEGQPRfSC6xu31v5ayKw
	 3VOo5iJgCrBwb4JW5jUq30/TmCgcJY9jka7tWI3xtPzzyemoMA1zZvaOLoxql+hZ+y
	 6kJ2FmC6PidBUYbbJcTqVxPyPAeF3yqBB93dXLfmcy4wUxxhPzaiNYIpGLSK8GgdH/
	 gj5FiHxy5xwhMeHpJq4y+CVA+chakK5SbyTreztEOCieZCxvc8RAz9ngbENnccrRyu
	 Yo+UDAsv6QBgA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 37A5924BB4;
	Mon, 12 Oct 2026 18:48:28 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 18:48:27 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.48.43])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j3MLz0Zw6z20X4;
	Mon, 12 Oct 2026 18:48:27 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans de Goede <hansg@kernel.org>,
	Fabio Aiuto <fabioaiuto83@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable <stable@kernel.org>
Subject: [PATCH 5.10] staging: rtl8723bs: fix OOB write in HT_caps_handler()
Date: Mon, 12 Oct 2026 18:47:10 +0300
Message-ID: <20261012154712.338-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/12 15:14:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;patch.msgid.link:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206608 [Oct 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/12 14:59:00 #28677641
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/12 15:14:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Alexandru Hossu <hossu.alexandru@gmail.com>

commit f8001e1a516ba3b495728c65b61f799cbfad6bd0 upstream.

HT_caps_handler() iterates pIE->length bytes and writes into
HT_caps.u.HT_cap[], which is a fixed 26-byte array (sizeof struct
HT_caps_element). Because pIE->length is a raw u8 from an over-the-air
802.11 AssocResponse frame and is never validated, a malicious AP can
set it up to 255, causing up to 229 bytes of out-of-bounds writes into
adjacent fields of struct mlme_ext_info.

Truncate the iteration count to the size of HT_caps.u.HT_cap using
umin() so that data from a longer-than-expected IE is silently ignored
rather than written out of bounds, preserving interoperability with APs
that pad the element. An early return on oversized IEs was considered
but rejected: it would bypass the pmlmeinfo->HT_caps_enable = 1
assignment that precedes the loop, silently disabling HT mode for APs
that append extra bytes to the HT Capabilities IE.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260522004531.1038924-5-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ mdmitrichenko: adapt to 5.10: struct ndis_80211_var_ie still has the
  CamelCase Length field here, so use pIE->Length instead of pIE->length. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-64440
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 4881adf930ab..62aafe7e885b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1029,7 +1029,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->Length); i++) {
+	for (i = 0; i < umin(pIE->Length,
+			     sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* 	Commented by Albert 2010/07/12 */
 			/* 	Got the endian issue here. */
-- 
2.43.0

