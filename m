Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480444A3F8
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292792; cv=none; b=i7eue9L57txBZov1/58+U6uZycMIRQGNx0MP0q4tu/8xqy1L/i67AguAj0Uoffht9zN84DqUBE3V8im/NludHwic2BmbHCkPDReati031sEB2d42dAkMyNvwxw0GJ2kiyDMj/T1VfJgbS+GEq6p468k9/MwHPO4JLK8SJ3i0Qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292792; c=relaxed/simple;
	bh=so+sJEXPcX/c5t2B93vxjpawl6VZJ9hVu3eFKoGAYUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAFTLsfbPQLXLFEO8GxaY9uP6WJYfLWofAaYeH+JP8z/OiFqNR8wYKwgiIv+g704B5SuR7rv+i/h4efpiOk+S+A4aXNL2aqwEFhIciHKKusLesbszJKHsFwDzQs4zTi94/OC3Sdkwla+4I288JPvktW9LUxIsX1N+OF/+6h/1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi392hVf; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi392hVf"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66e63afda8fso346270d50.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788292790; x=1788897590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=klO9rcY41+qEAIW/kerSCza/k0mNjfQoLBO8B+8gjZg=;
        b=hi392hVfvUXkFuuWzN8y2xb2KSrqiHZgC4gjsvEft3LsVtS8msfRYtX0GIfb/tnu28
         i/WIu5RzVeVZO7FUqmN+Iy74VBX/9+95XpcWcmYOj8mo5UF/oC/iK3I30YY4bsMgaz+o
         fy1eiI88NH8W2ORnGD8c6l25faWKk1gwArpOaAs24EpK+aA5wkBkNdiZg44axi/Bt2sr
         HZTAxPRwe72CrOiZh6dI/OiKeYC/TxOidRlfs8mFnrnh2QO8Bg6C9KleSnkae71vPZ3K
         6N8UvdvgGadu7LqAcThOtodZCywGfT7lixa88OAPcp6tFpwZH2G8ZmsExZSOB+kcu0sz
         EFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788292790; x=1788897590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=klO9rcY41+qEAIW/kerSCza/k0mNjfQoLBO8B+8gjZg=;
        b=GtBjunSE8RKI4JebuMSK8kH6PS9bH91Ufs6t1ALr3MJVxAI74uFSXv4OQG+SjxBxsv
         Gp77N0ah+ic7/G+Dqaa5vepqsnbxVqrve9iY0J8CZ9edFfDuM6vgd60NCh7SEgAkv2vH
         rumIDGHIMOx+y3oiZZ7uPO8fEs0/stPEtoMyTEV5wV6yfLgGwk6rUMCWCyRYFrZ+KHww
         XOQ+IPij9xaj59TYQimSifiJeEH8d0vM1RMlitCGaFyn3+psD6q7EANebYklrFEC5qOq
         AGBI/Nigax+CmwI1XliTJ988/kpMd05lydVHwU9VIQ4fYDvxkSPySDMMeozWScGVQI41
         Km3w==
X-Forwarded-Encrypted: i=1; AKwUvBwLfBh8aFaNckFlqwDUw6bu2KhDZf0IsEYk3VpYouso/W6CuFVb9kxoSE0oqsbg6En+FoGgtf4=@vger.kernel.org
X-Gm-Message-State: AFuF++nqTEUgVEhwhDRMkXcrSjwnmL92aUg6o9yNQeQwUi8ACrHlz0ib
	a8blLroD2si+f7IsbfpIGRqb0u1VfSf7knqSgvDZozzi21pWjqAZeDvcakGWrdO0
X-Gm-Gg: AYBFou0O0ywOnpqV6L/NvEQ/K8otzmZB77iK68Gxs8Z5+ccADgMR3bnv9fvu5uxK7w1
	LZjyF7gmUonywXIoyHGTf46iQMPooJd2VDw3j4KNH2oiPbFKOG999kUCWjaa5Xj9O5G+XxpnILE
	dcP5dWU3FtPMhhoifG/ftGRenNPi6vndf208f+jIFGW1Wu+pKRDt2ASNGAnjOpZ5XiL38sh4udx
	CNCyEYI9h3Phax5h2Jjvh3hPYlYI3ZSiPLBqaKqLtJ1o5XcHQaRx1rQcyG+AXs/3sKumJ02AYtg
	r9QYxHZvPUwU3XhzxP198Qy68u6cr81mt1lQdbFaBEMXL91so6tlm68iyVlcYxIn4G2Q/HWYTKC
	SVXq3dxT/g1H8n3Git+sldWL7xlus9jk/v0aCOVSFZ6wvGRr9NZinsdJy4u7Iui1qoB3Wx+hyKY
	//y16/CTtM+h5fmK3rLfGBe6R4pHrQL6n4cIMKysZVVBJJ7m0vtQfB4A==
X-Received: by 2002:a05:690e:450d:10b0:66f:7d56:cf77 with SMTP id 956f58d0204a3-66f87582dabmr3200931d50.26.1788292789853;
        Tue, 01 Sep 2026 12:59:49 -0700 (PDT)
Received: from adriano ([181.173.249.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c186d60f8sm1528187b3.36.2026.09.01.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:59:49 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+2a3de29133b40e8f69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] media: as102: initialize mutexes before registering frontend
Date: Tue,  1 Sep 2026 15:58:56 -0400
Message-ID: <20260901195856.19910-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus adapter mutex and the stream mutex are initialized after the
frontend has been registered, but the frontend's stream control
callback as102_stream_ctrl() takes the bus adapter mutex, which can be
used before it is initialized:

	INFO: trying to register non-static key.
	...
	as102_stream_ctrl+0x27/0xc0 drivers/media/usb/as102/as102_drv.c:259
	dvb_frontend_open+0x7eb/0x1410 drivers/media/dvb-core/dvb_frontend.c:2825

Initialize the mutexes before registering the adapter and frontend.

Fixes: 41b44e041811 ("[media] staging: as102: Initial import from Abilis")
Reported-by: syzbot+2a3de29133b40e8f69f3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=2a3de29133b40e8f69f3
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/media/usb/as102/as102_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/as102/as102_drv.c b/drivers/media/usb/as102/as102_drv.c
index 6b1d3528a0a7..a6dd675689f5 100644
--- a/drivers/media/usb/as102/as102_drv.c
+++ b/drivers/media/usb/as102/as102_drv.c
@@ -287,6 +287,12 @@ int as102_dvb_register(struct as102_dev_t *as102_dev)
 	struct device *dev = &as102_dev->bus_adap.usb_dev->dev;
 	int ret;
 
+	/* init bus mutex for token locking */
+	mutex_init(&as102_dev->bus_adap.lock);
+
+	/* init start / stop stream mutex */
+	mutex_init(&as102_dev->sem);
+
 	ret = dvb_register_adapter(&as102_dev->dvb_adap,
 			   as102_dev->name, THIS_MODULE,
 			   dev, adapter_nr);
@@ -341,12 +347,6 @@ int as102_dvb_register(struct as102_dev_t *as102_dev)
 		goto efereg;
 	}
 
-	/* init bus mutex for token locking */
-	mutex_init(&as102_dev->bus_adap.lock);
-
-	/* init start / stop stream mutex */
-	mutex_init(&as102_dev->sem);
-
 	/*
 	 * try to load as102 firmware. If firmware upload failed, we'll be
 	 * able to upload it later.
-- 
2.51.0

