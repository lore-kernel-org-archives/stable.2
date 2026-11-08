Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156222;
	b=ivTmaJRW61PpX5D71v78XehLlsV04dPVal+1snlUE0cf5BvZHXK41AOcYMQAjwciSxnF
	 W07EmKKC7IduCZJ6DB4C+JpmPzywSwqzRjrRHyouj6PbGZEDcOC6Fcl4X/UACfkr6qf0u
	 i05/QNIX+XJKBOkphjfwp+D0E46ZbIoZEyFMsMyaiXA5qVYWzGMRhhFhotDWCrPwRui7T
	 2JCodIlR+Pg2uJlyqhh7RVQOgGnfqfKHQtVu1J8GVYu5B5kc8adQPuyQy9IMK71308qhL
	 FJ+9Y6VY1BmbKKwGzWNsCZ2hE7iZ0nNDoDvQfXpoGtpZVq+VeKqKRH/JrGN4Gq2KcGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156222;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=7aOhoI9xQInTI2IoToIaRRagEMy9aljQDQTESt0ZIXs=;
	b=5Dk5OglrDyz7XAU0CaktrzLoM6GIKaWdplEOY3AhTwXQymzpczxFZRnRfSFpJqkwRwmu
	 ieP0cgp5DTv/Wx4Vn7zQX44RGSFTLGAWEgC6bf4NLgrPZCpkKaj8yumRsEORQgXrKVOdV
	 V6IeRQPpfvcImnynQeomLyN+CoKnOSXu+Hb68poOnjSOSJhLCfwcPuVQLIX29JhaIegP5
	 C1nHMOL3fZxvCsrCgi6Z9lO0gc7m1XFmo6uEfIzqF+Dqw2RJanSVPp2RYnab8i110a9pE
	 H/3El4QvcxITlzr9ao26l1ucWQyrpAP+vZr+bAhaTEBXdRdbTmDIjbBuYzPdyV9ozlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DnA3KMTn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nHMR73dg;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E2606A334;
	Sun,  8 Nov 2026 16:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5E2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DnA3KMTn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nHMR73dg
Date: Sun, 08 Nov 2026 16:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794156220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aOhoI9xQInTI2IoToIaRRagEMy9aljQDQTESt0ZIXs=;
	b=DnA3KMTnmz2Wrg6g07Zp435/r/zak4SBMMQgiwBW8Op+57QqumEqUP4xCMnLABqBtjNdnV
	fW9DuYZanGd23PYS29kwJbQjIShRSoC48iU9yAqC++Jj5dN3WkjXep3kZeo7674mbyPSMY
	+8J0CrEbKY3KeqqDT47fdTSNqHg15mRlzpVhuu3rFORlYFSJsGgLVXSy8WI51h7x5SXh1L
	HFfkf17VJe9Hr+YtDC8WyM3eRo80Fhf3XTOsZNHm3d4xprlvPAh9TSOX/MyRTpykGj93fy
	OF4+gjeSIynpbq9EzUQRyDqmUtgu0AUC0o9xCNm29IDwDqNrHZ3zYHIWD6qRWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794156220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aOhoI9xQInTI2IoToIaRRagEMy9aljQDQTESt0ZIXs=;
	b=nHMR73dgsmLJ5r5YClWwBl/ocCK/hNlSYR5aABr0aO2DGjaAiIxh7D8oxI0KVPnZ+nrpj8
	Rtz8VBqmaB95ozDA==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Avoid freeing borrowed firmware nodes
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261025121242.2169180-1-thnkslprpt@gmail.com>
References: <20261025121242.2169180-1-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179415621861.2093942.11178552553536784469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b22795dece39a7e200a1eb750ee3511ac892816d
Gitweb:        https://git.kernel.org/tip/b22795dece39a7e200a1eb750ee3511ac89=
2816d
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Sun, 25 Oct 2026 14:12:42 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 08 Nov 2026 17:39:43 +01:00

genirq/msi: Avoid freeing borrowed firmware nodes

msi_create_device_irq_domain() uses dev->fwnode when
MSI_FLAG_USE_DEV_FWNODE is set, but msi_remove_device_irq_domain()
passes it to irq_domain_free_fwnode(). This triggers a warning for
firmware nodes not allocated by the IRQ domain code.

Only free the firmware node when the MSI core allocated it.

Fixes: 9d1c58c80046 ("genirq/msi: Optionally use dev->fwnode for device domai=
n")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261025121242.2169180-1-thnkslprpt@gmail.com
---
 kernel/irq/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b22d744..e1d8503 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1129,7 +1129,8 @@ void msi_remove_device_irq_domain(struct device *dev, u=
nsigned int domid)
 	if (irq_domain_is_msi_device(domain))
 		fwnode =3D domain->fwnode;
 	irq_domain_remove(domain);
-	irq_domain_free_fwnode(fwnode);
+	if (!(info->flags & MSI_FLAG_USE_DEV_FWNODE))
+		irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
 }
=20
