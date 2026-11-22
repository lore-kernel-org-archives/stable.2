Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323666;
	b=grYYwlNq/rKaMG3UN5yvxuQHULHvQqjlB7o1TUt/D47LHzhlXby6QpRz31MQA+tdqWRH
	 OHxnea7NbhcngIcezzZSufa791z9GXPBu5nZ5C88j2Z67LvZbz7odJkm3jIPmL00fmp2G
	 vfhacYZYWBb8wueygx+8RHoYR9eTiJurPyQ7Yy6V6g8XfFEii/e7UcnHCVi8785r+OAYM
	 mcHI+rzcUEZk4xNNMrB7WAXvTBQQBf5oPOVAT4zyXob9XVGrcUmpEtdnJSdMnvmfXW/wD
	 Xz9sYsP5O8eYorAl2a7l4UvRaef607937DKHeHsTGkvPOP50upeVMgdm3eTqHkir1tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8sO5baWR5ydBEJ8ZbvTGeWnxXFHzKoOvclS5abJHCLc=;
	b=ZaNMVPSaWjoGQg8BeUUz6O8sVVGNVqQUKszfC/fqzFpqeUxWj8JnRVEqvW3nUl9HtsrR
	 O6LN3y01Mvl/2q2zPzLGcEJdgM0ZO2FQKqxwffwhZZzKGapJ5CB5GtGXkUMHSydQw+8TL
	 QDI+b80KrEOwZRG2RJWmV0uWE7+r0a4iRakEQyN6Pcnte7GvaraYcLHAA/PKTpFITnddS
	 pppGBEA2JQWDnUvaCwlwGJkDWckS8jAEgqEyzyKGf/wr91rm5qUXB/93UV6BmGk88hbGU
	 5qX10L7oMg53oudHOv3K16KxzaxO2KZx8NMjb89Qe0qIekybzV3TbE+nFaYqO+Y5gyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICGUHgEz;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D0606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70D0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICGUHgEz
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso1116922a12.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795323665; x=1795928465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sO5baWR5ydBEJ8ZbvTGeWnxXFHzKoOvclS5abJHCLc=;
        b=ICGUHgEzmNAkS+6+rKhYTvE6UimbSj2StJZBaerKMoDxcmxCubWLSfIHmmxQl1g4DO
         xxjxxGyvi4Eb87Uhm5z1rVC/3+Lu8Ug41jt/l9KYP/xhG/u5LwceuCJXjo3z5Wcb/HKO
         Wg0c2fa9Qm7MlGug/l+rjLLBmKeEHwEyiPYMdi6E6IYzPU13+4L/+iYbAxD7ZOc0o0Xm
         fCE3/fSBEPDY2zHarYLaKuJD8PKdBr/TTI7gHmoX0AzNX2Ne6jBd9lcMstA7Z+b1egmD
         Ua1DI4I2pkXHdxccbdJ74lAnTgG9nerswqE7ekxTGTgAsUgnXNjJhAbWqRuQNxNsNnlr
         TQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323665; x=1795928465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sO5baWR5ydBEJ8ZbvTGeWnxXFHzKoOvclS5abJHCLc=;
        b=Ssd2ZUobhq0YoBmOZw+5kxYT7K1FVSOZBZ3gLVyCsFt+w93dQIGOcEzMEvkm01gjy/
         p/jB8Yx3ttm+3mJE28I+PScj/KwzckQGIVMKyGYReD63/g9yXKmSnJm8JT1BCA9oY3Th
         uyGCMcN3LqyVC+QpiHI1oRFpleDO5UXJp8Tii7uvFh5L+z6kRej8pWS5mGvGFJXZpS5T
         5W8CSuAKpeefAd+l4qrRfEj5SvNLMPIhhQyQT0eLBGr8d+kdWetVQJZ1x502Y0k2vV4/
         vuaIOE84YqpXefXy6rThY3bQOIjrdNAgsBNDXXaaclXNFBp2j0MrqyWy/bbDoTm/ikdm
         9hCg==
X-Forwarded-Encrypted: i=1; AL+hErH3npDH5wq0ORjHeqeno//p0JEt+yGMifvFYB1wdIT0dvjiOij8ojVWUMNPFafGCVGqSBOT1IQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fiMJvrCghpac08XNBlLbz9kIYeboiVOJZULYZDjX5aDEhSE2E
	GMRMA+8bC8Bb+Pp9Ae5A3iuT9NHAfBSJTEK9eMMkLwhBXMYTLKC+FB+y
X-Gm-Gg: AZFdTZdVawa6Dt+co/f6aztCFRSuYmnR7cbMZQ9CbhtCdm3A2rk95Zx3cnysEX9KEFI
	PNaAPC+2L4PLN2vMHBnGGx3JMKk1EF7CnZkKYxHecNC+m9hTGDo/Vr0zjmYX/mKlOwNJSfrH1Mb
	wR4lHz5Z3ICNF3Ubo15xDASG3G1Pl4TqbH7JsoryqO5qCN3mYlWhMaxcPzQc9lgn2k6djhSCXIx
	EnLeLu4m2U6zTqI1y4eFtRiONHm6zuwc8ci4RiQogxrV75VZlzsvI3WCNNZAst4nMdrmXDrY0lY
	ZFX+lfjQvxws4jTk32r5JKYpy0b1Iq8akxU3nSeuyLIDqTlHRv14FEQ19KYC9Prsd52Q49WHqFc
	DVpIfOzW94nCAXN10aed+GYBf1qYb772QFyo1/URqH9lt7QOFX1HuR21RM5FruadQqEh3FOpeMn
	HljTYXuYYVOax6V5DaLLwol4WXaobpwPkcxcgkCNYyX/2VymDZWAEAkbZT8EGs43XwBZBAZQ54B
	fF+/XYrK2eBk784DtaM/bPNke56cma+zijh+sjHWsPwWx2EHxPHgXXs15SwOr4ntb9Animv6SOa
	DdviajDyIpzBZv+VF4NIpaNyv/xtvSKp6hCE2Sw=
X-Received: by 2002:a17:90a:c10e:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3b41c9080c5mr5222821a91.18.1795323664828;
        Sat, 21 Nov 2026 21:01:04 -0800 (PST)
Received: from x1.hs.local ([2601:600:a482:7d70::4d5e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm3431606a91.4.2026.11.21.21.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 21:01:04 -0800 (PST)
From: David Westen <davidlwesten@gmail.com>
To: netdev@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	m.chetan.kumar@linux.intel.com,
	mail@maciej.szmigiero.name,
	linux-kernel@vger.kernel.org,
	David Westen <davidlwesten@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: wwan: iosm: always send the host sleep message on suspend
Date: Sat, 21 Nov 2026 21:00:39 -0800
Message-ID: <20261122050039.861287-1-davidlwesten@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Unless the BIOS reports D3L2 for the WWAN slot, the suspend callback
only rings the FORCE_SLEEP doorbell, and resume the FORCE_ACTIVE one.
Neither waits for the modem. The driver doesn't keep the device in
D0, so the PCI core then puts it into D3hot anyway. An XMM7360 in a
ThinkPad X1 Carbon 6th gen doesn't survive that: after
suspend-to-idle its execution stage already reads CD_READY when the
resume callback runs, and the first port open fails:

  iosm 0000:03:00.0: PORT open refused, phase A-CD_READY

The modem then stays unusable until an ACPI reset.

Send the ENTER_SLEEP and EXIT_SLEEP host sleep messages on every
system suspend, as the D3L2 path already does, so the modem knows it
is going to D3 before it gets there.

This ignores the BIOS RTD3 setting for system suspend. The setting
only selects the sleep protocol; the PCI core chooses the power state
without it, and here chooses D3hot, which the doorbell protocol
doesn't survive. Honoring D0L12 literally would mean keeping the
device in D0, as commit f4dd5174e273 ("net: wwan: iosm: Keep device
at D0 for s2idle case") did. That was reverted, D3 being the expected
state.

With this change the modem stays in RUN through 2 and 10 minute
suspend-to-idle cycles, and its data session keeps working. Platforms
that do well with the doorbells now use the messages too.

Fixes: be8c936e540f ("net: iosm: power management")
Cc: stable@vger.kernel.org
Signed-off-by: David Westen <davidlwesten@gmail.com>
---

Notes:
    This is independent of my S3 series ("net: wwan: iosm: fix S3 resume by
    re-binding the driver around it"), which leaves suspend-to-idle to these
    callbacks; it applies with or without it.
    
    Maciej suggested forcing the D3L2 path for suspend-to-idle earlier and it
    helped another XMM7360 user with the same CD_READY symptom:
    https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/work_items/992#note_2938256
    
    Tested on an XMM7360 (ThinkPad X1 Carbon 6th gen, BIOS reports D0L12)
    with 7.2.15 and a debug build that forces the D3L2 path, which is what
    this patch does, logging the execution stage and the PCI power state.
    Starting from a fresh ACPI reset, the doorbells left the modem in
    CD_READY by the resume callback after 2 minutes of suspend-to-idle.
    With the host sleep messages it stayed in RUN through four cycles of 2
    and 10 minutes, two of them right after a fresh reset, and ping over
    wwan0 still worked afterwards. The modem and its root port went to
    D3hot in both cases. This patch itself, backported to 7.2.15 on top of
    my S3 series, then passed a 2 and a 10 minute suspend-to-idle cycle with
    ping working after each, and S3 with my series still works. Built with
    W=1 on net/main. Not tested on the XMM7560 or on a platform where the
    doorbells work.
    
    The investigation and the patch were done with an AI coding assistant
    (Claude Opus 5.5). It read the driver and the earlier discussion, and
    added temporary debug logging to record the execution stage, the PCI
    power state and the messages around suspend and resume. We wrote the
    change and the changelog together, and I ran the tests.

 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index 49052eb511ba..dd7cfe3747ef 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -406,14 +406,10 @@ static int __maybe_unused ipc_pcie_suspend_cb(struct device *dev)
 
 	ipc_pcie = pci_get_drvdata(pdev);
 
-	switch (ipc_pcie->d3l2_support) {
-	case IPC_PCIE_D0L12:
-		ipc_pcie_suspend_s2idle(ipc_pcie);
-		break;
-	case IPC_PCIE_D3L2:
-		ipc_pcie_suspend(ipc_pcie);
-		break;
-	}
+	/* The PCI core puts the device into D3 whatever the BIOS RTD3 setting
+	 * says, so the modem has to be told with the host sleep message.
+	 */
+	ipc_pcie_suspend(ipc_pcie);
 
 	return 0;
 }
@@ -427,14 +423,7 @@ static int __maybe_unused ipc_pcie_resume_cb(struct device *dev)
 
 	ipc_pcie = pci_get_drvdata(pdev);
 
-	switch (ipc_pcie->d3l2_support) {
-	case IPC_PCIE_D0L12:
-		ipc_pcie_resume_s2idle(ipc_pcie);
-		break;
-	case IPC_PCIE_D3L2:
-		ipc_pcie_resume(ipc_pcie);
-		break;
-	}
+	ipc_pcie_resume(ipc_pcie);
 
 	return 0;
 }
-- 
2.56.0

