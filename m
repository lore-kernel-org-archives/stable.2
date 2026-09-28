Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480536B934
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574141; cv=none; b=a0cqumqJzYFNub1OuMEefBVfqW5a++MIYf/w2bcXyh/I/Mopr24gqMRZKnc2SArMjPDmMywVpk6mS5o3JzL9sJVjcq7cubtsblIG+2/DllU09jMJJdDZ/Akun8U9umLl+/7Blk5ykgkqb9+pmnznjEYAG3n8uDg91uOtY/g2RkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574141; c=relaxed/simple;
	bh=P4Vsh1ZbYRmqZTHpG78i1hS07HrZhfBOCO4NGcvEKEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQrzs8XcS2sFSmgIoBiIjFm6KvJP1QLpBQKtspWaaRfNsao/ZI80RdG+QL9D3ahB8bGlGPFvJNbdtRQTr+Ml6xNsNgU6DxH1yqlnS2XgaER1aEHr+lknjg3AhzN2OLS92aftNOG/fGZg2jHTIxnYS4EG2CHPintyJeboINnLVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQO2F5yT; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQO2F5yT"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910704e63a9so10522526d6.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790574134; x=1791178934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzHcf3s12a0U+VG6RoG8MbFaU5doXW0O9eGxG+zaczo=;
        b=mQO2F5yTdyfhIFkcdNNKa5dbbRlvVGKsqP0fX9jBq/RPLK2yRb6sEMXqGr8s4WU1tk
         Na4wlMH/tpEbehJlh972pTZNinOqQujMV5Rh0tXrAxu2Dk15xgeNmwgByJ8rgfSQTYCe
         9lKHZlhmkl1flouTJGrFrE7UBmhL3gFT8iJVyaIDWQnK9VRFtaR8Cv+aGGJ61H3xqDbY
         5ADVuGn9/Qd4DZw0G1taal/KtU4TdxmeXVYPcvTdqMvYgRg57CAueuETlpyWIfB6MKCh
         V0iULfIEs4pXu60cV+lX3BUl/6/k+VEKRIjbBeKvshB+OjbCobyxVcGFBdvTp+KSRfme
         6R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790574134; x=1791178934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzHcf3s12a0U+VG6RoG8MbFaU5doXW0O9eGxG+zaczo=;
        b=h91vJPV/GSM6rB80YBxomnQGI2AIgTZsbWCzFmAbGUDgHEpzGhqaWedGxpXRu211oo
         xVOlPu94DBdpczQA/WJXl1Xm/UZbQDXLFkHTMGf4UNdfB9ZyCPNJQ0ZkUQwsqsAej/L4
         UR9HGJu6UJD8u+9U5dPaw4ZTez7aDCWNZb7+L+Wf3fJTiuZhKO/NB2vteAYZR96Sa8l1
         3mL8nSD0xnOSldd6lyN+OP7SPfti0CB9OZIDykUgFf7cxWBdzJzs5YmiOyLLUqFz9ZrE
         N0lf4Yd7dnIg+0FgzhyPhIEgnWSoKCTifmBP+XUpCZaa0Fl+JURjsu/ArEDp5wPtCzJL
         /gOQ==
X-Forwarded-Encrypted: i=1; AKwUvByCfUCpTIPb4Cw4yRRI5Cbqp3Yo9bRVuLRR31/9KWUzdWPgLz6aTXt1iG2Ju+uN2EcvS/nGEWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwYXd9JkMLS58dmdlMunsDXqe+ndTyvN18l3FdfUOKlXru9zMh
	MHGA+wrDs/Fm4e/b21WA4GOQw9SJrQVGlGEcI8x7uAIhTzaGX9s7PaEH
X-Gm-Gg: AYBFou3kcGNYTPGYS3T98SvD/q8V7AuJ2FvTXVV9/FEAoUJ7Abpp+MSOlA/LIYm2adz
	QBOgCFkqulaRmNl5qr6seRTXUj1rIrxYtsvOzmVXwAAuts3Cp6rys/p0c4JDESdd8I2zFSJ6BJN
	0fHevRrZfBuxyenFR9VVjFIp8jjdf5WBauPeTrUs0SYGGwE4BxRIhwWBpWQ25wSKiQPjPpupZto
	ReF9Pa8S/SqB8u9T/Ed93tC21DTa+TnkudiamdsUh3CE1L1lkboTNuKwAsDV0MoEKREPpT85+jT
	sza5w/PByv3XkV21lX0DR+ppvY2jIneYPm/OZplAvDSyxU0gSEjpqFhtmb0zMn1GVhecCQw/+kh
	/5Vn7fGlBVapJY2aB72Y6pbd0YbadU2zBye9S02YLxOxtSf1OYA4YOVr73c5NoeuAPKIR59qLQj
	DT9fPhjoixCOV/dtyN+WxWP1JlbFX5xzDGsSam/EGyRY9/ic2K2vLIwpa4gTX9IPc70h2oZv6Oh
	I9g3/OEAwCzIrwmvgrMllQaJqqTK+kNz1wKAw==
X-Received: by 2002:a05:6214:319b:b0:914:4fc3:e85d with SMTP id 6a1803df08f44-9144fc3f607mr102677316d6.4.1790574134183;
        Sun, 27 Sep 2026 22:42:14 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.192.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dd1b90sm73359066d6.22.2026.09.27.22.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:42:12 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pooja Katiyar <pooja.katiyar@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Johan Hovold <johan@kernel.org>,
	Ajay Gupta <ajayg@nvidia.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seungjin Bae <eeodqql09@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response
Date: Mon, 28 Sep 2026 01:38:01 -0400
Message-ID: <20260928053759.533956-3-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

When the PPM reports more than one DisplayPort alternate mode for a
connector, ucsi_ccg_update_altmodes() merges them into a single entry
in uc->updated[] and sets uc->has_multiple_dp. In that case,
ucsi_ccg_update_get_current_cam_cmd() rewrites the response of the
GET_CURRENT_CAM command. The response is a single byte holding the
index of the currently active alternate mode, and it is provided by
the PPM firmware.

The function uses this byte directly as an index into uc->orig[], and
then uses the linked_idx read from that entry as the translated index
into uc->updated[]. Both arrays have UCSI_MAX_ALTMODES entries, but
neither index is checked against that size.

If a malicious or buggy PPM reports a value of UCSI_MAX_ALTMODES or
larger, e.g. 0xFF, uc->orig[cam].linked_idx reads over the end of
uc->orig[]. The byte read from there is then used as the index for
writing cam into uc->updated[new_cam].active_idx, so the out-of-bounds
read is followed by an out-of-bounds write. This happens without any
userspace action, since the UCSI core issues GET_CURRENT_CAM on its own
when handling connector changes.

Fix this by ignoring responses whose index is out of range and leaving
the original value in place. The UCSI core only uses the value as an
index into con->port_altmode[] when it is below UCSI_MAX_ALTMODES, and
otherwise treats it as no active alternate mode. Also check linked_idx
before using it as an index, so that the write into uc->updated[] is
always within bounds.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Cc: stable@vger.kernel.org
Reported-by: Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
The issue was found through code audit and was reported privately,
so there is no public report to link to.

 drivers/usb/typec/ucsi/ucsi_ccg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 91c2958a708c..4d1166c20639 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -389,7 +389,13 @@ static void ucsi_ccg_update_get_current_cam_cmd(struct ucsi_ccg *uc, u8 *data)
 	u8 cam, new_cam;
 
 	cam = data[0];
+	if (cam >= UCSI_MAX_ALTMODES)
+		return;
+
 	new_cam = uc->orig[cam].linked_idx;
+	if (new_cam >= UCSI_MAX_ALTMODES)
+		return;
+
 	uc->updated[new_cam].active_idx = cam;
 	data[0] = new_cam;
 }
-- 
2.43.0

