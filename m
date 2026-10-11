Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A133B0582;
	Sun, 11 Oct 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722005; cv=none; b=CFCjBLF7Z+JXDw6IUEj6yJbE6dv4KV8nld5GTZt5ZM6Y75GK0WCaR2ydH4mBMeKIxtBsk+c8zyavv+5WOaoWCBzaNsQNlFKwhJH5D3r3v1w5oBEnQBdjrz2UIsBqDHKEln08/gzSSK7SYHgPxY4vaSrdW0z+hP1QBaWK1/NQxD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722005; c=relaxed/simple;
	bh=uPaAOHfI9gs8UxSYhxRJzVYpGKocptKAXqDiTRjfXGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u6qAOxRPbh2Ra7MHc+q7Xz0mLD8k7/hXjo+upJ/1/aNehJonjGW50Mv2WlAFJ9JoFLePKBfcaxGaC2JfvSVXinL781+0U2vOTbtmnoc0XSsGM4/2UijCBBHhaVooptdmXj83Ah4GaXMQl/ajolfroJcqGgbB3KD0jzRtzTMuTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJyWxWw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJyWxWw3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6139CC2BCF5;
	Sun, 11 Oct 2026 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791722004;
	bh=uPaAOHfI9gs8UxSYhxRJzVYpGKocptKAXqDiTRjfXGc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QJyWxWw33c4FEmenX4p1tWxZAbo4fneMU8Y+5uv21JlSpQWAwP9TUwLnTUnABn1aa
	 M6JeujPVMQY/1Zd7EL+DQ8j2ePgp3k5FD/Nszyb5KMX/yLguX9exDDta+AJtgw1BpF
	 vZ5hy/t7ZJrZmvOIN7KEZmB7kJ1J7qSmCa00wWXvVtnACzPl3cdy0jJqBJLTYRn1Nr
	 2mKPC3/In0aQahFPNm+ZxWKgbcwwZlMW8m9jvjqz94LwHO4lNRe33bMay1r8Kj7YpS
	 fYRWpXEA5wKi56vM/0R/La7ky2+EgVyHnb7L/6SEzTxiUoVYHTZZqNc/+8VqFCRpLf
	 ELWK5kmm+D0GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D1CA9EC7;
	Sun, 11 Oct 2026 12:33:24 +0000 (UTC)
From: Franck BAUR via B4 Relay <devnull+franck.baur.67.gmail.com@kernel.org>
Date: Sun, 11 Oct 2026 14:33:21 +0200
Subject: [PATCH net] net: jme: keep RX MAC clock enabled for WoL
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-jme-wol-submit-v1-1-9cc033e259e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIABCCy2oC/x3MTQ5AMBBA4avIrE2iBKmriAU1GNFWWn+J9O4ay
 2/x3gueHJOHJnnB0cWerYkQaQJq6c1MyGM05FleiUwIXDXhbTf056D5QDlOsldKlUVVQ4x2RxM
 //7AFQwd0IXyO2YvEZQAAAA==
X-Change-ID: 20261011-jme-wol-submit-9df9accc5367
To: Guo-Fu Tseng <cooldavid@cooldavid.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Franck BAUR <franck.baur.67@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791722003; l=1689;
 i=franck.baur.67@gmail.com; s=20261011; h=from:subject:message-id;
 bh=SeoQOmO2eEg732RNb6ToQJ2L/+DWTL9snNuAeoOV8m4=;
 b=pUZUqe8RJr9IE7ULUKkLVKCCfLZTMEaEsk0YYDHmCA8Fzm9XmN5OcL/qYwDdNWm8jaxFAyDbS
 yR8OCoroeaOCDBNQIvLd/wV2NpEZgojCkgOcr5qfAvAJI+VfGf1nOAc
X-Developer-Key: i=franck.baur.67@gmail.com; a=ed25519;
 pk=4AAmINL6MxJGFmb3HM2Vp734BIHvnGs3+aOTK/FcJ0Y=
X-Endpoint-Received: by B4 Relay for franck.baur.67@gmail.com/20261011 with
 auth_id=1158
X-Original-From: Franck BAUR <franck.baur.67@gmail.com>
Reply-To: franck.baur.67@gmail.com

From: Franck BAUR <franck.baur.67@gmail.com>

The suspend path disables the RX engine and resets the MAC before
jme_powersave_phy() programs PMCS for wake-on-LAN. The MAC reset leaves
GPREG1_RXCLKOFF set, so the RX MAC clock remains gated when WoL is
armed.

On a JMicron JMC250 [197b:0250] revision 03, PMCS_MFEN is programmed
correctly but Magic Packet detection does not work while the RX MAC
clock is gated. Instrumenting JME_PMCS showed that MFDET remained clear
after receiving Magic Packets.

Re-enabling the RX MAC clock immediately before enabling WoL makes
MFDET assert and restores wake from ACPI S3. An A/B test without a
Magic Packet remained suspended until the RTC wake alarm. The wakeup
was reproduced repeatedly with the patched driver.

Keep the RX MAC clock running while WoL is armed.

Fixes: 854a2e7c331a ("jme: Safer MAC processor reset sequence")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Franck BAUR <franck.baur.67@gmail.com>
---
 drivers/net/ethernet/jme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 25ec5f757c6828a5f5241340bf3fb01d8e0aa3e9..27ac7405f76fed169d9f1fa84d9875611dcf119c 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1892,6 +1892,7 @@ jme_powersave_phy(struct jme_adapter *jme)
 		jme_set_100m_half(jme);
 		if (jme->reg_pmcs & (PMCS_LFEN | PMCS_LREN))
 			jme_wait_link(jme);
+		jme_mac_rxclk_on(jme);
 		jme_clear_pm_enable_wol(jme);
 	} else {
 		jme_phy_off(jme);

---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20261011-jme-wol-submit-9df9accc5367

Best regards,
-- 
Franck BAUR <franck.baur.67@gmail.com>


