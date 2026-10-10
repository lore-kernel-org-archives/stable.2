Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36B30BF70
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652600; cv=none; b=GacoELMUx2tfyAf8Z0H2FI8QSRvhUDmZpLb9eflVMwY0hk8N4yLJeApFr/QllLXuPVOMdNur6ZEFcVFRnhqjNeKN5tovWsYoPoGbDpvPU+mMOEBhLDZyO3e/C1BNxXliWvvehrkzVfLyIkQscW8nUr3B43OzHpVZ5vCGWoR8coY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652600; c=relaxed/simple;
	bh=qRQkoWyjxcoe8Yub8BihDAFoDQy3l0rzwTJat1+awQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uy5S9BCxzFZHWLoL6gDYsEb4BoJbvmvmxO8Jqaa0FjIiqZTyX3TTqVVU9mUKCICFO94rFL527VejaETBo5hzWTvyf0Yb1075GX26NiH44uscEN7WXEbi4E16fV/DbCzC6x7BxvooZ+JDjEmXBoQUzdlGECxVQ3Rk9lwYEjPTRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NILsnqIG; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NILsnqIG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15354aa70e8so935942c88.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791652598; x=1792257398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK3+R5MVAxUhsJSrVfq+GrGUfD5s5v+zFwmql3xSieA=;
        b=NILsnqIG6vlNxnu3GTrGXHl3xGccTuzKQuc4SP4NXr4EzvqLCD5UXguMk4m4n3pKcK
         PRu2RfTTdeEZRtxJ5dkFYleCQh5Q2AZ0NPxNP0LgySMwOqmigSnEyUDZaMHrdBsSxNOX
         iwucYZzhpWnO/lnqJ+uQS/pUFwGsu8dq/6F2xJuL8eG1R7SdrGAINWYv8Pqn64tPMYYK
         qVmf8GznPyazOZmLfXeOl7wSnbx8cg/F6628rlcQG2Xu1QZjyjTO0GBx+llwUywrD3f2
         M2fGSMl3ZV2EyWQGPAsIIuD4CSv81bB09ZzKuhJdX/rkPZPK4dNfAdBk/otACmYytE9J
         3Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791652598; x=1792257398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK3+R5MVAxUhsJSrVfq+GrGUfD5s5v+zFwmql3xSieA=;
        b=olRuGalb73DmyHM8jzK+Xujq0+O6aoxPRuIWgdl4KQq9risSg87BxcJX0u1TrHW+s2
         O4yLQ0eL9kGiHk1bp0X0Q7rPMTNj1CVmC9QJMSEZWXV0UANhmkjYQoU+ZLCGk/tmitwo
         bDMO741Z8G3AKzyFyEp421AK+yL8gUmj7wIV3WayeYnqgP0yY7fr07PlQ/W2+j7BXxmC
         6Bk53OmwwbwdG0L8HDkVr/4iZEycx+YIubetdzAgP7320dPOD8J1yvAlxnKtZThy+OaK
         ITivQXS8p1idWLhYR8zqnmBJUxQvoEYjIGg9Mmzi/P3uA04/KnPh0k/u8ks5N3+Mx4Cg
         zBmw==
X-Forwarded-Encrypted: i=1; AKwUvBzGldY/XZqJTpZ4F9lU2qoGxk4fjPRozJ8OaXFyFKah5iE1zalQ3APkCYVuCfSZjLX5nRwX4V8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLExvVBplBcYACctdW+4A9sH3R9ow+/b4YNw1dhAfw4EHMSX0br
	Eldjv08LEzfGvhtLz8Dt3rJybC9SeD6ffTndf9pPs+KfL541SgVY3dt6dsl1VWZh
X-Gm-Gg: AYBFou28YCogXVGcCHglV/AePLdwKNxrE5reGZi6iLCwh16wiJwCZHB729wP6tD8ntP
	ywGnsqqhtQgojZDRrCzsu0pyowUt8LXf+NHFGu/Ky4pgpN9RQYkVLZ0sbh+GmDSQe2WWGZS5fuj
	eZSNbTaliKmp1yNbc4xZm/p/QUVLl8gbHfEd04w6UMv0nE6Y0lM3StKUi3JOM1QEZCqaSDjD3Uf
	SA8E5XjRINY125HUuc6r5d2JIJr/ErElhPTjA6i1f1CUeYaKvTq1K5Qr57mJ9tB4evpQWWi5Ctb
	+4T5FdnTH8RxrBtaZjueLTHVHi0b3gC1uZUmVI8PQR5kA6v8TARLQLKxKnJemBD1dRG0zyMZR2U
	AJIwU5U19vXABIlBtD7aG218GGKEWnjpr7sJwG8qEPaGUcGrwVeS6cg8y3dS0NV1P4x0x3e4c2T
	G3d0PvFOhSuZk9efPzf1sWrhLjPkZuAhlUSg4sbVEIc6/P8XXKl1kf1ZuAQpIdi+0AK/5pq4Fd9
	AiQE+xSe4g2jOpGlFLJ66mNbVdLApJNRb9COhLwRAHFtyyXnQDOf042scx6vbPpe8OlTAWrUdLo
	+sSrQAP4Jhd2XGeYMuYfFdwsAKsjZejzrvPNPVmJVbCijiG4YXevKouroQVqtKMKMAdJn4/MEaF
	qqCdi8ctHawysAOCKbFQQpnqkbFmmFrwYn7/wfzn3f3p+MdrpGthUo7VOj+7r3CbCC4KB1SxoBV
	tKjKWcVFjbD515A+LTvfXq342RqN94IABe+GrB
X-Received: by 2002:a05:7022:b0d4:b0:143:2984:6518 with SMTP id a92af1059eb24-16a612bc1e8mr7592771c88.39.1791652598002;
        Sat, 10 Oct 2026 10:16:38 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-c00c-b850-f47a-b651-03fd-a578.dynamic-ip6.hinet.net. [2001:b011:c00c:b850:f47a:b651:3fd:a578])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm15344795c88.19.2026.10.10.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 10:16:37 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ting-Han Hou <ue081723@gmail.com>,
	syzbot+e69c25cf38a53d0cf64c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: keyspan: fix control urb double submission
Date: Sun, 11 Oct 2026 01:16:19 +0800
Message-ID: <20261010171619.1709-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control urbs used to send port configuration messages can be
submitted concurrently from several contexts: open(), close(),
dtr_rts(), set_termios() and break_ctl() run in process context under
per-port or per-tty locks, while the outcont and glocont completion
handlers resubmit when a resend has been requested. For the USA-49 and
USA-67 message formats the control urb is also shared by all ports of
the device.

The send_setup() helpers check whether the urb is busy by comparing its
status with -EINPROGRESS without any locking, so two callers can both
find the urb idle and submit it. The second submission adds the urb to
the endpoint urb list a second time, which corrupts the list and can
lead to the host controller driver spinning forever with interrupts
disabled when the endpoint is later flushed on disconnect:

  list_add double add: new=ffff88800ce63818, prev=ffff88800ce63818, next=ffff88800be7c078.
  WARNING: lib/list_debug.c:35 at __list_add_valid_or_report+0x157/0x200
  Call Trace:
   <IRQ>
   usb_hcd_link_urb_to_ep+0x1c6/0x330
   dummy_urb_enqueue+0x21c/0x750
   usb_hcd_submit_urb+0x228/0x1c00
   keyspan_usa67_send_setup.isra.0+0x531/0x710
   __usb_hcd_giveback_urb+0x241/0x400
   dummy_timer+0x1402/0x3470

The urb->hcpriv check in usb_submit_urb() only catches a resubmission
after the urb has been queued and does not prevent this.

Serialise control message submission using a spinlock so that the busy
check and the submission are atomic with respect to other callers.

This was found while testing the reproducer for syzbot report
5fabc1ae99ff40690d84 (a keyspan_close() use-after-free) under QEMU,
which emulates a USA-28XG using raw-gadget and dummy_hcd. syzbot has
also reported the same corruption from keyspan_usa49_send_setup().

Tested under QEMU with that reproducer and DEBUG_LIST, KASAN and lockdep
enabled: the list corruption was hit in 4 out of 38 20-minute runs
without this patch and in none out of 36 runs with it. As the race is
hard to hit, this is an indication rather than proof. Only the USA-67
path is exercised by the reproducer; the other message formats have the
same pattern but have not been tested.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e69c25cf38a53d0cf64c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=e69c25cf38a53d0cf64c
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/usb/serial/keyspan.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 4d3746c7a94e..84a428fc102a 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -537,7 +537,7 @@ struct keyspan_serial_private {
 	struct urb	*indat_urb;
 	char		*indat_buf;
 
-	/* XXX this one probably will need a lock */
+	spinlock_t	ctrl_lock;	/* serialises control urb submission */
 	struct urb	*glocont_urb;
 	char		*glocont_buf;
 	char		*ctrl_buf;	/* for EP0 control message */
@@ -2036,6 +2036,7 @@ static int keyspan_usa26_send_setup(struct usb_serial *serial,
 	struct keyspan_port_private 		*p_priv;
 	const struct keyspan_device_details	*d_details;
 	struct urb				*this_urb;
+	unsigned long				flags;
 	int 					device_port, err;
 
 	dev_dbg(&port->dev, "%s reset=%d\n", __func__, reset_port);
@@ -2056,11 +2057,14 @@ static int keyspan_usa26_send_setup(struct usb_serial *serial,
 	dev_dbg(&port->dev, "%s - endpoint %x\n",
 			__func__, usb_pipeendpoint(this_urb->pipe));
 
+	spin_lock_irqsave(&s_priv->ctrl_lock, flags);
+
 	/* Save reset port val for resend.
 	   Don't overwrite resend for open/close condition. */
 	if ((reset_port + 1) > p_priv->resend_cont)
 		p_priv->resend_cont = reset_port + 1;
 	if (this_urb->status == -EINPROGRESS) {
+		spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 		/*  dev_dbg(&port->dev, "%s - already writing\n", __func__); */
 		mdelay(5);
 		return -1;
@@ -2169,6 +2173,7 @@ static int keyspan_usa26_send_setup(struct usb_serial *serial,
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	err = usb_submit_urb(this_urb, GFP_ATOMIC);
+	spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 	if (err != 0)
 		dev_dbg(&port->dev, "%s - usb_submit_urb(setup) failed (%d)\n", __func__, err);
 	return 0;
@@ -2183,6 +2188,7 @@ static int keyspan_usa28_send_setup(struct usb_serial *serial,
 	struct keyspan_port_private 		*p_priv;
 	const struct keyspan_device_details	*d_details;
 	struct urb				*this_urb;
+	unsigned long				flags;
 	int 					device_port, err;
 
 	s_priv = usb_get_serial_data(serial);
@@ -2197,11 +2203,14 @@ static int keyspan_usa28_send_setup(struct usb_serial *serial,
 		return -1;
 	}
 
+	spin_lock_irqsave(&s_priv->ctrl_lock, flags);
+
 	/* Save reset port val for resend.
 	   Don't overwrite resend for open/close condition. */
 	if ((reset_port + 1) > p_priv->resend_cont)
 		p_priv->resend_cont = reset_port + 1;
 	if (this_urb->status == -EINPROGRESS) {
+		spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 		dev_dbg(&port->dev, "%s already writing\n", __func__);
 		mdelay(5);
 		return -1;
@@ -2287,6 +2296,7 @@ static int keyspan_usa28_send_setup(struct usb_serial *serial,
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	err = usb_submit_urb(this_urb, GFP_ATOMIC);
+	spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 	if (err != 0)
 		dev_dbg(&port->dev, "%s - usb_submit_urb(setup) failed\n", __func__);
 
@@ -2303,6 +2313,7 @@ static int keyspan_usa49_send_setup(struct usb_serial *serial,
 	struct keyspan_port_private 		*p_priv;
 	const struct keyspan_device_details	*d_details;
 	struct urb				*this_urb;
+	unsigned long				flags;
 	int 					err, device_port;
 
 	s_priv = usb_get_serial_data(serial);
@@ -2323,12 +2334,15 @@ static int keyspan_usa49_send_setup(struct usb_serial *serial,
 	dev_dbg(&port->dev, "%s - endpoint %x (%d)\n",
 		__func__, usb_pipeendpoint(this_urb->pipe), device_port);
 
+	spin_lock_irqsave(&s_priv->ctrl_lock, flags);
+
 	/* Save reset port val for resend.
 	   Don't overwrite resend for open/close condition. */
 	if ((reset_port + 1) > p_priv->resend_cont)
 		p_priv->resend_cont = reset_port + 1;
 
 	if (this_urb->status == -EINPROGRESS) {
+		spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 		/*  dev_dbg(&port->dev, "%s - already writing\n", __func__); */
 		mdelay(5);
 		return -1;
@@ -2464,6 +2478,7 @@ static int keyspan_usa49_send_setup(struct usb_serial *serial,
 		this_urb->transfer_buffer_length = sizeof(msg);
 	}
 	err = usb_submit_urb(this_urb, GFP_ATOMIC);
+	spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 	if (err != 0)
 		dev_dbg(&port->dev, "%s - usb_submit_urb(setup) failed (%d)\n", __func__, err);
 
@@ -2479,6 +2494,7 @@ static int keyspan_usa90_send_setup(struct usb_serial *serial,
 	struct keyspan_port_private 		*p_priv;
 	const struct keyspan_device_details	*d_details;
 	struct urb				*this_urb;
+	unsigned long				flags;
 	int 					err;
 	u8						prescaler;
 
@@ -2493,11 +2509,14 @@ static int keyspan_usa90_send_setup(struct usb_serial *serial,
 		return -1;
 	}
 
+	spin_lock_irqsave(&s_priv->ctrl_lock, flags);
+
 	/* Save reset port val for resend.
 	   Don't overwrite resend for open/close condition. */
 	if ((reset_port + 1) > p_priv->resend_cont)
 		p_priv->resend_cont = reset_port + 1;
 	if (this_urb->status == -EINPROGRESS) {
+		spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 		dev_dbg(&port->dev, "%s already writing\n", __func__);
 		mdelay(5);
 		return -1;
@@ -2595,6 +2614,7 @@ static int keyspan_usa90_send_setup(struct usb_serial *serial,
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	err = usb_submit_urb(this_urb, GFP_ATOMIC);
+	spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 	if (err != 0)
 		dev_dbg(&port->dev, "%s - usb_submit_urb(setup) failed (%d)\n", __func__, err);
 	return 0;
@@ -2609,6 +2629,7 @@ static int keyspan_usa67_send_setup(struct usb_serial *serial,
 	struct keyspan_port_private 		*p_priv;
 	const struct keyspan_device_details	*d_details;
 	struct urb				*this_urb;
+	unsigned long				flags;
 	int 					err, device_port;
 
 	s_priv = usb_get_serial_data(serial);
@@ -2626,11 +2647,14 @@ static int keyspan_usa67_send_setup(struct usb_serial *serial,
 		return -1;
 	}
 
+	spin_lock_irqsave(&s_priv->ctrl_lock, flags);
+
 	/* Save reset port val for resend.
 	   Don't overwrite resend for open/close condition. */
 	if ((reset_port + 1) > p_priv->resend_cont)
 		p_priv->resend_cont = reset_port + 1;
 	if (this_urb->status == -EINPROGRESS) {
+		spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 		/*  dev_dbg(&port->dev, "%s - already writing\n", __func__); */
 		mdelay(5);
 		return -1;
@@ -2738,6 +2762,7 @@ static int keyspan_usa67_send_setup(struct usb_serial *serial,
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	err = usb_submit_urb(this_urb, GFP_ATOMIC);
+	spin_unlock_irqrestore(&s_priv->ctrl_lock, flags);
 	if (err != 0)
 		dev_dbg(&port->dev, "%s - usb_submit_urb(setup) failed (%d)\n", __func__, err);
 	return 0;
@@ -2795,6 +2820,8 @@ static int keyspan_startup(struct usb_serial *serial)
 	if (!s_priv)
 		return -ENOMEM;
 
+	spin_lock_init(&s_priv->ctrl_lock);
+
 	s_priv->instat_buf = kzalloc(INSTAT_BUFLEN, GFP_KERNEL);
 	if (!s_priv->instat_buf)
 		goto err_instat_buf;
-- 
2.53.0

