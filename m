Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4542A160
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440220; cv=none; b=JBpYbrBi9G14iORB3YGd6pfzLe/0UPS+RjhOacVpQCYB5PUd/7hwRDWdXOhx6XhvIYLL+Z3u0P09fa8kYQm5NGaZd11gRU/DRXDtn2M6agpdR7uFXOew8WE23uko0IBJsCDWqC4EgeLfg6TztPbx8j4h1gCP7Lk+gp7ewSwOhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440220; c=relaxed/simple;
	bh=Dja56rSsJWymUw/Omdg2HDuTOFhSjr88PK7rUZ7ZjLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Auaj5Cs7wglB4Em4RrspeBuR4NvK91iSESc4EtUPiBNNh3QojfTmKT5odATTVTLr4pKnDanu6/AxoUoon0zMN8bZK+fxNJv4Pp0v9f3LchaGooXR5sy8xQnNmraI5Rc06XaqsPXHDEj+KrdwDnbz/vA/h+w/K0dpZrfvKZzfT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=clmgbVx7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/YNMxuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="clmgbVx7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/YNMxuN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7NhoV3008741
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0E2fjjl2z413AgzHaMxdBXeMeM9rA+DTDDWPItpGYo=; b=clmgbVx7554OB8pc
	G/Eqn5PlU2sklUehPIBBslc18mUqbknhcJKWwf1j2GEERzez4dCLE8g3ydZYosle
	Z4O8WtSuUT/HoOVPgDnewRUKzY1ITvlH5p00TuSaLJXZyJlqhMYVAe3HlRHzDbHr
	Hitc7/z6l9AXHTT1kxJMSeUWM+4v2eg3j/CnmNHIai170KVhMLN/J2/plEV1b242
	We1cEbXCMuQ/s4FqPyFc+bytUgF9pkJoLw4DI/yK5ElzeApRE5bFRuM17NUWwCZD
	O7kvkFT0yfln8t2kHgiJ91WjyJHd0Kq4nUwGWL0l0KUBzYg5zunCDsM2q2mwqymQ
	oSci4w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtkda7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:23:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4447319a91.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786440217; x=1787045017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0E2fjjl2z413AgzHaMxdBXeMeM9rA+DTDDWPItpGYo=;
        b=A/YNMxuNtFfz5Xn2EeC8OgTU22eLNuPMHQ83FDvQWiOv5AzYJeaJP1UtgfscqrrmpU
         dDaf+utq7Neq1OORHL+XAYTgOgsQf8yq/cCKo35YmElkb+cST4jBwFI+G3jS2q6kVd9x
         ll1BNT2t+5/myKOu3fH0gY2Sc0Lm/+YlGPKfDEMFaO2EadLHF9/5JKVkUNRFHQhp6oVe
         iD/sg3wShMo2C78wrZevyijEtuRlFBxExaC+/7diEDZhe4hWZdxLVFgD7uWP+3gKo92Q
         Jz4NZlo3CKqewSmko2vOyqHZthMi3pXbutaBVCvkO5+3gcXEB9OpjSvE6X++QK6uU8i9
         fWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440217; x=1787045017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0E2fjjl2z413AgzHaMxdBXeMeM9rA+DTDDWPItpGYo=;
        b=Qp9evuCze3nxos1M2MHtHYbCQisHGAZei87naVFyPm/HCY9LTT7Jk1pqW++JGT9cmP
         REvVM1L3X6LHaKFJoN/1a2H0RktDhIl51WMkedtUEWLp1i7Hricz7MKIitp+s5VuTWnF
         pRcalpZ+aht+kKBMjdqzgmWlD00jL4a4fal8KtEALa8Tz35lMosMvX+JltgbVnYECIPB
         BpliwxQPY+rZEbThEF0IWSRMZRJA7GmNGf58/GVgDeytQ+kmWO7C1lAMPsYpVtVTMT4y
         xPSUjMOZe9lwGlNU7tACIP1iZX4CwbItFZ7YDTs7Ipx/W3ibCKHNOlkDETahCswmnGOj
         3R6w==
X-Forwarded-Encrypted: i=1; AHgh+RrD9M+EcgfWLQNajwmclz5dGdTeSIYgeB5P0RcPAJe5/NjpIThtTTR38yteft78Wt5Dibe6L40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZq2mx6Mnrz55k+IjxTAShPoDFmvuyGpjQ//oLFXCuRVE4LijD
	droOXA75PolWANBnIw9ZzcfPdmalS3x/frMvhAzKEEhAAtDWPwAQRH4U8s0symfDtpAxMzyKkfc
	l0w4IcrzFplA7DRW1jsU3JZow6gJwvaabOcm3597vKK5oDm+11Fz/IzvZC04=
X-Gm-Gg: AR+sD12PBKTUV+nzr8ghuxd/fNFseN3vRVbPKGhv707Hw0094q1tSG975nyHeQSpkXe
	KW9LOomIfaQsXUjF2lEv4mHj+WE/yyLMuGFLB0VaOdnw4YiIg//p0PSIRcYJyt7IHLuwKkazj8w
	y9364pUrxdy90zd2aj+8ZiTzwpVIbQGZs5QBf/LdH2XPq9eccddW7HgOXBgjwFG/ntjnoZLFKhc
	431uS547oGzyAobJ6J6fvUIjLSdxUELbk8AhgiGHGQI227h03EAeUWs4kRfSvZegd19MewSOKmT
	bqyk9IIfSpNXAxDUDdTPclYk8LBMGRYQ/lBiLUxzL52yQwywjFxlfCSinHTKi5k9EL4P7jFKxeR
	aLWp+98XOlfzEJ69nKJRVCJzQebshwzfeQJ7WJln+HNT+YOHOLhDk6LGcOhKiFqG345cblTokqW
	qNRdurBf9Xb1U2Qgvaj0fr1V94ydavsD6E3yo=
X-Received: by 2002:a17:90b:5486:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-392ec628202mr2004751a91.15.1786440217351;
        Tue, 11 Aug 2026 02:23:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5486:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-392ec628202mr2004717a91.15.1786440216887;
        Tue, 11 Aug 2026 02:23:36 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14120447d8esm3385004c88.14.2026.08.11.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:23:36 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 14:53:16 +0530
Subject: [PATCH 1/2] i2c: qcom-geni: update frequency table to fix timing
 parameters
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NyBTYWx0ZWRfXwOwgyvDeRc+h
 kPYstmjy8mWHU15mTA5Lm86+jRSS0dwxaanRH1wIL8kVRxsAsGDn36EljEgITriH3BP40CZyS0w
 OQiKq7OCPzgvTO/ckuI+rzm+9FAIbK4oi/GG1KtO6WUtFeDcFeJzZEDzHz14z166vwvUSB1S+3a
 +Akwze97FE3aQPnEhkUojMepYwgpfvcjdb6WYIujBKm/TuSA7vMd2eJf3M+QZ/qcgCtcPgdCCSn
 4SjTuBQ1LsfeFX/ehl5V5atHTYxeTEdK78KWgxF5K+twlQdbLk8XTrMPPzfPNMfV1gUwbR5Wmfq
 6HQ3R7RYpTyYRjPpzFKSNShqrq3DXiFkPZG28dB8smKYSslOj98BIfdtinCwnf5jabLJ1ic804R
 iXOkJpwHbwP7Mp3xqzsvdehtvyI7JVWkkEYSSOk4IKi1fJmRG5P5RNJxmJVsmXPqz1+EiTL8K1Z
 8Pke9iWTkERpqQ9eEdg==
X-Proofpoint-ORIG-GUID: 1JOdyblwW4fHY9XPlNQ2lzjo3ZuDYTVf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NyBTYWx0ZWRfX7T0IdFtoqV6G
 4og2Jtqqd1NbHzS972RjpQvwjttUPkmLuPY7D9ipsOFxO5mS/7yYER9GYI6Emida6eAz8UVJ304
 zwmLVkCFu1kMqrq7pAcKkZt3JSYkFHg=
X-Proofpoint-GUID: 1JOdyblwW4fHY9XPlNQ2lzjo3ZuDYTVf
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7aea1a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GyXxqrRC-9zytgsE6zAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110077

In IPQ5424, to meet the setup and hold timing requirements in the
standard mode, update the frequency table with the values recommended by
HW design team.

Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.

Cc: <stable@vger.kernel.org>
Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..00013b41a6f5 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -188,8 +188,8 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
 
 /* source_clock = 32 MHz */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
-	{ I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38 },
-	{ I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19 },
+	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
+	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
 	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
 	{}
 };

-- 
2.34.1

