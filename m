Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713698;
	b=a10Rz1eEeYjwnme23DAOQO1ykG6UToaw/rbuhUAdbk9y17JXSn/bWSYfhIOfCj74UR4b
	 v+iyBBPNJtd9w3y0p+NZD6L42TvxdzmO4HG8Cuy3OSz+YNK+baPgrz0iYeS41IvsD7s4Z
	 uxa62TbUz0WYU10H+nlbUcAgLkDe9tkRqRmXpqlcRDb5ZIJlvjn0vgqgJZO0gt7K7/EOl
	 9i1OQieUPY1Iiy9IJNhnD17YawyONs+ILcdbsmqqNsldvSsZRz05wUIY04IPNjh9M5rNT
	 DcJQmJ22EGkGsUv1FG+wr5v4oadMMvo5/ZAZ92r2uk/ky31noXJQ6BaQ0mrSXeiIz2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713698;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=thTW5B905MYp85Zu/iGBKj33GxF2Nnx5pO28a0OAOWI=;
	b=NKZPVF0Pb6qR91hz475uoL7n/4H3D0PKzPEzctDoswxaRczMFn3wB6xuAWy1ZWEcybqv
	 gf2jFFRszNKlOAZUY90K00JFEeQUmxOSdeMCj8TvBXleZ5/zXHvm+e/7468+dZQwLo/Vf
	 ssoDwEMDIVK/y2VqQVGKB2q5BTwr8kPY8aXdy/swSixPrEIrqpOF7YRwL7KqvubjTtBVp
	 db0x4Z9YClnpkXwDmwKx1sKqz/awsecLrafw/UWzBk7J29rB4xMGssbjl9672cP9sj4Eq
	 tbwWGOs13yrBJ3+LrupG12gsyqGHLi0lQO0p83J+3/wKtg9BoU6Xgv+zpRWirMoiXkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fo7vShe5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD0606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fo7vShe5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD1C1F00A19;
	Thu, 26 Nov 2026 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713698;
	bh=thTW5B905MYp85Zu/iGBKj33GxF2Nnx5pO28a0OAOWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fo7vShe5ZC4knuf7aMfNT75UW+A9Z5iAmTKP/zJRdNCs4XhtKmSPWXI9AFCWidzKn
	 Ze3z+rn119SPnRYxOC6YhzkjOLKUQuFhaYgOA+hFyf7wIZkADqk32PoLSU6JFAZQNG
	 wXNcCOLJns10ujtugp6LoJIDqEv+YTkWOdjyNAYSBE+Q625aSUS0g6bzJetfS8YN7a
	 wySiGM0UW9O6k+k1DeZTQbqMnRGiSzu9xI6S9xgglwOP4A3NLJBXcQ5KB06heJ+sbt
	 7t4cGb7IO85fhwRawqXcsxiivlN3DQtmub3/eg2CtwyzThlh3lUds8vhIItptVyM38
	 z1+7T1M52mFkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Changyul Lee <lcy8047@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] iio: trigger: free the trigger ID after device_del()
Date: Thu, 26 Nov 2026 12:21:35 -0500
Message-ID: <20261126172128.2745277-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126172128.2745277-1-sashal@kernel.org>
References: <2026112508-repose-unboxed-3df2@gregkh>
 <20261126172128.2745277-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Changyul Lee <lcy8047@gmail.com>

[ Upstream commit d32bf759801e6df23038dc834622a122ec76a4dd ]

iio_trigger_unregister() returns the trigger ID to iio_trigger_ida
before device_del() removes the "trigger<N>" device. A trigger
registered in between can get the same ID, and its device_add() fails:

  sysfs: cannot create duplicate filename '/bus/iio/devices/trigger0'

For example, adding a sysfs trigger while an hrtimer trigger is being
removed through configfs, or the other way around, hits this because the
two paths do not share a lock.

Free the ID after device_del(), as the error path of
iio_trigger_register() already does, and drop the "Possible issue in
here" comment.

Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index bf09ddee2bf7f..721ee9ae946bd 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -109,9 +109,8 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	list_del(&trig_info->list);
 	mutex_unlock(&iio_trigger_list_lock);
 
-	ida_free(&iio_trigger_ida, trig_info->id);
-	/* Possible issue in here */
 	device_del(&trig_info->dev);
+	ida_free(&iio_trigger_ida, trig_info->id);
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 
-- 
2.53.0

