Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E641CB4D
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351458; cv=none; b=cxnLBh1e2s2FEjtcmZ4TzLZx5QBuFvQ06BmgF4/4d172ANaaVvaSqDFf9eFoD1VGAs24q7vuzZimZMfSYONrVmcoa5YTnWXIXMz1m6D773ZHhwjRho64UDhaK9YvLiI+vN4zCquO/aWEiUsbhuaWNe0oi0H192x9EGFPwQm4u30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351458; c=relaxed/simple;
	bh=uWpEzD7A2z9BBVgL+L1BqfLh0mFLnWBMyojankD4Bys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utE2Pv33Idb+Xl7pO9Gx1vGOvmPTCYOSokMOKGyB0GEcVWZT/lpvQ6KPH3FBB4ktbjSGahITWNbxFd2he6fRMywRbvxeJ2WdO4ms5fwDZmsvUD9hJbc56mVoRROQ9+1Pn83eyPw3EqGMfg0LhGtR89SAXOA3ZQUe+Pykj7Y1avU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9D4Jd3I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJclcSVf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9D4Jd3I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJclcSVf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IIUJbw3181731
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=meykzvnfYzX
	i2RMTimQviyiTW8uxbnIMjVzBcf5ea/0=; b=E9D4Jd3INo8GpCLHpi5eq7ywjm+
	R8GAuEjumpQOy6hSD/iKAlifEXffhZtpfAPyUfeJoE/eb7Ii99TKOQDnivMAd3s8
	9UQzbSbnYXtC1SENpfq7hkW91Zl5fk1oLk2PQIwjENQFnLmugG7dy0TKwZ29Od8/
	IWfMWdgifFDI9KL8EjZZ+gZm0WeUb1Jp15kPDnb+bEr5cDqv/sourCRLO8BSs73X
	hExmyTvD4LzmcO/mc+ZzBptYilWGchzsCqpNP7BhlqjOhzJfk0miGHiInXwpxxRW
	F/lR8TXakki7JmrtpT+h3wj/oU6SFlU6Eq0yKZFMsfR8O4N/QljRIGKnfOQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k3mf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:24:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e92aad34aso313403085a.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792351456; x=1792956256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meykzvnfYzXi2RMTimQviyiTW8uxbnIMjVzBcf5ea/0=;
        b=aJclcSVfwE0Mc4/a4GMKOny/E77NtPv3tJiVHxYakqF1Pv2JteigDEf0MvW9UKCen1
         OWrG29nikcRQGkgKQ6ikp51JlWTDAy4awes3kPMvAFUchDnuq8hLzBdUaH3vdUW+FMWj
         44HaIlznBoMNpuMDNXTXkPPhc549HNLokxnPIH9M5wR+wEhM09r8ncr7xNrSLv57b720
         NY6iZtnkYFYki78IxAXrgRFw+0PqeaaF5SXXj5L/DEhpUHYMWZqEuPttEOXuz1HNLxa4
         tmwrHza1RZjpUtwxG5Me/Y8aHUeMlKi/R6K8j7paK170hM4Z85xVW1eZnIzbcc62sTJD
         +Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792351456; x=1792956256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meykzvnfYzXi2RMTimQviyiTW8uxbnIMjVzBcf5ea/0=;
        b=OcC6o9T2LUjM6cO+US+Al2tfI9nv8hXy2kAWny1R5XPSj3qhuflNOkabo40eNuHjm5
         6emacY1da/srG13yCXvkUjFLS+/rVGf0A1BTkF0PWDnkUGt30BCotUSJLvQe+SGiQEO6
         GOFbiCJwH4baBBX5Di5C2YaI2mzmZ5mr2sQyMABeQxuSq+/0flPk03bUrLhcWDopo7/6
         8MYzHkLIImmehWvp44NC3oGZ9BmRgW3U38Stq1f6sHi/RsHl8ux4R12E6jMy9kyzX1le
         FCB8cKTqRsYMzGeb2pF4WPOh2E5IzclH8ca293f7QBZzyrn/HMwAFJTyTNelnBmJhII3
         SOQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYFrflnlwbf4JKil5El2sYaRRlmAvnwPXpe3M5TUFEMOMzioSwsKujaixvR6ebi6Fwb252pLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsxLzp0kfcJvZB+Nva8lMhZv5QQ32VeTOn8TQdJN5n+ZFMOTGY
	liIIHalLkYGe0qVlfmiI8Br85CkwYeewY7qaNgNchv8TE5SC8/tPA7Nssod4/Aiz1jqaZRdQBWv
	x4ySpMJik0yxCEnoZifehPuY1pWeOJjP7GAJroh8eZjYrTYO3UbhDLIADL/U=
X-Gm-Gg: AYBFou07LUJrd7iy8SuMTt1LAAvkOyazuw0AbwTCn6XvIaAi27PAEvgYjqZ5NsNEqlQ
	OIUtOktir9IolrNpzockJtH7Q4bOz1alKZb08TOJkSe+sR8rA4ybQw7lLRZt/JAwF/Ibxk6t7Ux
	iSeYrzuj/xfosycKIrgNhJTh9eA+mEYVhJJyUoSmnQ9K6z6Tgl5mzb2gOX0q2fkNXUs95VKZIxm
	CDtiSJBeABOJHWoR8mvEFx4nQyZrzpWoal7/kKXUJ6JOhraJx4jNDdjlx9Tv0rNSGGMuyRnvFmj
	ydZx4vpT+TyuhUNSfOb4X7YLAor2f4toB2j2SDGXt5ww4dYlN/hjMVwfnvxC/vwQsm9EIU5IKL3
	ZiQ8JbRbChIlJ
X-Received: by 2002:a05:620a:6e8d:20b0:93f:353c:6bed with SMTP id af79cd13be357-93f353c6dd1mr373737885a.20.1792351455615;
        Sun, 18 Oct 2026 12:24:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6e8d:20b0:93f:353c:6bed with SMTP id af79cd13be357-93f353c6dd1mr373735485a.20.1792351455152;
        Sun, 18 Oct 2026 12:24:15 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce33ad3fsm184417105e9.5.2026.10.18.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:24:14 -0700 (PDT)
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
Subject: [PATCH 3/4] ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure
Date: Sun, 18 Oct 2026 20:23:58 +0100
Message-ID: <20261018192359.287987-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA3NyBTYWx0ZWRfXxqQz8FZd/KN6
 YSZugBSYpjtBI60zGNJQ4BrE/ViKYVlsqt/iyXcOjM+oU5t1+FgL4PihWVouwECp8LScsoOC630
 OoQFqNgBWM/wYK94Hyz0X44FkVwFxmsF2C7mEYcqiGzWi0oCDP4vcrw1qhcY3YwcSjnc7LQl7Wm
 LvYrz7i3up66+4t0/u6Vm687XGNOETn7sXj6UPaeaSRMGT1MWzKKH3NS6W9z4zQq8FiIn89ceB8
 kIvGMRoPZuHLdttIhd/mWPhac9IRI3ecSb6U6Ss8S7wX01R37bMBYbiqQ71p6BrO/oU3rq/jB3/
 /9E9U2qYPbBWxgqa55OIj79Ljcg+qiGMiYvNIIM6PpiU96xE7uKEkw727wyYb3b+r9Yjzf+eQTj
 8/QyvROkHgqKT33Oq3NieDvCQL6CHBmqM0dxrtXITNWIzVqQa6DKslgASsUiGFSHwMmK3cY6tp/
 MsuYj9xJJ7PUhu37K7g==
X-Proofpoint-GUID: ISZ9N5KhTtrhdyPeZKFABXC44ZBg3Q3Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA3NyBTYWx0ZWRfX0h2y2k9oy8or
 KiXVm3s7Bof6t8y6NLhRV2qOOzVTLK2+VeVxM/CydOPp0tr0LH+aTxBGXIOx750PqQpqLfmX2G/
 HNxuotYDu9dUFs4tPS3u6fKbBNwGyp4=
X-Proofpoint-ORIG-GUID: ISZ9N5KhTtrhdyPeZKFABXC44ZBg3Q3Z
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad51ce0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=AaUSbDpTSIYfnfK-pzQA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180077

The SoundWire IRQ was disabled before pm_runtime_force_suspend() but
never re-enabled when the force suspend failed, leaving the codec
unable to receive interrupts.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index 3361db188046..8396a4c058ec 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -264,6 +264,7 @@ int sdca_class_system_suspend(struct sdca_class_drv *drv)
 	ret = pm_runtime_force_suspend(drv->dev);
 	if (ret) {
 		dev_err(drv->dev, "failed to force suspend: %d\n", ret);
+		enable_irq(drv->sdw->irq);
 		return ret;
 	}
 
-- 
2.53.0

