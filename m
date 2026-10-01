Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E93C5DA1;
	Thu,  1 Oct 2026 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893589; cv=none; b=OOCNswIZyH1U+e7yrW895zadvX0cIdR62478JMXDe3UciUvtQGAfiHkncvlP1FaOxMS5wOkRd9iVuW8hCsXsAAIu6WxtvAHvUKWS1LpdyLKX7PIEH1wTMiV1q6tQ8XD3fXt7jD8u4CAvnHiNP8/IrjQMWb5pfDpSGdUfqJzFUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893589; c=relaxed/simple;
	bh=hGHr+2I81ejfp/DsBfCmghrWW5fjJ8hrG8YNO8L7p5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iP/2dqgZFlwcJLJ174jquz8wvFVF80uWxi0HNS3/VwmbUxubJlsrX3Pte5976FQSXVTsrxCgpVNOtSR5j2XOWNdtrfpRu80AttecYCuOvEuYIlDKmJ7vqsMaxIN0quEzuuV2dzW2fljumByg2DBgrooFy+Y8p5nNba1xRo+Aw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEFyXm74; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEFyXm74"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691G5T6J2030035;
	Thu, 1 Oct 2026 22:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=g/sMdSj8DDi4M03l1I2UQfN4y5okDdFfRf9ky0ubX
	PY=; b=mEFyXm742DXm6ZjTk/GW+12uO4cBlOBonNHKNgFcXKLjWMqynSy2U02TG
	sb8a2Rlm10BFbNuIyjC4RVpfPKjgRgobilx9Oun/GpsSI0PNtEZasvwzehaOLZYH
	K6BvgM8Rdo9oAWbTOSQm7dfJbH9bjjhYnTaICEjX7G6Hk/xkKhpdfeiy7jcdJNB5
	Wucwu2zpYRYdrQ6FMjtBFExk/Fsvdk67ZMDhMHLZaOkXp685vq1sZi8MW0Tq4/0S
	5SVfoAoKle3kX+mH3Xn83jKa304awG4eKHK2VRlBO7gVkmr4FwDTq/gSvEtku7KO
	6IK8KDEpGTteXAiVwn7X6fI9LOv/w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fknd2c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 22:26:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691Ja83u4073405;
	Thu, 1 Oct 2026 22:26:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pht66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 22:26:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691MQ7tO30212642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 22:26:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AA8458055;
	Thu,  1 Oct 2026 22:26:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64D858043;
	Thu,  1 Oct 2026 22:26:06 +0000 (GMT)
Received: from ltcrain119-lp4.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 22:26:06 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] xhci: Reset controller on xhci shutdown
Date: Thu,  1 Oct 2026 18:25:27 -0400
Message-ID: <20261001222527.11742-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vUfaowdiw9kcGPmzh0WlD1wzcNf8HSKD
X-Proofpoint-GUID: vUfaowdiw9kcGPmzh0WlD1wzcNf8HSKD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX6tBzrPEjyCtd
 My3iJXOhGO0Pn2OK/uwL5OsPVzexVllL5MdmO9XKAa1qLGHclDvBO+wUtSM/846TTwrtUGk6v2f
 LI/+/2qp29v2xsaa0HweADeGlFRuQ1Y=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abede02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jT_9lS9cAAAA:8
 a=_TR_F_hvtShnT16lqtcA:9 a=Ec8Bv2-zM_L_lWdDgjzK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX8laPojxqdjYe
 ppIeSWaAM9eXWwZsLiIaG6AEx3ZPs1mDK+ZJigiEz/EeVVRnT+kvG1/2rCxVefmIcKBOyaesHD2
 37YlEJ6rHjTyaCuslfAD0/aXTkag6VsVZsCS4A1RyCsOyhYUEFecl9vylMHlZ3fXlWDcUwp47BV
 gj8pV8JlMx7CSzc6I3XNzV7pnWvOrd/53PHEHu35pWnFa9P27dk5D7o64eJOkFtxkd3kjGz7TGf
 Vl0+Q2bE8sG1XgX3F0jdUtXJfWjMu0szCkKi9fva0kZWFmrF/+3I8Be9ls1t+okN9fKOidi/apm
 GqJ8lhc0HUi3sFbyGaaLRhhAVb8I47PDD43GST0ZY3dyrR0M14HDCmfwLbSVfZvDMOtdl2rNNbp
 r0+hBKBwa6pjPnvJ58Oog91Lw5AMA9LCzwsPsUyjwo5JTBQ6VkE8kXYqSK4VvOMU1tPv7IBqdBu
 yjxiTsNkOxAWWl2afiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088

From: Wen Xiong <wenxiong@linux.ibm.com>

Fixes kexec boot. Without a hard reset, some USB chips will fail to
initialize in a kexec booted kernel.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 drivers/usb/host/xhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a9e47e178c28..364bd61a4bd7 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -781,6 +781,9 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"xhci_shutdown completed - status = %x",
 			readl(&xhci->op_regs->status));
+
+	/* TI XHCI controllers do not come back after kexec without this hack */
+	pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
 }
 EXPORT_SYMBOL_GPL(xhci_shutdown);
 
-- 
2.52.0

