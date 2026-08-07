Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39741A79A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142601; cv=none; b=AOpX19Av2hpNEF8jiHZ8nyGFtMZ0AcXG/dKLEZNpLPO24vDA26FnTD5e9cOIrObW4KIO2iB8Fgv1FbbnaBRcvouXBK6/KKjTdGk32p8P6oc9kGHx5Y1v/qoW+cZk8JnHLxCBcPHBvk0sl3cXpeELdywgchCPAykRZHFxBwNkYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142601; c=relaxed/simple;
	bh=RHoshScSBq/TXjA4IyzFbnd1hM0s5Vvftuy8gbda57g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W09MkzVpvHgx5ayb+pjzErDdVn921Wed1QfSYSZ9K5PONOXxYmagFfhSQxb0zJyOO3nz4mchwsEp10X2j3DFK6mSNVcpaIkv1oFnNHy/WxZGFfSkw5BK7esrS/M8GZ6tK800z0E3kHRTet95UicyV+UPken/MZsLxE7WmJ1W+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWh2t7BF; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWh2t7BF"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848860def2cso53022b3a.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786142600; x=1786747400; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anI89PUz5R/cOuvPIsSAEi7/Ob4r4rENS/4H1jZGfTA=;
        b=pWh2t7BFbORX1eKU6k3gxRJZ6CetszLoVb2CAXJOPkpHKD74DJBduH+LTJGqedQvJ4
         94Kz22vz9C/Bfrfk+DSWivndmq/waPG3Tj+RhPLJBoRS1ip899ihpj3reCeubVJXfw3H
         YS0gP+b1Xx4PoDZpED67lpPSTFvM1rujCGaVqsVB1w46vyQdl13nUNfLbJN/Y0rUHiG3
         iGcjD+tnwpddwynKzuw3AnlEC3J9pamjmCa2qTpeayknB32SNpzEe/LWSerihI3ylV4L
         cE2e6RZmHlQfZfSEo5HHnOAikGqFlo4iRldVxnta4mFglZfpybYSsebzb6eCTRGcZppF
         F7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786142600; x=1786747400;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anI89PUz5R/cOuvPIsSAEi7/Ob4r4rENS/4H1jZGfTA=;
        b=BzZNuENG4oC8JVCT4qjSEnSSWZ/4qZqy9UfFB4XS9fcCLO9gkkobImiNvNf9X0VVMC
         WHhldLpkg2pgUBW4F/D43N70kBkTz+gol4T+v5kxdSGc5ix4mHX2ubJReVC1RoYSGsQ6
         pxLUBsaSR+xPonqxCKk2v96VpahftSWjRKELb+2vobCUqLTuatmjpD9GnPS1TumNKSLz
         gVdvnulvcV6VuPZLq7++5Ib0dcJUWkwbj93uvTYVaA8PNTVu0tXr7gdjw97MdIBGnZO+
         wv4REmJTJUgY28YVsnOfXpnMtnPltbSK5UbUG8lATxoxddfRjXqg86Y3U+f54N//N3SZ
         rlMg==
X-Forwarded-Encrypted: i=1; AHgh+RoiNPn8FrwMezV4ATNJ1Sf+4FTFGXBlLxBr7pxk5foMGAhh8EEJPaLSey31QbqRfTuNqcnonXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGJWNIvoUcZGNaPTNroPPYWYa5JToKcVT3cgz9NpSQN4AzmfJ
	SrSrgDK1VEXVYTOMxBjxDH8qe+O5eJ+jHb3Zpcjx85CA7JuMAavseNq9WqzhPM/Zk0gY5IFUL3f
	iDYzHWCHvB4SstRzcbc85SvZA3g==
X-Received: from pfwy31.prod.google.com ([2002:a05:6a00:1c9f:b0:84c:2a14:d041])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d8d:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-84f2e0228aemr24930499b3a.2.1786142599794;
 Fri, 07 Aug 2026 15:43:19 -0700 (PDT)
Date: Fri,  7 Aug 2026 22:43:15 +0000
In-Reply-To: <20260807224315.234152-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807224315.234152-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807224315.234152-3-hramamurthy@google.com>
Subject: [PATCH net 2/2] gve: fix NULL dereference due to missing ptp adjfine
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, thostet@google.com, jordanrhee@google.com, 
	ziweixiao@google.com, willemb@google.com, nktgrg@google.com, 
	pkaligineedi@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rhee <jordanrhee@google.com>

Fix NULL dereference due to missing implementation of adjfine, which can
be triggered from usermode as follows:

sudo ./testptp -d /dev/ptp0 -f 0
[  551.943697] BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
[  552.061946] Call Trace:
[  552.064487]  <TASK>
[  552.066681]  ptp_clock_adjtime+0x1c0/0x2c0
[  552.070874]  ? get_clock_desc+0x6b/0xb0
[  552.074825]  pc_clock_adjtime+0x78/0xc0
[  552.078755]  __do_sys_clock_adjtime+0x85/0x110
[  552.083293]  do_syscall_64+0xea/0x610

Cc: stable@vger.kernel.org
Fixes: acd16380523b ("gve: Add initial PTP device support")
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 06b1cf4a5efc..1d6c59f4ead3 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -26,6 +26,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
 	return 0;
 }
 
+static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
 static int gve_ptp_gettimex64(struct ptp_clock_info *info,
 			      struct timespec64 *ts,
 			      struct ptp_system_timestamp *sts)
@@ -60,6 +65,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
+	.adjfine	= gve_ptp_adjfine,
 	.gettimex64	= gve_ptp_gettimex64,
 	.settime64	= gve_ptp_settime64,
 	.do_aux_work	= gve_ptp_do_aux_work,
-- 
2.55.0.679.g6767b8d81c-goog

