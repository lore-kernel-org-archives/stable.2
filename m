Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02A377EA2
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154231; cv=none; b=jj8Q/nV85t/BwW5zVtMuHCyKBcwI1qRELkIuKfgXuw/1IaEjZ0N8DrDSNuAaX32EBpg6DfF7mNImPZ/MyeFZ73GPMPore2UQR6bsfDBzRZ1Mefxy0lY7D2XRZEyIoAjxhOdZ+WtWQPw8xzg4fURlMTtj1f20PQzmOdTy7AdgrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154231; c=relaxed/simple;
	bh=41m4eZr98ZS4+ChcPMOE6llvIl9fhqsMcrIQxRy1N9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j04ssEqhlMbrJkeu0WLj7J0s+PXABshHJGTAKmmqA+csnT0TkGfwiuZ5dJDr/lC0rCcqablLugTblQLKf/TjkBi77W/kO1dek98Io8MJwaGlSTKWqYSfboVIMVszOsoGhmZ4FToBd02WhfNj2gb9miuGwgGoTnvtSCzygZSNMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso11060845e9.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154228; x=1785759028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=golEXU1+BL8SymczTDciNAwJvaEVruf5+6aSnIpz30M=;
        b=Irap1IY0ZQ63I1EHafnfBlJ8uCzgGWXcLY7ka2u8Xjw4KVNqPDQJH5EJm3dUYPb5aw
         IJDhZdA5ORECJX6N+f+yIzna3X5/ugnevSSpJumt7hum3NbhxZHDpBr3npnvfyC2eqQl
         kVonUMIu21vE4VIe+3x+zvwsUhRj3OeQza5ZkFUk4KKdfFywffwueF16a3kwktwK53kB
         1nT/9E9l3Oxx4YQfP2L0zJUp4SqBkme94fUDeAd/KyeL3GrNiH8DTSeuNHmjAirtsoMO
         qFCLsu5Izt0Srztg4THA3KTzvk4HgD5qJ/9+Z+Ws80S4GfOq2QTuBG1baY3SM2JOgy+F
         +xtA==
X-Forwarded-Encrypted: i=1; AHgh+RoUGFOKFvpKsNAUyozYih0iw9lRBMVqEV1F/d1D7pDUUh2oGv8bDJwLxDm/sHv9enZjzYAx5M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gINTy3yYa1aXippdw8pDeA/Qg/Ucpjh34qzEHJnin8S9y0Lo
	edqc4aH2+/mPySGNMizGQTXNLsg9xJdhlY6nWWuAfoEZubCVujk0pHiK
X-Gm-Gg: AR+sD13hXbDdTbUWcgUdSo/ze2KmhsuGeUgWSAWFXiul99i+6rF4u/fYVbtzFbnxlwh
	dVdbcJMH+Dnj25R7HoGxse/+bdMVFZNx9T8Rih8TBDqWbTPRPcnQqEbTYSnGenjF+KwHKsCEF7w
	x4SGrxLhVar67EsURkDbOAHVIAjxhU7khuUSXg+DiLQuTfBOFNFg4FRhWT4kC42wuW9EPiNKrx4
	/SX0xI+NomlRGTchiOwFd46m4FAMioKyWcHnBGKPBlZdzjiH5X+VhAMluuaAOGojZyn3Or3sKp+
	Dbie8yaSSAeT6cD4sUDO3br/j4Nmc0o+h+IpM193nEgllGGMDTGfBTUdOpo1lV2zZMAQi/442CI
	+vfBA0gTbhIc1/aXQQXu6KKap7FprUjxfnp8/iKFfVDK2ZTX7pGhaSxz8tCC+6i2UQ3XyGBd2yP
	NUqpKhUXxgORGChZKD2uDBqXfwaHRyrbXxd+LZKh/SW5P8KB4f9vJOUw==
X-Received: by 2002:a05:600c:1c07:b0:495:7561:a9ed with SMTP id 5b1f17b1804b1-496b56c89dcmr110977965e9.17.1785154228261;
        Mon, 27 Jul 2026 05:10:28 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm220012685e9.4.2026.07.27.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:10:27 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net: openvswitch: fix potential UAF on meter attach failure
Date: Mon, 27 Jul 2026 14:10:21 +0200
Message-ID: <20260727121022.198461-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While attaching a newly created meter attach_meter() function makes
the new meter visible to other CPUs but can still fail afterwards.
On failure, it detaches the meter back and returns an error.

However, this is an unexpected behavior for the ovs_meter_cmd_set()
that uses a plain kfree(meter) on attach failure without waiting for
RCU readers to stop using it, assuming it was never visible.

This is never a problem for ovs-vswitchd as it always creates meters
before creating any flows that use them.  But the UAF can be triggered
with a custom application using uAPI:

 BUG: KASAN: slab-use-after-free in ovs_meter_execute (net/openvswitch/meter.c:653)
 Read of size 8 at addr ffff88810d152650 by task meter/2508

 Call Trace:
  ovs_meter_execute (net/openvswitch/meter.c:653)
  do_execute_actions (net/openvswitch/actions.c:1407)
  ovs_execute_actions (net/openvswitch/actions.c:1584)
  ovs_packet_cmd_execute (net/openvswitch/datapath.c:703)
  ...
  netlink_sendmsg (af_netlink.c:1900)

 Allocated by task 2519:
  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
  ovs_meter_cmd_set (net/openvswitch/meter.c:422)
  ...
  netlink_sendmsg (af_netlink.c:1900)

 Freed by task 2519:
  kfree (mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
  ovs_meter_cmd_set (net/openvswitch/meter.c:479)
  ...
  netlink_sendmsg (af_netlink.c:1900)

Fix that by making sure attach_meter() doesn't make the meter visible
until all the checks are done and the function can't fail anymore.

This also makes sure the "hash" value is calculated after the potential
re-sizing of the table.

Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-31642.

Fixes: c7c4c44c9a95 ("net: openvswitch: expand the meters supported number")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/meter.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index a02c47277337..4aaeeae3af5b 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -133,18 +133,10 @@ static void dp_meter_instance_remove(struct dp_meter_instance *ti,
 
 static int attach_meter(struct dp_meter_table *tbl, struct dp_meter *meter)
 {
-	struct dp_meter_instance *ti = rcu_dereference_ovsl(tbl->ti);
-	u32 hash = meter_hash(ti, meter->id);
+	struct dp_meter_instance *ti;
+	u32 hash;
 	int err;
 
-	/* In generally, slots selected should be empty, because
-	 * OvS uses id-pool to fetch a available id.
-	 */
-	if (unlikely(rcu_dereference_ovsl(ti->dp_meters[hash])))
-		return -EBUSY;
-
-	dp_meter_instance_insert(ti, meter);
-
 	/* That function is thread-safe. */
 	tbl->count++;
 	if (tbl->count >= tbl->max_meters_allowed) {
@@ -152,16 +144,29 @@ static int attach_meter(struct dp_meter_table *tbl, struct dp_meter *meter)
 		goto attach_err;
 	}
 
-	if (tbl->count >= ti->n_meters &&
-	    dp_meter_instance_realloc(tbl, ti->n_meters * 2)) {
-		err = -ENOMEM;
+	ti = rcu_dereference_ovsl(tbl->ti);
+	if (tbl->count >= ti->n_meters) {
+		err = dp_meter_instance_realloc(tbl, ti->n_meters * 2);
+		if (err)
+			goto attach_err;
+
+		ti = rcu_dereference_ovsl(tbl->ti);
+	}
+
+	hash = meter_hash(ti, meter->id);
+
+	/* In general, selected slots should be empty, because
+	 * OvS uses id-pool to fetch available ids.
+	 */
+	if (unlikely(rcu_dereference_ovsl(ti->dp_meters[hash]))) {
+		err = -EBUSY;
 		goto attach_err;
 	}
 
+	dp_meter_instance_insert(ti, meter);
 	return 0;
 
 attach_err:
-	dp_meter_instance_remove(ti, meter);
 	tbl->count--;
 	return err;
 }
-- 
2.55.0

