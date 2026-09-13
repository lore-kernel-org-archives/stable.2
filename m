Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C963EE1C5
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306856; cv=none; b=abP+nsGDZAjPENU2dXgGrK3H9UoP1s9JYFvTT413IfAj4H8bnvEospJqOnVzmVqzTDQX04wwbLWNhuIPlwHpNbsTuFSqoUMnO739B6ZG18KKTfwi7G5w+gQbtUBaLMENaXtLhxHsY4Nd/WIEVWNj9HmEij7iHTQw4EZ34gm3aB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306856; c=relaxed/simple;
	bh=vUq7OE8glOhov/9NBs9mV+ziOL9KOUWXVhl29wF32kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYXHBzsba8ESc2SH1Ee2AFNttBL/nf4Rg39TBvzh8UEFs2BS7bbea5IincmdLE7JOlfx/KvP3/3goDPPokuYbFpVb8XRm7Sv7TcVkrSacvriJr7LCDwHPe4CSv7AeuOpSSd4HzUAAn+SiQhxkRe/BaGStg38Kq3DTwQiO3OFsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYYdMye6; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYYdMye6"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4ae61629fso835850a12.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789306855; x=1789911655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9U8XN+wqeWZ2BOPDqAL3IN95g06CNkRCt1kYaktqWGg=;
        b=sYYdMye6yetjLqtrxHBwrfTskPMmuHpQVzGHUu1uBEWKvrSt/BlQXSB7QFdaMMK4W6
         2GQG8FvgH2FwfOpBfwLhfzJLQ9SSyipGFayJVcmLnLJV+VcetlO/F9MFLH2ZUzwgEtpn
         h2Fem1sOoDjDCVrqFt/s/vmWLtIpbCLo32ZB+ftjIA+/9IuC5Gx2mje5pH5Xpni0DGnH
         aAlNjTG3pu7WCPQEFvrsKds5qgD6+q2QfggpswHaCbX+ADaX8UCh9glptXL9jNw7I1zv
         y0CqEsyoKf4u/h0rIQa4ASPwxg5oOP/a88PjMc/rK0Hh5JzRN91+dhtBZRjK8pypKhXe
         9Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789306855; x=1789911655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9U8XN+wqeWZ2BOPDqAL3IN95g06CNkRCt1kYaktqWGg=;
        b=N27L3uE6T/pCJQTbD1k0iJ84wY7Uw0MwNCojOx/yoWaUANpGxY+xEg5OvIbOmadlm6
         DncI4AqfJStwdK/jrtxkYOPtpevUPSZHdgrbsoaCfBHa39FVoALrMW4auEdyQM5QYmGj
         dFinAyS0G9lRimo+iR2AQduiBFTMxhTKXJ6xvcnFsZ35m2UUxEA9BjXIYbPwYTgpSpAZ
         VuePhy7Xx1/Rvkgj2Uw2eLqKRePobZeV1JQTo80N3Boo+mSjmGu1jGtrjmMiEycmN0Z9
         zpFzlewmQ3oT9+xSEf9FJ77kAd4GChG25ABLTUsZu7s0QiW8qgjQ6IpBsJW/GTJPE2jD
         irzg==
X-Forwarded-Encrypted: i=1; AKwUvByqygR18uG8b2GBh0IXVgGeNkKx/iQbc+g3hd68OSAHNOst1z/qjEYaEFNcOOoan0IPzKx+zTw=@vger.kernel.org
X-Gm-Message-State: AFuF++mhVaaG1RMRXhonwLbqQoinZKpfKjcVZf7hu8YlgMYOoaWeff9d
	A56WHvoFVDjfJV63KSaHOHOKgdSehAAxqSG2/0KQkSPlFWKt7XJz5QGsadVCwmz8mBA=
X-Gm-Gg: AYBFou34XtaEH6nvZ59rR6+sOE53A4bA5nnoUh0eY9aDWYGT394EknMAkXmVoF+/J/h
	/0/TkKZpG8Sfmn6J/I0CZX2x56m5w3yvEmJYnKFcumcHk18vuV5jckOUBL10194MXHWbCbrF4+T
	j2TDcwA9lfdyqQHFvL/wqU7rq/i2FHL6oYGsR6kUuEKakFIhKS5u7PtMWub+mDEDWDquhksDTRr
	kbuFW8gezdcYlwE1KNNpK4YXeTti5ACmit/R6aWD9wQIrFFc017iht8sfw6qU31dsTaM7Ip7Wn6
	KjY3X5N8rgxnZT4pp/NEY93YFSrZ5BBK6TGD+OzrFHELa77pzUOzmPoF4uLvYU+gQK4ffbmAoCP
	ZIT5/mGc/RImOQmuOm1Sj4mQ62OSvVNV+QcwFtNtRzsbmjxcnVqt1M1PEbKO/Et0INgyQNhTWZA
	qb62h4MycLv+oL7tHghLpA9VMgL/cDDBcxKIRmUS/dwhSxDgx1D/6ciA==
X-Received: by 2002:a17:90b:1651:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39d9bbf93c5mr20289197a91.2.1789306854833;
        Sun, 13 Sep 2026 06:40:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm15365323a91.13.2026.09.13.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:40:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on probe failure
Date: Sun, 13 Sep 2026 21:40:44 +0800
Message-ID: <20260913134044.1562697-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidpp_probe() initializes reset_hi_res_work before starting the device.
Once device I/O is started, incoming HID++ events may schedule this work.

If a later probe step fails, the error path stops the hardware and
cancels hidpp->work, but leaves reset_hi_res_work pending. Since hidpp
is devm allocated, it may be freed after probe returns while the work
is still queued, potentially resulting in a use-after-free when the
work handler runs.

Cancel reset_hi_res_work in the probe error path, matching the cleanup
performed by hidpp_remove().

This issue was found by manual code inspection.

Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1504de32b1c8..6a21b281a1df 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4834,6 +4834,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
+	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
-- 
2.43.0

