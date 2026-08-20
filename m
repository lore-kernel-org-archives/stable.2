Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B935FF6E;
	Thu, 20 Aug 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237744; cv=none; b=GoLdZZu0Eo4la1c665629/AXpZFWyGbJ/DaknvfKf5HTZWTNYBSIWWaMMdkD96sygqSlAplIMJH2pfubb+MOQ4yL2dc6kr2trDbcdkVWoocogbWIjxGXQsAgTATySh/hYoKKa9m5RdsbQ8s85Cv/PBpFwcOlBeZAQXj9kT9bV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237744; c=relaxed/simple;
	bh=PbU+elOpfjTkVbEZFnnE8odpHIA2v2q13MwBL5SBH2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUqgfMwUWHVk7SE8tjogjG2vtEX79zvpPhZ2t0xTwdjBO9VlwOzr1rL6TReM2YOHiWJqM2oFAMUeKuH4EpK3w2Mvha8leGREXzihlGGEdPdNH2BQWuCdfZqNP8Z5QMaC4ZqSFNWgb+sOvGX/oGbshAk7TOrDuV6FrzacN3ziEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtj7Vao5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtj7Vao5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F311F00A3A;
	Thu, 20 Aug 2026 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237743;
	bh=KVZD0qsq1j+N11IUMNXG1IasgHvReK9xYRuzAdl7f04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xtj7Vao5P1a8UPr0yQxThoUVIpECNWoCkYvziUpZ7rW46LEkBQM72V8hCROYudQpL
	 MBveC6NGb9g5eTsljjyh0hIxGXZzOHpOJCmsOzchDRMV6yjZchZGbWFmieKK05e23J
	 Us6eyg4m4b1mrJujSisMV6CEWas+bRZpLHPOYdTa+ubCcaAdaQg7YS+K1bU0txZJi4
	 O2sgSJ4ATNv3WuLCnvRbJ+ManxL1lnHzY9PV5Lkes+Htwlyfo7nvD8ojlOcys/qxHc
	 RnczEBa88sjddJRN9jFG2O+snvigVoliHRhKzwqb+qufOHK6zf2bTpwIApUtcF9r9m
	 Age54yMx2uxmQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wx4BA-00000001p31-48VO;
	Thu, 20 Aug 2026 16:55:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e5e28c3e953b2eebb16e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] USB: serial: fix port tear down use-after-free
Date: Thu, 20 Aug 2026 16:54:01 +0200
Message-ID: <20260820145402.434447-2-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820145402.434447-1-johan@kernel.org>
References: <20260820145402.434447-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers for multiport devices access port driver data from
completion handlers of shared URBs submitted at attach() or first open()
and stopped at last close() or disconnect(), respectively.

A simple NULL check before accessing the driver data makes sure that a
port state container has at least been allocated, but a completion
handler can still race with port tear down.

Reorder the disconnect handling so that ports are not deregistered (and
their driver data freed) until after all ports have been hung up and the
driver disconnect() callback has run so that all I/O has been stopped.

Fixes: 2d93148ab698 ("USB: serial: fix lifetime and locking problems")
Reported-by: syzbot+e5e28c3e953b2eebb16e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a7e6fb9.ec5dc6cc.21cb3f.00c0.GAE@google.com/
Cc: stable@vger.kernel.org	# 2.6.30
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 17edc057a311..a4fbc849c0fa 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1191,12 +1191,17 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 		usb_serial_port_poison_urbs(port);
 		wake_up_interruptible(&port->port.delta_msr_wait);
 		cancel_work_sync(&port->work);
-		if (device_is_registered(&port->dev))
-			device_del(&port->dev);
 	}
+
 	if (serial->type->disconnect)
 		serial->type->disconnect(serial);
 
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (device_is_registered(&port->dev))
+			device_del(&port->dev);
+	}
+
 	release_sibling(serial, interface);
 
 	/* let the last holder of this object cause it to be cleaned up */
-- 
2.54.0

