Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513D434E39
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351457; cv=none; b=H5k3rtEPCXV09BHxrQgEosLjYioDuTGHYta4ZuRDpzEO2FHCB2q7OvMlEsT+1irqBtp84SxDJ8njVKlo8/XOCGNGFkgYfvUdWAp/va30eB+gaHVFcf9jy6uR1hoEkKrUVOvAHsH3iU3ps57o78nvbVDwmLnhw3mBMbZ8UIDKaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351457; c=relaxed/simple;
	bh=w4a6F0ekSRD35OQzV65/UQtuzosMYFzap1cwoBwsUgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeL0KUbt/A6U76bJHc0TOYJlbiD9orLEquxlYSy5O7e5mYLCdWBguREG8cJQimg8FYruYOggI4J31VJlJjak3vEvEruYmkvPAdj0sSn8d6ZTBzNYVcjnaxLVOK8ln3230Pf2e5PDuwUnia4CFHQuSSYtI82151DVEGusc1c5Puw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h20kwg5A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DHgQsGYJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h20kwg5A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHgQsGYJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IIU0761510777
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3R4EKzix3+S
	TlhmbCV2t0LnWUys9Ube2NoVdrXT4KpA=; b=h20kwg5AEC/aVPNmXs3wQ7/A8Bb
	5AfEMExGljx4NIGtzSD59nJPcG0uKQjGkIl6qX+1kzt0oRbEZslV8l6tu749rphN
	uao77S3vjzdny6A+PX66MajZYfteNpmKqsPQezgPvRRKKNyTNqiWgsuvHSoMFd1E
	bg97kP8U1I+Kr61T7HPW26egEL4XjasDOf3ZorXt7mvp92Rg4LjF2/J1rICV+TNA
	lYffcONfS6ZVTxTYyOqZBYWkRPrF+Y2xji+ycIXlUdD6LP2LSJYW013rM2SE4qJh
	qF9bw4DVbc88CmZlp8bIVEyntQxVN9yzbI6QzSwoF9lX6PhCcrQDsTwl66w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys3wev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso117056585a.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792351454; x=1792956254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3R4EKzix3+STlhmbCV2t0LnWUys9Ube2NoVdrXT4KpA=;
        b=DHgQsGYJkocTP/Xtz5lKDo2XTcpAM4Vnm6qUWcwu5MhmPcoMdAplioDu7tAtFY+rSa
         41YEsUkCOwDhe77Lc0KazIH0w1xtydeu+H4gunnZe8FHL2QpcnbgsT8Fr46GOTI5LI92
         qfzZLMbdc7ZRv59nBUFC0PssUIiiYFgDPtyc3nt4P8wGUdaCCn4sUmWlL1mwm20qQHWy
         VFv8aR+hus8i8TBQjxeSLId2yqlQS/4ftwQG0913kNJosmgBNNeeh4DI7IySz8278FAA
         SDLdPLgZAqsQloBpWYmPv/GC+S7H/sD6cDTXucMHM0ypbmz3EiEZo/uHl1EuY+JlrtGd
         qmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792351454; x=1792956254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3R4EKzix3+STlhmbCV2t0LnWUys9Ube2NoVdrXT4KpA=;
        b=dR/6IvH1VLCsk72XNgaa6HgpqiRxaye4ncj8BZkMWCKVUDxX46wiaiFdTAlm3KGzzt
         8XeVStIBeWtlF7edEQgDOUaGF94xzBQmspLeVyzKyIJ/v1O6N9KUqOTINcJINGD7NW3c
         jifgNKBBrD3wY1KJj0nNeH7CseOwTr2g0lrng1l8gzDW9w5lgIwacwAYnt7b14uoB2Pe
         u+/bA413SWR+OB/sRxcBFALPTF2o2dUtDG08GE2ThnRipLfmcudVcwzIN/Ia02esImR6
         jPvCfdMYlubNqMk6WGMd7KDJCzigSaiGzD1q3A4PAn5djDE5IikEiKfXnYhKWprepbAP
         D2lQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU9gVCMEgfSrmKKp/gytt7EJLnBXsZsoqV+jffTEL56idB/rAd6YtAlTjVZhXWSjDl4fUP0YA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBu8Xt2wEZ2fJnJjGaAi9PSMinh/Dj0xiXTzucz9gvLGKGrY3U
	/fuma1yso5unJ1+oGuqxxBwLLSvdUn9bosPsp1D4uXpGXuEyJ7A7jnWSTLW8opNUIkDnfhpbhbz
	PWomEAiQE/iO32mbL/23O/gpjO/llCcDCVfkKSZme0Ashx+X0MG2SOtei7dQ=
X-Gm-Gg: AYBFou3q2bdiImmqWL8i8FNbuZYLKUP7PBDBBuC+scAqUxkXZsyXyAzN7Ql0AfIWNI9
	f8x4x16cXdGxWrwEP2E2JkSS7xT/ceGqJ+Zgydgp6+HNJMNjkaHo21Ed/VtJYIswAtK2aUVC2hX
	fdPoaU/j6L1grbm/QtUtz1/T4QGsQWRiqmysPAXV0jocyZI8g35zyPMtPQSKzt9QjIvMkPa09mc
	uAU2zTcJfvFVGjL1YoFpakvRK71m70jbnjyHt8HCGRP59YZrI+fXlYJXr4s1u2SEpMElmUhMPly
	okZZzmicbcc7zgLWmEjXgRWZfHZeyNJUzmJ6f1br7c+dJMZds/xQX2c4ruW33+tK7pzPh9I+4ci
	65WC7Unk7p2RT
X-Received: by 2002:a05:620a:7084:b0:93e:c12d:4eca with SMTP id af79cd13be357-93f17fc35d9mr1448070885a.42.1792351454243;
        Sun, 18 Oct 2026 12:24:14 -0700 (PDT)
X-Received: by 2002:a05:620a:7084:b0:93e:c12d:4eca with SMTP id af79cd13be357-93f17fc35d9mr1448067885a.42.1792351453748;
        Sun, 18 Oct 2026 12:24:13 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce33ad3fsm184417105e9.5.2026.10.18.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:24:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] ASoC: SDCA: enable pm_runtime before taking the initial reference
Date: Sun, 18 Oct 2026 20:23:57 +0100
Message-ID: <20261018192359.287987-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA3NyBTYWx0ZWRfX4hFFloqi35qD
 7Iph0GTWeT80c0sh/kerVW/NUc1AHfKaRr8sl4dGjsGowanjDasgk1yIjF8eDrbHC966etpUNSY
 tMK7q8JqQ7LZ+9/punE4oQsaZyGX900Gm7FeaS3h7FhgwLEfkji50sk4v1XZGGsBMOnCSQ1B2yf
 rVkrNaY7Hqe8rn9mLaITpmjp+yOWUlVKNkP8KLAXPKdIEgA8qBfPO2bDjqzd4XvCt4TuqM24KYl
 xDXCIMXpiEYrDI3fZUmocodLqQd0z7tOSOiaPoP117sgsLUgnY6r2GeC0sn0wOxBUWqnvwv4nVB
 q+hAKQluQDhCt34jhzGsG32fNPoBLM41hsd8w1rZl7yv1CsZKSRxa9WZaqMCbdXsQCBlSOBZaTz
 WdVR3p4rpdQToMHVCWVnqNYfMRs+pKUEvG6IfbCyMewg3SUP/NCjwGuXV9+9dSef5rnTZN4sCKq
 ETHiOkvEXJn4kngbMGQ==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad51cdf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=shiE3HVkELJXXdC6UlEA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 90ZOFCfqVhLs7m4WPChvhCdOxZ41WaKK
X-Proofpoint-GUID: 90ZOFCfqVhLs7m4WPChvhCdOxZ41WaKK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA3NyBTYWx0ZWRfX4DQSZp9+8LEj
 42J6PvB2aniMBkzcXbzto7VFiu6t8GcqOXEH7Z1AJ44yx7OLMRD7eOfmHMyjNDhW9equtcu31ip
 bBsJUSgWgpN3cjobKemtWeMMkzkBzpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180077

If devm_pm_runtime_enable() failed, the usage count taken earlier by
pm_runtime_get_noresume() was never dropped. Reorder so the get only
happens once enable has succeeded.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index bcc660aeb739..3361db188046 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -194,12 +194,13 @@ int sdca_class_probe(struct sdw_slave *sdw,
 	pm_runtime_set_autosuspend_delay(dev, 250);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
-	pm_runtime_get_noresume(dev);
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
+	pm_runtime_get_noresume(dev);
+
 	queue_work(system_long_wq, &drv->boot_work);
 
 	return 0;
-- 
2.53.0

