Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049274;
	b=Eut+ksPOgrLdSivk0UBTSWXLpsofGgSXFPMj7cD8eQVSRdw7lOqA0cf14ME6wlDo6wJN
	 u6ZREnGwbY6bXna3Zf2oMzVsOcEHHK014rUXBM+5zda11gbxqZ+AohKZE2YJOwki+D0uW
	 2k8OkYNrTUD/NYFR9+5Hm3S/6+U0IZmIdLOlbWwZcm2mm3LfUGWIx9gB7Kq0/DbFuyK3X
	 pfClz/HKGstjU6awXHJCaiPcTDLQOIsGjaVwKddslE7rTaUZATlb/JSnwzEdaLz+q/nzd
	 JbnDWy/nRoXpk8u0bTP8eSbJAwd0SXzaKB6dVN2lOCs2J/Y9l4zykXlPp8F96RsFnMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MVocChVzy3ghXacirZnO73Jv+z12OPmrQRYW//wLmuQ=;
	b=cN39Ef83aRflci3V8PQh7ECFnVlSHi+xHcbZ5sgvbjBciGlXUZ1Pq9MK9wo/lpJS+33G
	 ffZKHgVzbyWMTvILl6pimig2B7PmVVIttUjtjN1vIq4PfywGELSxe56bEWfWzigrtnF7p
	 cXBGpc2MgvrkPt+VNxq9uHP/T+WxLQS2FEBPfCrBJwAqhg2pc2d9ShScYZcmV2BW0Jndr
	 Orq/9eV4HKVOfqs9epbholm2jSdPGxLtF7CPQwmL8ZZCy+dpZG6cUE/i2BahSTJQ3omaQ
	 QbDy6kPuYaGe6xtH9Obeo6x+wmnltmj4ywB1lnhiEYUK7/p5v8Q65Z5ypPLojSYZJ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OWKwyKa/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWKwyKa/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BEC1F0089F;
	Sat,  7 Nov 2026 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049273;
	bh=MVocChVzy3ghXacirZnO73Jv+z12OPmrQRYW//wLmuQ=;
	h=From:To:Cc:Subject:Date;
	b=OWKwyKa/NiQPUYNU4zYIBm+eUOOOOBJaA+5GQ9Apg/4r1y0uldLCNLVaf0sNDYXJD
	 e6wamSnTPbDwPRcfaBJHkDp+uwLh3+8jgytpb4rRqt1jlFLPUB4fS5mEfPufEKbxO9
	 sYCDmBqNpi+0B3vpsLMpwCSPbMLTxCaG+K0lu3KxZZhM4fvhZ8QdREZ9b8O3Wge27v
	 RKjHUW5cOzmt2oPui+5oLMTNZXYK/GttCa7eYOrZBUkOL5pFL8cuRIsW+y1cDzWQ8o
	 1/M8aElxxOAe01HQB3vBPTmOGJ1YipqHdCHoscJ4IAiFyhEGhUjKVU0tkZiw1U1oZf
	 SQsnm63ZsFCqQ==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	ukleinek@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pwm: tiehrpwm: Clear period on disable to allow reconfiguration" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:12 -0500
Message-ID: <20261107060111-failed-5.15-e74b9a7ee500@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e74b9a7ee50071aad25d3989bf985292f90b0c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060111-failed-5.15-e74b9a7ee500@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




