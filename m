Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C83318EE6
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760360; cv=none; b=MtaT5BPVflSJvZCylW2sreP67s4vvO1IaoO1Ikl7Bw+gbLeX4DZD2NuHhDBRb1MI+v6lV/u05+56gxXFB3zkjNPt/+r++lxANKmPPa1ZTDhATCECXfVEuM1ojsOU/PwGh7zn8NlTfBrkQSNLiOnkJtF1lIjXjlcUWN+56ZdcJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760360; c=relaxed/simple;
	bh=7JtV5uLXpEOdrc7VhsN+CT22r+AmMSBTlvwiyW3OsLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qoaogR8YrFqwRB30Ti/2eHoG6EBOBCAyeBT1p85lfxmdQmcBtNsky5Js3kpV1RuCrrQG3jMhSK+qPYt4XxTqWWeGcttdWoS89fR3iuZyZrYpRqN8fOjaz88cprTPFgVbU19u8YyKJNBSNkmav9GnUgLdvdzYLoZdQnXRBSP9YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frvERqte; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BT7iNnXL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frvERqte";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BT7iNnXL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGKHIJ3406666
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=53zfVdPigWdhI34k28igXx
	FUdaeVfgx0fZfm0IjaFw8=; b=frvERqteh68FQryUsFPh/XtDouQz18R8TYA1OX
	Es1j187SlJNIyTt8p8gM8nnie8oBj2qCILnc1p/bl6rslBqzFcrHvd14PzgxoTTs
	x4wIUmX/OOuziBi2H+PCHhdkXDgIrn/UpbK4kOVtAydmKz7PlGf4Rj2V4wbJRUd7
	NtjuCboRPlTXFHdgJ5SI6MJAhTy261aCa1dy7dkMZzsGEjNSqR246MMr2+Y42qQW
	snA118V+9oMNC7p8GI/j27iBmxNy4hSJNngJrFhTfOwfU9G+AKgkFP+Ulap7BkfB
	YGwo/rMolip5UaO6f+TfVqymZtKkOTSB5oXk3nyLe+rAmOgA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq8ap2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:12:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4237463eec.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782760357; x=1783365157; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=53zfVdPigWdhI34k28igXxFUdaeVfgx0fZfm0IjaFw8=;
        b=BT7iNnXLDKwdSK2bBWtbGBNffCxgrcqNhscHw6slvk5JmJ6mXlS706fUw/a7lakzft
         8PwaeKFQeQ71PXSUDILcxyyvPrdjSbNu8xMvGzHw0UADvzrN/GeqXg0MROsJrWWV5KJj
         44uQeHrf3+s5zxeu21dDTyKOBwE8hnoRFSUOo2PcUiGMTAfiOkWDbyy4dbqG7M+q16Ww
         BabPDxf6C6bQysL6RXFBZXuX5f+/TUDWafo6IM4w77lMQyHAREUwaoe0mKVYxkmHnYPM
         vl4F0XBJYsEt1dZXnstAtdsfPeqlr83ChSOuEAHu8yKqQ9+kV4BHbAdLM19ArVZP+7rq
         sg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760357; x=1783365157;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53zfVdPigWdhI34k28igXxFUdaeVfgx0fZfm0IjaFw8=;
        b=VdkgaLJzegkCzEgICmOsazwnbCeM1qhmktT3cojbHU0V2VM9MOFdKGj6FeewlbIptD
         PTFCNI/L8lwfiEQhHOagTg3aElnf3xo2m2P5mCE0wFKy4QnpQDVqAWAQ7Xzok0cQ/Ypz
         LEFeG+1sgD1hTaK+azpeLqYZlneNLQz3G+lDFrhVCY3oVqA2+btSiqP4pDYFF3B+jZ4D
         nhHfu5XKYPQGMpgh3/OeN3mili+9ZZn/4TmlKLXoCx5XUUuGEEfFKIoIsoBqUi9awzqS
         +cMVDE/e1HAbWjG9m8wFeanXUxaMs/3yh4KLlkNImwAil9YKdpCeCn+6T/a6A8aiGnhL
         7ncg==
X-Forwarded-Encrypted: i=1; AHgh+RrytvhS1k/Qh1vSm6Z2zlEY1xpfFxKE0YSxTAOESZkvk6SwNqN627A2Kh9ojyFHns7OHaU8ShQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6HIDWDXAjPTq/RAA+9MZ0YzS98COkAk+PjAVZTQnT7vWHXyiz
	jMy6/vixhml7W3Yd1jplJUAVCjPe7oJIdZw8MSYE/LqlGF3uL0gUZbpHEMVsQS7ezyJRqYM2yt7
	VvEvVv3fZVcM4fyZYqlEOvL/0bwmZt1+KW72zfoYPYh8bq2IEAj2fH/y3ycE=
X-Gm-Gg: AfdE7ckctJDYOKzjD5sewzLyAZHpRyXSPxTnN1dOqrcIjcrleTfwBfLFaxorxnDR4ix
	Uv/7Orlm2a03CryoIBKbYoAlQS5KB5GnVW1QHld5n9kyGrq+hiz4IDCaFMSeicHveYfMAVmWhgM
	SY7BVbcWrs31I/ygnoVdwkoGXmIcH307xZ/NoauQBvpN75JA5zIC6BNaxcju6aDJdNvyrEb+r01
	z5i/yslsfx7X83UItI0DjQwMHtsZTx8TLYL3A1D5GGsWrP6wOq7CsIHM0RqgDangMAXxiCnvpfU
	PcT3Q9boxLCFrrG18V41RZIEwWliMnhRkA8vE6LCdwZxR4+wNxyBM5sM/k+geXVMQvQRsKLv/HO
	jFfwjZEXCMUPjap36os/7e5moLTyEnS0=
X-Received: by 2002:a05:7300:545:b0:304:bce8:fa30 with SMTP id 5a478bee46e88-30ee11ab946mr695854eec.5.1782760357106;
        Mon, 29 Jun 2026 12:12:37 -0700 (PDT)
X-Received: by 2002:a05:7300:545:b0:304:bce8:fa30 with SMTP id 5a478bee46e88-30ee11ab946mr695824eec.5.1782760356530;
        Mon, 29 Jun 2026 12:12:36 -0700 (PDT)
Received: from [10.213.104.145] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5c4c3sm391958eec.2.2026.06.29.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:12:35 -0700 (PDT)
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 00:42:12 +0530
Subject: [PATCH v2] perf/core: Fix group leader use-after-free after
 sibling detach
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIvDQmoC/4WNQQqDMBREryJ/3S8xJAG76j2KizR+NUWNTYy0i
 HdvYg/QzcCDNzM7BPKWAlyLHTxtNlg3J+CXAsyg557QtomBM66Y4go7+8beu7jgSLolj1F3aIS
 qFSPJJTFI1cVT8s7Ze/PjEB9PMmveysZgw+r85/zdquz9udgqrFAbKZTkRtdC3FwI5Svq0bhpK
 lNAcxzHFzmeUJXRAAAA
X-Change-ID: 20260626-fix-group-leader-uaf-c46960e525e0
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Aditya Chillara <aditya.chillara@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782760351; l=6043;
 i=aditya.chillara@oss.qualcomm.com; s=20260626; h=from:subject:message-id;
 bh=7JtV5uLXpEOdrc7VhsN+CT22r+AmMSBTlvwiyW3OsLg=;
 b=I5iIeZD8pQc9DseD9NXnJMQGE3MwigZjAh4po3xOuaPQk3SjgesWlZtQbZ+JG4dOMMwcLeNnO
 DZHjJK98BXzD+IhieDDER84XWUChyYva9X214jrY+qwsSBD6Tnq2ZM7
X-Developer-Key: i=aditya.chillara@oss.qualcomm.com; a=ed25519;
 pk=3vcOzHlHNCpL/4rvfU3cpTk2xIC7SI+TH0gypa9FdZQ=
X-Proofpoint-GUID: cpy64hqNmumE-Pkj7DmtWZfCxDWLGMwa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE2MSBTYWx0ZWRfX9Al5amSzdRoh
 IMS85d0ZfJGSdB521XhzSAV6wpdm3XaFa4LMUnVnpAsMyo9Im+YfdD62hseq2rSEfptaKvp2NHI
 IcRFIfhwulmj4x4DjXL2+ySsivux8A4=
X-Proofpoint-ORIG-GUID: cpy64hqNmumE-Pkj7DmtWZfCxDWLGMwa
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a42c3a5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=8GH6xakp1RB7l4jbzwoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE2MSBTYWx0ZWRfX5B9ecp3tPfhP
 8Y+re1+78ZhRDHfvRuWYC0NaImbS/HtaMejXWoIgLetq0r0xOMtfcrv41JeVUkN/kD3YDbjrbEt
 h+F9Aj7AFORpVI4sZnMQ1onPRivU69oWuO3oIMiwD6Jq3pYk0BwcRcDYvTnwkQt+v9H5ZCl47eC
 bQin5bUQ4ftSP9UbB9Ebcy3RXeBNfhXfmv7uAUI+UDfVqRcXD+HXx/EA5s2byJFVvCltaLRY25x
 vTtEQGyAGb3OGm6B1AvLxvgej62kXEaa6ce8AXOVRJJ52/OtVHSwWleK1+ba7iTV+gKhWV1UIQN
 RUd67dYkVwipA9g9Ho9H3KJlcEiKXeiNGJtlKQlObI/oV5Eh74U6N/KK/xCdo3WpwtqkWLlbzrZ
 6SyVAEYDBz0OAn/kZp0AtEc00x6FTvDwYfDyU8o0C96Mh4/Dt/RhG1j9M0rxO+6/DEWyMKzTqJg
 OCfCwH8jPEnqssYvZzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290161

perf_group_detach() handles leader and sibling detach differently. When the
group leader is detached, all siblings are promoted to singleton events and
their group_leader pointer is reset to themselves. When a sibling is
detached, it is removed from the leader's sibling_list, but its
group_leader pointer is left pointing at the old leader.

That is harmless when the sibling is being closed and freed immediately, as
in the DETACH_DEAD path. It is not safe when the sibling is detached but
kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
sibling is removed from the context, while its file descriptor can still
keep it alive.

A typical failing sequence is:

  - A group contains leader L and sibling S.
  - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
    L->sibling_list but leaving S->group_leader == L.
  - L is later closed and freed.
  - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
    dereferences the freed leader.

This was reproduced by running the perf event fuzzer, CPU hotplug, and a
stress workload concurrently:

Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
pc : perf_ioctl+0x34c/0xc68
x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
Call trace:
perf_ioctl+0x34c/0xc68 (P)
__arm64_sys_ioctl+0xa0/0xf4
invoke_syscall+0x58/0xe4
el0_svc_common+0xa8/0xdc
do_el0_svc+0x1c/0x28
el0_svc+0x40/0xc0
el0t_64_sync_handler+0x68/0xdc
el0t_64_sync+0x1c4/0x1c8

The fault happened in perf_ioctl(), where perf_event_for_each() follows
the stale group_leader pointer and perf_event_for_each_child() then
dereferences the freed leader's context.

Fix the use-after-free by promoting the detached sibling to a singleton.

Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
Assisted-by: PatchWise:gpt-5.5
Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
---
Changes in v2:
- Moved the fix to perf_group_detach() with a small refactor
- Link to v1: https://patch.msgid.link/20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com
---
 kernel/events/core.c | 62 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 954c36e28101..744643ada948 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2253,6 +2253,8 @@ static void put_event(struct perf_event *event);
 static void __event_disable(struct perf_event *event,
 			    struct perf_event_context *ctx,
 			    enum perf_event_state state);
+static void event_sched_out(struct perf_event *event,
+			    struct perf_event_context *ctx);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
@@ -2343,6 +2345,44 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 				    &event->pmu_ctx->flexible_active;
 }
 
+/* @sibling must already be unlinked from its old leader's sibling_list. */
+static void perf_promote_sibling_to_leader(struct perf_event *sibling,
+					   struct perf_event_context *ctx,
+					   int group_caps)
+{
+	/*
+	 * Events that have PERF_EV_CAP_SIBLING require being part of
+	 * a group and cannot exist on their own, schedule them out
+	 * and move them into the ERROR state. Also see
+	 * _perf_event_enable(), it will not be able to recover this
+	 * ERROR state.
+	 */
+	if (sibling->event_caps & PERF_EV_CAP_SIBLING) {
+		event_sched_out(sibling, ctx);
+
+		/*
+		 * The guards keep this correct even when @sibling is already
+		 * disabled (see __perf_remove_from_context()).
+		 */
+		if (sibling->state > PERF_EVENT_STATE_OFF)
+			perf_cgroup_event_disable(sibling, ctx);
+		if (sibling->state > PERF_EVENT_STATE_ERROR)
+			perf_event_set_state(sibling, PERF_EVENT_STATE_ERROR);
+	}
+
+	sibling->group_leader = sibling;
+	sibling->group_caps = group_caps;
+
+	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
+		add_event_to_groups(sibling, ctx);
+
+		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
+			list_add_tail(&sibling->active_list, get_event_list(sibling));
+	}
+
+	perf_event__header_size(sibling);
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2368,6 +2408,7 @@ static void perf_group_detach(struct perf_event *event)
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
 		event->group_leader->group_generation++;
+		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
 		goto out;
 	}
 
@@ -2377,29 +2418,10 @@ static void perf_group_detach(struct perf_event *event)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
-
-		/*
-		 * Events that have PERF_EV_CAP_SIBLING require being part of
-		 * a group and cannot exist on their own, schedule them out
-		 * and move them into the ERROR state. Also see
-		 * _perf_event_enable(), it will not be able to recover this
-		 * ERROR state.
-		 */
-		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
-
-		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
-		sibling->group_caps = event->group_caps;
-
-		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
-			add_event_to_groups(sibling, event->ctx);
-
-			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
-				list_add_tail(&sibling->active_list, get_event_list(sibling));
-		}
+		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}

---
base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
change-id: 20260626-fix-group-leader-uaf-c46960e525e0

Best regards,
--  
Aditya Chillara <aditya.chillara@oss.qualcomm.com>

