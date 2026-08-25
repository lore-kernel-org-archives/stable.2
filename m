Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B283C942E
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701590; cv=none; b=K22VmM/y86wu1vnfi5tPe/tED4odp3Db7Zp4N7SDjsfkAnZamlVMT0g6RwjII91rBGENf61mWUUfbUv9AtcpnsI39x+Kl6T9g2FOgBfHFNu7dwpRJE2VPxhUxT1hyLjSPf0lgxSpR9PGmEpEfVCZUqz5Cvjc5XwwQW8V3TgD3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701590; c=relaxed/simple;
	bh=hSy0TDwkiRxy03N0dGR6M5FyPGFSqOUpx+giGNStmDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PO9CqMSitV+2LwTfBqGkixmPIagqsYauNBHxWOvi3djRgsR01e3mCMlJGpzSX3LPAD3k34IbUdLZ/HwQaa+UGzw0ZqpMnd5jU63IADMPMjAGJ8A+vOPTrJ62vNEorvindZBeKDryA0gIlLfCluIbF3HGey91P6O4R1FcUKFmny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mY3tNZnr; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mY3tNZnr"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so754996a91.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787701587; x=1788306387; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0+d37aFEBatttrxB1z1hnSPDhmjQUMoxQTvWGkjabs=;
        b=mY3tNZnro9iRWxlmp6NaMHJqJMTJzml5PerCY2/YkJXyZ4csixwyj0gvakTIV6dDD3
         oLR4FrtbMenzCyzrB1nKRsoBfCPTpjLOyl+kAsC1DYKscxRqaahVBVU483nYq1aChGwD
         V1p+XuMXWgYq+NTWuy8wcMhHE8zfywXX6ImaL1zwdgWeLnlkbr2QCGT9d37OszgY3Rd8
         wP/frwdCMdq78qAtksA5BuKiHrzXIxwd9KwLnTREHv9/ra8B/5783N/p5e2Vj8BPYEM3
         M08NrW4kCqcq49Hm8whGd+BeSKzWvBZbGrebX5+RDVPDyxPn8BKGGzZ94a57h45a76j6
         kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787701587; x=1788306387;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0+d37aFEBatttrxB1z1hnSPDhmjQUMoxQTvWGkjabs=;
        b=Uu+SNbrm5pUmoHDg33TX4+dWLVMviFeS1GeP2fXDxtuIzwhVNFhEEa9HrOiz9IESQs
         v1Oh5J8sXYZE7aS91lFMKuZgsI3FV3WngOncz+kPpGmCLk01ioyiMGxRCMnQeZcf09Ej
         5qxt+zlgdND9tBK4APVm4RiJO+4HAeYrwj3q33YrURLHKUnnYq18OMmmLeUnTDsn5AZz
         VHyuJPMyZqDmEQ9wyqIazHq25mKxMISj78KvGWGlcMIGFLjbca3PZfGnwz5jqJkCFd1X
         PB8qWsVwPW9+f12u/fObsV4QFFZrjeilL/0cFNEpAwB0/1UwxHXmzPeB6riFlRnyiXCh
         umWw==
X-Forwarded-Encrypted: i=1; AHgh+RpiVAW/a7aITD6yOagM/RrnNQi1gKR9M6dDMG96vrlKG3ARcJcQKxuONEaIS58TbzXsreBzSAs=@vger.kernel.org
X-Gm-Message-State: AFuF++mXejpXXUUmK+Yq7l2fTM55NEM+C4DKMlMfNndCK88CLgO4Nfgl
	+voUe3oq3F2ceSROvtEd57krq8kzsw3R4v3f0ViptG2W4Sgn3DGvim92C2pYuPlBiftRmrXUmhY
	c3L/76w==
X-Received: from dylq20.prod.google.com ([2002:a05:7300:5994:b0:327:dccf:72c8])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8b:b0:38e:67e1:15b
 with SMTP id 98e67ed59e1d1-3966d3d9581mr5330179a91.6.1787701586417; Tue, 25
 Aug 2026 16:46:26 -0700 (PDT)
Date: Tue, 25 Aug 2026 23:45:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260825234545.2076049-1-jthies@google.com>
Subject: [PATCH v1] usb: typec: ucsi: displayport: Fix OOB altmode array index
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The UCSI displayport driver indexes the connector's port altmode array
with the GET_CURRENT_CAM response after checking it is not 0xff. The
port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
not equal to 0xff, the kernel may crash with an array index OOB error.

Update the UCSI displayport driver to verify the current cam is less
than UCSI_MAX_ALTMODES before accessing the port altmode array.

Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/displayport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 7067f2561b84..8d2032d0762c 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -74,7 +74,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 		cur = 0xff;
 	}
 
-	if (cur != 0xff) {
+	if (cur < UCSI_MAX_ALTMODES) {
 		ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
 		goto err_unlock;
 	}

base-commit: e1e6e541c5c9cf548e9fdc35fc26808c82074440
-- 
2.55.0.860.g4b6b3295ed-goog

