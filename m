Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219689;
	b=f9FVb9bGzZmm/f+PWaqC4fO8WUKTW399L6/k0Hj6kZb4TXMJcS52Nn6QbvRF0Gu7HFkR
	 tXUDmCnEpDDAwNd48arH4Lx/CmdavPA9706lM8GInsM1rwP61a9oWMKCsuWuazw6U4XtS
	 757jhFzfaBrYM19p2KQ/TlRVSRo5g4VOd5QTfYt9PnsR2KXpnkzHsLrUU6/HgyIruSavp
	 bUHKK5Z7TCHyuEATAXlTio7fRmbwS8T9rEhwPEwcoBGjX1EPQvppt3F11tHhdu2gqxs1i
	 YXjrE3h64x4tEXZa0cn3XQjaFrCy8QN0UIo0hVJd6SCGHO9oaubqUS6Yl9jsSLWGZMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219689;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Yk5/XLzJ5f+1po7K3dQbPw3WGKnnHFKPtx8SFjJPecs=;
	b=mV6gv2B2fvWoKUzydavN9NtnDPeo1SbkQKOqh76s6ZviGYW/ngA55n4X55lI6XdQHkcc
	 Fq92p7FvWfcq6GtTauRaDedU8Qf34CEclbu9KpODlbTCKxw2EcHkMyjoXhBYBrWL/of7t
	 4FBUQxV0LXHN0EPakXBrs/B93yZclOOQYeIIYEcmB9bjnMuQg1M8v2DkXfPQaFyYuhEbr
	 LqCAVXevWsTO3Q8HUW32QmuLBZSCz2qq26oxPeb7yzBnEq6FEs0Im2Uaii7h9xo2DknD4
	 SCfeESkxDGcJ2pkdlMvT5mhOqdc6rlHKSMCdw0UnDFRAof9dUZ1BBJ7cUu7Dv3ZSrLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ObYGDubl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MAA9UFqb;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D41606A31C;
	Wed, 28 Oct 2026 20:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D41606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ObYGDubl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MAA9UFqb
Date: Wed, 28 Oct 2026 20:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793219685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk5/XLzJ5f+1po7K3dQbPw3WGKnnHFKPtx8SFjJPecs=;
	b=ObYGDublF7qeEzK8zHCYewskqTVxIX3WhJexVVLXXbyB/4K/dED8aBqKVPs88Os3wGBto5
	rNA4Ddq5b8R39oTU32kPsgwmsgQMIrk0SodfkB9IC6bP1HveZ8908itZ165PzZEcFFgwPR
	9q+O5JxUh833xGDSj72E1/hIpN7UUdxDIq9Nv1yw/T7AS7ETg7u9KC/v/btzd4H7iu6y+U
	QhbyLyh7vxRoHQl2QpBmRdg9pNVE6WAGoYgFch5bDtkiTjvee+wUy/M/D3KfPfURBqN0RY
	o+ZqkeI/2rj2JQqdPT7S93uf8yjCaj3WdXYB9JzmZ8oXvxEzJmO3V6xGNHRcYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793219685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk5/XLzJ5f+1po7K3dQbPw3WGKnnHFKPtx8SFjJPecs=;
	b=MAA9UFqb4wbI3MCjuCRcrgzXuJ3DuTzrqcxWQK9+gM4+7Gp0X2QWqlLbu+5/rAp4ddXqfH
	3uiCeVrqSIXRnfCg==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-msi-lib: Free wired MSI descriptors
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261025122058.2180685-1-thnkslprpt@gmail.com>
References: <20261025122058.2180685-1-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179321968402.4109677.4505423239419852725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1c16bc2b1122f78f9d51c5785f7a78b36d44972b
Gitweb:        https://git.kernel.org/tip/1c16bc2b1122f78f9d51c5785f7a78b36d4=
4972b
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Sun, 25 Oct 2026 14:20:58 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 28 Oct 2026 21:29:53 +01:00

irqchip/irq-msi-lib: Free wired MSI descriptors

msi_device_domain_alloc_wired() allocates a descriptor for each
interrupt, but wired MSI domains do not set MSI_FLAG_FREE_MSI_DESCS.
msi_device_domain_free_wired() releases the IRQ without freeing its
descriptor, eventually exhausting the domain. Failed allocations also
leave descriptors behind.

Set MSI_FLAG_FREE_MSI_DESCS for wired MSI domains so both paths
release the descriptors.

Fixes: 64a855324311 ("irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MS=
I")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261025122058.2180685-1-thnkslprpt@gmail.com
---
 drivers/irqchip/irq-msi-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 45e0ed3..a1e12aa 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -75,6 +75,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct i=
rq_domain *domain,
 		info->flags =3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
 		fallthrough;
 	case DOMAIN_BUS_WIRED_TO_MSI:
+		info->flags |=3D MSI_FLAG_FREE_MSI_DESCS;
 		/* Remove PCI specific flags */
 		required_flags &=3D ~MSI_FLAG_PCI_MSI_MASK_PARENT;
 		break;
