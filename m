Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798739;
	b=cve9lirsDw0OWT3TL7NomJcNODqdW2cedZe/lUwkW1Chm4DoyxssyITsGKaMp4/czFOc
	 vJnnThx7jR8pZ8sJDX0F36LLicVA94HkgiaEZUhO3t5FqeR87dADmZu9rDSDl9nNxjyq6
	 IVKjfLKCdtKrgTK9mzcJf7TDd+d5MpkfN6GJlj3FfPgqbF6iNDDuWVFrXpVbIJtOiGkSR
	 Mbzm+dT99QGmCrFXXf+xH1+ZMsKFHnFSPhpYz/dSYo7gDDib2NmZ0Z+eXXKfqViS/yGBk
	 IfrTnV25+mBOBB6+zIghtPKyTUldF/6Na1tbUqpxVcT51eCy1Z77iDFwUDGwiGF6/Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dhVj9s9zFV+DbHl3yJ+maZv5fyr6B5MvtTW09b8JDGE=;
	b=MODDT6uIIJB+IHiBfyfmSLheObSrxxIIY118JIzVfsHtM0hes+fCgnYosMS1XT0tqNvU
	 2N9dGiNYSeqWBiCapB597VrR2Hpu6WrSbJsQY1kRMTojR3pSp5nb8D4wz48q7ErB/XaaU
	 m6kVgmqNnhY7ahjdrYRE5YeS4LytHAbPeKPxbV5A6cM5Zr4cQrGf+tAzLKDF6wfo5zX1Y
	 HcVxiuePtlNi/hOyPZC85jovHIG2O+HWDETAE2WFdKznVGWdJZXVqkwpYILaRp0eDHk4N
	 7mzb6WYMj7G0XfjGnAGGrnJk2d+4fUg0T0oIrILJec+PZjs8jPl4JdAqfMjku8dpk8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tGbI3/06";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27695606A31F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27695606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tGbI3/06
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso1347553a12.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 19:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798738; x=1795403538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhVj9s9zFV+DbHl3yJ+maZv5fyr6B5MvtTW09b8JDGE=;
        b=tGbI3/06I/g0J13gmiKUMJPY2XMQCypJkTiVTXYaK08BweI4+sOQ5WdvQ5RbB4ffXf
         Ej9Cps7spxlMhpru/xJckAW2Der71gTsOBV7yjgnDnQhZETaBa0HApmvnBrJdJEzvBRc
         GksXV7EqCa1QuppEluZ0SYb4OHMAzdFbWZ3pRCgo/cPXVhSG4147sIX22V07Zk2MOSq/
         fkurgw7PAqpTaWYlDL++YMuy8WWy6bed0NVLKoSYVVtXEHbPPUdJhGLEX+T3vW9Eei3G
         arGzFKrjwlT9u6YMIkPCJMWhIWhj0afYSMGdO8tx1XsZSCUOKssB+8Yd64auF25OSy1E
         T7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798738; x=1795403538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhVj9s9zFV+DbHl3yJ+maZv5fyr6B5MvtTW09b8JDGE=;
        b=MPvhTaj7eHQ1qRWicxlsOLOb2gmo+mkPAuv2FX2X3dlFD7LaYh16I/F2yVjnFigxwH
         PZIwrZ5ET0NJALFs++uz2aNq+m8crqaeHojsuc24DFfPty316xhKXZKOzXo/b913FzkL
         j7A7JCOBluimh+gvLDkcJKOw6t1Sl7NH0kgWZscjIN4x7ltqTSLTM0uC7Rc427kjw3VK
         32pt6xwKxes56PDNsERWOcvjMXor/Gdk+U1gYgJdpLvSrWvXG2S62w6i+Krc/0XYu4py
         HCh4kdxxWJVSX3Gw4LXS60Hg6Vr6IlKyqub3ooGbmCS82918CUvpfcf26oTKU8ezLfaK
         WXbw==
X-Forwarded-Encrypted: i=1; AL+hErGdBP49Tr9lDIl8e7lPtMoX6NYX8qDJpm07IbryWvnjyydiLAC5u6B1BcyvR9Pnoecxv7GyLHw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t+KaiU1Atub2BbKHNIDaR5cShm8qbSNWoY+g/qMzKRnkMkjHJ
	5wg66judN+gq3Yo47+3LL7jQDOrzj/kfGEeLtFL9na+ASKgEr0vjmTep
X-Gm-Gg: AYBFou2/RgIP48OhAVlzs0WGw8kvvV0B358ljTGEbUWX3RfXMy/vCDS4FN89AWus2EF
	neAumWuhJE3r5orQukwk0PJrSvycyX0fvL/XWYGxIxsPduSW8ZqY6L/wwbCOdAg7CN4D15E3I4f
	W2mpjSK5GFXOMAzDkU6DA96bu/3KwfcBJCIq0yr1p5ivneeP7FVCXqe09OvLPeJhtqBQ23C6tlM
	nEYinf/OjqS3YnVSdpIMvp9fwh4yitvFCb4U3fHpngJaYSQcEW/FbfnxomlxFxE5E0UtUCJddDI
	HhgIlzpZod4pWD+VYJeWx6JhmAigjkTxs4XC0z6XeinDRJKS+UzAy9iUenZCbddIQpcAmhh3kG2
	0dDEFJBIJmZJdROUP93lizVUbKlZfcvY6jALZCFdHaQrjonzUiFrHzucURy1nWDPhJ0BfaIR/iY
	H+0b5zJF1WmZ12CL669r/N3kFbFF0HgDbaH1YePYR0E7TVvJbDnMEPKPmISc/VYDxw4ukY/2sVi
	li/oax3g+9DN9sv3+V+JAhmS/DOFwKCFv8q8SULhceRYlGvcFzTlK817KPnwC0mY5raDKCSbLPC
	RbGUn3Pl+7avtEDwJ9sHRVIW4fB3BFhM
X-Received: by 2002:a17:90b:184b:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b1b0ccf45cmr6223470a91.30.1794798738434;
        Sun, 15 Nov 2026 19:12:18 -0800 (PST)
Received: from x1.home ([172.56.107.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8dc859sm31238405ad.59.2026.11.15.19.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:12:18 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	mail@maciej.szmigiero.name,
	David Westen <davidlwesten@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: wwan: iosm: fix S3 resume by re-binding the driver around it
Date: Sun, 15 Nov 2026 19:11:48 -0800
Message-ID: <20261116031148.333990-1-davidlwesten@gmail.com>
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

On platforms where S3 cuts power to the WWAN card, the modem boots
again while the system sleeps, but the driver still treats it as
running. After resume its execution stage reads BOOT, and by the
first port open the boot code has crashed into the CD_READY stage:

  iosm 0000:03:00.0: PORT open refused, phase A-CD_READY

The modem then stays unusable until an ACPI reset.

Unbind the driver before S3 and bind it again after resume, as
commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by re-binding
the driver around it") already does for hibernation, so the modem is
probed again once it has booted. Suspend-to-idle keeps the modem
powered and is still handled by the suspend/resume callbacks. The
target state isn't known yet when the PM notifier runs, so use the
default suspend mode to tell S3 from suspend-to-idle.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: stable@vger.kernel.org
Signed-off-by: David Westen <davidlwesten@gmail.com>
---

Notes:
    Tested on an XMM7360 (ThinkPad X1 Carbon 6th gen, deep sleep) with
    this patch applied to 7.2.15: after resume the modem is probed again
    and comes up without an ACPI reset. Not tested on the XMM7560.
    
    The investigation and the patch were done with an AI coding assistant
    (Claude Opus 5.5). It read the driver and added temporary debug logging
    to record the execution stage around suspend and resume. We wrote the
    change and the changelog together, and I ran the tests.

 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index 49052eb511ba..ec27d6fd7910 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -534,12 +534,17 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
 
 static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
 {
-	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
+	/* The modem loses power in S3 and S4 and boots again on resume, which
+	 * the suspend/resume callbacks can't handle, so probe it again.
+	 */
+	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE ||
+	    (mode == PM_SUSPEND_PREPARE && !pm_suspend_default_s2idle())) {
 		if (pci_registered) {
 			pci_unregister_driver(&iosm_ipc_driver);
 			pci_registered = false;
 		}
-	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
+	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE ||
+		   mode == PM_POST_SUSPEND) {
 		if (!pci_registered) {
 			int ret;
 

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.56.0

