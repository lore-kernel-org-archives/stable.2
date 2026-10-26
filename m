Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052119;
	b=m0g+zsgDbSNBM6EzZk69FCgUOCH2J6e/iTTxVdzgmn4QjJqS3hyWywDxWqqq+PRRkYHe
	 QrgJcQRp7hMvnqAEiAVkqYPHFYbH3SmL34C5tpTAFMUyCqrlX5Zwo6CaovflCb4QCW6uU
	 ZHT8XVSjJiaFTKWBe3Y3mK/fBKGTw6N1quzG+ki/D38/bReaLywZju4xRgpPrSOFQPJuW
	 gBLJ4WAYcOGkIhhiqqfemnCKECiZdBLQcgbrCJXwMmDzWLVmblR2xGym/1aFX9Ak2sP2p
	 Dx0Z92ugZkdzUt8QAVAtXuZ7LiWsGzo+VO+gG4C5RSa3EzsANI/v5UoWfQ0QGZ41Plw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052119;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ET8ka4qtfEv+EdZP3zMkitJSumzzgQOgC9axB/fU1X4=;
	b=CyRtyysnh1U/nGA/Yn6k6avKJUUnw7Q6vnKLpixSPWWPoDES4hfNb05yzOyWKRRqIwkI
	 D2etiMmqKQ8NP+s1WVCTMyPzobSTvX9Ri6GiR+wL/okVveYe75wcZwFDtoRC/dFANR4m2
	 oQADNIegibZK1yrkC1HkHMw/V/DZ68jRfeKUvsmEyu5OREYWPOaBSQxuooWF8PY33w5Ug
	 2x/D8nT9QdNdZXvXX3nRpqkL/DqCGWamrvy3fWjKiubStFvLQekhI/LImbGplajfulMm/
	 sY/fBk+YJXhOl5aazN1RopmuwoIos30JBb3NlsEbPBEr3WhSDchHJ2grmooZ4UCPBlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=md5Ubl9F;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f3SlIO4z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAE606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ABAE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=md5Ubl9F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f3SlIO4z
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QIoF0t4131366
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ET8ka4qtfEv+EdZP3zMkitJSumzzgQOgC9axB/fU1X4=; b=md5Ubl9FMi7cc0ij
	rzpSL01q5iki/iNDVVb3+fQMV88oV81yGYIpIDRpVK3z7mzBPEi3UudJl5t11Itt
	4QGqGDPY/tdsuTMdwirUAYXNAUzkR29bLNEBSeohZB24CIUprGafJ1ZxdoBeBgCB
	FgkNfs0bQ++OW4ud0feqpIFai8nMWwTFYVMSvEK0Ctds6L9dHWMW03yBgwxEIfr0
	HOjgMD3rVhIqFe7ce/zo1mw0l7N97WznagxNemK5SGaZzl0vitCa/uMcIyPgrR16
	/lOW7FZcqzGyB0ubqAFer2sf/xIM/wYkbbg33yOlm648dGqstpb9Kdm7CXaiXeH1
	tF5Q9g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xt14v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:01:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso6480802eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793052118; x=1793656918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ET8ka4qtfEv+EdZP3zMkitJSumzzgQOgC9axB/fU1X4=;
        b=f3SlIO4z0pSjzPXChcZsyrEnpp0BToDODLgESVcbRMvbJmwRZyuaxsLeaPb7iti/oJ
         LbhBDuiez+DJZuRqy4vwzqMSnvzY2J7mRUrA9UQFTa4ioLWBImIyepvGBVd8EF/blVcn
         9+EZrzn2WJXpcYAfzpGF4Xp2xaaSU0D6TDCidQgKNzmzxYx0INLgYCgUPcyWb5IfSQ3U
         WkQvnWZ2yVGxLFfsrArfTbRcgLyJJfdRljjidkmjf44quPja5Zt8dL5t0TGhf0HAyvSJ
         atZXYkdeDl8+/BJr4szLgKtTaUVri2SCJZNT7xtHbExdg7r3HZlqeZjEzta3u+P4rm+a
         3nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052118; x=1793656918;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ET8ka4qtfEv+EdZP3zMkitJSumzzgQOgC9axB/fU1X4=;
        b=uBVKUXeAs/sBlAVl36KR55m0k0CUWbERerMx1aRpFnzF4xJHkVQVm9mdYtgKrDTOi8
         PQMTE+fwWkyU2AXS8hMtO2BNFXQZkP8pazXHr5Hs+4ZLsNz+pb2+E9UfZcd0Ax8TDisL
         PWuJkvRksa5eqq93vEt8K/hAFVs+Dby9LXzV4tKHGfHXpbK7wZEysC60OJ7dGBB+qPlM
         PABZhxBeb1TCPSvd1uYyJY0O8oMdYLG8+TYzZl152mgzzjtnN029lYWjWrg0h0II0XlN
         DYp4XtxU+tbAJ4pB0Bqa+r9RKNpx/1EtTXzKufLtvkQSXh35LiZB6a6fTIr33apJqPBq
         wTKA==
X-Forwarded-Encrypted: i=1; AKwUvBwFwWfFDjKtUWFj3b/xN8PKXqqZxa2mBJzaAFHn4zM3kWgPuHmeUB1hM41lJGUNlV3GcXwoApU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4oLYsJkZcdUeVcjFWckG3wgmn+/K+Zv173i6HtM1qCiVKOc98
	SRA5h620+RPe+Ua3xrkHCzuS9BEEwvtnsskTRn/Zexgk6r4SyxvoeKJhgOAi3qeVQ/UGoJbz0tH
	zu/XejQC6o5uAYqq6ZhJoiQfg+Y9k+SKSmzD1ozg+lNc761Tw8/wVep1sVqQ=
X-Gm-Gg: AYBFou0AG9kyAdd/AHRBiQAPj8vzeGm5/hvYCS0ReFn26yjVDW+/keY8qMhy3RrZLiB
	djlOIHgPmggMcYQvPewCyxZQX389FQzMyyXXEky/T0MPPnzWfeZcGfT/ePEfMGtqbAN+BrdYbQ+
	q4IE2lR+OOuIVfN1TrdK+D2BVdnFB6hu/nOHBf0t9rEoBYTMjI3CzkU/0YMIrrttQ2NcFkbLaM5
	MIoddHvVDcCrFentfBc+TQcs0lMQX0zmvBcv/3GsaQ6kHMdu3eSRkuxnC5EjwdwYic7omxHbZol
	gqIlKd+RZY7PdEdA6ecLCWvuhPtQ6Hu7ohsT2kLhN8rm6up5RSC0ztM3iuuQHEdJKw7ikZQ2lyq
	CDMOnfDji3ZwYX1w1B3Wyok5qPmS+xHpBUDr+gg7vvVnik4yi+IwNZw==
X-Received: by 2002:a05:693c:41cb:10b0:36a:279:c93f with SMTP id 5a478bee46e88-36a0279cf79mr4893075eec.33.1793052117408;
        Mon, 26 Oct 2026 15:01:57 -0700 (PDT)
X-Received: by 2002:a05:693c:41cb:10b0:36a:279:c93f with SMTP id 5a478bee46e88-36a0279cf79mr4893031eec.33.1793052116612;
        Mon, 26 Oct 2026 15:01:56 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a03bea5d4sm8443486eec.6.2026.10.26.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:01:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Benoit Masson <yahoo@perenite.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        stable@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260928213322.98949-1-yahoo@perenite.com>
References: <20260928213322.98949-1-yahoo@perenite.com>
Subject: Re: [PATCH v3] wifi: ath12k: assign device id from the WSI index
Message-Id: <179305211480.3326479.9381266425749962152.b4-ty@b4>
Date: Mon, 26 Oct 2026 15:01:54 -0700
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
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: DDBnVFmxjiaVdB6PfSu7V-kTDwIe0qG8
X-Proofpoint-GUID: DDBnVFmxjiaVdB6PfSu7V-kTDwIe0qG8
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adfcdd6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=go08DCD3T2PDlqsEJcsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NyBTYWx0ZWRfX+43UGHFlmbW0
 yZQbwGjObdQBk4n7+pFQt0oDteR59//CODnoRDcmHEV+Pt2M9Xlc3P4iKxSBRUg6DNPT2+KlbF5
 gZfXzhyfq43hbiZDzryeKKLAAqu6kXRlLQcOmq7yOANcCRZz/z9edI1i5L/w1HXEQL0Wvsow8e0
 tjos1dWheMxdc1YHUEeOJvVFVrqHbVdz09/1Hy+xFrVqZo+Za3KnfMg8bQI6ns5ALKHCmS887Nw
 jcHsqCsXtCvCDXzb55l2MOy91Oz6vEDY+QpumjnLBw3ExjrXvNz9nyJ4AQ18h1WE+bPNuHnnAEU
 bKdQ7UGjqqpI//OnZb1/Z3f5TWXf4aOWSkyjbD8/yUwgwXNIAA5jl75x7GHDZhHvPrdW7x8WNLN
 x+Kwf0Xjsj4cWe1Ptxkf4b3Q7QjX7I0Ccu2tRcUYuYBV/uCcVSWFQKRW43A5hk4+FI+J6mRAbCh
 dz850jiqlsWEhrhnAtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NyBTYWx0ZWRfX/4tBZoGbODJK
 hDNzTAiMJLRn6UxQQarcO19t7LfrPG6oSBAnKGVVHvD1r1YoaTpDGMu9CrsBXpmuIGjCpoZqFL4
 1Cua2VEfEA+jzuHtuFEO75aKEPyqrjc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260087


On Mon, 28 Sep 2026 23:33:22 +0200, Benoit Masson wrote:
> Devices of a hardware group are added to ag->ab[] in PCI probe
> completion order (ab->device_id = ag->num_probed++), which is not
> stable across boots. The wiphy radio array is built from ag->ab[] and
> the wiphy device is taken from its first entry, so the wiphy sysfs
> path and the mapping of radio indices to bands change on every boot.
> 
> Persisted wireless configurations reference radios by index (e.g.
> OpenWrt/hostapd "radio0"), so such a configuration attaches to a
> random band at each boot. This affects any multi-chip group with
> single-band radios, e.g. TP-Link Archer BE800 (three QCN9274/QCN9224
> radios in one group).
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: assign device id from the WSI index
      commit: 81986a81f09fae73926c7c44863b335880269c90

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

