Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3253CFF4C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701629; cv=none; b=Hrama89Yx5YcGlT1oSQkwhIecf7JRu3375vHyKZCjDrYm1mSp76vupOSvCa+zHUeOUbtY9eynHUn2eetTfGY8EHdPBMwa522tfwy1UD7mbJzHR/FoFOtC6/FIYlxt4m6yVvts5M0S9UfER+93AXdym7pBpAsjvb0aNyvzoRLC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701629; c=relaxed/simple;
	bh=qUi+54K6k7c5aupaRPmdgoDYw4Z6reS3AgEZEYrubN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWoqW3g7XkesMEys3pVSov1lcXCGktLCmazg/LOQR/fMELZGYhbeKKfJCQmKMCB2VXciDPXMkqQxq+IAeCNvCFecFzTgXNuvJ+u3MENtxNksOj45pr/tKmpTKP3DCEEhqD3oyJcqnxgwqf9HTsycMiD0vfh8LFsU4ICeCjAa8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO02+zJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO02+zJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AED1F00A3D;
	Sun,  6 Sep 2026 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701625;
	bh=AlonPHcmALa9V+fkHw3NNoVZDm2PX6da4/TcDeP2K7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hO02+zJlKFHcGxU1elLLRggG9UA2DFuSUUslsmil4nqT0H5IDIaYtFUfQPnRFn2gS
	 GY98KDIfWgV4WdcbJA1R2jhGVqvmqC9hI4+wjwqYQDVSokYGwyv6BGOHqOk7HVVqEb
	 sxPYdqoQ8ZhqSp/PJllwp2VB23Wn+zkxstb8/QBGTSXt6zSp/CfnkgSlhgYBopBA4Y
	 Hks3Xn17sq8+JWe6LGDi0Mb64T9I6V2E9ElmdcC55WB0x0wC/GUMixFi4mt1Cqkin4
	 k8s9WK+Fvodvs9o8fYO0U8n21sqCaAvp/7lPxKzq74OKhxyKVns/mIp8GXfue1SZD8
	 1/vhx38Fvokgw==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y 2/3] KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
Date: Sun,  6 Sep 2026 09:32:51 -0400
Message-ID: <2026-09-05-daily-reply-0021-kvm-sev-psc-chain-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apoPcpTa7Qy2isaR@google.com>
References: <apoPcpTa7Qy2isaR@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Ya, backport the whole thing up through d1a3c2162334.  It's a lot of
> patches, but IMO the risk of breaking something by trying to trim down
> the backport is significantly higher than

Tried exactly that on 6.12.y. 9 of the 10 commits (through 42a39ad5d592
onward) landed clean, plus one extra prerequisite you didn't list,
d6c840adfebc ("KVM: x86/mmu: Rename .private_max_mapping_level() to
.gmem_max_mapping_level()") built clean on x86_64 and aarch64.

The actual fix, d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA
if its backing gmem page is zapped"), doesn't land on top of that
though: even with the rename in place it conflicts in kvm-x86-ops.h,
kvm_host.h, sev.c and svm.h, and resolving it means introducing the new
CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE plumbing rather than a minor
context fixup.

-- 
Thanks,
Sasha
