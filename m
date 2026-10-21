Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586143;
	b=apKsC55L3BQ+Yv/e0dSpeXjSmhtHZqcDaeQn1MphpZnrh+3QcixCKIysPqm0vew4w9rp
	 tkpyeNJ00aHC+sugrQzjPoHx/115NqunEA8jf1/Ho4eusPWlxEPV0SMfyjZHGMG2GIYFR
	 KQYqO4y/QKH9+1TC1igRVwDHiITjA2t9yeqoLev4LXMzup8N8cGtn+WUg/joBVRqLnNT4
	 bTyNxQ0fjVhV6CQlvgPOtJobJH40p3poSn58moxv6//gFruAzoBMKqu1sYSJXNOt6fA3w
	 LnMMMQW438hR8xuVJPWXbOJ4iNizmlh/MJGNi0hmWkspk/dpAguOZiGxGAb71+AdmzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586143;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rRjJ9UGtMuFxoq3PHT5rK/LIbEmzm83jrP7CttFUD88=;
	b=sj3/DHeL05l58t19iKuIlVDjf7oRb053pBdlu+9nGrzlUXQfL1G38OrNwt2W2WcqKdpi
	 sdwBcq4BaDWZNziNsT9FtZExt/UK3i27sjaVuDlBOtvcMXgGzi2eFCHqQA1Hl7VYmd70N
	 WLuHTomKhGkpeqGe67wdqy6M64v0sH5T/533YKwugeQlekEIwO1RoT7n3BKH/eMR9ggSz
	 AfY72da/T/NCA8F7xdAw/WLDU//m8IBKkCITOv/gpH0iSmXaFXcGe2cGdsClRb1ovE35G
	 Gmtq03AE5Ws3ZWriFWF5olzOVvu4+vrFhwKyxPZlOOFyWNA8DeItisCxh6dZHp5EYHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8fNmmZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931A606ABF4;
	Wed, 21 Oct 2026 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8fNmmZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461BE1F000C4;
	Wed, 21 Oct 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586143;
	bh=rRjJ9UGtMuFxoq3PHT5rK/LIbEmzm83jrP7CttFUD88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l8fNmmZIxyVF4DhXOFBNNhkEHDxpo+Ti4/BO1LEuV4WRelAVpaiktjU9y5uqBkVUI
	 0f1IS4nXMs9nPZkyMyIq34qWkO4a1lshj48JOzJFa35mnc/DXQ+O3LhcPKjzUftx5S
	 19+aJUOnkc08yFDy8R90EkCE/8/zThwG912boxzSg9EmYJStTNTYsw9HcrrXtP35AQ
	 WSJMZ2QfAi5x2PIfHA5CL9gGU704H4JR2JuVirwpWNID2X+bfa4M6USsiGjqk+J34u
	 R0WU1UtuM0l26mREQvc7DClhFs7sJPBpTt7p5vX43OEwsDPcceWW7I4KsZhgcIr0wq
	 +anpWyJW0Zrsw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Bryan Wu <cooloney@gmail.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 14/21] leds: flash: Avoid divide-by-zero in led_clamp_align()
Date: Wed, 21 Oct 2026 12:32:23 +0000
Message-ID: <20261021123406.3163547-15-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

If a flash LED driver leaves a setting's step size as zero, writing to
the corresponding sysfs attribute invokes led_clamp_align() and triggers
an integer division by zero when aligning the offset to s->step.

Clamp s->val to [s->min, s->max] and return early when s->step is zero.

Fixes: 7aea8389a77a ("leds: Add LED Flash class extension to the LED subsystem")
Closes: https://sashiko.dev/#/bug/linux-9d06d7fe-310b-4aee-8b16-0fb49550c287
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/led-class-flash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
index 181dfd49c6ad..16b3b6b9365b 100644
--- a/drivers/leds/led-class-flash.c
+++ b/drivers/leds/led-class-flash.c
@@ -375,6 +375,11 @@ static void led_clamp_align(struct led_flash_setting *s)
 {
 	u32 v, offset;
 
+	if (!s->step) {
+		s->val = clamp(s->val, s->min, s->max);
+		return;
+	}
+
 	v = s->val + s->step / 2;
 	v = clamp(v, s->min, s->max);
 	offset = v - s->min;
-- 
2.56.0.218.g1ec904b173-goog

