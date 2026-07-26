Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE374288C0E
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077440; cv=none; b=i8U57W9LEhq9OJRyYupa4+WKQ7yGKntYqEjehA9tUXlmidT7e2xOkGGx5K33Ca3eXtcU6F27uvI2qQZuOtVZoB+9/BdFWJhrrHAWXmkBrYdp7l6X+PRaUUr7K0Lof0L4yE6iNFMkxkXs74k47iAPOwpHk9ZnY/Km6vO5ETreaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077440; c=relaxed/simple;
	bh=OwaQK5ACj6VXXqJS8l4fei+7T8PalV6SBruuV2Qfj20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzA/xbF43TzfwdosCA+Zb8nsv/bWXDaUSpkp7V3W9EY5Is+Nh2yLb3AfFj93WsKXTomVsYxbmMwxDil7yfyKlPCTd9uXizB6ORdO9BSza1BRG/K+vRR4ZaXHWOVhaT1wLa0Gh3+Bb74zhMbX/ZQOW0xCc70Hz0WS2lbIvm0tr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTVd1QKy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTVd1QKy"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e85499ffbso156100785a.0
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785077438; x=1785682238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMeSotEc/3ox3Bn2HN8Am2NoxrfVodevyTk9qNPO5Gk=;
        b=jTVd1QKy1xKmNPcdyfmELT6QtpZXzCViEE1RKk5pxAuGJh2c0d5hpbtfR0Q1yDDVb1
         EgZZ6okohJpF1BM5S+kC6sD3Wfhtqz9XXxnYMfMXYmivpDtWMOnYLdHF/3N134H07cjq
         0nQPoT792hLUaRND/qFjFyaNiEYurw1fIzW8Yc9uXSp7YK4QknLugQ+YbevXs6XDNbOf
         9lv86jk9bM0bPx8uMZ4NjSEphGa54aFcdsXqy2RWrrPhKGNlMhA02LE81C05dKI8yVol
         OGFWpnTfhQQRRNaH+8V7x+ggRUrfbDTnxIbAomWV3WCB8hNlZEYMTrVbEixuHPv0hODM
         tOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785077438; x=1785682238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMeSotEc/3ox3Bn2HN8Am2NoxrfVodevyTk9qNPO5Gk=;
        b=laRWEc28pqnhQZmvmQa8Rppl6uvROOCno1R2j/AAh4FMdKjbNJA91NswFciMK9LFgo
         H9/QZWNr7yDqf+ukvH2iAfqDOXpyaoS/n21P38KOEIThPvK0hVLZoI2a77ClwNMeGhC7
         uioAyDvsdb/kwIC21EynxvJvBjE5t0TKv8fvegBN/CVL8MF2PqjEbMaxoVZq/irtYZyq
         NuhEgZG/iyhqoDKY2XrIFo6vGSLZmiopmQNUXCcm6yAcPgjY8hQylqwgsBTpNNls48Ul
         kVzQtI9zPgcnsEpPyXFnl/Rm/rtvXWAp9Nb5b486HZkinIzumedrIeJ+yJ25s0fuJrPt
         cvXw==
X-Forwarded-Encrypted: i=1; AHgh+RrHtrr0nkrdy28Q7uRT5b5aZqH/YjTQmmntcmybt7Y4TyD8Si72SwcRLr6Pq7bPkY0naxu/tak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIBJV3sYJUMZWs+X+cpFBVguyRRxkBn8el6HTnGA0lDj4eZL3
	sy681+VXONN111a/UNTHn+NlRLljOu/MROicBdUmJk6g90z/++ENbPmM
X-Gm-Gg: AR+sD13LZyke0Dm2ReWneQfcddNYQLG7KMvDSrmN6MXSuht0N+eUitDIJWLev+ZipHJ
	fnFp9eRzYiC15Mhb4WW6w3N92csyQIzIBzYejHnUZITY/WLEPbqXu0MlkyTxi7uJjJhCayA/2RI
	bhnHlBwLhCxgIfDpTNGvzy1/3bJ7D/PR+l6rqI2RG6DJlJX54kGekHEf/iTSZZLtGCTMftzjy5z
	lJ2M2RG1oaNaB2iHvhu3h1AdPFw3A+e0ZB9Yh3dkbZ3ZpMv1ei3xI+eep+VUsg1oP1NsyUvq4MJ
	GxMsiu1aVwCs4pLGWDhWBP1/H4LzVUUAH5kYB5avt7dGC/WwDo4VTZ6G8kesCnkhfS5Xs4/Tahj
	6XK/sZQvV3avtFtdaUP1ku8utKmjCerSYonUx9zj/z3pfEipbFJgk9UQMQ0GlxpjwquoQmp4+J+
	fV2ByvAifmtSNk3TaopWyHcFH/BQ3Ni7YDUdNGNUN+XtjE2vGZaTlW4xbBLpV6KhfpDCenS8Tj7
	a3gQMkDynaBOZrls9R8e0FY0e/3CspyJQ==
X-Received: by 2002:a05:620a:bc7:b0:92b:6805:917e with SMTP id af79cd13be357-932df765487mr509006085a.70.1785077437785;
        Sun, 26 Jul 2026 07:50:37 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de515396sm391642385a.7.2026.07.26.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 07:50:37 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()
Date: Sun, 26 Jul 2026 09:50:25 -0500
Message-ID: <20260726145025.1507383-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ctrl_add_dev() memcpy()s the userspace ublksrv_ctrl_dev_info into
ub->dev_info and then fixes up the fields the driver owns, but misses
->state and ->ublksrv_pid.

A device added with ->state = UBLK_S_DEV_LIVE passes the
"->state != UBLK_S_DEV_DEAD" test that ublk_stop_dev_unlocked() uses as its
proxy for "a disk is attached", while ->ub_disk is still NULL, so DEL_DEV
right after ADD_DEV oopses in del_gendisk().  UBLK_S_DEV_QUIESCED plus
UBLK_F_USER_RECOVERY dies one step earlier, in ublk_force_abort_dev().  A
poisoned ->state also gets START_USER_RECOVERY and the char device
read/write path onto a device that was never started, and wedges START_DEV
at -EEXIST.  A poisoned ->ublksrv_pid just makes GET_DEV_INFO report an
unrelated task as the ublk server.

Reset both after the memcpy(), as ublk_detach_disk() does.  Userspace only
ever reads these back, so correcting them silently breaks nothing.

ADD_DEV has copied ->state in unsanitized since ublk was merged, but back
then it was harmless: the gendisk was allocated during ADD_DEV, and both
teardown and the START_DEV -EEXIST check keyed off disk_live() rather than
->state.  The oops became reachable once the disk allocation moved to
START_DEV and those checks switched to ->state.

Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4ca6ec738c93..2a22f9dc1f2f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4764,6 +4764,15 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	/* update device id */
 	ub->dev_info.dev_id = ub->ub_number;
 
+	/*
+	 * ->state and ->ublksrv_pid are owned by the driver and only read back
+	 * by userspace, but they come from the copied-in dev_info, so reset
+	 * them. Otherwise a device added with ->state != DEAD looks live while
+	 * ->ub_disk is still NULL.
+	 */
+	ub->dev_info.state = UBLK_S_DEV_DEAD;
+	ub->dev_info.ublksrv_pid = -1;
+
 	/*
 	 * 64bit flags will be copied back to userspace as feature
 	 * negotiation result, so have to clear flags which driver
-- 
2.55.0

