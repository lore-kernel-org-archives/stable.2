Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DE312836;
	Wed, 17 Jun 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697064; cv=none; b=YmjMQtNcCbVdU4+iQXSE9tk9sPy3ww6ibchRBBj3eJ90ZiRP7gdtDPHz+4FiWgK6lcuxk20NtkeYaB5vCeXEkNAp2rUojOIUmrxXD3u8Yg0G5UTuc2f7mEXW379I8qj2egiDpC/zyxk+xr6zfU9SMuu1r8P+zW+veOhgDoVIxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697064; c=relaxed/simple;
	bh=QDoKguxzKFFuGIB6v5JbRH4r3pRjA8d7GLIQh8BwtXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw/3qzKssVbc+2rrYU3TZyPwEP6HlkflcH6opojMumQTkXrQ2jImUJw6Mrr8/AhUNQXlp/WB47C3UgCLxmj8OcagtryFpp+3c5UrPffKdom1Kd5xGx756c4FVrYYB69MvBl+NC2z/813T2Sa0oZK6pi9uDFqh/R9eN/wtkI7Jrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3tjBblE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3tjBblE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653B1F00A3A;
	Wed, 17 Jun 2026 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697063;
	bh=AIlauNyUqgAYjMoNz0VK8efi2k8dTc5G2grZpTKqCsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3tjBblEtEBWrJMZtXOZq2OKEyXK/6nMUJ/HsDpmrAT3InSdygNgat510MjCwYweH
	 Hu5qY6RVDKvygbfvZDQ7EWKlg9V0RJzCkaHjOZxK1a2itOTGAFGwSHWoWp7kVL5OAf
	 8V5/ce2v17iUBkFRMKR8av+iwvMnMWZ7qGknnh8lvQbNPCfwVW1+yFP4y7wblXYwfL
	 VI1MLJbp1+XagZNvrSh0sNZQr8lf/hsBh0Wht7rq4HR8YnH//kKph31ouOvnJaHqZq
	 sbhTLFWldaDco2W4ra4kwcUp0+42iuJk/oXZ3ZSWUWLLAI6CTTHjUEnombFvaro9jr
	 1mGWzPcvNMKgQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wZonN-0000000DfJ8-0vg7;
	Wed, 17 Jun 2026 11:51:01 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Xuanqing Shi <shixuanqing.11@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
Date: Wed, 17 Jun 2026 12:50:49 +0100
Message-ID: <178169701881.3049015.16397230325847247864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617040820.2194831-2-bestswngs@gmail.com>
References: <20260617040820.2194831-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@kernel.org, catalin.marinas@arm.com, will@kernel.org, bestswngs@gmail.com, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, kuba@kernel.org, akpm@linux-foundation.org, hverkuil+cisco@kernel.org, mark.rutland@arm.com, kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, wangzhong.c0ss4ck@bytedance.com, shixuanqing.11@bytedance.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 17 Jun 2026 12:08:21 +0800, Weiming Shi wrote:
> kvm_hyp_handle_mops() resets the single-step state machine as part of
> rewinding state for a MOPS exception by modifying vcpu_cpsr() and
> writing the result directly into hardware.
> 
> In the case of nested virtualization, vcpu_cpsr() is a synthetic value
> such that the rest of KVM can deal with vEL2 cleanly. That means the
> value requires translation before being written into hardware, which is
> unfortunately missing from the MOPS handler.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
      commit: ff1022c3de46753eb7eba2f6efd990569e66ff95

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


