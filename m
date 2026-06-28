Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AC23EAAD
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640914; cv=none; b=eAadtix5W/8Djjs/le+LXyo6RLKZltNop17r9QynUzsAfCG4UskYX6WrDUmvjTYwxU91tMGHj6XDdN+dsy/MDQTT5n8/OI4gBjjzXgDBjgBeK6QUX7WuPsONI+BhawTj8CthaMKFw+0CL5WAqUJJrc1FldrXQwiyVaVKtB2QkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640914; c=relaxed/simple;
	bh=2t5a9qB6hNVDxj5S5IvP3ktU8+lgMMAZlQSPGY+2cYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zb1tfKBII5mkEj1PmCn5v3T20O1VYvcw4v2af3U4GhU4z5ZkSTQN5cL6Rbxxv9K/QN40CKhh/zdgpKdvD6SzE2ZqnLE5IkIAqsKTP20EAwgG4oh5mH1F7zgqx5wuvgxJ/wgchxH9PL5KPCLEBKXdUwZiRsjZ2y1NKdQ/BNSRY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oS+ukM0S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS+ukM0S"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49319ebb3a9so5995995e9.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782640911; x=1783245711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GcbpUykRobBfdlA1r4jXGTM9YzHADH53GFKveeipoE=;
        b=oS+ukM0S6XxhNWJ01URy4Y6Tr1K/gSix2ZsqKk6v37kajwpS6v+S3jLaA4DWYhEIaf
         WXVL5P8CUEekhySWm2UG9gUm8XVMVfPfU1a5Xz5cJTrtpuro4Rj1V1ePG4Q0uC+ouMu3
         Vt5DuuydsyycBSvX3fkYlCUg0VaLoKG17JgK5uPsZwtB4+bhhDDJ36n6TR9CvyGjBHC9
         wTR0HeqbjEDiz4IOV9zPUkJTM/qEP//j+ElDIwvX9+JjROgR9BIpVEqMrV2bh7EDQuX4
         c5tycSeRgRqqKV2JmGX81ELctYENtJPLzY1qeqncjT0cYV9MW4elDYVcjt+ocETS5DYm
         eoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782640911; x=1783245711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GcbpUykRobBfdlA1r4jXGTM9YzHADH53GFKveeipoE=;
        b=rvbYdskIrs9C4jqPQJmWASJNeQXZZqockj+TkXxGHjOqrtl4m3aoHcgFNKnY6o+dxe
         RYmumdmBdVUnKGCtUkSUbWtHm2m8nzzMhSOMzufoyugWsJgIvfgfUjpOZIkeJfLI/mmh
         tbA+iK9rrFNEWTQysBbllNdjK3VQuwgPdaL2jPBRwWQIT4EPxjfzNyJZJ2pukvY1KQaJ
         LIGS67m+x+2CZXUjOKFcofbUxmrjoyJIeLSp2pfrtB4cHRjybCDyCgLlGsdZ7S6+slYJ
         bZjDyulzYuiihlE+nP7ASqYS0S3ZN6O04HCna78ygKYbhR8ZQIivXI/U4mO695K4eaXC
         BxuA==
X-Forwarded-Encrypted: i=1; AFNElJ+fP+Q9XcrrGlKpN02XBxYIofeStGLBvQg9qxPGzCtj+CI9Tb5awVF+gKFCUQHLmQUnorMZC14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWqY7xcIwU7fLCT5tZ9JTBnus1EoFU2gTuVDZ7Ui9D/3OmX4Zu
	EYYyOI3svSBFfxC8wkn5zmxOv7yNFK9KfZ20nF9xeoGdL7DE5QCcrn/P
X-Gm-Gg: AfdE7clXtL/BwRD+UThVLq97SpMU2j6oIdExdKf8WhcmhodSy+UGCvp0pSnekOQ2nLU
	jnHsqTTSjgRBEswU1VVyTuPFymN7pcHRkmOdqOsFeL1Dg2QGwehiCUs3U1EtJuAEBRhj9EsErv2
	FKWPXN9KfnchniPFi9YAzoSFwDj44JMIlkybYVbHdlo+SG6jZy/U1QvPNUhl3p8U6essaXzm80m
	/JQjFeH24/37SS78Ymrzf3p7UQ8fIq+VtBQ/TaaiL2WiJb+znexlNDVjQLV6KlhuiNGovGpW82C
	WYpv1/5L84hFAnV6LID5f0qKM12dzCUAFgd91LSL2uFqoYpPMzqj3/R5v44XtiYP7YUfUBtEyx+
	0lUTg9aUSlQ67K1kBiWDBpp+jKn7GqSAXesVnfXXuvHurZ4ViF5/3xNyFbMDuYGIAQu8lSe3xgg
	8Kq9j+63cgeZ5SJx/AF73AlGGPdQ==
X-Received: by 2002:a05:600c:3581:b0:492:66fb:5dc5 with SMTP id 5b1f17b1804b1-49266fb5f1bmr205698715e9.24.1782640911113;
        Sun, 28 Jun 2026 03:01:51 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472bca3caccsm5286932f8f.33.2026.06.28.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 03:01:49 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+d37184d9d8cc34602616@syzkaller.appspotmail.com,
	syzbot+d445a71e1c011b592c16@syzkaller.appspotmail.com,
	syzbot+2e428058cafb408fb695@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] media: dvb-core: publish device minors after registration succeeds
Date: Sun, 28 Jun 2026 12:00:58 +0200
Message-ID: <20260628100058.48760-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_register_device() publishes dvbdev in the minor table before media
graph and class-device creation, both of which can still fail. Their error
paths then free dvbdev directly without removing the table entry or
dropping its minor reference. Opening a manually created device node can
race with or follow that failure, causing refcount corruption and
use-after-free; without an open, the minor reference is leaked.

Keep the chosen minor private until all fallible registration steps have
succeeded. On failure, release the initial reference through
dvb_device_put() rather than bypassing the kref.

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Reported-by: syzbot+d37184d9d8cc34602616@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d37184d9d8cc34602616
Reported-by: syzbot+d445a71e1c011b592c16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d445a71e1c011b592c16
Reported-by: syzbot+2e428058cafb408fb695@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e428058cafb408fb695
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/media/dvb-core/dvbdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..ca4d61a94270 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -545,7 +545,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	dvbdev->minor = minor;
-	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
@@ -558,7 +557,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
+		dvb_device_put(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
@@ -577,12 +576,16 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
+		dvb_device_put(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
 
+	down_write(&minor_rwsem);
+	dvb_minors[minor] = dvb_device_get(dvbdev);
+	up_write(&minor_rwsem);
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
-- 
2.54.0

