Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92714BF92
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140162; cv=none; b=fMj70J4HIInWpIActqy7gBu1Z23ZhYJZqdiIKaut7I9K8R9sSETJUC1eIgfGVtrOY4EEgwPQXoKhDUKSM/HORM0/fytaQH33D5YPCfyDYStxjtXe9PUFWEok9xVU7aN+45Jb1X/leYj4KByqrngbSlXrAR9Kc+HlfUI865cqX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140162; c=relaxed/simple;
	bh=6KNTz/ZwbwhW/tHYlmAtIJz5wzkhbvWdHahK176PG/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXSP5cuAOtkbZWzijDaIQGStWRAdoOpb6UowO9FdAiqyDZmkD0inmYG96cJbMrAj0PwZRumDW+UDFA/7ZFGGxIet4t50bSOX3WRyFjTDA3FS0ggdyuTjxdUUQDG0AMTMF+EnqRbC+Ifa6XDQYg3nFsvGg7+xKma70uR9mJTWRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sL8bjxAm; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL8bjxAm"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-138405b7bc5so1234251c88.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781140160; x=1781744960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVFUmgfZWQUg8yb+neHfsaKcJQcz+e1b1jXoBTh5r50=;
        b=sL8bjxAm/CVo1j5SpH7Fdn79hVi9GWASd2Db0FaqT0Ed7ZQsATMMgsSuUR8zBL+kVJ
         eQ4YLYBL5bsTybJPG56unJ8wzH6v/Wb1xc71EtsoxNaTWs+njPfToYDtdLNIeEdXUxns
         99xflWI8/wWrr/ozw+2EX8zYvU9bydUOsPTCL1G3ncpV+UmPFy9ro+SVwrlXVZUwZI3o
         UJc6+/1bFQkkT+ICnP/ru80KD4FTS68WgerdwpipAN/P/piUoYkACAyJG2R0mM2BBunt
         wJEnPfBm+ac0ZV+YrsBQIstkn6j8M6efKhnmVHvTy+XULO2AjIX6YGRtrnolJjEh7xio
         ZXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781140160; x=1781744960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVFUmgfZWQUg8yb+neHfsaKcJQcz+e1b1jXoBTh5r50=;
        b=LWtfe5dyhqTzgDKF9bJVZU4QkknpXOF+XugjoLPV4qjxah5JCPRTrJ5nsM227oBDBY
         x/7VfZdgqZ//YZCjVQet/yP6aOqvLMBqAGbVML1A4u/ySTucjhBvxO0MiIX01XSCYJka
         QDHUvlTVxzkNiNoSh4PVFRCtnsfRy+WGCZe3xrILfEw5a9FAiqcSasMoo6kD/hrKNyFw
         e/mT/8GAm5WsXh3zY5VS9ZWiIXXjsmsvJTPxIqrxLnpEgOnqBTCJGA0nYFzXv/wnKKsY
         mOAf0LN11al0opGxkB3CGqe2yuEU7xf5IFIwjUV8KBglyXHcvrF5uNqmEHh0O+6gGuKk
         VyAg==
X-Forwarded-Encrypted: i=1; AFNElJ+9yZ1c6BeIS+p1oseFzPyJvqNPirXc4NF0eEUhMgePh9Gn5gqT0CTLxtzY2vtCMh8e5jrE4ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNv+1hSMi5LbKkzhNl+3lOMebJPHEbsZxhPPCYZwxbXzQ3sZTf
	2rtHvSZRVknnsuhv1i+PTQQPG3gNReuSujEC5HFl3xsyTEHpZsfC7iPj
X-Gm-Gg: Acq92OEprjGtalPJh/RK1QViNsikfH/0/dKohLIKB3iRJ3nFLvpfzP/CQuThyaYurWJ
	jJYLA8M2Q/n5rriw4XdTNYMZzUScNYL6dxsAvih5iI68r8QKESCqezZXBMvbMfSYO/kM4NtCmAv
	+tbpm8msfotqHSBXxrZWt0HxpMBMIhMAkVubOToa4YI3LxNbuGh10n21aFTpYrJcWi555fO/+KS
	cOqLfFeRShUP2FY3qwpRXLpuMYRdQ4dzwj5CCgqsl953mo80QFienoarWQitsHAfKOagMWwnIIC
	EZ4QooB4dAgTUtQV8XKlZd5dN5mMf5Elr6aBq73BkW0ltvZHuvw2q5ZN9hCTZNKp9gNddiEIwEd
	idbfVbWZUcdBslwJ3BEYPVSxT1fsoDDsxMWE99WETiYv0yDubYXQ4rlsqZRoi3zzqOMB+QjUqzn
	gy4h2az9dontyjjY3fGUyUdzA4fTlaOA5hH/xZl7ixPzh6BP8eBj57jUeMpi/uJoRcRFpFDCbAN
	baRKuZ6Bp8PBSyicTAiZm6pmeFiw1HVBEbnesePy1MgVuCU2wtFoEhSHJtIa4v5pJFTdheZLpMq
	FyE+J9eGvR1l62gHc2BI1W5M3g7s
X-Received: by 2002:a05:701b:2914:b0:136:e42d:2c2b with SMTP id a92af1059eb24-138421be22fmr248006c88.17.1781140159987;
        Wed, 10 Jun 2026 18:09:19 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13843790552sm117029c88.13.2026.06.10.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:09:19 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()
Date: Wed, 10 Jun 2026 18:09:12 -0700
Message-ID: <20260611010914.429574-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_E500 was renamed to CONFIG_PPC_E500 in commit 688de017efaa
("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500"), but the check for
it in mask_user_address() was not updated, causing
mask_user_address_isel() to no longer be used on E500 hardware. Fix the
check to use the correct name.

Fixes: 688de017efaa ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e98c628e3899..619270bb7380 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 
 	if (IS_ENABLED(CONFIG_PPC64))
 		return mask_user_address_simple(ptr);
-	if (IS_ENABLED(CONFIG_E500))
+	if (IS_ENABLED(CONFIG_PPC_E500))
 		return mask_user_address_isel(ptr);
 	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
 		return mask_user_address_simple(ptr);
-- 
2.43.0

