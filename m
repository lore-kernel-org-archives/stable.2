Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F07477E21
	for <Stable@vger.kernel.org>; Tue, 16 Jun 2026 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629386; cv=none; b=njPuN124fyuY8egxBGUXKMlYXzKJEUoUQciZFbYvGwTI6lrq1JI+awFq62vMzvIT7tUsLZmBqbXK/6kxiqSCUHDPRp5bwHBr+AvY2PTW5OQAFplStjsnH+dS4Dp3BrMI9/jGrLJsrbVnrewys4zkl8cDEFpxCi25MieDDMq8no4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629386; c=relaxed/simple;
	bh=lLxvdHCAPpQZp6pnlDmDv20UFFdnnMDjt/ZuR81XGvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iud4oWPfyrkExWoIZMZrGOAJD9M1DcLFxWJER0PGgLEeJl3YYkinEd+/ktgLDk9Z6TZzefBeNFu7sRQJ5zWRfQ27CxXXHljoJdyshjos2IBoqJIBWPjOceHiORp0YOEDC7kWRi7TUEj6VwHJyR+JuyabYCj2Jzo+hAjUg1jKbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hX1Jd+R5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qk/Sn8/+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hX1Jd+R5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qk/Sn8/+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFcio32169990
	for <Stable@vger.kernel.org>; Tue, 16 Jun 2026 17:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tqkhb6/HtxqIF1Por0FEpscFxhtJwz/EzUn
	01w0gJKE=; b=hX1Jd+R5M7aATIDNo799S+JfrEXg0FLn4Y28Qv/xWHwm8TauawI
	5G7SQ3qsafwuTiM41xKq01doa9Ge/mWvL83Idut1g5fUzgFdAC+b9U6mwpm/UIdG
	H+l2gbVs01XILvy1trVNSA5X7MNZfroE7dkom7jIoS57MGtJ8bFv3AZbaiPncBfK
	40V+khDciizBwclUqur/vCjAbyZNhYcOVMdTBYq2ck1B1ShyAXddQOyiqNdyZpl/
	d7PenKzkZquu/5aOyCxbFpkhSHha04ZkyeF+EhkNYqTiQaK+MlJOWDGhmeyI4Tnc
	mVDr2dJCJSGMtTaFRSrHF9ozg9R4bsvQl8Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu3ct274s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Tue, 16 Jun 2026 17:03:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85dc345ac8so2689664a12.1
        for <Stable@vger.kernel.org>; Tue, 16 Jun 2026 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781629383; x=1782234183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqkhb6/HtxqIF1Por0FEpscFxhtJwz/EzUn01w0gJKE=;
        b=Qk/Sn8/+Mjw3vFTeiuOOMpQBacvqJrByzFGklbJ9LOzaIa0jcV7sA+LJb2KPGyo1go
         I05igR53LYO8p+mcw8i8Ghmo8fUDV2QIxKe/QuK10kN8S5JyZCfbD5oEOQ+U4hwIoptk
         RuS2iSfhnGCofMaHoLSutys1eevP7c54B3KRDXqzNOR6+mJFzmzquFYbyhzuTuASOjya
         u+Nj4YJP0qX+MLTLR9OknjViFz6RTQh88Tnv+46Z1ltKLj3JhYaxOemWRxqalJuh+kAG
         Wlc0PKqE+ZoLZ9SJsMUWaunLvS2wWhvG2uFp1N5LMBhGit5QsHouabBNCLXV4tPUgOzO
         8YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629383; x=1782234183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqkhb6/HtxqIF1Por0FEpscFxhtJwz/EzUn01w0gJKE=;
        b=GhzZZ6reR6gvVw+MOu54s9VQWSSeTnBsl5dlQ9u98fWYaUYB2bk2FbYEl1GPCmFcJY
         MLszwdWmQB4BcO4Tn65HIJyQIvZueOyMWVirlCfxekzVjTQjuw8lfG++xg4aYQM/YNmZ
         TDynTy+z8TsnEqD6SJAL6FNu6NtmPTgMvgYwpr8oJ65/XvVf335/3S3sl7A1HcGVDlsS
         7HDkSR4wM1GA82emLKmcR2dfwIk7djPPa2M888/sGWHjttoO4tP0KJ/CePAhFj1Amcla
         rbqWjl9vA8z1YQyjK0fDcfAiSUTi5L78Lfclnvfkuf4cW8PK35BbbKVY7GZ6G7GKi5tr
         hscg==
X-Forwarded-Encrypted: i=1; AFNElJ+b/HX1iZWI5USijyt/smIxHDUmpRe4E+4GDYugdUeK36bScbzWkiKvhbQ22sn4CT1J+obceEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6rgEB8vlqRiVTkvdmgvCSM7MiLBQIgQDMDXFxuMDO2t2m7j8
	Yis3k7mvCqerZYCvM2wBvTVrZz9grrPAhYyHiR/x6DhLJ2wBskJ7dXMtM0d0SLjowjSLAo3qgm/
	r1Lkm0KBdyN1/Bgi4XoANXgkv06MZQvWVa/if5NX1Z1x+V9hEcIOHJdIMAz4=
X-Gm-Gg: Acq92OGJX6WMvtk/xi+/CjlEB2Q0CxPP3HcNPlwHiottjBndntZD8R2fa9mw1CiBTtc
	yzhyww3PEeRIKbNLrJU56FJ5bi1ND+5r7+HZfV8UFL/jPciHILRYHeAKF5zOqPxuelumsh2pU4F
	G7eJ1c2BDvIDa8KtvXlYlR5IgkkVY+BCQ/qW7XtoLkAtm6SoGzePR7uft3XSofqgVcuz40QjWt7
	THnN+xPN2ZUExTk8ec5xPrqJPQlV72r3a+27Rivx8s86Z9O53heWRdBipJowmh3UyiZ6gqzjYO7
	hRvc/hnByAk+le3rMQcZaypT0Tdoxc2qkua6lDLwGkGz4FaMIEvUFXxTd32mlNkIarMEFF0aZvL
	yrKq9ot37TF6XIuG7nFO5/P7sHImhjD6AVgY=
X-Received: by 2002:a05:6a21:3086:b0:3b4:85db:1bd0 with SMTP id adf61e73a8af0-3b8b603267dmr215801637.12.1781629382722;
        Tue, 16 Jun 2026 10:03:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:3086:b0:3b4:85db:1bd0 with SMTP id adf61e73a8af0-3b8b603267dmr215723637.12.1781629382056;
        Tue, 16 Jun 2026 10:03:02 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a458f2sm75542575e9.3.2026.06.16.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:03:01 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, krzysztof.kozlowski@oss.qualcomm.com,
        andersson@kernel.org, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Val Packett <val@packett.cool>
Subject: [PATCH] ASoC: qcom: q6apm: fix NULL pointer dereference in graph_callback
Date: Tue, 16 Jun 2026 18:02:57 +0100
Message-ID: <20260616170257.9381-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a3181c7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MGBxgCYFQN7ghPknZEEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: _PiJEP2VFBG5XU0DWLfMchkQYqrrBEeW
X-Proofpoint-ORIG-GUID: _PiJEP2VFBG5XU0DWLfMchkQYqrrBEeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3NCBTYWx0ZWRfX7ri9vdB3gKL4
 TPt1MSowQwirpeXqxp/v60ZykFnT36eaoxfbVVNBzTUfq/S3EZ6ePAnwej/ppNEZaPtdONk5sEt
 KAJhtP2UwTZUPZ6T9H+8sLE+8gPLnqGyTyyaphSR5DNEz13iz+g5dXLiwePbUQCT8m0kFzMFWJu
 y+UHgxxCHC9/9GRYc9aipeEgWANy0NeYp82/tUvo8jPio5Jt44qDRhPoAVuzVfwX3U7e7ZOQpIf
 zaByOvBd0M11A4DwLM2kB/AJzBmu4f8UMHM1oG4NirSIzpRB0gMg5+5Gs+2+h2PmQ2PiHvAzcbL
 OrLKhGKiasAMQ1VxinMAlT+hIeHdY3obi669vQLFeDWoChKkLnjxRPDUbXmEK5ftBgpTXy47KLa
 E9PiIHNsU1CYpjg3zJ16qgxmkfiP/qFa5fb78VdugdrXF6K4RjepgWAg/2kn2WyQpZeSW310cVj
 tJITCQeVJdBt49Hv+Sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3NCBTYWx0ZWRfX/uvSxeqp67ka
 ZRlpW3W1s63KOPwYXAyzQoY6vW3DUYtvrhAQ1QP2cnKREawU1imiL2STCgNlJl02/Jfl24W6rFR
 lCmwLunJlG0uehCK832jaFDK5QGdKac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160174

When q6apm_free_fragments() is called it frees rx_data.buf/tx_data.buf
and sets them to NULL under graph->lock. A late DSP buffer-done response
can race with this: graph_callback() passes the !graph->ar_graph guard
(not yet NULL), acquires the lock, but then dereferences a now-NULL buf
pointer to read buf[token].phys, crashing at virtual address 0x10.

Add a NULL check for buf inside the mutex-protected section in both the
write-done (DATA_CMD_RSP_WR_SH_MEM_EP_DATA_BUFFER_DONE_V2) and
read-done (DATA_CMD_RSP_RD_SH_MEM_EP_DATA_BUFFER_V2) handlers and bail
out cleanly if buffers have already been freed.

This problem is only shown up recently while apr bus was updated to
process the commands per service rather from single global queue.

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Cc: Stable@vger.kernel.org
Assisted-by: Claude:claude-4-6-sonnet
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/all/133ced18-1aa9-475d-80d8-6120678bdde4@packett.cool/
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 2ab378fb5032..2873e831a8de 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -549,6 +549,10 @@ static int graph_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 		token = hdr->token & APM_WRITE_TOKEN_MASK;
 
 		done = data->payload;
+		if (!graph->rx_data.buf) {
+			mutex_unlock(&graph->lock);
+			break;
+		}
 		phys = graph->rx_data.buf[token].phys;
 		mutex_unlock(&graph->lock);
 		/* token numbering starts at 0 */
@@ -571,6 +575,10 @@ static int graph_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 		client_event = APM_CLIENT_EVENT_DATA_READ_DONE;
 		mutex_lock(&graph->lock);
 		rd_done = data->payload;
+		if (!graph->tx_data.buf) {
+			mutex_unlock(&graph->lock);
+			break;
+		}
 		phys = graph->tx_data.buf[hdr->token].phys;
 		mutex_unlock(&graph->lock);
 		/* token numbering starts at 0 */
-- 
2.53.0

