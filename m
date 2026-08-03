Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F183BCD14
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765595; cv=none; b=Jd349gGoDv2pQS2mNCxFGLJriNbmTp7tHF8ea5L829z2dXrA4BeFKVPIT0uRz9ByZolJu1tbOMeNBvBeC4cWOfmP9pxKnZvagkSjps6jrt1uQf/gFwmIDsjlFd3BYs/Oann+aQcx81DtC3r657kzjtoLK7Xu7MwzW+3+Pzbq+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765595; c=relaxed/simple;
	bh=Xm/7DtiEMg1IjVRIDD0Dmnqy+tWy/4RQwD2wLYgsQ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPPCrBIjCo03cchZM2KqGYAVhnuHCy6oy+n+noCe/4owQtRIhHIb2l6GrH8IQKoCt3nIVimUw5vrEWS7T/WwVeM6CPUsJUNhAyBR03E/HwrZd0OkiCRvpnuZhxfsCyya2Zdcj2f0amaTlzkzN0qOi/A5L/rGfjMgC6Kh7HZJ+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/mbDd7b; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/mbDd7b"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so3186863a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765594; x=1786370394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+pksryrxLXLGb/sclyi3ItCIZaPNjNevdntxR0DkJM=;
        b=a/mbDd7bmFL43HNAgNHEUc1w4UxVNQekw3kRIPkcmw0jd4czbJM3qGRb00uLFJ2DQp
         CxMzHB0py5bQwn1wmtmLnEpRlJ66ba6Z6Q33NXYSM8eHKaiCfsDMo/2wPIRRmB5hel7O
         z5KoVMFQEV+/PY4RB1VPh3Rys//oGNwFRyIXJlcfiOhUSAlrgHvw6Dft8jxI7A7X3H7u
         LJqOdP8Ibu/9xdN4YuV/oc36AxSosWrH8PrAkvT0+bzVfzJH9bE+mV9Qgr5Flb3iqRPK
         szgUs33uuKpWraDYCaplasMQGkNfOd7tnPn2f1aegzWzJE4ZLI7CHxxnliq9i0REMH8k
         MYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765594; x=1786370394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+pksryrxLXLGb/sclyi3ItCIZaPNjNevdntxR0DkJM=;
        b=ZerX2EUewLy1XAk4v545V9gcfz20Ztc+hUzYzN3r1Zl5BB6BWH1llEepn1sTcmaeDI
         PifMCZ7mu/DqB69IaoTIOQzjQwy8Nlg7J9DHNxdNnlfsFC/8nd2vrLGN/IXKNo/7p+oe
         iGkznZmHz175e8/F/neAks/JFU4pcItZuNsheLzTud0XJJOAjUbY1e0H5Z0GrnAEL56S
         RIaBURTUxMnqxLS/USqN6hcMss4aZqOkNyz/9VBXsrSN5IxY9QFs24Wm0ypvjnFfpbdo
         OYe9SDqbCuTq6gHcRfSMay5t4sbxA4s5j2nHU4EncRl7wEvoMTTFbg2FkvZQyeiInDmY
         QoXA==
X-Forwarded-Encrypted: i=1; AHgh+Rou/uYatgkhsflWy3hc4L+/62cvq0r/69vc6hUi7uT5GyLvjH44GM+grlTntkoShyXX5Lfm8Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejR6xCQti3TrblECdzJ3rVx3iYzbUA8JBromEuAHDF3DIx2sn
	foXFdDe99d7Wr91LKcxFkLoM9KMtnhoWzhkRxH9Y4n1FRVBHgzbk8UU=
X-Gm-Gg: AR+sD139+KIsw7+A38Wq/K0sRzaE9LAld5SuGiymQ5CKwBcxa8j1HhFEuMzDa05dczn
	0BjLudnUGib1dyMTV+yEGL31ueN+L1RljHvWEjQHw+S2nWEhVzkUn8lV7CjntCw2B2LwqCwGFCB
	tLF2CqEnxiotNU22+0bsY10I1Dtq9achDw4PduWGs43BZBXK7T5grQSPjBhwZQKo1iutpKm9Oar
	9rHidVzKNX9pIL9QAGNWPwEZBBtqSv6QmtHq1SDjMkTq4NuakOIEYouMEhI9GEnOjAFHe/epqKk
	3JvyLR5HjKLKT7m95bIhd3Yu315Gkmrs8m5T+z5/jQ4gKLpGCCbgysigFcZgc6OeFQhjUfdwSJF
	UGpQED4s+PDbQfgud9JBp7TvTX4KoMh5geC5jbzDEUwNX9UtOblWfrkspsePsD/BGARtof8kx0y
	SI0Md9IRdcN9uauTGr9gi9sIuYbRR6ReSAO4LmRQD0plS72qgG3aKiQ5rugKnemrDEqOtgIdQiD
	fV4L07W1Pj59yzKygfDeSmcFoCFWEn/x2+heKZgygK47Zx3NdjV/k+UOvNUbn6QM4bhjGLL3sZ8
	6aT7Gd87jKOLlpGwSdyvTyA=
X-Received: by 2002:a17:90b:1d52:b0:380:540:d499 with SMTP id 98e67ed59e1d1-38fbc3fb64cmr8689147a91.6.1785765593692;
        Mon, 03 Aug 2026 06:59:53 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2ce1778sm4068946a91.15.2026.08.03.06.59.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 06:59:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] ptp: fc3: register PTP clock after initialization
Date: Mon,  3 Aug 2026 22:59:42 +0900
Message-ID: <20260803135942.48383-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_register() exposes the clock to userspace. If either following
initialization operation fails, probe returns and devres frees idtfc3 while
the registered clock still refers to the clock information embedded in it.

Complete the fallible initialization before registering the clock. Schedule
the worker after registration because it requires the registered clock.
This removes post-registration failures and avoids exposing a partially
initialized clock.

Fixes: 1ddfecafabf7 ("ptp: add FemtoClock3 Wireless as ptp hardware clock")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Register the PTP clock after initialization instead of unregistering it
  while holding idtfc3->lock, which could deadlock with a concurrent clock
  operation holding the POSIX clock rwsem.

 drivers/ptp/ptp_fc3.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
index f0e0004..02b9739 100644
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -665,8 +665,6 @@ static int idtfc3_init_timecounter(struct idtfc3 *idtfc3)
 	if (err)
 		return err;
 
-	ptp_schedule_worker(idtfc3->ptp_clock, idtfc3->tc_update_period);
-
 	return 0;
 }
 
@@ -825,6 +823,14 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
 
 	idtfc3->caps = idtfc3_caps;
 	snprintf(idtfc3->caps.name, sizeof(idtfc3->caps.name), "IDT FC3W");
+	err = idtfc3_set_overhead(idtfc3);
+	if (err)
+		return err;
+
+	err = idtfc3_init_timecounter(idtfc3);
+	if (err)
+		return err;
+
 	idtfc3->ptp_clock = ptp_clock_register(&idtfc3->caps, NULL);
 
 	if (IS_ERR(idtfc3->ptp_clock)) {
@@ -833,13 +839,7 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
 		return err;
 	}
 
-	err = idtfc3_set_overhead(idtfc3);
-	if (err)
-		return err;
-
-	err = idtfc3_init_timecounter(idtfc3);
-	if (err)
-		return err;
+	ptp_schedule_worker(idtfc3->ptp_clock, idtfc3->tc_update_period);
 
 	dev_info(idtfc3->dev, "TIME_SYNC_CHANNEL registered as ptp%d",
 		 idtfc3->ptp_clock->index);
-- 
2.50.1
