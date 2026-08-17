Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0037B012;
	Mon, 17 Aug 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990997; cv=none; b=OOJEpDql95QUEuBrvjCQ3WTA+zRSQceQ4/MRpiOh3MMCivXBKFGD2wRGzY1ev5irQgNMxp4P7sU1jhayIcaRgSNdIIhof3uXIxta/ajay+ynDC39S64b/42V9H0fzsihHqDPHJ1eu7qSJTXKqHpUeMwRfB6ZJYMiBJjshwubgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990997; c=relaxed/simple;
	bh=2bMHlIscTGYaXERazCnrdjlYA/91AAbUKHMMbmOXA0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fzrz56X3wAP0XVUYzuqHdt4M60vDNNHLVu0NtE3j7B4PZiBIRmrj5NN69TgK45dp1mDQThvH6fpfzkXSSqrzBPGXaEIn6ob+0pd7tpikLu4vBO4kSE7pr6rakJ85mYu49REpgFtc7mg6XDOY0ArncT5m+PYtvRFR6LHgIscg2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=F5d6b4kC; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="F5d6b4kC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4007311C2E9;
	Mon, 17 Aug 2026 20:23:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786990986; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=db1Hr6GtgGeEWrhLdGQK8Vw6KYbkanMTqL7CzgrrjMM=;
	b=F5d6b4kCLhfbp55Jy+fuZBacmQASu6rxf3ymso+Mhq+j+tmy6e9wgkxvkPXxEy07EaAWKQ
	KW6N94QCHOqme/cd4VaPxg80sumsWbbmHzgulCRIjN4xM7K4+QIeaJ6sq/CxxtAt1E22yK
	62mYFfiosqFpby51Fz5TT/lo9HGPS/QQwzCYvXAENtO3gk/UYXgwGzoj9CEH/EhbXJDbyg
	5Z7DLr5J9RgMfOISnj5vvfAdvDKg7W9rAvepcwmdARTpXRSjs4v5mAAI1j/m0JH9pKmB6L
	riFxlqFEgtfJDd4N4UTs46GReUlAmqTsd6MNElqLZyfNdFl0kV22X8yuhbAAKw==
From: Marek Vasut <marex@nabladev.com>
To: linux-usb@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: mux: Fix typec_switch_match()
Date: Mon, 17 Aug 2026 20:22:39 +0200
Message-ID: <20260817182302.146546-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The fwnode_typec_switch_get() sporadically returns NULL instead of an
-EPROBE_DEFER for orientation-switch described in DT. This makes it
impossible to discern whether the DT does describe an orientation-switch
which did not probe yet, or whether the DT does not describe the switch.
This happens with gpio-sbu-mux connected to an I2C GPIO expander.

The class_find_device() on typec_switch_match() may return NULL in case
the mux did not probe just yet early on boot. The sw_devs[] array can be
empty on boot as well. If these two conditions occur, then the conditional
if (to_typec_switch_dev(dev) == sw_devs[i]) evaluates to true and the match
function returns NULL, which propagates to fwnode_typec_switch_get() which
makes it look as if the orientation-switch was not described in DT.

This is incorrect, because the mux driver will probe a bit later on, but
at that point, the caller of fwnode_typec_switch_get() already got the
NULL return value. The NULL return value also does not trigger IS_ERR(),
therefore the caller driver interprets this as if the orientation-switch
is not described in DT, and does not return -EPROBE_DEFER to try again,
even if it should.

Fix this by checking the class_find_device() return value, and return
-EPROBE_DEFER if it is NULL right away. If the return value is not NULL,
perform the deduplication test, and if that test passes, consider the
return value to be already non-NULL.

Fixes: a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switches")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
NOTE: A similar change was reverted in
      f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switches"")
      Maybe the orientation switch commit also needs a revert ?
      Or the mux switch revert can be undone and fixed using this NULL check ?
---
 drivers/usb/typec/mux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 9b908c46bd7df..2bc7e8edb3cbd 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -56,17 +56,19 @@ static void *typec_switch_match(const struct fwnode_handle *fwnode,
 	 * function "defers probe" for now.
 	 */
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
+	if (!dev)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	/* Skip duplicates */
 	for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
 		if (to_typec_switch_dev(dev) == sw_devs[i]) {
 			put_device(dev);
 			return NULL;
 		}
 
-	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
+	return to_typec_switch_dev(dev);
 }
 
 /**
  * fwnode_typec_switch_get - Find USB Type-C orientation switch
-- 
2.53.0

