Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7C463B91
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388672; cv=none; b=tg8q93SVh0vgYnpwVu6djzVSRi1zXvPSaBpsnJcrHeVMNDqYIdLb8IVpGPx5zj6HnLgPRaELxJxk0sfSFxbFnLxtO9YQwQLthIiKdL6fsR2P2PH/y8+RQrQlwSvNX2ALqKzVZam1lF7vNPyDG8nPoNFG1uUz/5rmuAcmloc77Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388672; c=relaxed/simple;
	bh=bBnAXXUmE8Rf5xlW6stluIlOgSSprXp3socUzBXbJJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxsvBOWhl6ikVzh1L3nb61k+NWvYOFloY+0FF5NuB1kzgaxvJSq5O/W7sp5VrlyA9qW/Pxs5TAcdLe2dddh+WBCnAD6zuQSTviv3SkpAD91NvARK4xBdt7P1KEelUeSPQqI5q67UA9bA5nucoeFP6TIQUvwcHBCy6LAU2spyUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GuCjH3fs; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GuCjH3fs"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3516e7693e9so328125eec.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791388670; x=1791993470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVUR0mPxOZ7cLe3tx3kr6IkZOSqHAPMm8wQmfjR1ZyE=;
        b=GuCjH3fsw25c+WCl6OG5cXciZxRCrj2n/9PUkzKb3Qt2GnCcKM242YCzZiaaf/Q6ul
         r1HtxjyGKJZiIC1KwIb0z5rm45zkaAz/eWqAxbyj0C+aZGbgauK8ZnQpH1g0diXU+wTA
         s547drRs+HqGhi3ouaN6fWAGsC3lNl8POLFwqkn/IdlRfNDhKfHvr5PsQAPMbV3RTlFL
         y2W/8j1I2p/ulsrnqszlwLG2UKQMW1kkSBMw1qf7aTRMWZk3ZjabAax79jsi/9+h1/pj
         hNfKzqLQAO3517kakL1UyCoO0MYAaDqoI8RPfZcaQpFSplMbYbSVJWs1MN6khuAhi+vH
         x4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791388670; x=1791993470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVUR0mPxOZ7cLe3tx3kr6IkZOSqHAPMm8wQmfjR1ZyE=;
        b=U1EUFLkN+vVcASv6RobhXW93isFI6CUFUnMWMJ+4k4/MMmWTv8ATomWIgBRbmRQ4G8
         hF7m5NnML0GvgDIdo0M8JjpYb8v1yX+b/8hqRAKJrA0RiQ3OacuzHQvkOxH+dJAafodf
         oJwtuzbikok6qdKmc30/VPjGvgFLbbz7bMxsRxkkebeMkJ1iuKIv2p8EYIDi2xrxEA6C
         rkgtL5kldzw8DmL1amFl+77LcWm4iNOtZI9Kj1FJpi+w4hfJks5/yc3TVtCEoDbFTPsl
         Y/C7o6eZ9cq6AbPXNidQGY0n6VYBDkT1hGf6AgK2LibuV2GZQzRHFfIIiUvp3Dvqujmc
         02Iw==
X-Forwarded-Encrypted: i=1; AKwUvBwaZs09jnREBHvfrsRUE4HWiSxVdPIImJcTKPF6lMylm4P2EGboK/xpjZwPb21K7RzknV+TlRc=@vger.kernel.org
X-Gm-Message-State: AFuF++mRt+oKtGOuVT/nprglOyNBy7vEOdtwKqISispxKg9N8S2vWcR6
	yg4yXEZwjFclHofCBVr9sstKkWNE8oKwqcqWWSXXYjCgszExdxebAR8kXowEmGsxd6E=
X-Gm-Gg: AYBFou3DzHHCuLlSEoMOhL8zc1ZE5Zsv/aACbHnzfhLWyBIZqN1gTIS0pkxG0Ilurjt
	coqbNYgieKoYbsz0vgZqK3S8h1hzRnpYq2WJKLCjI8L6yz6goDz8h0sfuExYxvDAx9uoR/beHIA
	cgmDmF8X8Zra+2kh17Xd2u2rijtV6uVIula4w9JHEue4d8vmVLQhmCydlsmGg9n5mM1qsGl9N9K
	81tRXAQagY8HySFmbOkCvzTsDG6gAtg+j6A1hUmO6CPMvd3J7k6SLOMeN7ngsROtxgpDyvY+tQm
	mlRQM7MwYArTzQ1yzv7gWoGk8Ax5TC12+1LxmT1XirpLcV5qjzzwpqba8oS++U0HDoLAT6krIBH
	sd5b8U35Yb9WWyV/hNw03nlR+ILTxzPS9LeBFm5AfgJG3nY8xMKWHhU5qIq0yd/FbCl+EyezHVh
	irpCrbONgbUHysEyOxlBO9bBRpchwtl7o4ql7NByrKjpuB6ZcVlxYjhSy8lmV5Ljp36BrR+dICL
	p2Dl7FYlqFcLcmYMyMY
X-Received: by 2002:a05:7022:512:b0:146:84fd:7b58 with SMTP id a92af1059eb24-15d2e03cf39mr9053699c88.9.1791388670115;
        Wed, 07 Oct 2026 08:57:50 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16168f586f8sm9457788c88.13.2026.10.07.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:57:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Paul Walmsley <pjw@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] riscv: cfi: Bounds check restore token before swap
Date: Wed,  7 Oct 2026 08:57:40 -0700
Message-ID: <20261007155748.291814-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the user-provided shadow stack restore token is not checked
before being used as the address in ssamoswap.d. While an invalid
restore token will be caught and raise SIGSEGV, this happens after
writing 4 bytes of zeroes anywhere in the address space. Check that the
restore token is at least a valid user address before the swap to ensure
we do not scribble over kernel memory.

Fixes: 66c9c713de59 ("riscv/signal: save and restore the shadow stack on a signal")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/usercfi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index dec0ba5eff5ea..23c4d6d9d8cbc 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -206,10 +206,13 @@ int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
  */
 int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
 {
+	unsigned long __user *token_ptr = (unsigned long __user *)shstk_ptr;
 	unsigned long token = 0;
 
-	token = amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
+	if (!access_ok(token_ptr, sizeof(token)))
+		return -EFAULT;
 
+	token = amo_user_shstk(token_ptr, 0);
 	if (token == -1)
 		return -EFAULT;
 
-- 
2.52.0

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
branch: up/cfi-fixes
