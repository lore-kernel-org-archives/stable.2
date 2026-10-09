Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D88470E91;
	Fri,  9 Oct 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563810; cv=none; b=Jon8Mcn6NAbmd+ZQLVGejhN4f9/72LeYU53PViMqBdUu0nMA5hz6HWjt4SJtOYZBNCdOUsTtXVL8F2xU2f92/XrsH9WJ760zyxSHCxQFX5G0H+OsbBUwlKcEqZsm5J3crABTH7406vte1WGTIYTNkT3jDyG42RK07a6U6xDALy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563810; c=relaxed/simple;
	bh=+aAANgnZFrmg+bqHaMnKqDJhJiciOXyR0JCSjAWEXMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FegZATPJL5kQGTNifn9/haf9nWc9HQmwwpMrmk+vmV9riPKOtyjpi0Y/3cZu5YcACgKBi2ij81krQWxXxEkVr1ylI6FdGttQnUsDDaWLvH6Ndnb3NbKRWL7uxSEqMSCMeCtRCj8kRwdXMfE3Guty4sqzpXpNQNEpLrKxdgpGj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TaVQEteb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TaVQEteb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZPOa571712;
	Fri, 9 Oct 2026 16:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6WnS1Z+WYMP3nfRbFwUB3ixiVVzH
	/TwTlKG3XdhXwx0=; b=TaVQEtebaXnKpbCtSpTT2P/CsdVfzvpR+rxSzh4OBQFM
	7f16laA6lVCmuprlJg6FJ1pKDZSVWOZWX0CKna0H3NNfyAiu8TxVCS5AWxRxvih7
	YX5ryTaem1Z/mkFI5jgacbi7/fnVjF7kx4kW50RdfNrLxOknEV5gxk+2uDdbekS1
	hhnFleeYR52MWEoW1n100X1aIbAZD0XG/IRgS+S0dkkTQ4xKsD1H5pNCUsewuyIj
	WNgNiJlQHnArzq6ocOyeNkHb/ncWzvD2el/UG4DSZzHEZjibFfFtTaNAJe+N9HdP
	JQEaICddIwyu15Zm4yXstndNqbbVvXiO81VKpIL3jA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvkus0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:36:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699GJhwB1150431;
	Fri, 9 Oct 2026 16:36:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnks01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:36:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699GaNIg29164190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 16:36:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE6220043;
	Fri,  9 Oct 2026 16:36:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE5320040;
	Fri,  9 Oct 2026 16:36:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.129])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 16:36:19 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        stable@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix early boot trace buffer allocation and tracefs init crash
Date: Fri,  9 Oct 2026 22:05:55 +0530
Message-ID: <20261009163557.88467-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Smr1VNDOKKJwWEIil9nnNa__2PTR1iih
X-Proofpoint-ORIG-GUID: he5gvaUNxEV-a3_alhW7dMrc12SgFLpG
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac9180d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=TwISAZj8YnJKlnGNUAAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfXyaesTwI4TsMU
 NTymUp9qzvi7lBKp/duE+WS1CTN8vMXXfESfzILXfhOGQGz4HaGn+r2MbD+5WKG3Q/YwhXt3gbm
 Na135d83T1xT3YMKjr0tZmFg5RInXIF+/4v+6qmMcwNHxh/+SEt5rqex80GWpOCo5eFch/XqHlE
 at8wjqJLwUmB/cahcKIaTh2lUVlfw1v9txfVQGtqIE2z+zfsA6b9GMg6yMLN7h/O7Fmj51YfZ0i
 W/C4yjgJNETFj8RAwzLZmVvfL8mcVncyTR7Un71girdQ0JGY9yrRzaw6J6RvTqEgz4D4hR04nGu
 Tu/yagrS+tce3w2CLkmwTEGhPD4E7MPepubb2LX81eE+PH1xNKqm+YOYKK/VqXONYrnYr4M99oQ
 ur0d3vHY5EkTogNbfP2Y0+PLje7RxHbsjQXdWq7H3S5ZgnDL4BSD2WXOcMm++pQ51v+g5SXfNKS
 6ea65Mn+URvKAe2Pl7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX18RPMGxnr5Bs
 vVWYbcu197S9D+4Hl0ArOADpgc6ZhLd17utdx6zwQkDjjW32/yWVJ2YTVLVT8/Hq3ZULLT3MeWZ
 eTakYJfEwGhI691dU+fXhAX/yVO4e1Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066

This series addresses an early boot crash and trace buffer allocation
failure reported on ppc64le KVM guests [1] (and reproducible under
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y with large static kernel footprints).

Patch 1 fixes the crash (NULL pointer dereference in __find_event_file()):
When trace buffer allocation fails during early boot, tracing is left
disabled.  However, tracer_init_tracefs_work_func() runs asynchronously via
fs_initcall and traverses uninitialized event lists without checking
tracing_disabled.  Checking tracing_disabled early averts the crash.

Patch 2 fixes the root cause of the early allocation failure:
During early_trace_init(), __rb_allocate_pages() performs a heuristic check
using si_mem_available().  Under CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
NR_FREE_PAGES only reflects the initial non-deferred pool (e.g. 1 section
per node) because the remaining memory has not yet been initialized.  On
kernels with large static binary footprints (debug configs, early
SLUB/vmalloc/ftrace records), this pool is quickly consumed, causing
si_mem_available() to return 0 and trigger a false -ENOMEM before the buddy
allocator has the opportunity to grow the zone on demand via
deferred_grow_zone().  Skipping the check during SYSTEM_BOOTING allows the
allocation to succeed.

Both fixes have been verified by Michal Suchánek.

[1] https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/

Amit Machhiwal (2):
  tracing: Do not initialize tracefs work if tracing is disabled
  ring-buffer: Do not check si_mem_available() during SYSTEM_BOOTING

 kernel/trace/ring_buffer.c | 8 +++++++-
 kernel/trace/trace.c       | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.54.0 (Apple Git-157)

