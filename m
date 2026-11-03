Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730597;
	b=kT0DtvsPoeR7HBGn9l2r1C7weKp7r5F/h9j+zOU4/mCdL3x1iW35SXI/vCD+B/g0QRAq
	 yqNAB+LFYzCVcsGqcb5m2o8jBhZ0G7871kmRdrfRCeeZ/0CVAhCbHPzgTw/2u1E+4sDKB
	 zZZwIMITxCY7jCTkeHdR/rV4RNbYlIOBanYBsqseBd2fJjamNyYCy5BR1rK0Vt2ke6Bzf
	 TxrrVzvobbkz2wIAEH9CsAlOB/7NxUUZe1i0SG2OdVJR3sImTECFMcFBfhIhus9qGD852
	 EGf58bwcS+hBgDpPtW4kPE/Hk2BuM9WcJ4ddcw8TAmRKOkBIvc6eTlQLynid6jpa+uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iBhhiklJSyJ2sZ9SAOzTtwXUR/nAQ8p/ESWwp9myjuw=;
	b=pMKyrUGUfPFOkZM/s/2jnnmPplBihKycFPIJEHiZMcUXw/cQnkEMQqmyAdoep6pvtKqe
	 EjquxE7NNZstUIVmuEtyVt1qC16JCE4fflNznB/ODodt/aWVKbhi6B2D+SHLbmeliepQT
	 vNe6qK0ptQhq8GMoJx0+atKzuJRweMZxbAKFGnP7iGa2CJSMyUJ2GDK37l6JDNXqsBXxc
	 vvX1EIpzt7ozYGknAxgSWaZutgaQqKkEwJqlY22VjwvnJh0wkuGX/CZOf5rm4E0ZTMtqs
	 V7eN1IRdjab2MK9tyPFh4iT+ZdEcUF3uS9TQlprOTV9lS+genrs8ehxvfcTIU3Nd0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eoQk0e5l;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SwXFABVW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE81606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE81606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eoQk0e5l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SwXFABVW
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HPWDS344446
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 18:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iBhhiklJSyJ2sZ9SAOzTtwXUR/nAQ8p/ESW
	wp9myjuw=; b=eoQk0e5lfOEcB5ZbrvCTwseqLv9rR6Dm5ENdPvaUy/92tCqE0pD
	SPU8SVCVxis2QxFzgHexuzUanliS3fs4XddUbcWWmlkdT0NV4+PgryCNJPtDV611
	lwhWKf13XxAFp6EE/Ow6l4nfaC4IHlpH/lh0qgYjCIld2mu/BQCdagIBexaxxnew
	rwflCgBSbVJERUBbFH+g5DqF6G2sz7PHynMWlGgxEdgnlmr0lmg3AgY1PcJ+0SEh
	wTzdjf2Ix0IpksjVkYtMIHGc0XbJa85Gcpe7pcDZITFzc296OzKoChb8tnxhuUak
	clfR4wl3X1ESe4E9cY9iXP9q5/dxAU+9wUw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76dbnuv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 18:29:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso2891408eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793730595; x=1794335395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBhhiklJSyJ2sZ9SAOzTtwXUR/nAQ8p/ESWwp9myjuw=;
        b=SwXFABVWbgubg0eTGux4vtV5HMsxw1pcBU+Zn29cNoEA6DSBQU8ltGrEtAtuorAQz3
         QYYp5aP3Nbap8bbxbOlb2t/rnabdEvM86iNLSD3j2Up4xKDPct7G+OfCJS0T6PLXgTUi
         AG8DP9y/ynZb6W6ubIKQmjKhusqUKR8i4xYsxnamgwak+YZLt/LJ6+IvXTqY1/i4vj6q
         Y4mmSNWrkFjwwGqez7291t908Aec6kwkQdT7qUOw54UWWemRTCkv8SfBLo3eM205UgAG
         VDdgzrP3htmI5frJLROHoKYsaYMss7XH2Ci5GBHpBIqBEG4GXnLhFZ/hcyNQS8mzuZum
         SM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730595; x=1794335395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBhhiklJSyJ2sZ9SAOzTtwXUR/nAQ8p/ESWwp9myjuw=;
        b=rBE245KoMZq1byBG2/DOXqnnyzc/fNn9JzMjERbBpBNCfORJ/B2EKzJXIjxWcGT4DQ
         FLARovUBzun7zMZKuTzXUcAnbIPHlVmrCoMN4+6thhh/Kxien+OiTJFuv5YGYE6erR+U
         kLC+DnILl+xoFNAguBSLh32beDsE50h0ZFtG2Ml35HaBgMqxuAsHpp6DxF2TqQofJwAu
         mJpnFlF0unLM+lvyVBdRzG8LqwPy2/NGq24FxLEvH6YuKCjGmQ0089my08KKhw+SqPEF
         hJctHlgPN3ErmbmMQmIX00GbnMw0lhKsdDJs++5zpg8IWNXS6oyQ1bq+T05WkoL/lZRK
         YI1A==
X-Forwarded-Encrypted: i=1; AKwUvBy95VNa0FpFEn6MtbTyqCCKaGKd2PYDyi8oHDslqo6YNVtnsep+l8420Qd4w0lat49nHVexpHw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TMbf1psDbotwULiCDPklANBj/P8O3MDV2Ml9JLiwO0CR1uK+7
	xucqJvemtf9aY6nDMH1fTXrsKkDyU4mtfCtAmDAVHVihnjzuTVYr6XYMCJ+BmJ/4LlDX5QnLkUQ
	2Dy8uSsLZwQbgw3LvLYc3DvkgdofgDtN3YhBjuX02+BcK7L1s4qOXpV0YifKFFmzk2hU=
X-Gm-Gg: AYBFou3RlAN5mKrbpUVf85UzqRW5CvNJEELuNprGrhZr6C7QSgDS226+Ma3KT7DXOlZ
	5YNHyzc/BZw0bIk10fXglHZoEh0/edO3TbKaS8969tQeTepDy+/KKUvhlnrbNk0JfIjetqmEmfS
	mZp+GeOArugYqtT8Z2wkrvoKQOdcH3Dzf4UrA0OPFgzF20J1QpIwjCBDq8IcKN8CLVZydezwQpq
	cgVNYlWl+bY/1UEiieNMsWspoSvqihbkKzjQYJo2MNg2F3AtGw9++eMFNPZ/3rw+PhxHDVbwYM3
	p/v5coLCXhDctO6wRPvUh3Iy0bWXC6nPPomUJBhc+an0jUyAVjfgoE1g972nK3TbYB+sbm2sKor
	od4Ne8i97s229wJsCXDqk7cWIkwTP3+at7K+tYniD5Kx/Q8u51WMAxNyDrFjNrEEMHRhD1k1Sh1
	U9LqpWm8ViHtb68jE4oqixIKr03Rw=
X-Received: by 2002:a05:701b:230b:b0:1b2:4378:3545 with SMTP id a92af1059eb24-1b2437835a8mr1882299c88.21.1793730594823;
        Tue, 03 Nov 2026 10:29:54 -0800 (PST)
X-Received: by 2002:a05:701b:230b:b0:1b2:4378:3545 with SMTP id a92af1059eb24-1b2437835a8mr1882258c88.21.1793730594224;
        Tue, 03 Nov 2026 10:29:54 -0800 (PST)
Received: from hu-eserrao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c290sm609796c88.5.2026.11.03.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:29:53 -0800 (PST)
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: Increase no-IOC ENDTRANSFER delay
Date: Tue,  3 Nov 2026 10:29:53 -0800
Message-Id: <20261103182953.3437202-1-elson.serrao@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6aea2823 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aYgS4yw4GKKPh0ZsU78A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX3YnuwQuMrSxU
 71GwPBGPYMjFNDHe+4LBs+y5oX64mGsXIkW+w3Mi6T+8pvlJKHNfFbMY89Ma373sZ/hOi/V6h7y
 NYDEqe4L9vtm5FM/9lUD3t/zlJkt65w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX+wncBdCxlACN
 aSfqAteTaVr1siDMgcYSIqQda3fFMIjWr2yqzC6sE3HutXjQ3Zksbd2FIS9S3PhLbejgP4XVaMM
 Xoooe6GN71WQsZ6Zg00Ijkuni/+UIhxbZ6Shcley7BvfbCa0ApMkBfsluxhqdAn84tomX7tO+KM
 XEIJn8YBWSMqDUSlv4GPLm/HwpzUJwsPVe3VW0BRp+m9k0zE7VA7I9B+1DgMnEvBkmrLfz9VT4Q
 bDd9ZGZIAGIwsEWl5oj9mlsWRwaIkKrfIlR05XfgaMQgydf5Zo4UfxTjPLm5CeWR2ArXOQO8AbM
 /bWOu/r4UwdG7dcWOw4zSVgniWjbq1vTdCYcYw5KKJWsA415I1uvri3ZJkbbWbh7cYufuDegaON
 OMw7jcKYLYskD75W46oxNVyAPRvk/fhBS/s4xILR2nY831pi6z1BRuH/8wdVRDheBMdV740OmuQ
 oBkwflhMwEALdoyD6eA==
X-Proofpoint-GUID: nDX4tkhulAlU-R1Xve0NuvqI4brCSf6W
X-Proofpoint-ORIG-GUID: nDX4tkhulAlU-R1Xve0NuvqI4brCSf6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030073

When ENDTRANSFER is issued without CMDIOC, software does not wait for
command completion and instead relies on a fixed delay before continuing
request teardown. The DWC3 programming guide recommends using a timeout
greater than 1 ms for command completion. Increase the post-ENDTRANSFER
delay to 2 ms to provide additional margin before request teardown. This
prevents SMMU faults that can occur when the controller accesses unmapped
requests before ENDTRANSFER processing has completed.

Fixes: d8a2bb4eb758 ("usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC")
Cc: stable@vger.kernel.org
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
---
The DWC3 programming guide recommends a delay greater than 1 ms for
ENDTRANSFER completion without CMDIOC, but does not specify a worst-case
completion time. The delay is increased to 2 ms to provide additional
margin based on observed failures.

If 2 ms is considered excessive, guidance on an appropriate worst-case
timeout would be appreciated.
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a76f669a796c..a907fdfac8d7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -445,7 +445,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
 	    !(cmd & DWC3_DEPCMD_CMDIOC))
-		mdelay(1);
+		mdelay(2);
 
 	if (saved_config) {
 		reg = dwc3_readl(dwc, DWC3_GUSB2PHYCFG(0));
@@ -4158,7 +4158,7 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * returning from this function.
 	 *
 	 * This mode is NOT available on the DWC_usb31 IP.  In this
-	 * case, if the IOC bit is not set, then delay by 1ms
+	 * case, if the IOC bit is not set, then delay by 2ms
 	 * after issuing the EndTransfer command.  This allows for the
 	 * controller to handle the command completely before DWC3
 	 * remove requests attempts to unmap USB request buffers.
-- 
2.34.1

