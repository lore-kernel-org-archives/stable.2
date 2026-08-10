Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7DA42668E
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406272; cv=none; b=SCFIybGDIiRm5Zs7cwtQ03x7BGI4ZHVhaPclnw8rsLuA7jfvFiPhgNPX40qeIPtly7M8wl9dPp7dtldqURXCIPKhbEpbhIn7oewCxXFz842lELS/II0d5pZnswu7nazaa7xRVyfWEmRxB6P7XQAoOzrCR0nNu4gUE1oD02kEJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406272; c=relaxed/simple;
	bh=UqkCGesIKq9XVjA+IYaR8FS4MmlNcqakRTpxojk2nCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTt52g5pBZ2vpfW65PwAbprBfkH8Lk/48TS/fkjZO8Bs7hCHD6jAbLEWl5da/JeKAz21OHcKcvyFV6lmrmQbDaZooUEWr7QzFKVwkQB40YTVyEskNLUW/MMq1XDu/Da6eKJ9opckcXBiMFdDs0TSjkY1Ydfel8q5xSdYX4b2nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnOkE6Cj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnOkE6Cj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1FE1F000E9;
	Mon, 10 Aug 2026 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406271;
	bh=vToL2VW3bHJ5D090weSb1V4RFqmf5Ad5zC1C/X9GBAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnOkE6CjL4/udtceDplR52jKXMpBa3R3Emb1uw7iiLP09jAc5WaJqAT/jBEW17RwD
	 9SXu5dGJsQTnnfIoVR6hLroJ7IJsRPOEQVLYTBPytiDKFwcwLrBCVNtp5ga2kfEuDx
	 Q6VUmN7KzXnbAm4ZRAO6k+itP8S+zTxK6Qc9MwXemWz8EdNJbCVMd8QYih1TddaXWu
	 n+2ynv7U8VeaKJNczOaD9L6gVf+Wne5qb0sMFrn0sATFt1xou1GYjBbHtd7RoPJD/L
	 cCl0jx5P+8yRYv6vFl3TaRPrPjquphFOHbvq4yD42MxerNG1SuG90KS6wMrpZAYxSn
	 fyTyDsf7MkuCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
Date: Mon, 10 Aug 2026 19:57:40 -0400
Message-ID: <20260810234738.0001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062208.522577-1-senozhatsky@chromium.org>
References: <20260808062208.522577-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Conflicts:
> 	arch/x86/kvm/mmu/mmu.c
> 	arch/x86/kvm/mmu/paging_tmpl.h

The 6.1 resolution has two problems I think.

The new call sites pass two arguments, but 6.1 declares
is_page_fault_stale(vcpu, fault, mmu_seq) - so I'm not sure why you're not
seeing a build breakage.

Upstream could move the check because direct_page_fault() is shadow-MMU-only
there. On 6.1 it still serves both MMUs and dispatches on is_tdp_mmu_fault, so
relocating the check into the shadow arm leaves kvm_tdp_mmu_map() with no check
and no mmu_invalidate_retry_hva() retry.

-- 
Thanks,
Sasha
