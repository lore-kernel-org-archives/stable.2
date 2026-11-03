Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711183;
	b=QmzsW5UJ3CqCwgl52VXDAH7Xu1Mqku+IoEmtNtfc4+vrxIRK9SwTHGlwkULkn4ni0WsD
	 nvLr0UAPiA9KHXow34KKLz5RuW/er4nwYBEwE4MGx0746qRY0gOWrpBPLgElISpr8PqSV
	 M6yV4QtfNctlQ3qvZgGqd5fOuC8I38sDU/oIIbTQCmI7bgWmwh85eMFVE1Psjomft++bP
	 VN27+2L96yI8thlb7exdE/Sz5uMbBjf2LV4denDKXZbx2WMaAOFJ/my7yRkzC2TayqnAK
	 kkRH5h9HW8iDZkqOHoHx4vfGS8kFc2WD/2474RrahuHlNE2sHmCEvjtOyQfjYu/zs3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711183;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned;
	bh=DqbjqLnGmLvGgfiPehVeEkfrGreI3m7/ZDiq2XZUR3M=;
	b=b1SfWBieDpYETZOxeNElxHsJfDbh4BxPYQKB/Goft1XbgC26XMAqUp1le9aDAKd+ysj4
	 BvZrzvQc/6BCV27CHYwmTJcl1L7gev7dSBbPxdkmoegRAPrMhv8TEWopC9v6cmD99x/lI
	 0O8y8qHp0au/xOOfBx0liRobm7SdFVgZrnEA1wYyih5MIPGf3XJWK3+h6tivBwGlea83Z
	 paqjPyV8f7B5RbFfwq9LiVcZ15lIIkwanZMgKzSrLoLGY8XTrcYFlAh1BSYw5cUcdXAOC
	 oeYsGsRAUstQRgzKyXHcDtNElBH5S8/5DMNiV5w3qZ5pbzqS0vsU6aS9hwD3/G29Vzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4SNtPoy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48849606EE97;
	Tue,  3 Nov 2026 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4SNtPoy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287611F00A1C;
	Tue,  3 Nov 2026 13:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711183;
	bh=DqbjqLnGmLvGgfiPehVeEkfrGreI3m7/ZDiq2XZUR3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4SNtPoyN6FGl+0CJmHEpwZcGlZsOOMyv547R5O7TCMbgz6kt0FRVc2VJMVW6/amE
	 BdRn8xj9+myFNDCEZrEfCQGrpGYJfccIsUfUoyRQCU2aVCtXdjXhs7Z8PRDQx96cbS
	 tsZUwxBn75mx+M0IIg0yeiVlj+AgiY8GoTIPtDcdZ4saWvxC8t1YB40VmbMevqAAi8
	 B0hUyYPY0VqvrQqJ8uTwLDKu2PetOouHQPUyj2J3E1GmKHxLJu0I3JHrAt3tmU2k8E
	 C7O4cMZ3chBTJPPjeV51SuSC48mNSiWoruY4hsrycvQE7vcw82xNiaRVcRxbR1VUtg
	 Zzgr8UmQsy/zA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xOEDV-0000000ATWs-1vix;
	Tue, 03 Nov 2026 13:06:21 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>,
	Xuheng Li <xuheng@cs.columbia.edu>
Cc: Quentin Perret <qperret@google.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Add an ISB after mapping a hyp fixmap slot
Date: Tue,  3 Nov 2026 13:05:45 +0000
Message-ID: <179371111261.2844725.5233996061235125955.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028-fixmap-isb-v1-1-6c9f0f9cb810@cs.columbia.edu>
References: <20261028-fixmap-isb-v1-1-6c9f0f9cb810@cs.columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@kernel.org, xuheng@cs.columbia.edu, qperret@google.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, fuad.tabba@linux.dev, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 28 Oct 2026 23:02:10 +0000, Xuheng Li wrote:
> fixmap_map_slot() installs a valid PTE for the CPU's fixmap slot (or
> the fixblock slot) and issues a DSB ISHST before returning the slot's
> VA, which the caller then accesses.  It does not issue an ISB.
> 
> The DSB guarantees that the PTE write has completed, but without a
> context synchronization event the architecture does not guarantee that
> a later access on the same CPU uses the new entry: its translation may
> have been performed speculatively while the slot was still invalid, in
> which case the access takes a translation fault.  At EL2 that fault
> ends in hyp_panic().  The clear side, fixmap_clear_slot(), already ends
> with an ISB.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Add an ISB after mapping a hyp fixmap slot
      commit: 0e24f9db2ebedc271add0c5dbf2821b8f8a0ab06

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


