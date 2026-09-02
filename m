Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CB4AD7CC
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387288; cv=none; b=W0v4hluhQZe3Cm+iZHZ8VOE8+5uJU3HySSPrMX2h8eVpRIgmBCXokdiaIo7Gs5rEm5G7iPt0CKTsHhnZcvHn/Cwuru2JGdt2r3g6/ktm/gEFgayzrMLbtqRmRYLFsC/qBCQps5ldi7onA1FdkQvR8evHgVJTfqNEK4gADAi5KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387288; c=relaxed/simple;
	bh=eC1xMihXJacbADdTsNPyQhv8b62sbQgH5llKa+4WRDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEeqfLbqJQcW6ZjVuWscy2kjo14oUsJs+8G/FzrSn0M/abgsezTDlWsrYY01EixBPA6Puse9YmXc16stLJJohqhLwwCvPiJVG3P6bgG5ovItNScVB/2RMLeAIOlLcjymW5Z4aYDsGa3x4HApx6myl52q6FbmEuKLOKetFlh8Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQajis1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQajis1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF01F000E9;
	Wed,  2 Sep 2026 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387281;
	bh=+iP3SmJ/UBYuyQsQhF4r+bgzJVlC3zXQGOv5RNlANdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQajis1PuSm6gI/pUCrRy054gCwwviAkM3T6NJU/PpcBL4zmNwcGBjgob8q8m8sww
	 7gAuRoOixjcDfY1kb/qvJ30zkU5GdeOLFu8NXp6LMdyZj3ceFatXIZ2LElW0+EjUEV
	 K6Zy2BT+7wQVC0AHcq5BHd5tKRx437NzdMVjKfOChg3N+M8ZnoRy7LKtnbL/o2NtrZ
	 yV4h9ekmGdi68KPb/4JSjt/1tEEcqsVOVpz7n6iZfB4miAJOVu2Z50S90U5C4g/Imx
	 Dfp/KtwMwHNpU1UNIc9XzlQyC3zUkSnJ66oINKk/zWRb1lIUprZIwY1zFnf1HFn4dt
	 JeMcTSFt/oKtw==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y 2/3] KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
Date: Wed,  2 Sep 2026 18:14:16 -0400
Message-ID: <20260902-daily-reply-0017-kvm-sev-psc-nak-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apchDJDrXemR0paW@google.com>
References: <2026083135-thud-surplus-53de@gregkh> <20260831211010.1798943-1-sashal@kernel.org> <20260831211010.1798943-2-sashal@kernel.org> <apchDJDrXemR0paW@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> NAK.
>
> As the first sentence says, grabbing 00b9744a3688 ("KVM: SEV: Add an
> anonymous "psc" struct to track current PSC metadata") only requires
> handling a superficial syntactic conflict. This mixes in pieces of
> d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing
> gmem page is zapped"), and *that* is the commit that's by far the most
> interesting. I.e. pretty much all of this is leading up to that commit,
> not these intermediate commits.

Yes, this is a complex one :(

How do you see this series then? it's a lot to backport, but if you're okay
with it...

-- 
Thanks,
Sasha
