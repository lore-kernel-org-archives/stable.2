Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304695;
	b=psrBt6FSFEQUuL8UTZeBjilb0V1wSgWqxdSpLjKDF/lhiPUWqHNX9+1GrKju7W3E4oWU
	 eM2dN8HbDnoZ9dkjBhdztOdS/cnzhTr7ZzZIrw3/t6QjGo9CoeYN01vGeE4eEYcZDkBKc
	 5Ukh3q9LDyguOXXIs5xPTR6/NmF4lMrRj1D1f8eF3wqHA9NhVVu4k1pVUBTOIjN07uw35
	 U2SpYYb9LWDhZ+tdngOzb5UOwuSBoyUgOa7OHVfhdMM7CUntLfXUuHqq5x9c0OH3tz1kr
	 GW6e7UMIu8JYzVNGBXw1ew1ddx0kJrXrHPpYbf5WwejvYf9eQXkXOomTno4c92lxqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304695;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=st+FkmjgxRkO2p5uixOrBUL2Qow9wwEX9/ybZqtET0c=;
	b=CjUpdrArOmJnehhx/ZG5avp8ePZlM/uP8GwrVzH0MSJb0/Qwbtbl0c4J8ckfspRBrbmn
	 TzBRLLslQZqJXxqVy1A+YC7D4R/tyqLLR47pBju3J+/U2bmBkiXr3Kgc1ECMv9TzylVN/
	 /v/WIHyO3spzZBvWvZOzoCi2EZugqcbJksIZA2w3wwMuXSYoa8d0otxF1QFg8OFCOJUwR
	 uUxJSL05wxG4i7etiTzCAeE3+mDra33qJ3q3SruvDjK1OU+0ezXig8i0aFkxxKH9zNpY9
	 qhrHXHLwFMqKc0ctRLK7hz+WNlamlVpz7YJ7mdcAEuYyKOo/fhSSoyyqx0ELSqKfh+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RaHFHGUn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mhs05U7T;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBEB60A2613
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CBEB60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RaHFHGUn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mhs05U7T
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8Z7rp3849699
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=st+FkmjgxRkO2p5uixOrBU
	L2Qow9wwEX9/ybZqtET0c=; b=RaHFHGUn5JcunHYUUobWtAI3ki0W6U5NK0DwIm
	0MI0WtYdI/A5FEwVWqOHRMBT/xsdu+r2z12mlZ2WvzzXjMShZ14Cryd0kEj0pgZn
	eRkUhEbrHJfd1YvXYZyQxHiNaA+d6HKgofBS3P5eoEv2DiB599+K9Qq/gadW7Zzs
	9ccAT9ZTLYPh8sYTNBoS2A+12rpMxUk2jU8HpnjYzuHelRfHIsIT/VVfHMOXnuUz
	zYrSrsTsNfUvnYwhiuGWLYnctuQh68t3307hEnsgguttJMtm0wahzX7L1bqsJQDj
	lzBbmMSozRDLVZ5A1IkI5rAuwUNQBJ+oT6I3f4OdQPOphEbw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwga09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so1792120c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794304693; x=1794909493; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=st+FkmjgxRkO2p5uixOrBUL2Qow9wwEX9/ybZqtET0c=;
        b=Mhs05U7TVFnffqRWKGhCr4j8nfECnDRZ0hXvEpSiooyuVm56xL9AtoxV57E7wdZW4i
         rUqJVqO1s5Q0oxUePUHF/pryuCkvoTuBeBY9WEs2VWeQT6al95+5Zo4jbr9NlTok7AjM
         8G0hOHHN24PEiGQPkSp4NVpI35levKn/t+VPtqGe/l8qrgv85pWlxUxmnqr/l0HGZgfR
         ciYLY/0MoWaVDygt48sFJqM44cc5cy+BrknIYryoZTw0yMfK8LLCIzcfvrQuzF3ltuCX
         ebisP8YDNj3G79YU1HLi39Sgjm7zSn2IuSPV9uXmcisOPovs9FLUKRPV1CXVCvBGXM+t
         mKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304693; x=1794909493;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=st+FkmjgxRkO2p5uixOrBUL2Qow9wwEX9/ybZqtET0c=;
        b=tpXV3OrswEUTLDHv6etc1n7YDAUn6IwEMDOEKYbQXFGqso5B1asi7AFAwYhETIZr4p
         IrTEq/Z0aRMTLH+3qcD/dNzk0gaTnsvmfpcpb/dugRgC0TPFui607vnQzmzFEB8DRYr+
         n4jPKvKsHR2iF2nM++Qt7OasMk9uYFUhqLQPDUtn4FXfwYRX50+8gWezhJX1ReKlGWLU
         DE5B6jiqiUTuzKtZbH7Pjd0ABIJ/rXnNz+yEK9mTb1KxMlzqvBx/16uQPGWY5AnaYvMv
         Qu4z/qV39ZSRKsHoE9fhV767SYiGdNvFz8PvisK/ZF0qNiM7XWRmNHuWvbEQ/I/zMuIB
         HP9A==
X-Forwarded-Encrypted: i=1; AL+hErENj1KD23DgLKehPAKWHmOoWEbLrkrcb/exk4rps/fnQpEqhZd3TArz0q4f23NKsGxFnOcfDnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s7zXFgeJkVHTmUKg0QPunvkfkwtUMJSBptsB6TpgwgJzYO6Ee
	ygSQpe5yHRx8lx1HuQKRDmlqB+Td39agBfXCDA3KZYmgUxuHR6pyImViRKR7nxEQrJufmifFx0e
	k7AQVr8GwLC7m96Nlc3f1fA+6TPYnpZQc0LJg8Sx3kAMzcHgxtFlqwuV3IPs=
X-Gm-Gg: AYBFou38IzAxrBC9zg9FRxOOBuLiPFhYrdddFCnZkpRUBATYmPu2o7LsWS2sDvgGY1k
	Jn5M0ykdXMGahweoJje/Nm4qFNfq6VHQ2i2lVyaEcv+equO4ikylfMNRe/gKJ7V8O4MKXzo9U49
	AlYgIm4Hp51AJaNQbRtipQududZDSNSmSfa8ENBiKhr5hxB2bPSuOOK8+RnZ6h3metVlzW3T6cH
	++WtE6RX2sRCj4F9ZoQpaDMzb/mSpi98tqmEBtljcYiTzcBidsHVjkh903E7ujvwnupgGeKpm4t
	d3u1fK6/emqC1UN9yFmMTy/EJltZaXZi+5OEwrpqY8b1Cb0jLVtrqy9/qaxqyqypUjL5xCce1vC
	BDmH9qTDKLAwBSvgTDb/ARqcAQL9Kqw5HzF/i9ZtgbfUCP0xS829dFncoqzxNlQRovyjDTixqpu
	hGU1EFwA==
X-Received: by 2002:a05:7022:f8a:b0:1a9:f97a:34d with SMTP id a92af1059eb24-1b3b5fccfa3mr4008473c88.13.1794304693076;
        Tue, 10 Nov 2026 01:58:13 -0800 (PST)
X-Received: by 2002:a05:7022:f8a:b0:1a9:f97a:34d with SMTP id a92af1059eb24-1b3b5fccfa3mr4008418c88.13.1794304692520;
        Tue, 10 Nov 2026 01:58:12 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm7333141c88.7.2026.11.10.01.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:58:12 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v2 0/3] media: iris: Fix issues exposed during decoder seek
Date: Tue, 10 Nov 2026 15:27:12 +0530
Message-Id: <20261110-fix_dec_seek-v2-0-210d8c4fc31b@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAHjq8moC/3WNQQ6CMBBFr0JmbUlbBIMr7mEIgXYqVaHagUZDu
 LsF124mefn/v1mA0FskOCcLeAyWrBsjyEMCqm/HKzKrI4PkshA8E8zYd6NRNYR4Z9K0pcyLrDu
 WOcTJ02PMd92l/jHN3Q3VtDm2Rm9pcv6z/wti6/1RB8E4Uwa14UoWJ8TKEaWvuX0oNwxpPFCv6
 /oFlu3qs8EAAAA=
X-Change-ID: 20261031-fix_dec_seek-2fa92563b495
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794304687; l=1413;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=OoTEOWQbdE3NB0Daasfn0CVEElbzqxziQTEV4sVvvLk=;
 b=g/hV9z9s2R8N3SVEnJu74ymiGkSDFaugKOJVWe6P9etdbWT85UnQ5WMFuiHquXDkIevC8lWdG
 oiww5YXr4oECgEGH45EtFxB5CLSteZYvc/b5XnBYT5rdcW2ED4SzDhs
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: bQUY0XV2EI0iREfebJ4Q4cnN0Dxk-5O_
X-Proofpoint-ORIG-GUID: bQUY0XV2EI0iREfebJ4Q4cnN0Dxk-5O_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX1nFLW6RcFI5i
 avQ8eeZKPycFr7FbYoij9E6BL3vzhwC4HKD+iE1Kke2VfjO/uNe6MjVq7SR9gOpSMl1cqPOV5ea
 LWvohoJDXnuD49BpDXYdHlsbq0w0afw=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af2eab5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=dW6R3hR6YbmKee4CdVsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX1umJSxY6n2bW
 DO8twCY6L2nDIh5Tf1XAoDaZWAkZmgLPOBRrJhkGdT3pzTXqAU7Tz8qeg0clmt2Hp9NSYiMSfpF
 DL4hyokz9vFObml0uWYZJcJUZL6WU3Ks/dG4HxpTTeN4NmNN5fWJ0pGHBvos21bIesoASLgasTQ
 ZIxiXgESVkpo5E43exnP0dbc5h+6RLBvcVZIDDfIUWhliLLEGJGN3txkePYHLPuFvgkWuUPUxTf
 DpsOey3Gvp95yci7EgPnD1v8rrk/Ykce3BhYBbNP43v0ut+rHor8duLxbX+EKagnT8VWyoNJMZn
 tMlQK/e657JhzGnu4UKPMbcE5uMA0LfJ/m2cAPr40yBp3ScRQBOLoZu3v8/GauoAZ3lQs7rkplZ
 z2ucHPubW9EhftfGks8OZhG7nUVrBUbuq8GnPRcpLZSuU/fj9OjsfR8xnL3fi7dW16xupMCUitd
 bN3Z+Zmh/e3TOvMtOaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100039

Several issues were identified while investigating decoder seek
failures.

A seek could trigger redundant port settings change events, incorrect
buffer requirements for VP9 streams, and codec configuration being
overwritten. Together these issues resulted in spurious resolution
change notifications, firmware buffer count errors, and seek failures.

This series fixes the issues observed during decoder seek operations.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v2:
- Dropped the TIER_AV1 cap instead of removing the set callbacks. 
- Link to v1: https://patch.msgid.link/20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com

---
Vishnu Reddy (3):
      media: iris: Skip redundant decoder input config params
      media: iris: Skip redundant HFI_PROP_TIER updates
      media: iris: Use firmware reported count for output buffers

 drivers/media/platform/qcom/iris/iris_hfi_gen2.c         | 10 ----------
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c |  8 ++++++--
 drivers/media/platform/qcom/iris/iris_platform_common.h  |  1 -
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c       | 10 ++--------
 4 files changed, 8 insertions(+), 21 deletions(-)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261031-fix_dec_seek-2fa92563b495

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

