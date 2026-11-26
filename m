Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683418;
	b=0XF0PuTsVCeZWBTQMtpQMkc83AoDvm34DddA45c1sfoAB9fcCrrsb9V2Qe1iFmDdTbzu
	 krd/ioHuVXU98+5VWjnWHMbbMnL2jo20MMeOQz0c3VAAcwuPgFH33c3wsRH/qPMvETh4v
	 ink46o6UVP1xXJVk58uFwnqYU4rqhAIz07syqZIB+L5QdgNDT7+yFz3OtqA/u20pvNXoH
	 Y8BZuxDAHCxKflHRtDC0LFqqKizunskjVHgtAiNwJOFm3LR6W1ZFCI6OWsYClJMBrpjXo
	 Ieu7ExpNRa6J71LPm+eS6aXT1dIQWHn5x3LeEKqk5dT33r3zkUdv2oBBWVpxfTR4ifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UT7V93BmJFEXCnpajmA/sL54AJXKncbq80dRI3AFe6w=;
	b=RFClh3m4j7gFTWpBIDhNigAvQCV2imkiwPGEEzbh/YtJqjtlBgL6leYt5R9wyEZjAMRQ
	 HXgWikCV7rn8yXFoL2LsTN/iwdKKA04vpfvO3seIR0wBJZMfkLng74hgaj7Khi4ICr/ba
	 V6pde8RRdcoPy8CWdBXRvMzF7P5NDoXsXLTGlsp/Pwmf3P5ySzvmY90555oM8eLkLAR31
	 Wwa1lb+bPAzVMrLhgsufHaavCko8Eo+t3cfwigDVv8NxvYMFDfgmS9NMydV4DoOAG5iFK
	 xcyUYCBCjzXE6bvOPqaGaN+qyJKQxIvdif9r3PPA2QJh33e67b8C9Oncav/xn3cU8LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SPb648b1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JLMvmlX6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3E606A336
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA3E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SPb648b1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JLMvmlX6
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B8Sc919520
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UT7V93BmJFEXCnpajmA/sL
	54AJXKncbq80dRI3AFe6w=; b=SPb648b1SPV/mhrmWjqGSGxPY0mJxEpTEJnesk
	qxr4roL7zxCCXsVq+DaR4DNzjl7/Nuz9Pq95YuPnIYptJ4ZLkzVidkAP1MrW7x+m
	Nb0mOGTFvSGS6mx5hVxhlqRKwO7cfkqyqwfLtWQKZT00SOrPYk1lQ8ZNJ+boyTH2
	77mKuymTYkCHykvN7KuncSU6Gh9hw83QV82kEfkaMorGbHQd2dNo0+A0xhTcU80d
	fpJzTW/NWTVNnWPvzSdgDgXt/tVgeU374kQe5Br6auqmRep5WqNQ9cV4+CXxLHmz
	T7HRKppavfk/Cqqg8V82wHq5Jt/Qbo94Qs7Q282nN35zzAyA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y296c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:56:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1f2fafeaso753716685a.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795683415; x=1796288215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UT7V93BmJFEXCnpajmA/sL54AJXKncbq80dRI3AFe6w=;
        b=JLMvmlX6QpQdd0nL51w333ElbPFBdsLeUE3+Pof4iogAVdWIV6q0lQswAvvzaTP1fY
         WJcI7dWgqI5zbx/TIpQ35UTncVKlavjACujBS2wG9EuB2t5QzquuZlLS2S5W1YviOoCa
         lkQrVgk4PFa7MpfZPxu6NqFznTcFyQouCiDAaaWqRVZQEPQQMJ2QEBhvbvVfGMw95SYN
         KhoHf96WmvTaTMSBJ0MWTaPjcYOky6aKf2Ow4e4aFhWiocLThkSaDTeh+f/MeLlb5wgi
         KreGKAO/pV6eH6Z35HTtR9nqKcsIHYY4NU5U7pYDolSzjVo+ScLuqh+UCU7hMY1e8sjS
         IkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795683415; x=1796288215;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UT7V93BmJFEXCnpajmA/sL54AJXKncbq80dRI3AFe6w=;
        b=vl50WdI1NUOciMLWC7a9fXoWyP13+myGzyp5VqSK3lCjRKqaRgw6LXJjkRoRS6euhq
         MMjGF3b7nzxS/Q1/4TizJGoGSNU03c1nlo3dmC+pn6IljgHH3+FbvhZE1ARWZk5KwXnk
         ArmTdZJT7tSvm0wx75a4e8S7G9D8UjhICEjvCyHMaLETaJXk42D8V62GUXXDi2oOmWog
         H63Qa01wDUJDZ/qUcFAgqEIvfGKe2n0QLVp4BOOP59wdKezfzvafOyzq758tRnUg7WfZ
         FokaV6btqjTEC5JY0iADhptlkykW65tbYeeMzcW+NgDc02NW6vgnDJ9GY4vfFaPURv/I
         8eWw==
X-Forwarded-Encrypted: i=1; AL+hErFeSwQCy1RKW+CVfcku1KeSemWXDDluPGasBxlf/NIQrvxQ7px8P+tVj/9AX7lNxgYdZkaLzTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g8WpAFE8xmaOA4eioqB72avnrJq0xYrpQBSI4zx0gc7+FlHM9
	NgcZGqGhIsZRXdyzQ2avzNc5niU8EOJZvcDkNR2ZrI1diM1WfWcgR/aoiVkSKIX3VWQjbyADl6t
	ft44SVlE6hOR3ns0UVFyv9rwtVUXBiKWQOxJILCvTi3KMfkjtTmPNpOAhg2A=
X-Gm-Gg: AZFdTZeTRRaasuDFlIVjW3PCmiUMrrcIQgHFwcqKTX+Uw5c9zM/sf5q0jjRx+ErcYDz
	DXsqCI5pXE5gH+9shOxO6UGoGG+zsPCU29Gd/ULsPpML5XpJcQ3LAUI4c0pGA18ZzqCaJlNxHqL
	mH0hDLWxqbPUd4GR7jMHTxzNEzGOaBgBVunergd6AZ+8sDzhRKD3GjybjHcKLqcsLTdqB5eGOQ/
	l99UmDylW2i3IT8TYNn3ijwwT4ORT7ZIBaAASDg3wm/LfR8zOjq/Iof4ho1FAwEHWG8l62eJJLk
	T+9C0wB4Otxz5yAgdqrTw0NuGXR+SgZjx6+9qIuFEnCTCRUwGssML2Gr0snayn1QFaD77pJFfuL
	aYZY6FhELPG3EghN8CdUQq+cBMCPPPdoJYNMEaJDQm2wLMHEFxqL27YQxJ4CWEA==
X-Received: by 2002:a05:620a:29c2:b0:946:c55c:dcfd with SMTP id af79cd13be357-949ba965a4amr3395058085a.14.1795683414840;
        Thu, 26 Nov 2026 00:56:54 -0800 (PST)
X-Received: by 2002:a05:620a:29c2:b0:946:c55c:dcfd with SMTP id af79cd13be357-949ba965a4amr3395056285a.14.1795683414378;
        Thu, 26 Nov 2026 00:56:54 -0800 (PST)
Received: from localhost ([2a00:23c4:e5c9:901:c496:8838:86d0:bc8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm615440835e9.8.2026.11.26.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:56:53 -0800 (PST)
From: Christopher Obbard <chris.obbard@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 08:56:45 +0000
Subject: [PATCH v2] soundwire: qcom: Fix off-by-one error in port
 exhaustion check
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
Message-Id: <20261126-wip-obbardc-soundwire-qcom-fix-port-off-by-one-v2-1-c424edf85968@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OSw6CMBBAr2K6dgitKOjKexgWbZlKjXSg5SMh3
 N2CN3AzyUvezJuFBfQWA7sdFuZxtMGSiyCOB6Zr6Z4ItorMRCouPOUCJtsCKSV9pSHQ4KrJeoR
 OUwPGfqAl3wMZA2oGcghZrlNZSMP1GVk82nqM2h58lD8Og3qh7rfKZtQ29OTn/aORb97f8ZEDh
 4IbLjN91flJ3imEpBvkO240SRysXNf1C+bVkTgFAQAA
X-Change-ID: 20261012-wip-obbardc-soundwire-qcom-fix-port-off-by-one-47c0a8af1c5e
To: Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=QSJ5w2mIIkPrzyPdlMwV2Dpxp0igj2Xpcy45KBhQiGU=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBrB/RPR4AcjQPcBdipmSDZ/SGJhMpqJ0xB4C6wy
 zaY6EET6FOJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCawf0TwAKCRBjTcTwaHBG
 +DBkD/0cG38qB7wvKSJkMqRLTtonxrq7X+E7yUkbLOwE2GWcxr16iparwoe9f0PUbhrHHEHAqey
 LRBgvDnNY14Z7mybu/h2TE6zK3kemGtG3RDA+TxXiBQ/+LqWWs1puRytu0FEaD1soH9nzbUzSVK
 xE+Ii208Zbg9FggPAs5jnF+DT+jNBD1G02yN2WYyA04zIGmMfuMf91qbcrcFu0WtC4sOJte1LTW
 4y3OxVwO/8mHXjJXMu99VzWlxhKpU66inSZcW4Nc1HJEOGYeQzDIw4u2J5RmsdFtDGNZx9qV5xs
 op/X2ZM9cOxom460YamwaIy5YuZC9rUfMyagxWgN05ynbDz6f0TDRkSJBjUqEKmCYq7kJvzarYj
 H2Nf88WXx5FqgRhydFwc+v8pmpMRV8a9eBknxzCtadVHHEznCavV7CTa1K5iOPbAQFGvukSEOyb
 onU9KubPz4Tzn9pviv9Mxw2lMqORKpeQqSCReh3s7GnfSykihOan3Zu9gPzcUeapcUD5vrQOEgT
 75ZIjMEpmBLPZ6swYEfl3kWaP+vZjz+eLqh/RwKSM87zhO/EuL8tCTFwZQhtX+qTiZ7++s6m8vW
 4DTzB3jlpkH1DiJh1YWz/7swNhujPtsp6xmAIFxN3/0UiOlGyQuhAhJyWIz/kWWnJFrLayRvbSc
 6zxyH+fmCHTZp5g==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNCBTYWx0ZWRfX8IDPXL0UkBUX
 Qb2xyaH1chqtkxv86dClfww4EEx0jT6X0sBpYSxye6VAut+sI19vyUh8hnHKo+VVEOikgDN7UkM
 EbDjou5YvbwrEcV65v9md4Oj7DAI23qQMF56Eygws7vODqbzXueBKjOP7tvAqOomEuAsScJsvOW
 bjX+VFkkee4yOrhXL/cyvIskeQY5etrlO97P+O7+qR2cT2puFcZYENH3R/t35KBliIR1YUiHp1a
 Ggf9fB6zRE20Cgoi+6EoD0740lOQ7WrpyZZH5DNSG5RcgE01o3PURmA2crD9ybJZrKTk5/AkKwn
 vbm4NNgZa7jCksA1Oug+4IOrIg9eENLx+xGNDZYfGXIRXF9RJaF8hhfnapUuaWwKaz1gIokgvC8
 lp3ZHBzYqf6EeClIMDii3jDLXLoYuRx9kDQ+2O8MY+DliS2TmpdW3Eumzczu2hPm9Di21IvjeRn
 lMkwMNw7uv7qxI0idiQ==
X-Proofpoint-GUID: C7JnCn5mK0f28Jp-AW6yJ6hF04XAtgbj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNCBTYWx0ZWRfX+9PaBHlqf/ch
 qzbOy6t68Elx0fIhpsp85Jdk+cg+H6BuvLlOwQDqokReuB2iiN1Bdmy+z9At1GXp/xoXmkQEoOp
 DkySiBVT9X8BqhzNNMZNTi89VKPxqTQ=
X-Proofpoint-ORIG-GUID: C7JnCn5mK0f28Jp-AW6yJ6hF04XAtgbj
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b07f459 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=A2cS_Xtm9gsuIjapY5kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260034

Qualcomm SoundWire master ports are indexed from 1, with bit 0 of
port_mask reserved. Valid port numbers therefore range from 1 to
maxport.

Commit 6ccec91c3535 ("soundwire: qcom: Fix port exhaustion check in
stream_alloc_ports") changed the port exhaustion check from
pn > maxport to pn >= maxport which rejects the last valid port.

On RB3gen2 (QCS6490), two WSA883x speaker amplifiers are connected
to swr2, which has qcom,dout-ports = <6> and qcom,din-ports = <2>
(8 ports). Each amplifier uses one port for playback and another for
voltage and current sensing (VISENSE). The right amplifier's
qcom,port-mapping is <4 5 6 8>, so its VISENSE port is master port 8,
which is rejected by the new check.

Since all ports in a SoundWire stream are allocated together during
hw_params, this causes the stream to fail with:

    qcom-soundwire 3250000.soundwire: All ports busy

The -EBUSY propagates through hw_params, preventing speaker playback.
Disabling VISENSE works around the issue. Speaker protection is not
enabled on this device in upstream, but with AudioReach userspace the
userspace PAL mixer paths enable VISENSE on every speaker stream, so a
mixer change alone does not avoid the failure.

The original fix addressed an exhaustion check that could never
trigger because find_first_zero_bit() returns maxport when all
searched bits are set. Include the reserved bit 0 in the search so
exhaustion returns maxport + 1 and restore the pn > maxport check.

Tested on RB3gen2 with a v7.4-rc3 based kernel and AudioReach
userspace: with the stock PAL mixer paths, which enable VISENSE on
both amplifiers, speaker playback through the PAL speaker sink is
audible and no longer fails with "All ports busy".

Fixes: 6ccec91c3535 ("soundwire: qcom: Fix port exhaustion check in stream_alloc_ports")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>
---
Changes in v2:
- Rebase onto soundwire/next.
- soundwire/next now has commit d9ea256ee889 ("soundwire: qcom: Prevent
  pconfig buffer overflow in qcom_swrm_stream_alloc_ports()"), which
  adds an nports >= maxport bound on the pconfig array. That bound is
  separate from the off-by-one fixed here: it keeps pn >= maxport, so
  the last valid master port (maxport) is still rejected and RB3gen2
  speaker playback with VISENSE still fails with "All ports busy". This
  patch is still needed; keep both checks as
  pn > maxport || nports >= maxport.
- Add Cc: stable@vger.kernel.org, as 6ccec91c3535 landed in v7.3 and
  was backported to stable (Srini).
- Drop the claim that disabling VISENSE disables speaker protection;
  speaker protection is not enabled on any upstream device (Srini).
- Give the concrete swr2 port counts and the right WSA883x
  qcom,port-mapping from the RB3gen2 DT.
- Note that the PAL mixer paths enable VISENSE on every speaker
  stream, so a mixer change alone does not work around the issue.
- Add a note about testing on RB3gen2.
- Say the -EBUSY propagates through hw_params rather than naming the
  codec DMA backend.
- Link to v1: https://patch.msgid.link/20261012-wip-obbardc-soundwire-qcom-fix-port-off-by-one-v1-1-81f1a4c9c73a@oss.qualcomm.com
---
 drivers/soundwire/qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 65add9a74ffd9..05311cf639e4c 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1461,9 +1461,9 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 				if (m_port)
 					pn = m_port;
 				else
-					pn = find_first_zero_bit(port_mask, maxport);
+					pn = find_first_zero_bit(port_mask, maxport + 1);
 
-				if (pn >= maxport || nports >= maxport) {
+				if (pn > maxport || nports >= maxport) {
 					dev_err(ctrl->dev, "All ports busy\n");
 					*port_mask &= ~allocated;
 					return -EBUSY;

---
base-commit: d9ea256ee889f3db9f0bd07ce5d114ce92e31b4f
change-id: 20261012-wip-obbardc-soundwire-qcom-fix-port-off-by-one-47c0a8af1c5e

Best regards,
--  
Christopher Obbard

