Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1464248BB;
	Thu, 13 Aug 2026 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603791; cv=none; b=l1G0CX6/te1J+kdaDEyPHfoosu54T9yEdCILzo6nJFkciwfKSjcNYCJFI3JrIxfcBDCGGBJPk4lc6opVFliSDe3Nr8MjJQmC8ZVuC0E+N/3uLm938WR6wJmefsefly53Bb37BmCI1XTZlPavEvKhxd1HoPalIE2TvVitbUuVVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603791; c=relaxed/simple;
	bh=3vCa59xPmq+o8a3ImwWmy0hRtzRP8wVxUOzKnXAbJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKGYGMouLGVZ6gZHYUOe3crItb1YWd+IUawlD3uCjDBjcWKkitipNDtTMruAvKvCv9BJ3zmierwl5Gk1bi/WsH7FO/91hfCZGm9kZpi+XrL2dm3IZ9HZz1wBTkt/BQEfxDZmqXUaHuKAtXZ6+p23C+ZD00vjCCxAxWOZJ/jLSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6LWYWU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6LWYWU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AD71F00ACF;
	Thu, 13 Aug 2026 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603789;
	bh=LYDW+ngw5qRURlwX89PvvWJBIbVdW4n1IuPbDPKQw08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6LWYWU+mWJ/If0/MpTS3wczw7IetQ4Xv2cKzyEVUbexBH+NPMYJW0O1yBiBkP5+H
	 nPIIn1j9s0vvCg3JePdyx8+hER1RYRLUIL6JemlzVZyxjsgWYQU8yrZfBNizmNRQ/w
	 IaaJsGk4vejpA7Q8uXsVKPlVfcAAmbMBq3bwi8cx9f3qPVucqtfJ/dZE2w5dNTfHFC
	 NPdxNan+TgHT/LW0aelb6bHzquuR+XJJLN/59tmNflDvqIFIIUdWC+3wl+OOCPOpKm
	 JzDl03iGXahQNLHNECBPbW4pqq5aNF3k6SlN1kHBGOqsNMVVikMLBq02HgJkNzjuDq
	 O6Gag3y1wmUlg==
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: GICv2: Don't WARN on out-of-range GICV_DIR INTID
Date: Wed, 12 Aug 2026 23:49:43 -0700
Message-ID: <178660378177.666424.79190290228047804.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726174803.5880-1-kmehltretter@gmail.com>
References: <20260726174803.5880-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 19:48:03 +0200, Karl Mehltretter wrote:
> vgic_v2_deactivate() passes the INTID a guest wrote to GICV_DIR straight
> to vgic_get_vcpu_irq(), and treats a failed lookup as a "can't happen"
> condition with WARN_ON_ONCE().
> 
> The guest can make it happen at will, though: for any INTID outside of
> the implemented SGI, PPI and SPI ranges the lookup returns NULL, since
> GICv2 has no LPIs. A guest running with EOImode==1 writing such an INTID
> to GICV_DIR triggers the WARN, and panics hosts running with
> panic_on_warn.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: GICv2: Don't WARN on out-of-range GICV_DIR INTID
      https://git.kernel.org/kvmarm/kvmarm/c/c6d9c8ac6521

--
Best,
Oliver
