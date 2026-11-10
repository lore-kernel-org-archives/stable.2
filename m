Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318991;
	b=aitgPicU/1YL2t/wNxNx8eQsyqdVYNkxT+VxyHM3iYUWG97fJfUkOaWO7rvy8HzBKp+Y
	 bC4VitZYcdXwunPsaA+/aUOE0zoP04iRvQZsi06ZfbkBegpN6ovcIezTs0gw/rAHvx9hl
	 o4AY3LZgsx8QwPWlpP8OuD/ozTiU7kbrZ8scG4FWexRm4yqb7N8GR8OwqRAwpUMAdtCx0
	 6OD5quzrhy0Vx3GD/Q8NuEyiYQO66Rb9yJx+GVRxbrY7saNeaAwkYK8p6SAOOCPN5S8bE
	 1F7vvAiR5XVmzkeaVrWGopvxIWyV4PJpODuXKX2zrnwkluHmpuxByBPqO8kzzu804uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=duEhHjhxgY4c8ZsSQxGT9H6ZgZ3XEUDZq61yZDTU4U4=;
	b=2qdEZ+9pN+t5/bcdt4xeneVZqKaJwbGIP/5QPs8xLPaiprnVLfy9uPAHdqtH4+73YboA
	 y5HhHCZOM+C/zmZ5yDYdtUFTMFNFmMnV6EbOuS4JFO19qkHO8GqDutuVl0MUQafyDFq7k
	 PI4xGMt+I/D8p9PAM9SEmrtucy1dOlJJltskjiluSJDrPgsvHELfZeRYFiOWMl4O6QTVI
	 6wqklMrsXBV/pryT43r2gYUb6KmEP330hzEStS90PDjhVkvRxd7KNldllu8LmGQur8X2d
	 BIRzlzJjFZa+ZHeQ0tqQ8ZLXfWWT4YXv/kOTiQfrX1+iyzCs4wiSkHuhBIiv/FsiZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iy3SGRyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE04606A321;
	Tue, 10 Nov 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iy3SGRyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE01F008A1;
	Tue, 10 Nov 2026 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318990;
	bh=duEhHjhxgY4c8ZsSQxGT9H6ZgZ3XEUDZq61yZDTU4U4=;
	h=From:To:Cc:Subject:Date;
	b=iy3SGRyShCIF+fW/R2eLwxRaxAeGxJAFoH7NQgVazClhCYkyvtYXUeX1dPtbGz/A9
	 N81oZ1inZqtTB6JcxQixWF/l7NsdYdTfHTMGb9zlyBlMJC3ZzsVHpG4c+Om9g7JD3q
	 5DqJmbEN5LfpEhoVylbZJGKF0U3Z90W6miKE2TOT2LOwahHy3yDY9VDvgGpqR7oXBb
	 PkFnb8N4DC34zWshK4EsT8lvO8KrgFfjjUf5HnG7eXU1s8IVGUm4+FWNcAFbO2lQDp
	 l4JaPAPH01+JtnTUXo8YAHD4zlMmTDm2Pew47rdef9NZ2+tsaclzG1uuzAjJqidfX8
	 vdv2v8C6tHt8A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libahci: Stop the SW activity blink timers on port suspend
Date: Tue, 10 Nov 2026 14:56:16 +0100
Message-ID: <20261110135615.291884-2-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816; i=cassel@kernel.org; h=from:subject; bh=JKpTqheUxKNR0fEVFvHLG55dyTXCDIKx/7OgTnTk+EQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLI+K9VrpX/b+qHn+4rkBu6oDxY5ckU/XqUF3+6pPX7tg oXY4/a/HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIzFdGhuPvL0bO0Opoer+v Zomb0I2V9xffuJN54rbjN93Foms5kjUY/inP/lb/bzfH3t8GX5kPzvc5tzSN5f08w5q+61c3aGc t3s8PAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The SW activity blink timers are not stopped when a port is suspended.
Every command goes through ahci_qc_issue() -> ahci_sw_activity(), so
with SW activity enabled, a blink timer can still be pending when
ahci_port_suspend() runs, e.g. armed by the commands issued just before
it, and ahci_sw_activity_blink() re-arms it as long as there was
activity.

If the timer fires while the port is suspended, ahci_sw_activity_blink()
-> ahci_transmit_led_message() -> ahci_rpm_get_port() calls
pm_runtime_get_sync() from timer softirq context, and the EM registers
of a suspended controller get written. If the port is resumed while the
timer is still pending, ahci_port_resume() -> ahci_start_port() ->
ahci_init_sw_activity() calls timer_setup() on a timer that is still
queued in the timer wheel, corrupting it.

Stop the timers in ahci_port_suspend(). Use timer_delete_sync() rather
than timer_shutdown_sync(): the timers are only stopped until the port
is resumed, while timer_shutdown_sync() is meant for timers that are
torn down for good.

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Developed with the assistance of an LLM.

Tested in QEMU (q35, KVM) with KASAN, UBSAN, DEBUG_OBJECTS_TIMERS and
lockdep, using TEST-ONLY hooks: one fakes enclosure management (QEMU's
AHCI has none), the other arms the blink timer as ahci_qc_issue() does
and then calls ->port_suspend() and ->port_resume() back to back, while
the timer is still pending.

  unpatched                              patched
  ODEBUG: init active ... timer_list     no warnings,
  hint: ahci_sw_activity_blink,          I/O after resume works
  from ahci_port_resume()

The timer firing while the port is suspended is not covered, as the
fake EM support never reaches ahci_rpm_get_port().

 drivers/ata/libahci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ef760d81d1d1..2e71ba7ea374 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2491,8 +2491,21 @@ static void ahci_handle_s2idle(struct ata_port *ap)
 
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
+	struct ahci_port_priv *pp = ap->private_data;
 	const char *emsg = NULL;
-	int rc;
+	int rc, i;
+
+	/*
+	 * Stop the SW activity blink timers, so that they cannot fire while
+	 * the port is suspended. ahci_init_sw_activity() sets them up again
+	 * on resume.
+	 */
+	for (i = 0; i < EM_MAX_SLOTS; i++) {
+		struct ahci_em_priv *emp = &pp->em_priv[i];
+
+		if (emp->timer.function)
+			timer_delete_sync(&emp->timer);
+	}
 
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc == 0)
-- 
2.56.0

