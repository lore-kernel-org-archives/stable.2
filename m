Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C62B9BA;
	Fri, 31 Jul 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507471; cv=none; b=uND7i/lbElKeO4cQ9tKBD1O/I19lB082T3HgJdAOiojLOZFQWsb5alJD2ewPjhHXrUlcugeD94uYCRnsmpNesRhnYkPv5x5PstqugF5XQVbf9X3q/DBl4gNUIwJAEjiWMv2K89rwBE3gwxyejnunS01eaTTnzoc1AW66Kbgu3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507471; c=relaxed/simple;
	bh=oTQDB5XBEanfZPYHFTwG/Jk8Hy1Nqm47Cbz6/JibOoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HAKNb8dvv+q3QCH/ALK7aJSg/QaXpe8a8gqA4S8knuxvsAVGEwCmHMsogPWYfJak6PTBcKUih8ZosU4sRYXVKcqMxb+wz66JvQLrHW0AkMp0orjBVfZXqYMaue524lrf5xi5doiEJtlprh0ehOIROYMN/ocZFFiBuXsTMnG2xEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVGXa4FO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZjyU6ESY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVGXa4FO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZjyU6ESY"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785507466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NaY6hPBiUnqU3OPqo+LBf6yjDwHQ/NodAieL9IwlhF4=;
	b=LVGXa4FOpeJp8Nlwue6ITwDY2YBgoTRjYzH3fAYTxeqHyb/Iv81EUQ8wBuvdh0ya/zDOKv
	X+pk+jsnLc43Z6cWu+vSgHHrjOXksZ3Jkdqtgs3PEDKcnvhEItackr8COfb6LRLyoel3Vq
	xw+zs2K8GpLBmqH9iZ5ALM+J3CuASENqpa6eyY0rJWOOeAiVJrDCyQdE/2Ao5CUgOM4xzJ
	izjpm87Kq2U5BEr4A+n+9yWuzcZbuSg5oOmiggGubMpg2xLMjFYEF96JNJsyXtCJSue7vl
	ZFAc6VTogc2VMrzJnmN+tRlBAh8GINppxrYyxFYskwaU79TvYZxo4M+u/9TkXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785507466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NaY6hPBiUnqU3OPqo+LBf6yjDwHQ/NodAieL9IwlhF4=;
	b=ZjyU6ESYcMGuCJA+6BYDPIqeKy9wbLpQ+cvjttFe3NcuVamgwXob4DcaSekAD+bZibKNjU
	PLV5ySFlr607tPAw==
Date: Fri, 31 Jul 2026 16:17:43 +0200
Subject: [PATCH] timekeeping: Check the return value of tk_get_aux_ts64 in
 __do_adjtimex()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-timekeeping-aux-adjtimex-return-v1-1-b7fea4692886@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NzQ6CMBAGX4Xs2U1qjfXnVQyHVb7iaqxkC6YJ4
 d0tHGcOMzNlmCLTtZnJ8NOs31Rhv2vo8ZTUg7WrTN754E4Hx6N+8AYGTT3LVFi616oKG8bJEp/
 v7igSLiH6SLUyGKKW7XBrl+UPAhLjRnEAAAA=
X-Change-ID: 20260730-timekeeping-aux-adjtimex-return-8b05aa696f2f
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785507465; l=1523;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=oTQDB5XBEanfZPYHFTwG/Jk8Hy1Nqm47Cbz6/JibOoY=;
 b=pr33klYNZxywvtTk3t5J17OUAWwPIUU3KSmZdFzO2YlK4wFHCkv/ll6ixzhm2dKZhgXXg7zZF
 iE1DltXB7hgAm9lI3sjXlh3LR7uJW3m0jDJyWsfq0ra33ePbwd9rhGB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If the auxiliary clock is disabled during tk_get_aux_ts64() but is
enabled before tks->clock_valid is checked, then uninitialized stackdata
will be used in the calculations and indirectly leaked to userspace.

The same race window also exists after this change and also for the
core timekeeper. But in these cases the only effect would be incorrect
adjustments and this is userspace's responsibility to avoid this.

Fixes: 4eca49d0b621 ("timekeeping: Prepare do_adtimex() for auxiliary clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/timekeeping.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 97db2e9393f9..15ac0c3df3b5 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3021,10 +3021,12 @@ static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	if (!aux_clock)
+	if (!aux_clock) {
 		ktime_get_real_ts64(&ts);
-	else
-		tk_get_aux_ts64(tkd->timekeeper.id, &ts);
+	} else {
+		if (!tk_get_aux_ts64(tkd->timekeeper.id, &ts))
+			return -ENODEV;
+	}
 
 	add_device_randomness(&ts, sizeof(ts));
 

---
base-commit: ecc330e3096173f433659aa64ab3674d0d48440e
change-id: 20260730-timekeeping-aux-adjtimex-return-8b05aa696f2f

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

