Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048198;
	b=HqEp2PoVuaNw7fd2RR87uOJrctOgaFuPiwJTqZjKWVmI7Oh53iroIpSvhWuIg4pv4iq9
	 hGqV7Ixb5/LMl6XgBDVnfm7gmdDeENpT5qyfd5xnkQ6XII84dzTAuv/kruL4FRnB4M6JL
	 DzPrYdkwd08Axfj+KzwvVMAQSlYSMZpyWgn4qmcuXrxGx/XTYD6G/3adDEnLf6UX5RU/r
	 Y/O4ZnnJ7H09SY4AiqGItBnzX+tZu+q/AikfZ+OWzSXm5224GmnBtqE2QkuYTA5Q+igfC
	 ogbRA3wuA2+AmgvO0YSivhefK9YXsZJyZqAf/VE2vmqNmajMs7MWwk92QanFphXpVaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vUOJwPLiF1C08mKEoyAAuWLpdK54HkkqURo/ssn5v2g=;
	b=ZxHURkRkNHrwqSuWeacAZzXnUuNetmxcH/RUc9qKWtXeAJ/PqQZkpEJfE1lB4ZFI8ZiV
	 QWdd5MqBDM0TFD0AJ8FkXOz0zUkBlhk7ApNUGPlITXa483AdPv54ubFl7Sdju+VDmg3cO
	 X47+fpw3Eva4PyFf2cr3+XiG1/s3N34q7dvSXHrZ6ZQIF119K0lnuqnQX75WgSHGkL6ia
	 6fxqqP1i28G0/MLv7139oAtuPaXY9aEdIrAj9yAXmBu0vI8r36+1MGQmcjiCFZ4m8Xw1/
	 yDdDo8Kqwg6Xmaw0ZxDithv0iRd5QZBFBXc98WpEU5nypzstMzG6PXXPlVMyh9q9swA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDoxgoOB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDoxgoOB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2111F0089F;
	Sat,  7 Nov 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048198;
	bh=vUOJwPLiF1C08mKEoyAAuWLpdK54HkkqURo/ssn5v2g=;
	h=From:To:Cc:Subject:Date;
	b=kDoxgoOBOfpeWEwhek1i1QkpVDA0TAQAQCeJWDHqGcO0OQS0k+zfhrFMe5fuYK+nH
	 Lj7sAB8b5t6tmgxamdrDW8XKMGgwGSrk9Vjq+zNBkjfXf0TwfQaKD0BggjD+uvwB1M
	 b51a6e5r40fF2q3pLZrTGgeCErEWRlkkIWqxlQYvA3cNfeUmClgtb283PKFoDdOPk7
	 uqJPNflsk7oWvGkst0IOzrS7GnBeKYIOrra3YFxrcl2UGgv804L1lw0MMnYqD0/Vo0
	 DmYCX8z3rQd7ZlVufpIOvVSrUNqgsaivgOGa3sWXkCH8hydm9LUHTrLt1CMJ9Dsfio
	 zx68pgKl/au6A==
From: Sasha Levin <sashal@kernel.org>
To: hitesh@ebytelogic.com,
	bryan.odonoghue@linaro.org,
	loic.poulain@oss.qualcomm.com,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: qcom: camss: vfe-17x: Fix write master selection for RDI lines" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:16 -0500
Message-ID: <20261107054316-failed-6.1-fc02156a3efb@kernel.org>
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
git cherry-pick -x fc02156a3efb747b724a490cc50e1ad8c28a3b23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054316-failed-6.1-fc02156a3efb@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fc02156a3efb747b724a490cc50e1ad8c28a3b23 Mon Sep 17 00:00:00 2001
From: Hitesh Patel <hitesh@ebytelogic.com>
Date: Mon, 28 Sep 2026 17:45:04 +0530
Subject: [PATCH] media: qcom: camss: vfe-17x: Fix write master selection for
 RDI lines

On the gen2 VFE bus there is no crossbar between the RDI paths and
the bus write masters: RDI n is served by write master n. The common
vfe_get_output_v2() reflects this by mapping line->id to write master
line->id, and every gen2 VFE except 17x uses it.

The 17x code kept its own vfe_get_output(), which reserves whichever
write master is free first. That happens to be the right one as long
as a single line streams and it is RDI0. As soon as two lines of the
same VFE stream, for instance two virtual channels demultiplexed by
the CSID to RDI0 and RDI1, the second line to start is given the
write master of the other RDI. Both write masters are then programmed
with the buffer address and frame size of the wrong line. The frames
are truncated to the smaller of the two buffers and the SMMU faults
on the larger one.

Use vfe_get_output_v2() on 17x like the other gen2 VFEs and drop the
duplicate. This also removes an error path that released
output->wm_idx[0] before it had been assigned.

The gen1 VFEs are not affected: they have a bus crossbar and any write
master can serve any line, so vfe_reserve_wm() is correct there.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
---
 .../media/platform/qcom/camss/camss-vfe-17x.c | 41 +------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-17x.c b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
index c011f64f63e93..62c2405359a06 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-17x.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
@@ -382,45 +382,6 @@ static int vfe_halt(struct vfe_device *vfe)
 	return 0;
 }
 
-static int vfe_get_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output;
-	unsigned long flags;
-	int wm_idx;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	output = &line->output;
-	if (output->state > VFE_OUTPUT_RESERVED) {
-		dev_err(vfe->camss->dev, "Output is running\n");
-		goto error;
-	}
-
-	output->wm_num = 1;
-
-	wm_idx = vfe_reserve_wm(vfe, line->id);
-	if (wm_idx < 0) {
-		dev_err(vfe->camss->dev, "Can not reserve wm\n");
-		goto error_get_wm;
-	}
-	output->wm_idx[0] = wm_idx;
-
-	output->drop_update_idx = 0;
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return 0;
-
-error_get_wm:
-	vfe_release_wm(vfe, output->wm_idx[0]);
-	output->state = VFE_OUTPUT_OFF;
-error:
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return -EINVAL;
-}
-
 /*
  * vfe_enable - Enable streaming on VFE line
  * @line: VFE line
@@ -441,7 +402,7 @@ static int vfe_enable(struct vfe_line *line)
 
 	mutex_unlock(&vfe->stream_lock);
 
-	ret = vfe_get_output(line);
+	ret = vfe_get_output_v2(line);
 	if (ret < 0)
 		goto error_get_output;
 
-- 
2.53.0




