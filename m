Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC913B1022
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490411; cv=none; b=nME9HiIuHrVMgWA6BXJMK1vi23jl4xH6wrhl8RzSk8fWaqwbQjJBrbSQ4md24UwvX5yfr8pIpRGZR3icro4tqOdEVn3+9/7NS8aGk9z/xSSN1qB+i5XPMkmDRIF5CnmvqFtJbX/5wi5IjhU/GQySc9/QJRpS/9XC7y5siCcOlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490411; c=relaxed/simple;
	bh=RHReNSiLyV74dvXPfHQPJMZucSaSFQDikQPVKRnsA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U28/ekCEr3tjIbtDo+Q2yvS3rpfkdiYP6jSVqXGJ+2Wjbba5vbr+AO4QYUKyW57tLinrfPMBIZ/07sSNB/b493olmNIu6hICxmKG8PNdAKOjVw4B6TPdp1O6eoQAnLld/qThfTEHIRwJfWmmrc7BwP0KW+VQkl4+lr33FHmfzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYWuYRcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYWuYRcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A19F1F00AC4;
	Fri,  4 Sep 2026 02:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490410;
	bh=Wttf8cZFTKsrJt6zP1zyinPzTPWeuxMZ1N92I2kft2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYWuYRcsUhSMFrqImS5fNCIpLQmK8Z6rB4XusYFOyIdZLvZEB41KfSSb0otKCd9OO
	 2g97yMJBk9YFn8VVgWZldn3hN3dmzoHXefl/AFYeJ2sLMsiNKurhCS178aNmm9b7xp
	 EGJdiJryzxHE7cMYegIakUaRc74SsXxwpfqOliIq/T8j7nHmDD3RqwmZc1l/h5IBgx
	 XVKdIDIUun/5osftLPnqI7qu8NEKGEvYB+Iuw13W/sjzHpiEJVB1yVVXg7fMWL20rx
	 h3c/vGOFvCq7kjKZvU4357P08y7myWajSJ7jflPKkiIwbV+7ysTHiHWvGJlcJI/rlF
	 NMThw6ji9sHKg==
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
Subject: Re: [PATCH 6.6.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 22:53:02 -0400
Message-ID: <20260903-daily-reply-0012-re-pci-hv-irq-retrigger-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903160930.36419-1-namjain@linux.microsoft.com>
References: <20260903160930.36419-1-namjain@linux.microsoft.com>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
