Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488F516174
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683699; cv=none; b=ZusbVeIsGAnXddaadrJhgP2CeiR7WIlqBonOvBnueY7bKbT+NnGlQS24YZaBHBn3hDD/ZxH066mrnF5q8ynUa4/vEOGi7x851FjByFgDoQh8HBb7kTbzUvXjwplvs9I/HMXQfzdYrkDD8gKkvQw1yS60n82xU/mJOPCyvssSMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683699; c=relaxed/simple;
	bh=+VcecVkrJmOeZYvZbQBA7c3562muptPNCkTt8WujQYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvmHd42QTiUDE2402E9gjtXJBd5gFVvrY6yvaLE1iCwnmbCjSjwJWq/IXTGjO47Z9nOZ3XvdIuT2+ZRPs+ao1Lmi/jbSavz0O6xLqz00PS7UrCw9Qawp8CXObpdDWrnLHmF4/jg+0SASiPkowTjlHBycnzhEYRrtD9FLZVl/JlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=oKWfA0/G; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="oKWfA0/G"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260929120810e8880ea4cb00020708
        for <stable@vger.kernel.org>;
        Tue, 29 Sep 2026 14:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Kax74zXCxtPAbpTr1V6NBQYRh6q4iQaKKcO5IgxtslY=;
 b=oKWfA0/GAs7LaWlq7k+pknMp/aWFhvvvx/fHUFgipwR7Unn/hB/WwSXc0sDj5/oRc5cvjP
 cC2/Gopgd0hnkDqtMY5iZ0LsAPVFOhqzeBwxOCLrfWjB5pzYWZ+d6WTHUqe0TVyI3L7BshPm
 kk3L5ljYwdAI02a11AuQmDYEg+c7XStBInrrkhzYCpsH7Z1Wz3uiZZGXgBRkMLPobqiCWKD+
 ObyswWmuhIYGWB9HRfFp20a/GbsdssNRG9mMlA18FaOzM8+VpNQuavNAj4g9dt5Tele5b1uz
 T2DqWpfLbLJvFgiXa9q9YuIqXBhmoKMwVjpTu6dCbwmtlunCy4PQk0/Q==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-pwm@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	"Philip, Avinash" <avinashphilip@ti.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pwm: tiehrpwm: Clear period on disable to allow reconfiguration
Date: Tue, 29 Sep 2026 14:08:02 +0200
Message-ID: <20260929120806.2790355-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Both channels share one period register, so ehrpwm_pwm_config() rejects a
period differing from the sibling's period_cycles[]. That value was cleared
only in .free(), not in .disable(), so a stopped channel kept blocking the
sibling from switching to a new frequency. Clear it in .disable() too.

Testcase:

  cd /sys/class/pwm/pwmchip0; echo 0 > export; echo 1 > export
  for p in pwm0 pwm1; do
    echo 1000000 > $p/period; echo 500000 > $p/duty_cycle
    echo 1 > $p/enable; echo 0 > $p/enable; echo 2000000 > $p/period
  done
  echo 1 > pwm0/enable	# before: -EINVAL, after: succeeds

Fixes: 01b2d4536f02 ("pwm: pwm-tiehrpwm: Fix conflicting channel period setting")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 3a53489f0b982..e3407d0a1f7fe 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -358,6 +358,9 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(pwmchip_parent(chip));
+
+	/* A disabled channel must not constrain the sibling's period */
+	pc->period_cycles[pwm->hwpwm] = 0;
 }
 
 static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.55.0

