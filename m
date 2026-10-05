Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC103483BC8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206341; cv=none; b=PvYyqBuFhb05MqZgG8nPU7+Dtu/AC2tvd/TopnUla7rBPN8lOIai0taEUqvKql1G5CtDVrP4fuKab42qT1lAUM5KRwoy/g1YNBSNlWQ5MyrUuOUMtNFKOAq/xhj3V6zGTdINbcxajBRV2TsQlMpganm8FoE/TXOGdTe9EOgg5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206341; c=relaxed/simple;
	bh=qZjfduiUprocdydha0hejaLoDvEbkOkdyKLoNigaXvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KAN+O+J/P0+458V4PyUVyyLQbexT+htt2uNcleH4ifnQ5lfciQNUU0AElzR9r1hmNuzUdKdydyJCW0xLEXpFmnFUWI4Bj0P4lDIJngulmfQ3HH7Bj3KtBNcPaa4ogCBRJMPAMDpBvrwVd6tdjHi/xjxG3QgkpPl+dTvhM1Rs1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HpaMC67u; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HpaMC67u"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C59841A116B;
	Mon,  5 Oct 2026 13:18:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 956C46074B;
	Mon,  5 Oct 2026 13:18:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEEC210330777;
	Mon,  5 Oct 2026 15:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791206330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GvA9NXfhAxVnbg0A5UX36SLSJTAc1ELPqM4eyxSMlzE=;
	b=HpaMC67u9P+yf0PYKmcrCBP8Yc8Ux3RhXo8FE0+CFJAVg65zovOd3rIcabZrWSTdhEzAey
	25s0Ke+e15o3jilJ5t+yX9GdcNwdSRxXxIEQfomdDsEF+ra3vG2vIxhHh6X4Q+aelRQBZO
	vbXPQ49NPZ6RcoDj3HWRICP63uIGU5tXl3OvXGdsnA0pIk/jBMDYIK1NzSvIU9ecHEt5Fe
	0c1E5tqCxxl/xtTeb39nXo9svhKKrdDOgti/uKB3u5unzo4CQ+jGz8VR1LwDV2kltMXGR4
	efBc4S5cZLay9ikBhygu0nuIESlsL2O1pCtwm8AZQsQLZnPmfa//yLevDdM6qA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 05 Oct 2026 15:18:43 +0200
Subject: [PATCH 5.10.y] page_pool: always add GFP_NOWARN for ATOMIC
 allocations
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-cve-2025-68321-v1-1-f45fb28e7127@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3bJbqEN+irGg5ZF1wOYVomG8
 O5WPH6TzL8gazLNOFQLks6WbRoLZFch3s7jVcn6Yjh2QZg9xVmpwFPoGie0F2laFwfhNqCcHkk
 He2/BI3wtXH9w+u/5dblrfP5qWNcvxxSmAHoAAAA=
X-Change-ID: 20261005-cve-2025-68321-911342cf1046
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206328; l=1563;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=uDfnMFoP0oUtH4sdGjN+fzI5iGV5WmY78WV3yGVOt6U=;
 b=l/hzMAXjFHpreKGRyDCwpoxIzgV7b2BdoYCDlmRRmhWKfJ4j5AEWQS+DN7fhnXnIXm0GleC/t
 oK0Xrnoy16vDn8BSdYt9Di3W+JFOlzMp4rG5yQs/zy0ejYFI0TjGHLO
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit f3b52167a0cb23b27414452fbc1278da2ee884fc ]

Driver authors often forget to add GFP_NOWARN for page allocation
from the datapath. This is annoying to users as OOMs are a fact
of life, and we pretty much expect network Rx to hit page allocation
failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
by default.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250912161703.361272-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/core/page_pool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 09d98fcf669f..1e3422c486c6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -185,6 +185,12 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 	gfp_t gfp = _gfp;
 	dma_addr_t dma;
 
+	/* Unconditionally set NOWARN if allocating from NAPI.
+	 * Drivers forget to set it, and OOM reports on packet Rx are useless.
+	 */
+	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
+		gfp |= __GFP_NOWARN;
+
 	/* We could always set __GFP_COMP, and avoid this branch, as
 	 * prep_new_page() can handle order-0 with __GFP_COMP.
 	 */

---
base-commit: 587461ddf5d522bfcb50ebd55078c0dac37be496
change-id: 20261005-cve-2025-68321-911342cf1046

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

