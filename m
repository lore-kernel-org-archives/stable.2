Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598581;
	b=11lRG/UdPUQetiOgh1J1KDZl45RXp28vq9nV+btPiCI0xSAE9PYtWsDJvbw0p0wgLb35
	 kV9QI1q/m4HgaO8t9crhOz17Qt4L7kRzCimSMAHj+xA7GFDDr/ILyOM84LWbvMMwf67X9
	 dHcJtexRZRl6N/OoH9V/u84+0XfaKL5W1VuE1BKClnP8xjU9Os0LpGA19MUe+ZnKAEFEM
	 w750Q7p8iLAwaDQwrC4dyPCDyBkpNlsFXi8acYJUMykYT229cEMRRt2RKaxODpo9GJUKu
	 ZJndon4fN1wgC+0GCw65Rq8vE0DDXKxuB2+Qm1SV5b/85bxyIhhEXs9lMy0m5lhgpEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZByu9D35eYXwx1eYyZPmsqLbSDkpo2lywZU6Rw0Fffw=;
	b=sOvM67VKXcGzlsaQhFtvbUkNg5QtPcJAS3U0pkIBvx3lfpCf6PLzesXkwwFahIOIiC9i
	 L1U9JyFQ4fZjqovRfivBODPCsa291L2KZY4QyKUWIDQdfLda0aAZH277uGlnYBAuXIu1H
	 jLtERVXBcW5cKGBXDR/SNAMpVuy2XYCsaF9hoB2tSaQpH3ZmhVKpEQ+Xu0yqWDgdOANdg
	 RuwKAPUwix2+lT9lEh9tXvnV3uPKThGRP5te5+LtvTOFZfvIqrNeYe5PdJb/Ha8I981F1
	 7YoTMy6kxlnxfDepKiJlGcjcfxi+5cId3m4ZtOOixurplctxZ/cZR6lxG/7M1SldThQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASVkLsJw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB9606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASVkLsJw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BDF1F000C6;
	Fri, 13 Nov 2026 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598581;
	bh=ZByu9D35eYXwx1eYyZPmsqLbSDkpo2lywZU6Rw0Fffw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASVkLsJwVbuValgodXBPiX5ODYgd6wp1EbP3RvHdR+JpRq9P2litQu/fT9WTANcOY
	 yQ54MhDaokg6QU2a3gwdi6rFfnPgLClwVZCIS4MgyXhSbGJCyknfZK877Obb+TOKz2
	 gIpYUqh0PzD1eYH1JeSU27egujUX/ZRw33M1qZDzZiCgwJuZ6tG9Wh0lkXDE/yWRhl
	 bFxITA1C6yahnTh/3EX+8Y7VBrrlVEqc0ybkk4CI7nmVxVobbUeqkBWyK4t6M0Fv2m
	 dxReToriD50sM3+9ddwAfk4zLJ1ZNXH7kJ3vEFVEP3y+KHi8OYTYM3+403S4nwTtMb
	 Nwx94rUYtsxmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure
Date: Fri, 13 Nov 2026 14:36:18 -0500
Message-ID: <20261113193611.2457020-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113193611.2457020-1-sashal@kernel.org>
References: <20261107050548-failed-7.3-d34a818a331f@kernel.org>
 <20261113193611.2457020-1-sashal@kernel.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

[ Upstream commit d34a818a331f7e270fa9dc3db3d96f6a0d4fa7ab ]

The SoundWire IRQ was disabled before pm_runtime_force_suspend() but
never re-enabled when the force suspend failed, leaving the codec
unable to receive interrupts.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20261020073856.1177749-4-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index c5d6cf9896545..3cabed663008c 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -216,6 +216,7 @@ int sdca_class_system_suspend(struct sdca_class_drv *drv)
 	ret = pm_runtime_force_suspend(drv->dev);
 	if (ret) {
 		dev_err(drv->dev, "failed to force suspend: %d\n", ret);
+		enable_irq(drv->sdw->irq);
 		return ret;
 	}
 
-- 
2.53.0

