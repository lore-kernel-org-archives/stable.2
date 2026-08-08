Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E03A7597
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187859; cv=none; b=mUTdEX93VwYVdMrJgO79pJ5CiBpjyh9zU1iVU8n3qqodbXJ3vHTz5bsSulQDTmZh1mb8lBy1oFec9caEHmNdIHUt9v2npym8ylLTx2/K35HSSZely0KJFyXvVsJ/Dn6aPsxG7l+aBDGW2nHxYXcZT25blTJIeFGmQ60o3DjAA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187859; c=relaxed/simple;
	bh=ON1kS1no0SPn9XlGXhFU53i+x3fCGvAcs6uB4rd1MZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8b2/1ls/50ala7y1k1Uc1KBwTFHFh3F8787zd5tVTFcFj+p2Ou43tmD9Ef+zIWz/vb7Yfh6X9I/VKEI8nnu7g9jEelzBKMR1pW0r/uc9CrYzGD5z9LeK/+Jz0CNkSEgG5d3m3sCh6x5Ee5ZjPMhub0a2oKzPUg0umdNtdlf+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUzWV/cE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUzWV/cE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d049069377so3700125ad.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786187857; x=1786792657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Vav1/IZDRyi5TmIe+ztFcmW7gzOkBU4RfYMZP3HSBU=;
        b=pUzWV/cEKxVtYw6+fECFaQXltF9VwTzQXLEtd/vTMo6iBvLinHEm6zUtwoC5W6Mdjs
         tPPs+gEmfGmWhRx0jCMao1v/QmMt3dDXBIHTpVUl5UFrtRdaM4Kpr2DUgu5sbF0ZRL1m
         mj2XaK16tfsGb6WndGRmDljrxRrdc2j3EmxWA1GyI6Kgqmfl78ZI22aepz9ULtqpJs0c
         qRwCMQb9QJkUyEZDnSMHifwzK40mXCXcXsXUWmVbQ929/KgAkWMgbNNxvd2+OZ2/Rldn
         UORvJbjOPwbrH9EgxfYHbDhiSPx3baybXdfACmR6PMjbR5BrB0m9UYstQOY3L4qr5Buj
         bVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786187857; x=1786792657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Vav1/IZDRyi5TmIe+ztFcmW7gzOkBU4RfYMZP3HSBU=;
        b=ZaGWnCInn03+C/hUdVLRDDd3qsnqB1vraPfU2U5zHMgbMY7ZCDG/Llv3diiPcKhD9n
         tfXzAc/3THBOAKBPn2tIr1M7ExkoOzfGcp+GNGzxmhS+l41JPga7dMhrnlv9JA0ettxy
         WGEuIfJKbns7EDOt+NStb7pH91QS4LSAK8ZsSqUBSC1ztqbDXvP9MrxJm4AcmcjBSXZY
         q15W/wPOk37WtgyVA8KZg8kYykG77LxMCRS2bjG03cPt+NhGlyWKc6sdaOrM/w1BC2R7
         MdBqp6+q0abFqgXFrhS8S89PzfIMQ3e2w6YnIt6mxmfQXou8tVH+qrbhq9f6E1HH09qH
         wtaw==
X-Forwarded-Encrypted: i=1; AHgh+RooOQZgT7d0WvUzAqXEAGiGGbnTM26chOoivPZGEo7fiZ+SSNnAx9GEEb3OKtibO9JObilS5zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/wxyYq3ASz3QxRhhsF1bVbEmbiPR5aglpC8J9j3f2S45vR31
	i5yPgFa/VD0baJOhIjAK10bUQdPJlL7921iDMExrmzvD6jNKNdS9wYqW
X-Gm-Gg: AR+sD10TBtFOjMplKyW54S6fpej698wOoXfvme7TgzwPdOJ0/TWav+CDZ/Jiy/FG+Gh
	g+lPwTuvB7tsCnE9/lZA8cd55t4NOsGdlvRttW7Ka9PDAPDMCjQkB0bcL6CFeTuaZpRS3sj4i+l
	X99tCQ2u3wU+OJ1tgxXSF75D4unUwjkeRpiME3xXYGfhcVGioXbRTr84skBIi1o656NNmBkPruv
	OSHXs4ROf/trRtfEJ/8xwJxRKPJoR9kb8cByATP5/x8SPuG+zGxhEkeCGdT/Qjm7PiMlSp92jAQ
	eFHp+Sfs9km1hOXisODoIo00bDcmahbZoIsL1lUnz1jN0wuovIK0vbGSUlEInI2VcBAMEjyFoZ6
	xdeZS5Ta8qzteSCWGKBoo1uowQV9tJ4a1e4oXzE/AZTx7q+EpOoxnuUS+4rZG1Ws39hWbOh+GWd
	c7PJw65btBWoaNceekK8+hLsxj1pQfktRdjGMZVHiSrbxjfH8ZFl/8hgi12VSlL9x/KEH/h0el7
	oqhiQ==
X-Received: by 2002:a17:90b:448b:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3909d8c3b9cmr13238521a91.13.1786187857487;
        Sat, 08 Aug 2026 04:17:37 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde308sm18356313eec.20.2026.08.08.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:17:37 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cong Nguyen <congnt264@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] media: sun4i-csi: add notifier unbind callback to drop the source subdev
Date: Sat,  8 Aug 2026 18:17:28 +0700
Message-Id: <61d4901af20a4d2d0f9484328c173bbdfc52ec05.1786184456.git.congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1786184456.git.congnt264@gmail.com>
References: <cover.1786184456.git.congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4i_csi_notify_ops only implements .bound and .complete. When the remote
sensor's subdevice goes away (e.g. its module is unloaded), the V4L2 async
core unbinds and frees it, but the driver keeps the stale pointer in
csi->src_subdev and leaves the video node registered.

A subsequent VIDIOC_STREAMON reaches sun4i_csi_start_streaming(), which
calls v4l2_subdev_call(csi->src_subdev, video, s_stream, 1) on the freed
subdev, resulting in a use-after-free.

Add an .unbind callback that unregisters the video device so userspace can
no longer start streaming, and clears csi->src_subdev. Unregistering the
already-unregistered video device again in sun4i_csi_remove() is harmless
(vb2_video_unregister_device() is a no-op when it is not registered).

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 .../media/platform/sunxi/sun4i-csi/sun4i_csi.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index a8711336a754..6610ada1c06d 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -122,8 +122,25 @@ static int sun4i_csi_notify_complete(struct v4l2_async_notifier *notifier)
 	return ret;
 }
 
+static void sun4i_csi_notify_unbind(struct v4l2_async_notifier *notifier,
+				    struct v4l2_subdev *subdev,
+				    struct v4l2_async_connection *asd)
+{
+	struct sun4i_csi *csi = container_of(notifier, struct sun4i_csi,
+					     notifier);
+
+	/*
+	 * The remote subdev is being freed. Tear down the video node so
+	 * userspace can no longer reach sun4i_csi_start_streaming() and
+	 * dereference the now dangling source subdev, and drop the pointer.
+	 */
+	vb2_video_unregister_device(&csi->vdev);
+	csi->src_subdev = NULL;
+}
+
 static const struct v4l2_async_notifier_operations sun4i_csi_notify_ops = {
 	.bound		= sun4i_csi_notify_bound,
+	.unbind		= sun4i_csi_notify_unbind,
 	.complete	= sun4i_csi_notify_complete,
 };
 
-- 
2.25.1

