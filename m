Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AF5158A5
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971276; cv=none; b=m2csHHFMFiO8q1UoKhuSunoE4hQcjPq6rOm2aIia9TEQoN2vuMLzoue1+ELOQWqIBXDaAq0x80MGcTHcZ7zDU188yNijbOubmwldzOCeMuEeV2dCYeNtvaNYpiFKLhRrSEGqbnTczWPsWqggwakoa0aNNRwNPWWrlSDGvW7mpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971276; c=relaxed/simple;
	bh=xYd3Pn7xwPntUxM1xr+2z/L7TOcW6nT3FOYomMjm6fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aT+dW38Zo5mPXkdHJ1G5/QowQMRP7qVjmrl3DcX9+4g7WFIW72bmzEsMyq8Tz0iwUc7xLBQUjApBn1ytRkgLFmiHBqdoE9AwUbuBonJWe2HkBdgE1yGgaKV2q/HXoe+UmpJwAUj7APeaXisuJNs6lxGse2pd7xmG2fM66MaTK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N46glkmI; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N46glkmI"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfc58ed04so338974785a.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790971273; x=1791576073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWKhQl8VCZeFEKO2nQY2AimaMpesWlwedfHQWqbVEAg=;
        b=N46glkmIAiqW7ZGKBXQP3iWEbtDV2RN7iBuwpE1nZ8AZFtl2YWTUldZklKf0F5CFkk
         u4+UtAT3UYCfZ4knDM3yiCn46MVTFTVrX9EYMxUaQz6syAQnX2XooNNNmMcjBLXxa1Nm
         fpLEMPQv5EJU3/21h6YgK0Efur1PWkoRvXDdZZ91YT1kEdNqq9i5wOPSQ5xnHi+jaZRU
         4U39GvA0jE8tOrefMrwi/r6ynph6dfsaAjOfsxDil5S2h9rroIMjvPq5gIT4zdsqpihG
         A+kqP2sb8C+HlBgu7WqMI4IYdKY+e9ewQe/mGpqACcl9KTHRFD2P5LpGE7HFbp2TqTUE
         Nq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971273; x=1791576073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RWKhQl8VCZeFEKO2nQY2AimaMpesWlwedfHQWqbVEAg=;
        b=VTvrEMAJjfYvhfpEvb4Pvp9OauVDn67olC/aiWSDacHdxDk2G2G+XQDx8g5MaTWKsb
         sqnO8PPWgLq8Lut9PQ/ky51Rmo0idqstINBsynbjE8CAH5WQFPZJCRFMQaon0aMFU/IY
         N93Lv+VRT3iUudRVCWWxawtZ9+faL0qysH3uBaKqDnW93rWddhLcLhfHd8Ctqsv5u/7y
         JQe7sWY6FFAiYogMTxoFyLCfefAWUeLWXCu0p1njl9EgdxDCWsyf2pcAqjHFgCnuw9aP
         eZL4nKsCgMhA7cp9Q34omPdZndoAudLG7MG4/5e9a3jUvaJCE/99KSE7UrKOUF7HK65s
         Ia2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZWOp9YkzixYgecOmqXGrI+9SqlolnceGoW074lDSTs/FEd3JkSpo2vInvxM9/JXJdsNf9CGw=@vger.kernel.org
X-Gm-Message-State: AFuF++lKsSalpsp/XjdM6QTKbBxJ5EFJ3Tl6/mLb9Zg5rcu89L7TToB/
	CtOaCheCSocmQFCCMQfCn/yi3wbMzu+DuGWfoJnOKxZYlHoGJiayJ1U=
X-Gm-Gg: AYBFou3FpONniLDJ/8UgUyzNHHu5IRK6SJ9ha8qY1gOHDHfBjg0ZL0S/mgJlogC44zd
	eJ84sZp07qz/zfj2pX+HTGuqErcMI3k6Mvz8pV3Y5VCOp9bj0bIKdUaqwfJEKvyVp5TkA1F3bS8
	IwrvUpfMg8Q99zJA+yZ0t5/4cBY/F4qYH4RB9w5TVCCoVgMCiaEx0byDvxq17aibhd+f//ch6ux
	Cwnc5tElQJU2kiu4GOJP/1BA8GO5weGOGpi9DwRz0zM6r/Yctm3DamZAX52ueyNyCoCAc9NGxz1
	5CVWmo8R5jEB3z12ZJB2T1Qm4CwkVg+tj7AZbKyhhdMoZv7asEWl/hQ50cp4C01hMLKLf2s79AO
	VzFlJ8u6VMBMfvGROvQRDEtsSZ896q0aNzfjtXdVAPmHFjZYJYy6pdnLi2Ae/ynsGRv0HIeIcQA
	OwR/WCx6i2yPErQ3AVYSzURqi3ljoEuiwxnVVITRbKA7/GFGIeKzzEPkPe79ZWx2sQyeovSGhVL
	nzezLHlBd9dXd4jyD9U9oSVeDyyTXLbnb8tXguYT4NSCrP4qb+9HqffR62MwmQKKQ8A+x8DRCQR
	V23Iuh1gQglSotSmOto0ZcpNMcN7
X-Received: by 2002:a05:620a:688e:b0:93c:58bb:7214 with SMTP id af79cd13be357-93cf19db19fmr657960985a.31.1790971272471;
        Fri, 02 Oct 2026 13:01:12 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca21d8fcsm309147885a.26.2026.10.02.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:01:11 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mhun512@gmail.com,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] platform/chrome: cros_ec_typec: Stop altmode work during partner removal
Date: Fri,  2 Oct 2026 16:01:08 -0400
Message-ID: <20261002200108.399258-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DisplayPort and Thunderbolt port altmodes queue work to deliver VDM
responses. Partner removal and port teardown do not drain this work,
allowing it to race with partner driver removal or access freed port
altmode data.

Disable and drain port altmode work in the common partner cleanup path.
Partner drivers can still queue responses during removal, so keep the
work disabled until they are gone. Clear pending response and DP status
state, then re-enable it for the next connection. Cancel the work before
unregistering port altmodes during final teardown.

Allocate list nodes before registering altmodes so allocation failures
also use the common cleanup path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: dbb3fc0ffa95 ("platform/chrome: cros_ec_typec: Displayport support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Quiesce port work in cros_typec_unregister_altmodes() before removing
  partner altmodes, covering disconnects and discovery cleanup.
- Re-enable work after resetting pending response and DP status state so
  port altmodes remain usable after reconnecting a partner.
- Cancel work in cros_typec_unregister_port_altmodes() during final port
  teardown, following the review suggestion to use cancel_work_sync().
- Allocate list bookkeeping before registering an altmode so allocation
  failures use the common guarded cleanup path.
- Drop the v1 Reviewed-by tag due to the reworked cleanup paths.

Previous version:
https://lore.kernel.org/all/20260917204209.97699-1-mhun512@gmail.com/

Validation: apply checks, whitespace checks and static source review.
No build or runtime testing was performed for this revision.

Remaining review point: an in-flight port active sysfs callback may still
queue work after the final cancel_work_sync(), before the port altmode
is unregistered. Please confirm whether that ordering needs additional
synchronization.

 drivers/platform/chrome/cros_ec_typec.c      | 27 ++++++++----
 drivers/platform/chrome/cros_typec_altmode.c | 46 ++++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  9 ++++
 3 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 50a68819ceb7bbfbd888ca919d678d4c75237c26..2d6cbb7f51445fde4b4e8339081e921a9a143a92 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -282,11 +282,19 @@ static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int po
 	struct list_head *head;
 
 	head = is_partner ? &port->partner_mode_list : &port->plug_mode_list;
+	/* Partner drivers can queue port work until their removal completes. */
+	if (is_partner)
+		cros_typec_altmodes_set_enabled(port, false);
+
 	list_for_each_entry_safe(node, tmp, head, list) {
 		list_del(&node->list);
 		typec_unregister_altmode(node->amode);
 		devm_kfree(typec->dev, node);
 	}
+
+	/* Port altmodes are reused when a partner reconnects. */
+	if (is_partner)
+		cros_typec_altmodes_set_enabled(port, true);
 }
 
 /*
@@ -366,8 +374,10 @@ static void cros_typec_unregister_port_altmodes(struct cros_typec_port *port)
 {
 	int i;
 
-	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++)
+	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++) {
+		cros_typec_altmode_cancel(port->port_altmode[i]);
 		typec_unregister_altmode(port->port_altmode[i]);
+	}
 }
 
 static void cros_unregister_ports(struct cros_typec_data *typec)
@@ -901,24 +911,23 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 			desc.mode = j + 1;
 			desc.vdo = sop_disc->svids[i].mode_vdo[j];
 
+			node = devm_kzalloc(typec->dev, sizeof(*node), GFP_KERNEL);
+			if (!node) {
+				ret = -ENOMEM;
+				goto err_cleanup;
+			}
+
 			if (is_partner)
 				amode = typec_partner_register_altmode(port->partner, &desc);
 			else
 				amode = typec_plug_register_altmode(port->plug, &desc);
 
 			if (IS_ERR(amode)) {
+				devm_kfree(typec->dev, node);
 				ret = PTR_ERR(amode);
 				goto err_cleanup;
 			}
 
-			/* If no memory is available we should unregister and exit. */
-			node = devm_kzalloc(typec->dev, sizeof(*node), GFP_KERNEL);
-			if (!node) {
-				ret = -ENOMEM;
-				typec_unregister_altmode(amode);
-				goto err_cleanup;
-			}
-
 			node->amode = amode;
 
 			if (is_partner)
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index 66c546bf89b532d3bae1de322a1cfb1205e0190f..4b255cabac60a406ea359788604a6bf21d87e08d 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -37,6 +37,52 @@ struct cros_typec_dp_data {
 	bool pending_status_update;
 };
 
+void cros_typec_altmode_cancel(struct typec_altmode *alt)
+{
+	struct cros_typec_altmode_data *adata;
+
+	if (!alt)
+		return;
+
+	adata = typec_altmode_get_drvdata(alt);
+	if (adata)
+		cancel_work_sync(&adata->work);
+}
+
+void cros_typec_altmodes_set_enabled(struct cros_typec_port *port, bool enabled)
+{
+	struct cros_typec_altmode_data *adata;
+	struct cros_typec_dp_data *dp_data;
+	int i;
+
+	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++) {
+		if (!port->port_altmode[i])
+			continue;
+
+		adata = typec_altmode_get_drvdata(port->port_altmode[i]);
+		if (!adata)
+			continue;
+
+		if (!enabled) {
+			disable_work_sync(&adata->work);
+			continue;
+		}
+
+		mutex_lock(&adata->lock);
+		adata->header = 0;
+		adata->vdo_data = NULL;
+		adata->vdo_size = 0;
+		if (adata->sid == USB_TYPEC_DP_SID) {
+			dp_data = container_of(adata, struct cros_typec_dp_data, adata);
+			dp_data->configured = false;
+			dp_data->pending_status_update = false;
+		}
+		mutex_unlock(&adata->lock);
+
+		enable_work(&adata->work);
+	}
+}
+
 static void cros_typec_altmode_work(struct work_struct *work)
 {
 	struct cros_typec_altmode_data *data =
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
index 3f2aa95d065af709643ad653df487a9987780da4..bcfd8fed2073dad1e95bfba807e1af7a4dbe91e2 100644
--- a/drivers/platform/chrome/cros_typec_altmode.h
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -11,6 +11,15 @@ struct typec_altmode;
 struct typec_altmode_desc;
 struct typec_displayport_data;
 
+#if IS_ENABLED(CONFIG_CROS_EC_TYPEC_ALTMODES)
+void cros_typec_altmode_cancel(struct typec_altmode *alt);
+void cros_typec_altmodes_set_enabled(struct cros_typec_port *port, bool enabled);
+#else
+static inline void cros_typec_altmode_cancel(struct typec_altmode *alt) {}
+static inline void
+cros_typec_altmodes_set_enabled(struct cros_typec_port *port, bool enabled) {}
+#endif
+
 #if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
 struct typec_altmode *
 cros_typec_register_displayport(struct cros_typec_port *port,
-- 
2.53.0
