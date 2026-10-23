Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746219;
	b=Wft56QxfYud9fzYfoHoKebDWiNZQywOUtswCpcr7Dr+v9Av3PggLQWLki3Yp9HhfLZr0
	 hw+Xmm5XefEmM3Pj8ubU2/rEPHgxqUGxsab2b1b7CRkRonMtYg/lPBWtVQ1eexzMmMGOU
	 bo5eEPMIjgOCSXuXn0hFH+3gDiwkaTRISDLLcpfAOtvpLO/FLmCSYeM/rz2Vq3IR2oPg1
	 cVY7xfVV84Fp3WJEoalajeHJkEIiQuFs6tQ92bZFMT8DxPc0aPY59FAI++vXP3QebOtv5
	 2fyL+tM3obrgfWbdwnTCYo4ewND2HIKetfTCTwNJvZvtmyE3187ETRr9g661Ve6mH/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746219;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
	b=hG4oE7PkV0tL4HYUJtDODk6kxrEeR04VWQH4uO2J8yysPiStCBogZjvMQ8JDBaJE47eO
	 pQAcT5D+OQT6Sc4U8o1F4f8KnbJaNi+VK36W4qcdhOH5rfAgKPG4HXnq+n6GWFdADJJvf
	 Z3XLHsjwzA3tN/lTN5v6hkhMMnK+mHl9zn0M17uxZ+4a7rFrPfoMQNhlRAarhTuHAUbdj
	 hCOKl+n2099D4mU98+Anxc7eQDpx5tPDwFQWYl1d82CpkcQZkXvNVuev0LcynpfC2Xygh
	 emrCNLTSifva6Byz/BSYotDC/qFDVzfrLej3jK07bAtj/za5NUaKC+U0103+YvqQfiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eEwgp8Dr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kxydvJHS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BB606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227BB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eEwgp8Dr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kxydvJHS
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FLbR3167756
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=A+8sjnjyCG/
	D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=; b=eEwgp8Drg+K8WQqaGVgHPFoYH7m
	ZelowxguDuOG10m6kMBEkuwf1fTuo3DJ2HCfMaWYxJzvm3fs3BpIvTHw8w91OAyZ
	CHS5i7cuf6KUCmEB3uwdR7N+xei4rlA8Qx1nTZwb0gPsDzNj+QqbBnaH1lyl/8xD
	44M5sbQN4LSSU818uZPd1ciynhIcNw1tF6caBwXgA09/zxJaeoNIgZ2OlUoQH/oy
	zQBLxsc+d8O0OR/0Pp5EJl34TrOC8kTcmYk9VUZ3X92cgx8uWexF/WFpZTPRstZC
	NYonkur4H1s3tMnmGOXxnXFiA3zArRbcnX56HyJ8jdp7Vj3hNoU4e/FVO8g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmpaudm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd66551e02cso762868a12.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746218; x=1793351018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
        b=kxydvJHS7jhtpcpH6LlHPMKpiXdUMo0oTBQb39UC1QgBFw1udHYcrBlQvLDPeojt7X
         2WqHZv+HVifMAlwFOPF2rRHeC9+eypn+pzAwpxgIeTviAJ66qQVIGOYoKnW79D2noDK7
         KqL5Sj0jr+9C2Zg5GI2kEw3BM2pu3ffuGya0ZlvRjy45DYPivszL2qOGaB8k2jqXID6F
         quNK91mk6dr4Huuy4VtSbbgcxjRu2GqvcLOW2PW7PJhAp1fEsh++50mlxGAVSDNRaHC/
         ip3RQLklvbzSjCnxTk6W/Wncr8QBro34n6Ynwjum4TtY9KLZVBtwl5AB+Zgu9u64NcnQ
         8jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746218; x=1793351018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
        b=lfsxXHzrpmlEidcxk3vi4RUEfLdKlmC60hdYTdaebtvNY3MXQ+S/s4YoFJEojOtSnZ
         twwE3wwi7Pu9ibMeRhySXngmB7CsbxsThW1zLCC5gWFaJFP+InSBPb6BxcgYgI14oSPK
         3zEl2AQNPOyj5EW3IQA6YtE1q3tam3EQPxrrwdL9YbnVpPWiTpohAUhk375e/GoETvob
         YbCQiS84ZNyoaRm7mFTpLtMlgvSqpunMcbRGEhZ7Lj8BL5NybZBBgaTLn5PaHyODRMrg
         hlfj1j4Y7wbGJ1XNFX6rh0k//L71XHztaaZ9sKe1lur9SYpibMREOL/yLYA6DPi2w+6B
         j0ww==
X-Forwarded-Encrypted: i=1; AKwUvBzx0j8j88EEt9YPZRsJB28ffMEa94yZa90DZqLPBYQ2RbRht99YtlHR/tAtU3qMMkVNR9t/3OE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLT+dXZs1rhmCuUbIsi8LcFCoda7ty37CoTsKMZsnGjx9xDYXyT
	1BuwrEbsPTmJlgVViQMQJZjAPZV8bRzlmGP7d6oi7XrDQOH7r5qAhKC9EAsuhry2tAl5nbUtvIf
	1GJlBCmb1G8ihjrZYLe3gBs+TKx81PbYTc2M7NSr3Vg2k2ZTPTXFtU1k/728=
X-Gm-Gg: AYBFou0+gLyXkdgP67oSw8ghiNipkaUq0ZGDoAxJg81+FQ073XZgRf8AeoioodJYObk
	d06Jpw/rOwOh4FuCu003dq94C+2zhfp0waBw746NrdHlSrKaL35Nb94h48w/bhtYgn32HsZCd3i
	Uq/M6iUssTGUxuM4ZOG3NR5/6bsnPxF0fiR/8408Fu5aCwkEyLKjkil3mbzv9cgYct5Ufn/+t/7
	+l4yVOyDUyvZlZN4bh3iKzs9uvcE3+oSKBuWdR1by6XEGIr3XWtcaVkFNvji6uaQuKkYtuBfimt
	ixRYbI0+4sXEJFUzALbxYFsUTcwNOSQzo/bxnBhD5AGpHvuCPZLVHoXStYv1khzCOP/YN/ZM2z7
	tvgcEtutuSIJ5qy0JbtUHefaP42C8qDaObA==
X-Received: by 2002:a05:6a20:a11a:b0:3e0:b937:883d with SMTP id adf61e73a8af0-3e3692274c5mr1250211637.25.1792746217672;
        Fri, 23 Oct 2026 02:03:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11a:b0:3e0:b937:883d with SMTP id adf61e73a8af0-3e3692274c5mr1250183637.25.1792746217241;
        Fri, 23 Oct 2026 02:03:37 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:03:36 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 14:33:06 +0530
Message-Id: <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX6VXi/PHXRhGI
 MisvNy7J/r3WWd1TiSSp5lE3JS3rbIStLoqKCIv1Inj8Q9Ifj86MypsqRfSweLhQgJS7j1iA3ee
 7Buc/qCnD4223Uc4HH3WyeE2rLxdmfk=
X-Proofpoint-GUID: AZvTM2e5VBYmL6IlBrwqI3l8qEkHF6lo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX0PJFvPTGzQDq
 BLUZ/l1y6sS7EvXqOHJldj66igX315aNOhHBt1OkXk8E0WoSC5kUALf9vcnI9EFt6oSd6NrRSoS
 +iIQrSpvZ8EsPmsgPQ8gb6FWjdQulolLvgIHA1pHHc4ynNkD/Yqvu04PzUp5qDH6XFQjA1w0cYy
 sQGROe6ytlfFi1G9olxkZwRmPAIqz9YrmU3q1zdP0Xy1KLkucrTDxFce7jxKbDTO7yhV4DSYSfn
 dOMQoHL0CFK9o4550epLXgWY6dhnls03G/9SYArxIS0bYXInXXJHhbkCYs0qe+b20U36TTpT8sm
 UiNNbN6l+XDUm79M2Kh3rovFRA7QMXXls+2bxGIxLjvZQhv4lChPeFDJR7VkHsCPOYzZ5w8EH6e
 LutiIsp2ph19+KTik2w3tG74oQprIbTyIDksELqdr6TPqJ017TfmnukyaLBdsS8n4h/EFV3k2jj
 xeZMJAN2EZ357/M7QVw==
X-Proofpoint-ORIG-GUID: AZvTM2e5VBYmL6IlBrwqI3l8qEkHF6lo
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adb22ea cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Bp0rkiFJIKxNgHgNeN4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

Remove the compute-cb@9 nodes from sdm660 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm660.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index 0fca9662c64a..723bffc99b67 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -386,12 +386,6 @@ compute-cb@8 {
 					iommus = <&cdsp_smmu 8>;
 				};
 
-				compute-cb@9 {
-					compatible = "qcom,fastrpc-compute-cb";
-					reg = <9>;
-					iommus = <&cdsp_smmu 9>;
-				};
-
 				compute-cb@10 {
 					compatible = "qcom,fastrpc-compute-cb";
 					reg = <10>;
-- 
2.34.1

