Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38323E9C2B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467751; cv=none; b=ll2ragFAUYvX3BNIbVetIRhqnTx8GX47Mg7hMJ4Z53TwBZ+UqeoZPv93FRkiIonIBegE12fx+w78qzIG7H2Nu/RdbtSRfq4gGNC8wCsJdXiSIz6IU2H5fXlOF+X22R4Myu68qRp7cmMVxsW039sN2J8VdlIQ8cUWrUykDZQNLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467751; c=relaxed/simple;
	bh=EGRZecSq+sUoznuRW1tgHj6m0+m7k+jc9maFmGWRgSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XLOyaS2SCUxdXZD06ZUX3i62GfAIcYqkQOc4VBxuiZJ4f26d37mzpUf57AqiDQNyWtlB5NXdeVxicGGzc2Qtq9ckCP86kxTQ6QpovaI1zpBADlmQLO/7jjA4kaK3fktg9QBi5almp24VJafuT6uTMudIEamGYBv3XZwkJwgR4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOJt+8V3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SrIgviim; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOJt+8V3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SrIgviim"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6VY5W2823432
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jY0XweZHkyutQNq/majYUA
	IffJIhcMhnlmvSgDhUgp4=; b=jOJt+8V3jyQgztUvKp/CPcVV8nIlYAoHtGYlJq
	RpV1rA+sZjciYW5wVy/+OmnE9Qo25JsdZthBJzoiodJUl6Axxc5C71lL3q+ozTf7
	6KQ+TeuoYxc5ESxqqj1BnZHkUBFnIw4PA+EPLx2KqpEyOj4NBWOZahbzdfXuJ6M9
	vA54uYdnMZUXEDv0N0wzM0JXjFUpWabkiXidhnuhGDxdmVpCHkPZZlGflGUbIjBW
	8ljHexKGnELD4fAk/xunmMSH5velBaR993XPDcvzWEiZxbNO3daBr6iqSuEYK/S0
	bXM996Yc5nBHr5OBGNeQ8bujd5ul1uv613LTdg3YqJEmrWgA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f19m3u602-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:55:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c50cd6cbcso1009054eec.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782467747; x=1783072547; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jY0XweZHkyutQNq/majYUAIffJIhcMhnlmvSgDhUgp4=;
        b=SrIgviimeo/EHQLVHZ+P1jD2aFc5tX9p/NHSCIMvCKD8TrwqfNk/B9biOGuom5PfWi
         gTI2M2UqmA3W02VH1X7hc6Gp6YLz/s0Xw2IxwKekWV5Q57wtYtf2V0q/XD/VqPJHZhkm
         aSXnBQDNreYAbwFHEjBy0JpiU/3qriDcrUppyiFue3nb3nvfbkkUA7KJo6TWLTw/aZry
         jHvwngbLLpxzcyhyacbd3ebCsSN2OEbCo/RRgectdsfrsPER8u53yEPz98pyay+nDoY4
         O7aqXxJ4C0TerTg7r0El7aA6r+8vJHoB6XW6J+D74TsJwDJ5eUHoU+G+nXrlp/oEoECP
         T6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467747; x=1783072547;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY0XweZHkyutQNq/majYUAIffJIhcMhnlmvSgDhUgp4=;
        b=bFbivUwLUdqQUCm2wwbG1tidQYo7O7KHrI1JiNW6Q2oumYg+XBvm4NnY0EYk/QUikT
         fqAA7JTmUhFkESF5/d7Ch4BuG5nl6/emNCtBo3mtPqHLXneCLVxsPg4ntTgkruoc2T3M
         mieZ6ZvEIIEFoF5CZhSy6NLC88StpLEsAFb93yOfD4qTcVjtgjMMOl755+45nc+gx4XA
         0Wfaotw43BtwsqYAcTEnol79xcuEYNW7txlAxnciYbHsNmBb1adMdUc8P7h7X3f0FiY7
         1N3+KG2JP00lV6CGuu/DZ6+9UhcGBzRvYGumAxTMgw3csTDzQcQ5FljRyHdW9sB6LPu/
         rQRA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3vfcTFevM/bogpioo9L3gkbJ8c7fJS+iMMUkLImTA3gEaaZAansxIewS9yh93TdgtvA8zOZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ryNhbChE9ccwpSaIwy6YeUemUF+bRjt8/Vx/+Sv9RQHlwgev
	ZQDKQKVn23YV0ch2CDhEBQX3KMzC3bUYlFumwkBlt6x4iaNMOc935hscZmxsQraWCOo2yURyGIV
	KKWbdjGLoHyVzTQ7wxQbNSvapioQdb67qiGVMNKK+ideoVOK9XtPwQHzjrbfjMIEZchY=
X-Gm-Gg: AfdE7cmCfMEW5ji800c93gPx+rgSYb4h4H1HMxVSvwYsLIYcsNqqoaqcWPNDdW5d0J+
	4S5hgOSchK7AbKnNoTnBZiroiPtXw4Ksx0bXzVPchMmP6t13k4zcUwSie8xKOXTx1pRMwHOafC4
	24tka2TXt+lG1txj9jy5PShjpkotRILSjlf8gy7MZTZOh1Hg3uWR9k3iSaVBS++zcrvkNBYmipV
	i05VP+EFPXSy1kjo3s7BqS1XqP8AFejDT0d8gAZkt1aOuwzF6GtuVAaNWDJABnKuUBLYQnWifYV
	75OiestQ+7tnunBHSDRT1fpnQ/FThuYTkEZGzp8tERmHJH0YVYdKDhHts0Jk/qMbjy64VtyEFRx
	319kx+nEoIhN9S1jeek+8e4yOPNUyUmU=
X-Received: by 2002:a05:7301:1930:b0:2fc:9aa8:83da with SMTP id 5a478bee46e88-30c84d4ac97mr6609171eec.29.1782467747320;
        Fri, 26 Jun 2026 02:55:47 -0700 (PDT)
X-Received: by 2002:a05:7301:1930:b0:2fc:9aa8:83da with SMTP id 5a478bee46e88-30c84d4ac97mr6609099eec.29.1782467746076;
        Fri, 26 Jun 2026 02:55:46 -0700 (PDT)
Received: from [10.213.104.145] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afc91sm16971167eec.14.2026.06.26.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:55:45 -0700 (PDT)
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 15:24:57 +0530
Subject: [PATCH] perf/core: Fix group leader use-after-free after sibling
 detach
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHBMPmoC/yXMUQqDMBCE4avIPnchDXXBXqX0IY2jbikqm6YUx
 Lsb9fGDmX+hBFMkulcLGX6adBoLrpeK4hDGHqxtMXnnxYkX7vTPvU155g9CC+McOo43acSh9jU
 cletsKLsj+3ieTvn1RvzuLVrXDYrijvB4AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782467740; l=3343;
 i=aditya.chillara@oss.qualcomm.com; s=20260626; h=from:subject:message-id;
 bh=EGRZecSq+sUoznuRW1tgHj6m0+m7k+jc9maFmGWRgSg=;
 b=zEPD2vxgjCwp7/aYJ4vK38KLIJG+Xr8BXe2phnkRKu4d3DD4UxbjlZ+FG9XM7Z+wP1a3VKgil
 L/X3mSR+EdiBO69mHmerVR95FoMECCbCyE9+qxm5U1tH7btYJs3k2jp
X-Developer-Key: i=aditya.chillara@oss.qualcomm.com; a=ed25519;
 pk=3vcOzHlHNCpL/4rvfU3cpTk2xIC7SI+TH0gypa9FdZQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3OSBTYWx0ZWRfX4gLlY3YGoeTA
 XA2mG0czEmYTzVX+MOccQaajaD2YKLz7bKo3Ju7ZI0zg1kaGpWDc0QjRUWYH/s55dxLWvPnep9H
 QvAo1MB8SHSTd4LNq8ueYXmxBI11Edo=
X-Proofpoint-GUID: JtvdkR9EvwWiVdd28GsRcu0vBSzJLm5I
X-Proofpoint-ORIG-GUID: JtvdkR9EvwWiVdd28GsRcu0vBSzJLm5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3OSBTYWx0ZWRfX0hhQA4G6zDPF
 iJsaeJGmVi+Pn1nPcZ2PIOz8frfHDfC7TN/4Cz63PP6wKAQVpIWQNdpSVd1z+FhVsS5N6NwbnHn
 92uyZev/tEskQpHdhPADDEe3zBwSd1vlv3ZvEpjnuzdwgl+OU7nDN5GLZT00mX4SXg0ZwR0dVxH
 l8s63Cip8tD8h9EPYNLlU8KIj3IP5FdcowMU9Ko0ukCxnKrMljMaIfH3/wRWwzHA0dkRXRYvi9a
 HdGKFfC3FehEA2fZWapmURFMsLFq6vy3I1nu8BABVc/Bm4zD57g6FZ6F+vPjCm+O/gvdoDcWZRO
 SCc8WLCT9Q7lqq7tNM0u72wguyS3YRhv22o0BCeVj6hR0Sh3Lp7OS+EmvOqGPTJ//cBRNJ4985G
 Naa6hSJP7m4kdTctswZ+0v3UEw12xz3t8eWLZxsPu5h++X9/nvlwxLc+obYeNWBAzqyeMs0qKsV
 VrTeY3dmtqMibIWcgAA==
X-Authority-Analysis: v=2.4 cv=Vv0Txe2n c=1 sm=1 tr=0 ts=6a3e4ca4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ALW25PGDtRetjCARC78A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260079

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
 kernel/events/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 954c36e28101..dd9892040ab2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2605,6 +2605,26 @@ __perf_remove_from_context(struct perf_event *event,
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
+	if ((flags & DETACH_GROUP) && event->group_leader != event) {
+		/*
+		 * list_del_event() needed the old group_leader to tell a real
+		 * leader from a sibling. That's done now, so make the detached
+		 * sibling self-contained.
+		 */
+		event->group_leader = event;
+		event->group_caps = event->event_caps;
+
+		/*
+		 * PERF_EV_CAP_SIBLING event requires being part of a group, so move
+		 * the event to ERROR state if it is still alive.
+		 */
+		if ((event->event_caps & PERF_EV_CAP_SIBLING) &&
+		    event->state > PERF_EVENT_STATE_ERROR)
+			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+
+		perf_event__header_size(event);
+	}
+
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
 

---
base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
change-id: 20260626-fix-group-leader-uaf-c46960e525e0

Best regards,
--  
Aditya Chillara <aditya.chillara@oss.qualcomm.com>

