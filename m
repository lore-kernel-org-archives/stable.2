Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A0370D41
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295338; cv=none; b=ksmgm9KWnWWuSxJtfBECQQwYVvTafv5DqVvV1ZhrXWTFXuoLTd9g0Ehxsi1eIEDHSz5ygKF4w2ALvKO1rhLNq732dTfeZBCHk3KqeiMf/Uhh8b9LiLXLGIDT2PbkibvYe2bsOa7EMd2vn6rWEvYz7BbfWFish7/gPO2wd5oY3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295338; c=relaxed/simple;
	bh=7a/r0c22USbKub7O9zDQbjz1OA+PpCzhZQ4bovs1osY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRPmj3U759agzrXxTJaatE3L3gulfsei5yxjHWWqdG7IcufgsnD8jkoI7SyF247jRphuIw5udXcNcl0zMCzCpiOsBxAloQgMQL9MaNjGwoNtV4mRTFjtQRjAnF6rxftx5n9BrfPawP8zKqNv1dLUrg/F//E4n3yoDdRZU4vVxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m69zvNik; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m69zvNik"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e027da22eso38806285a.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791295336; x=1791900136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CPvl7PbyU/2kfsD+JpTBP33aFuEJTpqh+wQCTs8+mrY=;
        b=m69zvNik5YVUvTfQ0uhiG8LZpmLKfmTHekzbYzXBppQ6UM7XSASAqO1rKNMTTlSXdt
         4hCkCYQCUy/vTeUiT2MsruwCC5Z58zv9zJbMctOUI7b4Gso1Iy4B8mhPmSrjjjyyRlM2
         Viu5WRjLX33rofQcJsfVR76OclD5TA5WKGXbd69n4z7Yk+o99Gt8woeAs1yixpAk0rWS
         kkreXRI5J2XNMB2oW7x/yW34OZCJWDscvjisqtCnfZPeZ3LHYEisHm87e+RKlBvoSGwd
         3W8qekX35wRvDYmq4LGczy5E0iH9Z7hCiX08ptX7nZmcyHy65M7WPqJj4Gfm1Ti/LPbH
         REZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791295336; x=1791900136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CPvl7PbyU/2kfsD+JpTBP33aFuEJTpqh+wQCTs8+mrY=;
        b=NmBJh9TgJPiKW89INvM8EKUn/LhqK1z54j4VP6mWYMIFFOM31lL80Dgn0Wco0Gam1v
         XjS0/RmjZ40CUwgKOqAIaFsArWgDzckYu/+nV8IOnuFYu/vPA46dvl31yuVaCi13QRXT
         jpi/kqyv4G68oFNtHXW++F27ayPCEf3YSZWasZlrwfOX3nTkmm9B7qzJ9ggGt+UynDvJ
         gC1fFzbrQpKlFq/5ePlFoKkEJ06k9XWDnLJj9jX63tIRRLsH20rXgtSI665fQ6Wqn3+Q
         0AYlSXT0XtuV/SCiLh5lOVwUmQmufsjKojMNOrw0dybKrH4kbW/J+NE/I1afXr/vM98Z
         AJyQ==
X-Forwarded-Encrypted: i=1; AKwUvByjRYbDf/GZJw5a9YJfQtLHJ/DZqVGT9uWezqJAhZiVtNRt8KQWu95pEFVPAvmU0ECLXVqOKA0=@vger.kernel.org
X-Gm-Message-State: AFuF++mkBP+3kUNZAZW8PE8GJZ4bJ7qz4QzEkAmTxyXlxopxRzG0oIAO
	GYqvjKktkfIf5+XntBkC3YzH50j6RXwkEY7lnWOamvkOzcZ6tXZEfe5+
X-Gm-Gg: AYBFou3nUES5TwNw5fmyYds+iFhAOcKecgTUP9z/N4EVaSdAJM87svl667IKWRM/qqH
	gRa/WclIJSMBLbKRKlDxfpR1mGVXd23NywR3PIbNn86YUIdzMprE9+xywHbrNNMQLuMs8FZ95zi
	Z2jPeJ0yhoR0cwtwQY1DRfs7J90Os90FELoDgjCqgcLtcvrEi1WBlb1/HxkT6/oJft2GsdM1NQ1
	svtflPiMDiwXOMY7FfcFRtRO1fVEZHWSkvY2536ohgcvrEfwO3CGcqZ42yQbhDXH9KJiXGipv9E
	srBN3uzWleQ7A6U3cVkitcOS+udjj3qvWhme/RenazKavnH0Q+vzgWn3852jzd3Mkbs0W/m3lgy
	RyYjD5djDeEFa0+oq3ZEonaPqkvQ888+ZfVXc2s7lBjDMGW/fgxMCNQ4kcYEa+e9sUiWbB6PUCb
	ZHC/r7dNfrFAJfyjqModqExFV6WfauxjaEAowwFHWHddGBaVXrluudvuZWxT74PzqEVsRGm55rR
	dHaIUbpQEG2e/B4vYtPoUaqwA22tyqiRD//HTYY8tswz8yotPdDAIOdo0184Me2lNg2/nBBAzAR
	qI+dAZ7D
X-Received: by 2002:a05:620a:4101:b0:93e:4bbf:cc11 with SMTP id af79cd13be357-93e8f35972dmr280007185a.30.1791295335737;
        Tue, 06 Oct 2026 07:02:15 -0700 (PDT)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cc9d80ae3sm1138742185a.0.2026.10.06.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:02:15 -0700 (PDT)
From: Ziyi Guo <guoziyi114@gmail.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: samuel.holland@sifive.com,
	thecharlesjenkins@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ziyi Guo <guoziyi114@gmail.com>
Subject: [PATCH v2] riscv: futex: untag the user pointer before the atomic access
Date: Tue,  6 Oct 2026 14:02:00 +0000
Message-Id: <20261006140200.877263-1-guoziyi114@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001184355.2395068-1-guoziyi114@gmail.com>
References: <20261001184355.2395068-1-guoziyi114@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

access_ok() checks untagged_addr(uaddr), but arch_futex_atomic_op_inuser()
and futex_atomic_cmpxchg_inatomic() hand the raw uaddr to the inline asm
amoswap/amoadd/.../lr.w+sc.w through the "+m" (*uaddr) operand.  When the
tagged address ABI is enabled (CONFIG_RISCV_ISA_SUPM, prctl
PR_SET_TAGGED_ADDR_CTRL with PMLEN != 0), those two addresses differ: a
user pointer whose top PMLEN bits hold a tag passes access_ok() after
untagging, but the atomic is then performed on the still-tagged raw
address.

Supervisor-mode data accesses are not subject to the U-mode pointer
masking (that is governed by menvcfg.PMM, which the kernel does not set),
so hardware does not strip the tag for the kernel's own access.  With
Sv57 and PMLEN=16 the tag bits overlap the canonical-address bits, so a
tagged pointer can name a canonical kernel virtual address (e.g. in the
linear map) whose untagged form is a valid user address.  An unprivileged
process can thus make FUTEX_WAKE_OP perform an atomic read-modify-write on
an arbitrary kernel address, with the matching FUTEX_OP_CMP_* result
serving as a read oracle.

get_user()/put_user()/raw_copy_{to,from}_user() already untag the pointer
after the access_ok() check; do the same in the futex helpers so the
atomic operates on the address that was actually validated.

Fixes: 2e1743085887 ("riscv: Add support for the tagged address ABI")
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Ziyi Guo <guoziyi114@gmail.com>
---
Changes in v2:
- Drop the inline comments (Samuel Holland)
- Add Samuel's Reviewed-by

v1: https://lore.kernel.org/all/20261001184355.2395068-1-guoziyi114@gmail.com/

 arch/riscv/include/asm/futex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 90c86b115e00..6f3bc9bdb85e 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -40,6 +40,7 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
+	uaddr = untagged_addr(uaddr);
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -82,6 +83,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
+	uaddr = untagged_addr(uaddr);
 
 	__enable_user_access();
 	__asm__ __volatile__ (
-- 
2.34.1

