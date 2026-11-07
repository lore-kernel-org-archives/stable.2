Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049255;
	b=s/Jt8yZZTRbZ4rzoRlNl5ADEBlOLkHZoLtmF/KQw6ypI0qt3AGMGxD0rYvDpYOBU/OkD
	 80RblU+VNyzC9hjxYsr9ztyQ5mYIGm3AjVi3MoLQZC3L4J4SM6GQ8SfeNlJNLKFKEP1jj
	 9hNDE0x6E8NCPzKpjiXlhkAvVWjEajZ6OHqkOxi8N/kM64YdyjA7iS8zTE9c8mDJyf7Ro
	 0r9hJTohxKQwG1ZXfL7PnMOvovxZ32iS/4GC5hOcCJwUhEosAC14wRzcH8/dVaKbeK72a
	 8Q68p2kQK3IEGo3LCtb0l9b++W5Mq4aFYBcZ1p5zlfLCD1rQPO+mlaX28QykEzIO5AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049255;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3ZOQc5qmrqqJPVa0HUNAUAAmqD063Z8lmMulZ4/C9uY=;
	b=q3OwHdksMc/+20nIkkL2x69RWD+FjM9Kv9DOreLLhYaQPaKTxnOMRp7Kkh6Wc8Dlfj9w
	 /Mp438RegRk8xu3UtPGSvs06AEPxGq4QAiOl6CyHUD3oSzA4G1P6Vr7+jJRdi/p9jqAfX
	 ix9Hx3wLhtwnJ/1Rw1/j2mZR2Vr+3bO2c6XtXXJ67CH/BH7TRSJwF4Csbrrw9EzQ2hIvd
	 83tGgPxDj0SSibiKqnJUUHv6jP3uCrINaKZ0zMv3Qdx7N8RELu8HON+8O5YT9hmlYv1hu
	 2h5r1nQgLEDKzIBV+sIHN86dBB2iFCBXIJiaFz9w+ukNC4ocK1VA0RSZznsTAbmvqnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaKBxxoa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaKBxxoa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7391F0089F;
	Sat,  7 Nov 2026 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049254;
	bh=3ZOQc5qmrqqJPVa0HUNAUAAmqD063Z8lmMulZ4/C9uY=;
	h=From:To:Cc:Subject:Date;
	b=OaKBxxoakHnTv7uKpLLGEnm6fd3ohpHAXwuOkK3WsC2ThSpxgXpL1fDKaXT/uVUiw
	 D8oEWQH49AShYto0IanQ6tunF4FSjpMuwi+jW4w3aIPF2x/R0c5H9HVUU7qz0glNs7
	 X1gr6zjwGeaRlEtRrakrbmeFkNo9qZrq/FEfO01AIotl5RU/4noMt6oBxHZv7Dz0WS
	 b3MwCZGf1XktxBQttcNXFzT8dlJVAFuGiCGv5hc0in4eER3xWP+YTlxtKgsl9PI81z
	 VNI/H8nH08WBgKgu7cNAN5eoslYOBJrVkP4FKdZEFwkjH09ZbasKHRON5H2KR3dFKl
	 vsYvsAEDS2LBg==
From: Sasha Levin <sashal@kernel.org>
To: hitesh@ebytelogic.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: qcom: camss: vfe: Fix VFE reset while another line is streaming" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:53 -0500
Message-ID: <20261107060052-failed-5.15-e5d4b0e69a40@kernel.org>
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
git cherry-pick -x e5d4b0e69a4017fd39354499c9d7583f625f0524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060052-failed-5.15-e5d4b0e69a40@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e5d4b0e69a4017fd39354499c9d7583f625f0524 Mon Sep 17 00:00:00 2001
From: Hitesh Patel <hitesh@ebytelogic.com>
Date: Mon, 28 Sep 2026 17:45:05 +0530
Subject: [PATCH] media: qcom: camss: vfe: Fix VFE reset while another line is
 streaming

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
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index c14d97a131f69..2680a9914765f 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -808,7 +808,7 @@ int vfe_put_output(struct vfe_line *line)
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
@@ -820,8 +820,6 @@ static int vfe_disable_output(struct vfe_line *line)
 		vfe->res->hw_ops->vfe_wm_stop(vfe, output->wm_idx[i]);
 	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return vfe_reset(vfe);
 }
 
 /*
@@ -833,21 +831,19 @@ static int vfe_disable_output(struct vfe_line *line)
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




