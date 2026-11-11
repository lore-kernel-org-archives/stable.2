Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370424;
	b=SPN5UzqpC58ICeJjh8ZVrLUQAuw2Dh6Y/4FRUJ6BzzwDMQsUO4OYgnQPK8bVgI0X70JW
	 U5teRXaezB+IO4nEvc4sjw5zrHM+MI000grgKIQivh0GoAcSIqZxRvRnshDhOiMzbGM/a
	 yj2xV1uM3mrri3qUxC0gCfA0NyTtiyhkqfLd9OQOZ3fXL9jaNih2mEMYstWZDx6L4qPiY
	 ovaPojqnzkbcQnI1YMy5ZmDwIvBr2fhcrQRXmqUxFpLSOLsx1++k3ZZeVk/HqAu9mm3L4
	 pvUAqKiB6JizcGm3LD7mastQmVsTkIUP3xcf0NPrAXteGB4ckksaSQFckDAR/+h8jqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p5ptUqtNc2KAda1UrbM7Wi2hLYdlQF8+wklXxjwnDAo=;
	b=O2LvlEf4Nq4pk7E9SjiMvlUa9H57lOwu9gfGYPXXrZzqqAfM1X9sVJl36rLkASZtO4o7
	 UZsIe/UcjmnlpdazLmAMfqhNCQhspZJSvp9D4YGpEvBFfAKaYN4YyRGSlwfCHIr52xY4w
	 hyUk02/Xt+428w+1HiPGIy40wm6YDNRYxV6HzTFHiNwCYDZ3Qxn3Yyc03nhW41Ked0SOT
	 MOJu8jxpQB258l/F1Gg3oVtRX1uxPXs/3sM7Z9V/5PiZKNlOTf3FKtSWCU5nNHvKDe9hW
	 9HwkUMh6zmrcl1a/IhmaarrOzJO8U+jIY9lbyIAzjuWczf5ittnG3h1dbJJDChsiyAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNR61vu7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNR61vu7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2164D1F0089F;
	Wed, 11 Nov 2026 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370424;
	bh=p5ptUqtNc2KAda1UrbM7Wi2hLYdlQF8+wklXxjwnDAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VNR61vu7vwSSbmmSgU9PVgV8AtI0CE5EEyGhycgFHgU9ALFDTVQhWB/YaSYZ9NpRH
	 nPNbQYd7k52rZQn4Nx9HdkcEq2QCNH3I5WvQ/niyAk3iLyRwenH/VgMMbub5sf+PWh
	 evluFQWauyxc0u7N6THSSRWFOx7ZkX+pZsmGAbptADFHPYX7BMT2BizXjQ0wCGRO5l
	 IPRebUyhQQWl66POnHtbfdk++4haEBN5fBGUX3bJNnjyi3Gvj48WL6gB6ZbRvF23CI
	 mpH+VBtVPEW+qgLAjMTN/hqE8QA/N1C3Yca1VIT8V5f04/TJWBv4DHYuLTQQwkhxRS
	 ubIre2R+u1PwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] media: qcom: camss: vfe: Fix VFE reset while another line is streaming
Date: Tue, 10 Nov 2026 23:13:38 -0500
Message-ID: <20261111041132.1029567-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041132.1029567-1-sashal@kernel.org>
References: <20261107060052-failed-5.15-e5d4b0e69a40@kernel.org>
 <20261111041132.1029567-1-sashal@kernel.org>
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

From: Hitesh Patel <hitesh@ebytelogic.com>

[ Upstream commit e5d4b0e69a4017fd39354499c9d7583f625f0524 ]

vfe_disable_output() stops the write masters of the line being
disabled and then resets the whole VFE. The reset is not limited to
that line.

When two lines of one VFE stream at the same time, which is the case
whenever a CSID demultiplexes several virtual channels to different
RDIs, stopping the first line resets the VFE underneath the second
line. The second line's write master configuration is wiped, the
buffers it had in flight are never completed, and the VFE is left in
a state in which the next global reset is not acknowledged. Stopping
or restarting the second line then fails with:

  VFE reset timeout

Move the reset to vfe_disable() and do it under stream_lock, as part
of the decrement that makes the count reach zero, so that exactly one
caller resets and no line can be enabled while the reset runs.
Stopping the line's write masters is enough to quiesce that line on
its own. With a single line streaming, the reset happens exactly as
before.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
[bod: Converted vfe_disable_output to void]
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 41c63eec091e1..142bda014d4da 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -405,7 +405,7 @@ int vfe_put_output(struct vfe_line *line)
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
@@ -417,8 +417,6 @@ static int vfe_disable_output(struct vfe_line *line)
 		vfe->ops->vfe_wm_stop(vfe, output->wm_idx[i]);
 	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return vfe_reset(vfe);
 }
 
 /*
@@ -430,21 +428,19 @@ static int vfe_disable_output(struct vfe_line *line)
 int vfe_disable(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
-	int ret;
+	int ret = 0;
 
-	ret = vfe_disable_output(line);
-	if (ret)
-		goto error;
+	vfe_disable_output(line);
 
 	vfe_put_output(line);
 
 	mutex_lock(&vfe->stream_lock);
 
-	vfe->stream_count--;
+	if (--vfe->stream_count == 0)
+		ret = vfe_reset(vfe);
 
 	mutex_unlock(&vfe->stream_lock);
 
-error:
 	return ret;
 }
 
-- 
2.53.0

