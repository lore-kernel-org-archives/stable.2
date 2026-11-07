Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048196;
	b=KoG2dqW4jdy0RD/cRuEj0EEjsbqZKApatya6ToMpZMuZl0EjrychDa0/3oDYjbKAJuYk
	 rEPVqcsdBcqpd/5+7VTBNuh0DKtVb7r9nsehmJAVk/4w/t7mqZ50ARt8AyJqho4dgwhSv
	 pgBvSIJAr1sog2YppO9jy5gj0eBxkCAsEnHhZQbXTmds49HUgPHvmzhKKY7yZn+OVCJxc
	 w+hVPQutDaR7Vhgkp3gqlZgT+W8gncA/TxWg17Ryrp8byNfmwJ3/1gNCsyoxO/fTwROII
	 lsvqwRClzSTYAEfnafXP6P7+6p6o5oWpwwGFXzq/2TqNeIbElbZv7ig8pM8OwaxzNBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OA8dK19BIdB3a1I86Ts0sBY6MQjWoB0425zj0jKZZDk=;
	b=f6BqNWURrdsFs9OADwLPFBO0KYp/6WFkBBPJq77gwkDtjom696LBxXIVqG3eIhMvyxFR
	 gvcMzDKtn1qzYc1/XQR+smMD9jBwvd8aKuEO/Enklh7mzJPUkbtBO0rDlp9cA0SMdXAuN
	 RzNTa9HtvVVW9UjgnvXB57WOc3Vhl9CPR1EKOs7jOncrZftniNxnETCOvmY0xpwEHXN2Y
	 9vasY8JRuLSadcAK7LlQjQlF4wFgq953bcKFpyRXnL5ARCBCwKJdb9nazNw3n/FJwaE/E
	 ZF5vOlglx4YlUF3zh6NFTiCbWnWUQz0+2N7LK6m6HVmnOXWiTVM62d6nPhzzMrFxmTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4VB9XA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3974606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4VB9XA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA951F0089F;
	Sat,  7 Nov 2026 10:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048195;
	bh=OA8dK19BIdB3a1I86Ts0sBY6MQjWoB0425zj0jKZZDk=;
	h=From:To:Cc:Subject:Date;
	b=i4VB9XA7XH0Pnw1FGj3GB2rKHQDvIo8pAu9kghW8ElNvDR4DgRVzedBM7uKPWsruK
	 7BIb8P/kCYMW1DKSMzpuKQoXghzUA7DzFgmroMEphFtwplwgTXf1VyKz+C/vEsRivD
	 Tw9crc10Un8vt6rErAgsXjtz+++5tBbn0cthtz+ascuYIxkcXf6WUTutx39oGae0HI
	 uctNynzm5ruMT3d3svx7PMHokowpTdb+oEmQwOYaHnCAJI8MwKuWhTb4JnmQcBVVpP
	 nOl7S45x7LKBGGhTlpm8OVaODU6tnUQoNHslrsG2DLkct3CGim2tD2rK1F54JZJ3VS
	 49VAbSU6W4CeQ==
From: Sasha Levin <sashal@kernel.org>
To: hitesh@ebytelogic.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: qcom: camss: vfe: Fix VFE reset while another line is streaming" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:14 -0500
Message-ID: <20261107054314-failed-6.1-e5d4b0e69a40@kernel.org>
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
git cherry-pick -x e5d4b0e69a4017fd39354499c9d7583f625f0524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054314-failed-6.1-e5d4b0e69a40@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




