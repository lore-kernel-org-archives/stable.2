Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959746A5EE
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862773; cv=none; b=gaX8mAQ0M08fV0NjmAdFS+T/v/XXe1luPBTxkx1IBg3LJa5KBc0Fmw/LvxL0Rjk/i4Fe2EjQS8ZmLXpXLI0WZtY46ViYXFQrZdp2Eq3kHnrtaKXGRnldJ0jg4IPymFoxZpgSEnyt/aPa1dwq42jYKeb8SN0lxIIoGV5otAs6REw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862773; c=relaxed/simple;
	bh=+vhRxjblLVKvP7WdudvdmQo+ffSQLsCCEasY8z0as7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxZBKLAfkN8XTajOc5YWF9c6jhqqhLCRJ/ci8tDqQK+sXOQBwlU8qLUFpVoNHt9ul0uX/clxEEPDAz3HOPycYSLOASOT9JbzEnibHGtScx8uMrAQDcfaC0j/zBxkb7BNsGYLanmhy/FtYPtrC6YJG6G8N53bllbyRph+iw4FK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WefQtq5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WefQtq5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F211F0089D;
	Thu,  1 Oct 2026 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862768;
	bh=LJZorh4CSUj7ReDHiCpVo9XJp6EKqza9o1f3MDJdr70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WefQtq5dOJD5i9TT5ogghynC5fetQhPYFHAFvQ9hPCI7P5SqbYpoUJmVt4hybMfdf
	 yjJAehYPX/WtTZ41OuQfaognIgFjJvg6XyupcDj7P8V/NjQnyXy/Jz2CagPUHNBTZq
	 yLw1kcoy2VIkGwPU24M/5cw8OkGfMOmgElcgE8fWFUtE5xbR3fSHg8pww4ULClOEI5
	 hqIyWLqUIFStOaJH410tp0il5ZgKavUJ6dC9EgSMeBinzlBd1jHlNnBypgjnp9y3EM
	 WD7oossXlX+235xK7XFwApmsdaZ5m2LxjXyt2Rmcb4pSnLhQg4P86yCDasLZX93ZLb
	 Gum+psLXoyloA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Andrei Matei <andreimatei1@gmail.com>,
	Hao Sun <sunhao.th@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shun Ota <shun.ota@miraclelinux.com>
Subject: Re: [PATCH 6.1.y] bpf: Fix accesses to uninit stack slots
Date: Thu,  1 Oct 2026 09:52:19 -0400
Message-ID: <2026-09-30-1-daily-reply-0015-bpf-uninit-stack-slots-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930091119.749424-1-shun.ota@miraclelinux.com>
References: <20260930091119.749424-1-shun.ota@miraclelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Resolved conflict in check_stack_write_var_off() by dropping grow_stack_state()
>   and omitting upstream dynptr logic not present in 6.1.y.
>   The following test files were omitted as they do not exist in 6.1.y:
>   - tools/testing/selftests/bpf/progs/iters.c
>   - tools/testing/selftests/bpf/progs/verifier_basic_stack.c
>   - tools/testing/selftests/bpf/progs/verifier_int_ptr.c
>   - tools/testing/selftests/bpf/progs/verifier_raw_stack.c
>   - tools/testing/selftests/bpf/progs/verifier_var_off.c ]

The verifier.c change is right, but 6.1 still has these tests in the old
test_verifier format under tools/testing/selftests/bpf/verifier/, and
five of them expect a privileged REJECT that this patch turns into an
ACCEPT:

  basic_stack.c: "uninitialized stack1", "uninitialized stack2"
  raw_stack.c:   "raw_stack: no skb_load_bytes"
  var_off.c:     "variable-offset stack read, uninitialized",
                 "indirect variable-offset stack access, min_off < min_initialized"

Could you send a v2 that adapts them the way upstream adapted
verifier_basic_stack.c, verifier_raw_stack.c and verifier_var_off.c, and
corrects the backport note to match?

-- 
Thanks,
Sasha
