Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708993;
	b=bd7NNgRf65ckPOt1ik9xYWOI+h5NZjWr+6wKuvj7Y/zvJ6Iv22OejNxQjTjyfYcN5y76
	 yfGMp3vCDmUg9fQkRQeLOYcOXr7vDGZBiOG9AZ4vjI5dIaDdDbkgmWYUwHuylRSS+RTkL
	 Mt2ztxVsL4n78olo4L8EeN7h81oLjVjOy7YJiUUuzFcf8lh8fDJp/hTi1SFQdpieLs3BY
	 6S0TyNsk3WcdMOsineg68TlKpMjk8yMBES+nlf9i5XIF1t4yybvDqzgiBibPU1r9YhZ+J
	 um8Djt3U/0uc2fztPuwm25tRqUxGbsYUGQbvz+BZ4TMJSMY3D95+1CT8JF50LwX7IFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708993;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
	b=g6+vddr+6OSCo94aQGPMJUKSTZeYaNjJoxvukshH8WISEn+z+MPiDkgMAkEIPPxKKyqj
	 5H9k3Rhh2H25cZfVNGARbm6Guxok0dQBhvmNWnfIu+ic5aYlkkJyEP8owOn1CH6GxShtd
	 uLuy7/bwf0UofU9iqeNm7hWtRH9r+CUm2Vpp6iRVrOUP2asudV+llER4iiTRhPGn7Welj
	 JXS01LsnxFlX4vuUZhFIm26uSjsv8w7a7Xv33cevy5HWoVn7wk+QyAmlB7Zoahq+0y/s0
	 faJr0wo1vUt5V3KTqgnP5sDngAoVYn9iIqIX2kxrpuhpJmQsH1bsnUuM/TWQ0IOBvlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28417606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28417606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3CPCVC2850283
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 12:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=; b=EDDclsUCxxBMMyPS
	hSRvJNY9XyOMPssJxN2bWsAG3M5QV3Mo9ybSqfB56MCR9Gvl4jcHa4oZ5CftGMW4
	vzKklfqahmA7YyvrecFKafFk/s+yDkTrZhvYlOk+YO+p/UX0Lwcnjpu9UeCDwQPj
	VAE1xx8G3frBAyWWVkaZ9qhkmBdv0L7ye/k+4iHmsz3U0kLITNPElieRfQVAJLTf
	IVbCfW/CDlXcdVNCj0rEuogCOHzRPWD2XTjz6KffviY66ir/FXJry7sgis8RnXvk
	9NYXWmso4AmHZoKPeB0cbleLnfp3F302T6DhK3FdldgdcHLyquf3Tx4gJ9eJMKow
	3nzbww==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2ack44w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 12:29:46 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98c73709b84so3009222241.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793708986; x=1794313786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
        b=gugOoYN2/WM/kDivAuJBtXpihzzVU/JUJS14+FC7Uhqwdzb0ooMCyd7j2rBSgjpJo2
         L89FbR1PoSRMS6cqxm8NK5ZipdUOkd/ku3vUUsR6O6LM/+nBnMfmdE9Ms/YTti0kjO1d
         6Mv+HKKwzKc/21lG0ENyZQ5I5AKSzW3t1Tv7Y6z1kSggyzhETO+IcImhdmCuPcWF4ocl
         SAvtUnqKl1dpH1deZ7Tm302bganlXr1ayJYSo3GoOzXGIOtboF8lrMQEhkZgqA/Uu6rB
         LfJgEjGsfgCcd39P8fqs8aKLI7nNrLpgC1gIPEI7cY2kNwR7Fd4TGKJb6KM+0rUsSC2q
         V7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708986; x=1794313786;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
        b=13vGvT/0L/eNDcXd55nEIx4kNuE9J7txobFjJRrzcXSbs6CQFiBOWcG3SMmHmEffvl
         fcanCgW1grhKzJfzmcFkY5xKGvbo6IyjErCAdR90fxuf1P5a3+vfrSGv+mj8vNE5GZ8Q
         n4j8tyOX1g4skbpkDUnl3jfl2fvQNArBDTAjcew2Bt6bqCpjyz2TN+i7eEI8yBBEm2an
         HXs/3xTWd85zMCrK0gEQxghKFF+5V8iX7C0EofxOiXjrJ7b7Erl/Q2A+tyD0lUWGgXX/
         xr0jHaFVOymesr1xI0+XnVcdgXmuJAdzbFWWLkg/kkuEmUEm89FCHPPF8LRpiGZvJ7fz
         vssw==
X-Forwarded-Encrypted: i=1; AKwUvBzVa/TBCHRjIPi5XeVqO6LwoxrfJbcZf2g3AEn28MrhGBcg2ZwM1w+ZSDpgOc5mKH873gt7T2I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Fq1EODCJaoK52DaWKc5vtgrj2BNiiGQmjtCwxTJVpH4EL2jXZ
	EUyeKttERw8mcg2p/kQ8yYe2Olu8nU8bUCQxOICdJpafUaInGmdjfVgwoUi1e+aDrzH85NqaQsv
	VHGp2ytEvJAp8PO/ySwAYB5thAy5FXJG8+r65jEVjAnXXdluKKxh7EBBo3SCvUiLDauk=
X-Gm-Gg: AYBFou0ood77iWW5gj9NrL4HpV24aUGnL/C0xsDyt5oPC6M1ZDilhf8slYyC0xUzflC
	z1ooaiAdvose/ja+sUBdDF5O/AmCLxWLsByjja3F1w9ED8kBTrNmpx8s4rasGRPg1EokA+TbJuD
	p9Hk5iZCKIKa89eFMQ7VogSbpOmv38nhI6fnVSXkgqIZAdC5dddlfGYBp0S6o/EgPo8Z2OljWgC
	lI3vc31wwSSTts9+1REpGxeVek7YJojaPkJ6g5GkJbQCTk4omT2zl8cynAvsjgVtcB3p5jnBn/D
	E5IU9PJPlACIGrm2l3fIuJAsg4CQbejvdkkCc6f8loLITrZVwnSoAs438i9wQgwf5so5rTn1WBn
	yY1Fa5g9SGMMvybHHATkfVKy3hijBM6LW+KiAlD2FPJuVLS+uv3ShkqDAZ5VFeQfZe0B7fDq/B/
	LJ
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d07273b428mr4586995137.27.1793708986032;
        Tue, 03 Nov 2026 04:29:46 -0800 (PST)
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d07273b428mr4586987137.27.1793708985574;
        Tue, 03 Nov 2026 04:29:45 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d5dfsm28910586f8f.3.2026.11.03.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:29:44 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: Re: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
Date: Tue,  3 Nov 2026 13:29:42 +0100
Message-ID: <179370897915.27908.8240780682152468371.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9d3ba cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KLQxzaQ-LYvYA5eWPjEA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX1R7eSVQNY+FM
 fVjJyeuErfLkMDEt1GSCa0XM98bpncJMKNcrNOReFJG+pFSU/uhJN7c+5xprgSUL7lhHqcLjeFw
 KQMfOrJPP2orebFbhTVdgYR47tJM2hL8BDOi+mUQ/1QciBpnZeXo84BchxFkO9aSvQJ3//2eQ7h
 O/JcOe9xMNyu9B3Id/ascKMaimY7MJjtsDkdHrqM18A5psJnOmbgIyOdEWOZz4X8za7wgvor9U9
 zJ6TR6H/81yrsE2DHD+u1LzSpmYb0cQL93Y8a7d4KWdFAX6NpEzBEyjV+HpWk4zFAC+8ubB9eGh
 ZUGxqP9lQ/37GFXthc7LIRJQnXosHG8x3Y2y4F+52hiwj2mMiqv9EtOA4WEoqRDMvzh+wXiEOya
 uVFxyspn2rkHi8jETm1/6ijxTq+y352fXwYBsMtowaZXonk6md3iWIlR8ArPckLGCveGL8If0OI
 2pMgPqmWaETDLCNAI8Q==
X-Proofpoint-GUID: WvyDXkGV5Po0Kxc6KQQeUletiqhyuc-G
X-Proofpoint-ORIG-GUID: WvyDXkGV5Po0Kxc6KQQeUletiqhyuc-G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX8yhYzxupiotM
 J0cHKGvC7lMuQfC9/nmOpHzIWYCqOGM1CZNkTfgGdl2p/pnU98qqsHSx8FqmU6RIg0KdF4HEnVS
 ujAsDiVeTUDY0Zb1Kd+cX0OtSc/YNIY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030049


On Mon, 02 Nov 2026 17:48:00 +0800, Shuai Zhang wrote:
> When the WCN7850 is powered up from the Bluetooth side first, i.e.
> BT_EN is asserted while WLAN_EN is still low, the chip starts from a
> cold state and is not ready to accept the first HCI command 50 ms after
> BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
> hci_qca does not resend it and fails after the 2 s command timeout:
> 
>   Bluetooth: hci0: Reading QCA version information failed (-110)
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
      https://git.kernel.org/brgl/c/bd60a639b621453fe37b780df4b6d3a13f981f13

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
