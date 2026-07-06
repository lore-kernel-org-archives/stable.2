Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C42430CC6;
	Mon,  6 Jul 2026 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354796; cv=none; b=kXCyiGZqWH3ZaF7a2gpiQyvJ07Ga8XOS+p9XW6ZRQTytDhTGyXi2lDuOTyc7l07DN/L9CWVJsx93GCpcKPE9tOclgFcPXbhOhcKKQVRhYbchgvHBAWq77KZBJErEbQfQRLhz4vDXgFXmaZKf3CKHLZkhsxnfAuCs7mUS7A2bQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354796; c=relaxed/simple;
	bh=78fhhankv14oGSqYHnz2NT+Tk9f3xYa5kAjCmEehPn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJgmfzeb4BHW2F6OCnRqNQj6NNx+5DhU7eIXXwUGzK++yI2Z+cSeglyjlfsrGa6Tuxall6yPh4fDZtmhn2gKwHTU4py0rg1OHzEypw7NLQVzVq4N32S9caIcCTD1EZQOCJmCulr9YhpY0Gl7YlIGgG+11vsJhePPklidKKgUV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZDwuy93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZDwuy93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E261F00A3D;
	Mon,  6 Jul 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783354795;
	bh=qkeQCDXCe8FgrurW8DLDVZj+1YSS1GZoll7hPEXalKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZDwuy93qzpSMRj4Ucu3W+Ex/p2JCeSFM5Zga7VwZh0v9DxSVnUAR1rF++JY7yGlA
	 x+7Yn6UTjNbWEBFVMGqI9KbUYWsoikGx88ZrwdzwK74Zej141pLbb31dVGEbxYUQvh
	 tqzHDz1CaKRdzRs0vJ+8Zy4dqvcXE7e5JgrKyze+EeNH0eOcoCSmwYHoL8zurEGNz3
	 0hjCjY+eiDn3ddu3oLxOXb4QfkwtjN2UidanIOX0cgVcH9uwLMe+/CtLUglX/42Kxe
	 d52PpUw2z7gpPpB/9iBq6G+XGTwcY2Rv9FRR+R4CR/pNMm/9I6YhoD5afnv506z8rf
	 lXiM6D5EEz1Gg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wgm2y-00000002244-2k4P;
	Mon, 06 Jul 2026 16:19:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
Date: Mon,  6 Jul 2026 17:19:49 +0100
Message-ID: <178335476041.1423186.3105343217982386007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627105105.1005990-1-maz@kernel.org>
References: <20260627105105.1005990-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, pbonzini@redhat.com, will@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 27 Jun 2026 11:51:05 +0100, Marc Zyngier wrote:
> kvm_io_bus_get_dev() returns a device that is only matched by the
> address, and nothing else. This can cause a lifetime issue if
> the matched device is not the expected type, as by the time
> the caller can introspect the object, it might be gone (the srcu
> lock having been dropped).
> 
> Given that there is only a single user of this helper, the simplest
> option is to move the locking responsibility to the caller, which
> can keep the srcu lock held for as long as it wants.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
      commit: 3a07249981629ace483ebbef81ef6b34c2d2afec

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


