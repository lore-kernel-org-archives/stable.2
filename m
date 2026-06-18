Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F4313E1D
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767005; cv=none; b=cD/hECbcQqASQFy1wPqEI+GH9YGfPyvv6wvrY2zdcqRIJ148T04gcGIx2d1/CgOij+maaak2SaGaYA3ti1VVqfzRwDyEgueuVuIZhGP4fuuUHgMCvtVXBczToJG9dcLvtTKSvAtBvH2cF/VL3KzKOTVqx4Zd9jmKYV5w5FpRkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767005; c=relaxed/simple;
	bh=hvOh8cEClaiB2vFMktW+2r7QZW93RLGLCpI2YW05JOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uwB36w6Rmj9CoWTq2CXKU+3fkoclyfxPHE1VJS2Z3spwf8/mXnc8KesZATJJk+Fb0EaenGdJrKacxEvfiQ7ALXOr15Xi2TxmtkMoeBlRlVbJgSc7oas/qdImncVGHtgfaWBBlG8isAgIcKIlPTyua05aOhZvBfYjRFnBdTIlrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lgfYkfVT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdnNpzEf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lgfYkfVT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdnNpzEf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I73TAB1063052
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ShDllGPAIl7Vq+gPkwo0Da
	oUO1L9IDh4ObT/0q4ua4w=; b=lgfYkfVTR0heTr2aKIWDoJLQHU6psB53OEBhMI
	pp/ByugsWlDHzv+AcvVqflykj8FFqTFBraf37zyeoA/3XkkFmJxtCy49uSdWSlyX
	JCeesSWARtvQdyQkHynsd3aDvFYnyoGkjXVi5Q+VkCNIc/RxGKd6Izf5+oLHyrk0
	bceKS5FeBtSj6KfXld45T7yzm8Fitx9nZVX4/TWEz77I9YoQ0zsh/iIMYkHnzCAD
	J9F+WiOj7tgXOCpyMk6xgdFCE5PDgSHwAcE+TCJLifUusvf5pn8TjlIXCxOfK6lR
	agensCWxIZ2/cr606cy6ONTXZshqm8G9HjpJSagk9JEzM7FQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2judba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:16:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bef75a41eso2864411eec.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781767002; x=1782371802; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShDllGPAIl7Vq+gPkwo0DaoUO1L9IDh4ObT/0q4ua4w=;
        b=YdnNpzEfGHkooTz3bC94odi4E7aAhLooZW/YM4G1dc1CwKNcBu+PhU+OgnHqv13AbJ
         XzAr3PjoDEDwWWWXGhXp+xJYwrNW+2mOE7HRjw+iNGw0hpa7CHpeHP9uPM134sM/fg2E
         G45Ea+v/RurSitYPQ//jzO00YLsDQ6PhGz30iKFahhmkE8rLnAIQW8JvrzzOW+bktZt/
         pX6GB021aBMnqIYDESmTco+Zc3duStMdGMp73qF7ucmtxrTQLzNX1SWNpTYTRlrdCGDQ
         nM3wfqV3T0zygNM76Ii38Mck/hPRu6u69c1IeKevyGxpkd9cdhDZfaR6dcueMxrsgVyZ
         Q1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781767002; x=1782371802;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShDllGPAIl7Vq+gPkwo0DaoUO1L9IDh4ObT/0q4ua4w=;
        b=nbrJmMQK/n/nHBmKLuy8wB+Wt762w+TyPJ8WjIMxu1uLyRCxkaPkuvBHCcBJRLpzuQ
         fERir97uxeDmNjPGHWEnSx0RCKPPZ6m39AmIQP3775lYu6wZn4S9mG71qTcUnAm7WeNt
         XE//V7x4FE6XnL4OzcdLsTV304yuc71miQzWJtk0othwP9A/V1UtCojC42bhGjRBSFFP
         /GHZqrCXvgc/c0a7FR858C6IF2BcH374eCIUFWlVxkUuX74YmR8f2rn1rDq+gpcu1BhX
         /nccSJSPfsF8OE83X+nJmGzuG/pcNTmr4jzET0OP4Axzx0KPsM9BggpzFNYlGlukFWu1
         4ytg==
X-Forwarded-Encrypted: i=1; AFNElJ+f7HiI4pOpMCbyovrHA6JvhyxN18tjNb3py3q/ILlobElEMQfi2F1vbx+ltxgs0OSLpn7+/1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyalNN3GA7aYcRHtnOY6guOospFzj6aAcF4DoroPS6u0QKLVne
	+VdntWzFYwsWxdvpSZk89YYDwp3tsAkBr2CkqkZfftRrlQtYL6hem1QTEDg8HHPLDMiqyNVfuyM
	+8jU8vv6CzRQEGWMbm6GfXNj3g8vAIr71F3mp8K3Ap0kRcMRleM7N97fMzXQ=
X-Gm-Gg: AfdE7cmUF8MYcpiASGtC6JYBEdRe1/8YRe2qTvRGG52tYv5iywKc4zSTeJJ9JbVAilv
	kcSOJfT0ajaNOSamSlsLO/JrscTLwLWPjTzKzcUnaV61p3quiNFcGBWtt0ZykEJXqOsnKlqdkbJ
	dSkVo0gcgB4otx6vDGppnrl8OgI3hXzvSFYL5vhgN+3TFGoHpQeSyJYMpoug7mrK3E/tKkFWrTe
	nnh/fW6wxWcPNDzSmEA1ktVp7qLyMZlBJvXdjsZjpEokZpYCGpAkPl8OZGd+paezcvoEuNRmdU4
	QrCBK6e78LOSBUD2opzyW/uldSsoKpKCPq3JekkmWEt++SxrMmajIyfLTiEk8n9F3gqRDcZM7z/
	FXK0xxU9D2AKr7tDtpFWhehao+lXeRSccRmEiuJwsbk0sl2tQLKDQue0Hwbbpsfc0HQ==
X-Received: by 2002:a05:7300:2302:b0:30b:c502:23df with SMTP id 5a478bee46e88-30bf7175348mr885302eec.13.1781767002290;
        Thu, 18 Jun 2026 00:16:42 -0700 (PDT)
X-Received: by 2002:a05:7300:2302:b0:30b:c502:23df with SMTP id 5a478bee46e88-30bf7175348mr885280eec.13.1781767001800;
        Thu, 18 Jun 2026 00:16:41 -0700 (PDT)
Received: from hu-chunkaid-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bd677ff31sm4089851eec.16.2026.06.18.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:16:41 -0700 (PDT)
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 00:16:39 -0700
Subject: [PATCH] rpmsg: glink: smem: order FIFO read after availability
 check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-rpmsg-glink-smem-mb-v1-1-68a026453a69@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFabM2oC/32NzQqDMBCEX0X23BVj8Iee+h7Fg8aNpjXGZlVax
 HdvtPdeBj6YmW8DJm+I4Rpt4Gk1bNwYQFwiUH09doSmDQxpkuZJLhL0k+UOu8GMT2RLFm2Dssl
 lq9KilFkJYTl50uZ9vt6rH/PSPEjNx9XR6A3Pzn9O7SqO3n/DKlBgrQulMy0ySXRzzPFrqQflr
 I1DQLXv+xcvMPNuzwAAAA==
X-Change-ID: 20260610-rpmsg-glink-smem-mb-3b63dc278358
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Arun Kumar Neelakantam <quic_aneela@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
        tony.truong@oss.qualcomm.com, chris.lew@oss.qualcomm.com,
        stable@vger.kernel.org, Chunkai Deng <chunkai.deng@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781767001; l=1751;
 i=chunkai.deng@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=hvOh8cEClaiB2vFMktW+2r7QZW93RLGLCpI2YW05JOI=;
 b=CyC1+P4gLTNiG0GCQOxfrjRtgg6Ue4lxkOwxEGVYWbQRpaeYKJeG0NZaWGjaFEp05XZKrfcTw
 0rL0I8FJEITCUulKK2OTq8Ts6a7ADjaL3m7LvZpJ59vuXNmKKYfr8Rz
X-Developer-Key: i=chunkai.deng@oss.qualcomm.com; a=ed25519;
 pk=wWxCpsJRKQeVRzpZ8GLRnUX6ozLMowqE3hiz/j+j9O8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NSBTYWx0ZWRfX5EmA/CfVrcwU
 WJwERIxL2RdaZFPMuEX4nfNrxUc2Qr9aDLFSJlNaF+cuTThGpKZbH8oHxvNgLL2UTH7kJifYT+X
 IUAPc/N00eqep+INMEqgzdzQ/67W1xclOWCXWai27ZZxx2NqHEUUt2cPu69v4DI3xxpJkm+AGX2
 swHBuxmsI6+puB2NUTD8+m/qPim+fruKqsTbRF8WMoIUQ0o/Ix4y2Bjd8H/jkBqbJ6uTmp9njAU
 RMruk48MUHVIqQ/SuAfvb01qHasewka/qKfx2R+cF3ZnZMVrF4pGva/svD9rLWmqO/adzsPZDX8
 XBnlE/PsEQlHyLE5JOqw7qHS7+2kY1O6ybGWXruNinOE65OviIBDi31Fvit1yMar8jffJCaNLE7
 iP1Sz5YuK9y7qIqXgFy2+Q0JWfEGefUiIizaWwZg8pcGaBF4I72aMOk+ErNlzAyM6K7vw8khNGl
 VIkHY1WB6On94oFgyhA==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a339b5b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cA7Ack57fQK9oI2lPcoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: eda1lbfiLXtXaIL7rr4VDdPBcBn6oBu2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NSBTYWx0ZWRfX+x+YWw3k+plo
 LPrN10chw5avLiaC4w+S+170XGKxjDHCr+FyzS1GyhJ/rek7KcKo4VQWU97J6/9Rr+B5mY267Lo
 PfcGQ8Y1rZM7nopKYd2nQpSvvLhki8M=
X-Proofpoint-GUID: eda1lbfiLXtXaIL7rr4VDdPBcBn6oBu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180065

glink_smem_rx_peek() reads the RX FIFO payload after the caller has
determined data is available via glink_smem_rx_avail(), which reads the
remote-updated head index. A control dependency between the head read
and the subsequent payload read does not order the two loads, so the
CPU may speculatively read the FIFO before observing the head update
and consume stale data the remote has not yet published.

Add rmb() in glink_smem_rx_peek() before the memcpy_fromio() so the
availability (head) read is ordered ahead of the FIFO payload read,
matching the consumer pattern in
Documentation/core-api/circular-buffers.rst.

Fixes: caf989c350e8 ("rpmsg: glink: Introduce glink smem based transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
---
 drivers/rpmsg/qcom_glink_smem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 62adc4db2317..35bb03e67ae8 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -103,6 +103,13 @@ static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
 	if (tail >= pipe->native.length)
 		tail -= pipe->native.length;
 
+	/*
+	 * Order the availability (head) read in glink_smem_rx_avail()
+	 * against the FIFO payload read below, so APPS never consumes
+	 * stale data the remote has not yet published.
+	 */
+	rmb();
+
 	len = min_t(size_t, count, pipe->native.length - tail);
 	if (len)
 		memcpy_fromio(data, pipe->fifo + tail, len);

---
base-commit: a225caacc36546a09586e3ece36c0313146e7da9
change-id: 20260610-rpmsg-glink-smem-mb-3b63dc278358

Best regards,
--  
Chunkai Deng <chunkai.deng@oss.qualcomm.com>

