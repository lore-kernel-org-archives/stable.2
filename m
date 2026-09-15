Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53D463B9F;
	Tue, 15 Sep 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463636; cv=none; b=C82KG5oMt322l7o4mZDhSxuua/vTD8VeqDSJIvHmuQwFD2/8H7LcrAqep70HCXyMCBP0dzzsmSnd7SVxIaF7b+uVKRyOgD8IilyPV9sxiz6u0n+BRnJ9Ws93qM+2N+6/rcpSfuThovAo4gvuZoKZk9mG7cq3/k2rHeE0V9m4Hb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463636; c=relaxed/simple;
	bh=fP/N19hnbAJhIypZMfgmjnt4LsUCGAxomuxoDLNIcew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4jF8lXkqw9wUzGLTDuUwcXClj+P7iZNBU1lNNkDe+aCq+k86dmDC5GBu72KO14qTw2Hir1odvsA41wkRXiiTkV7pj8BmpS7sEeER+THU9+WhLVm9RloG63NFCrEekc8xKsUofetmqaxrSNWdOB9fONiGgD4CfFxcOMAAxq59S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuC2pcd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuC2pcd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08F01F000FF;
	Tue, 15 Sep 2026 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789463635;
	bh=U493e9Wk5sWJ+Te4km6fRxRGxfnwGprrNsoNPLC6E04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GuC2pcd3/vsRM26eu31MYDqPuvniehc5Xkol1ZN0SN3OfK1kJb4bZbpyvMWlcceVS
	 vnLbeP+LHetShle22T9nio1Qtz18sezeyHTWpEInrhV4caJHzUuQeJEOI1OUL5TQhT
	 Bujr8bBqaleaS1apU3Fmkkgl34OuTphYK5Ompbmdp87t6IIwjch5bMJo+rmMii5Wt8
	 0R2BlBEZpLnu9NbuajCJ7QkSOtdgUcxqQOvcox6lfLqlX76OJWnfc2Q3U3CeXaIU4b
	 BMZiOJ+gimaZK9o8Nf97WB/wch3vUE7AgQhl7g1e+/jhdnjDa/hHz9RCj9Hq8f/MW4
	 ePPLD0WJ32mlQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>, 
 linux-ide@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260904134310.1465051-2-cassel@kernel.org>
References: <20260904134310.1465051-2-cassel@kernel.org>
Subject: Re: [PATCH v2] ata: libahci: clear PxCLBU and PxFBU for
 AHCI_HFLAG_32BIT_ONLY
Message-Id: <178946363362.698413.4876179160197154184.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 11:13:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 04 Sep 2026 15:43:11 +0200, Niklas Cassel wrote:
> A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
> JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.
> 
> The failure is seen as soon as the ahci driver is probed, and booting with
> iommu=off does not solve the problem.
> 
> Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
> for HBAs that do not support 64-bit addressing.
> 
> [...]

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY
      https://git.kernel.org/libata/linux/c/82e47533

Kind regards,
Niklas

