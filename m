Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638056;
	b=lZPMKMmb5gAS7WEgHQPbnzTib+HHHVU9yKexSXAH3yc6ZYEpYpZzCLGGu748ciL6yFOU
	 L9QZQ0+jtRl7iLdvffEUVC5+cuE8dHV0Ks9IAnc3BoBbyz6Fbm03UqKdn7hcLU21CcXiR
	 6sgf3lg7NguKlKQB9bFzR0TteUXKC3TdcctxSrsa5glGC1wqb89JHQxre+/WbNSAuERF4
	 V5gIoggkwhbkVPhgBvS2lt2OxH5TWHcrO9ex5c/nK1CYhCJb3nh/fp1l9TdQ1wA/C7j8r
	 DC9LGnhqimCWVwQwJaR7WU6gSd0Z9Fy7gl5pAVWH8HyJoF6mfbtz/52T1oZlzCPlshQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YYPL1H23dOWiGPUMlPHbPULy1LLLRefcFIcoTKwBa8Y=;
	b=xrVuqta98t5r8eErtraEZ5c3NZjCMQpgHQFpmzZ6a0OtyijGtAsfW+pxqcJ2rYjmlveW
	 KsHwMxFTOe9/X4XjN4V3F9c+cPJsDo2OZ0Oq9oNE/ZTX7N85oVHXA6QtH1k4kYn/4ztNn
	 tpAlud57uceLPhUwsQuGdBq0SRaLVQGNU1G+iVNjdb6dw7BO+M3I3zReKE1TWDm8tVo6o
	 ETxqB5GWBXRG5E4TphBp5/vAbaL5c509dHXxf00lCoceKRmpotm2e9xXw/Y0H+Q67i+hN
	 PYcMyDk0+188GfbtbIl9g7FWINyxEpYdSmniWrRoYdk5vPoFbUOjY+UuS6E1jrUQ0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdazkZ+e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76B606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdazkZ+e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE701F000C7;
	Sat, 14 Nov 2026 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794638056;
	bh=YYPL1H23dOWiGPUMlPHbPULy1LLLRefcFIcoTKwBa8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdazkZ+ewoOOwA5jrU/dMb8dDJ+OK6M9UHcAk6gLXUJgofnja+IroWcPMeNHU6EoE
	 lJGY36pIorxYjVliG5hi8SNxEXHMMId95RT/bWsCE80hXI9EXHTgmm+CdFVzb/Q1KK
	 przt2EleVWkjAnpNHCeBJd41DOz53oW2EQOyKr5NCcvrTcUM2s1IG6bs8KGgWCwlEB
	 qQ/0QYsH58F7JT0eqgzwTQshhi8+3bSvQpPCxRloDowX74UI4aXNcpc3b5w9HBK9Na
	 dweX8dGe4v2DNPlQK9BX1jI0CmHiQhFhYxYOIulid1S45pkb8FTm2Cj19JOazpF6Q4
	 I3wK9etlzrVPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohit Sharma <mohit.sharma@oss.qualcomm.com>,
	Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ASoC: qcom: q6apm: Guard callbacks until probe data is ready
Date: Sat, 14 Nov 2026 01:34:13 -0500
Message-ID: <20261114063359.3219746-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114063359.3219746-1-sashal@kernel.org>
References: <20261109201639-failed-6.1-ef7062864c05@kernel.org>
 <20261114063359.3219746-1-sashal@kernel.org>
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

From: Mohit Sharma <mohit.sharma@oss.qualcomm.com>

[ Upstream commit ef7062864c0511bba52775d0eb3aa72d886b5f3a ]

The GPR bus needs to make response callbacks available before invoking a
client probe because clients can issue synchronous commands from probe.
This creates a short interval where a callback can run before the client
has published its private data.

Make q6apm publish its driver data only after all callback-visible state
has been initialized. Have the q6apm and q6prm callbacks ignore packets
received before driver data is available.

Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
Cc: stable@vger.kernel.org
Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
Link: https://patch.msgid.link/20261022144130.2443667-2-mohit.sharma@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 6 ++++--
 sound/soc/qcom/qdsp6/q6prm.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 4f9143b903b31..8529381139865 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -757,8 +757,6 @@ static int apm_probe(gpr_device_t *gdev)
 	if (!apm)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, apm);
-
 	mutex_init(&apm->lock);
 	apm->dev = dev;
 	apm->gdev = gdev;
@@ -771,6 +769,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 	idr_init(&apm->modules_idr);
 
+	dev_set_drvdata(dev, apm);
 	g_apm = apm;
 
 	q6apm_get_apm_state(apm);
@@ -811,6 +810,9 @@ static int apm_callback(struct gpr_resp_pkt *data, void *priv, int op)
 	struct gpr_ibasic_rsp_result_t *result;
 	struct gpr_hdr *hdr = &data->hdr;
 
+	if (!apm)
+		return 0;
+
 	result = data->payload;
 
 	switch (hdr->opcode) {
diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index e3b8ddeb769eb..16504683ed725 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -197,6 +197,9 @@ static int prm_callback(struct gpr_resp_pkt *data, void *priv, int op)
 	struct gpr_ibasic_rsp_result_t *result;
 	struct gpr_hdr *hdr = &data->hdr;
 
+	if (!prm)
+		return 0;
+
 	switch (hdr->opcode) {
 	case PRM_CMD_RSP_REQUEST_HW_RSC:
 	case PRM_CMD_RSP_RELEASE_HW_RSC:
-- 
2.53.0

