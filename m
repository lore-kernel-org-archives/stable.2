Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626544;
	b=UGuHw1c+Mrxwp+2YYfCjjlOD/gisedduQi7U8z7GqkftWG+KuSy9goTzITBrtk6Vszlg
	 iJ8Mn3+oPagAU3agHKBgMuerCDjAyASMxKjI8sUt67oZN4huGTVjY/ZWk2hczNXdVfYmw
	 wlnzUxy3uAgfNafZCcgMqH2fPbdSmf3dt3HckUf9xcYJIkxMZh1FYS/MqSUuJnLbML9Mx
	 xsVHUHh5YMCZwHK+3hc0RAhKu4E/V0PrXzmmP1JbUm1wihakrSTqcdzHtSggTCK/OLmr3
	 UlUTg7WIQm3dFTXIGLecM/OKssu1Tzdp3Tpukd+wrxwJlreSY0SpqwrqNF4psfRcwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626544;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qRdWYn95ZaWm6oy1LdHIRbsN9PX4lhhSO6t2mSmf2i4=;
	b=4WcVwKAvp269QZm2ZjOAiY4C+6Yo9Cxc1nri1hh7nJ/ZcbZORFw9TKkHHHQ1JDmVw+uI
	 Y22llTOP08ZXXj6/Tv2BNRyXziJ+7Oo+u/fummBoGmoa7YwxuG2+G0JbWkcZZvAXmp6Pg
	 bsk/DTF9v0O2ZIIwa5tFAhiGbKZNsBBNNvbbz6eTse+k1OA7SITuHZuW00r2j2DYCxHNU
	 k1alLOX7gXHWDaZfz9oiq87BuCHRazljhPZlivWZ8EVBsQw49NKlElQaOJKyae8FMtaRW
	 XnhXz+fTyCvp1Rq+DHtLbnCrH0fL/xA9Tsxj+OMS1POvP9sjNxhrZ3terhCnh5ZZp2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DePitHCx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sr6T8w54;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960560A262A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0960560A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DePitHCx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sr6T8w54
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAGet2902103
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 13:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qRdWYn95ZaW
	m6oy1LdHIRbsN9PX4lhhSO6t2mSmf2i4=; b=DePitHCxXjc4rq9gX5pue6c9Sbk
	W9EE3NTucaG+w1zVYvKWspgPR02IGwTefpQaEC3Dg4DFcL+hi/HOZS6Mw3GJ1JJo
	IOqqH58uktsmOBkjyDnOx2oCNVbVoK5EYREQ0iumubPZcYFeG43CjByu9vFCM3NM
	prcdNsJKlw3aZ7CyumrPrnN3cxnQn5uElsdRIBTkdbrelQfFKTC45AhIQKbl5Dvs
	lIgEAvqa6cO0kM+P1D7v2e1GgQv9I03TpjCyv235usNW8Ubbv19R7Kn/GCVb0r0u
	s9BXVmITWYLgIGjuPFnSRk5kSumxPTYfXsH80ADoefral5sgW2PmN7zr+Ow==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavghdd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:35:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c10b8abe29so2451071137.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626542; x=1794231342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRdWYn95ZaWm6oy1LdHIRbsN9PX4lhhSO6t2mSmf2i4=;
        b=Sr6T8w54EkstpzOVvRFtqviuKo7pyblF+7ZqOAkhiJgZmFHwPJybUR2Mk4rZbpxjlT
         JePK7XcgLcXaJq7CaT61abtXsZZQ6g+11kwLQVsb3qDtfMOBh6SGySEnrH6seFnMwj2l
         2ujxU3OWUcqYyd4JM3ha1vfKkN7LhDpDsU7301s0QenFIHMXYuzImR+85h6lnMKsKOYh
         t0Ho09OvxgSKMO4SkIziW34OD2DTlAART+yGLIDWQM74cpL5SAN7a9Fi1fj2DJnL01Xr
         Emy1KZtLU2viYiQX0rQhLyEED8YhwPVy1NmMLVUSJrFF+VgP9NN5l9g/6k9S/MbRUVsB
         qezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626542; x=1794231342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qRdWYn95ZaWm6oy1LdHIRbsN9PX4lhhSO6t2mSmf2i4=;
        b=kqZ/fJSP2NJ5CXWiaAWgs2HU/2fIjw0Vg+tuOzTsqdGRiSEb0EwClsh49pVXhheMtl
         OVz+t9D1Mlfw+ez4xnCIWi5GTIWiXZCTE91ZZT7/ZWJp/7ChoPPX6c0QGf5djTIwdY8r
         yEBxEm9L7vjY5I2uDKEKsUbEeE/OuDNmSPkazLomhMlfsBPyl138QVe9ArDALmG3Yn+B
         vu6HYqoiRYEkR3Udh9tbdXq1DpPfPz/T+q4V23EbsveDpqWlF+n0PSE+fxim0dmgt36v
         A7ox65FXRTu7qGsq/JvW7N2eO+fvUViSJUBLeMngBUcL4NV63Ux7Wn3j8I0K4S4m5GXs
         Ovlw==
X-Forwarded-Encrypted: i=1; AKwUvBxVH6g8FDJoijVnv/Bs0uJCaUKGtgr9/U8suW/vLvqtCInKB9aCXq6SmmrSs5u3lZLoZr4O3SQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ph5gddoOh+W6SnaKgAeJe+53ZIhffjSDC1zmxOBNQ3P++WFVu
	xfeUGsFAZYLYDg3o/0jtf5/SF9TDfHlATA3LC2QaQkj3/0JEVaNA4qvZ0tlR5Mlh2f7GA8zW55T
	J/Z068CLVkdfOxgAdP3p6RxwyEqW49+PpRUr5AGkrNUzF2Mg1tsUccwqytd4=
X-Gm-Gg: AYBFou3HfkO610tN0wNPhv4Wm2prZFOTBVQmkLDiY27AkNI9TacfCatI3VWa+Mgk2r+
	audKqn+CCZBbzP6C7kNj+w33euO53Zzq7puhQOa4vc7rCDpZypWSMRMJd6IdGh6rPissjEivXHp
	2EYkv0BISlJFLfuzo6cRMZzCBLvAFRl/K/B0Kh2jh9UTYnIh3BXT0rD/64W94k6H/slDNGiN7uT
	l9irdh2cAV8WHdkjxzkbTZZjlFClNz6cQua+qBemTG31cISyIj1Mn0xNyBpRs5tUZ5Lnkh1zl5q
	03Hd4RpdsoYtO5EzTrWWLLcw7YnPz0FRFB2THIhlJYOTwGKqEasRZfgGK7d14MDnzTDPLlVzEKu
	W7vgZ6R6hZRCDN/xE8sAjudb8t9wT15mzPHZqpFh+0IAJ6W+2L0Cf5LFyJd/pdg==
X-Received: by 2002:a05:6102:5811:b0:7bf:74c1:b607 with SMTP id ada2fe7eead31-7d0728adb49mr4475443137.34.1793626541701;
        Mon, 02 Nov 2026 05:35:41 -0800 (PST)
X-Received: by 2002:a05:6102:5811:b0:7bf:74c1:b607 with SMTP id ada2fe7eead31-7d0728adb49mr4475431137.34.1793626541242;
        Mon, 02 Nov 2026 05:35:41 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba53d7sm25735864f8f.53.2026.11.02.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:35:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Chris Lew <chris.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 2/3] soc: qcom: smp2p: Fix out-of-bounds with incorrect DTB of too many outbound entries
Date: Mon,  2 Nov 2026 14:35:33 +0100
Message-ID: <20261102133531.173434-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=yrLnmfOt/ROm8h8K9Imo4uMtO8yY2Hc0DvStAQL5SHM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq6JGkvrUbyfQWKXRVbixCwBnKu7593Roui559S
 zoG/bSxCb6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauiRpAAKCRDBN2bmhouD
 1xHPD/4v5eySVecnfwRobUdUpHQutJluQ0vZtyhjVQJNf6+Ohz29j86NaTY/Zy1EuWjlyWVLffK
 xSRUsH5qF50PxZn2A/pTQAxuQ01LxHaFarzDuJjNJjprOM7fSULhy6tMIud5hrccSF6eqbSm+Ni
 1EnM+ViR2F3D0a46yhchSPLvX4iIiOlGeCMH7xUYYJoZbhCO3mUUbOR+4IYdcygFAgSGc2Hf4fk
 rcBVdrlqSUgJCx7E2R/gHX3hpe92+r805dg4wqdaQ3T7Jc0nhNqahHLpxk0wA4AB/Wdapf/6CFp
 mH4y/mlGb54hNbd1DLXwbpq5T455rB70BX/BLlzTMu6r17XqP8CpuSFACWlxwdQP6D4fs0s8FIU
 DYMiOQs+uvfCRMOyZFQMn5WrEgo+2xOTeDRSJBb4Xy2m9AS3nnK7m4cvmWen75eeNR0mSjo9567
 QtTLRt9Ril1saSEVXYwPpwK/2hXisD/LX7ZrGwT5o03l+PfKwpqHFuiI9ODFws+MVZ4AGjwxmRL
 H4gp5ZlnK6FY2MUg0er0CX6uY331ZloPY17roi41/FPFdWpP5sKN5WGz7mwMWxp9dbJuL0NlBsL
 1u51PEBktqgFnCSoIapaGwHSNp7PO2OFag08Jry4oyV7ZrsDkqv9zFKjt2qEuy0VGRc3krrjgUa lLyQpCbKxox6hMg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfXzzlWMDsz+0F/
 FHvbAQs8b2pLUTc9dljOYVh4rye37MKJ4d07CPRUvs1SjWQCZPYCDAalrZShT/u3cXOqQJ+WSti
 Z01ESiU2iIG9fdi7JNFWrOG/i2Xm5AglCJfmwtckKeggyimnaR6fRnGDTSLJXSmIa1s0o6ghB4N
 iRcD1cGu8YekIlGqlAouQUEdm5w5QsmZ6v1ajnKWDXzDhg5ewoyufE9FyMX7yBqEgca+bD7+CKo
 7p1ScTb1tWCEhcdeGR24QuqK9W42pP5bhgbUT3VNEpWoaX3Ik7sUTWUjX/xl0bLOMFD5zmsQHhS
 7KxGF4eUAfzW0jjAOP4J9HuTuziB6+yi2MzuKcDEvojnY9M+TV3jXYs54QzhXeosYKxoiFnVwe5
 utvz93YI7HTe5ulJxLlJaGXFm14fSSOD+Cx4lwX2Dqd0/yoy57PVP8737/Y0HffBK/V+LLqYVJl
 yLSSbjBLNBCe7wl89EQ==
X-Proofpoint-GUID: A7U1XDNumsZo8Friwo638-JzybIlVKXx
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae891ae cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lFa8o7j6PwDw3F3-yxEA:9
 a=gYDTvv6II1OnSo0itH1n:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfXzSx/hqyKNpJh
 44Slb1sXUAGW7Y68QCOXDkz4NvzIrRWIuF/vOMc0WhMap+GTmE0WcCRHmd1re0Y/eF49BCK4Ej5
 1druJtCgcQXaeylaBizYLQTii9qoFVw=
X-Proofpoint-ORIG-GUID: A7U1XDNumsZo8Friwo638-JzybIlVKXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020054

The outbound SMEM item has a fixed array of SMP2P_MAX_ENTRY (16)
entries, thus driver should be sure that DTB does not have more of
these, otherwise such incorrect DTB would cause out-of-bounds writes.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-eaf9beb4-cc0d-4d8e-be28-4c12b039b3c8
Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. None (Sashiko comment looks like duplicate of previous patch issue)
---
 drivers/soc/qcom/smp2p.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 9b6e0627ed0f..49fb738d02a9 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -517,6 +517,11 @@ static int qcom_smp2p_outbound_entry(struct qcom_smp2p *smp2p,
 	struct smp2p_smem_item *out = smp2p->out;
 	char buf[SMP2P_MAX_ENTRY_NAME] = {};
 
+	if (out->valid_entries >= SMP2P_MAX_ENTRY) {
+		dev_err(smp2p->dev, "too many outbound entries\n");
+		return -EINVAL;
+	}
+
 	/* Allocate an entry from the smem item */
 	strscpy(buf, entry->name, SMP2P_MAX_ENTRY_NAME);
 	memcpy(out->entries[out->valid_entries].name, buf, SMP2P_MAX_ENTRY_NAME);
-- 
2.53.0

