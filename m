Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99F125A0
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839292; cv=none; b=TdfSiIb5FEuVRQ5KmadJeNguGICDVAOnkKqLPfzA0+6tdqkO5tvaMIpWRM7Avjp/Gv1J9BKzVbtpoFT4gDKUpCXmxKdz8CH2Nq26kwHTAlK7JSMMoSpfcdPWpCTMFkW5VuCaDwV0TAFVKuzYpQLy4Fz9TPpKPqxLn3i3Bcve7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839292; c=relaxed/simple;
	bh=tXPMv/Z528AzLwHoqZJSLZNkBxU0ltXfHPgB+kUGM0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKYBMJL6BSXFS7pg8YPGStFDpZAoxVJhyTDCMNno6naEqApJzqXWh5oGvWt7Iyuk/luqV9V0v2qSO0KDm8G5aYQpAArdrTqEIZ0ZTw+s35sQ3agTURAm/ZbWla8divv69a2NSon2GTXgZVkmWfOJK2Wzo2zwC4lPXb3g4/++KkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCoFo3lF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCoFo3lF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1218050a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789839291; x=1790444091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3sjbzhb8LLlJu3Xq4nSK1HUp2gy9IN+rCu4DEVUfQU=;
        b=aCoFo3lFTKMrg7PIcA1ejGDI13I3vmHJBmZnC8El2K/sCTwSTghub9PQNrVm3hIzPH
         zE91qUQTHGt+8hP1wjX0wJ6p02E6neQ4IActu8nvkh50uU44QbP7FN3ApDSpIDUH5QgJ
         n8ReyfqBrdL0GMSrmXp4my3nW6LGdKXxuXC2ttTnT8VD9B1dCEHXj4cpGxW7XFZnfz/O
         kIMAr9bqHrz1WQ0sy0//sk/uumvk0YjDluST7jUh95HELb/m4lTa0UGAUrqG81uoVlHe
         BJtDY8BbuSBo9aL1o80wIQLCeEkVbUNc0MvIhuMmAGR467maNOrQk3JeFPL8osGhgGYw
         08TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789839291; x=1790444091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3sjbzhb8LLlJu3Xq4nSK1HUp2gy9IN+rCu4DEVUfQU=;
        b=FYMNuIlY6Fq5qIYCa/E9Tx7db/0/wqsijtE/0xuHhC/dmylxLsJVdh60WbHMbP/E3H
         HXfyKcOxba0PIZ/ObSMBCvwpvZBhCp1rGStZthT2kJ2J3qDJkj10nhZRkRpmpXRyTprU
         EHQibOKaj0eL7x2/fi1AQnz2kKXF+qmfQ8rLoWlNmzluzmRam/FALNy2JxXqUfOLoFt5
         21tw6MpESjyUEePjAd0X8XGG4sdWKQO4n9j/+GhIp9v9mZb7Fyv9+T2taKJciPbVgE9N
         pA7KIQ8jZ4wwYLOj83d4ps1t7SfVKLRDWcDXa5NprDDOfp3TupKsSWky6r7YI4SteOOl
         pRmA==
X-Forwarded-Encrypted: i=1; AKwUvBz6j48vZCjI4O163gW+T7hG2YUk5ZR10VGazWbw11rVpGtbJVko1AN8hY03+65/rJ1wj5sYdp4=@vger.kernel.org
X-Gm-Message-State: AFuF++nztHdK4Pdaj1JkXTrFSNp3Zundwl0Uqclpw4BoKV9ZapSLblAk
	rW0zMvB3Aqgwh8Joc0+I76xEZlmTa0iPNbnPDCXRYKqXFuy63XqMhPUQ
X-Gm-Gg: AYBFou31ZTGpmDVrU3XQ3Ss0iXM6QlHZAMeE58PTC2wgLtjLH8E9tRIKpgtq/giHkNk
	8xwOMOfOMaqJGeevLON4uwG7rzGyBy0rBdh4ITdvZrTA/KlCjxd6QgfF6ddP++PVHo8muRTTyOC
	tG39xnYEsAxF2sqXHNpvwDrHHXqXOTHZUBkuKLi2jv5PbOFXff7mRU1KUCZik7/yH8JFK6D1uJD
	6gjgtQwuS6n8ykqoNd0eNEbAjxD1LDIIVsW2W74pWJKyLlTFIfFGNCjcHC5hd0w5CUlVU+3OJNd
	Qwir7tuS+8sl3WV6pVo7aOLoVRVzusSxVNfJCtQSlNweXE7OcQ8iIcWNM716LNQu5v3lUCeaoCV
	xHPxX9GbnJ0HnxLvd0bB4y3MgpcQBDZ0y/FjX45J7vRTPwvAHLjBJ8peUxBN9/8ZytPwqXuxeL1
	3ynniOlnjEKossAd6v2L6C3GghVhcz4uju/qpShvWQLtCj/Rf5knkKPg==
X-Received: by 2002:a17:90b:1dce:b0:39e:6a80:dda3 with SMTP id 98e67ed59e1d1-39e6a810c76mr4792250a91.42.1789839290805;
        Sat, 19 Sep 2026 10:34:50 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a026898b76sm3234229a91.16.2026.09.19.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 10:34:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Robert Love <robert.w.love@intel.com>,
	James Bottomley <James.Bottomley@suse.de>,
	Joe Eykholt <jeykholt@cisco.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: libfc: fix directory server rport memory leak
Date: Sun, 20 Sep 2026 01:34:05 +0800
Message-ID: <20260919173405.3718408-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fc_rport_recv_plogi_req() creates an rport before allocating the frame
used for the PLOGI LS_ACC response.

fc_rport_create() does not add FC_FID_DIR_SERV rports to the discovery
rport list. If fc_frame_alloc() fails while handling a PLOGI from the
directory server, the function returns without starting the rport state
machine or dropping the initial rport reference.

Since the directory server rport is not present in the discovery list,
there is no later teardown path that can find the object and release
that reference. The allocated fc_rport_priv is therefore leaked.

Record when the failed frame allocation leaves an unlisted directory
server rport behind and drop its initial reference after releasing the
rport mutex. Keep the existing lifetime unchanged for ordinary rports,
which remain owned by the discovery list.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 3ac6f98f4113 ("[SCSI] libfc: correctly handle incoming PLOGI request.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/libfc/fc_rport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index c25979d96808..884b233c2f72 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1848,6 +1848,7 @@ static void fc_rport_recv_plogi_req(struct fc_lport *lport,
 	struct fc_els_flogi *pl;
 	struct fc_seq_els_data rjt_data;
 	u32 sid;
+	bool drop_rdata = false;
 
 	lockdep_assert_held(&lport->lp_mutex);
 
@@ -1940,8 +1941,10 @@ static void fc_rport_recv_plogi_req(struct fc_lport *lport,
 	 * Send LS_ACC.	 If this fails, the originator should retry.
 	 */
 	fp = fc_frame_alloc(lport, sizeof(*pl));
-	if (!fp)
+	if (!fp) {
+		drop_rdata = sid == FC_FID_DIR_SERV;
 		goto out;
+	}
 
 	fc_plogi_fill(lport, fp, ELS_LS_ACC);
 	fc_fill_reply_hdr(fp, rx_fp, FC_RCTL_ELS_REP, 0);
@@ -1949,6 +1952,8 @@ static void fc_rport_recv_plogi_req(struct fc_lport *lport,
 	fc_rport_enter_prli(rdata);
 out:
 	mutex_unlock(&rdata->rp_mutex);
+	if (drop_rdata)
+		kref_put(&rdata->kref, fc_rport_destroy);
 	fc_frame_free(rx_fp);
 	return;
 
-- 
2.43.0

