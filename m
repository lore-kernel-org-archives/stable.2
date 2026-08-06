Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB818499F03
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054252; cv=none; b=u0UyMygtfOY0dirdLP/gRyguiekYcCU/zFMz7I3OZH7tR2HRAwVeS87VLWsSZrDJCqFaNAufbnrLsBTjKUazIcBD2jXh+xK/PIh1E5DlZ3kbGabo0HjBtD0jooADQ4ZYipwdG1yliWAYdhzWyfo+zDpOf+IPSk4rvFWaxZzbQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054252; c=relaxed/simple;
	bh=+o9QGjIip+mB0zT5m8VqWQBgDa+DKcbyBA/hKPuZl1s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HB7jXcC+B7KwZX6jA/I31ssBS2CNRcQq+4692+FoYec2WZiqaUYifn8dO8FXnVgAxrzjHQOnkt8eW/MnsGd6eeEz1V6RuJsyrmlPu+k6H55KwSpr9hwyi5JC/oML06Lp5mSXo7IXBt+PbFGf/lpy6LIOEhrwBoyDw3QLQIkiEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTN+4bkx; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTN+4bkx"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84870e7f498so2905468b3a.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786054250; x=1786659050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP2d7oDvPp3Hc8fnAHJj8Oo/Gn81Eu0dp5TtGDR52bc=;
        b=qTN+4bkxb18QYW0Fpbhrd23SrEuAF0EiyykAT622oEJT5AjQFKcacUTWxM8JzPfNyI
         6pMcpd1lYCwVGz+wZM9CHpriQikM6HbzKq5I9HZQTBoy8fiDLXMCG8zV66/fhZxsnpq/
         Tg/Q1+tiuYHdFPaxaSPq8qSGIySdOlbv2VIV/1ru1xgwiP0hWwMzDcxno5MarULPTnIZ
         k9gPqWn3Q3vYrJkz2ED81DPwRxfcuTi4zwWZ/6Fhtze0R0aIkZxP3T2ZrR9SVS4CL5xt
         IE0qPBpOMUlA6ndGjbN8XbVnn4/tmpe/XGYDUVad17byW6apAVJbaO5gXGoNjmOuz4PH
         YASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054250; x=1786659050;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vP2d7oDvPp3Hc8fnAHJj8Oo/Gn81Eu0dp5TtGDR52bc=;
        b=Ik9U1sfcnAcZ/AXbxcYi17wLX2tkkZ/2yXkv5E/2XqzD4DEsDwq6Tk+SbUNS+Bj5uf
         BmZyjMZ5SKvLfII0Kh5jZlnyJ15T6tuUx7MiOT1VcKNofMBuSaO0tIPc8tZX5ofmsz6L
         9i9rnJIKC2npbg7a26KAVoIO02OLn5pl9Or0IleT+ER+c4u4Ghzbv6blMgQLz9R29vus
         FlnSjXAGI7KxZDe1b1A7SN8D5VWCFqrOPdSFkQr+8iRB5TNTbyzw+K+8wxbtWr/NSycX
         5JqDX2RbmT6tDevM1GClVF9B9Xj13nLcIJM8d6CDz/p6WkWynlx+NFna+RIb97yWU1ZR
         EnEg==
X-Gm-Message-State: AOJu0YxzpcLpRMsg0RTNMSatgrz3/FkESsw4FgMAYqjnUmANWMJExfVc
	auBVk9iCn/jsd3g1ejnxw9jvqu2gek+QM+7BYu11rv1XPU1LSWCt4+/9UGttozE68pm8cB/Bi7S
	7O8r97smoNuk3AGpHDoWyjhY0t0Inz4ju7lRYxq9nIxFoPc68/4QX3Ux0VamxIW2dDRSH/66BDZ
	Yq35UeyLB6bQVghflN1ZEAT1todJvLUM4=
X-Received: from pgbcn6.prod.google.com ([2002:a05:6a02:a86:b0:ca5:80e2:129c])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1886:b0:847:99a7:c751
 with SMTP id d2e1a72fcca58-84f2e05d02dmr17681622b3a.25.1786054249492; Thu, 06
 Aug 2026 15:10:49 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:10:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806221044.1169839-1-tkjos@google.com>
Subject: [PATCH] Bluetooth: hci_conn: fix potential UAF in create_big_sync
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Sasha Levin <sashal@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 0beddb0c380bed5f5b8e61ddbe14635bb73d0b41 ]

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Handle the
resulting -ECANCELED in create_big_complete() and re-validate the
connection under hci_dev_lock() before dereferencing, matching the
pattern used by create_le_conn_complete() and create_pa_complete().

Keep the hci_conn object alive across the async boundary by taking
a reference via hci_conn_get() when queueing create_big_sync(), and
dropping it in the completion callback. The refcount and the lock
are complementary: the refcount keeps the object allocated, while
hci_dev_lock() serializes hci_conn_hash_del()'s list_del_rcu() on
hdev->conn_hash, as required by hci_conn_del().

hci_conn_put() is called outside hci_dev_unlock() so the final put
(which resolves to kfree() via bt_link_release) does not run under
hdev->lock, though the release path would be safe either way.

Without this, create_big_complete() would unconditionally
dereference the conn pointer on error, causing a use-after-free
via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ kept stable's `qos->bcast.out.phy == 0x02` context line instead of upstream's renamed `qos->bcast.out.phys == BIT(1)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Backported to 6.1.y: included inline helper hci_conn_valid() in
  include/net/bluetooth/hci_core.h from upstream commit 881559af5f5c ]
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
 net/bluetooth/hci_conn.c         | 19 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e67b1e5e0d2c8fb3c49696dd73e5fd6753412155..76764d399b23eff885e307148391c9cba5c6a4d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1069,6 +1069,24 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 	return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
 }
 
+static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c == conn) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54cfcab7636380a2ced55986a81b0240e9d48d87..aa5404412cbd34320f00954bda71dce65910793c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2088,6 +2088,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->out.phy == 0x02)
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2194,11 +2197,24 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto unlock;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
@@ -2223,10 +2239,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+	err = hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
 				 create_big_complete);
 	if (err < 0) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
 		return ERR_PTR(err);
 	}
 
-- 
2.55.0.654.g21b8a5bc05-goog

