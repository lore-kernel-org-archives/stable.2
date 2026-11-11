Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407124;
	b=g8gqp0scGI/i/j+LQvM0I+iKIwfSECaJG+WyCuUQSXD7iUrrNbT/R+NZgd7C7U0LHe1Q
	 3yE7ciAGxcLmZLbqucrjEFITHgHZQNC1dXkDdkjDy51BgjTK8ftv8UVJvdoPazGJOi6YA
	 76bG1c+8ERiWehqtllTe6zohKG/JeZEDNQYmPysUGKyAQLvH4UeyJEbhcncG2IqpNuDy8
	 Fq7pdeCQC25Lx0SS0tZK5SynSvEz2NyPMttBOvUix4wlDpmHhkyZB3jUj8q/EgnBznpL7
	 46JN65VHOQ4ZufAujZdwwF/eDgD5VWa8Q06HG4NXKGIa3BOsv+Tjc5Om3KbCpqWx5Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407124;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7PvbwQrmnADsjCFAoszrj4+ka0FWXtUhEzRlBgpiTII=;
	b=dT2DMeU/Fce6YMo+VjwHDpyzslMlVsfXASEod+WMetTQwmwG2flH54YcXULSyAmsZZ4e
	 8T0vSWjoYGKRKsIlZ0nREbaaZoIqR4AE2yzU5HzbP0snUmyHYat5IxwqsRIKky7bmBsOH
	 wc8o2Nm6iBfvAuhRWJhTIYIAz3Kp0u6qEVqe9szW3mHq9wa3U+pA/fPHzQeT4fh8GAjUJ
	 Lm24x4qDeJfytCv/c1Ckp4VNeAjYHx8HrqUhzO57MzBpw+EaF0zLPF6rRs7FtaGq0FuT/
	 1rlXjusxY/YnwofZnnJZ5hyvjIFVKDSIRyktGXTTKgbAdvWziNuZFISt1tcyt14TI0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFLN8MAM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63941606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFLN8MAM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651C41F00A05;
	Wed, 11 Nov 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407124;
	bh=7PvbwQrmnADsjCFAoszrj4+ka0FWXtUhEzRlBgpiTII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFLN8MAMTOYVR3mqferzEEWlZZpRpb+foDUUigpUiw5eobJu7UJGrpI4k1j25+kfM
	 yuaPwcKF0S+ugbIAeLkwrj7g2zTRyvUlPxzD4uzGYlpufLywqd0YneAehY5SHq3o9O
	 zDm46uCU6X2CSAXD9sO7dKfqEkLwp1ZUElay2hXawvnIfKU0Pzc5ErGOS7bLdpAaS6
	 y1cdKVEC37m2BdkwjRHbuHKDRKKjNnZ+ChsoNU6eLyrh+iV1ZTzBxzxcukezK5C6Hn
	 dT9TIBgzPzD7DTOBB7OH0kdTFtYhvWOEa/w3geQPYW8jo7G4H2MzrOx0tBOw6Wj1hn
	 c6tktFQxe5mxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: qcom: camss: vfe-17x: Fix write master selection for RDI lines
Date: Wed, 11 Nov 2026 09:25:21 -0500
Message-ID: <20261111142324.2295266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053035-failed-6.6-fc02156a3efb@kernel.org>
References: <20261107053035-failed-6.6-fc02156a3efb@kernel.org>
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
[ sashal: applied the shared vfe_get_output_v2() implementation to the existing local vfe_get_output() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c   | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 8dd5ec9adea60..83f4322f23152 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -402,7 +402,6 @@ static int vfe_get_output(struct vfe_line *line)
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output;
 	unsigned long flags;
-	int wm_idx;
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 
@@ -414,12 +413,12 @@ static int vfe_get_output(struct vfe_line *line)
 
 	output->wm_num = 1;
 
-	wm_idx = vfe_reserve_wm(vfe, line->id);
-	if (wm_idx < 0) {
-		dev_err(vfe->camss->dev, "Can not reserve wm\n");
-		goto error_get_wm;
-	}
-	output->wm_idx[0] = wm_idx;
+	/* Correspondence between VFE line number and WM number.
+	 * line 0 -> RDI 0, line 1 -> RDI1, line 2 -> RDI2, line 3 -> PIX/RDI3
+	 * Note this 1:1 mapping will not work for PIX streams.
+	 */
+	output->wm_idx[0] = line->id;
+	vfe->wm_output_map[line->id] = line->id;
 
 	output->drop_update_idx = 0;
 
@@ -427,11 +426,9 @@ static int vfe_get_output(struct vfe_line *line)
 
 	return 0;
 
-error_get_wm:
-	vfe_release_wm(vfe, output->wm_idx[0]);
-	output->state = VFE_OUTPUT_OFF;
 error:
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
+	output->state = VFE_OUTPUT_OFF;
 
 	return -EINVAL;
 }
-- 
2.53.0

