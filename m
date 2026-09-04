Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B133AB28E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490418; cv=none; b=g6kapUvLwgUtL9KkmaMkEWIEJmBZEa+NxFGQO8EXVXh1v5tRlOiMUvV8z5FkPWSLlNrE5T4ejsZv5vy8JoE4+CyXTZ6dFbwnFpSgbTjVE7H4IiODiEWTWzCMHQE1rcQSe/hCGd9Y7G0l7Ec0EQEQVIn5IHcXZUFVyzZPFl2u69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490418; c=relaxed/simple;
	bh=LacuonNCPw538lEiLucYW6duJMCQhMOcAWWB50hCbHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es1la/2sxht2JQEhzqnmJCLjsDUCQxINL6QJV5rVElqns67beFam3xrBFeLhlZgx8aq9ydhqiOU5+UoDfw7cPWi4bOGW/6KbRKiLyLOv88btARRV6wdJW/2n0qpnJbaCnpyEewu71YNDnBvvYHH74Cc7x6++0eI/ceh4PsZdYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMu2qQ2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMu2qQ2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686EE1F000E9;
	Fri,  4 Sep 2026 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490414;
	bh=fpea791kjgW1L+bdhDkQ/lWott8vCQvTCy+qU+I6XQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMu2qQ2uKIpy+Yxuq3NG4RdJNu+KTDFaMaWN0/RUTF8YtAe6IACAO2KMZvkTFbW8E
	 5l9QdwEd/7ZTF5hsMQmiKeWBVjNJATrz2tFKjm3OHC/s2O1tyER4s594C2jGnb2trn
	 hDViztBIHoeKWw/HOF0apOGDyyDy6BQqrNHums+gYFIHMs4vjcJIdB4PPJs7SREOf8
	 fFUAv0r64L8Gm+Dpfqt0EpBun7TRm2avO8dE2QYrhiwD4rhE6OuhJCXvDbbwhDLmhu
	 pLZYjeKXz09o4v9NKwgr/RSVm2Rnq8Aq6Qts1vPqjHdrYETAiHdU2DYtgp+avmdP9S
	 Fc1yF8DX6zXpw==
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
Subject: Re: [PATCH 5.10.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 22:53:05 -0400
Message-ID: <20260903-daily-reply-0015-re-pci-hv-irq-retrigger-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903162331.111146-1-namjain@linux.microsoft.com>
References: <20260903162331.111146-1-namjain@linux.microsoft.com>
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

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
