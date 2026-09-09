Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C841E6D9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986780; cv=none; b=ZL1xTfO1szajwguF9KqwPTvtw9DlH0oHY9mPwccNL6xEWnzrHOCiCQdueGL2yTeAJm7Dbj22j0j8P+0AxrInwnh+kk/RJLbr7OhR7xPKSldg7lT1D8QymwmWlV0qpEmQG3xBQ9vhZcsCeBsbsqEMfEs4WOh96UtGGYtA/6cUlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986780; c=relaxed/simple;
	bh=5vVUPYKPtpjlnd9FTWykDsk1acCTltGJpiIPClWIgbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGZShREGy0bnyGoYj+M719ud3OQ29IfOwLVZYGxlPJo0meqLbo+ANGOZ44+MfOQODAO1Xur33sTkWmJCpSpZ4T5sGid4OTnR3dvMx8YPlhgleqqGWSl+2Hgd0i+KK1X9/ro3dov+qgSd9th1K+/MOg69i8dZWoEw/zeBiVHqSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBtoqXeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBtoqXeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F4D1F00898;
	Wed,  9 Sep 2026 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986763;
	bh=JQrdcwBY318ET1K4fch3etuDu11hWGHs3wiN1h+WA2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lBtoqXeGt3WeCxolbs/9u9ajtqJ1ICEo4kCkOedLQ00QHFMmLc7hGVIQNuWXjo7eV
	 Q+/8E6z39rm2L0F4x3Lvbn7J4fqRnfaiMOet/AmN7hL7o43ZDEcA+kjJZc/IeXY8qn
	 0AG8mFqXEwG6yuBk68PaSwsM/8wvWQrWiDWEhGLX5d+508i3u4wHL8ZtwuIEPEBUfy
	 zeXr6fCJd6ku0A0EgWuucXlhwlBlmrpYTNxyHG4IkDmgrw4CrRlZWQjYdEkFOAvuF4
	 MKWspzrlwo274MbtLj4bCt+svjRQtUUfxAn5/CpGqcHNQ2RkKRUUDNWwtPw4z10MYt
	 VSd7gBLMaLhqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	sashiko-bot@kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] i3c: master: Fix device_register() error path
Date: Wed,  9 Sep 2026 16:46:00 -0400
Message-ID: <20260909204601.3679694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090417-elevating-aging-a57d@gregkh>
References: <2026090417-elevating-aging-a57d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 74be657d98a8d684c0475f3cbd450ef2a30ffc73 ]

When device_register() fails in i3c_master_register_new_i3c_devs(),
put_device() is called to drop the reference taken by
device_register().  That drops the last reference, so the device's
release callback i3c_device_release() runs and frees the i3c_device.

Two problems follow from that:

i3c_device_release() does WARN_ON(i3cdev->desc), so it warns because
desc->dev->desc still points back at the descriptor.  Clear it before
calling put_device().

After put_device() frees the i3c_device, desc->dev is left pointing at
freed memory, so clear desc->dev as well.  That prevents, for example,
i3c_master_unregister_i3c_devs() seeing desc->dev as non-NULL and
dereferencing it.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-i3c/20260701203053.8F3971F000E9@smtp.kernel.org/
Fixes: cab63f6488761 ("i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260702183644.60827-1-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b51b159fadeed..5485bebb54dc4 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1928,7 +1928,9 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (ret) {
 			dev_err(&master->dev,
 				"Failed to add I3C device (err = %d)\n", ret);
+			desc->dev->desc = NULL;
 			put_device(&desc->dev->dev);
+			desc->dev = NULL;
 		}
 	}
 }
-- 
2.53.0

