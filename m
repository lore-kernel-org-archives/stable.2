Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3872E2663
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042015; cv=none; b=hgKzupdw1Lwv8JYlZ70QNh7PDwnp7u4kYq2FNRsSLqAry4pFAgcAMITRXQBNbNXkhy7o0orUD8nQ6cmhNBAa2izd7MBnm3NCjM1wWitArEiXFPy3E+BqY7/SksfLLknJqydpXE3TvBUtBmJQH5Huowy8WRjcb9GVZ6Ggh5wqqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042015; c=relaxed/simple;
	bh=3BgYikqSax4HF0A6zgnHHnuQB1alfzJJhKARWIQRbhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWDPhm0d/1sjPQzfN0e9bhSw08iorBwRIJyFIPqE9bp/gX7zoGJyO+QCp6iYQp6dDwTCHfKFj1x3hgw4obRPEQmxUhduxv6CUXHr8OFsitU635Pe4Y2u1qFN/RLpuTrsWaEx4aSL7OiY2SQwuvSj9+Q8LEPDt2mJx0Qi/lPKLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0A7KPqD; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0A7KPqD"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c7so343174285a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790042012; x=1790646812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ByHXe55/uuBbCQG8Zppw6bo6YHny9xMuvL7YZ42cUcg=;
        b=g0A7KPqDAU/BRD52u0DeQ795PUnt4z2wxmWUcKMnccLBXUfZ/JecrDV7N2Dsc0n0Qw
         +wu8Vrbb57fIYTs1FWnNHxI/p6G2uwMe0rJTc2SnmS7sD4SzFLA11m54grNk7CNkmAcw
         VHwYPVqmn/CjO7amfRXJ4Hw12rfg31Duqk2jJ9YVnB568rFnY030N32UkUdx98MJE5Tl
         Tsx+EDhBgx2QvDT+i7/v3OA576RpLZCvGQ7grePqO9dhY5YcdON3QUGnSTEvKdMhZQK/
         aD8f4uITXi3r2S8lAadDQNpxiTwnlTZnENhQGuBfLPWPj4jb8xrAXZGjvainyQ7dAN8B
         AmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042012; x=1790646812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByHXe55/uuBbCQG8Zppw6bo6YHny9xMuvL7YZ42cUcg=;
        b=bC++/zuUxKnDo8DREI7VQaYJcWEl3Y82lkBzqsU1nZj9VRkZe4DJStyeG/wamp5y6J
         Zsqz75BQO3hsdzuwm03EJfB1u/A1qMJRnQV3Udtxh2vRF4f19FvO4gnY3z220HdEU7wP
         LiOBA+x6/ERnJI5Bp2dGla3cd9JRqPUMRq9q5qsnZfEIe2RTFfX6/bzpYMiNdu9B+VBb
         ybgJ2C1kfK0TMhpn61M9BLs5c7tayEkIQYdz39t7d3NwpQ9f7ziK3/GjCh4h5Pkw6SKq
         YMXbjZwuC/Mroe5O6SipBBdUDv4HC70QzYB2jMQsGTKa4pE++kfmjwEOPOa2ilgJkzUD
         QcYg==
X-Forwarded-Encrypted: i=1; AKwUvBw4YCIY02xXNCSUXkOe8UvIFAaUcF9iXVLHoR3PnGgZ0QlV7RoPb6ry8J1pcdu9gEjYwjvID3k=@vger.kernel.org
X-Gm-Message-State: AFuF++mBVQHzBsiWesQLiIaVqDTe1Rck3BraohZqe7GniJeGEuosfCbl
	hu1LlbGQ/lPmjBAWnZOsNDN/rRKvnee2RSVVd95naT91N5FfvupMTHE=
X-Gm-Gg: AYBFou0GWNUrfizPIy7LViRwa0WfwUlZRwH9fRUQh8Ce8bDdcF1DhFTg2JOf4Tw2/lZ
	YA+mnaut6PsWflueER2Td1qRVQPmG5KG3G6sguyLNABBjfCPuW99EefdhZN9y6guvcAPxCFhk4+
	/rRzd458IyPBtD+3FUCN++HxUCgFkaj3sbSG9wxtDeJqOzQjqS0oDyllXJTZgWN/+UZr2QVSIle
	XTh26xWFT1Udxuux9xeel2rzA4KlzGc9kg2EzY+psLuoPK2PVBe9ZvWcCXjJ5nruwfnNz7VNKt4
	6AAj71e1X8ui2Cdrg6AgBDoRySPBTmCBPyFusReHVHVTGedLyk4ue0J80Rdbd1f9MjJAgrNJoCK
	IgH3l8b5W8EMcW0dpyvbJzqVmt+lPeMfYxqAW1gEKQBrKQxnPIsxU7K28O7CMHyzyhO/DkyFNtM
	0MmFGleKylB4NjYIpROlFApgVSYE+yKCb1HKxZyy1Hit1PgQG5/0CFd0hZu1v1uUIGPnWAjetuR
	F+gPrYNIekZ9luZEDtjeRQsHpElmGeVsZF9diNyPsewxuvipmr/McqNdziUsSvz+VC15Z+bFcjv
	itcY1CNd2lhDAqLF5cWDEKvYf/Ey
X-Received: by 2002:a05:6214:2128:b0:910:345b:4c5e with SMTP id 6a1803df08f44-914008bbd47mr17891176d6.37.1790042012011;
        Mon, 21 Sep 2026 18:53:32 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91402536633sm3857706d6.49.2026.09.21.18.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:53:30 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: rt5663: Cancel jack detect work on unbind
Date: Mon, 21 Sep 2026 21:53:27 -0400
Message-ID: <20260922015327.637137-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASoC: rt5663: Cancel jack detect work on unbind

jack_detect_work and jd_unplug_work live in struct rt5663_priv, which
devres frees after rt5663_i2c_remove() returns.  The IRQ queues the
first work, a button press queues the second, and jd_unplug_work
rearms itself while the jack stays inserted.  Both callbacks load
rt5663->component before checking it, and nothing clears that pointer.
rt5663_suspend() cancels the works; unbind does not.

rt5663_remove() alone does not cover unbind.
snd_soc_del_component_unlocked() skips it when component->card is
NULL, which is true if the codec was never bound or the card was
already unbound.  The jack IRQ is requested before the component is
registered, so it can arm the work with no card, and it stays live
across a card unbind.

rt5663_i2c_remove() alone is not enough either.
rt5663_set_jack_detect() queues jack_detect_work even when clearing
the jack.  On a bound I2C unbind that call comes from
snd_soc_link_exit() after rt5663_i2c_remove() has returned.

Cancel both works after free_irq() in rt5663_i2c_remove(), and again
in rt5663_remove().  Cancel jack_detect_work first; it can queue
jd_unplug_work.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: df7c52168ee1 ("ASoC: add rt5663 codec driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Found by inspection; not runtime tested.

 sound/soc/codecs/rt5663.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 262d3bba1f3d..2430bce31b3b 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3179,6 +3179,13 @@ static void rt5663_remove(struct snd_soc_component *component)
 {
 	struct rt5663_priv *rt5663 = snd_soc_component_get_drvdata(component);
 
+	/*
+	 * Bound teardown runs this after snd_soc_link_exit().  set_jack()
+	 * there can queue jack_detect_work, which can queue jd_unplug_work.
+	 */
+	cancel_delayed_work_sync(&rt5663->jack_detect_work);
+	cancel_delayed_work_sync(&rt5663->jd_unplug_work);
+
 	regmap_write(rt5663->regmap, RT5663_RESET, 0);
 }
 
@@ -3728,6 +3735,13 @@ static void rt5663_i2c_remove(struct i2c_client *i2c)
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
+	/*
+	 * component .remove is skipped when component->card is NULL.
+	 * jack_detect_work can queue jd_unplug_work, so cancel it first.
+	 */
+	cancel_delayed_work_sync(&rt5663->jack_detect_work);
+	cancel_delayed_work_sync(&rt5663->jd_unplug_work);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 }
 

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
