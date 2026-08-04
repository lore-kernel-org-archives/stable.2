Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C54334DE
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816372; cv=none; b=iJLxmEgpZCraP3s3gw1vz8LJqg1niWMPc3QuKGepP/wo7Yndq4+KcTY1PAqg70L0V78qI8GW3IIIOiHweScCG8B+f8QXIvajR2fSzdGOzcSs740fy2bMQ+d1W1OkNuRxmCo7ZksBfBSP4KS8NhC3ZO5PdhDgoH53AJ1g0ucRW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816372; c=relaxed/simple;
	bh=5DE4KQsM7346xeBKvK3gf4RPk9kJfK5f72ku+Z9mtWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3BXxgLdx1LSlMAWOJVcEP7a6p58XlHBp9sG9ODT/XKOv0m5HW8s4+hOWCfIEQFLPoDRhvevlVxbBLjHAEolV56hww+b1NJApDQ9lVNDgl0Z22FU8fEhRYtUN6ARFWeU9L5hvk5S1TOGgL+uupNShltcKb3Il5XgE+9HGjStM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=lUKemQmm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="lUKemQmm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf52d15d88so34047305ad.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 21:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785816370; x=1786421170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=za1Dlg5MtkIibFTGSkfNOwAtn76AnP6HPzWNLsvhv18=;
        b=lUKemQmm9QETeTffwq36G+BrDLCxd2IMl2zffaNwjs1HjIMRzDZtCXA6J55TUy2ue2
         fHe4ZSEnS1Kn01UeKuMjCCpZEW9pKdX0up+XicdeqRXhcwwfgym6sraP75+L6kuNMHsG
         D48K9pNjwVOwTYlvJMLOAMhl1b4QpvPU3GUbkqeCm38V97eC/S1tPlefMa7mtU7ECcJ8
         07JUMPi8xxGqR0+54hrrElvgDz0JZ1zbcv+St1mcgNMOs8EGtO5vZE/UFs/K/e6JcJ/j
         TdwxhxpsYdfz5IGuE2uW2Tle1Ip0e5RUa5QBLQ/KsDA9Es6xC67Vg0DbzZlPC5oL2qOU
         OrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785816370; x=1786421170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=za1Dlg5MtkIibFTGSkfNOwAtn76AnP6HPzWNLsvhv18=;
        b=b/KsLxcFmPyvmQQlQFxnc7I29YDge4/pq8QNSJ8XCP+XeWRoh9vP1EpuCzA9KxTwH9
         39/kEw73WIUsx833v5Zd9NBprjpr/wwc46GrZHzGdWwf3DXinuY3SPgHB+vnWGhxKC4O
         kGmhJcdiLWR4tSki2hdPTuilFtg0YrssItWv+Fsy7oLO5iVM9bTWuhMWlxHnyvavKZvO
         PfqYV3LhCXQycgCoYXFyLxeod6TqtpOnc0aXdLRFQzeOVDpWFbyuRXxcQwfVEiNYR4ZL
         bFfMRHiFW83L66ijgnZMC0jhEQXge9cPP3c/eZ623S5u3jephb9CyDT+E2vGA6Em+sVt
         3CGw==
X-Forwarded-Encrypted: i=1; AHgh+RpMElO6b73ea/jF+iqfoUPRhEA88/g/ujQmPftSw0lMSPmffVM1J+dhIXaZpN6XpQhcpaz4oiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvVssuG+32ui0gJDu9SZn6Xv5ROR0eEJ7PGMHh9x9MsRSI9Rr
	CrsHwJ/9YM1XjTNepUiRi0X6QUTX1/ToimH8aw6t6mObmtOXwXjbDJiJmwyP3OaQ7JI=
X-Gm-Gg: AR+sD13G1+4nUFkjFE8F8qOCoJrmANYSVX6S2XJBxGvzRqgHbvA0bWWt2K92dBziMFK
	bIEgimXCTF8GVYvZhf5LOUkD2+yZeuUbJZrJ44BMwejwJo6l3nZdbrSxmUV03OLcxFtxWKAiwzR
	D89+rxdxKmtCfRyWMWpMotC9YaEvrT2mrdjk2Z9RoS5GDoaHZGxf6mAG0r4GnoaNhbfpUQ4sazb
	2ZaEOigovTGnMsyDuW7V30kRSOi2lDJvejOsK4uYv8KnbILaGgk/VJpP8tKE0nNRbR/K2NsjxIY
	CrJelrI0bx/rmXcJCXbgfWlK8bI4Gczmg/2R+h0+kWPOSedqZzYxbttyR732DO1ci4EKP6zKale
	dofsMbVQjABas2KuryfwODIzrVfh++StvuLZeHYYVqTtbpuOjvmD5LEKqg7Wc5H88jjnkDpJ2zz
	4XQK7aLcyDvWnHhDp1d4QvnNNJRxqEoEs2GVzFW+/6LHl6xodYi9cyAggJ2n13oVShA0fb
X-Received: by 2002:a17:902:ea0d:b0:2cf:83bf:6b05 with SMTP id d9443c01a7336-2d0523e144emr111189575ad.41.1785816370167;
        Mon, 03 Aug 2026 21:06:10 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b11f9a9sm46075465ad.57.2026.08.03.21.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:06:09 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: lduncan@suse.com,
	cleech@redhat.com,
	michael.christie@oracle.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] scsi: libiscsi: reject a negative task index from parse_pdu_itt
Date: Tue,  4 Aug 2026 13:05:44 +0900
Message-ID: <20260804040546.2264137-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804040546.2264137-1-yhlee@isslab.korea.ac.kr>
References: <20260804040546.2264137-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A transport that implements parse_pdu_itt hands libiscsi an index taken
from the PDU, and both lookups bound it from above only:

      if (i >= session->cmds_max)

i and cmds_max are both int, so a negative index passes and
session->cmds[i] is read from before the array.

be2iscsi produces one. beiscsi_parse_pdu() assigns the raw tag,

      *index = (int)itt;

and beiscsi_complete_pdu() forwards an unsolicited NOP-In from the
hardware async ring without replacing its ITT, so the value is the
target's. It also reports the session's own age rather than the one in
the tag, which leaves the age comparison in iscsi_verify_itt() with
nothing to reject.

Bound the index from below in both lookups.

Fixes: bfead3b2cb46 ("[SCSI] be2iscsi: Adding msix and mcc_rings V3")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Not reproduced: I have no be2iscsi hardware. The reachability argument
is in the commit message.
 drivers/scsi/libiscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 160f02f2f51d..7a74bc697d23 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1191,7 +1191,7 @@ struct iscsi_task *iscsi_itt_to_task(struct iscsi_conn *conn, itt_t itt)
 		session->tt->parse_pdu_itt(conn, itt, &i, NULL);
 	else
 		i = get_itt(itt);
-	if (i >= session->cmds_max)
+	if (i < 0 || i >= session->cmds_max)
 		return NULL;
 
 	return session->cmds[i];
@@ -1384,7 +1384,7 @@ int iscsi_verify_itt(struct iscsi_conn *conn, itt_t itt)
 		return ISCSI_ERR_BAD_ITT;
 	}
 
-	if (i >= session->cmds_max) {
+	if (i < 0 || i >= session->cmds_max) {
 		iscsi_conn_printk(KERN_ERR, conn,
 				  "received invalid itt index %u (max cmds "
 				   "%u.\n", i, session->cmds_max);
-- 
2.43.0

