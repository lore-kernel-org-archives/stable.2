Received: from mx-relay21-hz2-if1.hornetsecurity.com (mx-relay21-hz2-if1.hornetsecurity.com [94.100.137.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FABD3D092E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.137.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096207; cv=pass; b=SVer1cgSb0UxtpKZ+6A8Cn9/GAwoyhJ9pgykOshxxSrzTm9B85PONRgDVaFyv2WFz9M97zOBrgb5ETbi61Awq1KJaZxf2YWQm/MCUc91WBtdmiY79VoruhT0YwA99YARBfogwSZzIgIgrboeHsNVY99ruOFe7xF3lPlSFA1Oi6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096207; c=relaxed/simple;
	bh=vAo8ynbmCgPLK6IHfXeGXdNTFJprZCvDd2VGQT+wO1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCOhZGgV3JpukgtElEBkzddsStGohdMyVVKI8cLCsaKGZruA6VeFh6bYaXRus3byGUw5PuuQje9pMH3Rlz2A/AR1/L/SaNJW1oyrBkkFDTicfCoTg3A9W8EzGyRfhFu5BSMFUfp/zX/zIb5dJmaRvP8Yk0bmZfr0HI6+qXXUllc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net; spf=pass smtp.mailfrom=marcant.net; dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b=AC0bk6mn; dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b=Zb3J4Kg/; arc=pass smtp.client-ip=94.100.137.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcant.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b="AC0bk6mn";
	dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b="Zb3J4Kg/"
ARC-Authentication-Results: i=1; mx-gate21-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=217.14.160.69, headerfrom=marcant.net)
 smtp.mailfrom=marcant.net smtp.helo=rossini.marcant.net; dkim=pass
 header.d=marcant.net header.s=gandalf header.a=rsa-sha256; dmarc=pass
 header.from=marcant.net orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1786096151;
 b=SET79kiB7e6KudujYqpT5ECHOGL1bXjBQYtk395U+GKCrsRS+fVbbLxpo3wrDNzL28D88ft5
 4F7HoQsPr9bdcRi4dK0GDBMObistE0P58h9LIH9+GPztu1vBJ44R3J6hiXeDba0yg/5eT6xid+v
 Q1AGhvzz9XuTc5qBE+K7SPQVKDbX9jxRawqqCHKXYA+hWGOjJWBjdquvZwMvTrE0SkDVzJ/x6Tu
 b9aiTIrVMU5mQiYotvIyFIQNsBMTQdZTebbgV2YowmSxkxOexCHLS/vlg7zFPnbyYnhM7QmNai6
 T6cKyHTcJI/kQ43R1+NJWSKe0bdiKGrZVxeUf0Ni7EiLA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1786096151;
 b=nKga3UabmZC+KjLp99U7DOqAyevpkEh5IGsSJpfLCS7obBRULq/onO2SPQIhWpXW7buPxgPE
 6upLKLVg74rKR7Tmk0+DUdI7OWfCsnOXyNd15z4juWC4z4h5ZlTxMyWM4NZj+Y/sjvFDMIlHDOH
 /sCnfKA6be7vChMU7JvkevQPJAuOw+HQuIGglUC69r7xtozHJvNdGy5t2D2uL635sx9JwsqR66o
 80gr1RvX82roFf6eniQCm1RcYl+8dj9cBbVTjV+xoKjgtJNQAvq1I1c5oo+hGWVEk6RGFZzO3Dm
 geCVcszq8s6DEiYE3W2Sxk8y08KlOk/C/uBfD59BX3b1w==
Received: from rossini.marcant.net ([217.14.160.69]) by mx-gate21-hz2;
 Fri, 07 Aug 2026 11:49:11 +0200
Received: from futile.kalnet.hooya.de (unknown [192.168.203.16])
	by rossini.marcant.net (Postfix) with ESMTP id 7A6E5960146;
	Fri,  7 Aug 2026 11:49:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 rossini.marcant.net 7A6E5960146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcant.net;
	s=gandalf; t=1786096142;
	bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=;
	h=From:To:Cc:Subject:Date:From;
	b=AC0bk6mnUCQ51txc2loIvXwTZrP8IjdtgCgMflA+o9+RP+0/uQnlJHBMHfpr4xuIx
	 QdFRymlKVMJ3Zd7OzmZah3W2O/03DA9kGY9/fdwoZGCsFJpGsbqdxj3kXUOCHe3PnH
	 XbQdPMP1V6ISHDNEs3ceDdXStQRUjgDVA7wfl9tc=
From: =?UTF-8?q?Andr=C3=A9=20Valentin?= <avalentin@marcant.net>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: avalentin@marcant.net,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	stable@vger.kernel.org,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] wifi: ath11k: run ahb shutdown() teardown only on WCN6750
Date: Fri,  7 Aug 2026 11:48:58 +0200
Message-ID: <20260807094858.1548216-1-avalentin@marcant.net>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate21-hz2 with 4hGfVk6d1nz17HPR
X-cloud-security-connect: rossini.marcant.net[217.14.160.69], TLS=1, IP=217.14.160.69
X-cloud-security-Digest:4b0cb592f54d16cce5fa190591264bf2
X-cloud-security:scantime:1.148
DKIM-Signature: a=rsa-sha256;
 bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=; c=relaxed/relaxed;
 d=marcant.net; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1786096150; v=1;
 b=Zb3J4Kg//Qnp9lYBlrnKMlyygCEQsqYQ6GILgQFfiq4w21HSaO6Hqr/Vva1U2vTJNqFrztBX
 rrZ0n6g03Ww04pmyDgCjpmYoDdD6fWB/Ybsx3grLbdgLGrWUggu0bEtLzRTw/Dn4bF8whJxB7ay
 /CL7ohBoqrNKw2/PJKVYPhgVTt5jBBNjmLkZH+UUbEG0bgZiRn4B6OYGzTKrPbHeUDdgykt8GPx
 GI1h0V8ivt8WvhDbt8bEO6NXOYuDURQMJ9in4dmQ8fTK6VzrQ358MWHWguHGX5xSp2AmfPf38Nv
 X3g3j8EGhWcU+6B/wOLTWkB2owfcmNdPJdF892chfZX1w==

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

