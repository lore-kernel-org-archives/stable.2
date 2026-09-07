Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7D406834;
	Mon,  7 Sep 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764204; cv=none; b=aJpU+wbrc3TDcfXnUYsD51+V6EiwQMaY746RCKYY9rKIwogqe0kZXkFgA5FUmcoEyHSsEbIugMgtphtEzWhO2nIzFHTFQX/pLDkBD/LujzpxYd+RKcZF25seqnPN+AZytMlChrRv+7CMN4houIvmYBDq4n90JGO7nPXS9NjBvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764204; c=relaxed/simple;
	bh=/wkMVvADfANsF88IfEhps+ta/Rq2LjzqGVcIwAnw4VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqXZSsoCNpGVUUtFgaGGAw7fMP2xTzz6I51XJcxVZOHczF1WlFJJ3uJbxePcISA8mlz9OPoCrE0j/Sv1Zs1/1N92Kkv56iI1vVzSBRQXAb/tSLLFUJ7ZEIECtoJ51tQuQQhVukwieKht+KqjIS2d/QMsvXaoy5vrDKfAPRU28Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct1QvAzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct1QvAzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0F81F00A3A;
	Mon,  7 Sep 2026 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764202;
	bh=/m4zDVNEv3Vemxw3xr7Ub1WP3qAIAIAjBDAXA7mngxA=;
	h=From:To:Cc:Subject:Date;
	b=ct1QvAzZifzGIOuDnC+M19+trfyZXoAmEWMVygurMOj1/pmdGCQlZd1Yaikb2og/9
	 BH0ljSa2UkExdY3yx5ssx+mVygqIDy4ZoQedX3sF0fw676afJisdLII0ww/7yvsbFZ
	 v/3vgDkvr/lsSCPgAn5juRrnDmZC0A/p3FXxVHAB6ZB0yoIwvyghGsJczu/MzdLMbL
	 nhNi39ujCwoUYix05+xBXCJgC9ZAbcvmW+b3Og8uohhA7vBq632wsA22BF1grSm/qi
	 nv11Fqlh7/zhvl0arCmkPgOysaG8TOdgGfQzNRzWdIJsYLcZ7WfdDUzozVf9SUQZUq
	 Vok2X/Ehw0oqQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3THU-00000000QJd-1w8c;
	Mon, 07 Sep 2026 08:56:40 +0200
From: Johan Hovold <johan@kernel.org>
To: David Lin <dtwlin@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] staging: greybus: uart: fix racy TIOCMIWAIT implementation
Date: Mon,  7 Sep 2026 08:56:32 +0200
Message-ID: <20260907065632.101144-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wakeup condition needs to be checked after adding the task to the
waitqueue and updating the task state to avoid missing a racing modem
status update or disconnect.

Fixes: e68453ed28c5 ("greybus: uart-gb: now builds, more framework added")
Cc: stable@vger.kernel.org	# 4.9
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/uart.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 24b4dab069c3..bcfea0a02155 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -643,7 +643,10 @@ static int wait_serial_change(struct gb_tty *gb_tty, unsigned long arg)
 	if (!(arg & (TIOCM_DSR | TIOCM_RI | TIOCM_CD)))
 		return -EINVAL;
 
-	do {
+	add_wait_queue(&gb_tty->wioctl, &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&gb_tty->read_lock);
 		old = gb_tty->oldcount;
 		new = gb_tty->iocount;
@@ -657,18 +660,20 @@ static int wait_serial_change(struct gb_tty *gb_tty, unsigned long arg)
 		if ((arg & TIOCM_RI) && (old.rng != new.rng))
 			break;
 
-		add_wait_queue(&gb_tty->wioctl, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		remove_wait_queue(&gb_tty->wioctl, &wait);
 		if (gb_tty->disconnected) {
-			if (arg & TIOCM_CD)
-				break;
 			retval = -ENODEV;
-		} else if (signal_pending(current)) {
+			break;
+		}
+
+		schedule();
+
+		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
+			break;
 		}
-	} while (!retval);
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&gb_tty->wioctl, &wait);
 
 	return retval;
 }
-- 
2.55.0

