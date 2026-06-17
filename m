Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102263EFFCA;
	Wed, 17 Jun 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697073; cv=none; b=UWH7NB+LiUOP2vh76DbtGR4q8jOTAemdfzEfYolX69wWPpaCSIjTCOWwTkxFf7d3QIb4dzyI/D3aM3g1xLAUrWo4e1HhLIkRIFaUFzrBmbhBGUn2RXZ6H52IX4EzLduNkMlDJGQNdZI/9gR7bHY57HLFqLSIceoKSa3UuY19SJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697073; c=relaxed/simple;
	bh=6sW+7YnMJv5+cqZGmyMQkreGbhXyeXdqLP6+7n6/DHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/u3CqGoml16z6v+XwWI6o0+5nz8JtC13NWScqQlejZdqRTRk1sKsZPoTidEUg3fmDK2MU2/M8AaK57EFWPlHUmoBPOfA0cGjtPfmq4acToEteDKpIw1/Z1lA9gjUIZjqVDudI6ybMQL/zFbxRfKPJseE2QAZOe4AwaeHoGNMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EglIvT3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EglIvT3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E0E1F00A3E;
	Wed, 17 Jun 2026 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697072;
	bh=C9EGIq2jnGzJg6EdnET9pfuV4r6/vPa6svq/9XBMvTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EglIvT3Pjsru3BQXu5uyKZYxgggtCrsrNPWIkdUe6C2Pk182xRTbM1DpDs2eCb3LZ
	 whGMHOfPFy+XOt19yGPnrnUkrMHNvCDDLeawdCX4HXyF/0xxJiOZzmmBXPeBK4WVRZ
	 Aqy15e2VuybcjXIN0T64mBCtfVCQYtgxRHCxXWw/dLwIvJRioERZPnR5HyeZBLygZR
	 3DVYpAkhFd+QUDjfgA9cE9XyeBsD9atLm2xp9ND0cchc2HyW3YgmlPnJB1QukgQ8Ji
	 XDI+8jPxCwWF/7wKAH2403AldF5LBMqTp1WVb7rAy0ova7SlqA1DNMbxlxBYxZCZfT
	 kCv1cOrJXvRxA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wZonW-0000000DfJO-3s1b;
	Wed, 17 Jun 2026 11:51:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
Date: Wed, 17 Jun 2026 12:51:08 +0100
Message-ID: <178169701882.3049015.10605549328933029647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615051324.830045-1-oupton@kernel.org>
References: <20260615051324.830045-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sun, 14 Jun 2026 22:13:24 -0700, Oliver Upton wrote:
> It is entirely possible for a guest to write to the ZCR_EL2 sysreg alias
> while in a nested context, as it is expected if FEAT_NV2 is advertised
> to the L1 hypervisor.
> 
> Get rid of the bogus WARN which, since the hyp vectors were installed at
> this point, has the effect of a hyp_panic...
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
      commit: 9f1667098c6ae7ec81a9a56859cfdacb822aa0d0

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


