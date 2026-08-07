Received: from mx-relay50-hz3-if1.hornetsecurity.com (mx-relay50-hz3-if1.hornetsecurity.com [94.100.134.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2D2EEE9E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096087; cv=pass; b=SPZW3ImY7ge1O5WaU/eE1ojbQ/FBx0p7G3ONBMiJ0isS7YrziJwUZWhkvwIf09FcWc9KOYPkyGWxrP+XRFCt1Q/Aw4+CXqlas3dhh12uR/r4MEUzpRWcJpJNJ+0d6syiHMzmLUuaLF4amrTLHtqwaTRQCmxJ8ilfFseHxnM2K/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096087; c=relaxed/simple;
	bh=vAo8ynbmCgPLK6IHfXeGXdNTFJprZCvDd2VGQT+wO1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cb/tM2L9bvCXYTcm75DIqgP+qaLLTLaYrhFYnxaHHQ+OtOu5GArnS/OwQEAv4Kbc0FKy3g7IvgjnI9+HDY3LmdAewfdAmOgWspazbcX4OUK2z65/8cQ3GmyAWRYKibd0WVFvJEj++ysq0EfSVwSETZW+TJjeWbFXSYp0uTj0ru8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net; spf=pass smtp.mailfrom=marcant.net; dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b=YASFOPpy; dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b=DG9BISQ7; arc=pass smtp.client-ip=94.100.134.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcant.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b="YASFOPpy";
	dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b="DG9BISQ7"
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=217.14.160.69, headerfrom=marcant.net)
 smtp.mailfrom=marcant.net smtp.helo=rossini.marcant.net; dkim=pass
 header.d=marcant.net header.s=gandalf header.a=rsa-sha256; dmarc=pass
 header.from=marcant.net orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1786096050;
 b=MjpTBj1gOO+ixOsRQoNRGJHYSCR4pjGHFzOg+pKSFrZtxvHkkGwf9oRTAQNG6qBOr/r2at1T
 EkQ+j6FvfQrwgQekaTIMVs4R9W9MUojke3XU+7MMqGg50vAGG0tOagq0lk77Rz4zUw/GNzZYUJ3
 Zi1EMlk1xRC6CuxnNS8RG5lRHdvAPfFpV/vFzn1vfn5lORefL8MTQd9sSyafnmAoTHxKvgAnhXu
 X/ltdrxqpBbl44XA/FYxhejk8a6LlYN4DTLyzWnBt2NAYxeKkReuNOzDPgeSML//EXMlTZx/SEF
 43mgNBczqso85xyOUwH73W3JSkPsKJvyWtg1FKG95o9VQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1786096050;
 b=Xu8lxuZxfaJLx3/UMHYshTyZu3pOw7ZFffsK/LymJnqIB17MmuBN9EljOrYJP2Hnfx6KOhCC
 WQ1SSnJjJk5sG31BEfu/iZKWPzelS2mKhixg3D1+CpsSB6V98pQ6YfbF5j1xOljjtAHDT2CXgC1
 epfDqKbn0dJNeUKNnsvJOu+bbpT7wB29rewp/Ey5m1NR8u8XrcLbeVamN3lN+sg/cXe3v9RFiLx
 jfh5kDlFYM8hxAuw6/3ZNe4OxxdJao3zj5aYUvurE9Y9nA/P/dYbWHhYt24NYFJ+5SO/T//fGua
 xw3jaRbIuleKMXKwB4Lv23IgVQsaNZypZk39C1NDsnGEA==
Received: from rossini.marcant.net ([217.14.160.69]) by mx-gate50-hz3;
 Fri, 07 Aug 2026 11:47:30 +0200
Received: from futile.kalnet.hooya.de (unknown [192.168.203.16])
	by rossini.marcant.net (Postfix) with ESMTP id D8B02960146;
	Fri,  7 Aug 2026 11:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 rossini.marcant.net D8B02960146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcant.net;
	s=gandalf; t=1786096045;
	bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=;
	h=From:To:Cc:Subject:Date:From;
	b=YASFOPpyrSfHEtvgPk8VMIqNm5X3E+BZXfjYhHLNny1mrcjOOUZs+pb8QHpT+Lem1
	 DOd5ex4hXx0qObGv0sTjdM8BJZ7dTEtwl6umMB0qJxU7lfUUxUVnPshaYU45nG4ZA5
	 ZFWzA8ALeJqpks3d2ihQLATPNvS6Gu7Lr1Vz/IK0=
From: =?UTF-8?q?Andr=C3=A9=20Valentin?= <avalentin@marcant.net>
To: avalentin@marcant.net
Cc: stable@vger.kernel.org,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] wifi: ath11k: run ahb shutdown() teardown only on WCN6750
Date: Fri,  7 Aug 2026 11:47:23 +0200
Message-ID: <20260807094723.1546780-1-avalentin@marcant.net>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate50-hz3 with 4hGfSt15T6z2nGsf
X-cloud-security-connect: rossini.marcant.net[217.14.160.69], TLS=1, IP=217.14.160.69
X-cloud-security-Digest:4b0cb592f54d16cce5fa190591264bf2
X-cloud-security:scantime:1.192
DKIM-Signature: a=rsa-sha256;
 bh=RDpUyEwEJ0kzf8chyqH2Jx2Y1T40GKQkvwbA8Z0ps60=; c=relaxed/relaxed;
 d=marcant.net; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1786096049; v=1;
 b=DG9BISQ7eDDpNSKfZsbBf6WTckfCVQoXBHq4tJD39mlffWY3PLZLM8q7/N2y0ke/fVR1WvFt
 SpAA5x0l9pK4QiQnXIYmccuIHc8nbF70ZQJtXWGixxnfqj5JoNkrA3mYXDiMq7UoccaSQZFvFSN
 Ncv9EUO1s0hLpd822b5ydQ7Np+F8OeeW8iTcQtF/WmglM6v5Yn8AcTuSKi3NM4ljpZM2qlMiI+Y
 /zHwb1f3uFqgpKr6ChRl2dI5fRUfB8AmF+qcEEwj+nuv9xi9fa2d4gLQEsSXglTS0qCLEaCRsfC
 sWd6sUPH7QUzkF8UqYCCOrocnpCj3Ho+8Io+FyKb4FLoQ==

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

