Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40719367F2F;
	Sun, 12 Jul 2026 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888484; cv=none; b=esiEB7Rjf/emVBOiRD5kJAlY0qSwG7nvSpGIrNFFx5IAnnC1Eb37FLoLNNHPpsK53+R/PZ+wCek5A+dlj382DtEu4T8QtqrgFFGAVZ5UNOdJHtLUx1aGsX9U4MFRLGl981mA4cLpDbC9UebXHDa0/7UWBNx/G8lBAw6ecldsMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888484; c=relaxed/simple;
	bh=LQ5qnMAyqyImi61w94qWvB5yljc6lYL/VDkUQYzT5xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn+ria2mKrXuGlEwpwoW+oZVxemCmrLz8QMx1GufZ19jeRRUNX0QWk8WXchU/YaxpjwWsz4K0D2z89UhRk5Ha7qTxNan80PSlBz81eYPQvsPvu8AkIDFLKsC09Q6EznEDk8oVaVj1Rb8UEY5UPtWBHRVV4kY3lrGIPk4O6w7AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=drtMqrls; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="drtMqrls"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=51X5ACPiybVecl/egLVDpzxmSGAC3FWqg15+e0vfnfE=; b=drtMqrlse0CCYqM1gqVb3oNwOB
	1rm2ACUG03nC4BVS03Ff9HOF9kZJQvy2g2PzuX4W9gVc9sOtjb7315m4xPDCC9/Bj/ULbninyWKzo
	/MDZhS+UFBbB9lovaegH5ytHNM60wofsEs9/LFZN12ulRNGv944rgVJVgRaCylOZRB72DTAEPxoS2
	aRwPuxUsCC9LJW2RvPZ7RHRKMZxpDwIPsxzWYUzQlXOA6xSzHPg1sV6sauXd3WPUY0haxO2c+qOAu
	CSQsFGbELMJYs0zr5CcRwJC7i5drPNO/5/mb0WViQfo5ExuA05RYsxOSsMvD4AubsKi4FnOZfUyXO
	qTV8YCRQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Oren Klopfer <oklopfer37@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peter Robinson <pbrobinson@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"
Date: Sun, 12 Jul 2026 22:34:00 +0200
Message-ID: <178388833983.1396294.14906370206839721571.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703201010.67311-1-oklopfer37@gmail.com>
References: <20260703201010.67311-1-oklopfer37@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 03 Jul 2026 16:10:10 -0400, Oren Klopfer wrote:
> This reverts commit 096bd8c679185f898cae9933c6a68650fa26ea4f.
> 
> Just as with the Pinebook Pro, there are multiple chipset variants for
> the Pinephone Pro, and multiple firmware binaries for different
> distributions. The change causes issues with some of these combinations,
> and reverting it resolves the issues. See the Closes below for the full
> report.
> 
> [...]

Applied, thanks!

[1/1] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"
      commit: ee7d67291fd95554dd24e9db8d8983a27739eadc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
