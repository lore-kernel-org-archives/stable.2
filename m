Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893610;
	b=CDLgKX6bw6N46SH0fFQxl192LVG31h+x3cU7Gc+aIEla9CxPbNfSp69/jMEz3TJ+gDNf
	 lRKqgQTab8mKVcOUcPYatM+JW5YI+JBxatQ7PGWR1koPaxqQ2DsmBz2JRc2dV4WfaG0vB
	 4glKtOC+NyN53aGmodNBN7/KOekBb9l8q2FM1+INgG6jwAIf7ArTGlqay/LkMspONdAyN
	 75GbMlMONuODpxJQoAl3xtZrYT/IIcyRyQWjYpPCI0N7S4Ph/AuCYZx9DKZnMv2L2Ii7T
	 LKjCbsfySJOh4ld0sMNzLrq2QS5Rj7TDYTsvB6sh+myQf88+304+1uYDy3E6Y58zszQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893610;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
	b=TjsPsUiNP/z/7faivS37hJYdxZPRB2Icq697cE6EO6j89j31hO2EqISDXTEANXTwdJms
	 46tnv6+bJNtbE69fnS013iAVmeILQfvkWaIaC0avJencAay2P+a0ZOGqvZR6KJib4Sa/G
	 gco2+/RpqrOIxysB3lZlYcuJrS8+d14N03Thg1F+cxlN+4YnBk5VerluJZOi4/DFtQm46
	 n6OFw/kyF/8XHkfRWYN6VUned7aBsIx3jDLJwLqoUE6zQ2Awbj0eXMiggIVheDr5bvr0I
	 B3etkvr7hH1Yp/Qnj9b13fRSv9eTwv9EEKuNC70OkUDpqPF8aMS5DJ9XrPPR4Bj2sug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UbgLQfmH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeiuGTIc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA5606D81F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59AA5606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UbgLQfmH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeiuGTIc
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQL9M1040252
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 15:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RN+WEUPp4KINOTOtwDMjWG
	bdxhennDprUx1GDkbGW6I=; b=UbgLQfmHay1X+yLkye7NquJWqU5e0T0xMorbpE
	74Ttkk3IcQCJZwuOfogWU5uXpQKh/oTjnd9cYKbq0bW3rj7XRJDB1tZ3CpwtycAn
	BeZOC//LnRvrAnZ7u7FlUyDLOuQE25ubJNXpbEIEMIOuxl9/M6/W2+Bnm4XSIBze
	oKceZdEID2DXR+k+W5EFVf+Hvo37clM7+TRhEM17pGLdFGC7JxfxvzrXcijSkJVf
	8N9YDYYc5R92tCaQ3JJPnfznxFcQ46sztjBN6p/+92aE6IAAnFuQSQK35wbGUo5c
	hqnW/zSD2V0yeutOmQorrudVCg5uwEG31yCLMWNzjGuuCVHw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdacb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:46:49 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9806756ea40so1619936241.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793893608; x=1794498408; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
        b=NeiuGTIcDa0UFX5v82P4oZ0WJu5KVbWMNDs3GR2L8p1fx7zZcZyrjB6VxrX5NUCB6N
         eHdIDgVXXkiHUpu6/FHKgtE9FvhR1ig7GAEei4+MFiIheIGXYrapXFX15FlVWRgUG008
         2JtuIba77h77V4H2b045mwUGoFGTyholICVyAuLpku78CVH/5uzpOSWqUxixZjXm1aqV
         ud5eIyCvvoXAf0VVQ7jcyQCeBiFkBfIZepROugkZ1Akwv7wapLoXaNuxQrFLGqLra3Zt
         caoI1dEF1whJDIBvf8nDVFBbw7CZPUdJdtoHxPakiSdkasof596lWyN2l4HiqYj0sYe9
         h5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893608; x=1794498408;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
        b=xQqtlrAYv9OnYgm0IWKJpbDcGpsveBgRis+MpOdos+WVUYmmJEXqicPrRORWIzp36X
         vr+dsg1yOzeHXrqGl18QVNE4F4j0eSUyO0AwFe1QNbH+zXWH1G0RGfZdD1P8XLarQj3V
         6fIzW5jzli4eESx72W3gEdp/I/jsutRfBDttyan/ynedJYvFAzLEN3N9cHOW6PFSJa84
         wjoSLrd8DL1rvfLgKpuEAv77OHLmQ5+MtihmKYvwF3VlsFBgaUkKEOXL6ChIYxmsSp0B
         LxIYv+eBnoifGj89suh332wSmwNOspt/7viDdyQX45LPmZ8JpN6NQZeQbEZNgv+DVgYe
         ep3A==
X-Forwarded-Encrypted: i=1; AKwUvBwUPmw1YBGjdbQJ8IHJ216vWssXEOMJU5ScMZnPnc+LaFvHRycGI8lcWY9cwYB5JW1aa5/5OIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cYuckoecF7TigFKYvxuxbEjzcDGU1WtcJ07Wsru2DL3olQCUG
	s4TXAlV4dAuJVxWSJLx5M2UicuId4seLhPfUhFVTG9lo/kHuja6yM2gUPGMupl3fPPA/MqVdXSs
	kJs1cNkseJj6qN5mudRE1u6uhTIKosTI71Nu8y4BbRg2vEzzcEeVeN1dEtO4=
X-Gm-Gg: AYBFou2mpEMBJcAKdu54pzkH2lClN+52aFIJwTaE5TTs8dens2HDkBwV8CLEVJ0b/xI
	MZ60wR4w26md7xDZLsxAEc2PvjEiTD96VngMmfbbJ0cVbrU/WlXZulHxUPRfX+lk7y8jpXB/yH6
	iWh4R4+wDYB8WklCEvpAUeNO/jBu6tMtUvGComrIu230mtRhIW6cCgUAwO+67yYXyspL9TwedA9
	GP53A2wQ7siv/RnJYLb6wfCiPb+TNmYUcJx90x4GHMEx82U0UTgwzYHy1T2Zg62omTZRlVGILfM
	nLyIoiL7w/qCyhQTUhS9nKC7lKfwsklAqQ/lXbKhpeV6OyZIfy/bordHYcphdKILjecQYg0zqla
	0C1YQ8XnK6I9CBr+ksYhXChLhCuCw3XksOpWyb8ZrtrJpWSkgex7+PGOnH/bfiLznZlbF1U00wT
	tzDQ==
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr9324562137.33.1793893608541;
        Thu, 05 Nov 2026 07:46:48 -0800 (PST)
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr9324517137.33.1793893607880;
        Thu, 05 Nov 2026 07:46:47 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm10717936f8f.49.2026.11.05.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:46:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:46:45 +0100
Subject: [PATCH] power: sequencing: fix serdev controller reference leak
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOSk7GoC/x2N0QqDMBAEf0XuuQdJICH4K6UPYjZ6aG2agBbEf
 +/h47DMzkkNVdCo706q2KXJZ1Owj47GedgmsCRlcsYFa43nctSGL5dRwG/HqifsXJF5xbBw9s7
 CxJB8jqQnRRf53YHn67r+lZkypXAAAAA=
X-Change-ID: 20261105-pwrseq-pcie-m2-serdev-ref-leak-f521e086d5f8
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=blvW7P+vdcHikV9wkNkqbWJ4eKvSI0rN+D6MuijpqgY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7KTmd1rI0vmNN85k0PZmqXGbQ8qWCS5DLVv9q
 J9gq1Xa1vCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyk5gAKCRAFnS7L/zaE
 w94KEACA5RwVkTCGlBgYEPF7sW4hDzlNdX/Mkg8SksT9dCIa2v3O3WNBupuy8rIxu3W5/cuYUw1
 c1dzdVJMZYqcH4Mb6pCinkkd5z5+lduqTNLSXtIHVjpiGFL2Ex5lTF1aloa+9FWz1RoHIquisyY
 R/BFEBZ9cyUP39Yx00fnQqnNcgtZwhvcx80PhXqQusGEr2Y9KwzPc3L9GO3OFE7U4WBR3nrB8G+
 4p/ooTTMIJl0yif8KQXors2F0zY/vrLHA4yQyAYiLxoKFck2iSdhu/v75WkX/Li0HMWwx1TjvrJ
 I53v/UQiSfMbWyXATm81qIG8BE188YjxHnlbpowxF1Imif2MuAUUnQUKJb31t7sAhfVdzF3lNet
 meCGbN2bamOhRr+2qtOAmf1QgX9GhUFbLWvP9olvER/nL7JsvrdQrvVFUVMUp28UoWyye98u+CH
 7oqg5T0ge65lwSLsI3DHbMwXLXDwBehf3ypoQ9lq3j+BqJskzc+yi1SHP+J4olgkQxJ9xW9xG2k
 CV5X3Je2nLPFedDOGnIddzjBXP5Dk8D7WBuwVO6Bf9pRH0q4vUjdIbHGD60Gdss5imJnno85qJG
 r12NIf1dbaegpiWbhdb0YRvV46DzaLJdG3iXkZjH0ReHkXBKAhn2Tgukz7k20QTiilC/vRh/vbG
 qzC+9B+9xzd1EwQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aeca4e9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vvZYVk8vaF1dF-lsgB0A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: ca7o3cDSiPe40qWuBqlToNphWbQaZqPP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX0dGMwaUWxGVM
 WUR16kqYCXKz0xX3QqPragB6p6kE35toNre3wabUEbp0HXFCi+4s2/mu0OV7r5fbs5BpMpNQ7qo
 oovNs0Ux5txW6elWEkLeFHQjYnml05I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX/aYRy1Vl3j9W
 IJY7W01jam6XvcTxRXblG5c+Ad0zv9R6ugJAA4ejphexcmCNkUy778AuREwQ7zquZwgopG9lazX
 yXB+2OU2cvm5Nk00JFcC09E/oLHAyyWO2xxHvfrHzr9zw+/XEwh0ypfFwF50qpjIw2vQ5RuSjWi
 LdnKauQe2f/g7bMSZgYjkewWBQxYMrEMMPqBB2F+qvbLB3JCZllPRIrNHWniFjv4u4kOqeVgJ0Q
 uZvxYupWx5kQCyraCX4yK+yOTzObUrE5P5nKuQAQwhB18CyNeGMRih8ew5gX64IjthZaiuLfE5u
 lknprbJ0Wi3BWdqAvyG+Ff6yAAMFKG9iERVfqfS2NDQ4thBRET76T/G+Ka0SAtZW/Xf5sDlAHiM
 NwQX+anZPATZ/jn6xGPcVEQWgX8IoQ90B9Mnh3O0cN8BH1fA4qdKbHaradR/Fqqhas3PEq87bxH
 NvpSttTi8Do7qWls3Bg==
X-Proofpoint-ORIG-GUID: ca7o3cDSiPe40qWuBqlToNphWbQaZqPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050062

In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
pdev is already tracked in ctx->pci_devices, we return early from the
loop and skip the serdev_controller_put(), leaking the reference.

Initialize ret to 0 and jump directly to the label that ensures the
reference is released.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/bug/linux-07754192-a8ad-42d6-ab1b-cd6f16bec846
Fixes: c4be520907a4 ("power: sequencing: pcie-m2: Create serdev for PCI devices present before probe")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..e3bc5ebb1e56666d135c04b23f6d462a0a166df3 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -296,7 +296,7 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 	struct serdev_controller *serdev_ctrl;
 	struct device *dev = ctx->dev;
 	struct pwrseq_pci_dev *pci_dev;
-	int ret;
+	int ret = 0;
 
 	struct device_node *serdev_parent __free(device_node) =
 		of_graph_get_remote_node(dev_of_node(ctx->dev), 3, 0);
@@ -308,16 +308,14 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 		return 0;
 
 	/* Bail out if the device was already attached to this controller */
-	if (serdev_ctrl->serdev) {
-		serdev_controller_put(serdev_ctrl);
-		return 0;
-	}
+	if (serdev_ctrl->serdev)
+		goto err_put_ctrl;
 
 	/* Bail out if the serdev device was already created for the PCI dev */
 	scoped_guard(mutex, &ctx->list_lock) {
 		list_for_each_entry(pci_dev, &ctx->pci_devices, list) {
 			if (pci_dev->pdev == pdev)
-				return 0;
+				goto err_put_ctrl;
 		}
 	}
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261105-pwrseq-pcie-m2-serdev-ref-leak-f521e086d5f8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

