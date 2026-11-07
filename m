Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047508;
	b=F8I54sgRjvuteXvLqciLp+5nuCdyfQoldJHb1jI+cf87IBA/Gpb6O7yoFLZjEuH/R5Oj
	 OelKL7ZCLPWXtEsRe/V9IENV2hMQ7umpyJgZcn9Q2wfkDOo5gt5sMeq4yxyeHpq8HH6xH
	 PEY6AMFHmKEmTNA/+jQiqwN5FelYQFqhDKLATlDqk79raSzHiUwo+dupFW66zaYMewsGY
	 Q1q9SPDi4zciuA6K0DOALmXfeaZSHbyzmzckMJ2QwrnEzagWIUIeMoXwKmus6g+MTxHLA
	 sXkBcek6NuMixRbiS1B9/7d37isAYXXtcy4GKIsMtN/M+J9fAxg+8rKzwigP8xF+lAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZQbc+im9yguABt/Kq+E/66sGt7hM0DT/0wHovuBBikE=;
	b=IETL9bj+IL4JrrJklB+t+AgZr+bwUGc2h80oo/LW/5E6vnRfyH/WVyMDQ4yRd5baNJ0H
	 5Uv9S8IW+6GiXJnJerq3WtPZprzFFDRNiO6xJcWsCse2oR6CFqWWUrOqve6vS1K8puUZR
	 lpd1UE0fQkuC0SAnR10B4mswnQDtxznRgVNJNy7zGT6BBVAxwFYfScGM9fDzckf9/HNvH
	 tVUuAM8bQM77ayDyFQ4WXnGMlDO/t7MMGJslOZBwV1rUq2+NtQb+bAFCP4Hdoer7NwvqK
	 t6Vm806kXmwi8J5nRxfYyJPSNH3V1OeHTul/cecw01wLGIwE+bfvFvqnMlokUp8Y7ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lVW/sVFH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7096606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVW/sVFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A021F0089F;
	Sat,  7 Nov 2026 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047507;
	bh=ZQbc+im9yguABt/Kq+E/66sGt7hM0DT/0wHovuBBikE=;
	h=From:To:Cc:Subject:Date;
	b=lVW/sVFHpgYk9a/OF4dY/cSufpRqHyoLf/n0PQ0WMCwCubUsMqewRno62YUH2fy9s
	 vbPwAM3/jXxv42mzuwF9uYXGI7qPvEq7aS0I3FnK7GA9yU9bkcjxJ8EGc+O6+ZNnvA
	 DJUwDHR63DlafvhbdkDujDEZhTYEu9vFLNzbxt9Go4SKTgYfi+2p69dNxgq4JjeXX2
	 82Ta7Vs6VMDF/cxsKxNuGB7nBcYDkaQ5jT1LUC4NoQc60hMb1ZkCS17RP3XF90mxlu
	 0WzwwyEwUWBLS0iMeliZCfbTq/7NJxSBVehTSoVfspe7XXQH//8fGhT38sb7KgoW+v
	 /gaPmIeShIcWw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: codecs: rt5682s: disable jack detection work on shutdown" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:45 -0500
Message-ID: <20261107053145-failed-6.6-ca552e3140e7@kernel.org>
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
git cherry-pick -x ca552e3140e736ed6704fe5d47439d8f2d40b42e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053145-failed-6.6-ca552e3140e7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca552e3140e736ed6704fe5d47439d8f2d40b42e Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 3 Oct 2026 00:10:45 -0400
Subject: [PATCH] ASoC: codecs: rt5682s: disable jack detection work on
 shutdown

The jack detection and button check works can queue each other. The
shutdown path cancels jack_detect_work first, but jd_check_work can
queue it again after that cancellation returns. Canceling jd_check_work
then leaves jack_detect_work pending or running while the device is
reset and, on removal, its managed resources are released.

Disable and drain both delayed works so neither callback can revive the
other after its cancellation. The I2C remove callback uses the same
shutdown path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: c07ac3ee76e5 ("ASoC: rt5682s: Fix the wrong jack type detected")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20261003041045.650207-1-mhun512@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 0f80e4c32f573..49ed7793d3a20 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -3318,8 +3318,8 @@ static void rt5682s_i2c_shutdown(struct i2c_client *client)
 	struct rt5682s_priv *rt5682s = i2c_get_clientdata(client);
 
 	disable_irq(client->irq);
-	cancel_delayed_work_sync(&rt5682s->jack_detect_work);
-	cancel_delayed_work_sync(&rt5682s->jd_check_work);
+	disable_delayed_work_sync(&rt5682s->jack_detect_work);
+	disable_delayed_work_sync(&rt5682s->jd_check_work);
 
 	rt5682s_reset(rt5682s);
 }
-- 
2.53.0




