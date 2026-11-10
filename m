Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319102;
	b=hl7lwoC5Jur6MzR3xzs1Z1Ldjqrq0OMPyCgmQ4lLDu1tmHn0ulXEwZKjpVaBl+SqBmhE
	 KvGASXJ+zcZC8EVzTjjegh3Es4wUDplYeymKQU4z7UjZYuuk1Rqe+R0dbUOvkgp7PfLAe
	 iCG3abQLaCOzYEYVjVMLJU/JvdTq5NpPucbqRLgq2FfnQ3j5lkkRJeqQECRM5enTH7Yqh
	 2tixro3v9BPHVIUFHutYE/R7R/XmA0iupj/IheWPGas7Ma2P+WeUwiZmQF/kHqJpdXufA
	 OATyAAos6rRAKs4kdWly2qyZYD0m6jSY2WMMO+NhxMbEEEP2ajOw7lQHOXywgrY1yRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319102;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G1amRx89cS3ZlVbqVl1dHUbx8H+yk0rGJ3ceJbcLO00=;
	b=15V22yGqGkckDQCU2TNi7p6y9sd83/ZMI5cpgG16AOe6GgNqPXH/rc+obYKcXk6xthQ7
	 nyC7JcBJCi2zB8qR2Fw5nyVzCMc1Ri7b7rMJCMccFlVTxm1dQiSWFCMfOhV8PxJ6IyLLL
	 0zCmQ4LPbii+QAz/zXKK0WmsWQzl5Myk38eckDIgP9/rREm79YT5EY5cC0hFT9FJu0r5F
	 CH8dG4AyxT2StPu6lAjxHIrRlRtkzMtUNrBR6sf2jLWZ6lQES1tCOUvwfWUQelFTOHc6n
	 OIEcpb7wBn+OXUqlWU3qXggw2KncpEPoAVhCqvbR8Kjb6RAfdoo9EupTrGv09aeZJ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=La2A6gWF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHGZH+1B;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF12606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF12606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=La2A6gWF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHGZH+1B
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABA9u22124840
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=G1amRx89cS3ZlVbqVl1dHUbx8H+yk0rGJ3c
	eJbcLO00=; b=La2A6gWFhdCuJohKUxu+KrmPeXacK9C/vRy52ddkzfQArdz3LkV
	MlP1tC3xCNUYgT0Quw84SY0o7eLeh8bemfL6wHXeAZpUaWQleiMGFU1pZvgkjjr6
	Sq4OrmyZsd9lhdxXCbuUh4XIQaeI13M7Fz7GtMOApmWStgnKvP36D47x2Idgfr9E
	o5TGRkq6Nv4ln3KY+9rn43RNZVbir11dQuqk9wkW0t1lC83LxKYV4UgVCYeCyPCN
	t2gjCXnsDFeP1TSMVcVajpPxBzD20eoUMBKbPJVF08qaCbV1n/mgDDwXxh/r7N3i
	vAUmWqzG+ISQ2ouVPFusHlm+Zt0H7yHIZ0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkkdb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:58:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adc5b185bfso2044973a91.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319100; x=1794923900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1amRx89cS3ZlVbqVl1dHUbx8H+yk0rGJ3ceJbcLO00=;
        b=bHGZH+1BN7u0p78fuy8pj4pKCDfwD5obJ1JpO3Bp05zRM6OsjS7Spg3270d3Te1EBn
         FQmCu+Zg0ts60vaLAZURYgFN+kdhd3f7jRLZrwfuTY9QTlBbipxXCog+bn8wI6xAAUib
         HKxLANIXdx3QiMMsmRcOKlboAxhb0VrI8NJJ5+YLsf2aGA6St7duCNDJwtX/bo48rSPK
         qxXxvwPxcoG80LGk5T9WojobJjd6sBpC8SK7yRjTlLuHsoMINVjnXmH+455AqAUZQvDd
         uhkpfbO5bVvbg9q1YX8G9YCubIrcOdbbsDuEAgE7BOZaiKeedIYlQfsNe0gl5TWxqVel
         W5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319100; x=1794923900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1amRx89cS3ZlVbqVl1dHUbx8H+yk0rGJ3ceJbcLO00=;
        b=yNNZOIWxxmGm8wKa710fci0iOgvHqLhW4KPl14/7GSCGnlsfBEGTlbmROKRMy6Gt0e
         zpJOjNq6nvHVZIAuIgquAJlIbm2GtK81NETbZWeJFvfILamoOCMzpV7BR+80QUIX0sBx
         7xdOJku1nf528dFTFYIY/aUwYlwfIhoP5mdpcWmn1WCctSyVSAcPTPfYQDmKb90hVDG6
         tcR/ceD5v7/aBGE2rbGv2goxoBUz6ZqrgWA20Te9WD4Y2ek1U1yK0UA0pT3fKJzTyYJ3
         syd7yOSBtzHIrNQZbikj6y6kMOcYvzWMtNtnfjLePtU4ZJ2y4/PVQMkG4UOCnRGICRpo
         nxSw==
X-Forwarded-Encrypted: i=1; AL+hErHYxaYZPs4SI8eLbrRAv3kzdastwtY0MeHhKF5hIXRnLYmcbLApZ/9/4DhC3mmUsbhq8ybxK4c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HnMu7wU5jvosx3sJFIyhH2elLcyispVCOxtG6ABVUDCxvYbXS
	6rYZUGS1hDejoVgTjomotMp0POgGvBkljTBfQsmBwx/SqFryQRoXuPkGv/OeYcAUVq2YPXMmFdd
	uzXIl40Ofqq8yTrcDjEW1JXwl2/D5PzqqU15i5T36Gpqd74vJnghvplcRjQg=
X-Gm-Gg: AYBFou2CMy6VRw01SMh/cF+ujp06NXYHU+XSwwCX6Cy0EtfGvzFSUgTLtZm6h8DeC21
	HUn0MvwwgjrC8s0OwDlJNSwnJe4zpIUH0+o9/DM0ZQMNB7HrB4NNjF9L+gJ3aieuE0eEEjp3N62
	hH9s1lpZ0WT6A4jhNkfkqqyq0EKk7uSXUUlxyV1JfU/jC+li1PYpUEroYSHEfsRgPAi4BhO7DvI
	tm1jDjsRHBbSNICf0wNB+vikuaX0ofZfcQTbsjzdCLGWh0impcH1V/ATfh+gaMS5KaLf0nlyoed
	aCqS9womoSxLcQqXRMSjClZnYdvkPC9aZa8JUgxsZ1fscnIZOyiZlgxvR/g4y0GHtIOR1atzrEm
	v41ShsRyDwLIRt9epdYSwE+VraCyO/AZOVC8oaHtgm3GTfDpNMls+e1DaeUYWSLB+FWDe/Ea2/5
	COgnS9vuSKvLRePjFbJcoK/mlrgSSSD5ryKCG2da4=
X-Received: by 2002:a17:90b:3ec5:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b166fd294emr2603107a91.54.1794319099626;
        Tue, 10 Nov 2026 05:58:19 -0800 (PST)
X-Received: by 2002:a17:90b:3ec5:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b166fd294emr2603098a91.54.1794319099224;
        Tue, 10 Nov 2026 05:58:19 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17da5c970sm36744a91.2.2026.11.10.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:58:18 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        andrew-sh.cheng@mediatek.com, rex-bc.chen@mediatek.com,
        jia-wei.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] cpufreq: Skip inactive policies in cpufreq_driver_target()
Date: Tue, 10 Nov 2026 21:58:14 +0800
Message-ID: <20261110135814.621355-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: CXlWTUZ2gIsAzptVNQd2R8S6QEXq-w_n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX1rz2VIlfuqZP
 llQnDySuAQ69pKa6EnwiYWej75DDYkcG+MS+3GMihhuviEurbiZbJfJrVvx/a0CLaF53HuquA31
 bQiC6g92MODQ05m/DZBxGem8TqOuDCU=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af322fc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NN3j_4cKtzw3BXDvlvQA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: CXlWTUZ2gIsAzptVNQd2R8S6QEXq-w_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfXycOg7yLFoXYa
 C+K66kE0DgzXv7uJflUHLAUmbZUWy/SDLe+WWs+QGatI+GRiFOu8921TnVGvyooaqjyM9J+9F6V
 ndleT1kJMteK0rlatYWQszYYx0ohP+tNo1lIm7KX5Oc/5ojAxgOuCS5OYH+rZJOz50FKaSIwSCI
 PuMaWmb0gI2BZEmviN8EiUV3LWstlKW+MJjMv/R4iHkIT0aXxdppopFsUFbyigShKjfpxWTIQLd
 oHGtft2nN/YH/Yy5Uli6O0F5YHQyG8zy+SNMW3k7PInrumc2ppeZ8S+QoC3TFhRAPbNiOZEl3zc
 dsVsSFmB1s0NNLznkleQTPeOX5gYd5KeTkq2I8UsuT/qxrV3uwYpG1D3WHXNuVci3JqQG3kLQH8
 qarVZIVUr6BUIqPN3d3xMpQa0dAd5Wud9ImP8BeYIW+3RBX8G8zYmqw57PWhnM6cip+Er4W/gDC
 /J0d8h6wv7s/THxK/9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100055

A policy obtained with cpufreq_cpu_get() may become inactive before
cpufreq_driver_target() acquires its rwsem, which may lead to a NULL
pointer dereference:

  CPU X                      CPU Y (last CPU in policy)
  cpufreq_cpu_get()
                             cpufreq_offline()
                               __cpufreq_offline()
                                 ->exit()  /* frees freq_table */
                                 policy->freq_table = NULL
  cpufreq_driver_target()
    __cpufreq_driver_target()
      __target_index()
        policy->freq_table[index]  /* NULL dereference */

Before commit 2372784542cb ("cpufreq: Drop 'freq_table' argument of
__target_index()"), __cpufreq_driver_target() returned an error if
policy->freq_table was NULL. Since the offline path clears it under the
policy rwsem, which cpufreq_driver_target() also holds, that check was
sufficient to prevent the crash.

The race has been reachable in-tree since commit c210063b40ac
("cpufreq: mediatek: Add opp notification support"), which added the
first caller of cpufreq_driver_target() that can run concurrently with
CPU offline.

Address this by making cpufreq_driver_target() return -EBUSY if the
policy is inactive after acquiring its rwsem, in analogy with the checks
in cpufreq_get(), refresh_frequency_limits() and the sysfs show() and
store() callbacks.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261104153042.3987338-1-zhongqiu.han%40oss.qualcomm.com
Fixes: 2372784542cb ("cpufreq: Drop 'freq_table' argument of __target_index()")
Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
Fix the issue discussed at:
https://lore.kernel.org/all/a4b320d9-ade6-4f39-9e9a-e9a82b13152e@oss.qualcomm.com/

 drivers/cpufreq/cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..352ee4a1f085 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2403,6 +2403,14 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 {
 	guard(cpufreq_policy_write)(policy);
 
+	/*
+	 * The last CPU in the policy may have gone offline after the caller
+	 * obtained it, in which case the policy is inactive and must not be
+	 * used for changing the frequency.
+	 */
+	if (unlikely(policy_is_inactive(policy)))
+		return -EBUSY;
+
 	return __cpufreq_driver_target(policy, target_freq, relation);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
-- 
2.43.0

