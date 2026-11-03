Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694687;
	b=KA5UWERiOnBJ7Fn9fUuqN40ctkh64iKEEpEPeYK5GrPbpOu9LeEWPvi5RCT4Km82KnZ6
	 WWYUgI+/JtScGlFwl65pPYq3kGbA9RodT63cbW7gfNm6UorxEEaXUtJrFZLB5jB70cLx6
	 1mfNpmepGmyP+vRUnxCNrezztiCxqoTWw0teJ2X2mMiUUUgPdCTqqe6BKsaWlFYGzgTON
	 RNEGVm5zxQlA/uqo8m3TrAD8qkIZeSSHDdZwBQggKWWaJi84CaJFit6fgPszIgXa65Ck/
	 pVL0bSJtJ2hR/3vtmxc9rcelzhF65NTC54kr30UT/kdeZiTLmwdAMzrSGOMnzv2r+dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694687;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=N/32RpzipPksbyw7hpLe9vuq9er5JHhLwdofJhL7vbs=;
	b=gnwvFiSoLfPxNFUE5d+8rsWAC6yigGzqL4lV3c+yaKcPwDFBoRw5R3K3RtMQFuoIrz5/
	 vAqiZQMGxqvO4WXcWsymLIhNfk+NCIoJ+0H9gkmmhT0pEgeVOI0xV0Ii0lBLsyl3HcgVn
	 1Hyi34AoQjugTm+WvO6+S4kAN6QIwfLL4IgeVo2CK9Sv7C8TuIasHHPjBuvHaXpDgn8Au
	 8zipVLI0m/NNkV+DwoTbwYZF63cIkn8FLTzPGWTGLNrRHzekApzCWxnobMMubuaZ61p3I
	 p1++PB7NjvX/Q7V5JS/31eR0pZevi2YOISXxQaxgRpAYVu1XDOTkR5ydHdIHskCu53Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD26082BFA;
	Tue,  3 Nov 2026 08:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBD26082BFA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3xZbbm+lqfHc6AA--.1447S2;
	Tue, 03 Nov 2026 16:31:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx25821: Free controls even if the video device was not registered
Date: Tue,  3 Nov 2026 08:31:32 +0000
Message-Id: <20261103083132.1171874-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAC3xZbbm+lqfHc6AA--.1447S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xGFW3uw1xKr43Gry3urg_yoW8Cr1Upa
	90ga45AFWkJFWYqa18C3W8Kas8J3Z3Xw48CFWDCwnrJwnxG34Sgr4Fqa45GrW5JrWI9F4j
	qr1Yvw4UuF1rZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXID
	7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMAA2rpWfX8iQAAsD

cx25821_video_register() initializes a capture channel's control handler
before setting up its queue and registering its video device. A failure
in control creation, handler setup, queue initialization or video device
registration reaches fail_unreg, which includes the current channel.

However, cx25821_video_unregister() only frees the handler if the video
device was successfully registered. The current channel's controls are
therefore leaked on those failures.

Keep video unregistration conditional, but free the control handler
unconditionally. v4l2_ctrl_handler_free() safely handles the zeroed
handlers of channels that do not have controls.

Fixes: f8d7ee70919d ("[media] cx25821: convert to the control framework")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/pci/cx25821/cx25821-video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/cx25821/cx25821-video.c b/drivers/media/pci/cx25821/cx25821-video.c
index 84aa1209e717..84aa7efc50d5 100644
--- a/drivers/media/pci/cx25821/cx25821-video.c
+++ b/drivers/media/pci/cx25821/cx25821-video.c
@@ -656,10 +656,9 @@ void cx25821_video_unregister(struct cx25821_dev *dev, int chan_num)
 {
 	cx_clear(PCI_INT_MSK, 1);
 
-	if (video_is_registered(&dev->channels[chan_num].vdev)) {
+	if (video_is_registered(&dev->channels[chan_num].vdev))
 		video_unregister_device(&dev->channels[chan_num].vdev);
-		v4l2_ctrl_handler_free(&dev->channels[chan_num].hdl);
-	}
+	v4l2_ctrl_handler_free(&dev->channels[chan_num].hdl);
 }
 
 int cx25821_video_register(struct cx25821_dev *dev)
-- 
2.34.1

