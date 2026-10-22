Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707454;
	b=wib0QNn5JPReEg4lvBRmwka5a3sgiW+mpm8/28u8u04TG9rnPFd4F/pH4O+xhS5b7KjW
	 PZujTheGmrzr0LBVamaV7hsf90H63CPxf6ErnuvMgS7iNqMJrG9ERy3Re6szZEv8U8S4v
	 NsgcTfBp8FAaM5qu9hw4EyQO2c966VIHA9qEiQmBm3xw0/ru6LTLhqB8oqZG8ZRDkeunT
	 lPtRj+1SzFeu0xBx4qIVME/yk46Pu1MRcxnU1JzacbQ99RJyqvmG3xQZWusSDEYMKc8kh
	 rx1HpPovUf8k1B26Rip+dp5evJ3dDPv4G2+ywr5CLWwhzBE96j2sDgG5mTQIqIxpUEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/WIkpltfnb+vy/iRWdcQeenTOR+kthNZwD1BDIJsCtY=;
	b=0yR+vWnGIGJ9jEmgbY8nvqQQBw6xScwWrjrAUhzUYy7ONbohxxZZv7Ziu+F+KDxjHERh
	 dUWuzxGENDnm3suQuKl+qMPl7StIZyOJMb8rKotQoZX+rwHppvudL8OOCQaa2OZWlM5Du
	 q6wGhKQ6tok6V+I2yGktgCUiMuep0LihkASPbEVeqUSz7NXuXWQfdec+a8SsTA2GUGgYq
	 0lKKNFFHFxSftB6OJsB9/cnwQpskqvFEwOvjd3mC8VxtTG+p84ixfGXVdiD8vV+xIPjzW
	 Y7KV2wmuR3+yLR1NJuJ44XrxJotfOHV0QBjvAhODqnoraH60yOnDeu6LJCHXgSP+lsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JFpZ94Ob;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C7606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC9C7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JFpZ94Ob
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eac01ff101so160341e0c.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792707453; x=1793312253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/WIkpltfnb+vy/iRWdcQeenTOR+kthNZwD1BDIJsCtY=;
        b=JFpZ94Ob3Fm6+qT3OvTYTxeHkpIEU9c+VZ8lDQaWmzPXF/uzU7JrLsmPMCYrUuiLQZ
         1Wtx830OvhlAppc3G4T8svioQktLUvKgcZ1KZ3v03L38/G98omE3XjY0OAmiH6DmV3ar
         iNs2BkVv9aPFu0Ck7fqp1MbCrDMvzbcrKtbLnpRYO9esYY5a0rpVfaZeST8FDrRLZ0rw
         JL3+G/uUiDflNKH7CHP3Nlk/zXwq97RxcLtFlvcXrIBOpsXfAHtyPvsF09Lqb76JVHHq
         jYyQMy7aMRjpbqqg/cZb2pE3wbP8ckVY5j9uytlgLoOjBec8ATLlTrk36iNJhhBXKKlS
         n3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707453; x=1793312253;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WIkpltfnb+vy/iRWdcQeenTOR+kthNZwD1BDIJsCtY=;
        b=akyD3ox8mFVnxAgSA76uCZYwrvrtFfVLGLAdzj+i4nZ9TGuBQyneUejFayAUCDxz4d
         hs3jBIumcodkydOvO/B81bUrER+bjX7s0KhkO9pCW4cBV103um+G9Zq6lByBkwutRqdg
         KenDvqUpcXcQjVDfpksGPILfwu3TdreNC7jAi6w8a7oH8QfuX8HXmcRPfI0cCYhSn2rm
         4smP7CID1dZb5ERLhukpN+v65ak2OB4JDnqoG8+sJbawLV4JgrhA73YDrIy6OR0MzrfW
         5fgXaFKXIdZ95Y6IsXCXA7gG7NEVrGmkXUOKqhxIGkV+hXr22PaBvt8WPyCpYTkoenHO
         Jksg==
X-Forwarded-Encrypted: i=1; AKwUvBxwLtejFhVuS3v56d18w/YW7/2tnV8T5sQgZnM9vm02bQ13e/x+oFmVXHrRmTS21J1EHmaAFCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/KFE/Sokgs2HrftagjJlL/ndD7nQ8Hk7rEZ7qJlFbb+0M9ovB
	V7J3W7UBdWeridvS65x4lOWdZ276OwY4WJo+ptAaHyhn3cq2MquH6CN4
X-Gm-Gg: AYBFou1VaitXYtq7Q53FDSOSqWx2/i6xLbX3guzBu6VkYImC8w0gMCbqq9KcjUOmfaC
	BsXHGOaSmJ6fKxIvBd41dszEmIcsB5Q43GBkyl5lLeSKYWMFueH0+NBdtGaSs7QB8fjQowf6BG3
	MhJOWqX8XBb5/AAUrxjH/P/C9YgmUizK74SlWUYN9lLqvwxk9RzjQeAb8OygKTySGfArpykHRQH
	DG7ytj2OkvhBKmZsBtYH3pl2FRQicrWgIHKObV8meODm1opdbbmyjDG7YWtoJAPOUYJu6oVZRCZ
	7T6SsiTnreIjjoCF1JBu12kvrfvI4bezt6PY7WtL43cSEwR+SGiVmP2KsimuNEtvhWc9WThjpAo
	K+ZmAh/RE1XIRXxn8XobvFWln/65vsf0YqPhTJljY/M7iZF/V5v+Iv75sTd9IBnPnWBq3Dhct+j
	Feyh2HSf+lYGRkZxWCOMcFjkRdGvc0+X7jHd1D/zr0aeRW70/Esddj3aRW3uMAlPTOaFSByz1rl
	pyEbjpwcjtAjHe8CHmlg54Jyr4gRE66S5TF0tCs09O3RcpwDA==
X-Received: by 2002:a05:6122:178c:b0:5ea:ae99:9b2c with SMTP id 71dfb90a1353d-5ec14ab087cmr87153e0c.14.1792707452787;
        Thu, 22 Oct 2026 15:17:32 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13f2cfe0sm456271e0c.14.2026.10.22.15.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:17:32 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] x86/shstk: free shadow stack when copy_thread() fails
Date: Thu, 22 Oct 2026 19:17:20 -0300
Message-ID: <20261022221722.619233-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022221722.619233-1-ivanrwcm25@gmail.com>
References: <20261015023147.519257-1-ivanrwcm25@gmail.com>
 <20261022221722.619233-1-ivanrwcm25@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

copy_thread() maps a shadow stack for a CLONE_VM child and can still
fail in set_new_tls(). That error returns through bad_fork_cleanup_io,
which does not call exit_thread(). bad_fork_cleanup_thread does, but
only after copy_thread() has returned 0.

commit 748c90c69336 ("x86/shstk: Remove useless clone error handling")
removed the shstk_free() on this path, assuming exit_thread() would
run. It does not. Each rejected clone leaves one shadow-stack VMA in
the parent's mm until the mm dies: one map_count slot, pages not
populated. The size follows the clone stack, or RLIMIT_STACK when
that size is zero.

Free only after set_new_tls() fails, via a dedicated cleanup label.
Nest the TLS error check under CLONE_SETTLS so the successful path
returns 0 explicitly. The allocation error returns earlier, while
the child's base still aliases the parent. shstk_free() ignores a
cleared base and a different mm, so CLONE_VFORK and !CLONE_VM stay
no-ops. The exit_thread() path is left alone, so the double unmap
that commit avoided does not come back. The io bitmap is still
shared only when TLS setup succeeds.

Tested with user shadow stack enabled, on one config with and without
this change. Sixteen clone3() calls with CLONE_VM|CLONE_SETTLS and an
out-of-range TLS leaked 16 shadow-stack VMAs without the fix. With it,
the VMA count was unchanged and call/return on the parent still used
the original shadow stack.

Fixes: 748c90c69336 ("x86/shstk: Remove useless clone error handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 arch/x86/kernel/process.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 346c438ac880..451594fa5481 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -176,7 +176,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
 	unsigned long new_ssp;
-	int ret = 0;
+	int ret;
 
 	childregs = task_pt_regs(p);
 	fork_frame = container_of(childregs, struct fork_frame, regs);
@@ -263,12 +263,19 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	}
 
 	/* Set a new TLS for the child thread? */
-	if (clone_flags & CLONE_SETTLS)
+	if (clone_flags & CLONE_SETTLS) {
 		ret = set_new_tls(p, tls);
+		if (ret)
+			goto shstk_free;
+	}
 
-	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
+	if (unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
+	return 0;
+
+shstk_free:
+	shstk_free(p);
 	return ret;
 }
 
-- 
2.43.0

