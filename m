Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E622E7165
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330201; cv=none; b=J1UJkyEXO22bI7ng9n7Z+MImgKG4DkPXfp83EzviGGQC9hbDEfPq8LBFxUx36FMsHEuUkB+CV6GLB484xanZwR5+il+7oRHv75yxDmuk7MCNKFGjSFWwtnxCBu3wUxWGd1OeS9svzpyCIcm0k8m2tf5kG+zm+qDDRLwqA3hmygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330201; c=relaxed/simple;
	bh=U1ykP2v4vBanOjpsoDqzdLlC3dQbDgoQVd9oGf9UHZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qq/nmd8U1vGQGGbID9mrJ1hA746CTdvhFyQ9hrQry6mkdZysb4lh5qouXun/7aRSr7yn4prJrrU7B/YgkbV3PRSQSgPXj9PWuxjE641DpjMspitBKtC9DYptx6TSy9q0hiYyFBJ3dp2evUeTqbHCGEaT6F+LPtaI0Qh2vDOyheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGjRHxMf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CrPQBFLO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGjRHxMf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CrPQBFLO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YcSW3532125
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0QNRZM/+ly43XM1TDOLVOU
	BQNvVjmzMTjRLEM43AcCo=; b=TGjRHxMf98XDUqNcnQcKqA8//3OWdbdTrTNQyQ
	VHtXJjDYPW7RO+L95a+vGfMWBSltsmobkn9sEoTvB93OQmxiRx76Ph/c/FpU8OLU
	x4a0CgpVDMrGHcpjEnYsrDWxWYG2/FoliGgEUEwvyNMSsmEX105UbbcphoA8UxOE
	cuoimkgiW9z5+SS6WbXTNMBDfpBOu3iUebpoSjNuLmUYLIb3mv1Z6mMxc9MTp81c
	dU7cH+L61ma5alvypWVwRibmh8S+rEUvX5vGWEs1WismvPJpcDCZPvcapgWczq5i
	96DZddLTXzO8QK0Fop8t353UkAcljRH08HS4pVst+noV19MA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kanx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:56:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-342217d8d53so535733eec.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790330199; x=1790934999; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0QNRZM/+ly43XM1TDOLVOUBQNvVjmzMTjRLEM43AcCo=;
        b=CrPQBFLOLTokz3qMglUlfgyWgMYHIqFMXUaVGCsWZhPaWoyAvRIM3ysuc8HwfuN3f6
         SdYV1ZcUR4axkm89EUcJtQnzCjXJimTVrWKVnNvxuiGIiLLj6sI3h3qa0TnZG+AXR3xT
         hX9D8shq+8C6oIF66tDkIkVwTssT15tCqRR0MLFORety4sNaSSU/mVDh+lgkQbV0pBJw
         d61Tkk2ujoujPQsq94A0RZFl2h5O+T1621wcSens7lGa89pk8QogeRKgirYOSNMuFCYK
         nAWIdRKSM1cslu7HuukCnxQPuRS9tn+tneUcbfLPQMU7C3qisqhTDZLGH/l3RUv8m2N4
         KSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790330199; x=1790934999;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0QNRZM/+ly43XM1TDOLVOUBQNvVjmzMTjRLEM43AcCo=;
        b=WPz+Za6ITf4ApjfCb5rdJHvvss7DzQYW/3wX/qwn1wOB3/Qlvvxc18uUC3d99x0oqE
         FAjoR4Q2Cmfs4ceNfv28VE5hMPkAneYtR83pI2D3k2UxdnmqA1urQRGuzhA7ctJjwq6N
         xOpVMSQrrxkqGuNmLinTuDxXmSD2dvHdzVJoOCBsd5oFrH13KLD7QPcPmZ3rrwczl5CV
         ZAcySLLFP32UCToTy5/S20tzOiaFgZvDtAvYh1j6eowwdjPUPhLAIBf0INPLpXyHKK+e
         ocp1zf1kC53xMnrJIJFxYdJn3AWZdOYhZWl/m4M/1vWbzUf8nhKuFm0RyLumu4VyqjFE
         cEMw==
X-Forwarded-Encrypted: i=1; AKwUvBxUMFqHX/OMed0Uoo4kZtWGWhAI9RJX/nAzYyV2EOywcdk67UhBSQUcajCZwVgegWOEtFCKdvM=@vger.kernel.org
X-Gm-Message-State: AFuF++mAjCmK0JYgFQTWAqqYeYCVGITLH7JRs+rLq/iitnieejR5t32O
	XZ4b7FeTKlt1TWM9Ac3TDm3G8oqH0JTHDHfY973Xs6GVqcB1VlYp6SMJqaDKD57bK9etcnYmS1V
	C1NF18IMkQPeKNWcCi1zXgC6behyLZtsL+Al3XbQnRJkRU7SikUHCdBi/acqn8nbAkhg=
X-Gm-Gg: AYBFou1C1FNmLgUBJYruq+vGxo8qyjkysxjGsNvcvu3+sw2t1bmRYmtfqULhtHGAzDa
	hfjSGEOKZq+GA48uiWRrDNPRgjs4lpcvOvtLAclQrnE6jHssZ8vnsxUCSvlnoQNXPQYrPIi+g4U
	FhFagRe7i6NmWahcVstgAgOkGlFzAfKp3bOf/MZcy76b2OSAAUT7osCaVmVTYU22HhtUY9Z49FL
	WH+QJiNMaVICc4dwkfx5zL2TlEHaOLeEE1MpGV3CbowsGSuT7wzFDFWHOiTiLphj+aqI08lQl1j
	EEIM0trArFXwA/5GuTy20zoQH9eNOKeLjhW6bEYgV7BornX+QqSOgSHhR4KTen4IryNGkZAUDmU
	pRFA8j2OsdEuhFPoAIRZRiS4WuhCH1b2o
X-Received: by 2002:a05:7301:a23:b0:341:4466:1cd2 with SMTP id 5a478bee46e88-3414466298fmr2048377eec.20.1790330198699;
        Fri, 25 Sep 2026 02:56:38 -0700 (PDT)
X-Received: by 2002:a05:7301:a23:b0:341:4466:1cd2 with SMTP id 5a478bee46e88-3414466298fmr2048339eec.20.1790330198003;
        Fri, 25 Sep 2026 02:56:38 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757263sm5066698eec.12.2026.09.25.02.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:56:37 -0700 (PDT)
From: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:25:12 +0530
Subject: [PATCH] workqueue: Fix NULL current_pwq deref in flush dependency
 check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-wq_flush_dep_fix-v1-1-fc5a9de31828@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP9EtmoC/x2MWwqAIBAArxL7naCGRV0lQkq3XAgrpQdId0/6n
 IGZBBEDYYSuSBDwokibzyDKAowb/YKMbGaQXNa8lYrdh57XMzptcdczPUwIrFVj+CRsBTnbA2b
 9L/vhfT/7cwRMYgAAAA==
X-Change-ID: 20260925-wq_flush_dep_fix-11e657c0b1d3
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790330195; l=3214;
 i=pavan.kondeti@oss.qualcomm.com; s=20260311; h=from:subject:message-id;
 bh=U1ykP2v4vBanOjpsoDqzdLlC3dQbDgoQVd9oGf9UHZU=;
 b=U0WpEy6fvjOZfPyEF6q6Yv1pd63EZiIRoMxi7wcfv/jdBnBX0fb3EYyVTM00kNud62u2ijwUW
 Y5Yxqmi+kpVAZ9s1uzhWBoNEZBXgtZEKmjNIUAKKx1jrN5FVOjBTw7k
X-Developer-Key: i=pavan.kondeti@oss.qualcomm.com; a=ed25519;
 pk=Pdl9NnQpMlqbYaAGGkgBGpURTnZFe2de5LRZSGHkbHY=
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab64557 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GxlpXvE1fLWR5UxzRzIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: z_sov1pJMxyrQDeZ2yTW9ND1NZ5YPNXe
X-Proofpoint-ORIG-GUID: z_sov1pJMxyrQDeZ2yTW9ND1NZ5YPNXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXw+zHw1hzObgK
 fuGHl+dAnlh1vqq9G23qxkxjqqO8gWOosHcU/qvyU6EDE8lTEgRMmHT2seYhx/7cy1L/96yk99R
 FysTH0bAT5lcgizeWHC6ssH4Jb6PfSz/OOb/ykpcPormWCmwX/wK6adlWmmHTRZmLmINUXWUtHS
 5pP62ATfT3bHN8N67GArrKnZ4Axws0oBK+KP1n0g741icODGm3vNpMri6a8QX0TcTIC7T5LWUts
 74NnpJ9vQzeU1Yi6yh3qeYBAiVaI/bxtaALCw7bJyI6gmUCm81tHAhAdJacRhDESifiTyLNeGtx
 tBV5+kAKFDZ0rSQ15CdLbAmk3/VTPEzYN+33wW00w/tF48+Ym57MYUakpamWJYVsk4w52X2fOhg
 zi8Xz5sgRYVyX1DqFNK+4Kx0kxsjlyImIHyvaXDoBSfTDrC3lnQ0uRcJWSqCXeEJFweZQYyFbMH
 NF4PUAgSIz6sa/MJfRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX34Zn1FOvBHjJ
 SAfPXIs6h1aeXNtQ4j0h1vQlMR0LIvJW6hr061lFK/rOONQ7rBt/QS/fgN5Okuzxzd5qoh00BgS
 MKAzJC1A5pfUXjBBobxOYpZfyq2siRg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250039

check_flush_dependency() uses current_wq_worker() to determine whether
the caller is a workqueue worker and then dereferences worker->current_pwq
to test whether the current workqueue is WQ_MEM_RECLAIM.

current_wq_worker() only means that %current has PF_WQ_WORKER set. A
kworker can reach check_flush_dependency() while it is not executing a
work item. One such path is worker_thread() acting as the pool manager,
where create_worker() does GFP_KERNEL allocation and the allocation path
invokes the OOM notifier. In that state worker->current_pwq is NULL
because current_pwq is set only by process_one_work() and cleared again
after the work function returns.

[  416.760634][  T375] Call trace:
[  416.760638][  T375]  check_flush_dependency+0x80/0x120 (P)
[  416.760648][  T375]  __flush_work+0x98/0x224
[  416.760657][  T375]  flush_work+0x30/0x44
[  416.760665][  T375]  ...
[  416.760710][  T375]  blocking_notifier_call_chain+0x58/0xa0
[  416.760719][  T375]  out_of_memory+0xb4/0x458
[  416.760730][  T375]  __alloc_pages_may_oom+0x11c/0x1a8
[  416.760739][  T375]  __alloc_pages_slowpath+0x314/0x46c
[  416.760746][  T375]  __alloc_frozen_pages_noprof+0x110/0x1a4
[  416.760753][  T375]  new_slab+0x12c/0x484
[  416.760759][  T375]  ___slab_alloc+0x7a8/0xc7c
[  416.760765][  T375]  __slab_alloc+0x74/0xd8
[  416.760772][  T375]  __kmalloc_cache_node_noprof+0x2ac/0x304
[  416.760779][  T375]  alloc_worker+0x28/0x60
[  416.760785][  T375]  create_worker+0x4c/0x20c
[  416.760790][  T375]  worker_thread+0xe8/0x2b8
[  416.760796][  T375]  kthread+0x1a8/0x200
[  416.760805][  T375]  ret_from_fork+0x10/0x20

Guard the WQ_MEM_RECLAIM-worker warning with worker->current_pwq. If the
kworker is not currently executing a work item, there is no current
workqueue to diagnose with that warning. The PF_MEMALLOC warning is left
unchanged so explicit reclaim context flushing a !WQ_MEM_RECLAIM target
is still reported.

Fixes: fca839c00a12 ("workqueue: warn if memory reclaim tries to flush !WQ_MEM_RECLAIM workqueue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ae3732a2c51..959525393739 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3918,7 +3918,7 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 	WARN_ONCE(current->flags & PF_MEMALLOC,
 		  "workqueue: PF_MEMALLOC task %d(%s) is flushing !WQ_MEM_RECLAIM %s:%ps",
 		  current->pid, current->comm, target_wq->name, target_func);
-	WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
+	WARN_ONCE(worker && worker->current_pwq && ((worker->current_pwq->wq->flags &
 			      (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM),
 		  "workqueue: WQ_MEM_RECLAIM %s:%ps is flushing !WQ_MEM_RECLAIM %s:%ps",
 		  worker->current_pwq->wq->name, worker->current_func,

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260925-wq_flush_dep_fix-11e657c0b1d3

Best regards,
-- 
Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>

