Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C103FC5CD;
	Mon,  7 Sep 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764110; cv=none; b=DNO0eLoiYbJuSYY+o+IPRcWKQvX4El5JiqrCpHz5OdbsIE5eEyJNinE0ekrRuHzoL69j8WzrXp1AG7Iu09SDIpw5+/8lMk2XD1RFD9Vb7H1rDi18jF2VLQVGeVEPfm8T/CMLpLnyrSaV0mFuayxOlFE3Qe1cadOo7eqR5eWJVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764110; c=relaxed/simple;
	bh=FDd9iNROPo2O6FFUpxCZ/QST69zsS6w6Lv2RZJ7NhuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+hWmJhk+LmAGtje4EVogSiO69ur7j7SzkOQjxHWNfT60tB9eMZN4kiWQgNmhc9znSNi8wdjY2sOtnhZfveZe6RG5dxuzXpO9MSbDdM6rlTbE1zu5nUL2evqyoVvWSsNtQ2+ESNhvlqplj2jLnR70DwgWwDw4NK8gtMQyO6DTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLBjP0hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLBjP0hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332011F00A3A;
	Mon,  7 Sep 2026 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764109;
	bh=z/odk7UzIyLnh0EQGkgHHAaaVYkrwkV+zN1HVD25i4g=;
	h=From:To:Cc:Subject:Date;
	b=PLBjP0hrEhrQylxE8HkDg1ifceeh/601zofBojTkXVN3CPhnd2+y8vceDDHIu8kKH
	 Hko0T8hbdKLieq2gBJQVUE+Xc0YvYGfsBW7TaR3jd6ZfrOFmzqgRdv/qNOFFd7fRxP
	 KpORkQZGbAL1eBHFWmjLALwGQu1qzT72yTAfL7eeFgDzgOriZjh5wwd0MmCVk3JT7S
	 SVY0u3bqtW9kt0xPdfFwGV7XA5KarDpvKsmh6DSxgJ3jZBk/F/ITjh4RftkW/acCAF
	 iK9ffTOpum+onQjS1GzYvU5vaHopIWNN85snIcvMdgu5pl5+m+WX39kICHfcFisE4U
	 SEfstFRbyyfOg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3TFz-00000000QHY-02hU;
	Mon, 07 Sep 2026 08:55:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Date: Mon,  7 Sep 2026 08:55:01 +0200
Message-ID: <20260907065501.101013-1-johan@kernel.org>
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

Fixes: 5a6a62bdb925 ("cdc-acm: add TIOCMIWAIT")
Cc: stable@vger.kernel.org	# 3.14
Cc: Oliver Neukum <oneukum@suse.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7bc5329fa3ed..00c250515e83 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1027,7 +1027,10 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 	DECLARE_WAITQUEUE(wait, current);
 	struct async_icount old, new;
 
-	do {
+	add_wait_queue(&acm->wioctl, &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&acm->read_lock);
 		old = acm->oldcount;
 		new = acm->iocount;
@@ -1044,22 +1047,20 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 			old.rng != new.rng)
 			break;
 
-		add_wait_queue(&acm->wioctl, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		remove_wait_queue(&acm->wioctl, &wait);
 		if (acm->disconnected) {
-			if (arg & TIOCM_CD)
-				break;
-			else
-				rv = -ENODEV;
-		} else {
-			if (signal_pending(current))
-				rv = -ERESTARTSYS;
+			rv = -ENODEV;
+			break;
 		}
-	} while (!rv);
 
-	
+		schedule();
+
+		if (signal_pending(current)) {
+			rv = -ERESTARTSYS;
+			break;
+		}
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&acm->wioctl, &wait);
 
 	return rv;
 }
-- 
2.55.0

