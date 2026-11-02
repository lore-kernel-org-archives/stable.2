Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614882;
	b=3aABzbk/J+TsfROv+YVydbFoH058q9+5bvb9NmZsfbJJz5LZZwfhWAEhR+WJPNgruMZ4
	 sbAokiZlgtwyOuORpIzxtprSKme9z0E4X8LuqgVNqDjzZSdGbwgQz6SNJV4c7t9qSItYM
	 Flnqa7QncgtYaED0sGBGPrdCP2HBGdJj5sTUA/KY9cNYzuPFE1qlDH8/XJ86B8zKVEXCp
	 hKBCZoYYnbBNzbqGdHC/Jqex+14eSevk0+4OdzMoUH97hzWsp75Zb48xSaQfOwoWSGqCD
	 woHLH8HAPWONZe/OKlD0eSsrn+sTpLuOjeEYQ9QQuCiBejXCnjP+5/jfTpu1YxY2qlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614882;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc;
	bh=pqviG7P71rw41SMpgpSC30sqR+CIrm3KdlZ1XI6MjVs=;
	b=2dC9tLbFIswZM2Dw646ohEZHaGiKrHYECDc+jReF9B0MP8YnRFGU97/j7L3q/Y7kxK1e
	 J4iKr8l02MUDqCM0bit1KckDyoWmmv0D+pwSDYwx8myxSreXuxqJLLbPhbEyYo5yz6Wk3
	 +x2FXbXP+sX/5uhRBH+3tFJqug0EncJE/HXmSqIGDG+0cdo0SH7JKJoYv0B+FfyXZnZVS
	 BaCap7n7Nk9894oelWYcnt+ruBNCcV6YamIJWbmpl8kf0Mu6WARmmmGkHfgfok9mU3304
	 gmfp4WLhm3QHFg4rMlqCpbPHl/qyYske1+tDLeSMuDYk6CzDyk5pYxKusaUVxu+7Y7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="rEF/IywT";
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C0606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B7C0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=rEF/IywT
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A22glhA1086465;
	Mon, 2 Nov 2026 10:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=pqviG
	7P71rw41SMpgpSC30sqR+CIrm3KdlZ1XI6MjVs=; b=rEF/IywT4sVKQzM7afUA9
	QQUgH0aGe0oQfjo6Lk+5fze2PeiPltF9iEDgyulmjUQJh6hquzN+r9GByxBTAZtf
	79b/mnUwiBIdOHh15OtUJsA7t+CBkblmYN4OF5fFyBGFZPN0Tr6zCTwHsJnCcC4N
	sQGI2QdpDR66agM55KkdszRJyYJFCc1+rN9AIv01p4kdCBYEaX1Rfq/i9YRvRGPG
	Jff5Sv2nN8UYxGKyxHYyfQ3F4amsM+0clHA0JR2W7c4iVL7exD4qyTykdfPSmyOY
	x/ryIwBq+rNV/1K9g/l0/t1JXK8V5hPE+8a9/xebacgoxpakDLpyIRdADcJ5tgeo
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn7431kxe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D2oD1424341;
	Mon, 2 Nov 2026 10:21:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-6;
	Mon, 02 Nov 2026 10:21:17 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Minh Nguyen <minhnguyen.080505@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Siddhi Katage <siddhi.katage@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 5/9] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state
Date: Mon,  2 Nov 2026 02:21:00 -0800
Message-ID: <20261102102104.1558500-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=901 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Authority-Analysis: v=2.4 cv=OpXaWC/t c=1 sm=1 tr=0 ts=6ae8641e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=FwJbE6n6EM51GTaFqHgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-GUID: U90GawLEwFjOY56ujXGOghzK5qdwnZ6v
X-Proofpoint-ORIG-GUID: U90GawLEwFjOY56ujXGOghzK5qdwnZ6v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX8ItNzrXKGCFM
 Leib/HN4kj/DAvhnRatVORqj56oAsBmioqOk+nk1ehUwu+j7AkpN2GHG/H/X5Q1ASkmIu7ZU478
 IIjjw8I7za5n1ayrYok2K7Pcq/l4YDkisgY5xq39XYEbE1LCZMbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX/CwZxCUbkQki
 GynvaIu1T9KZnRK80is4lMgcW9jgYTb7My3EfCFZ9uv0XDvduSIkxkdR/OAtMNJc1y7/bggOcrt
 mbG4YvilXpTd40SfTMvrDfh2Urx2eG5Z7aT3aRGbt3eWpOtaKH4z/6ERgd2EawBi7P8Crkpm7ZQ
 7C84SSetEv6n+iJWORYKLTCkYKWdGHQcuzeZTOtFk+u1GMJo3057JSdjw6M19hdiGp9wlcYh8pc
 nI5YuYYMNhFwEuajDBdfhLqSHzs7rBYNAzSOiDz8MJd8somAUV7NFwiNZc+GyYaldPwp4JQcZhC
 mjToNxewBk014bMoN6k6Ylg82Emc9rn2bvTJ8aByAIpH3oepLiiaQVwbNCMCwRBtW56exAQgKNg
 fqfQ8MC3dcqI7ycRMiiTF3qCyYYEn78O7FbFlOHVluSVmCnxNLD0qRgtu+Jz8YHIWaZb/tgiGue
 eFvmQjlShyMNKAStIbi7/3ViUDDQkFDBak/GvoCo=

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2f2312c422fd2695da772cecb30c69994b795964 ]

Put all vmcs12 pages if KVM synthesizes a nested VM-Exit due to invalid
guest while emulating VMLAUNCH or VMRESUME.  The invalid guest state path
doesn't use nested_vmx_vmexit() as that API is intended to be used if and
only if L2 is active, and the open coded equivalent neglects to put the
vmcs12 pages.  Failure to put the vmcs12 pages leaks any pinned pages
(and/or mappings) if L1 retries VMLAUNCH/VMRESUME.

Note, the !from_vmenter scenario doesn't suffer the same problem, as
vmx_get_nested_state_pages() only gets/pins/maps the vmcs12 pages if L2 is
active, i.e. if a "full" VM-Exit is guaranteed before KVM will retry
getting vmcs12 pages.

Fixes: 96c66e87deee ("KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page")
Fixes: 3278e0492554 ("KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table")
Fixes: fe1911aa443e ("KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2f2312c422fd2695da772cecb30c69994b795964)
[Siddhi: use 5.10 vmcs12 page release operations; helper is absent]
Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 118aa1fb8fce..7c861d34f9c5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3514,6 +3514,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		return NVMX_VMENTRY_VMEXIT;
 	}
 
+	if (vmx->nested.apic_access_page) {
+		kvm_release_page_clean(vmx->nested.apic_access_page);
+		vmx->nested.apic_access_page = NULL;
+	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
+	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
+	vmx->nested.pi_desc = NULL;
+
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
-- 
2.55.0

