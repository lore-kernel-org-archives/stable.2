Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD84B1B4C;
	Thu,  3 Sep 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443973; cv=none; b=R9UBld0YU1rZCAowIoGcyVF8MfxH0M9LV5szUrWBmvh9XJa1XfR6pwGlgCDFnqEQnwsOApY1kYhNPq89WcByjfUlEEnNvZhYtIUoJwOsOvxzuCSK3dn4hRKAZOAxx0cstErrS8Zm8zA+ALHE61og9+lRm5Evf3STx2ldohI6aaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443973; c=relaxed/simple;
	bh=/ias2FmaB+TaEDtNPPJ1rTt0VzGfItJrAvXcbU7Z2rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlCMxyrsTXzI0IOs5Xq69MFi8g92BzPazhT5BS+oZHaUsZxPVuDehc0s51aWNhMywSlS8yvrcpCcAzR4G5ygxQE92CILe9CtCiBN55zZxqAeSNW4T/BOGfHyrYbD4gykNc46F2CxT2nSbY6DatgTPjYa3KWUh5vqJugNSo4MnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnGrS1+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnGrS1+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC191F00A3F;
	Thu,  3 Sep 2026 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443968;
	bh=yuJ09dY19nMU5wcxIHt6wddh7HIKlNAVB137+0NMIxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fnGrS1+MxAIWviV6xD291f8jK61LVrxNBOzdoQxxJGgEIvDxL/FRxPlLWWb/n6ZAT
	 WZ1vOvKwVxf+D7CvaM47JTSA6EZEWeJFfwVh2NZuoZJ7eIbMhOFi3b5XCvYEsW4D2v
	 eUXhqXo/MTaClj+88RFQvkg4aZnOxFlAKE7IVOFtPLZBaOvjiv/Ix4APwnU7CZ1cdu
	 1i6/rgzivjGhSR0qBVO4Dh8qYGh2wguJXbB/lwGGKxSJQKXpVrBocMIoOoJCHIVsbc
	 CS7HRseUb4ItE3OHlwFwnSTfvBWMsImIVFSH3J0koy0QLCKfXK7wVrRx3a2PjXsn2s
	 OutH9UPO4gwPQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Khushit Shah <khushit.shah@nutanix.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: errata: pass REVIDR when matching target implementation CPUs
Date: Thu,  3 Sep 2026 14:59:16 +0100
Message-ID: <178844052241.4162712.13748055327957568318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831105444.4065831-1-khushit.shah@nutanix.com>
References: <20260831105444.4065831-1-khushit.shah@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 10:54:44 +0000, Khushit Shah wrote:
> When target implementation CPUs are provided, is_affected_midr_range()
> accidentally passed the MIDR as both arguments to __is_affected_midr_range(),
> so the REVIDR mask check operated on the wrong register.
> 
> Pass REVIDR as intended.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: errata: pass REVIDR when matching target implementation CPUs
      https://git.kernel.org/arm64/c/5541432e09dc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
