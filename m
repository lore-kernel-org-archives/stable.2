Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A92442FC4
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391513; cv=none; b=kcMkJRNXiJaC8PHy4tIzN67U1EsJDWINdg5ivnY7Cg7NmdNI0VXF9HqbObQAz9H1u2zsdtVyA12vdEJnygRplqJ+HivnFqtKK/GQeYqk4cdKBhRnlt3lafRm0XCESdeLK66kJm+Mp3lQOloMuOXqGOJq8GSk/15xerX0BxzdtD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391513; c=relaxed/simple;
	bh=LXPZ43UIfOe36vHQ2wxB7JyDoHqg9kjSChHWnFuwlb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EQ2hdOPUjC1vuDzWL11ajaJeb2E/N6ysDdN097XDghDNSXoC/gvQtbc9A3nw3ac6cxeLEPvGPJSoZ1JYfEoIA5/KZCabEnignt1ihy2bBYxmzM6BM4t/Zv60YytIuBGXTBakdBj0A0Olj/iYoshL8V3n4YfTmlOhuq+cdpDNTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gay9BgCh; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gay9BgCh"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e4ef486c7so196648b3a.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786391511; x=1786996311; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2ED+jOLQWClosWyz1TVlbOyLKljQeYIvXIP5gUb9VA=;
        b=gay9BgChXoqh67A77yL5kKICTVbdeW1QGcn8+00QVQPHm6rIAMMs4deZH7gHXlHDKs
         spu+mxlgdZY899pwQj3KdIVdWYmuFRh7LQfo1T5K3NPKbIH/XqJAL6dzMNbhnwUzH4Rn
         f1G5L4tHsVUH/O2px5cgdvMWCB/PrIPdKo6U/qXmT3HFJ/NABeFblUPfnsqJ+xsASLiw
         RTn1jDrE30Zsz6TQz1ScsH0MPKw7KkO0o+17wZEhC1ezSpI4lPhH58hpijaGDBqkCmoN
         pYwe4avLPLR1doYLKPMFGZTnd+TpHW6PpsoLdIPtK2n+YKjOK/G6CdlEx6fWWW6sq145
         fJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786391511; x=1786996311;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2ED+jOLQWClosWyz1TVlbOyLKljQeYIvXIP5gUb9VA=;
        b=G1vG36QBGi28WZWQDREtaCEy98yrbZz5jwRu31it5g05nKf4LPLz1DqKMKpoNUKP3B
         Tn0wxDceO8RzQkHG92LLzHttaEVpaEL8vjOeba3V6zmBxAtDoeZ80a74OI25/8tIEbs+
         h4WxIfevekW3Ve8NRdJk86sbAhW9Xlap5FiUt+bjcD/o49QnnoA7BcP56jV6YQZlQxJ/
         v6g1Q3ZUpsbwYjAomIKFY06FvDAshhNdOcdrTSIJIMQ2QtI0T4oh92rsXi/Ev/s11oYP
         R6nTSq+QDfrQMqIMZrIJI29Vv87ZmxSvCa7FC4cRHykG3Mo0x8pp/pBaLOz7Bahect4t
         Vcmg==
X-Gm-Message-State: AOJu0Yx8Y3sChGkFp1UvCasCh5SJ2eh61QJdygJCqRpkIIKGH5RhBirX
	mq0FweRaW9qFx2Tg7YWV1wT0SudLUGSaOJuCVLotnctcXHuKcXFPfh56vWZSdGCaJKnOGkvD+kY
	7rKhm5wj3/jWJuCKm6oznR47+hsSyXI11HEN6Gj39HvRI9P7TTDZBJCArz1/b1YVit7xixvhLvK
	0Rahl2h0jgsLC3vkjPFfDXYU7VptnPYNg=
X-Received: from pgvh24.prod.google.com ([2002:a65:6398:0:b0:c99:5ef4:543])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d8c:b0:848:452d:9a14
 with SMTP id d2e1a72fcca58-84fa18ad390mr1015710b3a.16.1786391511159; Mon, 10
 Aug 2026 12:51:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:51:47 +0000
In-Reply-To: <20260810195147.4121080-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810195147.4121080-1-tkjos@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810195147.4121080-2-tkjos@google.com>
Subject: [PATCH v2 2/2 5.10.y, 5.15.y] Bluetooth: 6lowpan: Fix using
 chan->conn as indication to no remote netdev
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marco Elver <elver@google.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
conn ref") don't reset the chan->conn to NULL anymore making the bt#
netdev not be remove once the last l2cap_chan_del is removed.

Instead of restoring the original behavior this remove the logic of
keeping the interface after the last channel is removed because it
never worked as intended and the l2cap_chan_del always detach its
l2cap_conn which results in always removing the channel anyway.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2:
- added this patch to the series which fixes 1/1

 net/bluetooth/6lowpan.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9424d153f323fdfb1453d18ef7821ccddaeaa5eb..d0b1882f5b4b77d274580a0e8af7a3d43972615d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -775,20 +775,10 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	struct lowpan_btle_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
-	bool last = false, remove = true;
+	bool last = false;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
-	if (chan->conn && chan->conn->hcon) {
-		if (!is_bt_6lowpan(chan->conn->hcon))
-			return;
-
-		/* If conn is set, then the netdev is also there and we should
-		 * not remove it.
-		 */
-		remove = false;
-	}
-
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
@@ -815,10 +805,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		if (remove) {
-			INIT_WORK(&entry->delete_netdev, delete_netdev);
-			schedule_work(&entry->delete_netdev);
-		}
+		INIT_WORK(&entry->delete_netdev, delete_netdev);
+		schedule_work(&entry->delete_netdev);
 	} else {
 		spin_unlock(&devices_lock);
 	}
-- 
2.55.0.679.g6767b8d81c-goog

