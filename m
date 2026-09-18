Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363B4EDCDE;
	Fri, 18 Sep 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748868; cv=none; b=XZyO6mATih5ozeQUDphtfk/+J67cVpHLx5EDoTmFLIv3phC1hDb9rYO4q4PLff/7GcCxAH+VNHgonme8jqPmC7p2gvVuxxaq9jmq/IdWUQh3rFvkO5UJfhT+FG1yVeoJpGwWfO1sbed7P+STujW06wkyf1B890ZVsdNTX3uCoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748868; c=relaxed/simple;
	bh=dNJUCQxPilzp6newgbWXraokwGhDSL+qgKd75dUqn34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3AECuSCa3MQpfBJqatg0oSNNRBeIoqfJL8/7Al6q87r8PQjEgpkI44fnt/xd7s0ycgGWOcyk9GClEuA5lyEeBUnUsKwwJdiciSgDfKGXs0PS7qDPsem5oZtfHRvyObe6zLNmNP3wXh9kr7KFI0STqjCJ94V2ZO/YOA0XK8uF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m+nEUDr5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m+nEUDr5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVpWV1421620;
	Fri, 18 Sep 2026 16:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=diSL3g
	PVIIsLP1y8rBsdiH9e7yVfU/AgUy7G1K9EC5E=; b=m+nEUDr5Ylfr4krcLS5fQD
	+kNxdjikpfxIa1Sv5ZEvZql9ZAZa6h6P8EfDRyr9IU/dQ3AdnOMKEiVnm1XPj97q
	7BX0jNHJImIcWZJOybDAVJD7wvUp45SLNC3DGmhXrqTNJhXd53wEoTIxZqPMbFK9
	N3kozwbnBvjpjzbLDUmjnblaGKzNbitt0lm/MFDHGDq/kqPcibovwL36T66d1h38
	E7rx9vf554DN6a/YWVTSeG+XADc2YpVtedPyUeOY0XSgwK+Rrh3J9yCxcTl3j8KM
	6nROp5FHhg67PkGva07Jv1e3AULnzlDa0vZeadLYLUzqS6q5yyoWJFeaTE1RaMtw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvgh52-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:27:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO2Gc771897;
	Fri, 18 Sep 2026 16:27:04 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffg6c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:27:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IGR3bP14680736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 16:27:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0183858052;
	Fri, 18 Sep 2026 16:27:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D56358045;
	Fri, 18 Sep 2026 16:27:00 +0000 (GMT)
Received: from [9.224.64.252] (unknown [9.224.64.252])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 16:26:59 +0000 (GMT)
Message-ID: <c52c9e8c-260e-49a4-a88e-229e0795d07b@linux.ibm.com>
Date: Fri, 18 Sep 2026 18:26:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Fix DL server divide-by-zero for inactive
 CPUs
To: Hui Su <sh_def@163.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260812123252.2355986-3-sh_def@163.com>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <20260812123252.2355986-3-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfXyyyc/bOQ1h/D
 DpnWTDm+ab2s4R2nPwFK6BTp/rCe3qXgH79ytA4uQgrr3PCwM3eDyQPcTHVti6i/c4buo4iJqoE
 cb2TAXiWtorRV5Kt1WZQ2juEqovGFDI=
X-Proofpoint-ORIG-GUID: 5Iiabi1vrPH-IF5YqTNpXI7xrvh9vISC
X-Proofpoint-GUID: hf4yfVzoTVulraZKsxkO1eMEkwkU-9jS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX3ehA8JH6R3/q
 t9xse6lQBAHD2i6b1hXJ+39aCtxcrfbQrCPftmkwu/w3F6uuHkNpr7wQnpmF3wGXnsQIfEHEvkk
 ZUIcBNmmK7U4+txZaXXY3tvAVEahEtouq2n32nvMncwjXX8cwDv6+gzikGY4x0tAaDI9a8ms7bm
 juwTsov309F3VfuVJclLN/NVIIUD4i0wzDEbMKlEgZEKQ6ZpRmd/mT0f+YDLiTRNiUQYaxxy17w
 OPe94Le/qy1UK9Ssn2dooUhvZsWuzj8WAY99Xxa1oxKmOR6Gb7GDiVBvCmsnSCsHSwGs+NHzMKJ
 o/B8Z8WCvvBfVwcu3CEg9WeJ8BNEnNVK+oCgOfeKQH5emD+IzivvUKUm+Rjv71/6n1PVNjF2ghQ
 42Z9yrucq1mLH7apGym9gc2GA/tEIl90DhK1k/82fzcDCR0hQFqV9is9qnHjXmEQW8df9ebbDYF
 XlpX5fTo2aZ2A88NcbA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad6659 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=5hoDY7baIL5RK_9Huj0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180229



On 12-Aug-26 14:32, Hui Su wrote:
> Commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
> for offline CPUs") rejects per-CPU DL server parameter updates once the
> target CPU is offline. However, during CPU hot-unplug, the CPU is cleared
> from cpu_active_mask before it is marked offline.
> 
> This leaves a window where cpu_online() is still true while
> cpu_active() is already false. A debugfs write during this window passes
> the cpu_online() check in sched_server_write_common() and reaches
> dl_server_apply_params() with init=false.
> 
> dl_bw_cpus() counts the active CPUs in the root domain. For an isolated
> CPU whose root-domain span contains only that CPU, it returns zero once
> the CPU becomes inactive. If the server bandwidth is attached,
> dl_server_apply_params() then passes this zero CPU count to __dl_sub()
> and __dl_add(), both of which divide by the CPU count.

Hello Hui, Juri

We hit the same divide-by-zero on s390x, but from the sched_setscheduler()
syscall path rather than debugfs:

[  836.069103] fixpoint divide exception: 0009 ilc:2 [#1]SMP
[  836.069114] Modules linked in: algif_hash af_alg ctcm fsm zfcp scsi_transport_fc mlx5_ib ib_uverbs_support ib_core mlx5_vdpa vdpa vringh vhost_iotlb nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables mlx5_core s390_trng ism eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core drm_panel_orientation_quirks diag288_wdt hmac_s390 prng aes_s390 dm_mirror dm_region_hash dm_log pkey_ep11 pkey_cca zcrypt phmac_s390 paes_s390 rng_core pkey_pckmo pkey crypto_engine uvdevice autofs4 ecdsa_generic ecc sha512
[  836.069173] CPU: 19 UID: 0 PID: 1005719 Comm: stress-ng-cpu-s Kdump: loaded Tainted: G        W           7.3.0-20260917.rc3.git3.a10f6da4ba31.300.fc44.s390x #1 PREEMPTLAZY
[  836.069178] Tainted: [W]=WARN
[  836.069180] Hardware name: IBM 9175 ME1 705 (LPAR)
[  836.069182] Krnl PSW : 0404c00180000000 001925217a23136e (task_non_contending+0x19e/0x370)
[  836.069191]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  836.069194] Krnl GPRS: 0000000000000000 0000000000000000 0000000000000000 00000000ffffffff
[  836.069197]            ffffffffffffffff 0000000000006666 001925217be2d038 001925217a237950
[  836.069199]            0000000000000014 0000000000006666 001925217c3785e8 000003f15af10330
[  836.069201]            0000000000000000 001925217b284f40 001925217a231366 0019249f1e61fbc0
[  836.069210] Krnl Code: 001925217a231360: c0e5ffffdff8        brasl   %r14,001925217a22d350
           001925217a231366: b9140059           lgfr    %r5,%r9
          *001925217a23136a: b90d0042           dsgr    %r4,%r2
          >001925217a23136e: e330f0a80004       lg      %r3,168(%r15)
           001925217a231374: c0a000dfe7da       larl    %r10,001925217be2e328
           001925217a23137a: e32030f80004       lg      %r2,248(%r3)
           001925217a231380: b9090029           sgr     %r2,%r9
           001925217a231384: 41903018           la      %r9,24(%r3)
[  836.069243] Call Trace:
[  836.069245]  [<001925217a23136e>] task_non_contending+0x19e/0x370
[  836.069249] ([<001925217a231366>] task_non_contending+0x196/0x370)
[  836.069252]  [<001925217a231678>] switched_from_dl+0x138/0x190
[  836.069256]  [<001925217a207f56>] sched_change_begin+0x116/0x330
[  836.069260]  [<001925217a23b0c6>] __sched_setscheduler+0x1e6/0xad0
[  836.069263]  [<001925217a23baba>] sched_setscheduler+0x7a/0xb0
[  836.069266]  [<001925217a23bb66>] do_sched_setscheduler+0x76/0x130
[  836.069268]  [<001925217a23be7c>] __s390x_sys_sched_setscheduler+0x3c/0x60
[  836.069271]  [<001925217b125850>] __do_syscall+0x1a0/0x4c0
[  836.069274]  [<001925217b135b42>] system_call+0x72/0x90
[  836.069277] Last Breaking-Event-Address:
[  836.069278]  [<001925217a22d3ac>] dl_bw_cpus+0x5c/0x70
[  836.069283] Kernel panic - not syncing: Fatal exception: panic_on_oops

In this case dl_bw_cpus(task_cpu(p)) returned 0 and task_non_contending() passed it to
__dl_sub().

CPU offlining was running concurrently. 11 seconds before the panic:

  [  824.924635] select_fallback_rq: 11 callbacks suppressed
  [  824.924640] process 1005879 (stress-ng-cpu-s) no longer affine to cpu118
  [  824.944307] process 1005883 (stress-ng-cpu-s) no longer affine to cpu122

There was also a preceding WARN_ON_ONCE(!cpu_online(new_cpu)) in set_task_cpu(),
reached from dl_task_timer(). That looks like a separate issue.

I have no exact reproducer at the moment, this is a CI run with several workloads in
parallel. But we can test a candidate patch in the same environment.


As for the patch, the same division is unguarded in several other callers
in deadline.c:

  task_non_contending()     (this trace)
  inactive_task_timer()
  set_cpus_allowed_dl()
  sched_dl_overflow()
  dl_bw_manage()
  
so rejecting inactive CPUs in dl_server_apply_params() closes only one of
them.

Would it make sense to guard inside __dl_sub() and __dl_add() instead?

	void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
	{
		dl_b->total_bw -= tsk_bw;
		if (cpus)
			__dl_update(dl_b, (s32)tsk_bw / cpus);
	}
	
	void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
	{
		dl_b->total_bw += tsk_bw;
		if (cpus)
			__dl_update(dl_b, -((s32)tsk_bw / cpus));
	}

__dl_update() walks for_each_cpu_and(i, rd->span, cpu_active_mask) over the
same root domain, so when cpus == 0 the loop body never runs anyway.
Skipping the division changes nothing else. Yes, total_bw is still updated
on a root domain with no active CPUs, but it turns a kernel panic into an
accounting inaccuracy that already exists today.

What do you think?

Thanks,
Mikhail


