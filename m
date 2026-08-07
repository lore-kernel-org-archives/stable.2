Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056D33DEFE
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114748; cv=none; b=I9UxeozZtw8B7/QRivddIg6EuCnaDAv+i/X3MMUnjtcIZohIdGie8EMs61NPi9d3CpjtWD9NFxCzNEDDBMHfkeom9NG8SScQ6gcwOjQ3ZJhmOG1Lbg5TLK5gg6oTc5O2gyrPhJh4dcnLS2LU+HtiSDXRnWZYjP0Grqiu+2glGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114748; c=relaxed/simple;
	bh=SHHzAbJfdnPZtdWXfC2j8SzUVJsq7sWoeZOsg/Eu1Oo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=NQlvOG29n0wFS+cGEUuMhjqVWS0DUwcE3Lshpi6MrWeAdvknSLM5a8mcOHAYW+bBoCo1iUd39hVl+ig20A+ia1IuQdpgFwYO8X8nHYkCA9VsAIoVydYPa+1kmS1PFa1JZI3wOnTGmsftxgvlSvlFGvzQD0sxTZ2VphGluo9AvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Is33a1kn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Is33a1kn"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38101f85591so1933700a91.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1786114746; x=1786719546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PU1wKjH0h+P2PvvnD8HJePOSNu/jMJxnsy78sXCEOUI=;
        b=Is33a1knoroCGaF975JAEWiHB5RoJPtEAK/uAUHPgjkNt2y3v69ZsyeICxQbG0mfgX
         ekP4c4xUV8HmDjBo04pc+K/nTVfpPWbdEwHOWzdeP+nu7VpgcwWizxAw72xw/3ROhUCk
         kfWWVO/i5wRakCnloRD8RNb8sm03MxVXJwxvFRKBuyn9Vb54HO2Mu+6vXDac3oq1nC87
         fFA8G8GaSQ/cSxznsnZBrBVByGm1RfFEZvDzl0+yCrCsO5UPjZwnR/qfjkO6gTh1hWPv
         Too7THfaBXqJk9VQJOFhBh+VX5fwSfDcQ/YItvCGleQLB2HjW9PtMLIy8BevRIxWKM+I
         Jb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114746; x=1786719546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PU1wKjH0h+P2PvvnD8HJePOSNu/jMJxnsy78sXCEOUI=;
        b=K+FpDa/8qIutZx3XrwRoxIT60blwrK9QbwsxOM0mHNg72riwFSPOV/4IhfQcDH1tXd
         rosbna188kpAmAqZ3gyqHRXHyg91YQ35WK+4jT3l51bvweVkcItTG2Fqn01CLcPd/Tjb
         xmd8W1O2uy4+G3XGSOcg129RiaeCeCQlHA7+6MoCh8L667DWYJIR1wrCgw2hdsB62KMA
         ZneWNKhcv4Xj5qn5loy7hj60wnudyxba86/JdWTpI5Tzmh2ofgGaojmF0vMQ3Q2Z/res
         1UmRm0vSuOVQYI+BFd9vnbnmBdBKB0sf/NCqQV5xRosEKMRwnWVGYEAOyfBB1KwUtjQI
         rudg==
X-Gm-Message-State: AOJu0YyBUmFPqz26j4LD9YYzXV1mUzRCu+tIK0r2Mpy7uGfnj2fXFZ8r
	PCyuQDh1bSauYbfxujWPBV6QS6ZNM755YQeXSMZ59d1KgLJdz7A7oifjevORsKCrEfw=
X-Gm-Gg: AR+sD10BgR2+fbl7JK6K3ON7KrUF+RB+O5nP/B7icvceZHqhpX7iCzEqPDjsJec+R2M
	QRotqhehUVq9M/DIc3dZJ3HZRMYN5LQG1Sx72RiEFEwf7abIqdElJLYeYqSCqFKvSezwfbdD5tn
	ANq4VhVHxLR3pRIpF7rj2XLPy019FYyEq6wNVA0vDRupAcdgfHX7u91x48aRkEv+N0mMaxJv7y4
	KT3V8PY+M/LS44o7MtruM+ox0AWf5tcUF2q3yFGq7+iOp4Wg3fdCsm8UsGnrdG3m40zA+2ie3kh
	DkQc6CjdxCq70F2MxEJbbpbGU8ZlcB7j7LPr1kfxxN+12ZYSEM4dhMkCNFBx1z4tCnXIfKxUlBA
	AN3Q0TxTsUKUI7RjCioKqY9hqJ1WUF9rkTSoppytBRCAEKtTjAktr9cCvMFiWG8jyiQCjqkm0ZH
	F3a64n89QBr43a8t3NPaf4fDFaWVZfhZaLYa1TCB2IqvlNN1vbi2OFrZ3+b02zziR+RA2GRSbPv
	OR2
X-Received: by 2002:a17:90a:c107:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-39083b8f11emr8782659a91.21.1786114745522;
        Fri, 07 Aug 2026 07:59:05 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b95b20sm7733954c88.15.2026.08.07.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)
 /tmp/kci/linux/mm/slab.h:572:24:
 error: duplicate 'inline' declara...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 07 Aug 2026 14:59:04 -0000
Message-ID: <178611474407.7658.14431237412617748501@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
 /tmp/kci/linux/mm/slab.h:572:24: error: duplicate 'inline' declaration specifier [-Werror,-Wduplicate-decl-specifier] in mm/mempool.o (mm/mempool.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/mm/mempool.c:21:
/tmp/kci/linux/mm/slab.h:572:24: error: duplicate 'inline' declaration specifier [-Werror,-Wduplicate-decl-specifier]
  572 | static __always_inline inline bool need_kmalloc_no_objext(void)
      |                        ^
/tmp/kci/linux/include/linux/compiler_types.h:249:16: note: expanded from macro 'inline'
  249 | #define inline inline __gnu_inline __inline_maybe_unused notrace
      |                ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:552fff16b3e598443df3b1292b7e338292e7187c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  993a046a044df0f29fc81dc45039a2a90dd4ae67

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a75ea8862f33761c09011cf

#kernelci issue maestro:552fff16b3e598443df3b1292b7e338292e7187c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
