Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6F3CFF44
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478817; cv=none; b=Web4Nx+Vt0mD2XLd0ENnySnuGrLqEnoHadwhObBsBz+Dd9lc+QrSmbFeoi3HUvCWk4bNgg6eSH8xru/AOuqWjIa4gGH5EMpZb1gkihwEJhiy8UgCHRvot5LoPlFhynpkfxYcS8sXMrH8l4gUhjtGjSduNRII0/CBTwhUIxp+CM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478817; c=relaxed/simple;
	bh=iYf0Z3IUg5KR7a1qHZ0mBPi3Zdla7UuK7O+KESklDX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Igmv4cam4iCudc3XRFh4j4upfY7clauikYaGvCCWjbYV/jagJdI+31L53twRwd+7p0/tArkbk+q1rPvOVi7gy+1kfXv7FGUl5M+OIuAdQyZ5+6l/e8ZHJNHXhheRH7MUGtTRdPPtrq7N1mYv23+zmAZIRlter4HhOj2Hy1rOEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kjtMXzNq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVnT7rZ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kjtMXzNq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVnT7rZ6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxuHY4005309
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g2OwLyaZtMOAIiCLuhR+Wp
	6NOjJhPYFA3tdfLkK+WY8=; b=kjtMXzNqi7yhVkilmzo0cTMPVSWjw4C1hv6fBf
	lNzwrD7cYwv+izQOfKOgrICB9p7KxkOWec2qfPq0UYWIA5FEAvn3oc2TXF4sPJcy
	GRXioYi3Lui+tAOJFB1ru7fHX4RMrocZ77FcvQqegQdP8D+ueQhua6JLPppcvcZA
	UDIycYpji1PEQcW7jLsjNPC9ILk3w8FDQcrcLWO90RIFY6WXSwiT6ow0vml9r5hs
	j8Z06Z6Iq6UylZSg2I0P8RVIaykyIgWlbHcwlYvCykN4dwnD/vvBG7DVtBiFdGWG
	hVOgltZOOETEoa/apZQUYUnKzd9tvYiR8bFnYevMO3pvL0qw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xts0g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:26:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-912330dd4dbso19367546d6.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478813; x=1790083613; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g2OwLyaZtMOAIiCLuhR+Wp6NOjJhPYFA3tdfLkK+WY8=;
        b=eVnT7rZ6ldkKU8tVSG1vNm4K2BIf/UKH+2Xf2nJuUnXCch54MhZRwAblL4DPXZM1sC
         67tAZeofa3mo8o+tbI9BLJ6T33FHSwztcks6qG5N3KwQ5WRmJIujNuiMbCc7ntyrzJiT
         4WIgeby7MLG99heKbdG5nZZa5z8NnFXG/xt+Ir0pEo6zBXa0ec0RmYPtWwb5K7f/Fypt
         kZPoUPb9cQVfHZpWgPmGiAydJE36vbpWoabKo8CYeidLQYg84B3xPiajBi8zGZFzCh/c
         me/lFfiLCVBHj6WrypsWuWH+0VCIOFFlE1EOp+GQAZiih5tRmxnSlMhAt4NZXh7qQ/7Y
         8R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478813; x=1790083613;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g2OwLyaZtMOAIiCLuhR+Wp6NOjJhPYFA3tdfLkK+WY8=;
        b=Y2aIb4xnD3waKOj/urWoBmnIUA1j+Jw6Sawx+k1KiaRcA3WAMN9YDX1l7EdGIGZQEf
         Bl4AQ/j2daPiNYIXUePEbHFPBTJDSqwKXLlzU9C1FgK2Qcy8WLJcfijdFpp0iRWGiR64
         wztnxjGXBhcV+E5vWUhEJq7eKM2fzZ7OtuDQs8BorRYdoZ6ckvK+32EJK/AKtIhUMe/R
         k7E2qIZYlNpltThKOvlOO00IyijPO3gJvMCqnBh+Yr7NsMFNWBj+Ib23iYgeNHlQpVq/
         f88lM5IuHF7U1Uxav4vml1rlqjUgpICrW02T5gQwpeg/vMtpWmLST+OEcjLFRzYNu+jv
         czSw==
X-Forwarded-Encrypted: i=1; AKwUvBySD9lN0HDGdtWIERxSJLhCQAlLwIjmmZ8WdKlYPlExNAgZt7Nr6XHZ5EDfJ/ZZxWCpdNEUDcg=@vger.kernel.org
X-Gm-Message-State: AFuF++khs+/OBwyHNJuFVZfUujBPZf+IL5PirphJPMCLXs/ctuNnTvVQ
	wK9Phoc2vDZHQ9VOQ2Cvu4XNHz9YW6bPAC5KhCh81HWX0T1Mok9lf6LBR8G2mw7BLITz6Zti7+N
	tyWXuo7qx4Vfmff2pRoITT+0DCB9MsCHhaPzmTX1eTc49wJXnFyZtztuEYZhgPDI99uM=
X-Gm-Gg: AYBFou1N9a5UurRT5GSpAnlL1/NWOHxw/NWPvE+y5CI1lyA+xfbiv0qjVvbDH9au8y6
	Dl4rQwK3Fe5Ano2f5WCLCbdey2+BZjsehd4niK/6vCHNfHSUQr2Ma+dCCWNUqeqMVxjMB5qfMCX
	A/JkjAx8SmfNB5OnT9SQJiw2AOJLsVF7UMeix1YOukFsipVpeSM/vvK06AjrEUtSampmt88yBWz
	64NW7D8ut1zTDy1nrsBgpVW5AY2xxQxc/DLtZPARtINop3vEodyhNmzIJYSloeT9HQa4mTCplkv
	BYhpH8RN2vyuDoHcP1huK0TAzxW0RuRvVcUVIQCTiu2rWbeDiUJoiNWeQSsKQsUrRJbEgW7MEBj
	2IkkoLgOjDWMsUd4Pf93AeiDMvU6ARaEyvcPj
X-Received: by 2002:a05:620a:6914:b0:939:f861:8836 with SMTP id af79cd13be357-93a34647d22mr466464785a.20.1789478812828;
        Tue, 15 Sep 2026 06:26:52 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:939:f861:8836 with SMTP id af79cd13be357-93a34647d22mr466459385a.20.1789478812305;
        Tue, 15 Sep 2026 06:26:52 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm1248906185a.37.2026.09.15.06.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:26:51 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 0/2] qcom-geni: Fix QUP Core ICC votes
Date: Tue, 15 Sep 2026 18:56:26 +0530
Message-Id: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJHqWoC/42Oyw6CMBBFf4V07ZDyCBFX/odh0ZZBxmirnVI1h
 H+3YNy7meTk3twzs2D0hCwO2Sw8RmJyNkG5y4QZlT0jUJ9YlLJsZCv3YJz3aAKQMaCV7Z/UhxG
 iC5giy0HZwFC3UhZ6aFBWWqSpu8eBXpvm1H2ZJ31JO+v22hiJg/Pv7Y9YrL2fsv1PGQuQMGhMV
 l2Zqi6Ojjl/TOpq3O2WpyO6ZVk+32jmp/EAAAA=
X-Change-ID: 20260908-correct-icc-bandwidth-vote-constants-49001bf6e03b
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789478807; l=1532;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=iYf0Z3IUg5KR7a1qHZ0mBPi3Zdla7UuK7O+KESklDX8=;
 b=d08jlEM5VgBRvdC4T7g4myaKphJkeogjF77ziBgbB+C9u0cB2ARnLUAAiAyEv4s6k93DgNN1B
 FvYamBUVSbRCCy2N0fCJFKGBEf3Zq/KgiZ+RuTPb+ccXpt6wzymbL8+
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: uyFutzdSyJgFz3oi352j51acGSVKYify
X-Proofpoint-GUID: uyFutzdSyJgFz3oi352j51acGSVKYify
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX0QbTy35f+4s2
 aFtBvlcgJojp+AcwutrEQ8QCQnaUlW2qrbfkEnpet5slc4frS3P+ZMZbPaKKu5RS3L88Evzxqfg
 uQBdItw6uizIVCo2879X5ydtFL9v/zc=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa9479d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=MOdl1PVcvyPrLPiNne4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX+vl55q5mcohr
 fxny1QADIv76tzFXwRxuhp9t/FfzdnqARGCLEZi8tgXnvTunSvJSlSZoEEkPRffXt91WbHghzH3
 v0CHrVu8hz57i29rEP/j5L7Vqr1qjYErOOjRcVgS2hCn8E1YLVh9AOYSBqMF8EdI6YQxDaVBX2a
 aEagK0W9dXbSIq8rry+ZbNS1d+g7yj4hv/ihrG2bDlXjL7mKGK2A1GsTwh6YVNNMloynjQGuGgt
 OOS8woNo/hHH9p/Jb5KiIpOvlh+rDufnxUWG4RAGzeWfU7O6jH9VzOS8z+nyDn1Zsfl0FPY4ZmZ
 v/723Ka4KDw3oemsvvcQKiE4NAVT4HASmucj0O0L38kY6jdSaPXTvnoob7jiuuGW8ynachdZz41
 2BAt6TsLoVNHaGwG6oE/zrz3J8ev0RqARvw52NPJBJwMs7LNTZflGrBXzGBY8X/t6Fsm/NeRONn
 y3idNkd4lPDUrKqc76g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150195

The GENI_TO_CORE ("qup-core") interconnect vote selects the QUP Core 2X
clock rate. The Core 2X bandwidth constants currently contain values that
are several orders of magnitude too small. Also, at baud rates up to
115200, the serial console uses only a 1 kBps keepalive vote, which does
not request a Core clock and can leave console RX unresponsive after the
system enters a deep CPU idle state.

Correct the common Core 2X bandwidth constants and use the 19.2 MHz Core
2X vote for the low-baud console path. Higher baud rates continue to use
the 50 MHz vote.

Patch 1 corrects the common Core 2X bandwidth constants. Patch 2 updates
the serial console's low-baud vote to use the corrected 19.2 MHz value.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Drop the unused definitions.
- Remove parentheses.
- Link to v1: https://patch.msgid.link/20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com

---
Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

 drivers/tty/serial/qcom_geni_serial.c |  5 ++---
 include/linux/soc/qcom/geni-se.h      | 15 +++++----------
 2 files changed, 7 insertions(+), 13 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-correct-icc-bandwidth-vote-constants-49001bf6e03b

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

