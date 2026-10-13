Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA94F4757;
	Tue, 13 Oct 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892707; cv=none; b=pDrajSZZBn6UhDpjEk8obl9Wi94uDiZIPASUxGeBivDFP7p6JuTPCRoFraPnGPmNpBPv60woks2Fqokon2Kf22kASGzFbYIFbuHeqEj5xNwVa9v7Ngv/pw/z9PdbftquIjWYLFcVf01LL+ioWTSCnlFIYKcTNerhYsCpo9k+K0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892707; c=relaxed/simple;
	bh=pJNt5/IhWyhOjxeNW40zNDjN+UIFt7l8LvGFaJLmBdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgfaNhQvt3HZC4vIeQr3oigPs3MxDJ3SnVMfLpSdLE3F6KAkpTeqsm97/05WBu5SWdhIH2AEkAkFrD+mtmHoXGi3ZEKk0FresFaa3WJtPR9muaF+AHRSDNAR+weKxonokPvZl/B6N+V1jr6TNDkRwbcWvoOssxGAom6VzRGQ2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=beEAKW6+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="beEAKW6+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ZykDT+ldOzat3VDDIfdr94Z8vYDUwlbjCPKhDjwqAq8=; b=beEAKW6+D9+iNxOMMY0U47alwX
	9IM+2guNvCmM+zaK7ZAK5V4YiBCz1N7/1xsrp9vpTMaI/swxy4BFxZ1ERfm4Gzaz0rsCcdpeznHQO
	sQQwDsEM+rbxRo5GOQ4TRZBE+EojBkkWgWWr8StSUeWPl0Aj90lkeF7b5oLGWdmBQeqJsED7wHRCL
	JcRIDDYZHZ9pSspM4AueDpJy68wDjkffQG6bbKTYypYB3tx0KItxaJWPRwExZrgtXrta3DWyb287W
	YzCpuU5OOmnVq9Ee55bAgfaaFoXIdaOT/Kqi7+XkCggOd/1XRWLgFFZvQELYdn2mLIBPe3fgNiShW
	8chlMX5A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jiaxing Hu <gahing@gahingwoo.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is removed
Date: Tue, 13 Oct 2026 13:58:08 +0200
Message-ID: <179189268363.3989522.7509478122641676060.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904125936.26234-1-royalnet026@gmail.com>
References: <20260904125936.26234-1-royalnet026@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 04 Sep 2026 14:59:36 +0200, Igor Paunovic wrote:
> rocket_remove() decrements rdev->num_cores for each core it removes,
> while find_core_for_dev() searches slots 0 to num_cores - 1. Unbinding
> the cores in the order they were bound therefore loses the last one: by
> the time it is removed the search range has already shrunk past its
> slot, so find_core_for_dev() returns -1 and rocket_remove() gives up
> without doing anything.
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: search every core slot when a core is removed
      commit: 6eff1d69dae808a1518aee5a58d0853a8db3f1be

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
