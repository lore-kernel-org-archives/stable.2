Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163457;
	b=ycaKJDw44SqmkC0wqkIIhdvXZLnXQrCmpe+Kscp1NRP3pW0bbvUZzTIUs4Av3nTvdAIQ
	 Okegln3A8s5jKTTHUkAmbHBLWS8QfvQDg3NIvMRP5N8nMCZcFpPVpm5qdlnutF5kRvJPM
	 AGb70w6Qr8DmjrXeMkQsouBqi81ImaFdTgh95Tuik6CYBZ00YbNQGQ9eCZlz/6ZV8k+XI
	 LIkhI3qjJ0WwbckA1Opo7AqHU6dl/8ub3zLm/cr20IihWuf5bDDah9DgeTiL0v99DQUJt
	 ngxI1LD/aBV286J4kjIfb9tyIicJU+jXmXFQTOp29khc9FajoxQJEKKj6lJf1l6xPCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163457;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=I5N9RQ/IoP6DtE2/EdfV2nfVO2+Sdw5QmebG6Y33ymk=;
	b=Zoyd9Gjv+omBP1ND/hvDsVWtdqZDNAIoHe08QorLbkYfy0Ex0bODsP32Cbk935Mg+iXI
	 7sVqqXZtzfvZXKCotiVErKjOI77AfYwyPxYzQxjkSyJM2SxAAs9LykD/UYHW89iqJOh0v
	 7cGfwx6NwdM9j4vpz1akdmpbkECECj7uX/OgtLNhlMV/WTTU1/l/9Q05csD5+CtGlQG6j
	 t9cZNpbC0ffXA508OwEOrAFF9okejNHsRvhXCk+OuPbFy7Llwqc3uF9lhr81Uui8e9DFW
	 U0Pku7eCvo1MjDIxHa/x8E/IWC9VBuWQGQ4JD4EQDkrWjHyQaarhuVvwtcl7ZZs4CaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Cji4uy2O;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA1606A31D;
	Wed, 28 Oct 2026 04:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26AA1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Cji4uy2O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I5
	N9RQ/IoP6DtE2/EdfV2nfVO2+Sdw5QmebG6Y33ymk=; b=Cji4uy2O4D97JMAvWZ
	bSNGvYWUX4xKZwx7q1khBR9NGdby4NUJtvXJqkaLbbaQkK0tzJS5c66a0ctSHyQP
	qxqi3sBJ8vlvcyJfIhcmdYxNa6sUuCelrvOhPVpv+Bg9MShO9ATq6dch1TBwuHWw
	vVl/22/v5rqC6bs7D1DiH01is=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3P_qigOFqkRkuDg--.55918S2;
	Wed, 28 Oct 2026 12:57:07 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: host: fhci: drain completion tasklet during removal
Date: Wed, 28 Oct 2026 12:57:05 +0800
Message-Id: <20261028045705.114039-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3P_qigOFqkRkuDg--.55918S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr43Xw48Gr1rXw47Xw4fZrb_yoWkCrg_Cr
	WkGrn3XrWDGr95Zry7ta17Zr4xt3ZrWFyIqFZ5taySgay7Xrn5Zr1xuF95CFW5GwsY9Fn3
	C3s5ZrWFg34UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU84a0PUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wNblWrhgKO4jgAA38

The transfer confirmation path can queue process_done_task immediately
before the timer IRQ is freed.  free_irq() prevents new hard IRQ
handlers, but it does not drain a tasklet that was already queued.  The
tasklet can therefore access the FHCI schedule, timer, and HCD after the
remove path releases them.

Kill the tasklet after freeing the timer IRQ and before releasing the
resources it accesses.

Fixes: 236dd4d18f29 ("USB: Driver for Freescale QUICC Engine USB Host Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/usb/host/fhci-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index d572f0c1dffa..c3fd7f77a71f 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -757,6 +757,7 @@ static void fhci_remove(struct device *dev)
 
 	usb_remove_hcd(hcd);
 	free_irq(fhci->timer->irq, hcd);
+	tasklet_kill(fhci->process_done_task);
 	gtm_put_timer16(fhci->timer);
 	cpm_muram_free(cpm_muram_offset(fhci->pram));
 	for (j = 0; j < NUM_PINS; j++)
-- 
2.34.1

