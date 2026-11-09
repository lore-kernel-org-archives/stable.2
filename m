Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232981;
	b=4PAuKlXAp0e6lR8SG9lFxid6yQGMw3TPa+Um0Tn4cjfEIiRBoYMb4p+ZWylClmokuTnH
	 lv6qo9GYcd+9qdqld8D/28V6SbZ2VEeaZ8gLM5FECzkQ28CPYvIDePVU71yaZwB9JU+hf
	 IaDNe4nUlgsWGXtgBHF1hk0Pyw6ouuKocZgCnIYRb6pgngB5cEGaFkFCeSMCL7h/FhZjN
	 8aeFbAqe6aLNLLVgY6LFGaexBb7shXVqmoWOQ/M4EkpcLBxRIYhUEt4NuipfIQ/FbgYvj
	 ipa5EJP1jbUebD0XEC7QHOW4YVlkPkPSyX6yQMElcT4T3GFtcA1snVI5qwFpqP8/9Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232981;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=/wZaGJR7Mv8C0oFPRANDNKg3ptxz8mbh24FxUb/IyHE=;
	b=Lgmjk4HSfgj3C9hVPOXy+/QFczAnxryT2Nz7A+ip5BJqaKj+CFSfAxoVBGUjNvn0/aw0
	 5QmUrfAD6RSctgxEdJssSWwMXmABVzPcfOZOkC2BOq58ZVFpO5xPvHQhBNiaSOqo4smkY
	 ZByQ1gBB99CggKZ38FBmOHna43zW/gAv+BT8ViOVpmIkkGb/ESX8D9/FbrZqPdbSCMW8n
	 ILc3IqTtytHy2jTpO9BUFDNZ8WlvqU4jLKYZBg2aw3TGRPlNzL+qlb6UabKwg1F+5xfT+
	 QrP7PzdibGe80dp+O/ReLHMn3UO1joU7ONnyC9QdkTGRfiaOM13tyfo/qDxzw9DgNXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="m9ANW4L/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uKN5liah;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D08606A322;
	Mon,  9 Nov 2026 14:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D08606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=m9ANW4L/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uKN5liah
Date: Mon, 09 Nov 2026 14:02:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794232979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wZaGJR7Mv8C0oFPRANDNKg3ptxz8mbh24FxUb/IyHE=;
	b=m9ANW4L/fkEmx9KtItFuYlyDPL9p82A05SwhH6fNCwBL1CMSVgYMy0ujEvEG1eVpjhINnF
	DrHNHaYUSjW/hmK5p+863dvtiL2xCA4KOsZK7ReifitJeYuAb9AVD06c+PGuBu7zQWdRRG
	uP5susOpZOhU1cmhdmdom9qGj9APxALDHUvH0I/P5r0wL7f5u7W4EUyhZWxuFH2iig+M1a
	rmJaUhgtFN9UdE7u71A95Xo9muxytH2FMAGoDgDZc2V5bDAmnUi/mdt+e2XlNjkochyyOW
	f271pe/CMOC7kRjs42SBlMZR2XxTd91qU0y3YHfQg04sd35hsdQbuZcSTjlQmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794232979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wZaGJR7Mv8C0oFPRANDNKg3ptxz8mbh24FxUb/IyHE=;
	b=uKN5liahxi10Ep4ZmtW5d27IFe0OIMv6P3UOe9U00JwKKqFVrNtPUtaPaPfYHbepKXltGA
	BDXAEr8ZlIUHT3Aw==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/matrix: Update availability for offline
 managed IRQ changes
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261025164045.2513933-2-thnkslprpt@gmail.com>
References: <20261025164045.2513933-2-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179423297780.2093942.15095289769443065495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c3f7de51aac3f5b7a369222acb06509922268feb
Gitweb:        https://git.kernel.org/tip/c3f7de51aac3f5b7a369222acb065099222=
68feb
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Sun, 25 Oct 2026 18:40:46 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 14:59:39 +01:00

genirq/matrix: Update availability for offline managed IRQ changes

The IRQ matrix caches available vectors after a CPU's first online
transition. Managed IRQ reservations can be added or removed while
the CPU is offline, but irq_matrix_reserve_managed() and
irq_matrix_remove_managed() only update cm->available for online CPUs.

When the CPU comes back online, irq_matrix_online() adds the stale
count to m->global_available, causing vector availability to be
overestimated (or potentially underestimated).

Update cm->available whenever the CPU matrix has been initialized,
regardless of its online state. Continue updating global availability
only for online CPUs, leaving first-time initialization to account
for existing reservations.

Fixes: 651ca2c00405 ("genirq/matrix: Handle CPU offlining proper")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261025164045.2513933-2-thnkslprpt@gmail.com
---
 kernel/irq/matrix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index faafb43..5a6adf8 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -225,10 +225,10 @@ int irq_matrix_reserve_managed(struct irq_matrix *m, co=
nst struct cpumask *msk)
 		if (bit >=3D m->alloc_end)
 			goto cleanup;
 		cm->managed++;
-		if (cm->online) {
+		if (cm->initialized)
 			cm->available--;
+		if (cm->online)
 			m->global_available--;
-		}
 		trace_irq_matrix_reserve_managed(bit, cpu, m, cm);
 	}
 	return 0;
@@ -275,10 +275,10 @@ void irq_matrix_remove_managed(struct irq_matrix *m, co=
nst struct cpumask *msk)
 		clear_bit(bit, cm->managed_map);
=20
 		cm->managed--;
-		if (cm->online) {
+		if (cm->initialized)
 			cm->available++;
+		if (cm->online)
 			m->global_available++;
-		}
 		trace_irq_matrix_remove_managed(bit, cpu, m, cm);
 	}
 }
