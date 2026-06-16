Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A32C027C;
	Tue, 16 Jun 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618131; cv=none; b=HAOoIVPqtiX1ghnm8AV4HPtRdF/GQvL0eicRlUwXj4qAEVWyXFCfzDajDssK9D3XNLI89FsYF5F2RhDZ1b/YBI+7aYZT9esobwdFEeptUd+RgtHdNv4Spc7EW1sRBmHda9JE6IWizrx6mOxRUH71QnTo1H9fzfdx83TtygNOSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618131; c=relaxed/simple;
	bh=pOyXHQutqch4Q8214h6bv/5rWKI9/F2GR01kP3wzY24=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cUmPCDi0vWc2O89pDeA4iOeiFEssA8iIAAZbluV6h+gXcLIIbki8Mv1lTcM5HYQ/mBRhzWq0G+/g1LXkXxKIlQhjvK0x18+qrcQlaOQ9nbkIY14F8D95psnBBqxa4OPJeLgiCTL5zotqOTr4+JYGjM3/pxSVXBrnvHZoOMLZfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izsrh6J7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izsrh6J7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D431F00A3A;
	Tue, 16 Jun 2026 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618130;
	bh=386TELQbEHxweuigB9LLOnXetjMUnGIUnGTjr3fVOKs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Izsrh6J79mj4NNjgJRzsUchOsOD02IXpx7Wb4ZNbQQt2pyIOembAqm52TFNOlTS7D
	 fxm91gfw7l/V3mrNrONfp6spjYuaFEbDUO9KSSOJf6R3ovS+qrFVyjoOlymE4mpmK/
	 GnjolHe1kLCD3h+8A4mZc/rfsKagWzsdtmmzrFjJ1adTHqeO9AhR/Q7oow0ezE465q
	 rf4YIFx0KQFUqCfuVq4WlACpPiSbblyOoCJr4smFXYpXpCmTTC0L2qAmWZmv/0muvL
	 SL/LTbgPZ6mSsMHysts47x9yA4zDondsZd5RVDkEdG6/KRj/1ttagN/djdQfjcI3P/
	 GbM/c3Ikq5fUw==
Content-Type: multipart/mixed; boundary="===============7481909573851222579=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3c63feba5e72738b34d50b2c614e309f0ce6a2a11ba70bae9197996a3e58020@mail.kernel.org>
In-Reply-To: <20260616164741.32252-7-adubey@linux.ibm.com>
References: <20260616164741.32252-7-adubey@linux.ibm.com>
Subject: Re: [bpf v8 6/7] selftest/bpf: Add tailcall verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:29 +0000 (UTC)

--===============7481909573851222579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: Add tailcall verifier selftest for powerpc64
>
> Verifier testcase result for tailcalls:
>
> # ./test_progs -t verifier_tailcall
> #618/1   verifier_tailcall/invalid map type for tail call:OK
> #618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK
> #618     verifier_tailcall:OK
> #619/1   verifier_tailcall_jit/main:OK
> #619     verifier_tailcall_jit:OK
> Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

The test output lines in the commit message could benefit from indentation
to more clearly differentiate them as command output. Consider adding a space
or two before each of the test result lines for improved readability.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============7481909573851222579==--
