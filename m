Received: from mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2B3AAF44
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792132570; cv=none; b=bYKiJlYPgnMeHBiD+OCdjwmt6V+FyrKnsn0AoiIEmzdRLga79ZfvxMJGJJc76p5KZ1KKCd6W9G4JQJFQemL24lA8pFGvQycyNLXlB0Qal5BuawPMAgxJcMSIvd5EaPwU+n9RdDfbRUaHJCmxb2oSQz7QQHfJJDtpXwy+WqsgaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792132570; c=relaxed/simple;
	bh=FMULLhup5HxbZ62tpmVqhAwf9hbLzat0PudWDGHNiYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feC4OOhvBmH5OV9pYzYzs8vEfODHE7+I6K6cJOvEDIcTVjnDWa4QH15RmzVmOTyuwexnNpU3VnLGDr119ufBWUzaD6PcJZRPU6idRXvCgDdtu8rDxRCKmcxBbKYEAXvCBUpfQHjuZxsVmOWgma9HoxLjvGMiK07GhaNTzz/JmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=CvbPcpll; arc=none smtp.client-ip=91.218.175.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="CvbPcpll"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FMULLhup5HxbZ62tpmVqhAwf9hbLzat0PudWDGHNiYM=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792132562; v=1; x=1792737362;
 b=CvbPcpllizDVQslEA8T8vTrQgs8cllH0v/IsNZ0nz7+28DKWetcktDjvZtlNTL3hOkjBZ2q0
 cnrCAZ+6VUVL3FWAfimw0k+klqf77g8BIDI4FKrgFONSl/bWgYwJ2TXxLhbfFsiWq/5nTzPfA+N
 NieSNcYTtmZWELvcbrR1Y8ORl/eAzJmE/o4WAnYIlSQAZW5d/YNnUFWg+2m5RZgvZNjbAGBLluJ
 /mihl4GMVLTElxq1px7Ktd6JSGl4izmcwFrnrCxR959rlHfLcP/jCW61J6qqjcxFcUDXQU3NLXL
 /joC4Y0TaOMT9cuUcieStnsctKhtI/bKIJMmitZxdpL3g==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a73d9cd8a502dbf2;
	Fri, 16 Oct 2026 06:36:02 +0000
X-Mizu-Trace-ID: a73d9cd8a502dbf2
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Val Packett <val@packett.cool>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Bhushan Shah <bhushan.shah@machinesoul.in>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Antoine Bernard <zalnir@proton.me>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2] ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch
Date: Fri, 16 Oct 2026 03:29:17 -0300
Message-ID: <20261016063536.598610-1-val@packett.cool>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The response sent by the firmware when requesting a clock vote (opcode
AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST) does not actually have
the same opcode + status payload as APR_BASIC_RSP_RESULT. Rather, it
returns one single u32 which is the client_handle that must be used in
future unvote requests for the same clock.

As a result of this type confusion, the status returned by the callback
to q6afe_vote_lpass_core_hw was actually an out-of-bounds read. It was
only interpreted as success (0) most of the time due to luck, but there
are some reports of random errors such as:

[   20.961100] qcom-q6afe aprsvc:service:4:4: AFE failed to vote (3)
[   20.961131] Failed to prepare clk 'core': -110

Fix by correctly interpreting the response as a single u32, and actually
store it as the client_handle to ensure unvote would work correctly.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/5976946.DvuYhMxLoT@antlia/
Fixes: 55e07531d922 ("ASoC: q6dsp: q6afe: add lpass hw voting support")
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Val Packett <val@packett.cool>
---

Previously part of a series:
https://lore.kernel.org/all/20260506204142.659778-2-val@packett.cool/

but it's actually independent and reviewed, let's try again with just this..

Thanks,
~val

---
 sound/soc/qcom/qdsp6/q6afe.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index f0ff1350e9dd..9ac51c304ead 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -393,6 +393,7 @@ struct q6afe {
 	struct q6core_svc_api_info ainfo;
 	struct mutex lock;
 	struct aprv2_ibasic_rsp_result_t result;
+	uint32_t vote_result;
 	wait_queue_head_t wait;
 	struct list_head port_list;
 	spinlock_t port_list_lock;
@@ -1010,13 +1011,14 @@ static int q6afe_callback(struct apr_device *adev, const struct apr_resp_pkt *da
 	const struct aprv2_ibasic_rsp_result_t *res;
 	const struct apr_hdr *hdr = &data->hdr;
 	struct q6afe_port *port;
+	uint32_t *vote_res;
 
 	if (!data->payload_size)
 		return 0;
 
-	res = data->payload;
 	switch (hdr->opcode) {
 	case APR_BASIC_RSP_RESULT: {
+		res = data->payload;
 		if (res->status) {
 			dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
 				res->opcode, res->status);
@@ -1043,8 +1045,10 @@ static int q6afe_callback(struct apr_device *adev, const struct apr_resp_pkt *da
 	}
 		break;
 	case AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST:
+		vote_res = data->payload;
 		afe->result.opcode = hdr->opcode;
-		afe->result.status = res->status;
+		afe->result.status = 0;
+		afe->vote_result = *vote_res;
 		wake_up(&afe->wait);
 		break;
 	default:
@@ -1955,6 +1959,8 @@ int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 			       AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST);
 	if (ret)
 		dev_err(afe->dev, "AFE failed to vote (%d)\n", hw_block_id);
+	else
+		*client_handle = afe->vote_result;
 
 	return ret;
 }
-- 
2.55.0

