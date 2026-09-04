Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1623B0581
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490413; cv=none; b=RtloBtFy5BysAyCAIYouRMx+NmCbBETEFEQlDQUgh8RiTNCYkoEQLol8kazdtHFeKR2L9aZtuYbMtX7xF6Af9ky3tzg8pgeJEgM38NF2o0MGjAlIM3lF/9k4LtVRPVdmjgB7X+KwaqePezhVbH/h7H4cqsMU+j5JjlmGfgB87rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490413; c=relaxed/simple;
	bh=VW/oZfSkYXWOrzyjbToDQL5oMzORASldI9ZLRAG4yX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0DRCec6p7sGqDGZa6Ptp+bNZjKGDg9jpnFelNouCFmqebP2bGZxtqly7sk3o85JOAx9SNdrwoQYXW3iypcty5CqZqvAUeAjOpTEj6LsSDIMU+kjgyW9tAG5oHJ+tnLj30OneOw6b+buZWGRq7YxXBeYFMS8Y1XYxpO42VPKRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awptRXrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awptRXrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47421F000E9;
	Fri,  4 Sep 2026 02:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490411;
	bh=79hBGJiiQJgifRk9SXrNUfaXIfCllQIlYMuI70OxlhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=awptRXrtBx90nlau/RSQCs1R+wYcSyhlZOHMKG0m+82cm3zlyrrlO4OMRiXsaGF6T
	 UCbCO59eO1xQ5T+gnhM9UwK5x5ckspS2JcClwc86fBJHkuUdBvch0CFuki1+/VNOxf
	 hPKixDMkz0N8xLN7sN3wI/LS2ddbbGV47XelkG7mVEjrY5SPQia2ZeMwOqpQBp1r/O
	 OWpTuPg2t3YERFnCyIQiM5UlRbnjc+SrDzDLFIRGeiGm4nMpVV4Y3Ol/252GEBGDFS
	 kJP8L4aCKsrg5//dVGi4TQyW44JyZEHRqp6YRHbuuudRA2/678j0jr/E1cm8brr/46
	 VZ6yl3KSc3Lag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	gargaditya@linux.microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	shradhagupta@linux.microsoft.com,
	tglx@kernel.org,
	wei.liu@kernel.org,
	namjain@linux.microsoft.com
Subject: Re: [PATCH 6.1.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 22:53:03 -0400
Message-ID: <20260903-daily-reply-0013-re-pci-hv-irq-retrigger-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903161344.64663-1-namjain@linux.microsoft.com>
References: <20260903161344.64663-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback
> for the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent
> on its new target CPU via the parent x86 vector domain.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
