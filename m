Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C7331EDA
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075405; cv=none; b=mB1iIZZRVaSflY5rvWg4OUS5efrn3qBtdaAp5cMZrGCsxLL84kWXqlwNIHWnInM5ssrM/jJ1qaHHqKlPpirnFuiZL7x3DMINpkVXxbB7mkSzOSR64rkQ3SsB7MrNrsutaWzNTZ8Js6iva1nP451iQF+YLv7/MP3vRepwsmBO9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075405; c=relaxed/simple;
	bh=46eYrWMMOwque0hGIWlgjDSe6yByv2jADvlK9lMcif4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7seOKxs/dVZXDSvWDpM8DUf5R2x3+SK2Xk1GqU2VM4F8Jjon+pnVtKqiV1v3B8IvpEdr5zWPlHEW/HTnyWwkXUlD0ODhNQAwQgs3IoCj7YkbdJo7tJcXCkOQbQYQ5mW2AiGVuy2OOo5ty4RPedcazlzAFQLzbKd0ckKvzXJH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3yzACNQ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3yzACNQ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6fe199b81so2263297a34.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075403; x=1781680203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GS3IvbRaVRHuQ7jWVUtX/UMvAifgWuNPLIfjnTq2Txo=;
        b=j3yzACNQ3Nr2fHBfdHzsaq3WlgXk+09MzwesdZ4DbtyFSyRoHNNOu/W5lcXj1qvtF6
         dApklx0dZarGhd4XuU/p/rfy51Ti99MrmDt5VjapO5c3MXnV9mh6c5zgPqcbSNBm4XCZ
         9am03fJPi/VMUG6wZMDS6C7A/ybxxNKk8zBfm49BuNk/oenGz7f/cSao7S2FaIwgiik2
         Qt7/qmP/NTa/aOiGxPBcSNobB2+2ZvWBKr1HY6P3Qfi1+MHkkJgAcwrWeULqReZZTNlM
         KlpsZZ/K8qnh0PZBQNJ+fklabPiVSJYVrkuWDRYzClNyqU3IhZUjttbmMkqFa3dML3vW
         kZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075403; x=1781680203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS3IvbRaVRHuQ7jWVUtX/UMvAifgWuNPLIfjnTq2Txo=;
        b=rRD8gJsO6f3nvBomB8Pwfy8kNR1/P+JeqihoLD0OiOFVFUhvfVLAWRxKC4TpDCwuvt
         PLsn+EPdouZEFwL3Dn/mCAwA1pifwfndfuEWbR3BhZr0K/CDbnlHiYdGN/kmd13sz06l
         Icz07a9tw9e5MK+kJBE4rNw3Cx8EJeinKUBj32ujR845RxHMKvKlcJh+feEr/Yg9r3ZA
         vcFAEZM3M7Upjl28hQF9BrNsSlBDjLl5iloHkojRaR/S30DwYVWkk2ixD6c7SZGj/AAu
         pBzr/60WqS7GO01Jt8d0NVU2LQzIjEFnHvXftos5wkEmvR7d/PBjNPvz47ofY19tmNpU
         476A==
X-Gm-Message-State: AOJu0YygSW24g7S59pQhBHE9IYaf6+gXSytWHDzgT/ZodH2A4nMMWmx3
	rRDLgMK60m58gxeyLhw/sf3oFNNF8i3RCU2ImElyR9VR+JSuqjAAY7dbNTHJ7ghHn/lvJA==
X-Gm-Gg: Acq92OHMN0gqOM/Ag5Z7BLdnNaS7OK/TtY4cC4WrKVhcQOSFn/Ov8fUhkhl7Lq4AkXY
	gw94Ha5LY8dHFaDLqrZQxmMkuIQMAtbfNL/fDGzijlSrE0qFNf8yvoTRwEi44wk1NG4/KgRpQjl
	QKmHRRyw0g1Q4cTm2+rxBddDeU+renmH/4F/Yoa+MJdeayyHSLkhccYY5ITzmXY//Yb+AHmKUxA
	zINobG4SpIz00SdpMMXbU6x2c1gce8UdV6agXYawtL2LdD1gkBEOEM1P4exk4aNLS3VEIGoXfvN
	YqvIYOIIF39g3kAuq1b0qXFKEM8ivgkut85HG22BlNRH9BDRobBgbriKbs3rsBW3giZ2BTkSbUB
	tLRleSj6zHtn+k8lxx+7wN5rRK+26EdSIioVoJ2UvLdDKJ/i7W2XXnem3V6WUP0lbNvS79F19qk
	4WuiBA98V6PIKrZ0NZxtJhjDvexuF/bSb1NzNy1PhgnWC/GtfgJwgJvlGVdA==
X-Received: by 2002:a05:6830:2b0b:b0:7dc:d7e8:cb37 with SMTP id 46e09a7af769-7e70ca635fdmr14003665a34.21.1781075403469;
        Wed, 10 Jun 2026 00:10:03 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e79821edsm15939572a34.27.2026.06.10.00.10.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 00:10:02 -0700 (PDT)
From: "=?UTF-8?q?=E9=93=AD=E5=AE=A3?=" <omeux327@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E9=93=AD=E5=AE=A3?= <yangmingxuan.ymx@antgroup.com>
To: omeux327@gmail.com
Cc: stable@vger.kernel.org,
	HanQuan <eilaimemedsnaimel@gmail.com>
Subject: [PATCH] bpf: Reject programs where arena and non-arena paths converge on ALU insn
Date: Wed, 10 Jun 2026 15:09:52 +0800
Message-ID: <20260610070952.43103-1-yangmingxuan.ymx@antgroup.com>
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

