Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368990;
	b=hxqAAhW/z4qE7gg/qkS8SFvLG/nyd594tRW6FuFIgzpzK5yVGpOcBkrVXCDawZI0f2bF
	 YbKv6440Oaayqos3gHizKZR463IeBpnQUiPKsn+NGVNhvC3rtZoR+n7PutE6xGDWt8II7
	 +mV15yXeDC+a97dazc1hMutEP23hNmtb5ee2P+uZN74oesf7NMv534VXL/a26Y/KvPVEy
	 Djrgb/DvmKL4sygZWhxk1LhV6ZuvBA01HQjjgXzyrKieKStGXSw+4L2e7Tg9pnmMMPxxe
	 M+aYIXwhgUjiJHikGfFXQWmyCEk7l1hd05kd4mLuHGOhjv51DqJr0JCdgLYtx+bO7UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Af2h9ikhJ2DeH6serzZnPjb9I/xiGmNIWrYHWnVJ1wA=;
	b=MnBvCXX95/ot3PtFLkbzLzCt5C88jgUg1xv+4jczytpiIJkMfk9HqNXaGyGQxqW0ieSE
	 gC9AGfJLeuSj9s2vhUBzxdkxJBpqfx6qGt16Ihh2ZkQJj6g7a3X3PF4lxDGqbroewIu2X
	 3L9Hm/XrfQ/FRr/Xvv1mDMQDGCuIl4Glk0AsO+vNh2TwW+Oh+aveONE934lCXGJ9yo81t
	 pno2ymCFCBjAaDLBLz2ScWdNHXUTBcf4ZBSRa1DJl1gSZFo4/BrUudx1L3BHQeJRoocKM
	 SsXqcyqX76tI12megISsK6YBJx6/SfDAJAyN6L/BTb+W5MfSBXR1smxmsPFhFua+3xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVEHQmVx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0466606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVEHQmVx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DA21F0089F;
	Wed, 11 Nov 2026 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368989;
	bh=Af2h9ikhJ2DeH6serzZnPjb9I/xiGmNIWrYHWnVJ1wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TVEHQmVx3e7HivcrylyaBF3K/KI3bI3nVD38VaPYS3tWKLlZths7DFPG29AwwCErr
	 FFxKhZfAo/+MBlpCE2ilppItilDtaGgeKzN31MzqfW3+n1wHwSkwZ1/34UD3hhiURN
	 QghEhm0tNvufsuj7afPvRawiucAHmf8CE2DG+RSSBLDNd4U2EFWNKi85xdUEeLQ0zE
	 fICcomrC38dY6dCYiH/RwjrbfY5Im5wth3VWp+giKHvQLBWSd2C4SKw+Hr3SnCLdYM
	 J7wj+OvvnifPdYyUwDxEJCGgOMaJcANPbmWLTJ2LDIMIy3RgKSG+9FYgr3+krOyduC
	 wP3B3bAeV8jBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] media: qcom: camss: vfe: Fix VFE reset while another line is streaming
Date: Tue, 10 Nov 2026 22:49:46 -0500
Message-ID: <20261111034941.1012493-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034941.1012493-1-sashal@kernel.org>
References: <20261107054314-failed-6.1-e5d4b0e69a40@kernel.org>
 <20261111034941.1012493-1-sashal@kernel.org>
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
index e333e4463433b..096a284c6bfc2 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -407,7 +407,7 @@ int vfe_put_output(struct vfe_line *line)
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
@@ -419,8 +419,6 @@ static int vfe_disable_output(struct vfe_line *line)
 		vfe->ops->vfe_wm_stop(vfe, output->wm_idx[i]);
 	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return vfe_reset(vfe);
 }
 
 /*
@@ -432,21 +430,19 @@ static int vfe_disable_output(struct vfe_line *line)
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

