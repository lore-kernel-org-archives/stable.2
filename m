Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8143148B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508912; cv=none; b=KBuUzHiIj89if1ba1w1jG/WACVwKBLUleLVbttpkFNvF3iMRdb6dwghR2s0EtzVmF0f4rJ9FarHqOnqZDkEdwdZ66xgCc049AlaswlqNp/4Dcu2FXY5+c0PJj4XWMmtQjmeVWK8wi7XMuJsS376Mu7xtFYa/rVt1lSl7Df7ZRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508912; c=relaxed/simple;
	bh=auqB5D5KRMWLfsnNJkEmivKz9/AtxkQIYvku4ToAYR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c4Xf46lOsdl3RBxdAcOceBYGx34VIGle9NAZmNciHr7DLkrcOPrB9XifmkDlpdn2KdIdh2+TLU2ljObue1s2vRGFGoon3Ssu2xY/l9yU7lYk3GFxCjtYPB9VRxy0qAUw3oLLbzwEGnZFsxBCjeXl+49YPkeejxNS2ntGlvqHatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGdfgSW8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VdwyFJol; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGdfgSW8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VdwyFJol"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VCA06i4154469
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2DL1707qpbWXy6RtnqhQgUS3iYKbXZtK7tzN7S3GS+A=; b=kGdfgSW8tX7i5pr6
	fL1vaeI2wbCm3hDAG0vpS9fDFZnCS01/55xszfH2R4cvBz79yvwZWG2gwR4eGtiP
	WwF1ZTfNfZRI9iNzUPh5/RQLktWNKj+w7kRNIvXgvuZbb/dRvl7ISAKRiPsGYz9P
	NXYqRHq5ZBIPJ7HTS8j1Wj0F+iibrd/oaCEaZuYNAIl8+PKalI4wiXboZbjmIwBO
	EdFtiPgfRKIRyx4NEmAV8y9Tzj4vYJi48NzUJ16O4BPjYIGSAI/sFISnI2xHR8tm
	wiCQNgmuhZ/xaIa8wiT10UmMQGCbB12XP6niVkUId5Pe4CXehG0pWFRxefqgTVeu
	M94qcw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkgnct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:41:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso1070234a91.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785508910; x=1786113710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DL1707qpbWXy6RtnqhQgUS3iYKbXZtK7tzN7S3GS+A=;
        b=VdwyFJolmsPlM6FVasd+T5+uHmGjZWMxbWSGKGIpKAypURqDMiVCWA3PYf0+q3EAAw
         5DhprQmKGN8kIPvcUL0Vj/knDNPp6xrHzW5fjog2GitvDurA8tvRjCDO9f0L+RDlvMss
         OUnP/HVzucd5BroEnvQhRCsSGXO5KfJIcjcyCM3MSeyiSsqqZ5ZxP4lutc/B9nPfUa2f
         +T/jMbrEtxYmlaSQFmKsHH6zNlFAbi6QJjwhLUwrkWpPeGTv8u2GwANcIx8vlzIe7y4q
         VCVq9zWLiPEVSKMFzk37wIqWblkVizoQbr7I9KUGL7iM6VBvo5BfkU7rN7ljJXVS2Qfu
         64Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508910; x=1786113710;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2DL1707qpbWXy6RtnqhQgUS3iYKbXZtK7tzN7S3GS+A=;
        b=sw05JGH5vyJZxdaM2cNi4ueVpSmo061yxXqpvee+UzBiUD3dDsxjUCVv2Iw19lZBE4
         yDmJHm11LRcwEaagK0V8SH1Uj84OShzwC9N6siHRa7eh7IXy00AyVQX9LjolRCxvh+E9
         OHIPEWxmRRioUY9zTiIakOVjL9Y19D1tTqvv73MD5w4Wvr4H8Y9dNylT3Lfkz6ZLHf9X
         WpCpQ+jM2QudQA1sbs4EXmenr7tMThQs/tC7CS08On3efsDyiHmWhHKhEZIEfVDy0Q1l
         +pkf2YkNMQfsHGXwOKtYaC3vsZuVHfOiewGNTN/uRGtAzHXpqiHfDi2wbNTuiXoIA2wg
         XtLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrdt5xPvKV2IKZfxWcdvdzsyRUTe587hxAqgBixAgv6CB/+KEbRGUuNf1XBgeMgrA7MpJ9eVaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uIYdRtQ2jPHzKnsEyuSzYnnq9OauzGXia5QOzvs9bYbawLRL
	J/QWSdGLnApUtpqZKrDTdDL55xecSXckmedfh77eQ6H0cFxXROkxdC7/LjYnbSVDzoioQMREWhL
	nxvtckVIU4imkbSJqGny5SXEJYac+RwZwGd17qJgHnDWPPOfQotL12ZrAnPA=
X-Gm-Gg: AR+sD11r2/hEqFdQ9HvsnaQDxI4nJBFnO3Rope2zWLxSVZo5AKXd6chvFz6QruS7mE6
	k/kPBDiiWwIIkkJjezfqtru9an336k31oBwE7ILBzMt+OlDMUYNSlcYu+bIvMtyDRfy4m1NBICB
	xHaQwzBPlDwq1opW5v5A8keEQ0AxOJBNJPZxPihm4uIZtExXur0rsiUhuNLe5bwwMfjaoK3dOVz
	BHioj4ts4UGpOicOgSC5ZOlP5KLGaxib089LQfaV1JU0+OmGxccGfXhy0xq1XGH113pwp4rmhIT
	TjwowS7gwEVt9ADUIG8KYLCzbuhmb1ZeL5Vdyw3UvMw4yAl0tyPNKpWoFw7zEFZsu3JfRGx/y1J
	t9v9W/M2XoZ9AMOBAuJtSIxssCg6djnQ0DTlNoNuABwE0THJ3UgugHmI=
X-Received: by 2002:a17:90b:558b:b0:38e:2a4:cffc with SMTP id 98e67ed59e1d1-38fbc4c4dbdmr176326a91.25.1785508909714;
        Fri, 31 Jul 2026 07:41:49 -0700 (PDT)
X-Received: by 2002:a17:90b:558b:b0:38e:2a4:cffc with SMTP id 98e67ed59e1d1-38fbc4c4dbdmr176288a91.25.1785508909088;
        Fri, 31 Jul 2026 07:41:49 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04491dsm9622360eec.16.2026.07.31.07.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:41:46 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260713213251.21161-1-doruk@0sec.ai>
References: <20260713213251.21161-1-doruk@0sec.ai>
Subject: Re: [PATCH] wifi: ath6kl: clamp assoc request/response lengths
 before subtracting IE offsets
Message-Id: <178550890659.2242004.10745983270353218033.b4-ty@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 07:41:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMiBTYWx0ZWRfXwDjVHg+OGGk4
 3cao2t7V0b1WiUGTdYTjyewd5v+07YuISajXtmL114rAldebeLbYVPB9c3y2RCZAVS/VDXZmI5D
 5NfQdNZBNMEorsIllEZ4qPVX9y+z2FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMiBTYWx0ZWRfX7DLPE+cgXz/A
 9Rcu2z4q6cEVp1wqytXFd7ttYj8y1y+SI2o1BnUShisqpDlKa3ecKARteZ+x2l+WBRHfPe7BLBk
 QNmkU30ZwIOKMfj1Yye2Cn34+Uzm1ZU3VuT2Z0lnYM88NCUQ0oOXYGvPEVeer7cWGlxlHyyOLA0
 80ngWUd7vcmnhnRq5OFklPweONxfgq9KdwlMjHkKx8uw62e1FxoMkotEvyJBDVI5Aae2/U+VdBa
 U9s89JOWHgVlGU4JIH92sFUT2gHpuxEKuy4icJoFYGgVxmlgUE2YcDHGqVbHcsQ6zi8wtJ1OgU8
 VBV0ytwxVovdesxWb2e7f6sX3J/VPyDhN+to+S2kFK5lVb+sMlO3Rab2rZkHeNoTt9zN18nov0W
 f1Cm7kiYO1KA3P7F9XR31lMXqy5V533EHTsj2Qb2/mfWhrFG/H33M0fLpehZ0P0zjL1c+4iF9PW
 +DD0MiuNtbjrxVNyoSw==
X-Proofpoint-GUID: pyOF7xNcCrFVMdLLhBXQv_NS1pN34cfy
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6cb42e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Tiqys63qfOma7-5uHz0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: pyOF7xNcCrFVMdLLhBXQv_NS1pN34cfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310112


On Mon, 13 Jul 2026 23:32:51 +0200, Doruk Tan Ozturk wrote:
> ath6kl_cfg80211_connect_event() subtracts fixed IE offsets from
> assoc_req_len (-= 4) and assoc_resp_len (-= 6), both u8, with no lower
> bound. The aggregate check recently added to ath6kl_wmi_connect_event_rx()
> bounds the declared lengths from above (their sum must fit the received
> event), but an assoc request/response shorter than its fixed offset still
> underflows here: the u8 wraps to ~250, and cfg80211_connect_result() /
> cfg80211_roamed() then treat that wrapped value as the IE length and copy
> that many bytes out of the small assoc_info buffer to user space via
> nl80211, disclosing adjacent slab memory.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
      commit: 3bbd05723d15dd06f0560bcd94fbf9a91b5f5613

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

