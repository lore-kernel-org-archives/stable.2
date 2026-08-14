Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34347ECF3
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720449; cv=none; b=gzQIhorSwuZ1D/SLtKMig91qukB0Kg/DeRX40xpodrnZJIzrHGvmTyMRmV2Shk6w83SYvj5Qays4AaFxpzdMZt1eAjpS39SNB0hY07p4tKpfsjPrcpWXHviBFNECLizL0B0vUfcgYcNt35vCwfpK5eIHDmdrr0B0ZhVL2NCEfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720449; c=relaxed/simple;
	bh=VFKeXyJTX5elzCK/iZOeCAqEbI268lQudBfzIl/EEBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7pSDppmUsOK6/9H5O9GnGjmdMb5/bUQh6NhH/u/4tXUWjnAIvkrn3WNpZ1eBob4sntVSce9fyu8CveVQltngI/XtvpvTWnU5N5/llVSIfEDXf3fCt/PyPYoDUJsWY+EwjZYEBI68CkZQo7Zz6bOvhtK+1AddZJXKzqFtSh8h3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTFfnkDV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTFfnkDV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce7d2adef4so19589325ad.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720447; x=1787325247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evqg/wCVmloNStWe7p9zX457kvwkpQrapIFq3Q4j/Ts=;
        b=XTFfnkDVS4Zq1xZMqAGvvQVKsZUpNSOsAfhzWs9uNK/YIzXPscSuwncOB+nNyplbXy
         E7iNfOeYNqpz3IWezwX/TJedWjm5pKAaOWvK+hIZ3qouYIA4gs57KvBq/w2Gt1oB+96e
         YPGfcM8RGAdwCd3HwSLUiTWRlDcFA6i8OGimk0HbpVzTlVCJmZHguRfgMzvCImZSC2Il
         w8RpkR0RdMdztWAwMJIIQrdZnk0fm044N6495bZyflefAqImUFdn8Nd2cjz7uu4rc05Q
         mqaJtVuqaa68UTzogGemaL1c4/8yq3oTeyl+DdEEg8uQugK2YFXOl3hyPwRK+sWxyJx9
         okaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720447; x=1787325247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evqg/wCVmloNStWe7p9zX457kvwkpQrapIFq3Q4j/Ts=;
        b=QqLqJ+pScEfEbCqXhWeKCyNebbI+DaaIaOl6b974kmUGKT8FZJo+VQQ/3nXWiG1mIl
         LLZIgetAOUcml+ivtetCSt+3wV1m/KGDCJRKYlTJe8KNJpBRf+ynG55qxuPHX7lygJlg
         OsKgMjZjxqTmoGv0QNUtBcdPuO334ZUEgpUXGir207j6pr0SCnb8qT23TduCL9Bz+vSg
         nlO1rtqtuuxHb9JAJez8alpOtsspXb/g723ccVO65dW89HkJ1nXsPX8moflw2WGvdUd9
         mPLqmUebZnJktZihG9gU21u6c160mQJzPRYptR4G2mw4vxe/xRPtkltwER9Yd26d4U5O
         diag==
X-Forwarded-Encrypted: i=1; AHgh+RqV1DX7DAwSGxsWHsUfoad8TqyXM4kD83XmIsd1M6o153FW4DAJO6Uc7BQ5aZG2jq0WnZYBTtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrVnbM7GF4DKogb0q4hfqSJs1noQf4gO2t/52vHcPzQq0AX+z
	gkYwQ4H7Xxy/3p3GG3ruFKNJl9VkTKoa7RfU5uHGJvzAf/+C3A0i6Yk7
X-Gm-Gg: AR+sD110nmrDbZAeq9gkE9l+Jj/aMr7b0anaGL/A21IicppOGdqlojzOHc7urcRd0Hs
	WklxjiFll+MxMA3X80m5XMAo6NJ2/KbBGVUBeeIOV2rby34ifjZJvIWjeBQ6pw//kwJeFpHoAN6
	3ea0vvRMuVdcz4NKc9uumLUmhPngAJTFqi0KWfeez56mJICUZTsluAFYt/gMQmnioqYMNfZgkWu
	iytwnb8X7r5AOindeMhPKVqb3Y7NJ00cG26/+Slkkx5EWiPzTpxwew3pxOM4yDO1vC2kGkmv32K
	wnyJpV14dfgbqRs8LnECNBh5uB2LDLRooq9pFiDiedy7nt9lNOZJTiyBBnb/TMm1smX+A+hAHA0
	qtb3TUsmBKM1S6UoT+4W77aSbmE6VU0Rq3VFo7LIk8MiLeWJgagTr2E6Aw4o1bpLqkrGxolhPfq
	+H8YNYElwb74roaBgBVzT90PxnRGs1X7isP4QvSD9E+7AIEtnUkDEMzV+Vtjt5jQWP
X-Received: by 2002:a17:903:98b:b0:2d3:14c6:2372 with SMTP id d9443c01a7336-2d3b080bf23mr87501645ad.1.1786720446877;
        Fri, 14 Aug 2026 08:14:06 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:06 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 23:13:40 +0800
Subject: [PATCH 2/3] powerpc/spufs: fix type confusion in cntl mmap fault
 handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-spufs-groupa-v1-2-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=2202;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=VFKeXyJTX5elzCK/iZOeCAqEbI268lQudBfzIl/EEBk=;
 b=AG14nyeb4IhnSCPWTjL4v8+rNjf0tPtUgxRKsImcMSuFPJsj0j8j4vy4E/bgRcAa0zpWN1tVF
 s751jK9hQFeDsWUorEwvFI2E+VYhX0W25tuCT9Ksr5+4vzAyq5HFQ9y
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

spufs_ps_fault() recovers the SPU context from the faulting file with

	struct spu_context *ctx = vmf->vma->vm_file->private_data;

This is correct for most spufs files, whose ->open stores the context in
file->private_data. The cntl file is the exception: spufs_cntl_open()
sets file->private_data = ctx but then calls simple_attr_open(), which
allocates a struct simple_attr and overwrites file->private_data with it
so that simple_attr_read()/write() work. cntl is also the only such file
that installs an mmap fault handler (spufs_cntl_mmap, on 4K-page
configs). When that mapping is faulted, spufs_ps_fault() reads back the
struct simple_attr as a struct spu_context and dereferences it
(ctx->state, ctx->spu->problem_phys), feeding a bogus value into
vmf_insert_pfn() -- a type confusion reachable by an unprivileged opener
of the 0666 cntl file.

Obtain the context from the inode instead, which always refers to the
real spu_context regardless of what ->private_data holds, matching how
coredump_next_context() and the affinity path already fetch it. This is
equivalent for every other spufs_ps_fault() caller and removes cntl's
dependence on a pointer that simple_attr_open() owns.

Fixes: e1dbff2bafa8 ("[POWERPC] spufs: add support for read/write on cntl")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index de7494748fec..8c7515140efb 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -313,7 +313,7 @@ static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
 				    unsigned long ps_offs,
 				    unsigned long ps_size)
 {
-	struct spu_context *ctx = vmf->vma->vm_file->private_data;
+	struct spu_context *ctx = SPUFS_I(file_inode(vmf->vma->vm_file))->i_ctx;
 	unsigned long area, offset = vmf->pgoff << PAGE_SHIFT;
 	int err = 0;
 	vm_fault_t ret = VM_FAULT_NOPAGE;

-- 
2.34.1

