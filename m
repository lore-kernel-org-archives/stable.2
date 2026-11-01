Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564668;
	b=JAdC6um2deqPivMYxeZHB9BCSeMmvGunE+qJXg00jtJ2wDoQxNTQ343iIcsvos96mATK
	 dSdBDJ2xHRQYrgDz0kbI2zcjKxUwv80FVrSac1DHAWV/EDbCpvssRn6JZyIaFYuiXu2N2
	 ukQrri+aXSc5b8n3uu+4sIMb2XTkgjeYNwzARCNh/sqghDfpf6jFF8STZ/MNcVQaI7q+v
	 Gu7WJfDYg6fgFGJzQtsCVTDYNlUzKS6Ypf6OB8TfX5cDLxTvZzD3vTgvWj6xpxEe7t02t
	 PJcglKds30xh9pOVuIiiljqP/wEBsU3VoGRp5HuchZwkkIXR+4hdWS6WKwTmSIhWIHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564668;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BN36EzrJIxm0RpLbiUbzeJOidynJLSpvyB8uWqyAP7o=;
	b=oZvYPqW46+wrF65JGBSG/NeklOumT7J1ZTcTb/Yl8b5mE4Ej7NjcDfom4c+1ovKRotM2
	 k8PWPPUZNpDf3rvf5NpLJAQLpabuM/WzkBaDOR3kKfmg6JLeKTuGMuUWKgjqTNhMTvEQl
	 pg42UoK1/r8E3OUxNtqNTp+tt8Mc0qPm/7Zywo/P+qagxP3SzwwkYe7PZ0kG18D4yN0wF
	 Y9+rwUfDwmiyX4I+icIXl+LrFur5wdh59KrZohvbjO+c+/hlbEuQ8l1HRGsbVETdNyR7L
	 wyfw/LtuZzUN8bZJsCoCCFadDTjjdEQG/Vru2bKOD+2t9jJRnnmUlgOzvnHSHq1L5WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EPZoGfiG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R2afyjV1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A00606A32F
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A00606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EPZoGfiG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R2afyjV1
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1KK1Hj1808505
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 20:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BN36EzrJIxm
	0RpLbiUbzeJOidynJLSpvyB8uWqyAP7o=; b=EPZoGfiGKVuM5qwPwgq4MgM+XNI
	ofryv1Ef5/gFgFsG14n0C/7B4ae469OsjcgZjhPyH3V1vFjTp8IRmp2s2+xqVrBP
	REUifM2Jv0MtwLHMOOh8rajHciJTTWoa23Dduxhl5s395M/m4qaGETeEy7IF5Xrp
	rFHJsdEEEjudLH9Jn9hCyy8z6kNzHm/KqNayx+g8K1WBdVNaUYvhE9+c85qAJaRw
	Z9KTgVd9dvuqT4qBFv+0pLG/TYnEvloSZ9i/dKhZq5UhU/hCrWTbsPt7nFYcue9q
	1W6d4Dv7i8UFGUh8qRv1+rBbr4GoiSfv378jic8y2WntFAySKEkjA+pz4Jg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkmhby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 20:24:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so459570585a.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793564661; x=1794169461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BN36EzrJIxm0RpLbiUbzeJOidynJLSpvyB8uWqyAP7o=;
        b=R2afyjV118vIypOB8GcPNYDmCChBRYoQ6fdOSaagFffVE1bbM66CcjXpIfaqugZPTO
         CEnpR3/i6t/5eELCHFiZNNy/vvZyhM59bb/YlfEbVnwsFQNUsTc0uuBffKUv8OjFYZfd
         N6DeYX71X5Zm5Erm7QoUvp1V36+zQv3HiDQ6dwggP0OlUjWRWniiFG5brcdnQzNVfG0a
         Nq3IEObtb8w1PCbSF94zdRlpsMMKJJ7O6WtNfM5qGP+40gBcabUlDqVLZknlufkyWpWg
         6hvQ7x2fTgx4JwOdyfX9Z7boUWfv0wUD8YmPY8XnkssfHj8waeXWaYQLV/crMt76cgES
         tpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793564661; x=1794169461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BN36EzrJIxm0RpLbiUbzeJOidynJLSpvyB8uWqyAP7o=;
        b=ZoZ2xKJFXMEUjYxalFdbAWqPnw0EapZwK74DuBUoit8N7q/Oj6AQLxzAY3ShChtpvi
         HG4kKPkohJyuKKJl4c1qxnmhyNQ5FFvL/kfP0yGajQVUb+/KE8Qa0LzvtUndmLEFBXmW
         gfVlQ1RGtGDKO0CYYNLMKiT3ZmJeL2UPoP7GZp4PjWDgOb0PVQNe7HZjlE/JLJqRnaGr
         4Up9S23i0Mi9gQCf6Pe0iMf/qMUKoxheprA2eiK8abm7FGZsa9f7QH2aqBslpq50BeCN
         xq46ZUm7XDmTFc1rI5CsouXXXbuD8WH3zaOH2kxOY8GJanl6DwR3r3Nv4KlXjnmDGC7A
         oYgw==
X-Forwarded-Encrypted: i=1; AKwUvBwXnqI/isf60Km/C/u8Q+I0qMm5QzAsK1mlwvV2TmGc69Nqr84AF5NX+CVlYs5FFmDMdEXY0a0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHwysoBbg84Jv4/y0nkgWUJiPQX41q2jdTpHfFrE5GI8d0K99e
	7MxY4P7XByXMXxIrseGLRc8xWCQpCsld9qVHVrF+PCbPIsJ+pJOGOsz+WPagpR79HFogduin7GH
	LgWMcSBDQJ6mRJD/m3M1YIHHkLd2e431EcFwH1aAYBu+nb7hunXl6/Yn+kuI=
X-Gm-Gg: AYBFou0/JdGM5LAJxoo5A6t+MQdwPg6+O4F+pJPPH6Rxzs7kg6O1RMBJ9RCTzRT98A6
	0kbeVEbmdTT9HLit2Qu0582HPDjgUqnOfjtOh2PzR82Ilp35pCpiRP2vOviHIkdueUglqa012fl
	wFhlabiUf93AGR2pdYw3Dz5QgzAX6cRRDPOefvw9EKTay9FeY7tz2ugmie8ZRY64y1i4c2YvA30
	nSRjzk3YKqzzm6WORJKbZ/gIXMxhKTsG27RjeXBu9xDhgkCRkoDrTE3MOq19zhVGQON2jQTaBOb
	2DjehlSFugsINXLtOq1pK6RTUaYlHvm8Hu8r1zh7QpcU9icMOZUu12PI5usO+VMfSf//DoJYS1h
	lJCkNXkpljIaW2zopY804HX3m4qSgiOYTSFwx/ndErTg80PyIx5zq2hC5sbV0PQ==
X-Received: by 2002:a05:620a:2795:b0:93c:c538:2b23 with SMTP id af79cd13be357-9442156a038mr1314585285a.1.1793564660702;
        Sun, 01 Nov 2026 12:24:20 -0800 (PST)
X-Received: by 2002:a05:620a:2795:b0:93c:c538:2b23 with SMTP id af79cd13be357-9442156a038mr1314582885a.1.1793564660178;
        Sun, 01 Nov 2026 12:24:20 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba4ac6sm16796675f8f.52.2026.11.01.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:24:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/3] soc: qcom: smp2p: Fix out-of-bounds with incorrect DTB of too many outbound entries
Date: Sun,  1 Nov 2026 21:24:06 +0100
Message-ID: <20261101202404.156522-5-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=WdISjf2NXOI+jjWzEjpgNs4nXLCjUS3m6VKS68MzI8Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq55/lc6UBqMjQ2dRfBG+z7dddlgUqjDhQIF1n+
 g/0dEkWPeKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauef5QAKCRDBN2bmhouD
 11llD/47815t6bq0RYdIVHpfpCVLKTLjM3aKQbrfwNw/9OWtNZ0Tk//Tx9T4MQApA00RpDnMGLf
 4Xm1Do1vhQTUW/9CJBNJxCMVIDjqRsJxsm5eSjsVQOoslzF0VcE/uo/G9cPy9ghZrqW/dLv2vNq
 P3VfPljCDCR3XX5rvBh3mnx74vO0f6EayW4kKHGJgYQMCnSa4Oprz6WPo5NPf6KfN5YxoDA6/UE
 qJFtXavk81Kk3xGDJIs+K1Gz1/E08L2MScvZ1cveFCpt5+p/4AUP2R02Bw3ROPLb4r0J9ZGrruT
 WS6LP4UDRUsb2hrD4AvUocA0wNAkA2wlSDMMSZbJH+rZap3qHKp5OsP2bVl4n+s0if4bqMUrOgD
 eqvX3SrREAmB5Y+O+vPzlOm3WqeUqnA72GV5OHXmS9KKyM3+/wID3/jInLGKrHQ5l59aDxeWBok
 kSRe74E+N0e4q+b6cnelxL2SazNaZ4V1ICAE+S0r6L2Hh4/oKQFxFaPrnVD8hufPjEdhYCpi5li
 iQo0DESBWlzxtpWQ5mCGY5WGkw/BVUt4VOEZfdBzQGhfgorO15bkixIWCOH7Nj2DTzqcEwLN84z
 2AS9Nu3un0HgWRSYCXy8z7dscUrV4EFAWcylQKwY4mq05gfucP4zI2ZITlfoPZO74Lz9jqO4cTp 3XYRBfrlhDo+Z5w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y_cnkRL_TwwPhLgrHsVbLGOuXjNfKsMk
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae79ff5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lFa8o7j6PwDw3F3-yxEA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4MSBTYWx0ZWRfX/TDrOl/7vH0R
 67lQAajfCV9W1oDdQO6aHATfVO5kMFokv+pfG7xnJqx5lYWxxzZAF+iK7JOmB0KAvXNX/Op7xvo
 EenwRa2RvQKy/yYAgluBeGDUxBQR+28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4MSBTYWx0ZWRfX886uctK6fdiW
 uaaHAAcK+w7sedpRLBYrL/a7JXjUiyC4tdTsx+Nlp1ncHJ0E47BOfUs/Qy0gWE4fM/vl2l3v4pJ
 fukybgwm2TZzIiVVWW/O7dYOdolKrdFDyJobDjP0j7JqGmdqLKmqGZXUO+JwILdMj4tZ8pt8bz/
 U96a93nlQWnIPtajY9f6ZzmqaxNuLE+s1QyLpWq6VWP8LDOXvXZm8EnZ/xV6svRln1Y4Vqnd+SC
 ibHhi9cyRG2+ekdFJlYdN8x/SBaQYqFzaFKTSR4xjnidaTY1TRG9LVVOuRJbHMHQv05F3riN/Ui
 Rzp8l6AcR66EaUwnuv4xRPgOkgzauoeaR9NcJ8KkRzkNXadychQyaGFbWERQdrcCbxwLIwGEYqn
 W/qxCjYfBIw/ndTHPdoBzgg5XMie0CrIs0oQjxNHZdlRtlQWyIGzLGaUshMA49K21q1miAR8UIu
 EVeobm1Acr2Ie+6SRQw==
X-Proofpoint-ORIG-GUID: Y_cnkRL_TwwPhLgrHsVbLGOuXjNfKsMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010081

The outbound SMEM item has a fixed array of SMP2P_MAX_ENTRY (16)
entries, thus driver should be sure that DTB does not have more of
these, otherwise such incorrect DTB would cause out-of-bounds writes.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-eaf9beb4-cc0d-4d8e-be28-4c12b039b3c8
Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/soc/qcom/smp2p.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 7c1684c65e3b..784a164cf367 100644
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

