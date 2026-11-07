Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048277;
	b=wYgxX4ui6P2hzE1frA3OsgRATy3Rz25icbL6UaMram3edTqP1M4JyFJJ1kB/1DHFY2co
	 rzPU1H2cnJ74/MtABdjWmroD036x6ZJI03TSEu3d42K2bR9g+xlJKjBsh9lf3D7foC9TK
	 Am+rUZyjZrnHPMwdoJLi0eTbSeip+cBP2TXuUVD6XbM/2nGV069EE6a7A8KekjBrVo5Uj
	 AItF3+qJnjGEfT0LUaIYdwDtY00hf4u3Sjv1GQmVgV46ALqrGZpVjbi3u52+mfEQzwUzU
	 NJulXk53EfjSvOo9weFGxlyStLfZrbknXl9jBh4Oxx4BQ4/CDoGWudxKZ2bYnDXzoag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Fyk87+vQKwE3kFOUJ90CE8Kf4wRMeGB5UO7WVPj4xjE=;
	b=4srW0V8ILGshf7RuuE1DZhyalpN2BhziFczCSnLSFzgGfikhEvOm4X0FZcWvDCFhLG5j
	 kznxKT33R/5m23dut7eDSFGN37vjutPcPBAn49FlHjQlsRLD2JUgtfcBgaaniOXvIqYTa
	 TXVLNXYylXZb79YhF4zV2Fl0Ln+adh1nEPvq0HtEyoW8d/uY/i8VAmY9tcPq3UOy5LgiD
	 mH3wEtFI6YUONCL2qTUdfiRkaDM9jy4bNbdzXIaDu4r0InuqMFzBM1iBDLHYF6hg937Wp
	 5cujWYcNdTkmAceb4zqAKdtipre33Py5QH2oQXCYrB7o8/xXlEWPlj7RA3/YfCnjVDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCv0nVfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCv0nVfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382211F0089F;
	Sat,  7 Nov 2026 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048276;
	bh=Fyk87+vQKwE3kFOUJ90CE8Kf4wRMeGB5UO7WVPj4xjE=;
	h=From:To:Cc:Subject:Date;
	b=kCv0nVfrZDz4LZSfEN2DDawRENB4hwi3tf7s0MXKeTfopNc3sJyif2m6fejhO5kf7
	 kvo774/KXcCD8wTRm1eSjT4QOgpm3WCoYowPgqrVAACnn1cKmE6zWgc/8sWdpqsb04
	 IAIhGqFRLayHNT3OkQ4s+EJF3TD98yJ8zuhc2ojd3wfu8aESf81b+EyUKG27L8sf8U
	 ar3poQ79kOMEZvHKBsLg45RFEKN8PboqsJqyqMEsLALFLVsbtAGc1EPB4r0U9fk38a
	 gW70whYaEz/wG+wg3QT04SdkCmSOJGDRICtCjlHSM03PAHr9G2RIReysosdHir4gHE
	 s18qItF+vNoMw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: codecs: rt5682s: disable jack detection work on shutdown" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:34 -0500
Message-ID: <20261107054434-failed-6.1-ca552e3140e7@kernel.org>
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
git cherry-pick -x ca552e3140e736ed6704fe5d47439d8f2d40b42e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054434-failed-6.1-ca552e3140e7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




