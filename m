Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047442;
	b=WwfEML4OKDEl9qLlW0XNNKib2StHY4s5JRRRE58tTs6UOhwP7PdAAF3u2djT5rMA4BIc
	 K2zfFQF+TAJ1szOzU2xeBZQHybfCkYxUhEWcH7JV9gKBz6DNqWXQ+7p81Sl5UBSv6Z4Pb
	 P2ILa/R/Oj7i/FTClgfuTAlCZ1+C1e6aYagyMYt5Luz+Zi9fH1mqxr0O7z2NALkcdG6Ek
	 XcBs1nKSU7NIbG1Cx1n/MdUF08ng4vSo8htl1Gxt1OymN0ZEeWBJWpe+4JFgTQotWujYH
	 2GmirUV9KCRd/8plU/KN2IFgYs/dvLLf3xSrtml2n+VJ1iSDe1YKjRkPK08m1q5dVEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k8jLTDSFiX4fUUKd3MI0BpH+m9ccM5YWjDTuGcdS398=;
	b=DIdoeh0W8vFvrtiQRfwkkX46O89bQUSKT/SzH6uzECA+6FFXiKj82E59lDlGpusZeY0P
	 qv2GBabQkCft+Si62CiKTn8TUyHIoZmk8nJzwRclzgOvm4/s9Gtp5sbRqkFDTpHvGe6fo
	 wAbUynZqphm9g6y4Mq6nh/9FLbCbAjlnNe0AilYOITxpCtf3LWI6ArPT/GAkIiixNshrK
	 VkGSdPzVvmVskvSDxRGodBQn5Z+omQFm/f9AZtapjSduYm2vGVC2rWsk7zWgAEHL8bnqm
	 333l3IfDaZoHAKPWr9wW5BgWW5w9XBfHSJdaphA+8uzx0y/J1J84FGi5AP04Y9wuIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a4MP/PgN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4MP/PgN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DEB1F0089F;
	Sat,  7 Nov 2026 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047441;
	bh=k8jLTDSFiX4fUUKd3MI0BpH+m9ccM5YWjDTuGcdS398=;
	h=From:To:Cc:Subject:Date;
	b=a4MP/PgN5aSgaxCleR0mz69pXKwZezzg3IF20taEnh98DtLVoJVXfnwBl1r9vzCg3
	 /rDbQaQVd96HPIRAJUvGD0tHVmJdbW0lxuEDu9QsEMrsBJhKMkVuacKSkAE4w8n+8i
	 cpyivnjlB28lnJzoIt8pUiJWJY2qgd9zKUdYgm8sZ8EZyelPLA1FfKTgROJ1iIW0n7
	 q6awfWYfFPSbxmX9txFz3T/aLTvPd3bziHVWC5fB56yoWI8YWALlVCXR54UqccmqAS
	 iVOAJnRY1ZJadEv3C6lmmDV8hmDeDefiZJ9VDnKgSYzQRbBhmMl2wEBik1BOeSCLrj
	 bRgERtXnOQXzA==
From: Sasha Levin <sashal@kernel.org>
To: hitesh@ebytelogic.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: qcom: camss: vfe: Fix VFE reset while another line is streaming" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:40 -0500
Message-ID: <20261107053039-failed-6.6-e5d4b0e69a40@kernel.org>
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
git cherry-pick -x e5d4b0e69a4017fd39354499c9d7583f625f0524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053039-failed-6.6-e5d4b0e69a40@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




