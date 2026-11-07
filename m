Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048216;
	b=fN5NImb7HFHbMN26fhefmozmohqrp6bHTTiCiXCGMDBlTvHBADmMftgY1HmMFN9/QbV4
	 Y6ebwUDRZ4KsiM8V7Ht/h6um+//VFIFTIzMFt9JLkvjeCqnBJ75bwJk+YUDqKEhk/dXhY
	 5h+6/GsPuGpfg7UGjbftRAskIfz0svCHjil2m8J/7auBomvlzZKzJBR2Pg1S9bpXErltv
	 zK6YuR9XTfwA8u6paMtTaO+EXz3GNh8Cav+iy3IxWE7blmX+mpfDLFZf8Yw0Y8bjkYrIX
	 Q7NVUNezVOQwjAkptFcZcxxEJrHl+17WOPRk7pyBL8oDBjnDvYtYgM9GJs3LgtlhrVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WNmuoYNTgmuo9bVEfwceLqx5EtsP6LiWO6xBw5Yidlg=;
	b=LqJTOCmIS0tbwe7VlOCOvdFKA05Cab00yGaZ9vDwhCIvU16V0UANfi+K8FUlndFTpt8Q
	 XsoeaaS4HH2GXnQV9ygmlEkkUp90r7r1QRmWwgZUjpMyxbCtqwVAeJGY4Rgg9Jiz8oKKK
	 C54g50hAnvRe+iAHf01/a+yjdvRgm6KjAI2SM9R2CuBhzlRzymoCue2gZLDRdanpLh0CC
	 YPcb1xeEbXRmFLiWKor+Gx5KBTxrZdG6bUsPWr88LliOJYzYzkdJGVwrlDDFEYcptSUBt
	 wWXxZlBI/tglGQU0jy3peN4m74HkJI/fxIRG+DA9nmFqXm/mZxVbh5afDI+UqxivyeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiuyjTR7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3D606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiuyjTR7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF51F0089F;
	Sat,  7 Nov 2026 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048215;
	bh=WNmuoYNTgmuo9bVEfwceLqx5EtsP6LiWO6xBw5Yidlg=;
	h=From:To:Cc:Subject:Date;
	b=PiuyjTR7N8yocWyD0v6unQU7hWoByfWQEZPY1qACbQmNFSwkIa3wRIwYgGiRaG5LX
	 wbH07V6JBFAf+dbpC2uaC4vk/R7XZXpXBLtWVwwNiJClL7wSyaBPeFYabXXBUh2frE
	 gn+wNSV+iwfULcTgVIA8k+AiYDUQq8unqBp6BnlC9gJltIF6zTzuTlyaJcJqmmIYCL
	 MxKH4GRDYzHaAOhQALQtp8P6ScifOZMyi75u1TfkCJV59Gq7sU6gElY/uv/8GW+M03
	 lwvbXozAovdnGO5cUuMVkiE5s+v90oRPLHoxhX0mtSFPNN9WcNZ24jlZaTA99NHaFg
	 Fd3WXATBP+E2g==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	ukleinek@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pwm: tiehrpwm: Clear period on disable to allow reconfiguration" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:34 -0500
Message-ID: <20261107054334-failed-6.1-e74b9a7ee500@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e74b9a7ee50071aad25d3989bf985292f90b0c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054334-failed-6.1-e74b9a7ee500@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




