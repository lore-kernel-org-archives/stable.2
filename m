Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40F486B9A
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038605; cv=none; b=u3AAt1m40Iv+9BDSjfO0cZGu3EjCYFrEIHoPbLbAXN+/YpsVheDLK9+e+iWzfTjqHFGpgPqO/lsfTFEvSv/fusG1Y/mLKTIj4deoM7X8TEKC1W9xeACXLXQH4pb1Bmiurpf0qS3s0auJzA9svKXabe+XiAIyp5+1N+Knb1ooQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038605; c=relaxed/simple;
	bh=2wciRBqi3q1cUn1/CHuKZsD2jtFQDABfw+DY2x3gqxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjRGcHLbuTphj3AxXIB5nVGU0VmQ6Ex1ayNCfhaTPvEHFD309JTBmGBMuHf6w7+IolvaFtPFwjFUkvydBjyDoT2vINiO3ldZ61jpa67swupDlwHBO2z9cba7bIkXS6Mx2TXVzC/jBxP40iwb9r8dtavNssOCm4nVaRiRq4wDcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrKB3iZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrKB3iZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD031F00A3E;
	Thu,  6 Aug 2026 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038599;
	bh=nGU2crTeym/8OBx1erlvTT6YM0ILPhX9Odz0eUiDzeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jrKB3iZ0W7XjzQ8x6TqPElOzZnQU8Z/NRb+vlq5dKhViOyydl78kiZ31IzDTNe6/a
	 D9l1bChymrFmivPFwOOwJiS3worq3GuGFP+seN4OPG7YSw0LALu4SP2dQRJfFggKt1
	 ZEn2GOMfsD5Sm3DOHTuc7aU7axwIZDJVHZR05i5Ntvz7mPqwmcVpqc76K6J66Uf7cc
	 vLEUb8L1FBsrX74dRYRZwFskiXoGL7oUji7Z/cmNTAdvL9UVmkrfQ/AoK7gNpZVwP+
	 tIsfL8wfxafWdQkEy3MDBqzP54KBG7dP5raE/9lQcc90BPSBbgvzyzL+cBNl9NhIxD
	 AWJlkCyS0VQMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH 6.12.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 13:49:43 -0400
Message-ID: <20260806131005.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806022031.3226009-1-junjie.cao@intel.com>
References: <2026080539-hurry-caption-f45e@gregkh> <20260806022031.3226009-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 10:20:31AM +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
