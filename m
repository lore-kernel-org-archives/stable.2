Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777B493643;
	Sat, 22 Aug 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787383575; cv=none; b=adIh1JXD1qK01ReHkIicY9YFx08Td6XZ4wRRdQnc+s7dmn0mTtv3CJmnoXhmgT1lBqYKdACigb4QrU3IKUH/BnIT2XQi1nYhtOyZGVPa+XIqKLJolW8xPFTTMB78vyH01lhtA/jDOIMF26Scq1F8J2+gmQDa99jYyjHmFnuLTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787383575; c=relaxed/simple;
	bh=RluNVxEg7IWM2B+Ur2yZcVbPDlgV5C/B8sGJWgXkuj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQSwTmAjy0bePXRMc1W4OmmBnCpL0jWUf0y5KGTh4PKIyBQg90VpGcCB8LLAI3TOdaNV1O2LVWwVPEJTsLZVqk5Uf55N/RskPpwGok72+J5OyY40vETIuDjsvbdRx7fVE/tc4vHB5jwArUKFMu+30qBVlAdejYpWQNpscJ4afq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ipzMv1l/; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ipzMv1l/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B1D511BFED;
	Sat, 22 Aug 2026 09:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787383562; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WYAjApTCgNLybJuzBs8Hml4OJ4opu6klS6+2saBBrx4=;
	b=ipzMv1l/u5iSEZDWONvIdBgVLuENaqZdcIRxvSKOoBPwBVRychRfH3fcUkqmLRlbGoLoZW
	u97S7Fa02zSNAGL3jTTRuSRYNWxCNa5cv6Naf8ZnPW1Qg+HXmzcXWIaEkR+fDG1MnX2xki
	229/Dy3aVyhYy7GcRPdSe7S9/eqaxeQ3D1ZnGdRFbwuqWK/zWuoxqVA/rzJcw7RGjKSgJy
	45GjTlvvlHs2knv4UkwwWAElHCSN1ymW3p2/T8MJU6/zXi7qMaJ9TPQPf39hD/KbLQ/b7d
	DnXibN961znIOvCXTZ/owyNyDuM/7D6/XlJDFn4kCO8NZa0VWgwiqcMXex+PIw==
From: Marek Vasut <marex@nabladev.com>
To: linux-usb@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: mux: avoid duplicated mux switches
Date: Sat, 22 Aug 2026 09:24:58 +0200
Message-ID: <20260822072556.490594-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some devices use combo PHYs (i.e. USB3 + DisplayPort), which also
handle the lane muxing. These PHYs are referenced twice from
the USB-C connector (USB super-speed lines and SBU/AUX lines)
resulting in the mux being configured twice. Avoid this by
dropping duplicates.

This is a re-application of b145c3f29d62 ("usb: typec: mux: avoid
duplicated mux switches"), with fix derived from usb: typec: mux:
Fix typec_switch_match() .

Fixes: f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switches"")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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
- Extensive test by Jens https://lore.kernel.org/all/8bdf6062-8ec2-4c30-8463-0368d3a0f1ce@oldschoolsolutions.biz/
---
 drivers/usb/typec/mux.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 2bc7e8edb3cbd..afa6fc1813978 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -277,7 +277,9 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 static void *typec_mux_match(const struct fwnode_handle *fwnode,
 			     const char *id, void *data)
 {
+	struct typec_mux_dev **mux_devs = data;
 	struct device *dev;
+	int i;
 
 	/*
 	 * Device graph (OF graph) does not give any means to identify the
@@ -292,8 +294,18 @@ static void *typec_mux_match(const struct fwnode_handle *fwnode,
 
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
+	if (!dev)
+		return ERR_PTR(-EPROBE_DEFER);
 
-	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
+	/* Skip duplicates */
+	for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
+		if (to_typec_mux_dev(dev) == mux_devs[i]) {
+			put_device(dev);
+			return NULL;
+		}
+
+
+	return to_typec_mux_dev(dev);
 }
 
 /**
@@ -318,7 +330,8 @@ struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
 		return ERR_PTR(-ENOMEM);
 
 	count = fwnode_connection_find_matches(fwnode, "mode-switch",
-					       NULL, typec_mux_match,
+					       (void **)mux_devs,
+					       typec_mux_match,
 					       (void **)mux_devs,
 					       ARRAY_SIZE(mux_devs));
 	if (count <= 0) {
-- 
2.53.0

