Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060E49CF5A;
	Fri,  9 Oct 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563823; cv=none; b=VU/v9evmsRzA/ej7hS5lhCMLjxaWuAcrNcVo00Lr6KN7kdPZbyvNUt24MZVNUd+VhaDrJf/j0L9UBAAkAGhNdkIywEvol4CHe1DHn/QrZ2KqLw9DnT1A9SOYmEDaW60ZJaF9g1SVoN1vowzjOniUNov6sP6aLDIUgyYLXaDPY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563823; c=relaxed/simple;
	bh=HXQm1yIIk6ZATMF8yluVVTZ0cPl4OWEyf7Jd7xP3Bcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDci4Jny4dxNI7Ww4L5V72L4OEOab3Gb2y8m72xuETVSWkRGrKP5pAVcpBF/z+BR4qKgT93CazoRKkk+BSjI4chI4D9Ffw6KT8HVZDUvbs8flOYgfoNiue4/EqZmppu0dQLanCyDWNv3Somcm9dB8G0Wyc1w+ry5vnF56qOVDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tlCI2tSr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tlCI2tSr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZcXm609394;
	Fri, 9 Oct 2026 16:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wzRV2L
	mBjQPiyC0I7dkq9CqMPgpGE0TcAMPtnS8sWcI=; b=tlCI2tSroZPXCt9vY1rwYB
	KFp+o/UuoIp3Va+shPyDbcJqko8R9TcdGhOyjPKdi2YG2AErXmwSdthXAogJ2F0j
	bqCNtCBKQz7zCdDfq+CmdnntxTyLhI9laHRDfaLNxOhJNOYx+ZBTzwcAnASYgXJq
	4rXw1yHAoKHZAIsiC61oI2xJjNzwQVDgMbmulFiMRDC52+kr4gk3r6AauvlB1Jiv
	VxfxNslr0kIMiF3YV0OVEvIWw+vlkFeQB5+mr3LvQddOcpo4WYoO0ccnrPvecMZ2
	+kC0aFI+fZdmsTegjdYI09lWPGI90k816etV0biJXi2dJFWZrjst4ah38Vqc6ECQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvu0v1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:36:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699GJOVF4068808;
	Fri, 9 Oct 2026 16:36:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u3pw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:36:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699GaVW539452940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 16:36:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FA1B2004E;
	Fri,  9 Oct 2026 16:36:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8782D20043;
	Fri,  9 Oct 2026 16:36:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.129])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 16:36:27 +0000 (GMT)
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
Subject: [PATCH 1/2] tracing: Do not initialize tracefs work if tracing is disabled
Date: Fri,  9 Oct 2026 22:05:56 +0530
Message-ID: <20261009163557.88467-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009163557.88467-1-amachhiw@linux.ibm.com>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-GUID: gsTwizmPPHxLngfgsVTtuy7lAWmPjDT2
X-Proofpoint-ORIG-GUID: T4OUPycY_YGqHVLkw9TSmHJMaISgaHUS
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac91814 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1LvLzkQZAlE5ysvQTrIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX0s8DsKQD1la/
 IOKTMk9kypq/yixVH5pMBJOniKaspWa6E+1a7S4yCx20M/Yc0ESKo4suEkrdhjy7By1+JG2o9rZ
 jFWJiM+cjgh0r44vMYWWjEOMDawQ0jM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX6Vl3wBXpiBQ9
 EZuUv1AatBWnkNbmdWp50pMouL9d6EI1ZpQe4jk2iOEFDiWEVTcXB0G9RSQF/jVw5nL9ghbmWia
 TPk0UV8crCUMAPPUExfsl2MF4ujZsvk+5GYE4ufTHEr6J2jqU5wyNCfTejzmNn01HrKH/WoxqYV
 bS3MBOdxxQ/P9aj0oGFIJXkNdQYulphPZxb+PiTtEdxy27dCVdXBGdLgf8pUSHjwgqisznAbcTA
 n2vEDGj/xU/L259d+h+OPNI7WSMltJGIfQzIzEhKC91CEo41xUl8nLImH3/gtGQ36d5+nA5pr85
 vqHngKjNYe4p5brfUrMi08zqJleV4iooN2p0QNbNbNdh51mHyC9IhaRbUx3GgIa8ws75uflT1+R
 grU/p5qCFi3xX7V1oMoYgtMoa/ZZJV2ozr8fjeXtUEF3TMOERDetpjytVnvfOnf3GqURRnnpt1X
 Gi31lRfBgxuxhLi4Iqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066

If trace buffer allocation fails during early boot (e.g.  in
early_trace_init() -> allocate_trace_buffers()), tracing_disabled is
left set to 1 and the global trace array events list remains
uninitialized.

Later during boot, tracer_init_tracefs() (invoked via fs_initcall)
queues tracerfs_init_work asynchronously without checking if tracing was
disabled.  When tracer_init_tracefs_work_func() runs, it calls
event_trace_init() and init_tracer_tracefs(&global_trace, NULL)
unconditionally.  This leads to __find_event_file() dereferencing an
uninitialized tr->events list, causing an early boot NULL pointer
dereference Oops:

  BUG: Kernel NULL pointer dereference on read at 0x00000010
  Faulting instruction address: 0xc000000000485be0
  Oops: Kernel access of bad area, sig: 7 [#1]
  ...
  NIP [c000000000485be0] __find_event_file+0x70/0x3c0
  LR  [c000000000448874] init_tracer_tracefs+0x274/0xc80
  Call Trace:
   init_tracer_tracefs+0x274/0xc80
   tracer_init_tracefs_work_func+0x50/0x320
   process_one_work+0x1e8/0x5c0
   worker_thread+0x1dc/0x3d0
   kthread+0x194/0x1b0
   start_kernel_thread+0x14/0x18

Check tracing_disabled at the beginning of tracer_init_tracefs_work_func()
and return immediately if tracing is disabled or failed to initialize,
preventing the crash.

Fixes: 6621a7004684 ("tracing: make tracer_init_tracefs initcall asynchronous")
Cc: stable@vger.kernel.org
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..7ac9e1c92702 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9287,6 +9287,12 @@ static struct notifier_block trace_module_nb = {
 
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
+	/*
+	 * Do not attempt to initialize tracefs if tracing was disabled or
+	 * failed to allocate
+	 */
+	if (tracing_disabled)
+		return;
 
 	event_trace_init();
 
-- 
2.54.0 (Apple Git-157)

