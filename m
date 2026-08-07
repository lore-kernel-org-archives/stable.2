Received: from mx-relay48-hz3-if1.hornetsecurity.com (mx-relay48-hz3-if1.hornetsecurity.com [94.100.134.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A4345751
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096029; cv=pass; b=p4Q/qxfQp8AuCWuXAr8zGHKkv67l3eAh/Wcq80DSa7W/xZsCuO/jBNWwDKUmEpjxSddG/HCqHkDZvBlP9DPoOAmZxtEbc/w1cNtPEv4VWHiZQQqekdV2JrrAM6JLTWqxtOx4axUzl15lAyOV7jFPwvbcE90BD841J/9N7xJuqro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096029; c=relaxed/simple;
	bh=vAo8ynbmCgPLK6IHfXeGXdNTFJprZCvDd2VGQT+wO1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tO9M9bknXsQkgdiJXcLjUivH21lxdsD/WbutzLtSBlbpwSDXV9x3TWkYI98cpz/aQb2u5PfIDfRwOO6sLpiwGW040tn4SpnCP/3wxE/z5u+7PCdQQshnoHppoMfKBAnnhL7McOG9c9jzniZphbfEzpyLCyZABnj/8r1EI5WwlRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net; spf=pass smtp.mailfrom=marcant.net; dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b=pBsb4CLI; dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b=qmnxkKZU; arc=pass smtp.client-ip=94.100.134.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcant.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b="pBsb4CLI";
	dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b="qmnxkKZU"
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=217.14.160.69, headerfrom=marcant.net)
 smtp.mailfrom=marcant.net smtp.helo=rossini.marcant.net; dkim=pass
 header.d=marcant.net header.s=gandalf header.a=rsa-sha256; dmarc=pass
 header.from=marcant.net orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1786095964;
 b=srZbdcni5mi4Wr3Fah0HaN+OtuzjMsxV4aqsud90kz+DzczDgU2fnbJv7uLe8pyMIkYkRmUV
 DSe371KcPFRwcsJ21o5s6vxY3nAiZl3/u5fTT9HtrAcOKZJatSOrz5gJ9KbJI60UChZ5lW1PId9
 FYB2omDciuUmC1ELPqrOPnuyDOM/c6+gfxHR6Ffb/OFtL1vRVVMVXaB3hYeBHI00DVi3aCj6Cr+
 jx/Mc+5u2PapNxylCI40bTuq35UXJnNCz8MhyyH3CDM6GGIOsvWGLYXXeDVXkuk8utXO031Jia8
 b9SGcPUJriKe1iisB9ypS6FOWbHdcVORQht/rCKnsfvJw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1786095964;
 b=FhEucjzqXGaqtv/jvaf9Jg3+lWnHLWr9EZeXKfcUNDOsm8EdzsLUfVuolVt91/fXvi4EdbQJ
 VYHytgi9rLqL6AUz9CcYFjDSPLjGOtS8JemOo1TjM9zxpGoURVqeCQLxdPgzGv+R43a7v9MGCMb
 Zbzg1siRjwqOC4wkwClAjpOqe50s7wVThuwuh9V57I+I+LVB5m93LYqBUQnjRlufD2yF2w8s49f
 vl9/PfBeuSdY1ZdTuJL7QCQlX5xKzSWa+msF7V+VkGLQ2gFdlqKrjegcmQxiBdm/ASlx/HoTPii
 IPoFffxYIkKtD1bqPSeb7Jfxa1oIX/HcnD+NraaEQm/Pg==
Received: from rossini.marcant.net ([217.14.160.69]) by mx-gate48-hz3;
 Fri, 07 Aug 2026 11:46:04 +0200
Received: from futile.kalnet.hooya.de (unknown [192.168.203.16])
	by rossini.marcant.net (Postfix) with ESMTP id 5B1E29600EE;
	Fri,  7 Aug 2026 11:45:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 rossini.marcant.net 5B1E29600EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcant.net;
	s=gandalf; t=1786095959;
	bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=;
	h=From:To:Cc:Subject:Date:From;
	b=pBsb4CLIBYV/mBJI0/ZJOMSmHfaoLAUUsi0epbr/kdAQK5KFZJBMduyYipmoqwvOe
	 khjx7fWfaaqdSSrYTbu+eGc38BUUbM4g4xPFHE4r7Pd7WQT2BjPYv8Yl0oIGE1hne+
	 EhcZYlWAuzlbCO7oqR/NSXqDCzr3RUeclFgQgtjA=
From: =?UTF-8?q?Andr=C3=A9=20Valentin?= <avalentin@marcant.net>
To: a.valentin@ddimension.net
Cc: =?UTF-8?q?Andr=C3=A9=20Valentin?= <avalentin@marcant.net>,
	stable@vger.kernel.org,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] wifi: ath11k: run ahb shutdown() teardown only on WCN6750
Date: Fri,  7 Aug 2026 11:45:57 +0200
Message-ID: <20260807094557.1545463-1-avalentin@marcant.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:avalentin@marcant.net
X-cloud-security-recipient:stable@vger.kernel.org
X-cloud-security-Mailarchiv: E-Mail archived for: avalentin@marcant.net
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate48-hz3 with 4hGfRC4mBMz1kNYvR
X-cloud-security-connect: rossini.marcant.net[217.14.160.69], TLS=1, IP=217.14.160.69
X-cloud-security-Digest:4b0cb592f54d16cce5fa190591264bf2
X-cloud-security:scantime:1.255
DKIM-Signature: a=rsa-sha256;
 bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=; c=relaxed/relaxed;
 d=marcant.net; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1786095964; v=1;
 b=qmnxkKZUCwEEZhp+YvBYPcnCJg8CHXIw1J0i1dwhZGFI1nqkkQeNfyAf2AcYOf60YHLK5TZ7
 hp8vcWJ1ZxAO/7V6QBSv7ahUxyovRrbhsZjcu1zUTsMjdJzAt3A0pbhufaaaPcCWrrVdt4t+UKL
 o014N3orAFsdZL6DXGgqmOSJHmxm03/BuLeCJokZl2gHLFos2x9p2P2p1P0Yv9+KND9L4KMA3/6
 y+GqSASjAMwM4s2SE6uMgFzUmSe2Z5m9qpgAvmUlPWpoqdnw40opY6lJACe0jtQNgLvatKibvhj
 VZG+og77E2q8b8QMlmQ3UIoLk3DNxeOAROg12zc0s28Pg==

The AHB shutdown() callback was introduced solely for WCN6750, which has
to stop DMA before the SMMU is torn down at system reboot/shutdown. It
was registered unconditionally in the shared ath11k_ahb_driver, so it also
runs on the IPQ AHB targets (IPQ8074/IPQ6018/IPQ5018), which never had a
shutdown() handler before and have no such SMMU requirement.

On IPQ6018 the shutdown teardown stops the WCSS Q6 remote processor
firmware. Stopping the Q6 firmware leaves shared WCSS state such that the
boot ROM (SBL1) hangs during DDR training on the following warm reset;
only a cold (power-on) reset recovers. A plain reboot therefore never
comes back and needs a physical power cycle.

This was pinned by bisecting the teardown at reboot: skipping
ath11k_qmi_firmware_stop() (i.e. not stopping the Q6) is what lets the
warm reset train DDR and boot normally, whereas none of the q6v5 power,
reset or clock steps reproduce it on their own.

Restrict the shutdown() teardown to WCN6750, restoring the pre-regression
behaviour for the IPQ AHB targets. On reboot/shutdown the whole SoC is
reset by the boot chain, which re-initializes the WCSS from scratch, so no
teardown is needed there. Module removal (rmmod / remove()) is unchanged.

Verified on a MikroTik Chateau 5G R17 ax (IPQ6018): before, a plain reboot
froze in SBL1 at "sbl1_ddr_set_params"; after, SBL1 reaches "SBL1, End",
trains DDR and boots the kernel across repeated reboots.

Fixes: ac41c2b642b1 ("wifi: ath11k: Register shutdown handler for WCN6750")
Cc: stable@vger.kernel.org
Cc: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Signed-off-by: André Valentin <avalentin@marcant.net>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 1e1dea4..749d8bf 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1288,6 +1288,18 @@ static void ath11k_ahb_shutdown(struct platform_device *pdev)
 	 * remove() is invoked during rmmod & shutdown() during
 	 * system reboot/shutdown.
 	 */
+
+	/* The shutdown() callback was added for WCN6750, which has to stop DMA
+	 * before the SMMU is torn down. The other AHB targets (IPQ8074/IPQ6018/
+	 * IPQ5018) have no such requirement, and running the teardown here stops
+	 * the WCSS Q6 firmware, which leaves shared state that hangs the boot ROM
+	 * (SBL1) during DDR training on the following warm reset -- only a cold
+	 * (power-on) reset recovers. Skip it on those targets; the SoC reset
+	 * re-initializes the WCSS from scratch.
+	 */
+	if (ab->hw_rev != ATH11K_HW_WCN6750_HW10)
+		return;
+
 	ath11k_ahb_remove_prepare(ab);
 
 	if (!(test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)))

base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
-- 
2.47.3

