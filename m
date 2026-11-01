Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564670;
	b=CBF1AiyYYa48LztkIEK70xcLOgdwh6SuxRy8OWgswmgliVZilWNu0BA7Y0p6jM0Y0Qut
	 fZlHUBEZixxRBy1dOQj5MRfFx9KDeNBtmwWxu9Qy0V+QzPPSqXo856rRF1krOXfGp7is7
	 RR5aeVw7nLd92zBukH103mn/pLvRCnBNVvfwG04qwi8hVwbCunOwlUnpgsoQngQYqQyxg
	 Nr6a0PDOVn9vpK0uJhs4QRSlzShz3uVIjHvIdGpR9p4OIAM388q9+0a+XJW2Y6PWl3hnY
	 ZXl0eWQATmpiZpUsr1WAxtL6KxkEtB6PC7Owg4AnTnSh3n39VpBsfk+UbgNVMn0ab2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564670;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0CYhVuDpQu8QYZjZkxqSBp9RIPdqIGatFnQV15ShOXU=;
	b=cei+8vL1oWeMMI+Id4KrhPi6OcxWgLWYqQ0h/aEHmM8WINA8Ru6mSvxK2f38MKRjA8FZ
	 ioml6QcV2c4UJQ1lY/7QSZFhBoPSL8TDwUoxM8TbeOjSZBnTe3lrLaaqqXDjHUCFhUMfs
	 zQPO22dfDGJ/z3l/OSA+mn4YFX0pMqQw5UloKSafucXAbw9Kqo9tNdgFNIsSANJrCW95N
	 /NFDP/8QD7wUXGXEgmDxXJ7u7SQklqEtC/1eYeFqfLrlAeja/ozqFTbJLRkdTP3n58Vwn
	 GT4ordFxykoCb5SrCQJboftoQNdh7dxS7Dl8xdu4J/Vyq7fV+nnXyiqBWc64KpeNolQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f80ybTA4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZ0KO5X6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A4606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79A4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f80ybTA4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZ0KO5X6
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1KK4sF1454054
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 20:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0CYhVuDpQu8
	QYZjZkxqSBp9RIPdqIGatFnQV15ShOXU=; b=f80ybTA4bnsLD3KIZUWLy24NggP
	RZHBvRIXJH+xBjzAenAFFmAE7J8jcXLl+3Bx5XizWszo2qvWNDtbHe6j4TRHoPYQ
	w4GwZFkULwqlWxVl8A/NigiU3i4brjWwb678DhPw44LyjiTMCddC6JuIXIkomMI0
	dTyyFRBhZ4s8lCXxZsJH5bAg/Vk+JMwMS7AOC1SlV/8mnEOrxRM99vo6id7P42Rb
	x252OiiwdmZy+IGQH/RjcS+fCyWLrhyEx4dY30J5EzezFAkpfyuHl8r4mv0OlAOP
	QEAlhHQC+uA2WMjuW3afjK3miryK7eS0k3RS3PsTccs0C6GKZLtY3MC3lnQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfv898-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 20:24:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f33438950so459573085a.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793564662; x=1794169462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0CYhVuDpQu8QYZjZkxqSBp9RIPdqIGatFnQV15ShOXU=;
        b=KZ0KO5X64vocw+o435FU9hRO3JcyCLC2MZt0+OTZrqC9MSnGeJSJw1boJd8r4T7SM9
         +Gz9+gWvc1r+AnEp5vTRex1ysrRAQGm4pEH6HNlg4V+tVnrZ7Ixx1p1LvEEOz6AjWpa4
         d4W5N64zw1JY6JlELtMKbjC+Vwb9Rjr7c3YJPZRr2SCKho7kdWTms6Xey3Vu8rkpi1kZ
         g+2dvZUPz74SJ9iHOqvtnGjo2qu0xAGIMbvV+45IMzLX8eg2PpH7dk3eP2zYVtrKQjSe
         VdPhe8Zi9OGFlnFp1X/UYVIjh1+do6GSt0n3ZwD/EYXZhejteRuJL8YjZc+a8kSAOY8U
         iE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793564662; x=1794169462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0CYhVuDpQu8QYZjZkxqSBp9RIPdqIGatFnQV15ShOXU=;
        b=aFFDZZh+o5jaV3zaKpHf0uuCDi5LFFjiMI3Pl+61VzFmjifYbotDqPwsA1h04teI0T
         BWIegkB0L8wVlRGB5wD1AmhVqYjbg9eSK1F/AUJDmYOixmaot7zq8IDp/0Uu+S6acadd
         UH/CSWZqodS88eIvG1bB4sPGisx2272bUwPQ4eW+IhSWAhwWHS94G2W+Jduov0ooMUW/
         OiYljGxzmrL8FJrOWK3+6Q3+aFxwEY4BcsxVXBovkJSZqsA1UK30gkqPal87hZ3J4L7C
         fuZfWuGLDYuvxMhmMT6KXc23o95doT820K1XGBgSBsYc1ucQ/BfI6PtSEEqbtQ7RYXUK
         npkg==
X-Forwarded-Encrypted: i=1; AKwUvBxrCdxDoDMnYE1zubNJca21j1uiyN7opvecOEc48NZDlLz0Nkdr2xe9r+1RRAdmPZ0cWlOz/9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOQyz1dISiT2W/XhnEoLPThl9mPZ1HngTgCN4mikTH4sHT3hN+
	+qD6/ttui1HZ0ytn3OXxwFiBOvoltujF4wNIkwZiJqRGPbUrSwBfa1wmXeDmNOd0UkyrreqC16d
	2ksFk5c/MD441MD7nkMH4TA1c+c3PHa4bHuwsjMLCc9aW1y3ghcJab8ehCXQ=
X-Gm-Gg: AYBFou1DSj5AKMz+zjY0iNANCSK8c9rt/0HgzKrfuhHdn4zmo4fx28LJr7gUGvmBAAr
	BvBBKMW90pKriJdsKpscqD7cz5U8EmzqlK2WTjT63hgQTPrqn4btLvuSHaLA/bcUreuK2neTQLi
	9wfmEvBBkntXzr2rSBBiSYfwD5y7wTUA2a3TetTFfF70btzSwG63LMd5a6a33dFkY0ls+WpzoMY
	NQCZDidn5ruYCp744yyylVtx2spekmZlNjn4HS94cbMc4F7ZAKuPJA/tyIsLWEOhPv+24cRNo+I
	I9EhTlr0faCHCIyQgoqZ5woCxmOZSHbcDIDKJiyVlIrjlMONBn336ToiSfR+HlQ3oZKbPQF3HBr
	IKzcGnbN0IbylNHZP+Zo21qbYCp40953dXbj89xy8RYq4KvZy/riKKSyvHTB2nw==
X-Received: by 2002:a05:620a:4890:b0:93e:90e0:d2f2 with SMTP id af79cd13be357-9442175c04amr1361357985a.41.1793564662432;
        Sun, 01 Nov 2026 12:24:22 -0800 (PST)
X-Received: by 2002:a05:620a:4890:b0:93e:90e0:d2f2 with SMTP id af79cd13be357-9442175c04amr1361355385a.41.1793564661948;
        Sun, 01 Nov 2026 12:24:21 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba4ac6sm16796675f8f.52.2026.11.01.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:24:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 3/3] soc: qcom: smp2p: Fix possible out-of-bounds read with too many inbound entries
Date: Sun,  1 Nov 2026 21:24:07 +0100
Message-ID: <20261101202404.156522-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101202404.156522-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261101202404.156522-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=fTYjwHjyqPhR6jVQmsSR64EDEvlEpuBr8t0tO7jmykk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq55/mIDCEOQQpl+b+weT5ffrMZADqls8l/iXZm
 RVxFU2teS+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauef5gAKCRDBN2bmhouD
 18MJD/wIiVBtf4dpsps5I/axn1Yrlexu5fSOOEH0v1WTyjZuu9XgWPE6H+QboG5McudTq3EKShR
 4glETnPDJVYK4XPm/ZEtI5bOVcxy/Zekvv1+nyi6Qjlk3KPGq3Kc+JhnpQYigswlKgzaNZWbozF
 IReO5o4r1JZ60DDAG7t1zX63QJlM9t8u4Sb0XThyK0odt2XijGiY3anNQG1/DSS9LAjiosxtGW0
 dcWdiJLLk+sxb6KoNpm47nyhEFJtbwvby4IF1T4HyCKTInxPQ8WWo/s8oeFe0v2HySjGe5LfuG/
 ZHGETrQZaOA19D975sPm3kPeRs7Ikr+Xcw45WOqMHxrkiRuV4JUQ8MqNsq95Xmwzn7oEPlu8KkG
 X1R4bM/K9BeMpAh72Bji01u/0KeNFT2kq7Gps59MP15XPWRBdxiQ9YzzZslxial+CjvoXsG36OD
 WAB8lLGmEwu55JI6jMQ7wVyNYDMyKoeO+zbBiPJdisROw5QSBoH3W+DrEKlBzAUJUl5BmtE7va0
 AeTWne9vsy1TXD6aUX9riDCIxVN8HJGVs9tgIWG0O5+451nnOeugKTRdFknicMP8bUfrAUlM+fS
 y5LI+L41sQ+BtTst4K8tXSDapVoh9FYy00VpzEKhCUSBfjJ9qHqtE0tJwxk7EMdxYgybj1Y88xL qI24j2QZ2T5xWcg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4MSBTYWx0ZWRfX0i2xSh+sPSRE
 nvKh9wYlCKbMTPCoAc1yLMalKXuDsWDfANcopshDZdHizFsFh07KJlLpIHE4o6EosXw5ufOwpVy
 R3igFWD9DTjUOrpNBwK2L7KmadiQw+g=
X-Proofpoint-GUID: xMBTSCjFX2IrjtroIz9EAcdEbDltOZKQ
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae79ff7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Xix-rBOErL6eV1CkEnYA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: xMBTSCjFX2IrjtroIz9EAcdEbDltOZKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4MSBTYWx0ZWRfXwXC/J197pIct
 fSglDBf+TojCRZavSRi9iklTwEOVeGB8p1Bm9p3QWxqK1Q3DWQ86R/duTcxmgh7wOqvZEb991Nd
 KwgBKio5vIGjIAWMAE91AVs9Epkpv7eVWD/b09fX3usK3/r0Ek4E6od7Pqo1k8fSgRAJgr4bBrQ
 WPmhabuWapxDynYBgXlGqFQZLxDbYCDo/uYqPE0jyweXdHjSyT7/8lzGCrnsaKixRI2yMoz7Oq2
 PXxCAiLwJCEvT/zj8DXdnqXfBF14zdGCPkoAaQnnZmc2bwGDYz+6aQd7WJSp396IWI9yhGgRpi3
 dkpXNhXLM2eEW3C24+jlICL+/KSqVpCnYAv5A06trSlnNRGk5nxTdARJgZieyg6GJBUfxDjfu4k
 Eicrw7P/mNfxspct0+H70DX7p0HCGWR9Fxp/Yw/Tsi3aDpxFF/JYMLvASqi8uTM6kD1E/QR+1nf
 vViELKTKA38qkmQCDqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010081

The inbound SMEM item is populated by the remote processor, so its
contents, including number of entries, should be validated by the
kernel.  Number of inbound entries is directly used when iterating over
inbound data structure, so if it is higher than actual size of data,
kernel would read memory out-of-bounds.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-b79427c9-5d22-4b48-8ee7-1d7808101e52
Fixes: 8a9a7b9d14c2 ("soc: qcom: smp2p: Add irqchip state support")
Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/soc/qcom/smp2p.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 784a164cf367..ff7c91645712 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -252,6 +252,21 @@ static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
 	return in->version;
 }
 
+static unsigned int qcom_smp2p_in_valid_entries(struct qcom_smp2p *smp2p)
+{
+	unsigned int valid_entries = smp2p->in->valid_entries;
+
+	/* Remote side controls the value, so do not trust it */
+	if (valid_entries > SMP2P_MAX_ENTRY) {
+		dev_err_ratelimited(smp2p->dev,
+				    "too many inbound entries: %u\n",
+				    valid_entries);
+		return SMP2P_MAX_ENTRY;
+	}
+
+	return valid_entries;
+}
+
 static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
 {
 	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
@@ -259,6 +274,7 @@ static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
 	char buf[SMP2P_MAX_ENTRY_NAME];
 	struct smp2p_smem_item *in;
 	struct smp2p_entry *entry;
+	unsigned int valid_entries;
 	size_t size;
 	int i;
 
@@ -272,7 +288,8 @@ static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
 	if (in->version == 0)
 		return;
 
-	for (i = smp2p->valid_entries; i < in->valid_entries; i++) {
+	valid_entries = qcom_smp2p_in_valid_entries(smp2p);
+	for (i = smp2p->valid_entries; i < valid_entries; i++) {
 		list_for_each_entry(entry, &smp2p->inbound, node) {
 			memcpy(buf, in->entries[i].name, sizeof(buf));
 			if (!strcmp(buf, entry->name)) {
@@ -292,13 +309,15 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 	int irq_pin;
 	u32 status;
 	char buf[SMP2P_MAX_ENTRY_NAME];
+	unsigned int valid_entries;
 	u32 val;
 	int i;
 
 	in = smp2p->in;
 
 	/* Match newly created entries */
-	for (i = smp2p->valid_entries; i < in->valid_entries; i++) {
+	valid_entries = qcom_smp2p_in_valid_entries(smp2p);
+	for (i = smp2p->valid_entries; i < valid_entries; i++) {
 		list_for_each_entry(entry, &smp2p->inbound, node) {
 			memcpy(buf, in->entries[i].name, sizeof(buf));
 			if (!strcmp(buf, entry->name)) {
-- 
2.53.0

