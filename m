Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368685;
	b=leprqRWLh46CDP9pkPLIkTcCOiJ8t1h8Y6ADZp/uXJyYSEKPcJt7H8gjUiZe6CmA2kLY
	 cMAsf2YLtKLWFto/hMdY/Ih+MKy1YBpcZ3kCBu53b02c0dYBqEN0u/zOF750FJt0iZrVZ
	 v31RyAom6eKmZ0FVnLPVguyxSnJS9xMJxNq4SVPqW5/cvtxRwyoUCigrHeaJPEpJDWRkJ
	 AA98s3UUK+nXbwTOPOy5iIZvlakXbUys/R2mKMDMbbynAl4mvhDubN0rPUJZTTqUIIjB7
	 QZ7qyDw2Jb0+y+CM3uMZs35FQEAIOUNcGSLFtuXE/2EZAPebOyaGJ4TeDGoE5U7DRbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KejB8p1CjeOEKnMuvka7Q/QkWOCkXxMKkTGxxu4Ihmc=;
	b=LwnS3v/DOj0+X1qhWvW8XEeBRTTf1UOybKU8R5dNzpzyzQ2bAuPlnsZsMubnkEI6hcyh
	 rbYyomAzHg+YMFj8d/REj8j1RPmjE7A8CN/UQ3coNzrGAOXNG0FMq9RTVRlBLF/zVokdD
	 /RKhC+jYMM4vEeBaQapP4g3dNsAsLc88oBDyL/k60UYQmxZKhxfiSDDLglFvEUHBnhhlJ
	 EAC/1yCDWp4aNs7WJOb4q/4QwziCai1VnKzmJGtzVStgUJvx3gu0GHw6CrPjNGhdOdGH6
	 YFA10tPtH499Q+9yDVe7Dmo48PC7n1u1cCxcd6F3lysngdbRVA8mpjtXun0Xr3CS4Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RZ/cjqsN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133A606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ/cjqsN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8923E1F0089F;
	Wed, 11 Nov 2026 03:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368685;
	bh=KejB8p1CjeOEKnMuvka7Q/QkWOCkXxMKkTGxxu4Ihmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RZ/cjqsN44sI1qWT0bFCFTwqsBn7NM654XTlIcRMifmtXytYnR1vnL9q/T11saxcg
	 XkPLG0OpyrAMBx1UOa+o8+5OWJ5l+eSvzpjkUDKm9ktDL1sSf9TWr3g2YvOzwdv2Fe
	 Pf8luewjPQG7zGzgkZ5p5BLls61H2Thcwq7eNKgmcX0EW/BwYhHID703glCUJyWC69
	 51y4bfotBfDyyE4LlTaK4+sDoX/Mjvvgha0zgfjjqbYHDjViVS5gOsSzzEM9iMF4XD
	 kjUuGmsYqK0XGcgilrJ6sfeDjKrudFfvEiFYeiHvssZ0I0uDoJrhJRE2x54A6E5Csb
	 jOVE9GVN/r8sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] media: qcom: camss: vfe: Fix VFE reset while another line is streaming
Date: Tue, 10 Nov 2026 22:44:41 -0500
Message-ID: <20261111034413.979341-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034413.979341-1-sashal@kernel.org>
References: <20261107053039-failed-6.6-e5d4b0e69a40@kernel.org>
 <20261111034413.979341-1-sashal@kernel.org>
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
index f4a4f0fda45db..10095818cfb23 100644
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

