Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED1339399
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716757; cv=none; b=QTv9/1C25aB+zrS65auRNMBERj35QCLxJP8eOMyGUTaMzZn9vO0W2OM035p9aoJA+xmESsb2tS1zOh1K43lFJGNcjIOd877HVpQGzHclyt4FJ3cZzLcm6PQSelJ3hl3WqAqRX7imP8V6Dzz1jWJ7mpu0XWPPjx6XvlrBlxAj2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716757; c=relaxed/simple;
	bh=qVkwbm5skxHmjijSQlwkYEBcOxBNQ7+31ovrvai2xds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3T0DWBcoc4I1Kaj6Wq9y803tauNNdqfuWgg+1qQMPtT7NrY1LKEAWVAYfVV97YbvRpGnf99bJv37kul/94ZKKQM7TNSt7SpU71wSuE1y7PsuJlTZgGINtmuz/u+cA57ofZMJU6HfbIblbUZEKuw1erIDXavn8zCosPkLykJev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Y84w2YQj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Y84w2YQj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cad8076b01so147119525ad.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784716753; x=1785321553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Nme6Toj9C3wtO+kV+jhiXnrP22CDDJWcY5DQqOuABI=;
        b=Y84w2YQjPHNvZbIZaOnXVY03cU1FLLT4uo6G39NScqUCyfG77S+Xm+2FMusxSDp5Ta
         jqkg+HxyHfaDwgLaBKeD4aSnDF3jfAZHCuPdhGh9ga3rA5JrYvWv+ycjcT8tgJvI0Th3
         Y7XVwh0NA/SwjK0kmHttTWIADe6ZumEsWinX1+HKov9zRk1rT3Xuy/yvFsPuD9jpKAEe
         bIUDdthVin3B15Lp/RRuwCie5cXAG0a1iqu8NGeag+1w28cqsa8w9gpI6NevwJWlWXNx
         JMohUqMI3ipkdHF94lwZxTzmv0+dXkO5tghMTKz3RdL41eo2zqpOIVeKQqGH3HmvK2Bu
         6SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784716753; x=1785321553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Nme6Toj9C3wtO+kV+jhiXnrP22CDDJWcY5DQqOuABI=;
        b=IgRq/AniZb6Ofj+b7LL9Wi9rJKo+Vl7wczfrARBMnMNE838xkqFzXQ0SbL8agzMZEY
         jYaWyjahyGy+I/FfM1SRmKJI++ekuCiSxRxGobELCpw/vE62CeOMmmFnpHajSvLkdrqQ
         NhUyLBP7osT7xo2mZ6vaLdNq5tJHTWjmK5CH8opMP4Fatc5ZvBsuGDlLPW/XsLu9ePsP
         u2NGucjaJgrz4V9lygMGheCH6EJG1WSVawW58t2+EWiASAYQx5jDRYnqioQddAZc1Pis
         d6+9yZ6yfiDZ1akpsw28TgmHdPsz141ZvBT5eF4h+Jwvige5Z9eKo6LcJhYqb/exjYBS
         YljQ==
X-Forwarded-Encrypted: i=1; AHgh+RpC7waQynIMjRJw5+SALwcxhe7tNBqji36XyI2+UdpvtdsK9W8fpYetz5lc1pfqHMG9VIOqKzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hbLoJhDtKHP/vsNBCwb/RZ6DOcbhOr2JNxHBpPZTu2mo+y16
	ORzkhed/4cohroVW2R4qzF5wDhSfDxlWatIbOv6h4T+Ydnk0+Ts5OVfzTcs58oOT964=
X-Gm-Gg: AR+sD117CFKTnLR9H0zg3hxFLA8yQprPgCbHsZUNeqqetL1lpO0cBt+zcVVHB17uHgC
	1ukbDqdg/D/+484d446wBzXeUXilwvzXQiseL6bFd9xgXIihw5Z7VKSZ4sftfbZss08pQu5NbWW
	Sp0KHiEmED8eVFJ9iTit+dMOCTU32TlARl0REAZrcwTUbTqveZ0VFa1TmZ/aBgWt18QNZPqSs+z
	KgkQBuNjWjk/ZUnkuDY5C3KXaDsueHozEFf6y02tTOcdLJQKXj+0SPeR4ih60lSlN98ul+SJKO6
	vNm0N1wZOmyjk8ZFED8URJO0qJskGA9s8zMIMTwD0oOqpFu4IcrBUGP58hSBFdZtI3h2RPJ1maw
	dXxrPc93ffFyP2vMzIOwjGwEF81e0AKCSobMkiPQL3fvwoSMmM7XmCObLwLtRQMB6qLPK3AFrWB
	WoczaEPztPH2bHbNZu+0Al1BT8ud7KHuPKktdLHMJOED6ikrcNyhQHR6DDsCg1wjI5r3ac9+NF4
	zbeXIfdYKHnkHQ4zzrLnFqXTHdLRECy
X-Received: by 2002:a17:902:ef01:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2cf349aa87emr250699035ad.34.1784716753616;
        Wed, 22 Jul 2026 03:39:13 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3147dc7d8fbsm9185429eec.10.2026.07.22.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:39:13 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: mkl@pengutronix.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	mailhol@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] can: kvaser_usb: Fix memory leak in kvaser_usb_hydra_get_busparams()
Date: Wed, 22 Jul 2026 16:09:03 +0530
Message-ID: <20260722103906.108571-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for cmd is not freed after the call to
kvaser_usb_send_cmd() in both the normal and error paths.
Fix that by adding a kfree() immediately after the call.

Fixes: 39d3df6b0ea8 ("can: kvaser_usb: Compare requested bittiming parameters with actual parameters in do_set_{,data}_bittiming")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index e09d663e362f..efbb7bed34c9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1626,6 +1626,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 	reinit_completion(&priv->get_busparams_comp);
 
 	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
+	kfree(cmd);
 	if (err)
 		return err;
 
-- 
2.43.0

