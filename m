Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026785;
	b=brxp0GRUTJhOrCfDrAPIquf2uWaTgdvgRndxi/h4c2G4j+h74CGuEO9mqE381XsLJnYm
	 R601syfkByPdT0vqvTgKCQ+h7hbuOT/+9oInmW9nCuGI77nZIjGFZoTBWinlg2l22bWN1
	 Co8BBgWzYxI7Mg9Xgs5D0jYQYcGDv+W9o0U0paKidiwCaj+OHqHK8wXVktqr5qDMt3gP5
	 0vem2hIByj70MXhd1noPRsQjj22azenpnaeO3CGaB0N/j8ZGv9FNwePfh4Vzja3QwBPmB
	 KDiLOPtyxPRV4oBISUwcvfh8JckXyYXhDPRD/Hnq0jnHJJg7oRD6jzQ3kVNC6x1wLvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026785;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rhEN0h7wX2c8+mVN5T2q/8hdxoSKBQZF1DPC1+vTOL4=;
	b=KDSUKEcfKh+v7YDxW0onzfGBMvfG34VHRMcAeZPWF5IDAip93ie3+pYIwJP+IvkOOS+W
	 W3dHKFnIW1IehuALeN5PIWuIJlmY/u1An4HCaKekCJo6lzfq5SwY1oxHnqZXhByqAF58C
	 iLt1n0R8T7vkutsP8m895vfEf6xOIsngq02tFmB/CCLNEdDgb81T9gh549f+ma+k1yVer
	 gh6IeVQ+MZSxS3X8HCxW803Y++hMRmNXFCpi+ywvmp4/ZwzjMgkq5fmOTpoe1Jly3trYE
	 RdZEDUp2cEE0T7LzrZHS0ZtXHOXmFvaGjuz6UeuxMeq24PWGWNLgw4+ODGUC+7SaTOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVddyxAL;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA7606A332;
	Wed, 18 Nov 2026 18:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70BA7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVddyxAL
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHPwu2077471;
	Wed, 18 Nov 2026 18:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rhEN0h7wX2c8+mVN5T2q/8hdxoSK
	BQZF1DPC1+vTOL4=; b=jVddyxALvzL/c5K2zFqAji+Zyrs7C+BQB3lcWn4yBqd2
	+qriZLansAV8er08U+RIxN+ndkplbrJ1CUGE9yf6kvqu7lHPcfMJ8fOt4A1KlEec
	kFj0VvHXSvRPX+Bpsvbl0zgNIKUvftwuB9Pmu5fhjReBL2MbN9N+2rqold9NrUGf
	pOpHfCJQ7AZ8kv1u6hIYifMdtJ0+ynwu1nluJUkVnLjZq+LnOcHPcwoYLYQ7uZrF
	LzgGR6m6YEpxA8cb6O0uCmV6BYUI6WXn12XO3dn9Mxh3q3IFtlyfzWA7UklswEP+
	DkoDYl/j2gDAykAnQhOB126DKS4icN6gBXf5IYM1yw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rm0x8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:32:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHK3T03429607;
	Wed, 18 Nov 2026 18:32:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02juhau6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:32:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIIWkZs28377350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 18:32:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3202004B;
	Wed, 18 Nov 2026 18:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4239E20043;
	Wed, 18 Nov 2026 18:32:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.19.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 18:32:43 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Vincent Donnefort <vdonnefort@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5] ring-buffer: Do not check si_mem_available() before deferred init completes
Date: Thu, 19 Nov 2026 00:02:35 +0530
Message-ID: <20261118183235.63310-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UoNsp9KWx-lIKmVcQS8oRuIY9Bxh663p
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afdef54 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=TAdDoJc28zNiS-eFyzwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MyBTYWx0ZWRfX6xos6IAaNQhP
 BlSiuJhmSXzFi/6ZDuVDrWH70Vc2Zb16jqNhiJLgoq/pwX0dzPtKJt8VHins2xknSrA3NVqTFE1
 iGgI1XqH9rSyluG6FE7pyQnCOr1b1xw=
X-Proofpoint-ORIG-GUID: 7Zi_ebJ6DCZ_bAp5rDfkW3mCgJgcv37y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MyBTYWx0ZWRfX3Fgejk2yJ4oI
 Ms64VVCgf4dYSfKPP7NkQbhjz5xj9VOzLFbpA/sMvrMsbwWEbltUTqzx4V1wVq/GjDdrQc/MvOL
 M2eEXKIgfCwcVhZybH+/NA8xFDbSvupUa5x4mYwrXO/Msrj+lgnKE64zoBXonUdq3MGqA99SOVj
 oTJB+1Pq/k9vi7D6zrrdn8PDXMzoFJTTEYenfY9Kbk616x7AH4pBFOUeh95Nl6y/cevHFGMO0J8
 voxsF11pruZIDyHzDuuXqL9d9aDqeopxtFZjwlOYpzmY+6gL0ZdOEB1eRTCbtysgOAxieMkrhDE
 8DMY5p6RENpazt1KachLQZG2SRSRSSDsOd/w/C14JkKBhvJvoFDadkfxIqfR8asNnq3RxccJY67
 jWAX3yo7eLI3GDKO5JV6KCo9qK+5jb353QxpPQwmGnbztygzW8vGmGzy5/yC9Dy+J/JdzWBu2sM
 kQb7CPfKrf+HsjqA+jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180073

With CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, only about one memory section
per node is initialized early in boot (16 MiB on powerpc).  The rest is
initialized on demand by deferred_grow_zone() when an allocation would
otherwise fail, or later by page_alloc_init_late().

Until then NR_FREE_PAGES can be close to zero, because early allocations
(SLUB, vmalloc, ftrace records) use up the first section.
si_mem_available() is derived from NR_FREE_PAGES, so it under-reports.

__rb_allocate_pages() returns -ENOMEM when si_mem_available() is below
the requested size.  This check wrongly fails the buffers allocated for
the boot CPU in early_trace_init() and for secondary CPUs in smp_init(),
both of which run before page_alloc_init_late().  The resulting boot log
shows:

  ERROR: Failed to allocate trace buffer
  ERROR: tracer: failed to allocate ring buffer!

Skip the check until SYSTEM_FREEING_INITMEM on
CONFIG_DEFERRED_STRUCT_PAGE_INIT kernels.  The allocation itself still
fails if memory really is short.

This is the second half of the fix for the early boot crash reported on
ppc64le KVM guests.  Commit b3b974008388 ("tracing: Do not initialize
tracefs work if tracing is disabled") stopped the NULL pointer
dereference in __find_event_file() that followed the failed allocation.
This patch fixes the allocation failure itself.

Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
Cc: stable@vger.kernel.org
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes since v4:
 - v4: https://lore.kernel.org/all/20261023145459.47516-1-amachhiw@linux.ibm.com/
 - Rewrote commit message for clarity and conciseness (Vincent, Steven).
 - Structure the deferred init check using if/else with unlikely() (Steven).
 - Added Vincent's R-b.

Changes since v3:
 - v3: https://lore.kernel.org/all/20261022181817.49717-1-amachhiw@linux.ibm.com
 - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
   IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
   (Vincent Donnefort)
 - Trim the in-code comment to one sentence. (Vincent Donnefort)

Changes since v2:
 - v2: https://lore.kernel.org/all/20261016134247.70722-1-amachhiw@linux.ibm.com
 - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
   update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)

Changes since v1:
 - v1: https://lore.kernel.org/all/20261009163557.88467-1-amachhiw@linux.ibm.com
 - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
   trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
   completes, so the false negative window spans both SYSTEM_BOOTING and
   SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
   boundary. (Sashiko, Vincent Donnefort)
 - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
   check unchanged on non-deferred kernels. (Vincent Donnefort)
 - Drop Tested-by: guard condition changed, requesting fresh test.

 kernel/trace/ring_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 75cd8df23c1b..98e8a02b7c43 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2468,8 +2468,17 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		 * memory. It may not be accurate. But we don't care, we just want
 		 * to prevent doing any allocation when it is obvious that it is
 		 * not going to succeed.
+		 *
+		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
+		 * will reflect the actual available memory only after
+		 * SYSTEM_FREEING_INITMEM.
 		 */
-		i = si_mem_available();
+		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
+		    unlikely(system_state < SYSTEM_FREEING_INITMEM))
+			i = LONG_MAX;
+		else
+			i = si_mem_available();
+
 		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
 

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.54.0 (Apple Git-157)

