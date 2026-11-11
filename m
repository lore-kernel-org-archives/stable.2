Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405945;
	b=KiBnWYDDF9kGtTbb2K/PrEhoIsj0IkqGxMr8syxIX6pW9amT9+9vOyqlmB539Ib7C3+4
	 Ln1NMwUfcRnQDYxRYRlSmKr1nnT88ihU1i6VrT2HRGuw40pFnMEmQDZ7n3Jg3Us4CJRwI
	 kgc+c+nP90ECDaP+O+lK842jfsQA+I4ibTTLrWP2ZiCxszfn5VneSMbSf1jhmZJ0DfJ70
	 axXYqQWxtA8FOk/unFAs2XUGMpSDEbcwmClZiGXhVO/3f4EHiP9kPV1wuRdqXWBzvvNLI
	 xvJiE7HBxAFyNd3pkEklE+97/6f9SszgY95nMt24SXFWsmFl66Spn2QDZJAy/cMHgWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=McRsNz+WYcmLvFXMRI0J2aVidR8pKhBUBuHbf9NY1mU=;
	b=tYGhVujBkkhhBj9pAtZ9NAtepCpBDdBrG40S7/7ibxpaxneg1DoDmXyQvT7QsWsWaAl6
	 WIIhWB837agHUlXamI5SfVjaLwEJ3XPQ5aHGp8e03X9bRVyqz5hBrWru6KCysBGvkN/ok
	 zmNmAvsq0XXTTwoJvDmRT48eNZ9ZeXypvEgZ9GClFClrungEbjJbGRdivmUJ2+c98sX42
	 owNA2Q+JmAHCLK+k08tD9RkRLQNfRG5mZ1Dr68gTCgOF1KEdVxf6wlM2i3bOhpKiksaqi
	 j+9jF2R8srzsfl5go+z95fDU+DvhwT9nWNd0XrJiRmkDa/xEFZsj5mzAZ57Wam1azrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LULTAo60;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F700606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LULTAo60
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57EE1F00A06;
	Wed, 11 Nov 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405945;
	bh=McRsNz+WYcmLvFXMRI0J2aVidR8pKhBUBuHbf9NY1mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LULTAo60ltyg96js7Ku7Kiq69R+1BlLavUN5jJuZq8Pgl14mZ265DwnixTpyyC1NK
	 KjZqZXeiUHf4jJXGaf3NJ9wcBv4i8fGZbKUlroV5mXkZVOzyFLSEQSSONQdJAD7E54
	 zIwL/QUyxBlzVpUpnhTkZQHSKbBuu6a46wn41ampl/0mNeknHkKjpSgE3RsG4gdyiR
	 OeNalo4gEyP/znzmsN2q2M3TgnE1vMN4IwaN07FJ/3S/MzTO+ib87nab1+hVe8MhEN
	 FF/dJcz0zBz1/D+dtRruDMemQLaCYxzjYePXiL4+D9q1jLaLtQnx8nRbJS7qDxa7UB
	 QXu/5p3amScEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: qcom: camss: vfe-17x: Fix write master selection for RDI lines
Date: Wed, 11 Nov 2026 09:05:41 -0500
Message-ID: <20261111140451.2175302-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111140451.2175302-1-sashal@kernel.org>
References: <20261107051808-failed-6.12-fc02156a3efb@kernel.org>
 <20261111140451.2175302-1-sashal@kernel.org>
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

[ Upstream commit fc02156a3efb747b724a490cc50e1ad8c28a3b23 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

