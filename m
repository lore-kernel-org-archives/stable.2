Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149794;
	b=BaWVhPhCN2AAZThZPoFO+BqGtNUZ9ks7J2vHvBknvObkrxsPZgrVQaTRs68tDeGzDB1x
	 H0a4aH42qMzkCNUghLivDNFXcSMF9QqYBMDdQCZR2vUFqaSH/SvJq7x0JWr4tPtPCO1rY
	 ZDCB0tkFE5RJ6R8/DIP1cWPOeH6phe/pDef1cgFArW9M7D/wvu28hVG3U+u5gaLvCDkFI
	 kPQf4/E+1QNCg2pLDgETaJUpOjyUfNS34FSEnnJcMesU7pSCfi7y8bnKwr6u+r2VVWgEk
	 yqQfAxKC2w7lVaFS5xR+lKSADufUio4aTRQawdQ4+cp/bjhS7ojfQvJ7QM790wdEFFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149794;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=lqDt1Owim2YZ/Pr88FxbmrZHbmtAdCxve/g4kOQzHbc=;
	b=BX8mJhnpiDT2EkO6Up/x1yV9RCMCRSfCncqY/Mk88839p1c7zxQQDpWXcyk1oZydg/9D
	 fQAkb5nS9jMVEYpdqipFmcQSFcpcTxhX3VmOXZF77WqAtvCv3paf5nbVgbW384nArPKR3
	 TbIzG/0JQxVIdOxruYwy5mF751GbZnvFGfhDzbQq9n3L1TaNYPx+1cpXjuw8qt5nfI/o9
	 n5wS71odKrcJjGh/S8AWoyt8HjU6WqcKmucssXIbw659dyNLh6MyW1ZpH49yZFZbyP/uz
	 r5Mu2HK1DMXJXJa3vNyAqBC1VvaQxUBEWkqZxECc3PquovVSiIpHWA5M/DYh5F+ajgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=v1YNzcNh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9lX1aELG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E444606A325;
	Fri, 20 Nov 2026 04:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E444606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=v1YNzcNh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9lX1aELG
Date: Fri, 20 Nov 2026 04:43:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795149791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqDt1Owim2YZ/Pr88FxbmrZHbmtAdCxve/g4kOQzHbc=;
	b=v1YNzcNhl+03KaQ6PYd88V9s08bVi8IsFZRO11Cak+Hd55AcWHrRnhDbaqV/1DSRXZPWF9
	MX4ZSNdLJ1n3fdL8REdRDpKgZG0BcrlAojhfMjEFcnPwd7tGYP1M6iDI9GJ3arX0ihXsyc
	cQp1U6CwTkI/UtecF8Qyu2U63LBc25a7so2yePOkh2gMQGEfRILa5J+oJ2164MIAHdH92R
	NRpBEBYaa1g7KDc30gAAiSCKHuV0+oPhX+wBPaQOYbsomW0rwib0FOv5h95zzK+j6qYdO/
	KtIX2OoWZzrohWfEaGQRSP3Cfp8uH1+n2lQqguqM2eRE70lyB6Y2QLRIh0MMLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795149791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqDt1Owim2YZ/Pr88FxbmrZHbmtAdCxve/g4kOQzHbc=;
	b=9lX1aELG1zkxyOyKJH/hutLcdtZCD8dBo7JWu2kP+8A51CVebgxWmm/kHd19dTS2ujMPDr
	CMz0cC+GbausnoDg==
From: "tip-bot2 for WeitaoWang-oc" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/apic/msi: Fix MSI interrupt affinity configuration
Cc: Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Koichiro Den <den@valinux.co.jp>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, v6.1+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com>
References: <20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179514978893.3191731.5879996775654988810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     068d82afd070beb8ea32c8ee64d685af7d3f36e2
Gitweb:        https://git.kernel.org/tip/068d82afd070beb8ea32c8ee64d685af7d3=
f36e2
Author:        WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
AuthorDate:    Sat, 17 Oct 2026 02:10:16 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Nov 2026 20:17:47 -08:00

x86/apic/msi: Fix MSI interrupt affinity configuration

The two step update sequence in msi_set_affinity() is required for MSI
interrupts which cannot be migrated atomically, i.e. devices which do not
provide MSI masking.

The MSI message update writes address and data registers separately, so such
a device can raise an interrupt in between, which results in a message built
from half updated state: a stray interrupt on a stale vector and a possibly
lost device interrupt.

The update sequence is selected by a per interrupt quirk flag, which is set
for interrupts which cannot use reservation mode. Reservation mode is only
enabled for maskable interrupts, i.e. devices which provide MSI-X or
mask support, so the quirk flag is the inverse of the reservation mode
bit.

The removal of the quirk flag replaced the flag check with a reservation mode
check, but dropped the negation of the removed condition:

   - if (!irqd_msi_nomask_quirk(irqd) || ...)
   + if (!irqd_can_reserve(irqd) || ...)

As the quirk flag is the inverse of the reservation mode bit, the replacement
inverted the condition and selects the wrong update path for every interrupt:
non-maskable interrupts take the direct update path again, which reopens the
race, while maskable interrupts needlessly go through the two step update.

Restore the original condition so that the direct update path is selected when
reservation mode is enabled, which also matches the comment above the check:
direct update is possible when the MSI is maskable, which is the case when the
reservation mode bit is set.

  [ bp: Massage commit message. ]

Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Koichiro Den <den@valinux.co.jp>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # v6.1+
Link: https://patch.msgid.link/20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com
---
 arch/x86/kernel/apic/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3..da5f44a 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -62,7 +62,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumas=
k *mask, bool force)
 	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
-	if (!irqd_can_reserve(irqd) ||
+	if (irqd_can_reserve(irqd) ||
 	    cfg->vector =3D=3D old_cfg.vector ||
 	    old_cfg.vector =3D=3D MANAGED_IRQ_SHUTDOWN_VECTOR ||
 	    !irqd_is_started(irqd) ||
