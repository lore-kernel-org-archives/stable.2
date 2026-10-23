Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746227;
	b=gJ9E/x3RHHE8UjQDE6urWS35jLZtr/SZdoBewz031XHmXWaObMhU+TLa7NNbA3dELTdu
	 95X0QxaEr4t5qimER1nG/5rIAKAN5Pj1LOvS/29DcMhPG7WaEdjuj0weRDQSXeBZuP+In
	 iUP1o1+rguAv8RB33XIkZJI91bcwDa5ofLGXRrxWRN5xWq0UlvOapCoChdiGA6FFlcWsw
	 EmsEhEr0w5gU5GVgLIesQMrIh9cb1pom4u/EFOMEwC6mK3Y8d+4SMryauW2/HbhKtoLIn
	 D/d7UdD/FPPOYxTgTyWl4jBAG5v4V68USxnFQmWPTZcLugijAJDxooORMnAIIU789Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746227;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
	b=FEtXck5Vxk1mIfYXVq0r0EA9dSanGBRfJVKVYKZjpqHHCg59SUVepYxjODl+hlxAtCAf
	 hNMC+F+vJlWsXFeDanyjDk7i6qADDndQQO2E8CoozASIO/o4euLrjWd4iVjsJ99B9DRpl
	 0XKyNYPp/uGuJnfGOHl+QIVWZlPJjniOeSYyVULi32pF1t1dn3ED7y17xeDYovCNUQO0n
	 WcdxM1Np+/niu0oILOeNy8fDn2IwxAJVw7r8JiOauM8cNUuLhm4QqyDC/l9pIq2Iyuctp
	 OZKNfAROjsj6gAFqG7V5GGBsIhYDwWvl4EMoGmwLYNIUZQVCkS+757h8Smb9wJLBcmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jp2rz4zD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Clb+co5X;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E3606A33D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829E3606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jp2rz4zD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Clb+co5X
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9Nr2067839
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NpvUnsLAKwd
	/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=; b=jp2rz4zD7ONXgwQ4HAdOHz0I/UU
	XP7XVbP1vv1aZ/jk9kPG2LRl2DOtEHvLzxCS1U0Q6CAxyZ2dXt5vZ2eIzP9u4Igp
	fd3rPPbUmmeGJSUBSGomYy60LMt4x92hwgklMnojYjrHHpVkqZ8JHEyls3SZ0DMH
	FO5p160zcqI057JZbOpt3DtJ/u5e+uDl4acJjieg/4h4XNfeGQb2wSMxCXkDhnUH
	b2Ru27Hy3Zmx+kWZbWRTti5Of8UZzxtNykBW2HgBgzlBjFyi5xNGZGti3YLE692W
	WMkwrqe/PMN7d1WKcen3a85hUI7CPlYxoot3Iu1I3q2I7DLIes4EV3Ho7sA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw3c5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd60a365440so460378a12.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746224; x=1793351024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
        b=Clb+co5XQeyLSh+7K3BbZ7x7MDX8+PtdjrZWVbDyFnY4wOvhHY+UOmtexx3js7KO4W
         Qhe+LlDTj/Ocq3g9DexsZisqtxhM+pAm/VTO28cGJpVec9t4+ctzQ0j6h39KhBj1I/Fy
         lhOtaUdYDujJ3X/j0woenqMc0fN9Sw+W6cI7uOqgYHeqbSeU+koGgqPkiK+UzkrE8916
         2cUUid4tMMZaqPQkptcoXSrwg1AzsWn+qoIYK7rU4sMo03AQq3XkmAfa2ynUl0xVGOn1
         mVKsoezOLta4PizO8FAqvbkljG3sbp3b3yVmkvcLOmB4i9AN3HR2uyUg2UHoMY7cflnE
         qJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746224; x=1793351024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
        b=pvtBDqYH3gAqkF88E3H9jsymeU+tA0jM1yMeyaTg9LdGdw0CV3/grGuceWbhJkzCoD
         h8Mjxl4xfCyGvdvx9XQaeS7k+2IEw8LkJL8aqZOj623v3zyAAR7l+gBLeWKyXx2E+01M
         JIv9N/tV5ASI7tyaXwlkSWfIh9R1jSAo4XEVgy3xnkNcT9MCK6ybnCrxIJCK8pgJMupt
         13tcYex2G9G5s0qOfFeg2Fw5VHkXiGTuPKeaJAwEjigixE8P5+3UwZFb9J4ZEyBBTDeV
         dh/feq5bphxUVTPAusk8RTbjkZ84fH6yZG6V2nEBg+zFgATY4CIq+Au2/WCAatHFd872
         6Kvg==
X-Forwarded-Encrypted: i=1; AKwUvBwxAV8uH4FTqvGUCWc9wbd0WypVXz1K6pW0vloyfhKHQbQ4sum4eK9UcmgNJevPzZX39w8tLRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL08Xi0L+9SD7dp7JRjseJ/4pQCvcc3g7wIshFzmQXiwlRyXO7X
	GWTNPUH/njj+XxoFQ9JhwSjWYUqTJHo5r1FFWyv9H2iW0K2v0TBRNczQ84WxcGfElmPG9FhJIGW
	Olgbzp5TZ0fge5fR4UkOxUwgzx6/uvB0R90AWzxWpcNJZfYAnwDExWs0AxHg=
X-Gm-Gg: AYBFou3ca8t6KCRdUs9BjM4027/RYUw9CdfwrEe0uwJrwwBLPkejvqlZF9upb8W98bC
	Eh/CkH2OxYZRwJGh4fmTwWkPqxs18HSz+9WNwDjXsmhbh+SLwIOCDG+daFRHlnYBlkNBb/xPI4+
	iInbJ+bivtROZuwuGUpSvqz+zL73E44b+W0kwzRhaid3LN6dJ+A3Nnerw0HlTDTfEjzW6x8jGOv
	n2MbFy+ZsLIgYoyMZu24qAlGbSmzQHgV54TOxZO6S6deN95TdOZffXpx1gl3SB4QWC6cm8xn/ms
	Asi6EXWsE0SHRIQIdi0FPiftfWIryZFA/zVOVMFXNLoxCKzwPQXO5CY3cwurW6Lgf/j7TWTVWh9
	4CibpOLAIyUPKxmYIZSkK9iFsd5S9KlZdgw==
X-Received: by 2002:a05:6a21:4989:b0:3e0:dc12:8908 with SMTP id adf61e73a8af0-3e376748cd0mr1004545637.81.1792746224501;
        Fri, 23 Oct 2026 02:03:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:4989:b0:3e0:dc12:8908 with SMTP id adf61e73a8af0-3e376748cd0mr1004523637.81.1792746223965;
        Fri, 23 Oct 2026 02:03:43 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:03:43 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 14:33:07 +0530
Message-Id: <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-GUID: Mm2PRzex8L7r9_TgAGZD9at8VhHfxJ9i
X-Proofpoint-ORIG-GUID: Mm2PRzex8L7r9_TgAGZD9at8VhHfxJ9i
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb22f1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=E36itTYgs6eEPh_MiKgA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXx1EvmOHw5W7m
 vnmqi1UrzEv9dwq1Asxr6T7QUeVEu7EnO6hUW8xMT9vixeG/Jyl8YbQGAZpC3o3WAAkicd9Xl9U
 ze0TXVUsbdyFLvVRwvaIEGfaJJKN13s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXyZfPYRZbhkFC
 jxuaH8HK2StL6c0Zj4soiyAZ8YpfcLw91tDv8t7c0rMjfj15+tlKEOCdTEF1ZVmmLoen93fLxgE
 tb58FZIabHfvvKR6c1D6UyADPpr998Ox5/8/SlFIshI8McLPYk/Olo7Gg8e/dmO3IhhkFAOkZRS
 79d8o4ebOxAiBANB8Aub6Q3RutS8aAv7T0W0+g53C0fgQcDRQXesD068/7VrfJ55QLeOQ+euC8w
 2DJHpOdBn9n0aJZKIG6qZtThG0evER9d4P4LOMgvI9kvHG7bwEuSgj7wfFJaOFbSS49jNl6VXuo
 tZnBka/AcJ9FK9K76pepzO46g4ljfCv0bC+bnXeNFc6pzxmrs9IEK8QMii+VRmOM5qBA8+oR2VQ
 IJk2teIa8lOsQU6hKEOyXCPh6oppD3mA3TYmn771x4+4+uR2gBKEpZUmKRQWaR0eEUh0Jilz0cB
 kPqXixGoH8JI/omqwFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

Remove the compute-cb@9 nodes from sdm630 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index a41ba0da380b..721885455639 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2483,11 +2483,6 @@ compute-cb@8 {
 						iommus = <&lpass_smmu 8>;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&lpass_smmu 9>;
-					};
 				};
 			};
 		};
-- 
2.34.1

