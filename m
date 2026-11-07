Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047450;
	b=mFC2cpllsn2uv0G4mlQu7RmPWV6j+7y4Py2ptQRpa+xZxFn8AcvlkO6/i/8bmpRw599w
	 IpEgtzE/5YVSqsrh0Miv2iAS8Ph0hljMX5GHN/LusnBY2CdJR9OFbuRaqQTSm9k7542db
	 6GKiZG2PMO376T9qBd9jBdc/k66zxWbccMbT4K0aMme49FHXHhmSvUVxiLbxk5gxgBN4X
	 fMaiTYky8OyNIJYCOi7AB4HzxWi8b5O/muspZlx2x1NxRppsWdLZgOn5LdAoRLOF8ODkp
	 2mfHY774fGnfhhv+zyhQZJfyepBI9LlBjumoRBbpxG/iRLuHej+N/nTCblbql7HyY1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4rTQpVO94vJQ0N/T4ZmJVRKnemkJ7HduIktGvHYY/o4=;
	b=h0Y5zEC/LZ5kc/c6MoyV/Qva/JkieI3aU0/DbOQrwrIdQDXblcQJFl+TSlrR2m3S8Rni
	 62MHdND2vqk206BkGmf7NK12hJVzFEq3nfweF5VbLTaA5mJw5LafA20WH4th1LSp33WEl
	 KAxNdDaVseD2zcvTg+WnyxIE69ybvkU/317+DRshPWbr8zcMJzb0muWQewrzwM7uaKPOo
	 Z92H38wMV0bW8cg6R0cf6lzoJ52PldQzICx6+Nvizz48b4ZzUfhlY+Uc60ALifKtPWdWv
	 ds/oBZHgqZ9BvM0lm0Di/9ZMs6XHKZ1hnNuQw/7BdwztdOWA6w56ilKjZC+32jQAYIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjztFlyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90401606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjztFlyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0651F1F0089F;
	Sat,  7 Nov 2026 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047450;
	bh=4rTQpVO94vJQ0N/T4ZmJVRKnemkJ7HduIktGvHYY/o4=;
	h=From:To:Cc:Subject:Date;
	b=JjztFlyIbfJkXntKdqfgiwf0aEhfxZZp+NPz3JGZ8MGwFe17NQqLOZMXTG/zjvODD
	 JuUX2xvdxBEWSr4nC3TYjLtNF5oXk5uRgb/8nRt9IGFPxn+HgzAICpWpUMCxfPArD/
	 R0c1mXZAe+4DjRDCsgM+CZ71sa6VSjBDisFPovILGsXRF1+V6LhYgxCpjXGqDPZOT7
	 z6m0t2BbLusoUbE/TAznhTAyEg4LXgX7mRilZeDxxwYuWVBC2wN2O76FIOjXV46LLd
	 kjrTurjZ7nDZpBJ5W3NNFCNGp0u2I1JzLng1G5SUtGyGOsilGlNbMC/9hg0BB9UfbB
	 clSueyWuo/bZA==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	ukleinek@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pwm: tiehrpwm: Clear period on disable to allow reconfiguration" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:48 -0500
Message-ID: <20261107053048-failed-6.6-e74b9a7ee500@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e74b9a7ee50071aad25d3989bf985292f90b0c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053048-failed-6.6-e74b9a7ee500@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




