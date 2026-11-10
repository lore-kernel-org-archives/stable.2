Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314599;
	b=UR8R+LcnESJXRznnR+ATBvzwTdCtEXz3zUR3AxNjkOoPx4tTJoWpeUGBAO2k3z0REOXD
	 3Zo+UcC3y3DQlxDbxhc1PGv6XNzp9GwnOnhoXEjktgB70KaP3Lbl6iL6vC+3hh/I6SFA3
	 P2LiNiGO8jizQINWx+vKUWUXIOzXXtx89eShU9vI8WZhLJFVvuCsnWAG88OUpsoy5YJ7K
	 c5+2qCjwCoLlDCDw74ovty7qPZnFU1H9uxgWHhfN/iPfYLl18onb/3zpVQsirzfL98Fis
	 mWY/NIn33MimTCJUTPj6HNg9LLk9c4pJZBKEN2O1XI5d7sbypmnweDWgyuJHyDf6FjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bAnug0O0syBmln9Rohl3zvYr0dXHtbNxflH5S5g3KSs=;
	b=1vsJeIiFhmbT4Njlbjn6LahFZK+bMQ+BpBmQiVS95cLc7CcGnyeC/0BnJ8QSEtCE/wfW
	 UY8yIFp0VthBbdNa0vkPAWkifYKR2QsJZhuGjY2Tz3vBrycpcE5EY4qHjdwrB8t7dNJXK
	 KPtB43P+HjcDHZURGmxTLYLejVS+U1NflxnDZYUilo6AyPdAwEOUFpgpdi7D4k2kH5MQj
	 IUWrmVMUIHteoJCGPP/48a1qVw8+YI3L4do2tdNY7RCdCgl47KVm4QbCv6WoZ027ngcDe
	 e36rYRgM1fNSHfTgI7a9MKR0OANsZ+1TB8OaknEt3yAckQsZwObbd89VlPNPo6ACD4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSJVbiWF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68153606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSJVbiWF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CEE1F008A3;
	Tue, 10 Nov 2026 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314599;
	bh=bAnug0O0syBmln9Rohl3zvYr0dXHtbNxflH5S5g3KSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSJVbiWFMHo5b9UIToY//DW0eqv0P1kiEWxyY6elE6do5NJIC8Adlja0Ed+SNrKcg
	 n4FCSNe6/cCOS+cAn34a0vkXS9mmnlIN6p/1xy7LW80sXzYqVV/jjATBOU50SVihdy
	 XxIkMPMp6cTIshDMdln/pGXy2eQNHoiwMAmYWamtdWJe/D1SQVtO/OUhDQ+KrleXse
	 FeIglk7dtaoQ1cRTdSgYNoKwy2ypw7yJ3EUpaeh0QTcJ5eh+ta/akNPf9gla4rfmKf
	 Yrdk2kH+6G6wTSjIj9rQ2qEDjMhlWkf3XlpEqodTSMhfSflKTnR4PZkrVI6qzMI0ne
	 Sciy/p9FVax7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] media: i2c: og01a1b: power off sensor on remove
Date: Tue, 10 Nov 2026 07:43:16 -0500
Message-ID: <20261110124246.1444734-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110124246.1444734-1-sashal@kernel.org>
References: <20261107050650-failed-6.18-a26c5ac46191@kernel.org>
 <20261110124246.1444734-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit a26c5ac46191ae34b3413f7a45d6241f63e15d42 ]

og01a1b_probe() powers the sensor on explicitly before identifying and
initializing it. After a successful probe, runtime PM is enabled and
pm_runtime_idle() is used to allow the runtime suspend callback to
power the sensor off.

The probe error path explicitly calls og01a1b_power_off(), but the
normal remove path only disables runtime PM. pm_runtime_disable() does
not guarantee that an active device is runtime suspended, so the
sensor can remain powered when the driver is removed. This also leaves
the xvclk enable performed by og01a1b_power_on() unbalanced.

After disabling runtime PM, check whether the device is already
suspended. If it is still active, power the sensor off explicitly and
update the runtime PM state accordingly. Avoid powering it off again
when runtime suspend has already done so.

This issue was found by manual code inspection.

Fixes: a95ffde28783 ("media: i2c: og01a1b: Add support of xvclk supply clock in power management")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/og01a1b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/og01a1b.c b/drivers/media/i2c/og01a1b.c
index 4b6b9ac24594b..68ebf44876781 100644
--- a/drivers/media/i2c/og01a1b.c
+++ b/drivers/media/i2c/og01a1b.c
@@ -1026,6 +1026,11 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
+
+	if (!pm_runtime_status_suspended(og01a1b->dev)) {
+		og01a1b_power_off(og01a1b->dev);
+		pm_runtime_set_suspended(og01a1b->dev);
+	}
 }
 
 static int og01a1b_probe(struct i2c_client *client)
-- 
2.53.0

