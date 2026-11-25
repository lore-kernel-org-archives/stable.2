Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603122;
	b=b4SEYRsgywD7mkWoznxzoMSiSPGUvPcojgRIzbsKgCN/MV0p9buRr2bCqE7tk/qhCy2X
	 LbikST9DiM1pKpxhB0CFypQJQ/3MmRQc+KYphODSawMrUUEJdyFNxB7qZRjICHo6PY3dm
	 UYUY0ET7rO2eeu6BMrpM0eHEMbmnWo3oF0k8fWabimiwuBJBzaQnBdN7iXMUtbRmC068e
	 oAqakFB+6nKAgl6m5KJD+M0+Nv63c4U079rGp94g4MtR7EghGtp4TwP58OnzvrnDSUmuI
	 wjnNG9KrGx6yTqjwk4+AcuzcWSH6vIEODb99g8f3zVVHLrykNDmiOKYe9JsfCUYDpDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603122;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+hZ6yiArMMGW/4xOEf/vgB/V37r5/1JqrJZy10W2Qx4=;
	b=XhhcUqBRYsdI47jQbFz2FF0cA1PMnp1e1aUZkIFnc6D39t/+xL2CO/QnGtHuA2LrXKrv
	 0aXyIouDJN0PvxjmTj6s98xkQedwo+s14V6m3qgyfOTTGSBqHdyRI+JuAWlAbb4Lpugip
	 gFDgcm8NeO9551yyOpbHsbu2BC2IKnu3uf+iYLenJRVlAeC22oNLbf8N5eIWys4LNR8dU
	 9smLmkn46K42VgurficU+vgnezU8HCAoCYIl6XUBUq9uMn3P3mgJ5si492y/6hRh4K5H8
	 IYB/LopSOuEttYaKIKXvMgnE0jAKSq45Y4hxK3rNfALAWCDryAhhh17PMCYq2DkDPYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ohXFrsaC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Pz/MkxiX";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A9606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8A9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ohXFrsaC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pz/MkxiX
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mFJ03126473
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+hZ6yiArMMG
	W/4xOEf/vgB/V37r5/1JqrJZy10W2Qx4=; b=ohXFrsaCJZZOCfG3HGTW/uKYT4+
	0nQpEVTZUyRrr8A1sCqUajvSxC+WUmgHJbAlW19DR+L60bILvZwpSNI2Zy/uafld
	dxqcfBHyORRp6WmC8zqXii4p3uVyXlW53A7e/Ed/hrloyxIVeJm64sqffckEWKJ2
	AjgtBKSmdCrxPbofMWCnwaVmsk9d4wXrT+wfbgqcbSW7lli0XtQKmZotCzrLzhn1
	hf/ojZeGFM0MtcGGzGDjflkl7Q1X0zlPYwtUhVtTh5zRwvyuEgkcIQMj9GmO4F0k
	UTEAKvtgFnK9Dx+zHJcIRIHas1fDioIW0758krbLY/whGvXCG8NZyxJ6B2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydbqvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-947a607ec40so550139785a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795603120; x=1796207920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hZ6yiArMMGW/4xOEf/vgB/V37r5/1JqrJZy10W2Qx4=;
        b=Pz/MkxiXKPMxnpbAsl4sTfEoGSVKuz5rTdXUgVJDuwkBbLnO/f4KaMroOwIUsb+NyK
         I12IgE9DIanlfbGUA9paTigU0/+93DFFYP5pIu3cMTlrfik1oFiX4u6sLYEf1IH5Jv4X
         vki5xDaXdffBl1v3b7tFowYk31joh0np0wwPh4N2mXaqndbt1dYmdtVL5NYTvHDZ2mFy
         DBRYVEg8SN5hgDLxX+WO6QnfPulQo8RaFR9z0UGun0FiTGVv/eazmqwnhAFfcPAbQTcj
         JQ/VZcyy50GUl63e04vyfORC380tH/kERD3uGQhbV2LiKu52TRnNhEgqp9gJaHhUTGqC
         sGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603120; x=1796207920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+hZ6yiArMMGW/4xOEf/vgB/V37r5/1JqrJZy10W2Qx4=;
        b=SlRCGzpYvmUedvROljZE8BkAQRLse0bNQQi13fmEi58HFpjbiYGghd7sK0jqWRnBm1
         8xOiIhef7UNkD8e52+VdBANwP0Dt3CNQQExDSJGSEAZMrurexT/Zbyzvd6o+tP2Jg885
         PZ+sGhqDphUVJzR1U90/etckG2T6U/gCxnmR369+Vpn/inut+JM2rmdzyF41vBq2gyHC
         KMKfljMWJbv0HUHx/6CUNmXqRNFSONWPhJioTp6O7/Io3Gdu2cLN1rEOtkF1f+5I2Ghc
         or9qUomuCeaDPslR6KnMGTkoPUm6zwKxZNf0avVQoMa+pxJK7rZGIrkPwiGOhFNmtlx3
         ImVA==
X-Forwarded-Encrypted: i=1; AL+hErFhT6IyMG6Z7IPZ4j+Zr8jU+r5poKp8plOYRiEZyFTDDtNlWaUrpAGOihLocpkzlUi7tPdTJk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KWtclHrEFvQei86IQbEK6RueUoVnKjWtaC+Vz0PCAp4rbngNB
	TDSuyqywrlGJ5pkfyvWEZFVm8jq6589NjamK05tv455t8uc6sJ50dxREG69/ArSk/3J5ngKUwDH
	RGMG3ZsgCU+Tfwmct59vGQvA9olXSV7cb00g+HI/DPuJdv4byiZOAJJXFUgo=
X-Gm-Gg: AZFdTZedIvyWR/p1+6S0Lc9ptyU0BcqnSOyYOaIUb1idvdyAcy9W8FkFvkj+2+J/I/I
	viV3330lQvyRn4zOE7/Ytnt8s6Vv+mblnZho29+mbwi/hFfhrWSXWv4uf4/0W/yWW5QrSMS/h07
	uiS4mnkXdnQijkOtcmnlOe9fUWl6S7kq8+fcbA3b7X4t7FdM6R8es3cGBKTkQxButjWuT1j/UoO
	GilEL8NgS22SQtGwwPLsk+91lWMYwl/3QOdsuqFGzQq1n9PPM13gwIFg5KASn8cr378UYSgTNkN
	dfrzZjCV3fhmTYP4ZdOe2/1ABXgkq6TdJvPAuSkl+JsXwqphWHXz1dDsli4twk2iBKNkueblEsq
	A2xkYXyLrNPIHSS+zsclbzVw4tuFsP2t3J/zLnYDnSxcxjwexUL0WLjtFFkrdMWEz
X-Received: by 2002:a05:620a:2a12:b0:93f:102:566 with SMTP id af79cd13be357-949bab5ee1fmr3046339285a.67.1795603119942;
        Wed, 25 Nov 2026 02:38:39 -0800 (PST)
X-Received: by 2002:a05:620a:2a12:b0:93f:102:566 with SMTP id af79cd13be357-949bab5ee1fmr3046336785a.67.1795603119456;
        Wed, 25 Nov 2026 02:38:39 -0800 (PST)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa397asm34171502f8f.48.2026.11.25.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:38:38 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Srinivas Kandagatla <srini@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Ravi Hothi <ravi.hothi@oss.qualcomm.com>, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/4] soundwire: qcom: skip offset2 write when unset
Date: Wed, 25 Nov 2026 10:38:23 +0000
Message-ID: <20261125103825.936939-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125103825.936939-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261125103825.936939-1-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfXxaMN2BV/lnxx
 u7kHhTMzwCW178DQcZgLDNuUQTw+wzibMNm+0NANADlfDuztg4XrpMG6fm4el8LwjcJTU7ZlTv3
 5zWHPcRjkLLlyPzkpI6V5qYKk2xFiZI=
X-Proofpoint-ORIG-GUID: wMNt9P_diVizQewuiO2lIcRjk1BVhwlS
X-Proofpoint-GUID: wMNt9P_diVizQewuiO2lIcRjk1BVhwlS
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b06bab0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=h8pHtkhTcpIEMHaiu1IA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX7F5Mj4hl0tpp
 EyuRFNlxtCCjo1E3prbYrei4Hjcw0vpP0Jy65jx+Bmbg7RJ3dDfAorRg9vB8wjywqULhQe63zoc
 qs8GvnxfIkTFnqrej+qhyuXEun9rfSy8o7/wAbR7hvRKbBXnjIN5bpDxX0ZOOSWACijmFCxbQrd
 LBqaIgFCzM0Mi14rg9rjOhr51BzYul27h3lds7uDhAlPtXLTm7Ntxv+atpbeXVpPbYfB2ECbKDU
 Ht5Z0cuDglTLyBg4rRpWLnXahXDDOcJ2liytWrJ4sf4OLW98KAefs8BWICHBZFJSk6sMX2DDOf3
 7Akug/1pcrJzL6UjT09B2QzgKH0aYR5S+/Uy1fDaKRzpjowYdqcX1ZOhgguN30PmFEPhyqDb+iL
 r6wQkDDMb7+41MhCKsDeNAaN38I8jAYGPod8zHGUk9L52NnsEfFXurHjWRSR1rovmSrFPP7FvSI
 vHb63+tEMAFU62NCVhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250042

From: Ravi Hothi <ravi.hothi@oss.qualcomm.com>

qcom_swrm_transport_params() writes offset2 into the port control
register even when the port does not use it. Many DTs mark such ports
with 0xff (SWR_INVALID_PARAM) in qcom,ports-offset2, which is then
programmed as an offset of 255.

Skip the field when it is unset, like the other optional fields.

Fixes: 02efb49aa805 ("soundwire: qcom: add support for SoundWire controller")
Cc: stable@vger.kernel.org
Signed-off-by: Ravi Hothi <ravi.hothi@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
(cherry picked from commit 65aca3ef0d1fb2f6b20892f0d1a3a1ef391ccf7f)
---
 drivers/soundwire/qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 95444eee4c0b..b29e2aec4ae3 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1232,7 +1232,10 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 	pcfg = &ctrl->pconfig[params->port_num];
 
 	value = pcfg->off1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
-	value |= pcfg->off2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
+
+	if (pcfg->off2 != SWR_INVALID_PARAM)
+		value |= pcfg->off2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
+
 	value |= pcfg->si & 0xff;
 
 	ret = qcom_swrm_port_reg_write(ctrl, params->port_num, reg, value);
-- 
2.53.0

