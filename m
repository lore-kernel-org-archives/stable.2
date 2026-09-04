Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF43B05A6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490411; cv=none; b=RCl1HiyTWyN1iH9hvHQ5aWWs9/Sllb62W9fEPXuA147/wCLsrJbmuAuJHI/3pn7lYm0JcJFl0ti9uHoW34xV5GdwXgHqwWg0e593xN0oBTr3qdccG3zZUO224F1IvpMA92KXW/CSudAT0OTDAXWwkS4uDErf/zj2iSx7iv+qYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490411; c=relaxed/simple;
	bh=ScTkGiY3ggdvdt2j1VHyLCQynAKKiQA6+LvB8ilCb/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwQk97tRXkzyuP1KjT73XrdFLAkxZAOTFhtz3JCNIaosXgZSYoVfxImNpAYoOqqzY0PZE6WJh0n+xE/yIL4HoTz1booTyvKDOwFqGDZcHp6QyzhiZOhQvzPehhqBR89zw/9FfSOOmuXlkpBlU3xgaigMwX4xUep4EGhPbU5NE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXa4SIIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXa4SIIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FF71F00A3D;
	Fri,  4 Sep 2026 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490409;
	bh=0+VkI3rTNzRYRLk2N+aQg39cJYiWzdv+TWegGIaAj5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXa4SIIJpbMPFWICo7Q4RaWJq0iDSK6KN9BsD/AppE1gpJlgUahIKOLlP9/neNB+3
	 Z0ZRox4Hw/qrBUcqbFeNotljlLdiSynWeWPec7KiEbti0G10SV+YAUoQPrOoV6sSFE
	 isfG1g+WXFY0xNRIcBdBxtSPNBCZpup2zZNugh5JM/aJzfNg7Jr1BKB1efCSJYI7V4
	 WR9w3X3956Yby26kTk48na/Ju7qMoChXCmAoNrY25+/0nvHqRO9AoosZfevjo9dWoh
	 HCDyCDd8pwOaD9/hoYC6uDXdof0Qh7XeWgkeK/9Ua5bHegpO+P+EKS1sj1wkLkUE3w
	 6rUCYIRBHGa5w==
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
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH 6.12.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 22:53:01 -0400
Message-ID: <20260903-daily-reply-0011-re-pci-hv-irq-retrigger-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903160211.18606-1-namjain@linux.microsoft.com>
References: <20260903160211.18606-1-namjain@linux.microsoft.com>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
