Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050272;
	b=HU6i5zWTRegZgYSf42rTijiLlZlN1bOrmRJS0XrGeQR+WOi07JcfXBXz60TRoeaIEQcN
	 6SENofnGhbbE8QE8tnugmh1+Wew1OOK/5lqD3Cej8tsdEa8VvHrTy6Vp9NubpRz/1K3QZ
	 BU7EbHN63ky9agfpSnVep7DxHxYS6BOfq8nBBc73QmyT0zXkudH9I/ML7sW+NOOD93WWT
	 IahwLBfYulSaOLnCMjKwKSNHrR+u5XHnF3E5eIgjPaAPHdJ/1PZ1igAWbsaVjcD5fYs6c
	 1wfgI5O5nyYSa+v1Jx5/zfhBo08lrjsm2c50AVuQPFtYCpNVS7aOXy0dqDwN6Zmtbkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050272;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=alLCNyvGE/bRa9QzESY4iJ4cfyZ4YAqGcqVb8iB7hLo=;
	b=IvnY/zttONA+Fc8jMiMmMxGqQhPkLwISDxNTOsSgzAgZSjaMmCeUiKIbxMj43TvlZGML
	 Uj2TLiCqkgdoxFlaE2MGC8DMSP1WxU+sK8GK3NVnFAfXoxwU1oZadR59K1uEVqUwoWoeD
	 axKiyB9JmuIihqym+OnhSw0whmKRSvksYrzxVocSr+zYjykvUlUp2DZDis9B8Q8jcf+HH
	 XOxjk1/IddGi0HM+mBd6hmjqg/q3Ob6aQsDvrs3fNsAM6NINjt/3mokSXAq3Ah2Zn6ekM
	 GsCAPuRoTR+f5oC4TXsqCwD/sY/ImH9YRISFkC8cXS3o4qCgnj0bhkUdPaMy7pTOIfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQPZdhsO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F963606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQPZdhsO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05CE1F0089F;
	Sat,  7 Nov 2026 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050272;
	bh=alLCNyvGE/bRa9QzESY4iJ4cfyZ4YAqGcqVb8iB7hLo=;
	h=From:To:Cc:Subject:Date;
	b=VQPZdhsOGk0iC9Sf6akzasAttPJoJGmCMppcEkdMFynU3T3cggPP5ty4Qzceiq1qL
	 HYxBuBPaYAEsFq3I6sz66qJ7JBA0YVAiAG99zlJyTvYAVMaNrCWTH/zVCysGAoeo/b
	 vRONhh6FX+NZNxfF+M+llUnlpPgaxlK/4bg2ujMP7bzCsEk5MXAp0fokbvpMgcjGtv
	 lG6XweVmySYduPmdtu0eWJjLJfVvwEdrKDSw5dO6i0Z03vldY3De/v5zgsuqzC1TAM
	 qimZ5C4tV0P7EcQEguogQGLUKwap3ysDhbJAhcYBNdcdHPIXYF3PghkM0Fh+gE1ilK
	 KvwsNRwvYJqIA==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	ukleinek@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pwm: tiehrpwm: Clear period on disable to allow reconfiguration" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:50 -0500
Message-ID: <20261107061750-failed-5.10-e74b9a7ee500@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e74b9a7ee50071aad25d3989bf985292f90b0c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061750-failed-5.10-e74b9a7ee500@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e74b9a7ee50071aad25d3989bf985292f90b0c6e Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Date: Tue, 29 Sep 2026 14:08:02 +0200
Subject: [PATCH] pwm: tiehrpwm: Clear period on disable to allow
 reconfiguration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Link: https://patch.msgid.link/20260929120806.2790355-1-alexander.sverdlin@siemens.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
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
2.53.0




