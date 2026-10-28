Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219689;
	b=1GX9KvKZpxRmJaKSHASsPWehcgTPOQkFrfHJnWiI2lDhXmZhbEmI6N4C/F56K6e2QfrL
	 Rk4Zi3zMQAPd5SLuqbtIODHNc6+PCFFIYuuo5q8wOmCso+ocz7e39P9KJ828bc8PeNR/k
	 I+bd3yWdmQ2kSXPr7dOcVoNv1iXTGvAEJxv1sIZQTySaniF4pTpqf368e3pBM7Wv5dGac
	 IWAhp4NtyLeEDpbC97mU4JQT/nMyxjhMCJ8oTq79V6EDWh7KUZW9+RrAq7Ce+rtn3/1i7
	 YYPOLEvEKrRYeRYgP0A2N0XNnDEVaLplxNaWlpV0tEtGgCPTMvvs0bp7U7i3aTOD0sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219689;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=2e8pGxogsCbS0KkycBza0NloYdbf5Ix5pnFAodrk1lQ=;
	b=CeLXXXdMFtWlCnWCdK9HPNWWrS2FWNXxJjZvNeCTUxRmXXZhOMouQ38ZPink771BSTyu
	 cQPEr8/RhVGo9wrwuEqdoS/C5B3MEQXrXXS1GDoBrP+mBwzKMj64x0YtTqo5zZYkvU32b
	 amYmEVd2AN7tXN9oQQ4Oovx+N3xtwn9iswBLCSSjFCCR+jUWJSTyYxsYIQQ1FQW03Azw7
	 nhbF591TnrX7ummxqet6qp3p/jSGRZqQ86idpTYTDuByV7Pl7bjlnpYXf/LinLzkFRnY+
	 kcHXQEf6y8aOn6KlzXTLkqhLoB2KFegwhyq4kLynV3vme4IDc8dcGevgl+Yd7C764uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Cb4VxrXV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1VWhzBEE;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD9606A31D;
	Wed, 28 Oct 2026 20:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ECD9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Cb4VxrXV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1VWhzBEE
Date: Wed, 28 Oct 2026 20:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793219687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2e8pGxogsCbS0KkycBza0NloYdbf5Ix5pnFAodrk1lQ=;
	b=Cb4VxrXVBjZEkJmGZXx6DpDfcykY1vc+l2xDX/cRob9p3PhSovhB2lH/vFCy2MJHlVIvGt
	qa7BOF3YjrlchkUgcBDZiuKD/Z4Y5Z86BhGLlyoBh++tH9+0SGNoGLN/4Utg9h0PelKmwI
	4c1SsJjpqH1p8xb3d3QcwJgSshhMNCVogLuyO8vH8sH8qtdiYZ5STQsB7+bn2uVXLMERD0
	6nxVKYRK5bP05DLXQIHwUrqVV4JQszkNYXHdnhJfj1ZLSrYXuOGvBj839aLX4cgYUkFd2h
	3ZhpYKuoNmeCavUoHOrK0W0BHUP8irC77BYSDqhA7KnLP8aYKJJ6GOEcu0daQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793219687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2e8pGxogsCbS0KkycBza0NloYdbf5Ix5pnFAodrk1lQ=;
	b=1VWhzBEEmSIy4u2Y7JiSaF9dcb1Se3LcGsBKGDT692GA6mGsppxhqTAsER8GzIp/xT5QBt
	jhAspAIzKDPgJtBw==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/riscv-imsic: Report successful hardware retrigger
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 bjorn@kernel.org, Anup Patel <anup@brainfault.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20261026122641.3292904-2-thnkslprpt@gmail.com>
References: <20261026122641.3292904-2-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179321968564.4109677.16946027044760564958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a2f482407d33ebe7f12e30d6cf383ffb1c7d709d
Gitweb:        https://git.kernel.org/tip/a2f482407d33ebe7f12e30d6cf383ffb1c7=
d709d
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Mon, 26 Oct 2026 14:26:42 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 28 Oct 2026 21:29:36 +01:00

irqchip/riscv-imsic: Report successful hardware retrigger

imsic_irq_retrigger() writes to the IMSIC MSI register to retrigger
an interrupt, but returns 0. The IRQ core treats zero as failure and
may schedule a software resend despite the hardware retrigger.

Return 1 after the MSI write to report successful hardware
retriggering and prevent the unnecessary software resend.

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for =
platform devices")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261026122641.3292904-2-thnkslprpt@gmail.com
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index 643c8e4..52673ff 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -61,7 +61,7 @@ static int imsic_irq_retrigger(struct irq_data *d)
=20
 	local =3D per_cpu_ptr(imsic->global.local, vec->cpu);
 	writel_relaxed(vec->local_id, local->msi_va);
-	return 0;
+	return 1;
 }
=20
 static void imsic_irq_ack(struct irq_data *d)
