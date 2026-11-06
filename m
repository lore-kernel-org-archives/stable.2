Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979126;
	b=OFy03HQBQc7hPks0BhvT5W/hTVVl9R9iOmX4fDEG2mG8JvnsAtQllAAl1GOA0+fapeKu
	 ANZntQ+un8rhTJRTVHKcPGiEILoCNOeFE5r07exq5EWP/y4X9Zb1OyOmOQ4vm0a3tI5p8
	 LecpwP2hb6Fb+cbmOFARQ1GmhG0eVkhjEKRKkgNh3IznIBTecn9/DJUo8D5FWhg1ZXU4Y
	 pE0/07B+oDP5ADFCPwqSRAmVUUWXrgclUhA5P+fOp8mlbVEJNFY3ypdf3dK2KV6vZ26UL
	 +0uFvIQTg89Ht2GWFw07khlHPbbYXoUD6GO9EpI84YkglmPfatosK9Ts+Zrwph5oKZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fFR0KdsfK6dJUInFKV8qgHMsYHCXBxTYLlyubzjP+7U=;
	b=RKzOYJa7BZ+1VwBbsdFhpQ4E7rnLEKtpkVtWMDNc2w0OCjhBsE7X6mEVRuIMARt2xYus
	 mCIvxc9SKfUtBZQR/yehyx6WdXsaouZhNLRDDuU5YZLANa47tJiVTrJylcgxjrQDBBLs3
	 hWXkRBqB8FAtl9XeSTIOAaeV2SoncGb+xbVzPaJeHv/6a9pjeIDhKdDn5fltOzipmB/ej
	 Ognntfq5IywQmIU+e++q1Uth+Wx9PYXmDOqF7hT9lqL+IAmOL4LHXO1wdzq+UIU5tBfK0
	 QQbQHvnDi6cCEFsfhQSMx3R87c0ttZj7ddbg8yYNYi8JJRijkVLC4YBEcIzn8QnJYZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r1hBJRts;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA3606A335;
	Fri,  6 Nov 2026 15:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BA3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r1hBJRts
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEGV2726891;
	Fri, 6 Nov 2026 15:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fFR0KdsfK6dJUInFK
	V8qgHMsYHCXBxTYLlyubzjP+7U=; b=r1hBJRtsy7tiHTiwht5sigw9PR/+HigHP
	xoDKc7lVI7cIsYe3ABOjrXm7bKkNKp6SZAfHpw8ieOTmGva4DQDMDuXEJy3Xp6eJ
	fSPgmQ9Cf9I0WtqFrzaZrt8UND0D3WMQSjVAUvPBgmhayq+elHWT6lKy2xvSoVSg
	UQpp7IuS7d0RVVBTR7EYR2/TRQvMoxMLCDP3YK4FDSl5zGnx22jVuEwUPtjfzBk7
	uQ6qvTBg4kjLPEmp9lVfxt6ZXbF5NDTZG/jOyWuIAH8jgYvGtel5/ilaNvtR1cmy
	NgUid3BBpLHGWhK59x3rzj3WV7ixi20E0oJl8KHETe+d6WApliehQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9d71u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:31:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F50NF3617259;
	Fri, 6 Nov 2026 15:31:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ubmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:31:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FVqZT40763814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:31:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE4A320067;
	Fri,  6 Nov 2026 15:31:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EBB12005A;
	Fri,  6 Nov 2026 15:31:50 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.29.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:31:49 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        atrajeev@linux.ibm.com, tshah@linux.ibm.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 2/3] powerpc/perf: Update prev_count of event to get accurate values
Date: Fri,  6 Nov 2026 21:01:33 +0530
Message-ID: <20261106153136.330165-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106153136.330165-1-gautam@linux.ibm.com>
References: <20261106153136.330165-1-gautam@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aedf2ed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sLosXVA8qExDGVDZZrgA:9
X-Proofpoint-GUID: DV5u_7wbKX0YxXxyCfrNalkx-vR1ljw3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX7RWTSPIDiMPv
 Qu/U71H70lZXT8zt1ai2E/2s7JBNljBgTH7pKWWi2oW5T0AQXxhXkDdevURxHPFaYFvwBppTYjC
 sBu1Zyy0njrzDgjh1tTqC3QlvJnbeJ4=
X-Proofpoint-ORIG-GUID: uEEhRZauucH76cmGafSnT-cpBjgxWxJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXyqCSoOBsS/Fy
 PZHj+SydpqHvJp0rIe8ucEY0dpvq9LgaAeLDNW31JprfLluioy2YESxvK0bJV2PiyNadaktifsq
 j9nA8Z4gwbHRY450/S/MJpmg7SOBZSWuN2dnmOzmYaAes3N60kHI8RZQO5UoWiUAVU7aHGOawA1
 jxR9h5McftWqAFYKQdCooEtlJmpAfYptySPx2ZIqceJU8oUMeOw+m1G5Z84L0v1r0CwRNLw4WoT
 5hk4M4+8jH4qndT0teueslyzHEDZci3Yl/oSJrtybVHLN+wtsR7109IZU/MDiPHxBRoCqV4ay3A
 SAkvsvy0wlwWnvM4KSfoL08u1fGPsooOCV25iPlFN+0U28AQm9sdnrugbcM7c7PROSb4dkoynBP
 h+D7CAASXyXbWII3Tx5o7159CLheV2nlPq7RmYCf3DLY054LggmnARFLm/oIHkuNDk0ilBJfO9v
 +KO7SFyEU817o29neeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

When vpa_pmu_read() is called twice while a vCPU is running on the same
host cpu, the "event->hw.prev_count" variable returns the same old value on
the 2nd read which results in a larger value getting added to
event->count.

Fix this by updating the event->hw.prev_count every time vpa_pmu_read()
is called.

Fixes: 176cda0619b6 ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2 -> v3:
1. Use local64_xchg for atomic update.

v1 -> v2:
1. Add stable/fixes tags.

 arch/powerpc/perf/vpa-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index 01d9196fcb0f..3296877eb317 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -132,6 +132,7 @@ static void vpa_pmu_read(struct perf_event *event)
 
 	prev_data = local64_read(&event->hw.prev_count);
 	new_data = get_counter_data(event);
+	prev_data = local64_xchg(&event->hw.prev_count, new_data);
 	final_data = new_data - prev_data;
 
 	local64_add(final_data, &event->count);
-- 
2.56.0

