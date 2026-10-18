Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E83E3C5F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366045; cv=none; b=uTz4tPX1yQegWapgAIbs36pMoEUQw/np4EYFvdFKjhyHUSHRWwUKn2vEQd/HSGjhEbVY2uAZ2yzt542bU7GidZbFsMD5TcbY03a1hPTG6stYNFtTDOi/T9iFXPghXF18BAlVc8+yloqiVjNWwOXJR6WvO+uh7pB1jhlDUVp78Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366045; c=relaxed/simple;
	bh=msWSNku5OlvN9yv4YElxcsCldoxv5uxWn4tihBzqttA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDVWhmO5pAihUmB1oPFMrpeLyOzI3l9qMaV6r/iqh1ZTc0NJ86cDE+zl3CoUXMI/9jCH2R2yIapbnUYFak6Jwzmgse4racCDxJ2nmz+uvqSTAOVjkk7LSpd/qIAKxxrd9GfllBAtE9jBLA9ytnLdBM2XIlSa0L4BzgZ6CsHNLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7fp7/PM; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7fp7/PM"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35c76e9614aso2903782eec.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366044; x=1792970844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWVaE8AeAPWzwHM66+gk5xCbOk1oz8k7V+7bfxLXR7E=;
        b=a7fp7/PMW7dyJJaLc3CeyMOrSriumvyDYjJW9EUgLorAR1rm7Ur3Utr8rTz5X1up0t
         Pu/O/06VINamH2dsz70P2j6pecyQUI1Q6eP0kUnVdC4w0lrLM9WxWberGxYCkVbOQjEo
         0pGyVh1N65cWJDB5c3eqYGDFiyr1nlmwJ8kBG5R9rWBhr0uLenQx5pGCadU7cAGfw4bI
         BJ7fvq5XuqnfNqqOG76dMX+4IOXr7u4acA4syrsIgbYOHlt5jSLKYlx2LvdZDnuyUvbg
         X8LzzPiFOhxbGaJb2R+ifQBSm3mvyf5eL4BuAUI0m7ZzGRhJLvJzLhUyi8u4cgnNScqn
         Im3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366044; x=1792970844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWVaE8AeAPWzwHM66+gk5xCbOk1oz8k7V+7bfxLXR7E=;
        b=bBCHdqkaOD80Ebv7847tudnE+1Jvu8MhmPddeAFc8L0aCxL61zxY2N3Sg5rin4vWOk
         H1a0HafVnh3E+l1+OQysBrKATsUumdlTgGMFrbjSC/6pl8pyWxINvxFhnaw0ykvheCc3
         dNqpC+zhY8BS3gWRdCpp2NkmpMHUr82T9RoTjhcec4Oyx0zLA2QfG531bEzYBp4YLvTh
         5ZyLVP1Vj5rhXJta46AFADxCilcCc7kP1AEZcbvqSZu8OIqK3zuJDt/J6VTmHsoLd4Fq
         DgFKeT4O/9SkukpZWCIQjxh2pAgYiTjseRADmJTNlkgXUWArlFCdqAv5fK+5bup957UA
         HgOA==
X-Forwarded-Encrypted: i=1; AKwUvBzlSyBREsKTzGp/t7FnvoOAr54ZYBaMrF9180jrz+qOVAQGbxwX6rLqyDnifpziLcfi5vWkHks=@vger.kernel.org
X-Gm-Message-State: AFq9FYIr1AFMc5Gpmoptfdkd6gxRDMo7YjvoqaWoswjsQ71XbhWfzg8t
	sB2tURlGL1D7JIpIMrpe+wDlgsVngAYhYY09gvbMFX7wjedFw+C8bUjN
X-Gm-Gg: AYBFou2O1KsLCE+p57VmdbJW4sbAWdYmRdIBp/wXRZkoTF22niCAuceaWi5zLTN+cq1
	GZmq5IxKxWWioj/qDyJEXXg6Gi0Q/NKGBKC6mLnmrHKBE8d7YEZ9gtb2LwQIV7GUTE5/cbkXlxK
	88Y5tT8EkCBfDVsRxeCUuKkf1NLBqji6DOEx55nG8PoEJyle+w+HDtKpdq5qt0YcxZlmlh0VYAI
	7IMg0IQN9nVcsNjg22+5/Fiv8I9cX4yCnOuzUXNuTu6dr0SIjIAh7gJAFLGqYthei/x2JHN5xb1
	9qHV2jjR2ewMHSTdvrspi2/XLLa/sjrK0Lhc9kFQzOH7bSu47UJJfnT/66sduTge0OdufsLNo1E
	oP7cvvyjBlN1ggBiQvGp8sxI+TabF3ejyXfA0MRTpHTCSM0yDEjscCtbTcnziTrCA2UxQ99dPx0
	o89FYlUiYaCJgbhBy/D7P/H7r7Bie/cPehwts2LgM7CMT9Fr68xCp5odvHvkpkuQ4LrkFCndAbE
	JKQKfkIomJNCZIOqi99d+uC6UPUFbDgKd13rau3Zug=
X-Received: by 2002:a05:7300:7aa4:b0:35e:43fa:eea3 with SMTP id 5a478bee46e88-361a137072dmr9070108eec.8.1792366043791;
        Sun, 18 Oct 2026 16:27:23 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm25571908eec.9.2026.10.18.16.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:27:23 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>
Subject: [PATCH v2 1/2] HID: logitech-dj: Don't add Unifying devices from HID++ notifications
Date: Sun, 18 Oct 2026 16:26:53 -0700
Message-ID: <20261018232654.70571-2-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018232654.70571-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
 <20261018232654.70571-1-markpariente@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unifying receivers (recvr_type_dj) announce paired devices through DJ
"device paired" notifications, which carry the full bitmask of reports
the device supports. Before commit 74808f9115ce ("HID: logitech-dj: add
support for non unifying receivers"), HID++ reports for a slot without
a known device were dropped. That commit made HID++ 0x41 "device
connected" notifications for such slots create the device instead, so
that non-DJ receivers, which do not send DJ pairing notifications, can
be supported. This also applies to Unifying receivers.

For Unifying receivers this produces a broken device. The HID++
notification only identifies the device type, and
logi_hidpp_dev_conn_notif_equad() only sets reports for keyboards and
mice. Unifying trackballs, touchpads, numpads and presenters get an
empty report descriptor, so no driver can bind to them, and keyboards
with a built-in touchpad such as the K400 lose their mouse reports.
Since the slot is then populated, the correct DJ pairing notification
for it is ignored until the receiver is unplugged.

This happens whenever such a notification arrives for a slot the driver
does not know about yet, for example after the receiver was probed
while a KVM switch had focus on another host, or after a device was
paired while the receiver was switched away. HID++ connect
notifications are sent when a device reconnects, and when userspace
(e.g. Solaar on startup) asks the receiver to re-announce its devices.

On Unifying receivers, queue the unknown-device work instead, which
enumerates the paired devices through DJ notifications.

Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Mark Pariente <markpariente@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 6e8db01d27ec..383c762c503f 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1766,7 +1766,13 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 	if (dj_dev) {
 		logi_dj_recv_forward_report(dj_dev, data, size);
 	} else {
-		if (hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_CONNECTED)
+		/*
+		 * DJ receivers announce devices through DJ pairing
+		 * notifications, which carry the full list of supported
+		 * reports, so query those instead.
+		 */
+		if (djrcv_dev->type != recvr_type_dj &&
+		    hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_CONNECTED)
 			logi_hidpp_recv_queue_notif(hdev, hidpp_report);
 		else
 			logi_dj_recv_queue_unknown_work(djrcv_dev);
-- 
2.56.0

