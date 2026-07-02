Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C90431E68;
	Thu,  2 Jul 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987664; cv=none; b=iBSIaJBS6UsEUcT6fkRkalTXSep5YkMcukG9GhbxPgsWRz3+ockjdM3N5yEud0KWdxXo2H7fDLkZflp+B9OUh872cQ9DXrIHs5XB5Qb8uwsIDCtn8wxH+Cv239sDKq++jdkhq1lAg5uI52PwNHrybXnWX7zbDGbITwVTiN+zqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987664; c=relaxed/simple;
	bh=bzutjKBr6Z86v8mWSdu4o8FkYSFLpCB7bWGr+YlZWzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a2+rjakNTZSb8+jp8bbkLJsW6BxLjGTBoSqZ9fvSI5BlUvESE48FQFKhuC+LMj30mTXBViIRC7Xca0hc0KaLc/hDgRUZhXyUKRCfWckjqC1ukf+uAoTNdFGUJaP3fxQc+ahsfLeZdSTmjpeBIRvF09eR5yJUk1FCi00VFaZJw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=pJqRIF92; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="pJqRIF92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1782987651;
	bh=bzutjKBr6Z86v8mWSdu4o8FkYSFLpCB7bWGr+YlZWzA=;
	h=From:To:Cc:Subject:Date:From;
	b=pJqRIF92s0iEpinwSTJ7s+hKoHSWwC89vaSU8qnU8/UQR/hxl6urtFk+xf7EZt8d9
	 Hf0w9mzvj3oPQaJ8MorEgWNDohXyxw+3TTRrd8dvWnl4Hvq6LjN24pzAXu58Km+1Of
	 bi/dXFg8gqDxUo7VwjUVew+8C6CLkGn3X11BUeAHqgYwrdsnvGaUL9b9J5psTGgvNN
	 pfAVMp2LV6OyyV112bUFBiqv94RxcxPyuXyhxqXG1GKTbLerYoqqhIkpWKA8ukDHb0
	 ednFPZalkcmunVEkLRNgOEAECdZM++2URcRQOBWeuCqpunXqzLrb03/TMjikqP+Du3
	 wIKsyei5whYtg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id A24051F955;
	Thu,  2 Jul 2026 13:20:51 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  2 Jul 2026 13:20:49 +0300 (MSK)
Received: from rbta-msk-lt-169874.astralinux.ru (rbta-msk-lt-169874.astralinux.ru [10.198.56.59])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4grXw10s5Pzh5F;
	Thu, 02 Jul 2026 13:20:49 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Peter Chen <peter.chen@nxp.com>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	lvc-project@linuxtesting.org,
	stable <stable@kernel.org>,
	Yongchao Wu <yongchao.wu@autochips.com>
Subject: [PATCH 5.10] usb: cdns3: gadget: fix NULL pointer dereference in ep_queue
Date: Thu,  2 Jul 2026 13:20:17 +0300
Message-Id: <20260702102018.48182-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/07/02 08:31:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 111 0.3.111 1434338e80da3ad6056aa2b487308911a6b137ca, {date_rfc_vio_soft_silent}, {Tracking_ml_letters}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204205 [Jul 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/07/02 09:59:00 #28358554
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/07/02 08:31:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Yongchao Wu <yongchao.wu@autochips.com>

commit 7f6f127b9bc34bed35f56faf7ecb1561d6b39000 upstream.

When the gadget endpoint is disabled or not yet configured, the ep->desc
pointer can be NULL. This leads to a NULL pointer dereference when
__cdns3_gadget_ep_queue() is called, causing a kernel crash.

Add a check to return -ESHUTDOWN if ep->desc is NULL, which is the
standard return code for unconfigured endpoints.

This prevents potential crashes when ep_queue is called on endpoints
that are not ready.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260331000407.613298-1-yongchao.wu@autochips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-31755
 drivers/usb/cdns3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 61388e2089f5f..a64302acdfe6d 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2587,6 +2587,9 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	struct cdns3_request *priv_req;
 	int ret = 0;
 
+	if (!ep->desc)
+		return -ESHUTDOWN;
+
 	request->actual = 0;
 	request->status = -EINPROGRESS;
 	priv_req = to_cdns3_request(request);
-- 
2.47.3
