Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469F33B6CC;
	Mon, 22 Jun 2026 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158068; cv=none; b=fu9DyVA2S8dKzlOoVcExWJNAeYr/bFlMTIAI97lL/WLn3wyVkSiZj4O3NQRb2B4p1/8ovTJBKck0jm4d0VPid4I2By3PAKkGvsuDjuLInKP6JghgcZgrbr9U/cqLpx+/OEeW6roZEhzRFHPHt/zfIgUHqZSmsJQIHsdcuGNhQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158068; c=relaxed/simple;
	bh=Gq54cYfZjzANFfqKQHm9HT2j6bO61C1Ey8Fce5L/oNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKzG7qKj77cxb/m1L+h8QgLr1tyEpGYexFQGEcjaANdsRTq/MOyBFBzcWOPGL79xVOh9B/bA8JELbbbUv5vPfdgs8y3jH4KjC/jwOlNusswvUxmL9ZVpnuabnAtMrGtcen0RTYQqH6zm9fHs8uKGtvKArmrB+fo1dkw3gJahiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA9p9FO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA9p9FO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00221F00ACA;
	Mon, 22 Jun 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158067;
	bh=MugcRcePTkTCHzE3VIPFTPMg/aw+YMki7rvnvVbaIQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lA9p9FO20UnhYLOvCjvDpBvabEIjGAhOs9GewX4LuUQ50NJxRBtO9AtjrW3cNS/3H
	 UvvSkAd2vNuClb+BeOwkxyRD2UnrQ3OKmIk7hD8X3GGkz39XrdxMnGo/RCILbtEk/t
	 0/txiS28l04bhDkGz9sk06ynZx/etIF6PsJFW3cakM7STEAsQwP1qrv8itH7k7FC1U
	 WvuAJW91ZP4G+WbEGl/2w9OT/FlPX8+metLJqJBImIlC1RvxlSbrkG+MVHFTqnwSTp
	 Qt8Mc9y5ghS5fwifnMvtAa0Rf1PHokb6JUYYy2jyKPF+AW3xsf+LbVaqbJ/Xww+O7Q
	 wfQ/NNtt5rmKA==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Kohler <jon@nutanix.com>,
	"jonmkohler@gmail.com" <jonmkohler@gmail.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Chao Gao <chao.gao@intel.com>,
	Gulshan Gabel <gulshan.gabel@nutanix.com>
Subject: Re: [PATCH 6.6.y] KVM: VMX: Update SVI during runtime APICv activation
Date: Mon, 22 Jun 2026 15:54:18 -0400
Message-ID: <20260622152404.0005.kvmvmxsvi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622100324.65288-1-gulshan.gabel@nutanix.com>
References: <20260622100324.65288-1-gulshan.gabel@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 10:03:43AM +0000, Gulshan Gabel wrote:
> [PATCH 6.6.y] KVM: VMX: Update SVI during runtime APICv activation

Queued for 6.6, thanks!

-- 
Thanks,
Sasha
