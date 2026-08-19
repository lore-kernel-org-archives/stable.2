Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825823B8D79
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152846; cv=none; b=T0UNA01AVK6XctnwmjZuTWfL4O540u/XQgsdZ0M4/9pPew9lAcXpbsQu7f6nOBI+2eVu1k0zSiiSjP+wKlDas+IWgfkQjYyu0zcJx9MiUhQ9FBMLm1rqCZp2csDIfiOdMfXKG1B53k8CjmxSYymRCgsKwsKtV2N12FuAif1s/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152846; c=relaxed/simple;
	bh=NktYR13aQGEZKI3EO5FCbGzBjpVy+3k0GIvRZjmI+vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1/EHnl1NNSf1CI2YdOP6Rhd5p8aOl94eNZh75RjhwVZkgnyLj9IScDlrb+OBsErVu2feTLOKgiMVBc8+hQFTKBjkBYZ34jjbIJlBxxTwbemOmPhKEcr+W7q3Kjzu6zzeQOBZF20uQdP+NNLqLeCPiKMqaA30bLYkSalP19BXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd6iIWOz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd6iIWOz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ced3386430so10021245ad.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787152845; x=1787757645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWrkfvF0AtjljV0m6J5emA4PqOIDBL9kVxpQPrwf6n0=;
        b=Dd6iIWOzy3GbggjuL47hl2sDCZumb4GQnaXyWMYEOvVlcEu+3b+/G+/jTz7EOE7T6Z
         7XHQFcQGqvAJxq7zUFbOSUfyQvNXTXlnOIdpTCCYe8/XDIrD179TQp/1uItGVDm5G0VU
         yjcC+rI8JjhFpRoiozaq9+EX5/EcUTGKtbalbnNGLi8g9ciV5NtCzp1VUj4SAB+Ow44R
         w3/ZVmlTawrvTDnFyi8KtY6w+2+GMtysUMpSdfpFfJvy2eDdUGquI4rdIAeERtaM3Jdy
         2aLIvTBbVXVsC6KB8tob9hH0NRazxltYp/O+hB2W85uS/NhTRnS3p1QaCGTJPrqOdvs7
         Sxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152845; x=1787757645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWrkfvF0AtjljV0m6J5emA4PqOIDBL9kVxpQPrwf6n0=;
        b=FmFnD90h/0oa+7OThkgDdvwv77CTjUnkdC++Qz5iMtVQzA2JzZehFO6NVo0vjggz5f
         /xyA4bgu8JdNDYPr40MEUhtbHuFjK2q6QvEc96/mPcENNQJbpgiwzp+mi2LYY/7kUBHE
         WWkSYDPJ4gmEjd/fADvE+fARSLQ8v27NIPXsgJ6sKzPg4d3wa+0suJp9AGM1wXhp8nZ6
         LkbkcDOBqPuFduG+IknlMZEvOCtfjiaBC4f3sN3AC7bAwjGIeMsXv0abHCLxoEWh9LvE
         NTgolFNWZ5Z2mrk8WluDslo36kddT2VrphKnHOmNuR9rXrSPzJLYNmfxrxuSdy5RW5WP
         6LeA==
X-Forwarded-Encrypted: i=1; AHgh+RoOLFq8UndyH3WQaGRtSxGbgXqOp3xBTBbhXgHq6HYD9t7cs18vUa8ypUe35fBN+maCX6orR5o=@vger.kernel.org
X-Gm-Message-State: AFuF++kbMKSPVxpX3tB8DeT8PvOGEKlPWaBRuuuX9fo+XFbeFqFMkSUL
	aoxEu/vVryYzb45uhxDMo0/LG/Q6dyAKXNereCQRAsPzQ1amiHopeop7
X-Gm-Gg: AR+sD10cuoJwCMQsjLQ+NNwmb5PTc99t9nw7eF3eclIEcMAijw2tiLH8sCRXNcTiD3z
	ys9eDR8E1n/IpRcS+efxO72ARVZqWyjRB0OA8NrTV9WJYSIHylpG+aB/C4RS90hp5s9azJAAd3X
	EWlD1CeFHKUv4GBUf63jraymljG3JyL44yaaEzNv08pWDOvcnXt71GTBoWHYX7pki9zzRgTXySA
	+wyHxCRqC36KomKJGU9/5v9s8WFrnR8kG8OOcjbFaGorEEEnbEdHF4MfuSCT5as9EGw3PPYaPMj
	ZT/RzNSK4jdVeyM9N2dIiMaN7AIJ61IIjzG0PZJQHMh0resRShXXrwic/xZ15SwlAQCZs977PYW
	ODfUrd3Mh9FFuhJbYe0cGTonO0t38zF/f62cVRYB/cahpEGQFebyIUEsGzHzPioUu1VR0CRUEGm
	mKktGKW/ajaUBp0FWm27LVhmnTp1WujuGyhJezex5UV0k7gdQmU9EIuusVNZc5GX4hy16hoN+h3
	oWYJg==
X-Received: by 2002:a17:903:1987:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d601a8baf8mr98123875ad.13.1787152843091;
        Wed, 19 Aug 2026 08:20:43 -0700 (PDT)
Received: from localhost.localdomain ([188.253.118.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ecb1c1sm27294945ad.66.2026.08.19.08.20.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 08:20:42 -0700 (PDT)
From: Chang Wu <kunjinkao.jp@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jan Remmet <j.remmet@phytec.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chang Wu <kunjinkao.jp@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: hd3ss3220: track VBUS enable state per consumer
Date: Wed, 19 Aug 2026 23:20:27 +0800
Message-ID: <20260819152027.90994-1-kunjinkao.jp@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regulator_is_enabled() reports the aggregate regulator state, not
whether this consumer holds an enable reference. If another consumer
enables VBUS first, the driver can skip its own regulator_enable() call
and later attempt to drop a reference it never acquired, triggering an
unbalanced regulator disable warning.

Track successful enable and disable calls locally. Keep the state
unchanged when an operation fails so a later role or ID notification
retries the operation while this consumer keeps balanced references.

Fixes: b3f9d6e491fd ("usb: typec: hd3ss3220: Check if regulator needs to be switched")
Cc: stable@vger.kernel.org
Link: https://github.com/qualcomm-linux/kernel/issues/472
Signed-off-by: Chang Wu <kunjinkao.jp@gmail.com>
---
Testing:
- scripts/checkpatch.pl --strict: passed
- Qualcomm CI checkpatch, sparse, DT and UAPI checks: passed
- Not tested on hardware

 drivers/usb/typec/hd3ss3220.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index d0de5a2488f9..4eec90c82bae 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -62,6 +62,7 @@ struct hd3ss3220 {
 	int id_irq;
 
 	struct regulator *vbus;
+	bool vbus_enabled;
 };
 
 static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
@@ -208,7 +209,7 @@ static void hd3ss3220_regulator_control(struct hd3ss3220 *hd3ss3220, bool on)
 {
 	int ret;
 
-	if (regulator_is_enabled(hd3ss3220->vbus) == on)
+	if (hd3ss3220->vbus_enabled == on)
 		return;
 
 	if (on)
@@ -216,9 +217,13 @@ static void hd3ss3220_regulator_control(struct hd3ss3220 *hd3ss3220, bool on)
 	else
 		ret = regulator_disable(hd3ss3220->vbus);
 
-	if (ret)
+	if (ret) {
 		dev_err(hd3ss3220->dev,
 			"vbus regulator %s failed: %d\n", on ? "enable" : "disable", ret);
+		return;
+	}
+
+	hd3ss3220->vbus_enabled = on;
 }
 
 static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)

base-commit: e1e6e541c5c9cf548e9fdc35fc26808c82074440
-- 
2.48.0
