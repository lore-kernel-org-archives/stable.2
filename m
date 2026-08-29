Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BF28BAB9
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999772; cv=none; b=psGnkbn4REjfeH7uaL5Cgtzr1SZUYVNxmjix30ZXbLJgUwJom+Yazpi3ARcYV7t3Bu7iGGfmTZ44cQHpb+uOq5fgYGHrjOT1rVU7oxu+leWmvgoN1fJApMOWU99by6Tru7AUCawieDUoRdiWCbEdWRDsINBa0oEHioXXXY9xhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999772; c=relaxed/simple;
	bh=KWNj1tfhDTMqgvVWCVcDzYwwxCOrZo/4oWyTTfhVVBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EobjavmNBdCHWjFrjypJdvnX4yoJ/0Dh3+vKvSWRjd/CzXge3rJnLKYB6YfF5FxXeTtVSbnp8R8di7j8uBB6+WBW/xO6G2iI6MPf8CVghL5M9p22ga2g1g9wl3R/qkjfuFeSDXKcQ1Dt7kBhwLGDXpGao2locoFw+zIHP9dTQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gKtNDNDQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKtG1sIW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gKtNDNDQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKtG1sIW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T8027M1412797
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 10:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r7oh96XdqBR/wkUfzzw8xK
	GlhF6rxacfqe1Jd7qHA/g=; b=gKtNDNDQiFM3QvU486/S4ZSxmYiTf95ELX3CU3
	CN8fTzikSNC3WH2KShymVmlzb342l30MRa3wZnSqvmac+KcnYzX3xG9xg1qW1Nvc
	zTyCKDe8/OpxrpiHkz6lgBd9hEPOPdHTEw/9hVaswIRa1v5gFXni9OBV7nnMhYyg
	vN7cNxA9JnSTq2l/mZ2WX0gvzUlUeYCisxKJ40MCePccvNVlAomHcuOoFhVmTV2v
	cz5hvO3dnCDwRB70jyTZNgf6tmrFs8SHMPTJ4EBBil3GLAoQfnnYQouecuc64M4X
	hAhotTGI6IXGkFujOBHAUY/2E6e4/GZXxnL4Uf7wF4wFRYjA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgygqnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 10:36:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52fa5c5a4a6so42472461cf.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787999769; x=1788604569; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r7oh96XdqBR/wkUfzzw8xKGlhF6rxacfqe1Jd7qHA/g=;
        b=RKtG1sIWnMCru5V7uAnaf5t5R051VbKkLbEcnQttwP5A3qzoQYN4tClaR0BUFltHAh
         bRmAe/VqSJgprZdZsrT5T1hc9125/8XIWYpgsR9aFVD1KfU9hs7RfrJqQyJai13G9GYm
         /JW+qgVDQOIuPfEPSFAbzRWpglQnj4HufCA/gELixM/UdU7aaUzFBwQc7DzQJOTHlhDf
         ISV1FluTNUinRnQiTJSmWAGIkUuBehGFuP/hBCDWQ4LyS4FmbbZfnEeRP0t7JOeo/7nj
         +2HGp+KKapE7pZdaK/OwM/OrW3rk6UyM9qXsg+yBSzDE6x16uTjTZbogKEswfQRZJfsU
         gVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787999769; x=1788604569;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r7oh96XdqBR/wkUfzzw8xKGlhF6rxacfqe1Jd7qHA/g=;
        b=G4j8fYLtIOpUcE4F7R1ya5vPTpG/xBkongDEWp/npmXEb8sCYnMTf2f8TX+oKgvV/C
         s2qZtwsETSI54FAviTEZdgfeUsTZ3RQl37baxMCQQIu1pz2spVkH1xV1+HEkteE93y8l
         o4BnQwwP6DYSBKjKW1QxAP4biV0ZxywmmR4B7LCR7ssnIxQ/SdfL67e40tODDrA+xLuK
         S4xaRBE5DIoXkL9dwPx0W9zakSXEYMJoQ9p+0vrjepH51QQZPtNufIHUaYzMxM/sBYTz
         Tc94R1FBFVW473gU5ltiq1EIoaJWtFF8s8yzygneCR+mYNQuqLwufMWd4JNHHv5cMQHQ
         QoiA==
X-Forwarded-Encrypted: i=1; AHgh+RoiRkbxbZ3Y9BIQzbJCI0g2mSuBfWdbQmYtz6co0iCqAFfpb7FXF5gvJlao1X5baF2B92D3lbY=@vger.kernel.org
X-Gm-Message-State: AFuF++n2mjfCyKSegbrFN/b/QQDf++TuUqrdwCKtr/5f50joNGCml3jq
	csaq3QlTXOJ2B0BDtZvTNZkbo46XNDpEuvGuHdsar32N7kFQ5WaMvTV4s7sDOhf6nmV5Iyw7Xcv
	xaRyYv5Utice47LbLbRY39Lhoh4OG/fHtwCTtC7HYzD9lmDc9lvOhWN2Y/90=
X-Gm-Gg: AR+sD10jlKxTGf2PeQBN6PdA3N93faeT1YbIcPopEVMrHz45O0QxlQL+Uf5sELobpW0
	3aYesUTxO8vUJLYkWnFWmX8qxVJlKAmiJam7mwbYyH3xZxrZsD4s/eHS60qvqfUUXQinC5BDtDM
	EtSr9Cc67hDofZnszXBdYgcnBB7DeSZ7emwIc8ar2Rns20B2JjOZ6qLbGSQ13s7bU/vIKhj9z3R
	SK/f7rjjeoBYfBydwb5A/2i5I2MweqOiNG64AjtDT25ma/Uv6lHtoi6UrMEKbeCYJ8SHN7iK/2W
	gdJ9Q/0EIwftmY5jHp0Q4HiiXm/rxaa1h/JDbeYHh6DOfvzGgr7FLld56L2YYAz5qHTekyFC9fW
	Kqwmq4ECHJQ==
X-Received: by 2002:ac8:5996:0:b0:51c:1a17:eba0 with SMTP id d75a77b69052e-52fb93746acmr150357011cf.2.1787999768641;
        Sat, 29 Aug 2026 03:36:08 -0700 (PDT)
X-Received: by 2002:ac8:5996:0:b0:51c:1a17:eba0 with SMTP id d75a77b69052e-52fb93746acmr150356591cf.2.1787999768217;
        Sat, 29 Aug 2026 03:36:08 -0700 (PDT)
Received: from localhost ([86.149.41.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a8e0657sm90067615e9.13.2026.08.29.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:36:07 -0700 (PDT)
From: Christopher Obbard <chris.obbard@oss.qualcomm.com>
Date: Sat, 29 Aug 2026 11:36:00 +0100
Subject: [PATCH] PCI: qcom: Only check bridge nodes for PERST# GPIOs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ7CMAxE0atUXmOpDSoqXAWxSBy3GIkk2LQgV
 b07AZZvFvNXMFZhg1OzgvIiJjlVdLsG6OrTxCixGlzrDu3gjviSgjkEr5EwqiyshoWE8UH5jhr
 2EyeHswUc5Y089n1HRK0fItTPolznX+98+dvmcGN6fiOwbR/pwnzDkQAAAA==
X-Change-ID: 20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-ef551ccc0a8d
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4029;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=KWNj1tfhDTMqgvVWCVcDzYwwxCOrZo/4oWyTTfhVVBU=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBqkrYSRy//TWaaxaBgax4wdgFGhAlpr5Z6miRlk
 UsqTcT1FnCJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCapK2EgAKCRBjTcTwaHBG
 +HZ+EACUqmFwJpJnfmXBxaTOcOdqgz37aXn1EK0RqFpeVGuIJfk35AJjhVB5gu+YEt3eC94PI2X
 XfqeKzjSI17X3VLYgG+g8k8+WkFhuWp9IH9JLeOnkACprcSJgzwe/hRSHlXKvArWDGZiOI/KZMG
 TS42frVUq9vWpBpAEZFwkqaQAXdRjaxdfiHqvmuUDESXFu+YPnmVWnphtm9/CnNihP+lD0+FoZQ
 uNZLZIrfcMqGuk4JeQjt24NB6OagLfnr9L65Nbkj59zKaE4u4xeZ+x7aMsF0AUma6JAZKSkxXsQ
 M5k7mfYTkLnw5a4c2Pr/e+uwbGmo2xc13Od1xH03ExD+0vr8km5s7+kCmAOyMbGwdZsnf15JUqJ
 XLc7l8wirgBK8vspDjpm2cWb8FyrnrUSn87+uqaRSpbEC/S1Kncg8wrlMYLNoi5fgKPJABSPfq8
 vh/IehzxdeWu9KpbOibuGGDyMw36BJTzpvgp660K/ogzHbwQ5Ry75YgjN79XOVSZM+Wt4x2G4CK
 +CH+QmzO9Jv60cvRA6GY9JgRevf7aA6E99dIXyriKobtx7/UxHMWWo7NKts+lWQzKmCoJe0w600
 i7vx79Jh+TtqTy90wretWSvozDwstMeQU+CQILxpcRkKBtCFp1skkmo4SgmG44WCHPaXwa9FIkL
 +KuhPbkfdLqaI0Q==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA5MCBTYWx0ZWRfXxsm7QkNqgqMb
 BwVYIDwjtVVfkt+eJO9T9Xlrr+LN2aVdQ4P4rDfzJXlakiBD3xkq+w5sueaDQUyCsX/d2XhTCbm
 VD8YLmCmPtn7CQ7VgGND1qxJ+S8AA+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA5MCBTYWx0ZWRfX+ZGIJmFQLT63
 BugBQg3eKjfdcDBztq8QQwys/mV6ABNy5RhAkIfibjDXW7eRtLswxgxR2R8cOZYHSdSBGYWLdrZ
 141UrRpO2BUv6C3XoVmRbRQZ7VspVVc6+KWlcq4dUzCaZtdVVWJcH1UmwYgubwNTDBREZA9QK9o
 nRDy2zV53ssmL4hIqpz7fSsJD0Yda+eL+eb55PUKGA2hCv7aHy1nheTKDFKJ8mDUyKfhdmKPM8X
 WCX5jP6J/mPggQuWfW1TKWxmJ4ipscaqXzwc5AUmlG1NSU77R1TEr9bUMjVAHZNJVUEgT5pZbqg
 cc8dg9gB5rJCMh2ys4lEUdc1aEjwUWrLFzNAhX3IxsPg4Q+K6NcDJu1uY59kjhbok3x9kqtwAwi
 jkjleTRe1BxmbK3/9YaPcITwNUrWwdao+p+CmtBSSPOYsvL3y7LwuqEyZWTxrk7rUEtxMTqxv2U
 6oXQC+3BdcyEnz+rtPg==
X-Proofpoint-ORIG-GUID: BFkpFHxehFbRfOpKOsAIWzE9rpgXHfMT
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a92b619 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=1ZqYAqmp+mGnO5v9BrvPnw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FVExEZwIv0vllHUD6gcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: BFkpFHxehFbRfOpKOsAIWzE9rpgXHfMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290090

qcom_pcie_parse_perst() walks the PCIe hierarchy described in the device
tree below its root port and collects the PERST# GPIOs from each bridge
node so all PERST# lines can be driven in unison during controller
bring-up, reset and power sequencing.

However, the recursive device tree walk currently visits every available
child node without checking that it is a PCI bridge. This allows the walk
to leave the PCI hierarchy and collect reset lines from children of PCI
enfpoitn nodes, where those reset lines belong to other drivers.

This is reproducible on the Qualcomm RB3Gen2, where a Renesas uPD720201
USB host controller sits behind a PCIe switch downstream port. A Genesys
GL3590 USB hub connected to that controller is described as a child of
the PCI endpoint:

	pcie@2,0 {
		device_type = "pci";

		usb-controller@0,0 {
			compatible = "pci1912,0014";

			hub@1 {
				compatible = "usb5e3,610";
				reset-gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
			};
		};
	};

The USB controller is a PCI endpoint, and not a bridge, but the PERST#
walk descends through it and incorrectly claims the hub's reset GPIO:

	$ gpioinfo
	line 162: unnamed output consumer=PERST#

As a result, the onboard-usb-dev driver cannot acquire its reset GPIO
during probe:

	onboard-usb-dev 1c08000.pcie:...:usb-controller@0,0:hub@1: \
	  error -EBUSY: failed to get reset GPIO
	onboard-usb-dev 1c08000.pcie:...:usb-controller@0,0:hub@1: \
	  probe with driver onboard-usb-dev failed with error -16

The GPIO is also added to the root port's PERST# list and is asserted
and deasserted as part of PCIe reset sequencing. On the RB3Gen2 this
causes the USB hub to repeatedly re-enumerate:

	[  116.479598] hub 2-1:1.0: USB hub found
	[  116.488601] hub 2-1:1.0: USB hub found
	[  116.496971] hub 2-1:1.0: USB hub found
	...

This disrupts the hub and devices connected to it.

Restrict the recursive walk to children with device_type "pci", so
PERST# GPIOs are collected only from PCI bridge nodes and the walk
does not descend through endpoints.

qocm_pcie_parse_ports() has made the same distinction since
commit 45df22935bdc ("PCI: qcom: Restrict port parsing only to PCIe
bridge child nodes"), but the PERST# walk added later did not carry over
that check.

This bug is distinct from commit 3edb3a038d42 ("PCI: qcom: Skip PERST#
GPIOs provided by downstream PCIe devices"), which filters PERST# GPIOs
based on their provider. Here the GPIO is provided by the SoC TLMM; the
bug is that reset-gpios is consumed from a non-bridge node at all.

Fixes: 2fd60a2edb83 ("PCI: qcom: Parse PERST# from all PCIe bridge nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>
---
USB/Ethernet issue on RB3Gen2.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..89a476c37098 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1953,7 +1953,7 @@ static bool qcom_pcie_is_child_node(struct device *dev,
 	return false;
 }
 
-/* Parse PERST# from all nodes in depth first manner starting from @np */
+/* Collect PERST# GPIOs from PCI bridge nodes depth-first, starting at @np */
 static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 				 struct qcom_pcie_port *port,
 				 struct device_node *np)
@@ -2019,6 +2019,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 
 parse_child_node:
 	for_each_available_child_of_node_scoped(np, child) {
+		if (!of_node_is_type(child, "pci"))
+			continue;
+
 		ret = qcom_pcie_parse_perst(pcie, port, child);
 		if (ret)
 			return ret;

---
base-commit: 570f7e331f5febb30f1384817463c7e42b65ca7d
change-id: 20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-ef551ccc0a8d

Best regards,
--  
Christopher Obbard <chris.obbard@oss.qualcomm.com>

