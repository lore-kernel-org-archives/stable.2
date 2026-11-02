Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613554;
	b=B2mtUIvCedFKQNJX86ZJbvl/1yoRy/STbdwxePxMyIyCY9buRWRa5o7TmKGipwevklcH
	 KWDEsmapNOOexEX/bzjNIY+2oJyTS6A5VKelhVEKp/WEpr8t4rVKXPScHHiK27/f3q9nE
	 GfdT01H0IoFTq03G7Hxxsawyt39Fx2x0jRrO0GNXU0O8taNaeGPeaM4fBVngRCb9ww+DF
	 ZCfly+T04RoU75CN1QalRAW4hVAJBP6KhAEmqpbqVS+jlbYi1/EyYrHsn+1ig2R2o52CS
	 bpQry7Edp25URIgYapyNW3eurWBXK8/6K6fghzqGqVvAQ0CpGkihiTZGkcjMO5pESNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613554;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
	b=01Fwkgyycq+2xpxC6epv4HzwxcA9QnMeS29L09Nw2bGqGDKlvo2x+i4O4jJKR8jlnORV
	 LeV08UVdJ9JdDfwCBPkS1ZjYsxttZLwmqpaThzvt8T5p10xF5+TL2Yme3sNO+mzMPWTjh
	 Jq/XcvS2vQc1V58bVw7g/AauajY8FfeeXi0hgHSDiS69cuLdDHfsojQA9Q7Q7V0rgFp+1
	 pim5DigtrnARji9GYm1AZd0hNhFa5d7QEoWXpS50mcLZ4ZvGJreG5KWal+0cwNPOXSp/M
	 LggjH1ixIIcacG+VmhtXcsEFSy5DiyvVQ4nl7AOEfxgtY4WZurjlrSue5YJEfr7avOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctdHG2pg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHzd1pG2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF02606A337
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF02606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctdHG2pg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHzd1pG2
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A7Fn260659
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 09:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DvLqP/tFCRw+lDS6WYFmF22W
	IsggD1RJMNZO7NQX0Jc=; b=ctdHG2pgkaQCYWdXQm7JOTj2bSHBkT/Kdf70Gzfw
	vfeGb1ztNVIX+f+hBwpNXGc732fuW673AIMV72by+Z1LoNgJgIx1M3ZdiIbGv+zQ
	9y19vQJ+VpPpsw4/14hqmAMg1vyr6kcg1JarJZWCUVn6e3qUAcg027GTqosZ6889
	d1ew500EPfPPzuqftIbOjo770OdBMtD3Ql/r76k09+LlI7MReICFflm++aLQXPDp
	BUN/ksGQb3w0oVzm0BdunQF3DZzA5KHiL2WBqvtCllJ7xAGQ2h6qoBmjVjj5r/ks
	JWgJ1HV5HM0NyP8jKo53WpIKgv0xKcIMyc8SF3VObcBuaQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvr76s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:59:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91becce058aso60604176d6.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793613552; x=1794218352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
        b=kHzd1pG2eqtms50mvSIRtxABHbW6bbKsrPDc2Mbx5dlY/5dZNRjnn9p/pTbVju2Xjn
         vo13Ne/9kBdNKi1i+6Gq+NvC7suqZoNR2FCbCkK7c1kxM+jkj0MKfzHEhIG/m6YP4iKi
         oD9mdavN0bUf7nmQHSla+W/KIc6GeJrLrs6l4Z1zUOgR8Z/9oDzHN4ZHJz3UgIbQ2c2k
         pfI6hPcKpZvtnta4XZuvp6fu2HUxf8s+Zu3JXmsmQcgSjrbACDBkGDx1l73vqlvwOpv2
         wUTs5edpeVMamCt0qXZnVDv1a/Qw4aPX8mrrj5RzJ88M0AnkBQjGEh4tOb0mZ6hpaGXI
         xklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613552; x=1794218352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
        b=cNNG6OpgaYFVZSxjkE1Eel0dH1DuKu+wNssD9qi4kIp0bbZUZSZNAq9DmWmF63a+pl
         CYvLayveJKHfluO/JiIQVoceYt3HfW+UuShK/AfE8iV1TKRRSlTz1zQAb7DllVnRujlA
         GYgDppf3PR2pDoaHTW3P5E05oFA+pIvv5pJbKnlYl1XgAyXJZKWaQu5dekfS1nrEIDIj
         D3wPMxv9hIKkfWM8UZcS6d/ePZvuv4YQT7WBgo1XtxrpsRgq2gJZIVvG0f0cfxhLQfkA
         UI4CG61LTerF0sYjAYp2lPFZ3fR8dZc5F1R+0QQy4Ifo9O39ZyKKF3pVKG1Iizyc+eZn
         Z1lA==
X-Forwarded-Encrypted: i=1; AKwUvBzaFXLA4Z7sjaeRE17qPwU7XVKm1NuU8UkwHwciNJtQSzUewe8/febMhsrqHVrTogbeZQ2VEGk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVcl8Ik3MDczT/ovGmuABhXAD7LbmG3I8rdfYHDZncZw1agT7s
	SBArTWiX8b+v7pRNg3dFLN0dwGfFqBVw02sxJuzfPniMaY4B4skQkBc7IyDYX6Tn9ewDch4yNKI
	YVRRYrqR1RTzsbOK/JpYAYFmd42K77eb02C2BwwD7CjLiA84qBSImAGP02+I=
X-Gm-Gg: AYBFou1JDPq08t/OcbHKZCWveD8KHQQERafb6aAGxq5JSNCHYjMW1NEA4tsyneRrHI0
	LQxVcNT+rZUxx7xr7QeJm/XOpBBzvRbKwA5TQNlx1A3CwlyOUTB7C0OyaZm68rU7JDQgPbd8zYz
	mDMaDym+OaFWjUQasnkFuMUfoZU2Co1Lrpay5rtPAOoPZ9UXbuhu21g5tBXvA24qon4n+rbDaeN
	CXhYKoMxHYy5ZC2obzNt/rPVCQ8Bvw2At3HxIQvwbWTC19zFI5oJ4cHUG7w3tQXbC/E1bmd2Pl5
	/TRt5Xlm5dZKnEa8JilICWf/CpHj50uNMh0CMJinBDrB9FX6+k+LpZUe5QLKHwuwbH5toZ5lbl0
	K+dXCbru/rrNxNjnBEjG4iFZ4y2aWkT9yamoEtXcPS4OSdDYdJZNIICl03dl4cgwAPxIIsCC8zi
	BINL+HXLQ/fBZXgbZdFcx1GwuuIp+OAXVi65Fl93Ua20HAnU8wsAe2KCmhTaGV
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id af79cd13be357-944217cece5mr1518816785a.69.1793613551875;
        Mon, 02 Nov 2026 01:59:11 -0800 (PST)
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id af79cd13be357-944217cece5mr1518813585a.69.1793613551287;
        Mon, 02 Nov 2026 01:59:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07551e2sm1516515e87.84.2026.11.02.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:59:09 -0800 (PST)
Date: Mon, 2 Nov 2026 11:59:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org, Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: Re: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850
 power-up delay
Message-ID: <6n7g6tamgj4q6k4sslwllqnidobapv7groh3tqc73lmzj2xw6y@e6ya2ozqa3pc>
References: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae85ef0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=H8z_xw01dn0BF6GSKEAA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: PmEKnH8bXHM3fGAU3C2PSdMwSEYYNUXr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfXwIyQQTlYyjFh
 UrXTlNbYbI1zrDVV6BYLZAMkXGrPBw+Y2b09oiMKN7TblbSqf6HuFNFymvAP2fodotNl75n6Uze
 rizbE5ZDIkhME6h4IrIH6sywEwWypQk=
X-Proofpoint-ORIG-GUID: PmEKnH8bXHM3fGAU3C2PSdMwSEYYNUXr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX3x/fq3YKVXR5
 UIVmXxo6KGI1AfBO72qU6M7Zbuc30hkiYgZXWBr/TeQ6QSjt/zUy0O2xO2YX1XWMfq595p1g+aX
 7353BXSo25Yrnh1CWCCVM5OW735wnMr/e/xNWZqiVfZv4OWNvxj42ov5uH9JEOAoLzSZlurMd3e
 GwPO+6A8OyKloBUYhqoz7Te5xWacYeIZe647YPGbpvKI6FJJeMFB8vfXSTcUTp08bEhsiO2ALJV
 4p7mi67lq62WSaz5rB3o4oiRtQ5V95ab36dlDhXRN91EG/opfykUzSFEoOU6AwBcOLcL8BUgXB/
 9k4yZnxL/R46tJIhDQR36y+oKpQn5sV/QFcRDWJUX3EBgPdbAg002qBix+doKZ8x8Qk8X2NyRBO
 kvSDOv63kmJ9kbe2VZWZYYU4GFZnZWP5HJ9x+CFsOAu+j3Jc1/gjcIlHtcRAbA4xVYsOMq5dXpT
 OH3Ufb/b2kfle/XLcgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039

On Mon, Nov 02, 2026 at 05:48:00PM +0800, Shuai Zhang wrote:
> When the WCN7850 is powered up from the Bluetooth side first, i.e.
> BT_EN is asserted while WLAN_EN is still low, the chip starts from a
> cold state and is not ready to accept the first HCI command 50 ms after
> BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
> hci_qca does not resend it and fails after the 2 s command timeout:
> 
>   Bluetooth: hci0: Reading QCA version information failed (-110)
> 
> When WLAN is powered first, 50 ms is sufficient, so the failure only
> shows up in the BT-first ordering. Measured on the affected board by
> which enable pin rose first:
> 
>   pwup_delay_ms   BT-first boots   with -110
>   50              9                9
>   75              23               0
>   100             21               0
>   300             20               0
> 
> Raise the power-up delay of WCN7850 to 100 ms. The delay is shared by
> the Bluetooth and WLAN targets, so WLAN power-up also waits 50 ms
> longer.
> 
> Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
> Signed-off-by: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
