Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCF480335
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256896; cv=none; b=ARKsAW8GnC/wNSEMCObQqQn2VEBuV02o8ZshpkM9J97x9kJO0Iqpi57Gkk0lShEXl8G2wukUW1hh1BpFJtkExO+xoC9OBZJjPd+QAtz1KwKJO8HcGgoIr0t2EmVbkb6X17iJPm0GKXiHLusUD+xW06bQHncpMSyUrWf6z3o4S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256896; c=relaxed/simple;
	bh=Zw0pIP5eSJI28ZqgOlOYqy4ScF2vOQAnlGs6UoZ0oSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKeQdKs+U9OymXQKTwQ9qrWb3ls0yjxI586WHXIeC9nXXQ8QKMdt20afsgYbFC4Z4kpWdJTfa9py8DjwU9LI09zmsS0v/7myXOC35DwrG7C5YW8zUq0+OCJrOm2wqxyPomKsBm+AbM9rPoWiTbmpXYs+3IZzUCGnCkzwoI2DZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB4v8vx9; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB4v8vx9"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso1099342b3a.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790256879; x=1790861679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOCGbQf6XP96p7s0OjDQYdkOZWkG2NUg2kYXrHgNtio=;
        b=ZB4v8vx9T5Ii0v14xNQJRScTrcNU9LVmZ0nw6SPPjOVeoti7wLSSwUAVTTzlE+Ds0j
         W1B6bPIpTw9gwbXk5IXO1TYW7FkufQpfMeeugX5AXc+lvJnMadq0Jp1LoRqmoXhUkkMh
         CguJyjIb86z6F5SpgL1+OHdcYXAYNQSNunHeStRoNZFoiwqXCON+/u9acwcOSfTFQA2T
         ik8wgcoDHGEjUixaY6aGHTXzUVryzdnD/gtQM+YgCkeN0GicqMnxzYVVl36tUE0SFuME
         TNh36Hu+C6tvjFVQh15p5EsJcCXw8Fwxnt8R+rUq4EBHAf3ZoHD+HHogoL9txBITgep+
         KMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256879; x=1790861679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOCGbQf6XP96p7s0OjDQYdkOZWkG2NUg2kYXrHgNtio=;
        b=L2ZmUX3inJ81Do871idTPfmw7LaK3UiAQlZaPAzpKFda5l2SIFsx2F3N3MUsg/EubL
         Rv1SIKw0HlDXz1KiuVTGA4QEPg1Qe60+0Zf3npYclH0fqmQAoKiWAdoQLszqHNgM8coi
         uDMxv4MLSMzEUPVlOhSRPmJKoMjjTDGlHfYWiua1t4Yl9jZvdSwFgisTDdYgDgYZnVeB
         SrU0zZFICCx+YHHeyhg1UrsKiWwAaeDXk7CnMVQ864TxQpSieEBMXzJf/qhKYMAUjvq6
         zLyqw7tg27O6tTKvketSFSNTa2nk033dykVfDttLPDaME1Mf6NZpE+eezybuX9jO8ZEJ
         81/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzKNsMUycBGCzzxBEMN72mvs4jBWh2gfvUQduAL9CPTT7Fp+2R/u+1mOiJEUO48zfJqwA4yuPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lq10buQ49GXRKypoXVJzXw9Tim2MJp+Ajf8UiD4Mq6BRcRR0dk
	GHgZYdaDrPxwP/T2ZgIffTlkU0iz+0ttr8vr3sP5ofbQqWsHbXV+AjOe
X-Gm-Gg: AYBFou0w+dofL2CGpuOPzQNRQJe/+5l1ve8gy6XMnpIBrHmmQbyvZV1YQ77deh6YZwD
	IWBlD9JaZmP9WHvk0pKQSTIAUEANdzkyAeSbyrRbuWjPcmkH051ff3KKg0OXY758XRi7JE1iIqY
	vXxfBDI7RDDAkQW/dK9yn6uF5xRnenlf5VupFx80qX8C1LWZXKWvui3LBSiL2TrJrwN6Ypeit9A
	2X/LwlGiSl1k6oJJK4S8bFkVgGXpiezZSIiloKbb/mBhWl8Pum5dq1N6RImxsbQqMll86AbZUff
	UrmGZhqZQ6mArVlSevOXP0zphcD67i9ssdTuBpPeP7q0iS2SqDur6HEYLCVIwdkTJoqQeFMmA4c
	+gkb5kYKTrq0kKjaKOjN9cxRtd658YVeaDxWnqlmWoON0DMp5XL6qITvnrc8K1AMl8bAeOt7I/A
	KcjpzYO6oURyuLwX+uL7H8+wj+7LV4ieitVMFHYT8yYfYTmgzA8IZnAg==
X-Received: by 2002:a05:6a00:1302:b0:878:3783:8a4e with SMTP id d2e1a72fcca58-87e9be76a5amr2245806b3a.54.1790256878537;
        Thu, 24 Sep 2026 06:34:38 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fbbsm3024366b3a.52.2026.09.24.06.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:34:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@suse.de>,
	Joe Eykholt <jeykholt@cisco.com>,
	Robert Love <robert.w.love@intel.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: libfc: fix directory server rport memory leak
Date: Thu, 24 Sep 2026 21:34:29 +0800
Message-ID: <20260924133429.1587511-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fc_rport_create() does not add FC_FID_DIR_SERV rports to
lport->disc.rports. If fc_frame_alloc() fails in
fc_rport_recv_plogi_req() after creating a directory server rport, its
initial reference is not released through the normal rport teardown
path.

Normal rports are added to lport->disc.rports and removed from the list
before their initial reference is dropped. The directory server rport
bypasses both operations.

Add directory server rports to lport->disc.rports and use the existing
list removal path when they are deleted. Keep the existing directory
server callback and retry behavior unchanged.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 3ac6f98f4113 ("[SCSI] libfc: correctly handle incoming PLOGI request.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Add directory server rports to the discovery rport list and use the
    existing teardown path, as suggested by Hannes Reinecke.
  - Preserve the existing LLDD callback and retry behavior for directory
    server rports.

 drivers/scsi/libfc/fc_rport.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index c25979d96808..eac3fde1246a 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -160,10 +160,9 @@ struct fc_rport_priv *fc_rport_create(struct fc_lport *lport, u32 port_id)
 	rdata->maxframe_size = FC_MIN_MAX_PAYLOAD;
 	INIT_DELAYED_WORK(&rdata->retry_work, fc_rport_timeout);
 	INIT_WORK(&rdata->event_work, fc_rport_work);
-	if (port_id != FC_FID_DIR_SERV) {
+	if (port_id != FC_FID_DIR_SERV)
 		rdata->lld_event_callback = lport->tt.rport_event_callback;
-		list_add_rcu(&rdata->peers, &lport->disc.rports);
-	}
+	list_add_rcu(&rdata->peers, &lport->disc.rports);
 	return rdata;
 }
 EXPORT_SYMBOL(fc_rport_create);
@@ -363,11 +362,8 @@ static void fc_rport_work(struct work_struct *work)
 
 		mutex_lock(&rdata->rp_mutex);
 		if (rdata->rp_state == RPORT_ST_DELETE) {
-			if (port_id == FC_FID_DIR_SERV) {
-				rdata->event = RPORT_EV_NONE;
-				mutex_unlock(&rdata->rp_mutex);
-				kref_put(&rdata->kref, fc_rport_destroy);
-			} else if ((rdata->flags & FC_RP_STARTED) &&
+			if (port_id != FC_FID_DIR_SERV &&
+			    (rdata->flags & FC_RP_STARTED) &&
 				   rdata->major_retries <
 				   lport->max_rport_retry_count) {
 				rdata->major_retries++;
-- 
2.43.0

