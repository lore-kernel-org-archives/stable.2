Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223169;
	b=1S+qColGEbX4iZXrtE78unBMyxO5q3EmRHgixnkoQUhPSTkAPxYf1f6fHvSzaEbhIl2f
	 IxIwdVy03HzTTxT1hE2MldmNzDWiyWCf3VKjSk7O5GQM16TgWJiEZ82v77WR7qvVVw13F
	 g5XvwOJP/xQHeb/mQP0flw5WJo07zplENdI7zZGIkYhFBmFF4vHULtCElBXFtOy5/DT4c
	 gW7l5DTwKvGprXGSPKN0k4I7skrIws2qReHLALoroIOQJeTpbJRruImQ1AEdLbSguU2t4
	 +MRAP9n8W/SQU2mudGd7cJI6LUc6tCiS75hdNo6npNyqB1E9i8TF+L1N2ll6eXWLcDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223169;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=roGi78ys1k2Uv1LUZCj5d2Fe7dlBCtFSPtg4j7Hfqp0=;
	b=zUkQXAM2q9pJRmtktYDuaATUCHaY1DudWgyvprklYLmIWjmMES3Rk5VlOyBQPyIxhQVS
	 N890LAXjGWjCWGb6t1WVPkrPEjplvWLrw8gmGIdNGXC/9eulpiCWP/jKTNmk+vxAAVCVl
	 EaYaFjbYxsaVvsjkbHZ7PNnmIO4myNVhUMpKXQS01E1TH/yTnfY+NhTiLiIlFhmKwjJ4E
	 sn91Rs1h8QsbCXZ1TlLWUsXp/4jmygnyDIjEVmsTudVwF4fsMYCo6oPWaf0HYqlttalOJ
	 8rYbuLf0yn9ae3vVqxYvTJMIWj/iPOSXGiqOzfdkTQjdyqNR1l4Pxsfh+8vc6dOp3cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jsOGuWIt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdfdRNVS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC16606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC16606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jsOGuWIt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdfdRNVS
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIPCJw1026661
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	roGi78ys1k2Uv1LUZCj5d2Fe7dlBCtFSPtg4j7Hfqp0=; b=jsOGuWIt+kH55A/v
	1NNo+qrfpvISreJ9xXX34fAdfvyQMy3IVE/nwrZ7zBouTaL4O6MNz7/rD0uImM1o
	oaEzYk3qdlqlBkSzqQVFyfQ9pWYG5HezU32fn7xhQec0sET/Z9LvMMaovzMojFuY
	vIcYnYPgP8oysRCgmf9RU4Cq0FFcZqo9zdhNJK+cAK8Y29YhPVAMsQCCFZcenmF5
	bB2I5T/qQXNWWLuiqLgmrb8JHK3wXyWdZPb1rf/GdKO38s4chNd614BQjxWjspUU
	HarJ2nio9JkZiASdTpczxzfEOGLWPmC/AmHlXrev9a2zGTCRk01eB+IHy9zNou3c
	nQakHg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb28wn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:32:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2561472eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793223166; x=1793827966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roGi78ys1k2Uv1LUZCj5d2Fe7dlBCtFSPtg4j7Hfqp0=;
        b=gdfdRNVSlShQ2MNBU6B+9RZUnmbr27n88zetW1rurPykhvevKNQTZw9u9xsg38ko4h
         64UkWtObpfuPesUjfTHwuxiE1vyxPrTVK7HO2e5H4DHi7czNhk6cc892r4cCEgDPQhOM
         1SLB7UgVPeLoWo0mhR93fb+tQA3CFGiIG30K9k/yiTl+eVECZ5azb1xhSHAMiyDRwbNT
         wX/ybVwIfhF0H7lc5/giK0CSFDQhsks/narFBIX/jhY/p/baYNawzAh9iU1iSQNkSK4P
         JsGCn2fA6i0ALBDtRYsx9L0epLQpuRVOwZiXEWZtA0GSwsuOBLSQ3mJrWgkQ2PR+fFYL
         XE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223166; x=1793827966;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=roGi78ys1k2Uv1LUZCj5d2Fe7dlBCtFSPtg4j7Hfqp0=;
        b=TmVqXN5YPFWoYh/c24tykqBEQdBF/UAMkzkWQpCtAXx/1z1ftWRqK8vBwdc4dTu77o
         uwgpBIt14M4ebfxxRiUwbwMdx9F+p640Ro7XxOv90cLj+B6VajeVk4y2+kAc6cFpFOv7
         /0UrpG97VH4u1DQaCC/xgJ7IXb8bvHQsLVqfD7Zlci/FnRmEAtZ9mASsMR8DryL7faLl
         c5OLZH3BbNaYeSTOCHNNQoIGHcFE0OWywCEDcRs+NUNC5oI7EZTfJvBNk1N910EQ1MOb
         zJFzj3PW7XGi5nqoDz1JUDetDRCHg9AZm4Q6/X8ehM9Q+9UIGFEwhNNbKAsRyDZZiPLB
         w09Q==
X-Forwarded-Encrypted: i=1; AKwUvBwJPZw/OV85WA3yTiZ4uujGZv77B2qMGrC2WyepVOcabdsw8pHPfDOXwKeIQl+LgWYirs6WLrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCAVVGQhR6ExxiQOMz561QuyDE45Q6ljwMQJgl6zeNAT8fb7sA
	PPtZl/VDXXdYsVdUxwXBy0vzGuFD1F+M2GMtdVeb9cg8PJwfHCJx0zXfdV9dUi6MU8D0IWj3LH/
	CWmVyzZLkeEU1engNMJGjf4N9f9DhyzZ1C9jIqEnwIxYYGKxo8wvpDOkoJpg=
X-Gm-Gg: AYBFou3oSJC2DNs1frLvhCNLpHwv45BerRKVs9qEVK8XZHpG6IiEkTweE8kqCdyTU6G
	JTPDTvDOTicA/W066w0QM7/7o96ZxpKTn2MlZMuWgQznX0ARiv7HdNq5uW8QYNixExpD79JIeDj
	arrlKo1QaZzHYo5HxXRrnf+QtAAUqqBym86PhyUAAQTVYIXxEZdvUfMqOewes2/vvecZr3FtHoy
	bjBGN/mNwGwfpcWe1bTzCV/LzoAOfPy+OY0N3Kx2V4dw7Hjdg4s2zSPATOH4CxiuXkUopC1ID9e
	EFmzMgV6Av3O8Co6gb0N6NsJCek+GwH+DaOhi+BdImEfJZQPwfZaNtiAGOBHiCTtm3D5BIbN2Cr
	dsPLad+c1oDNIhHVRDw5csPqU3yWlkGFXDhL3aar/yRV/q+8HH/EvmisVAK5QIkFdpgPBabdpto
	IE7j+KnsH0EuJ89MI3eYT6Wpo=
X-Received: by 2002:a05:7300:6028:b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a2014b7d9mr4548070eec.15.1793223165831;
        Wed, 28 Oct 2026 14:32:45 -0700 (PDT)
X-Received: by 2002:a05:7300:6028:b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a2014b7d9mr4548041eec.15.1793223165251;
        Wed, 28 Oct 2026 14:32:45 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a26d59f0fsm7520287eec.6.2026.10.28.14.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:32:44 -0700 (PDT)
Message-ID: <a34090f0-1843-4e04-a3f0-a53a62b1c1fd@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 15:32:43 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
To: Slark Xiao <slark_xiao@163.com>, mani@kernel.org,
        krishna.chundru@oss.qualcomm.com
Cc: loic.poulain@oss.qualcomm.com, val@packett.cool, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261021105434.29897-1-slark_xiao@163.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261021105434.29897-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae269fe cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=hbk5_eJ7lmwJhVnmj34A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: uimzcZYqpWKsLeumjHEPOXsnjJTPOaLI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4NSBTYWx0ZWRfX8N+dLA/vEYZc
 wb6i/vP/b0nzDzadKp2wkHv9Dc4GzokYl6ZY+E1rnm2LFvoDMfjwvPJ3P5zt3DTJjSuPVaWhTGw
 IDeXBsxMrN7dOD8jpFM1pKBJHP3FadY=
X-Proofpoint-GUID: uimzcZYqpWKsLeumjHEPOXsnjJTPOaLI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4NSBTYWx0ZWRfXx0VpO5olaa1q
 qQIfZumc+Ox/Pdc7c3Iy34t0dCKpuh4weKBL/YYutMVWpaacyXFd8UGKk8t952DC8HVqdLkXe0q
 Za99rftOyV0oRIZ4mQE1mtlVk4uF+WZzkrVyJ8QWPXHnkiUz/+Udc52SYuuHIaZWkH4QStpmrox
 zi6VrpdqSeAe/0nNNwP9t3/xdF8ul1QfsKshFVsFN/oLr4z9mW3SRapmwJDAyJnbr5z39KOlni/
 tFgv/FXz+YHFHCegavtSscR2tnL2KoEdDzF3hLmUAybQFJKE8yWA5tZOH/VA8nvQJiePmxtkBF1
 uIbPm0GWcrl1tjw++P7iqVsGizT9QlzmmZRrcM8G8JutARFpZT5SFvyX5TzBYbeGpyGBP9cAJEt
 yauzw//f2l6VasFqVL/Fp84eTSh5EawN0gKpfMG/p5q9sJUVnPce4ragGfprCLt+V9Xb4hpN+jE
 WKcMoTF205XLdKykWtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280085

On 10/21/2026 4:54 AM, Slark Xiao wrote:
> For some MHI devices in some specific scenarios, the default value
> of autosuspend_delay_ms may not be enough to handle the last wake
> event, potentially leading to device timeout or link drop issues.
> This can lead to a runtime resume failure and a subsequent system
> error:
> 
>    [ 8749.089545] mhi mhi0: Resuming from non M3 state (SYS ERROR)
>    [ 8749.089573] mhi-pci-generic 0000:73:00.0: failed to resume device: -22
>    [ 8749.090218] mhi-pci-generic 0000:73:00.0: device recovery started
>    ...
>    [ 8752.940324] mhi-pci-generic 0000:73:00.0: reset failed
> 
> Following Qualcomm's recommended settings from Windows and their
> suggestion during case discussions, update the default autosuspend
> delay to 5000ms for MHI devices.
> 
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
