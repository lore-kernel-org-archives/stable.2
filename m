Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711179;
	b=M0GsDHqmzjoIe4QLBb/5vrY6XOO6yELAVOC8KvUCNUZKkmSEoq5dicLZpnioDXLnDErg
	 74t+xOvL67NnZrRzjb0Fd1wCSh71jrDUeILonKLpnkYvGqA9KHMtJ3hPV3+bQHWD28dnG
	 VMP4NN/0X2mRs9wC6277k+pLXpHRa9y40xRIer1nl64GzRAraqnNz0N2Sns2iM/cBIpQK
	 lC3K4QN922nWfos3+4N4QyDye9pCZjwo7m8PbFYBmumq7TOyjbbVChkQ2ncF4RXWgBzUn
	 pTVN1HvlwfOOSGbRJQSOrhV4vqSOIIqtEFi9Lk35s/sW+ENVRhggl7ilL4LnN+2Aepw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711179;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned;
	bh=BTkNktWDKcUZl7Dn/5iy3nlFeUBooGmydxvaPYQQPMs=;
	b=izlH7uxQnqMDqe7P8SdUt/nDBCplNc0PYTcy3rVqO2+KFnX0qqBPQyaMCMDRW8/P5mZ8
	 42DuMd/61oAwPuRLqEyZBhXuz/tNQaj8ZEcSBSOKOirPGd0+Yl5Fn++Q9BNErp7y4MtRJ
	 PQT2UKtDCZuaQJKdwW4R8W0s9a/iC0ofaVHO/AuR9LCZ3XukoIi3f3gyeWFpbbKDHSZ3G
	 TzZqq7CiqQ3hzBbN+49o3qfy+KxcqD81mb+zeqb3HSo20LdOTBaacOGv7PodhWBUM63Hq
	 nzSa+f6yq9nbWL7jR1/ChZWXGPgbfO/uSMJHfm9egv4wY2kOaWXIlvXjzE+gLhHa0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnAkAzcz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24B606A330;
	Tue,  3 Nov 2026 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnAkAzcz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF3B1F00A17;
	Tue,  3 Nov 2026 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711179;
	bh=BTkNktWDKcUZl7Dn/5iy3nlFeUBooGmydxvaPYQQPMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MnAkAzczNJRLyDpmgrGNenNN/k+Ap0dBRU//KHOMjsporYHUex06eOWSqy3oa/AWQ
	 rTyYhYyCNVNGVvI0Evkt206+MF4OfVUGcu1A61j1V678cDND8wqUhM5AfnzThslU3I
	 Y0LTEstlyRvP7S6gbmLx9Y6ltuxzl+HrjQ1Gscpa333Vu8+WIlpcaIjTiyfWCfSuIL
	 jBBoQpLWkn+vAJrQ3QRSUbEClSpl5YLLHKdptUyLp0U2jzX8s/KIYUsfG7PDGlbn3b
	 rDi96fKMm+xgqfAT8hpmACd1S9TP1o5IgmBCPATyzoOmi0shA44d1k4Web+9pSfcs0
	 maJSzGExxYBag==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xOEDQ-0000000ATWs-31XY;
	Tue, 03 Nov 2026 13:06:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
	will@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2] KVM: arm64: Don't livelock when AT can't resolve a fault IPA
Date: Tue,  3 Nov 2026 13:05:27 +0000
Message-ID: <179371111288.2844725.13597429882644149907.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103114411.3642140-2-ardb+git@google.com>
References: <20261103114411.3642140-2-ardb+git@google.com>
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
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, ardb+git@google.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, ardb@kernel.org, stable@vger.kernel.org, fuad.tabba@linux.dev, oupton@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 03 Nov 2026 12:44:12 +0100, Ard Biesheuvel wrote:
> When a stage-2 permission fault doesn't report its IPA in HPFAR_EL2,
> __get_fault_info() recovers it with an AT S1E1R/S1E1A on FAR_EL2. If that
> fails, kvm_hyp_handle_memory_fault() goes straight back to the guest, on
> the assumption that the replayed access will either succeed or take a
> fault that the slow path can handle.
> 
> That assumption doesn't hold when the AT fails because its stage-1 walk
> takes a stage-2 fault on one of the guest's page-table pages, while the
> guest still holds a cached translation for the faulting VA. The guest
> doesn't walk its page tables, so it never takes the S1PTW fault that
> would let the slow path fix things up. It takes the same permission fault
> again, the AT fails again, and the vCPU livelocks in the world switch.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Don't livelock when AT can't resolve a fault IPA
      commit: 36b225a9b1c41a71d80e2cc17b3f0fcde4bd598e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


