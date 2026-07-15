Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F664A8C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074375; cv=none; b=BCOid65GRVGFmh20fvQniE0TTIq69AdM5rUAQ7YDBcTRb8jzdIBBzNyxcGm6sInMdvjGUE8g3wOhasvimW7pcvJqxxB4M/vCVaLztq3fHpDKchr85jUnGh0iLH0elOQIoepp3kqlgEW3S9lRN2bfyLFL9k9rYavSZzF+D57NsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074375; c=relaxed/simple;
	bh=Jj2rSeAxhdIGEasdDOcMhqA1SHUSo7+l1bQNf2Fx950=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cd1Ttjv/XBwf/o/Xzdf7AhESZO9Wc3q0ad/IKhnDgB11ku7x8sWUXmGrhA0NHNSV5gYSByRpAWnLr5V2f43GlsRLDnfppEdy0mh6gKlhkk1dTFwyk/OdJZx5xNsqLpbV3CV9qagKa5VozE04hSlehc2uJhhafLjcSd/VxKH8ihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBHSQFPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBHSQFPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D694E1F00A3D;
	Wed, 15 Jul 2026 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074374;
	bh=jZElyFM2BF0ERPXracD3Q/v1ySRIeRgFvYcXhdBcztc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBHSQFPnu1LXqdIWhNDR9FeYeDjPpFapUjavQvyN1/fo04ZWu73MUnffTEq6Ic8P6
	 SkL1tW1eYXFpDl9jz4viJY4NzYA+Wy2wkmBW73yVMDXqokIz66i9KN67b1uDRJlwty
	 Jeo16qVYKwSXxkp1Ixhb4wE6wtW20DPkqN84SOiRKfqaYqcMv84/zzPGK+wZgJpAXB
	 i1auNSInMQz3GXA3ANJEDeEJUF4l3sNEVbbWbDsgKPphMp2QZCnW/Bn6Ri39k2oNyD
	 SSgJanzUMBtfglT+iqP5uaPkf9E3ZVhKeq6NMhP88zuzWvVzd1h1HK8BRT6pSj1sFU
	 IJwriQZvXtU9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH 6.6.y] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Tue, 14 Jul 2026 20:12:39 -0400
Message-ID: <20260714200600.stable0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713222726.28158-1-macro@orcam.me.uk>
References: <20260713222726.28158-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Discard Vendor:Device ID matching in the PCIe failed link retraining quirk
> and ignore the link status for the removal of the 2.5GT/s speed clamp,
> whether applied by the quirk itself or the firmware earlier on.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
