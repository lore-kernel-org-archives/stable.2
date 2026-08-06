Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80186485CD6
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038607; cv=none; b=RZXjepcG77vWH9d0LE0uHkHTZM1VeiNa2sVdr/6HxXtL5p2b7oy/UU35diYbELrjioMqucU5KDz92dbvjs8mVU4dMJv1e8H3drQrZXAbV3xvY/vKit9SsbgxsQ5oGFmMkx1T5uIlH49SgZKmpt7OW2N0jNtKKJbkJfdQwCLKVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038607; c=relaxed/simple;
	bh=bJfWP2ZinNdFUPR1tMVLKnFLxlY2Chat1BXwMoAHbf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqNvzU3F69aWbN8fF13fLl5B7OhcWGgEvgUdyoS2CaF68xGze/gEWwAHfWGQjltjc8FAb6oDCkapP9qeBe/tr16IETEk3NETR7/P+b8Tr4x9nLdSR+qJOfIUcVHmcurbtQGjY4oQAqusv5+aKwE3uUG+3Be5JC2fcxRaOxqE9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My+HKUzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My+HKUzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9870E1F00ADB;
	Thu,  6 Aug 2026 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038602;
	bh=XBBdZX7jJWjG+luB4KIf4buM/vzSOTM8r0q35FpCFoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=My+HKUzSA5sT9dKKjMtOut1drB/VEfzS+DlZL2AOq+5ZglXBc8GPNS88BVji7TyBJ
	 U18JDPVKHazsSxgjTjxmacG8lnG32Pa3TW5+pGWCT4jcpvLTNNuMxQRdrYf4PPMjGN
	 4hcY9YTAKkAHCcVECrfPQelAEHrGjfgyKIgkz7VwqNLhf2LEllYsj+3OuuhqPZjVqx
	 y7fj1wiNi+6O1UWG0/oRXVfKvyMhzayC/UT0lvds26RdOQmuvSJKiIlk6F18vPyrvC
	 4Q32z7Rz6gpWXUhXjYCGsdo+W+n8UCwfaf2bStPMiKSsgIdo6rReMtZpUw7g2z2TAw
	 q72QLD3z2jGNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH 5.15.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 13:49:46 -0400
Message-ID: <20260806131008.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806021816.3224971-1-junjie.cao@intel.com>
References: <2026080541-awning-suction-d5bc@gregkh> <20260806021816.3224971-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 10:18:16AM +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
