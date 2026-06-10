Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E794379C48
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075674; cv=none; b=LMpcbZ7dL55JBCxYdKO/eosFqLeWhQ2m1UuD2pJ9AJ8uQ5aJewTRiu+gg2/qIGLh+b0FiK2BAL9Ks0yvwO4WU0Rdi+0BGNItjUBQJLkUthHeDqBnScYdMc75W7Kwok7dPmhK8zHUvQ0hTmRMasTIPKGI0kOuTs0jG17GdimXJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075674; c=relaxed/simple;
	bh=46eYrWMMOwque0hGIWlgjDSe6yByv2jADvlK9lMcif4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeYybT3qmtaO6L8V1/aOykH1c6+qhYq+iLIxDpNgJeej//k5nfv2sMK82BEMIGOmdS4EFmeLNSZ27TE5/ZJxJe2RuGrPmdAQzgSol9aXhrIbDrAYC9QXAB8ymXMoXXGgwUtDxXZMUY9wIcfIavRnorvaJ3aOBAk6usfb7SdAKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk7emvOM; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk7emvOM"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43d2ff651f2so5185690fac.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075672; x=1781680472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GS3IvbRaVRHuQ7jWVUtX/UMvAifgWuNPLIfjnTq2Txo=;
        b=Vk7emvOMxDR7nl2FpWOz0jzA/aia3fTFl0GVrxqSHS7ixtTl9yw7uiIlIAK9uMa/y9
         vx5sPw2eE8hoQyyDhRLojCkrt3WOOHjhMDYIXHjEc/6CuQ7njGiXxS3Faxwp7nvfXwrX
         1zUkcyIgRKg8z0Khfz+GxQhubDAjWj2uoVA5SkvJWkQhi1lRT4Cj5TtMC2uOrREBb1CG
         8SjHg0df50nIfwaqhQdxh8NPcLZvN07dHFbhIhNT/RmLAPLJDmENQTQSKmYsHg6hwevI
         rs+kBLSJfvWx0T3mpMZQOIduFjL6Zi/X7t/6HZdMbSSTW/4YZbNxnUw6gC6oqehz1RnL
         V3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075672; x=1781680472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS3IvbRaVRHuQ7jWVUtX/UMvAifgWuNPLIfjnTq2Txo=;
        b=CNVx6zSAkJKKWqLHU+8aeS+CL8wXwfxpbMfqHV3cX993G68pRPV9pXG7+gRoAWkBIi
         Sd4hYb7ZkjkjqjxYJjJVHcyE7V8ILzg0EtSObk/cbLlFtpQsf8SQ9k2XXLsjKEesCmHp
         2tmrPITDwTXUg57baTKeO0G32uUwNVMCKstRN4XeGShw1OuNwSqi504OvtSWHtxVMQdS
         lP1newj2zhgsqrtYPwWrQVxTw1SCxogtRiUDPhN8BgE11Q2vZYZQlIDtpopuj93HWhKt
         xqPv7YzQ/ucu5HVLIK5/K7S1m3lhhRD6MZb9xtSf0I86BebT1wmCVEX6Xea6juoVWq/X
         9b8A==
X-Forwarded-Encrypted: i=1; AFNElJ/t11cUPNtDkEeWrFSuKY31Vv5y+WpKDJ32avyE3tVnbe+5RhjtOiQcLxqXOjM6pQj4B9vg0Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdZmwPVQrUZ+jiTj44iL43DkY7VYc1eo1EmaN9thNCjpmU2h1
	Tx9ugg9uS+VdLJFG7TRIr3TRzq+emsgvpLtnVpWlL8nhgX3ylm1pEaBT
X-Gm-Gg: Acq92OFo448aN2z2wkEbnlEs031cFakpNIiT1Z64uEKeXz3CZibjbT4rLQI4WefFEsH
	pqe+mvjKzWW6SBJDeie6c5wt3fX4vV35vH/hGDl/xUIIqoS6Hj0wiUv6Y1DqvNLFPDm353wvULh
	l+WWEA4UqOFF4PKi9yXshHMpKZmvJ21ryUYs7s+LhcswQtCKLEnSXyCVE7z5eA3vblP6UjT15/o
	9kXv94fwf2IhuahhcFfTvEVS9pI1wS8kJLPRk/c5DdZYmBs+wFmqvj2N2Ydi2mSFle4hemFaIEh
	Gj3vU/krYmlHmcO6Xlpnutm3zM8moO+uGYmEm3f82BFksUbpkWUxbAbux6XZt1UPAnpGLXClvK9
	JGyss0Lr4Y0FKe/AOZd5CKLooJCOAUS3S34jl95lOor3ZWdzk4LrfbHMXRk90KnB3CQSv6UxtiI
	vSYHy60OtCCJOd68/ngzxDBIblTK1fxIEFu9Ugf7QWF46+bIRkmCmLaechrA==
X-Received: by 2002:a05:6870:489:b0:43b:7f1e:6d20 with SMTP id 586e51a60fabf-4413d242f73mr13745935fac.7.1781075672474;
        Wed, 10 Jun 2026 00:14:32 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7b79ad4sm20408841fac.4.2026.06.10.00.14.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 00:14:31 -0700 (PDT)
From: "=?UTF-8?q?=E9=93=AD=E5=AE=A3?=" <omeux327@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E9=93=AD=E5=AE=A3?= <yangmingxuan.ymx@antgroup.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: security@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	stable@vger.kernel.org,
	eilaimemedsnaimel@gmail.com,
	Mingxuan <omeux327@gmail.com>
Subject: [PATCH] bpf: Reject programs where arena and non-arena paths converge on ALU insn
Date: Wed, 10 Jun 2026 15:14:09 +0800
Message-ID: <20260610071409.43721-1-yangmingxuan.ymx@antgroup.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingxuan <omeux327@gmail.com>

The needs_zext flag is per-instruction but set per-path. When a single
ALU64 instruction is reachable via both a PTR_TO_ARENA path and a
SCALAR path, the arena path sets needs_zext=true which causes
opt_subreg_zext_lo32() to convert the instruction to ALU32 for all
paths. This creates a verifier-runtime semantic mismatch on the scalar
path: the verifier tracked ALU64 semantics while runtime executes ALU32.

This mismatch enables an attacker to create a controlled 4GB
out-of-bounds write primitive, leading to kernel panic or local
privilege escalation with only CAP_BPF.

Fix by rejecting programs where arena and non-arena paths converge on
the same ALU instruction, which would create conflicting needs_zext
requirements.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Cc: stable@vger.kernel.org
Reported-by: Mingxuan <omeux327@gmail.com>
Reported-by: HanQuan <eilaimemedsnaimel@gmail.com>
Signed-off-by: Mingxuan <omeux327@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..9d7218340683 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15083,6 +15083,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
 		struct bpf_insn_aux_data *aux = cur_aux(env);
 
+		if (aux->seen && !aux->needs_zext) {
+			verbose(env, "BPF_ALU64 with arena and non-arena paths converge; needs_zext conflict\n");
+			return -EACCES;
+		}
+
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
@@ -15099,6 +15104,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	if (cur_aux(env)->needs_zext) {
+		verbose(env, "non-arena ALU path conflicts with prior arena needs_zext\n");
+		return -EACCES;
+	}
+
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
 
-- 
2.50.1 (Apple Git-155)

