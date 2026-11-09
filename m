Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232980;
	b=VcZj87aOHoBkF/hLXCEKTspzLOPDfTNzxjsde39g8gf1zg+6KT0Lnt/Y0gKlp4mZfpeB
	 WgvaEq/7U6qSXb9C7Px4D0mOnDbaFMrdpHNSyD3ZEoWEaSRNXkh1VGEtgVUnyl1aoQDQN
	 NUtZK+o/2/VSNgptM6M39DANuIQFkoz9zO10eb7omoNiqJo2ICWgH91aTqXtnrKUqVUks
	 wfCN29UV+pw+HKs4VB8L5RswbKobEeYFKxEIa+jIK9XHO7b5s8ZjcvYaE3pQ5XX1YrK/2
	 DHQ5z1dxFSvz1OOb2FFkPq3dkab2wTQiBDR3ksQne2Er5eYUd1pCuEpBwMKLJCs/LYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232980;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=4IFgMuSamtCGf6cM8viFLNQK7HTuhKxaxt4FU0NAK/Q=;
	b=UCxWHcK+MNsBa4dIYvDilrI7JlHxXGnr01h/82f4QX0orZlTUhdlrKkZRyl0C7sktQeX
	 vo3327Dg8tO1lIBSjbGzvualJrNUpquaQC7J0MDtC7leEcOiF3EVhLa7JmudtXYUjx2uK
	 3akF3YXl0oukPZgj4otSg2LfkmaWTPkftiwJnbxNyzspOjw8n2YhAXZ21quzKduSFAP2N
	 oAD/Guq5KadSKt7VWSR0+Ar74Qervhl7+kFFqFuTZ0VO8fXDlV5n8g5v+XovnO/UMWhaC
	 YOT8sIfvtxWwC0qXXhdEUXtz29MDbUTT51kxy+qmtOnU44Zu8lw1pYO5lnpKxRFUKyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TDzWzqut;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RNG7T3a2;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE88606A31C;
	Mon,  9 Nov 2026 14:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TDzWzqut;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RNG7T3a2
Date: Mon, 09 Nov 2026 14:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794232978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IFgMuSamtCGf6cM8viFLNQK7HTuhKxaxt4FU0NAK/Q=;
	b=TDzWzqutpPKRvZfEfTlr6nocOH0sVMEDRnscjjtNQPn4FiNxwIJqu+4ULRY8Px4ZbQ0m3t
	Bk0zgaLSFwtj7iBHre4hxVS9DQBNGygba/ZggsTSKlXeB5A9CYssbD7Rs38tnC2XDIFoEG
	AUM0Z39qpyNq1/i4J29vgUOPZFiH42yKqiy6bw6fzZs3oTZ5XJ1FO4VZQc9JvwV9Wb9SgO
	5utC6d1MQZZB6Hm4oQjgWNM0WX5cMTcVQv2wcoAZ8jMbG5f+Ki55juzNyNrDHkqWWzSiZs
	Vc17yIkHIjW6N1k2KbGKWjv9UygqTrTIfiqWCFI4fGyQNOit9wG1zAVGDPxuAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794232978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IFgMuSamtCGf6cM8viFLNQK7HTuhKxaxt4FU0NAK/Q=;
	b=RNG7T3a2TJPYh9Q314qHXZ8OKrpP/yqnPydgxZ/CYtubw46fJAX+umi6eT3ub/1dByV3MU
	ijTbRkwK4zAuU6Cw==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Resend pending interrupts after handle_simple_irq()
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261101101635.270221-1-thnkslprpt@gmail.com>
References: <20261101101635.270221-1-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179423297601.2093942.3253583766812995270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1aed0e209f0c3bb1f28d4d69c2fc23528d30981e
Gitweb:        https://git.kernel.org/tip/1aed0e209f0c3bb1f28d4d69c2fc23528d3=
0981e
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Sun, 01 Nov 2026 12:16:35 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 14:59:39 +01:00

genirq: Resend pending interrupts after handle_simple_irq()

Commit 2c9e7f857400 ("genirq: Teach handle_simple_irq() to resend an
in-progress interrupt") sets IRQS_PENDING when an interrupt arrives
while another CPU is handling the IRQ. However, handle_simple_irq()
does not check for the pending interrupt after the initial handling
completes, so no resend is requested and the interrupt remains pending
without being signalled.

Check IRQS_PENDING after handle_irq_event() and request a resend, as
handle_fasteoi_irq() already does.

Fixes: 2c9e7f857400 ("genirq: Teach handle_simple_irq() to resend an in-progr=
ess interrupt")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261101101635.270221-1-thnkslprpt@gmail.com
---
 kernel/irq/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db..4a131dd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -626,6 +626,8 @@ void handle_simple_irq(struct irq_desc *desc)
=20
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
+	if (unlikely(desc->istate & IRQS_PENDING))
+		check_irq_resend(desc, false);
 }
 EXPORT_SYMBOL_GPL(handle_simple_irq);
=20
