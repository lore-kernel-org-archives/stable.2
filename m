Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0D4A0900
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940981; cv=none; b=nVN1Tgr2VzANUfUcgfi6Qi0Du/2CkWL4p6x+Qw2uOmok234AdQ91Hx5CzA488G5Hbz4lrLXASnkD6vY9cdRkf2HZjntmOgul4mGOnEN0U0WJeLSVGXUXz+mZCJgBsb4VM34iFNKhz/TbA+uHzHsk+0fEDtQAgmVkUyVXbMzDCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940981; c=relaxed/simple;
	bh=kJZh6y94i6h+wIueUxNoBcL4CgBSHgSQrOmgm0f33jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y560EpSIEkKsMxqEBZKPKjnwRSMm0MvWTSnvQvn7UDXFRB/KfmDBQzDRehFJ9seHqNf8VNZatKalkGwW/AvnnNYDLp+6nMpo/uLuFLDhGXI6qwUuPYmY5nk02XwS3ZEfatVgiK4tlVDO2Fr6dPiAFVfE7NN3zDG9NPBJ2htern4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMsAcUIi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMsAcUIi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so32285575e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940978; x=1789545778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0ImWj6rAclHhabuY+hCcTXmlRAswzPkBoaFWxuqP+A=;
        b=ZMsAcUIiUF6C3BHL1mLewfKZAyI0WyMqrU0VOXcxtvCPQSC6e2HxnaC7fv182denl0
         G9lzp8fA/qFbq6ODMUCulMDRXtTgvLdRnGvy9ojjw9XutRty9ICE8r3lt3Um28XyZbYt
         U5JLXAQyfooNdvGYI04ssVoY25M/M+Q1b4nUEFjRTA8v94JYKez90eXjSwuipGzZWwdJ
         KQ6XF4CCY3VCKdinF5aMeghd0fQQJxseUz2QXZJMJxlUdv98G6q/S01dwnqCb60FAFeG
         rE90MH094RudPzF9BizB6UY7VkjeVEw6cXN3XWBo1o7CR78DaLzqTLyPFVQS++cX6wru
         1tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940978; x=1789545778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0ImWj6rAclHhabuY+hCcTXmlRAswzPkBoaFWxuqP+A=;
        b=a1vLLlTvT2LNMtAwRKPB6kJxoJeoD/b2EfgqzNif/p0pgJ1NCj9JVrgxgqwNBHaYPB
         SaVZfzpvM3W2eRxLOdHiQbsRT1Es0z6U/WePlJkb0lJDsujn2wHJlrsWKNBGVOn7R80H
         erKXxt7QVWmZOYidY5goh4T6OgRBQHsVeaCk7wcylS5Xo8NT9lDxhFQbLbszcB6MRwlS
         g9PTpnYkf2DOnuNBEp7BsOkn0hvaSLqQrATv9BWikmUYubA9+kifECdW+g+Wo2khht44
         aPbfxCFbbswZdytKbS031BCXyrDVyDEKd2f5q3Vb5fd6x+5MrQ51gef27bHkCUUBjTFM
         1EhA==
X-Forwarded-Encrypted: i=1; AKwUvBzEI1BUasprhIfS4Uw6KSUJT3ARvkdHOZahWS3Ey//B+D4bAKvhFAZBRFr/4wYOBMRQdQbaFew=@vger.kernel.org
X-Gm-Message-State: AFuF++kJKfPMiWiCCh1XGYoVKUftKU+fOnTT7XH4k1x0q723d7n54d8X
	A4kGajEb1ywCrNIhFzAj/j+49cXRXMzUjNFDO5RjbV+jGFPdfTKJSbqI
X-Gm-Gg: AYBFou0yMRstXXsC9QEkmNhETarVywZJ00vlq1bMcdmbyatjBaqGRLAIs9ZP26i7x2k
	GerNVmicB+OsNhtnvJK2JogYgep6NnLk0i4NTE3mSxkZrUMnrbOIi2HuW/j8N3eXuS+KURZ35bQ
	WFcOSqZGSGw4DtFdzYvw0m0BWZvrJmqMI0M4brVWCLc69mYF7FYUPA+lIJHFO/73qJpe+DWEzX2
	VTbInnNPnRyt38wnqeK4d55bOBsng2EDtEpXFXfrRacwdKwVe4sdO2LJDqS307mYZTE0djAxwvq
	GROHTGxaonq+t21CdVq/INZTlGvyRniia/C3yYG9LaxIeMtlcKUBVK8c/kDRrbeV4iEt+xFZ+c8
	WfR4QQnIqKzRUun90RgcR6WOyGsvdswVETyZiP7w7QcC19zFg/w8XW4+H0Bo8cMDko0gkKLRWWu
	Ntja10YJT8IwdiSwQTjbedTM3cGhCmkfrZcDFmbsrDjLThuO4HZE7Y/3n/MhWXjKRJFhDXYq/RE
	P56m+wAQ7PLSG0ssXiJ28ZXYOCAByAjBfvqAZWyLw==
X-Received: by 2002:a05:600c:c3cc:10b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49d1d6a4d7emr53938015e9.1.1788940977612;
        Wed, 09 Sep 2026 01:02:57 -0700 (PDT)
Received: from chubuchnyi-ThinkPad-P1-Gen-4i.lan ([158.173.155.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm412817125e9.3.2026.09.09.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:02:57 -0700 (PDT)
From: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
To: sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	mani@kernel.org,
	michael.riesch@collabora.com,
	jacopo.mondi@ideasonboard.com,
	nicholas@rothemail.net,
	benjamin.mugnier@foss.st.com,
	sylvain.petinot@foss.st.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5/5] media: i2c: st-mipid02: Add missing v4l2_subdev_cleanup() call
Date: Wed,  9 Sep 2026 11:02:27 +0300
Message-ID: <12ac971583eaf4775a0242a58a6ed0a1fd08cdb3.1788940469.git.chubuchnyi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788940469.git.chubuchnyi@gmail.com>
References: <cover.1788940469.git.chubuchnyi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subdev active state allocated by v4l2_subdev_init_finalize() is leaked
on unbind. The driver has no common cleanup helper, so update both sites.

Fixes: 04d170b288b3 ("media: i2c: st-mipid02: use active state to store pad formats")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
---
 drivers/media/i2c/st-mipid02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 4675181af..b2f275129 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -919,6 +919,7 @@ static int mipid02_probe(struct i2c_client *client)
 power_off:
 	mipid02_set_power_off(&client->dev);
 entity_cleanup:
+	v4l2_subdev_cleanup(&bridge->sd);
 	media_entity_cleanup(&bridge->sd.entity);
 
 	return ret;
@@ -937,6 +938,7 @@ static void mipid02_remove(struct i2c_client *client)
 	if (!pm_runtime_status_suspended(&client->dev))
 		mipid02_set_power_off(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
+	v4l2_subdev_cleanup(&bridge->sd);
 	media_entity_cleanup(&bridge->sd.entity);
 }
 
-- 
2.43.0

