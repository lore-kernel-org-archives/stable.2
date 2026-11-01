Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515048;
	b=Ysf8lhEIivj+g5YcIQ3NncaFHWDiMqIopEdiAmvUwiIDHFHWYADDkzlppnJqeAWKaMil
	 C1fjoJT8deuRiMEXRiZpxQjoYkNE76RolIBQHpqcdRfsWpv0qa+ycVCI86FAH63T8yURX
	 VKiL8iqWALVzLgK8f6AzGX/5gU3Mwov44Y8O/4eDGdaQz7gBW2eb3nzchE5xlDbgimIAn
	 hj2sOqtOlgkBGoNKMY9VpHlCubRMmqh0WNiVKS6UHoZcpViz7soQeE3jFo6raNgHqcFV1
	 o5zaC1SPy+8ElT58lxLTTLU7ZJf6X8aL4VnKdt1S3gYNVYU/EqbDq8B8KhQoIKp7Kig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kaRMUeDRl+naPmm3qUT+oBT7oJDOZeWGKzT1v2c6cow=;
	b=fNznEa31yJg6ByrhKTWugBvVmwcAtG5rsZ4++A4SdWGfnnpH3SZLHqckYUonouBCKDkB
	 RzXUP4FTkx0KI/8VcpE0x74RydSvJl7o2hrGlQl2AVeEy9oXVROoLv1j/W/yBtKjXFzrR
	 ZrjTpslh6afVBQ5HyrwkH7SWGfKg9r1NOTJIT89mjvausfCW5NHsWF3yjw1OsahUTbGMS
	 fRSDtjMqCynMqjShDKMkyIKOo9U6C779b9sVKCN4CEGKeDVFIQGyXIjmhhiRwSq73d4Uj
	 vOWKeriOIrCGejUFCN41P7neX5IuuG7W17i4Af7XRGHTHBC+xawZT9j9DTd3ygUF5Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VlN2uOp;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32185606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32185606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VlN2uOp
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso814238a91.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515047; x=1794119847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kaRMUeDRl+naPmm3qUT+oBT7oJDOZeWGKzT1v2c6cow=;
        b=0VlN2uOpa2rBfHqz+P34UFeI4XmM/oV6fVJXakdvt5wrQMb1FoS5ag3HPzYt85TOH1
         xa6XLyiYexXf+CY0aD+FHXC0HjFxalWv0GNXi8z8taU/5lMat5legdx73GyDwsIa+Wwo
         FG00l+6/zUs0jtBM+nZTM5E9sXDhFmSCCyiIGoMmXxp5ge5Y3T5NAVBs54cjUpiuGSLN
         /W24FxFL7gLyTt5rkjN7e69qdPGzGQe9eTSDW7V3p0qGRYB3Urd3L/wtCdMm51jB8UNO
         w3mruK/a7WrXjU6mIzmjM0EO1DnVVHiyI/VyO3TVlvqWixy4dfvia1QSdhs9MYcJSrM3
         NAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515047; x=1794119847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaRMUeDRl+naPmm3qUT+oBT7oJDOZeWGKzT1v2c6cow=;
        b=EZDP+QCI367DmgPRXWXumy8Y6ULARRGiZOkyNXZFba2Ln2yZ/lasUYsDPQMHguiaMK
         lzFgTNO1O6+YW9QGV88Cfsdn5tDzX2imUKp74HL/DR3J1g4VwR5e3LSZKWt7b0PDqET2
         dgyi83JZT0ntjF6o3u0x4btbvkVdk4o50e5v01MEa5iJYodZ7Ifa1uM49cw9RvBXtzkp
         gyi0q9nK+Rfydx/F5H17OxXIPidqVDsyyUS4obfMcwuoUoNS05HLT04jlDMWxhuSUCp8
         NbiHMF9hMSQo/TvdH80xrq23S8k81N8v0QA6nR7f88VpYpb1KU+3gs9mVcxBq3eh9EJT
         kilg==
X-Forwarded-Encrypted: i=1; AKwUvBxdSUYBRbNIvs6LaEF/akzbJrG7oW5pL4ugoFHJ2NbO2MzMDCaiM5m72OuBgPXhs8kmZ7BBxXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/FcXvHOTvQqdxRDVDGrgHmfD+JAV4LCHuJUh1Goek8oGo5IK+
	VCFnXIcUbCSi7THq2EfA+G/AfxlNHArEYZDPP++KodFNyzoC8SNG9pAm
X-Gm-Gg: AYBFou3OX1PtXQT1EPit+aWYvQ3lOlLUeL0CDyylWAtz1z/NbWraXpUHkZWNZ3blyIJ
	s5nHucVQB5L8mAwQnNZnUPIDqXd4UD4+t5/pJ4t2oK2Al3a2IzSq5eubk8wz30lV8b7IqqgeJjG
	ZLclofIzp8F54CUZnPuCGh6319oc3edrlQQ2RNFYunDribldS6dzxu/cv+NyMoMldwnggxQQTKV
	okQa8BJxyFJ6RkgKE7AVNLiya1gy28YqQW15PsEOTA2NihO9jBXodObo8xZewYAH1dMGB5opvUa
	UeS+0+aKcJs9g/kacQQmQRvKRgod09AsIj6v+qv32UQaodvwCr41inUT5sGTA5ws0FsYl46t/2T
	Nh6npAkDygeoRTC1DB9AGhiSubItlluYqv1P8DK0DaRjQIugZ50vSTNYdmufzObArazOl2IbDQc
	5bnYLWeoZK3bbooQw9ZQZK35fmWSelCh1lsI6Nkw580gkImQH6GxtEd4meabz0zf1xElcTBqXP4
	ZSycc4xRqxw8LDJwpIPxH0fqvk8fzksKqg4oITljBxj6Vrab3VidnXd7pXmLG2f/wbkRnFV5YIB
	FA/JG26V37bauR9bWR9vcRupZwORSRDKk8DZyk1Twmy9ENg=
X-Received: by 2002:a17:90b:268a:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae89769d66mr5583408a91.41.1793515047409;
        Sat, 31 Oct 2026 23:37:27 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm5465907a91.1.2026.10.31.23.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:37:27 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH] mmc: dw_mmc: disable bh_work and stop timers on remove
Date: Sun,  1 Nov 2026 14:37:19 +0800
Message-ID: <20261101063719.88570-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
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

dw_mci_remove() does not drain bh_work before the driver core releases
the devm-managed host. The interrupt handler, watchdog, fault-injection
timer and DMA completion path can queue that work, whose callback
accesses the host and MMC request state.

After removing the MMC host and masking controller interrupts, drain
the interrupt handler and disable bh_work synchronously. Disabling the
work also rejects later queue attempts, unlike cancellation alone.
Stop both timers after the work callback has finished so that it cannot
rearm a timer after teardown has cancelled it.

The analysis, patch and validation were assisted by OpenAI Codex.

Fixes: 921c87ba3893 ("mmc: Convert from tasklet to BH workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
Testing: x86_64 object build with gcc 13.3 and W=1, with
CONFIG_FAULT_INJECTION enabled and disabled. A userspace model of the
extracted remove function checks pending work and modeled late IRQ/timer
queue attempts. It is an ordering check, not a kernel reproducer.

No matching hardware, kernel crash trace or demonstrated unprivileged
trigger is available. Please review the MMC shutdown assumptions and
external DMA callback lifetime. This is an RFC for a teardown fix; no
privilege-escalation or CVE eligibility claim is made.

 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d287..cc5e163ee7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3406,6 +3406,12 @@ void dw_mci_remove(struct dw_mci *host)
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
+	synchronize_irq(host->irq);
+	/* Stop the work before cancelling timers that it can rearm. */
+	disable_work_sync(&host->bh_work);
+	dw_mci_stop_fault_timer(host);
+	hrtimer_cancel(&host->wd_timer);
+
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);

base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.43.0

