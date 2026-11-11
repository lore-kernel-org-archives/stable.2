Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407601;
	b=SNWH4q/T0JFEAFeWmW70Wu6lcHfp7kApY/KVWd+N0aLpHzW13KutfL8kledZ4lRDzTnL
	 HOWuHPgHrQ3BAP+BRrm5+foFWb5d+QDZWQjb4tjxNn1caswtCCoEjqPAxui0TluTlQmWb
	 QfDrGGlX+ymL/FEq0oxuvsPv+KjxsKHfs1y2+ktfEzOrGCSwT+38D8UnN+K2apo6NnO1R
	 BGWtw2iVvAyGSSrLSDUs9LuBcLQQYKKkU5t/Cq9GjuDC2ZxhouDseIvCnWtHvqTjQm7Mc
	 1/34YxaPqq6p9gLpMQbbsC0y+QZXcAoN2M+87nj7a4BCxnF1mypx5G0MbKjV6VpVmpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S67q7YxllaAfcpPmv6wQJFodSuaWqCwC04iEm9t5YgQ=;
	b=uk2xfkEeYXvUVi/xb+J3U0E7RdHd5weXa0hvYN57/5v1idZ1fhIBszEsntPao313Dleh
	 UxXPTCtzf6Dyc244DaD+VwGFDd1iKbbc5r7zjJiP67dEtAD/aBm9xRZoy2k2qWWb01Jke
	 hwhYsEvleIgi2brvo/JTypWmp/zAFbsGoTboOFrCq2ZgYRDEboRpOXDc+QQr5r+O079+H
	 JCbXcAXG37edoJVMSCOa0WaGrgSwrVyHC896SAO4jyR0qtFCP+UUcW7k9hLvXdHMMLD8O
	 APMyqQ1fSiCVNxOySnS1jLEMLjj4hwGOJ6t+wMR3faSt7hubptr7xJrY/jTDImMFhsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9yepn9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D33606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9yepn9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847C01F00A05;
	Wed, 11 Nov 2026 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407601;
	bh=S67q7YxllaAfcpPmv6wQJFodSuaWqCwC04iEm9t5YgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9yepn9fyTD+gDB7pMMTQP2JrnxDpYbg4WtWMZ4v9uSu34X+7KWG2QDPX5bNqBsLH
	 E2jw5FLSSUP5VQ4Alu9rHk/19PZDBmxrk3vYoXx4NeI52HPV5svxgF9L6cnzP9jZx5
	 ApTeEEvQiL2Wa0lnEyb7HUrJ+eWmLh2jT5SUTPohbw3Bwm+hJfA3ko1r37HRFyB5qm
	 PdXkjRCY9kRkEH3im+b1+TosWSVMzrBsUf2SptdbVwkjvFTXqjH901fKd/REeDD5us
	 1Ezw0as46cXzzZ5RezqX7CdqU9xL7W7XXTOxSjkOOcBsGxcZGlMFw/RQ9cIKBVn2gJ
	 iaD1ZXfL+85Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: qcom: camss: vfe-17x: Fix write master selection for RDI lines
Date: Wed, 11 Nov 2026 09:33:19 -0500
Message-ID: <20261111143230.2328578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054316-failed-6.1-fc02156a3efb@kernel.org>
References: <20261107054316-failed-6.1-fc02156a3efb@kernel.org>
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
[ sashal: Adapted the change to the existing vfe_get_output() because the shared vfe_get_output_v2() helper is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index a6625aa050b66..cba90a556175c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -402,7 +402,6 @@ static int vfe_get_output(struct vfe_line *line)
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output;
 	unsigned long flags;
-	int wm_idx;
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 
@@ -414,12 +413,8 @@ static int vfe_get_output(struct vfe_line *line)
 
 	output->wm_num = 1;
 
-	wm_idx = vfe_reserve_wm(vfe, line->id);
-	if (wm_idx < 0) {
-		dev_err(vfe->camss->dev, "Can not reserve wm\n");
-		goto error_get_wm;
-	}
-	output->wm_idx[0] = wm_idx;
+	output->wm_idx[0] = line->id;
+	vfe->wm_output_map[line->id] = line->id;
 
 	output->drop_update_idx = 0;
 
@@ -427,9 +422,6 @@ static int vfe_get_output(struct vfe_line *line)
 
 	return 0;
 
-error_get_wm:
-	vfe_release_wm(vfe, output->wm_idx[0]);
-	output->state = VFE_OUTPUT_OFF;
 error:
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
-- 
2.53.0

