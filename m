Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C493AEF2D;
	Fri, 26 Jun 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496509; cv=none; b=HHgp8o3DLURRaQx1kno59X3h4aO6f5GaLKI7T0bMouJTkVfHafTPtPNYQS85OzI2sARDygAVLwd57J2J1IsvfZ/Ic/MmGc9CJ04WjKmg6mJSQyZrsFaTeWMOdaiMcjxzGBZolfW8xe1oRfVcis25AuRc9btb4TKuiqBnb/OUzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496509; c=relaxed/simple;
	bh=Kv+AeyV1o/K19utKGmCar9oV/XRnd8Bj3IWkpmGX57I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPeSea+vhEtGC9HQO7/RW1TbE2LcBaojbDfjEuX/OKVfbOdBfr2ohnygccgjPlqeyMZ2NgfHJ8TjJDcCmEv02/jyZAbilUiAi8Uc639rz3LCRkA2vJ826QCP9pOCefZ2JU+zmgX5LBqHR5Av2SLbvi18X1zv9zpr7+6CcH4soAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls7bAW2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls7bAW2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77C61F00A3E;
	Fri, 26 Jun 2026 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496507;
	bh=LLfGl8KvfmN7SkY8TxRU8Dpw+AxxkEIbDQBH/XUEaBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ls7bAW2+SLJKcDnx2UwcAwvU1OBweyts7OhBBUDU8y8yt34jC7igPSmqog9Q/gg6V
	 d8uqEwVXPHpcvNdMu6XQBxWOO0M34/d1bGJzHUtOfbIYMJH8r1CTD31g9gdPN/kv8X
	 iIyOPEbwTWCiox8yONVdTv+Ii9Gr1yY06VXJiyYsMzReHrXk5bnEID1eXOklFcfAja
	 mbRVqxzaFbwFfFRab9rZd2vt7pQfTQ3qSZOJNj7GZftEcjAjSN6bLbSyceUDduWtbs
	 UOpn+Ac/z+cxtpBcD9zUs3SKLie7OxdaKFcGuwwYY6bl96K+WXXlMI6aLBhIrvzaj8
	 7DqzlZwpcee+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Ben Gardon <bgardon@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are available when allocating roots
Date: Fri, 26 Jun 2026 13:54:33 -0400
Message-ID: <stable-reply-item009-kvm-510-p4-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112634.1778506-5-pbonzini@redhat.com>
References: <20260626112634.1778506-5-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are available when allocating roots

On 5.10 mmu_lock is still a spinlock. Hoisting it into kvm_mmu_load() means
mmu_alloc_shadow_roots() -> mmu->get_pdptr() -> kvm_vcpu_read_guest_page()
can sleep under the spinlock on the nested-SVM PAE path. The fix for that,
4a38162ee9f1 ("KVM: MMU: load PDPTRs outside mmu_lock"), isn't in the series.

Do we need that one too?

-- 
Thanks,
Sasha
