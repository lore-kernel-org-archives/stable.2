Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA2488D8D
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880251; cv=none; b=DRITJSF67Egjt3h+965Viz4JhUQCORWEdLwQJerh0vQp6bqbaGnfT4Koa6MFsC3pLPBehDjTovgsKlstkVwXCTEnsqUMzFPKzJJa8pLOT6sdLKN8Sz7Rp4oWI4p4lAkdkpTwpZ+mUU0lTpQ0eGVuhe5TonRNGZO7Y7U0JSgJrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880251; c=relaxed/simple;
	bh=AcvmI+l+XLV01JyvmKBAQ8Z7ntv50tf0vBks+2zx4HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SggG9TfwSDdeHwM2oHA4JmHUDHnecY5tCQ1SD3G779qYnp/o3aNwy1r9DSlXRAFGnI4bM9MmrOZB0NYhTco+McbwP4bF3865rIcPKmYG1xuc79puhC8ioTxjTQGCF4vvzC8MDDfNJZXfJhjeVFzfnan/iszvv9+9/LS9W7Sh5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAuUoL3W; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAuUoL3W"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-5332b66b660so60159481cf.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790880245; x=1791485045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8PbtpP1B6cfhsSP8Q8MPsWsDVS00PSdC8Q8MFvMrDk=;
        b=LAuUoL3WS8fxH/mpgnrNdENTvP2P0uIHhgtvMoNphuneNf8NxFqVrUaCNdXtOnZkab
         2Qkn5wAqP66zypRYRdXFl+b53KdxKbqZiDBpUHAWe3ESEUuoZuZ9MHE1E0Ynj3f3vk0U
         SVp2hpP8hax9lvQP2vtn+QNldgzcZVj8qeZJdhF4vS628hzWMkSrlHKyPxL2StC0sRDh
         bGRZCKu8a1fCf80McbO/URDQmIERym04SVUZJJmXi8h6Oxx+FpI5eBuJC/6r0eMyxFhe
         TWGUfsxPOWucsmLJ/2gJNxhtT2YYnaT9dkfUKgFbFwch+hyhzqEQxqUJirVbEzvHbFld
         2zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790880245; x=1791485045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8PbtpP1B6cfhsSP8Q8MPsWsDVS00PSdC8Q8MFvMrDk=;
        b=gZGsOETwim1oF12YH6l/DQ1yPphhoKo0ekoSDsb9K42WSbAgk2F/llqz4XEZPEd/66
         kmejGBIDtmab8LylWLLe5zAlDd3WUHX5UdijWhwL3wcsKbJnEdFeaSbnMH+5ZDwcDjVp
         p0Mvf83pxFEXEvR6mWZTi4bPkKDgwaiW2qj6d768B0jE/NHMmWghOypBmM4BZqYT+Y8Z
         rs5Ik0jVRFMN8N3YMZw9Cnxfe2mn15rJV78aHrvTZ7vuZuWa9/L134H6x/QUE59cPE+A
         SyyI391fLuy8JvM2/AENFcWK1Ok4OQGC5D2+zxDr2SNJjz+CR20nWH7TD5+l3VJ9H0ig
         v+tw==
X-Forwarded-Encrypted: i=1; AKwUvBwCB4NOqAfrLuoyMhgWSbsw6B+JWZWNUk8bTpreo1WzJ5MLVvjl+p7UNhpEYx4CYWuUqDEEW+U=@vger.kernel.org
X-Gm-Message-State: AFuF++n532wksCC9pBnhqd9QhhXuKIKov0Hh4Wdqtx3owDeb3e6YeSmH
	i7kZ68hh9KRWczjljlS+ymP/Xt59cGMJOIw2b1+MEf8F0HI8cMKWT5gu
X-Gm-Gg: AYBFou0p2TDT9NjhCy5ErhnkaxYx5JiLGTel6VR9GZcKkTNkwNGPKtWHWJ2HNjkVBGm
	n93FWdeO3o3TJZrAT6bArrouoy/lfo1+2wreXYenBCZsPyUvIL4xLKzA4hI9cwcpN6ZPn/lWJ8+
	vE273qL/6aRCI8Rqmj4cLSlM8gU7GSXEqsuWbrHbcL6OhHE5f0Kxccs9et01+RJ0f9Q+Dw4Ji41
	IB752iJwetH+NqEXKqhgCXyQIkFE0vkJ+O03rHVidjQnviRvuGZMQyA400ru64Eu6ZiTFmdN7kt
	GV7ClaIsdDTekAKP+l3yRqSs9TJuDsWP1wyzZk0l+94+L2xndpdjFDD4urEDRU6MrajA8xksg6d
	qqcVyWM+I+yGcm4pI4+rVxB80MJk+pyDA8z3a2/ODBoByBKEibJ5/N2oPIcjrHqerh+S6egZVo/
	XlZ8rQkR3722Or0vOSwhImzgEtZ92qQEZwlY3sGb+GILCWU+RENL3vUMtqNFGUcCOtAXWdL1A+0
	VSreBUS6v5o+TRuFXvKGe7AktkRWGOOIqUEfQIt28+s1V/TDZFYJf0VrmjMeO5Crm44MDfEpOyL
	mndAcmA5
X-Received: by 2002:a05:622a:130c:b0:533:356a:f7ee with SMTP id d75a77b69052e-533742b2e74mr106883461cf.25.1790880245336;
        Thu, 01 Oct 2026 11:44:05 -0700 (PDT)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a5b6ffsm5007681cf.6.2026.10.01.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:44:04 -0700 (PDT)
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
Subject: [PATCH] riscv: futex: untag the user pointer before the atomic access
Date: Thu,  1 Oct 2026 18:43:55 +0000
Message-Id: <20261001184355.2395068-1-guoziyi114@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Signed-off-by: Ziyi Guo <guoziyi114@gmail.com>
---
 arch/riscv/include/asm/futex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 90c86b115e00..8d80e580eec5 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -40,6 +40,7 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
+	uaddr = untagged_addr(uaddr);   /* FIX: operate on the checked address */
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -82,6 +83,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
+	uaddr = untagged_addr(uaddr);   /* FIX: operate on the checked address */
 
 	__enable_user_access();
 	__asm__ __volatile__ (
-- 
2.34.1

