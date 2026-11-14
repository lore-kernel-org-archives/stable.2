Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638056;
	b=CEwp4gF6BsbvmUg/gVK45zTLJgqDiQdeL3SREagaR0oSPmavlOhzIedQXE/uiDsLOPNh
	 Kw4HrYAY1aFDqW6vxu3qsw13AFGPfn7zMyN62RnhMxxfe5zi7lItdexTXJRhWsZRei4dK
	 lI1txQueTLmIsbmZAtqyIePZWxShprz+NUKKmhpOwOWBu7OgpbVhrclkjesuQo/RRAik7
	 VOhwVrKdZXniam6F8tKis8ix9z7ULlDelDgdTOpBWH3fmh8rS4aM9DGVQufAoSsLeQXXe
	 R07ylbkMwDXA4skOO2Zrf2uQKE2J5QqpqTyjtwzMWrkbYIwtBvQJRJXqvLhJIRZyO1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yYFjPX/AydEjIAM7tQPCXC3O0Y7JQmvQGoyUfiB0NWc=;
	b=yLR8BkUUN4NK9ntr9rM0LFKU2j58FGwQhW663RnUltBZR/uq/Hf6SqWKOAyQSll1IKYU
	 lmlkOEvpVYQ2uvQTl41AI9BLkOhsVx//1eyGITU0cBvZvhYcHwNBvfngcfyxVO76EJZoJ
	 qfMdBK9ZskTgysajVQKYOQO2egUIxHIoFvc2nPy2z5vja8cH9WByErFMKb1AjGo0BB/kf
	 xzYSA0rYzhI3/H3YXYn9QPYaSoieOJ+t55KcNeNfMIuMLyXxXRFFZaZk812euvIa0WGJ2
	 B3HGMKN2KEO9GltB1Zq0K2cNDn8BdktMo8Ozshsxflz5lAuB38LMQW0wzyohQUIpNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ir1bZTHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D7606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ir1bZTHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8781F000C4;
	Sat, 14 Nov 2026 06:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794638055;
	bh=yYFjPX/AydEjIAM7tQPCXC3O0Y7JQmvQGoyUfiB0NWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ir1bZTHMT2HJtWOc4l+2CS+g9j6OYKMClZNFbKCJvDVHbSGxp4MNufMgUM/WDLwI+
	 kG6sI1rGJ2Scm8LeHxjVbhCw+YFDFqZ4bHlDeu8ZUXO3EWgU+zJX2aMblfG0sFI1Ig
	 NUw/UTAzkJ/ufw1+7m1rfEbW2Cl2zMhVF1Vlhd4pwjslee0GOX4GCxL51CBIPAMOsf
	 kcp+CbSD0zkrteVrNgtZEKwNTIL672DnUIN5hDoBWcWrwHqY1csuG8rV0LiCpgETPa
	 jgVeTjnpTXrNKvNrx06RT0LI7jsBF4wBBCh5chM+NgE9PPvburwnW3Zh5jbvcsqD8c
	 qhn4VduYKgRvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
	Ratna Deepthi Kudaravalli <rkudarav@qti.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ASoC: qdsp6: audioreach: Add ADSP ready check
Date: Sat, 14 Nov 2026 01:34:12 -0500
Message-ID: <20261114063359.3219746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201639-failed-6.1-ef7062864c05@kernel.org>
References: <20261109201639-failed-6.1-ef7062864c05@kernel.org>
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

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

[ Upstream commit 47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e ]

Check for SPF readiness in prm driver probe to avoid race conditions
during ADSP pil loading.
This patch is to avoid, sending requests to ADSP before it's
power domains are up and ready.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Ratna Deepthi Kudaravalli <rkudarav@qti.qualcomm.com>
Link: https://lore.kernel.org/r/1673508617-27410-1-git-send-email-quic_srivasam@quicinc.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: ef7062864c05 ("ASoC: qcom: q6apm: Guard callbacks until probe data is ready")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 13 +++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h |  2 ++
 sound/soc/qcom/qdsp6/q6prm.c |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 48488ba2be212..4f9143b903b31 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -27,6 +27,8 @@ struct apm_graph_mgmt_cmd {
 
 #define APM_GRAPH_MGMT_PSIZE(p, n) ALIGN(struct_size(p, sub_graph_id_list, n), 8)
 
+struct q6apm *g_apm;
+
 int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
 {
 	gpr_device_t *gdev = apm->gdev;
@@ -143,6 +145,15 @@ static void q6apm_put_audioreach_graph(struct kref *ref)
 	kfree(graph);
 }
 
+bool q6apm_is_adsp_ready(void)
+{
+	if (g_apm && g_apm->state)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(q6apm_is_adsp_ready);
+
 static int q6apm_get_apm_state(struct q6apm *apm)
 {
 	struct gpr_pkt *pkt;
@@ -760,6 +771,8 @@ static int apm_probe(gpr_device_t *gdev)
 
 	idr_init(&apm->modules_idr);
 
+	g_apm = apm;
+
 	q6apm_get_apm_state(apm);
 
 	ret = snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 54eadadf712cb..5b51e155282fd 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -149,4 +149,6 @@ bool q6apm_is_sub_graphs_connected(struct q6apm *apm, u32 src_sgid,
 				   u32 dst_sgid);
 int q6apm_graph_get_rx_shmem_module_iid(struct q6apm_graph *graph);
 
+bool q6apm_is_adsp_ready(void);
+
 #endif /* __APM_GRAPH_ */
diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index 41a29047ff010..e3b8ddeb769eb 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -12,6 +12,7 @@
 #include <linux/soc/qcom/apr.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include "q6apm.h"
 #include "q6prm.h"
 #include "audioreach.h"
 
@@ -226,6 +227,9 @@ static int prm_probe(gpr_device_t *gdev)
 	init_waitqueue_head(&cc->wait);
 	dev_set_drvdata(dev, cc);
 
+	if (!q6apm_is_adsp_ready())
+		return -EPROBE_DEFER;
+
 	return devm_of_platform_populate(dev);
 }
 
-- 
2.53.0

