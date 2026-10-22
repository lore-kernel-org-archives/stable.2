Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660175;
	b=wVgGm9qNjNVPizn8pTFSP25PRMrz94Bcxkc0gBeiBz+RYlB7AzY4teZi+ytNsJ/xG48W
	 okI6NH3Xz2lM5u6hVFDE7GueilIT71zmKbPwTBfP5teS8CX0q/WkfFERnX0wrJyfkCTtf
	 BCcqkZrnWLmVyR0Ntnel3ZSGGhTk31uPbm/v8YrFacY7wcBH3EwY6lm8tjy1Qd8GKBoPE
	 aPvCsOWqZZ7O4MXFA/8JdemiyKz6Rt74Bu/+M+TztJPZ3QIgBi6zPFW8G1D8F/PILnywT
	 cw52p1JABBne+AKi/k10CsiudIyhBB5xI8Tita40jj6vQz2oPqcPsDWx9LPYOSXepYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=;
	b=sps8l+opmVepW8Ph5rvG1PrxcZj+fzIECNqDB8PNj6e8dRHrUQFpbvg1ukeZzM40T+hl
	 3D9q25U0yNw5v6Czg/CPUCSbBq5Hw5gBKj9MGh1e4BBi4+ZSdnhSYjdi7fll8KJ/+wbIA
	 kBR8f8TPiNC/nW5frNt9ttBeadhJ0+Az3Zp3NMbCwdoQiTVf2sgS70OEHXBEiI6MM0nyN
	 gCkkFHBfxGWyU8hS3VBe2djAP7N3o/5234IsAZQiRapqdZ2XbfJLOaKX8Zzh764KuNfCk
	 JfiVElcVxtZfX5COPCq1fjHd3fayaqQnZUNBkjOuI+ROwzzcGrnE17S6DA9nADRx8Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=awUZGDvU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ea24wtUy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F215606A336
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F215606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=awUZGDvU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ea24wtUy
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M761Hx3039000
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=; b=awUZGDvUo381zakE
	6IlU2NFPZS8CF4z1toImlJP1v4c1Us3D8S8tMGlDHsaLjViCgF5tKaRlScW2sGNR
	nzmedS4PMfnjR80vijvCqrG+GaG9VAtgMPp61NXNNJ+RGPWnoUrwzavCYwRD9Fqi
	Xu94BxbDRb0fejtCJuA7qXSkwI800z1MI2kh4i77allNd8iPzTyOwc1uN4mPJvyG
	HyzsOwQKdSGYfdPjTtbmSVQJ9M5NPr42HxJ+UdPWqwgtVfKifdlqH+nVZWQnYBBJ
	eGs2OR9c60sSgnLWeeuN0rZli8aJruEX5nBv+Y6TGTDLvc39pLaVUWJWwRKTO1A6
	EIc1wA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93asjj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so1812675c88.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792660173; x=1793264973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=;
        b=Ea24wtUyaW/1mp5kCSKxinV7weiADb7vlc+rbTVs4Rr6MVQ0Ktx7fQOHqsL4vjeYLI
         ReKEHJ3LB9QnoXMjsiIJlhjxwkDxYHwlJfZwe7ZkbSJqKckXJS26Lug9qJ4EuoE2+5XW
         oZqsGwWsFJb9/ixpUl5dHVTkLAfM3hjjA44K3fDZMnjjcJeAcCJLAqqIPgei0WwpIKfR
         f/lk+QftV703uCBVWBgIp1FExn91gyvvvKd0M9SjAMb6Tq9LVgSbmIq6YL9P7vLEI8T1
         FKTVyCZBstxtJlM0Ecc+YUnNzjqWwtigzAZnXB5MG5rFA0EUfewhvAtxAaGpHVwDhtQJ
         Ci6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660173; x=1793264973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1otG1lzuT2TL603n+ZyA3mzLoyhPcar5mVP11oCq/4=;
        b=XkCElELqz+1WneUYVLHb5bG99vW7owYGHWFaN/eoXh3Z7B8A8O+hS3ekWGcHZtpND4
         c+v4vcjNBu8hjxMMsgj3NCr3DP3gRaeVafdkH98sUjPzDxptpcSYo+FQUBeUoT1w3oTj
         I5k9axP1wVr0UqSSjgaRXK1KAkTltDajg8oU3ZEuGQFe814QDirDtpuhJcSv5+Gtnyjf
         4wjh3aVxd/m9wwOaRkBXvIZGCE92yXacb/R3AjUGnTuDDI5uKOw6HMgSa3pCGdxKWrpZ
         FN1ls0rl17nG1neLlTwTseuO8EI9BWk5ZX3/EAP5UY/SC7rPybpETfPGU/ekDGGfNheH
         mDCA==
X-Forwarded-Encrypted: i=1; AKwUvBycxXw+p1hJxLhkAsFVT2R68sg2YAjrfkId+yvnW+RpzIb+XOW4MZT26097bhqo/Feuc5TqrUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXwW5EkgeQc5JOYDLhNmbsaCmk1qbxTHkIMLseBQeNEv2l21cz
	S9ICEKwlIBJfySStpoQeZTVGCVe6OkYNSN3Gp0R2tGkhhtEdO3G+e2FyGk/gSAjCr+hyeVFClOJ
	qq2KXAiMYjQN+nbgS8MrCFwn1oelRhSkw0Xi8z8pPAiiLtUsw2D/6A5Q4CJ0=
X-Gm-Gg: AYBFou1gVjBPnj8IRJxU8iYugcxKHTSFRntB5rXz1HH3f2NC48EunTO+u4+jO9tExz4
	9TaPIXAPPATUS0Al4mzTMsq1HSfmbScG5B/OWKRHtCUKlNl2Zprm44k24mIqi6YmX4F7HR1R8ZB
	XYPGgG1Ukyauz+qWoTiZg6bK91o6M+byIdCx8PVj2xCCA5zNk8MaVHsFrHdedR59XPByjFzAuvh
	EKNdhwea5F9hqyr6bTjbW19TjFowuRNr/muhMSD2FMHPvLLF3A6jcm/k+sJsjAQYIgPjbKJT9Ow
	F11XcY3yXYxtjroYfCIg+FiTcmwPCtLequPftROc19sNPfuL6V82XEPDFHCpGuULded8Df03KbJ
	WIv6wp10DaX7mClKhAqNKYYLr2kLHlGcu
X-Received: by 2002:a05:7022:3f09:b0:18b:bce0:a227 with SMTP id a92af1059eb24-190a6adcd36mr6565164c88.15.1792660173247;
        Thu, 22 Oct 2026 02:09:33 -0700 (PDT)
X-Received: by 2002:a05:7022:3f09:b0:18b:bce0:a227 with SMTP id a92af1059eb24-190a6adcd36mr6565116c88.15.1792660172672;
        Thu, 22 Oct 2026 02:09:32 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm20475694c88.4.2026.10.22.02.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:09:32 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:38:47 +0530
Subject: [PATCH v2 1/2] misc: fastrpc: fix NULL rpdev dereference when
 session alloc fails
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-fastrpc-probe-fixes-v2-1-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660163; l=2456;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=gXjATeM4mZmReR8r0Cip4k+l0pcgcK7OC7jL7Usz15g=;
 b=8iJBr+ATdJCU8iVTzYlUb94TGIBcH2KOuljI0XoPmBRr5XGtpiQDEOswWN590/Yv2vamfMEy3
 TbUqejlm+2lDL+f2YkKmWMu7HVv5HlkgMxM3BKl9mdpWAdKCNExxSM6
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX5axKilxeYr5/
 H6+5iHjGxEA0aS7q7rhuPeL/HYV0/Bu3giam454Mt54Kdw4BT0p0s+YiPT9zGgNoZR7YFgF+Fen
 hlc37bCjHW1nAsxR8fEnZ4rSi81dnUzzduLn8uxW3CnzocHUGhGl1/DDTNfidQrhkMQet1ming5
 PYbfJ06RGWHpIhY+hhR0PUEtYm6qe0Xb2QUvbRY530R9tmhX5uWOFUGp56tNb+crmWlOKghsheB
 s05Fq3jNI2Ya/l8txsomYVdgrCgLQSDJVFGhgbuJva/hJ/beOtMgtOlpE1E4qwMNZeRwAe6YtAe
 tgixNHCr8RdJWhYkyUky7JiUoMHOkUECUL3b3QG7oVfj9jrgZ188+T/kIR8vd6sh76AxtkE2n+I
 daKiX76aO0mghS5NFH7iwUUr952J64BRIjKo5V5mK6MOxD5doVnu8EkEbYfbAT9Wz33AyrRFVOD
 02E6VsltqAor2b3unLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX4T9ubsz0J3hz
 JDY6pNGpto527U84FzFr8uNxHdleNRa5aA/s2KMldAfZadwYbwbb7/Nrt03jtieD3kPOjI8He/c
 2Q0vfPEfkdML0OU64RL32IJMp0W2XpU=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9d2ce cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HPkHAgnwbDoOiCnvmVMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: VjI3FJlUpf2jyZtpWJPYDwUXR-Nq34iA
X-Proofpoint-ORIG-GUID: VjI3FJlUpf2jyZtpWJPYDwUXR-Nq34iA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220036

When a fastrpc client process dies abnormally without closing its file
descriptor, fastrpc_device_release() is never called and the compute-cb
session slot is never freed. The abnormal client death on the DSP side
triggers a glink channel teardown which propagates up through the rpmsg
bus and calls fastrpc_rpmsg_remove().

fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
misc_deregister(). If a concurrent open() enters fastrpc_device_open()
in this window and fastrpc_session_alloc() returns NULL (sessions
exhausted by the leaked slot), the error path dereferences
cctx->rpdev->dev causing a NULL pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
  Call trace:
   fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
   misc_open+0xd8/0x1a0

Fix by moving misc_deregister() before rpdev = NULL. misc_open() and
misc_deregister() both take misc_mtx, so misc_deregister() will either
block until fastrpc_device_open() completes or prevent new opens from
entering it entirely.

Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is available")
Cc: stable@vger.kernel.org
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5dd1990d3e2a..f280bff2edf0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2697,6 +2697,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
@@ -2704,12 +2710,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (cctx->fdevice)
-		misc_deregister(&cctx->fdevice->miscdev);
-
-	if (cctx->secure_fdevice)
-		misc_deregister(&cctx->secure_fdevice->miscdev);
-
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 

-- 
2.34.1

