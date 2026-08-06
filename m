Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051A388E61
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038608; cv=none; b=aAlJa6/QdTJmfEGTkEMSj54TR79T1tvMe0xvtQXHNT0FWQVdwag2BTRy7OTJQv7Jzc/W0g4kKTI3kuO0TOmHwHfQ5vDEeaIwgfP2O74xJERc8gkc1dmuzeDzJb4DHsD5stuIW+VUGHWGF6XxxRWv6lfsCC0/62L3vn5PsF3yEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038608; c=relaxed/simple;
	bh=LpR+R8ui2ls9esx+f64pdNRgy685l8YZ6AITLwqqriY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNTzNCdm4DsVQH3milFuSehv7GqwEnByuh2UtaqnWZzK01m96/TIaTx2VxWRAAC9hsY82o/AkHqc508h8yXOMWhfHLV9E0hFpcfXtQhl1ADdgXV4iKc/h7XAlwv7Yy7S7jfdY+oUKtdSSQBpbCCbEcct0q3O2/7/uCaFdYMqnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmTWryxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmTWryxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778E41F00ADF;
	Thu,  6 Aug 2026 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038603;
	bh=b5jDZNTI11dYMerz3zWHH5RJXmdTPCDeJrU3kgMSmh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmTWryxmuPB/9SWUPOMfW96lg0+xPu4so2xyBu/vpncSkpSra+6NagFLgUnkvLdnn
	 mlWA/1DiqPYN+ohl3zUVdulp76GFmTJ3aLFAjp2kppgR00frbXNJF75ctxwrn/Uqf9
	 u1TzUabUYTPsfG+HhRUNdMX0VvVqIPMtRbSzntn5hMiouHZPBXkoVDXlubBpKtqNkW
	 +NZrSJng+0RA+8d2Ee50C7/1HZrQj3MVP763Y9GW7TM2ZqGWXmftBQaIgfwHVB2vz6
	 HLl8eG5F23qD5eRZVQX/us6Ld8hy0pWHpOZd1dwLnxQtUZg0WB374NZbBeZoKvGYmc
	 x1D6qAYTUfz2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH 5.10.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 13:49:47 -0400
Message-ID: <20260806131009.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806021725.3224574-1-junjie.cao@intel.com>
References: <2026080541-handyman-subsector-8c60@gregkh> <20260806021725.3224574-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 10:17:25AM +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
