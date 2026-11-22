Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795340161;
	b=DkrMhJPR46iul4l7h1Ql8hcyrp3BQZB5X7evC3NItbKNA1RuJvaYm3wkPTE/rQZaZx0Q
	 j2ay5mcgrNkKCZzOuvYRMZftoYbr/yd1EAk39JYeaJLUYBIB3ffa7nqffUK/ZY6SvBy+r
	 SJ6k23ICozKwNuWQatAx+nLH02/Z4HMtoGWwn4FCjjIllOeu+dKUkY6JCSqcqCuAk/9ro
	 siyf+urIncXBGLQlVjDnZvxM6r8FIHFWBA0tP0aXl2ibxlBhkAignDT4MAuYq1J6K1W58
	 +Sa2C32hsc7j8wRoDxhyL5uRrcgpGFxni04K/F2nJDy0txI0EqLAxtHJkZNDy15OHOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oFLBgFCgmaxQmxWfb6LVRPsrv/iiQMDieM1Nl0PLyM4=;
	b=Hyk2aO9P2qnLHtQCRdrFQwb8YRTCWZkYQVrNs5SUaw71BE+akARwLE62YvQs/ms5GcGD
	 obNWmmhpmeZ4G9jETRQ0WVgL9oqka8LTgMzZr4Yjw5ivrzh39PVZ7rRpTiHBTudZLDdpe
	 cY3733qykfKXvzFz7kK71Q1PEWHjPa21BHTenzEZ9rECbr7S0oILcQUVoWXRuYujYPky/
	 VyuaEC5LYe3UeOaux/Waa7gJq76pL9Go3T0mIYqyguf0oFCzo1c4n3wqdi8fs7A05ABfA
	 bGDdo1OX4OG4pSStCqW9/WN2KQBQqK1iT8xq55nJgIQwTVDArTIJ9yrQv49oUHkmc0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftJiMAXT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FD606A320;
	Sun, 22 Nov 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftJiMAXT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795340161;
	b=xnmLF9y3FPkwsK8HUfwxvNk8TJoEz3uz/G3OaK95IpEsjbK3SRnQl+yF+dscdTbjQ0DM
	 g6+5R33Wz33U52JMoDaTgCQcE3fJ5fhmQdX3jjKIOOn4G90cPNFBAlqFYtLPsf6w1BLr9
	 LEu9KSkQFPfqVWqzMW7XcRyfcmTkQPF2dmDscWzppjkRT+1D/ETGvaeA0wbZ5SS4E9Lrj
	 /hmVci4m1yZi5dKM8rPZINw5C2vQzTb9vecmXaKap5twkpnlqfM7CtxPksSsB//fUoCtF
	 rrZyun4kc5X6StNpJ/hXvn6myArS6seqHznny+KiRztKczhCTbaw3BZIAdrJuCWTBOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795340161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=oFLBgFCgmaxQmxWfb6LVRPsrv/iiQMDieM1Nl0PLyM4=;
	b=N5hiBMx/PJgVbi2Sc9TUr9xipQk1TyS7H414VVjRxDw5MupAhGnG/S4/9BtZQFqDIw3B
	 7ky4jQ+QbblK/BPvTtqqdwVPREV1jdVw7dBTiDuqg4BdNYeDASUE4cgBQHLKt0jqtFMzF
	 xKgkRmH+6SgikNnGkN/jEQjxDZaBXp9mzCDJK130UEK08Utz8CbIm6Djpi6PRBCu2RNqu
	 IBbr1B7CdFJ3isUCJ4VngUKsBq6wrOVnvV49mj0T4AbrZFvRLW3s6PFujGavDvAbKOrk6
	 9DB73yBJy/3YypbUk5c+H/68GYwRf3DGDcfHzFCAdfgJN/YZtHuUfZsYQY1laMX0OZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C62821F000C0;
	Sun, 22 Nov 2026 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795340161;
	bh=oFLBgFCgmaxQmxWfb6LVRPsrv/iiQMDieM1Nl0PLyM4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ftJiMAXTy9XlnisQASWuKvcQsP8NdVpRUdRSFVMdG1EmCZVNa9sjZgSqhcEGTgqFO
	 TInzAJVY06YUSQqex4/veB6THoTiFvVLVvmmT/2eOcNaZMFu343uZHw5JnWyWQjz++
	 9KWRhShLnIFwMUOmrcBFXsALZOBJfj8j6Cl/FSd0A6vWCiKNrTvYhbJ5ivfGo0kBAo
	 lCMSnzx3Iy6nciIq2E72qIbZHFFqZ+BX+B6NZn6xMlxr//hNeBS1qVBADPVwU6xS/K
	 eugant2dvdPktc8A4htDPplDBSPNlcC1Yc+gFIn0mUG8ahM8Q6npWrTqWPG4Dg9ZR9
	 AYMyHl8fEM12w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 282CE4BFDB;
	Sun, 22 Nov 2026 09:36:00 +0000 (UTC)
From: Leicheng Xie via B4 Relay <devnull+leicheng.dev.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 17:33:29 +0800
Subject: [PATCH] Bluetooth: RFCOMM: Fix slab-use-after-free in
 rfcomm_dev_add()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-fix-rfcomm-dev-add-uaf-v1-1-cac5354752ed@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOi2AmsC/x2MywqAIBAAf0X23EJr734lOoiutYcylCKI/j3pO
 DAzDySOwglG9UDkS5KEPQMVCuxq9oVRXGbQpW6JtEYvN0Zvw7ah4wuNc3gaj9Zz3VcddTQ0kOM
 jcjb/8TS/7wdFmz/PaAAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Gianluca Anzolin <gianluca@sottospazio.it>
Cc: linux-bluetooth@vger.kernel.org, 
 syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Leicheng Xie <leicheng.dev@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795340012; l=3276;
 i=leicheng.dev@gmail.com; s=20261122; h=from:subject:message-id;
 bh=wPiurJf5NAB3Lu8Avk81ILeINiSohz9dvVjdRquJVBo=;
 b=6Q+PSt3gaZkOQ7tAFw438TjcTSry2NO0bq7tgnocaG0Af45XxeX3tdpcInxYtCuzgXpbMPTwT
 b45gFQpGmg0DdahRCUttX80fmnMY/QBYxfLGSnB+OANXrPmPYYwCe7I
X-Developer-Key: i=leicheng.dev@gmail.com; a=ed25519;
 pk=3Wc835kaGsdFoMvE39Cn0NKn+/y+alxEDJs7LjGUmis=
X-Endpoint-Received: by B4 Relay for leicheng.dev@gmail.com/20261122 with
 auth_id=1600
X-Original-From: Leicheng Xie <leicheng.dev@gmail.com>
Reply-To: leicheng.dev@gmail.com
Content-Transfer-Encoding: 7bit

From: Leicheng Xie <leicheng.dev@gmail.com>

__rfcomm_dev_add() inserts the newly allocated struct rfcomm_dev into
rfcomm_dev_list and releases rfcomm_dev_lock while holding only the
initial tty_port reference. Back in rfcomm_dev_add(), the device is
registered with tty_port_register_device() and further initialized
(dev->tty_dev assignment, reparenting, drvdata, sysfs attributes, and
reading dev->id).

When RFCOMM_RELEASE_ONHUP is set, a concurrent task can open and close
the RFCOMM TTY device as soon as it becomes visible on rfcomm_dev_list.
rfcomm_tty_install() takes over the initial reference by setting
RFCOMM_TTY_OWNED, and rfcomm_tty_cleanup() drops it to zero, freeing
dev via rfcomm_dev_destruct() while rfcomm_dev_add() is still running:

  BUG: KASAN: slab-use-after-free in rfcomm_dev_add
  Write of size 8 at addr ffff88800e85b3e0 by task rfcomm_uaf_poc/179

Hold an extra tty_port reference in __rfcomm_dev_add() before dropping
rfcomm_dev_lock, and release it at the end of rfcomm_dev_add() after
caching dev->id. On the tty_port_register_device() failure path, use
test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status) before dropping the
initial reference to match __rfcomm_release_dev() and prevent a leak or
double-put if a concurrent open took ownership.

Fixes: 5b899241874d ("Bluetooth: Release RFCOMM port when the last user closes the TTY")
Reported-by: syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=11542ff1d167fdffa1fc
Cc: stable@vger.kernel.org
Signed-off-by: Leicheng Xie <leicheng.dev@gmail.com>
---
 net/bluetooth/rfcomm/tty.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 198c7dd1a95b..3a61c45b5b51 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -303,6 +303,9 @@ static struct rfcomm_dev *__rfcomm_dev_add(struct rfcomm_dev_req *req,
 	   holds reference to this module. */
 	__module_get(THIS_MODULE);
 
+	/* Hold an extra reference for rfcomm_dev_add() until setup completes */
+	tty_port_get(&dev->port);
+
 	mutex_unlock(&rfcomm_dev_lock);
 	return dev;
 
@@ -316,6 +319,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 {
 	struct rfcomm_dev *dev;
 	struct device *tty;
+	int id;
 
 	BT_DBG("id %d channel %d", req->dev_id, req->channel);
 
@@ -328,6 +332,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	tty = tty_port_register_device(&dev->port, rfcomm_tty_driver,
 			dev->id, NULL);
 	if (IS_ERR(tty)) {
+		if (!test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
+			tty_port_put(&dev->port);
 		tty_port_put(&dev->port);
 		return PTR_ERR(tty);
 	}
@@ -342,7 +348,10 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	if (device_create_file(dev->tty_dev, &dev_attr_channel) < 0)
 		BT_ERR("Failed to create channel attribute");
 
-	return dev->id;
+	id = dev->id;
+	tty_port_put(&dev->port);
+
+	return id;
 }
 
 /* ---- Send buffer ---- */

---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261122-fix-rfcomm-dev-add-uaf-cfe483717195

Best regards,
-- 
Leicheng Xie <leicheng.dev@gmail.com>


