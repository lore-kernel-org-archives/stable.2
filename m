Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4F43B489
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038608; cv=none; b=LL3LwpMZmAx8Jbb7n7LKRFqsspLCJZ3KHiru0wY5KouvQrqXmiZaEeiGpzvgBm09C/YI6XLHcUqBs/8q1/AXlaVTXmTCGBWeAGmXsZfc6uaFv1G89Ulfq8lUomB7+aCskVnY9q3IaLGqTnruCkIrhpg89Gp/OB9AGb6YQqR8WM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038608; c=relaxed/simple;
	bh=RGn/O5O9z0iJrvduTfBykB7xyevjpfoc/seUpm4m2pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRXH6Yk3Y/uu1SHMUpbNnjQjdn9daX14LXhJmk5bD8mVh5nbnYmsrqHsPQTs1hQCKb8xRjM5NyQQxjZ9pruYoorq/B7BWU9NX4XcaCa8rJZNhUxepMl0AWrOWZfVBUnuYo7A+OZl/qZozHjco6DHCDFXQIuT5CFWulG1VUYXSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/4txNQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/4txNQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3531F00A3A;
	Thu,  6 Aug 2026 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038601;
	bh=a6OFRrFFlkTNdvk035shFcFKve1RTDxNvTFa75cOlsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/4txNQUKK8GfVwoQBEaJ2mQPuipsQ9ARwQBHl7tFn8ZUKPwZR7gDfKIbavycrN9O
	 oMsyTUbE4Vj4yBBFapvh1sy+CgFYSe2z+ubaqZmd/nEmc9JLk/L/gHiNIXmOysVrKQ
	 VzIPzLGLKGdUoKvD3znR8nUt/qpFBdVtp2fjf6CjZ4lQ+3bUunxyOrREHt1HqXfsfh
	 PD+LRURTvnr7isUzFw7jrH4/JknNiD+UR6VU+IfO+AZA4vRbuYfZrYn6XU7ErDSCt8
	 KcxTu3RTy1WnC1rwadcN1sYlVFve7jr6fr5LM1GNYJQt/tl7+eu0FwUWsDdtQVfBxZ
	 C9zk9KKVNx++Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH 6.1.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 13:49:45 -0400
Message-ID: <20260806131007.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806021846.3225202-1-junjie.cao@intel.com>
References: <2026080540-ventricle-uncross-946f@gregkh> <20260806021846.3225202-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 10:18:46AM +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
