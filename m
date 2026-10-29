Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356087;
	b=q+e2HaNF5VZ14qTRy02t0kk+lrCNbZvcnNk3cBevGPgbt/lzl+QjQLYkg/ZhvhMAbIpY
	 6LILHVUQc3Ck/6SW9uXSXO92jMW6kj/i4j7ip03032lOw8MZjOllM7Ze0UzDJcbqRtk+H
	 d/M41r1VbA/YafB4mhvweD3d8MgcfWrTT+c7fJApRG1MVXgxcRF4y5BXJo/cTyGqxCgoT
	 lcjjeCbmUbk2gR6kuHy+krd+Bje+GOSuLGcWK32a9kYrJ1kAWC/Fa5OqNz9lhVUUBZcwJ
	 GUbgOCf7HbTv9Dyz5nKTRZ0+1ZNoGmXHHrOcFHhp+p3D8LPAH6Gfyx1+oNwfON0q6zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356087;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Proofpoint-Reinject:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
	b=rXRmk0Pi409mCXnL4SvPVlbcn4hlGCNOpy50OXf3tuyFjtuw4W127Nv19B8S1/IBCF9v
	 I3AsKZ7cKgPZnU+xihYleTSQxTSL+jcW+UBZXS2laKtmRdquJB9b3lamN9pYuYPcx9yNs
	 sHnqEv14akeU1z4QHzoODgnIPphRVtMTIH4yA3Ifr7jiM8b5tz2Ezxf/3uKPT+3m9hDxO
	 x05l9WCUBu4Uk7QyV1mg8iVHuHQuoT2Sn+WuvqH0fZ/bsZaQlYXO3WxFPb5BRHeEM1F4E
	 m+wf8PfCf+2QsHasvUegzUGJxOsin8vMZzo2NOHzYqg0NfqoVmvp3syfq6WrktQdnfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=USiiBghH;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fDvGCPEI;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92260A2614
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E92260A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=USiiBghH;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fDvGCPEI
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8JQ4U3894265
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=60pH
	mj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=; b=USiiBghHauYrBcMLTYEP
	0Hja1/JhbzTNZVclHeokS2UDMFr/KgpoLip0BcdrBhBNNMrRI6FE65lgrLcjMG+f
	HQj5o1kFnLnDRdmGc8tbbIdy5N6g0tKS7eOw+ppQsp63IUQimasoWQrRf+gLuNj4
	SDs36/OEUSgJSgSuQ22TpC9NRjBrQ61GRxAf6qv8P4nmN5jLvkycjcJKwlfWGBws
	ww06QOC6Sj8PSYXTs2T47Bw3LF5hVHVuiKVTCYp96McXRLoHPo9WnxFEOHduEXwp
	3FvTxJnfmOUPGFNF2n9PEMw2N9z4T7qdxmChHhveSVdJA+nUr7ARnIy+hbsvOo31
	iA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm7k00ftx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:51:47 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91b4bf686ceso31963266d6.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285507; x=1793890307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=fDvGCPEI+HOCDA7IwmeQ4w6kYAvBKbndElZlCu1ktO37nalZOnKc8eAB0o5pH5fq4i
         pgiHLLVwre/7JWCrh7Xt15VM7dzk6Ee2hNStuDFmvttHKKJvySO4hAvonaxdZFMWipaP
         a8PAW6p8Mx30FZAR2XpZutp2YY7Q9fTNJgd0d6NaXGaiSaV/LVHWmswuTXZeHjLuysxB
         3KBwWu2zZNlNfFgOXaXAq/fGLwQeKZmovGEuKOzBmdJURdPQ+0uN8swKQQXxHaOKoj5t
         e1hPGsu1VqtAroa/vMiJAFfrFDzFZ00WzcYk9Hfm0FAbCahwAYdWTdUc9WBbw0NC/yBE
         ELVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285507; x=1793890307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=FOaCTFdFp+6BWAFp43xTucMasdq19Thb3sW/VGclN1Y592+lt6vo+Aj/BEG5o4KRJT
         bE71fVEKqCPjN4Yat/bUhCwRczHTuMPVMGtIVbI4rImssxjHooNq7UCCycX77UA0pfyv
         ElnDaeXyZOEWJCQM1v7Eyg9IuvNayKH6+/5i2lplMz8icgIuCdal7HHED7JB4DbFT9MF
         czXEsZjH6p6pq1ZOtFe1Ugva/ytLvThNUus0thqXXI/KwW0eRdWRG2uSrtyhbDcv16Tr
         VKijFZs9gJEmhcH+skCe9J/GsmTsZY0cLwZQFLV5LTEcJZiwnhGsV1wZMoVamucBv/Sd
         I+gw==
X-Forwarded-Encrypted: i=1; AKwUvBxvhmyB0DYmnsfPsabG9l+EVhls2y6GCwwMnEIHmNwEzVUpQu34C61fH0VA34LiKH5yEUBeHBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDeXwzvLuiBzSLAl16dc+cerTF9DY1u+T6fOfwUCdu2+nvfUVV
	bdP9KCMmQAD6Xpbi24vQCYjb0trkCqPM/CCFBLk260L6Qk7Tv9KYenjBIpvgd5W6pDHlyf7tsji
	qJWEuEjaG61pFLkCnv+FDvWfB/JTPuR/0BpAR1kWO4HSSpm2zgra9rw==
X-Gm-Gg: AYBFou2eWXuSlrj70mekx5/vzEVDUbKzOt64KPGjuNNSM5+qD+xRNZAllAGyg2cyx9j
	ox036P3CDVs6eapfjU41YlRusT9ip8QEKDGO1645q/ZJkAx6j6m50BJuzCPOfuTSnnTPntLSTYc
	3OhGwDQDYF8AfDWOV3iHI5hLhEy2A0pXnujtBUTMYap/+/u24pavIRWZBsgUW6iwzQf1u4H1tvD
	ShBkCAtHENqKIGAU0wQmPRSZNmTcFYgZu0AVQmTKqN9S84La0gb9NQ686WETx6We5sfZF6u2wCP
	HYYtmCBLJ5t5rmEOET0xKb2YIhyLhVvd/DN9kfEsdgjhR/f2UWbI4jt1PLZJhwFrdjzd23Tl4/S
	FhWJ7sBDy8QTvgI83HpKNibNrdsHG5rhgsw0yFi+I6RnvrOUpv+V8etpQ/IBIBlA497+GVIiKvG
	EYwUwyCl1MCMcIaNI=
X-Received: by 2002:a05:620a:2611:b0:93c:6507:a6e2 with SMTP id af79cd13be357-94408de7631mr837871485a.65.1793285506858;
        Thu, 29 Oct 2026 07:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2611:b0:93c:6507:a6e2 with SMTP id af79cd13be357-94408de7631mr837867885a.65.1793285506347;
        Thu, 29 Oct 2026 07:51:46 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:45 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:22 -0400
Subject: [PATCH v2 1/9] ecryptfs: reject zero-length encrypted session keys
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
Message-Id: <20261029-ecryptfs-folio-v2-1-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=1720;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=a+HBd1agQSrDWNNuzP/HbD49+xH+YgjHAS6T3xiz06c=;
 b=wAYF+u7froYMQ9mKuuSsj8W+yYgbnMf0aGrGakJYXq/pZNQAqt/Q5v54YS9zGszXpQYi8c/lI
 MCLyabBMaXEC7hJmycnnkVoWfJXR/tlrtv3wkdVQtg4B36wUrv2h7+f
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=10 impostorscore=10
 clxscore=1011 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: p8JzpVNvc1APmyy2Si4ES__gfZ3jk8KI
X-Proofpoint-ORIG-GUID: s1_7liB7PlDBB01yxYxSFux_j9-Kl3-_
X-Authority-Analysis: v=2.4 cv=GfuCDgXL c=1 sm=1 tr=0 ts=6ae47136 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=aH2rPlVYf5PhSe4MZfIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX1J4f7CpNowpC
 YYIsvo0qYgNfAHL/oyvMcdR8xzCrdidrWW8amfFujURBkmxUC+BSj4JixjAwsU3CMEbPBSuV+b6
 GPf2czctdcU+gCfxEn4dO9MjOolLU6nFM0VEGet4qYEfVUM2pAVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX8io74pBExoY8
 llLl8YRIfAVyUgrM44uDmylQ75q7KYjYEfLiYKIOaPhidSH+FcKb92fRD4C6cm4tDU1qL6XvNxB
 GpgOW9NtRheXrjzl0TX371gfxtwgpPznU/5IuSPznfhfofCw1cOaMo750e4RKJ68RCKnH2Kq0a9
 HWTFB+mafHGSMNjmZWhW5dw6gbcf2FDL/9mk/zdEYBoVZoCfu5G7S6tlJuL20jeSJQdVgwHmycS
 Llb2yKizxMCtVZz8I7YMXZPwzPy0iC0KF8b6li9+Ws8jgC+rDW9KLtVGX8dGDtwU2Kj122+VNqo
 cAQcqa7ulNnnpxfu7nABXWnt0YqYj0ERPWxaXmZ3rteH0kJRbHAjr7FxcDRjgH1OQkXOmhIfuFv
 FBRY5QGX9EqD3qTLbip4m07lbRIYldBJNq8/HWOkiYY7p0PGyDh2ah4uLKCa1yq5z4rtZ1zXlS1
 RtWFS+aBSwoo6JRTBgA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 lowpriorityscore=10 priorityscore=1501
 malwarescore=0 bulkscore=10 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

parse_tag_1_packet() and parse_tag_3_packet() accept a packet that
contains no key, leaving encrypted_key_size at 0. The decrypt path then
fails its scatterlist check but returns 0 anyway, so the file ends up
with an all-zero session key. Since file headers are attacker
controlled, someone without the passphrase can plant a file that reads
as plaintext of their choosing and encrypts anything written to it
under a known key. Reject these packets.

Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261014-ecryptfs-folio-v1-0-f4412187b1d3%40columbia.edu?part=4
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/keystore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index c2ba230c71fd..a0989e3c8aef 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1250,7 +1250,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		       "rc = [%d]\n", rc);
 		goto out_free;
 	}
-	if (unlikely(body_size < (ECRYPTFS_SIG_SIZE + 2))) {
+	if (unlikely(body_size <= (ECRYPTFS_SIG_SIZE + 2))) {
 		printk(KERN_WARNING "Invalid body size ([%td])\n", body_size);
 		rc = -EINVAL;
 		goto out_free;
@@ -1384,7 +1384,7 @@ parse_tag_3_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		       rc);
 		goto out_free;
 	}
-	if (unlikely(body_size < (ECRYPTFS_SALT_SIZE + 5))) {
+	if (unlikely(body_size <= (ECRYPTFS_SALT_SIZE + 5))) {
 		printk(KERN_WARNING "Invalid body size ([%td])\n", body_size);
 		rc = -EINVAL;
 		goto out_free;

-- 
2.39.5

