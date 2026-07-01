Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81558356742;
	Wed,  1 Jul 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888854; cv=none; b=iv/bxTXzgEySiySU3BRZwmqYE5J9+8ppCxuPGffAj3qrbWGl/f7rcR/rGiko4jvWFMgIfVaAGiR5MV96XXwBWn0MqEbiODxam7Ydub7j8A6nctzRaOuogI/4rm9rkq9/uSXG0Ua6Jqmehzbt4Z2rvdNTvA7dqqPiyiV17/tG5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888854; c=relaxed/simple;
	bh=xIElgnFq8EtClhTLuOhn5pq6PlA2nac0VFPId7TvFK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fExfP8ly9+R57dYtNtmRYpjOcJu7k1ognY9l3c8cv7scq2DOBo4YB1QjIfTQTiESLl6IoHoclsIxFU5Tax7E2YHzDVAIwCWMMC0Ck6ah6hKwR5flH03OkC1D4tG3e1qplHMGC0oQq58Jxqz+eGX3K6Y0R1vAs8CUzHtH6NZlMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=no4srl6i; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="no4srl6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=xIElgnFq8EtClhTLuOhn5pq6PlA2nac0VFPId7TvFK8=;
	b=no4srl6iYned6xWUc5UESnHFkh5ANMnGlbzNhIFfTc1enfYpoA4XZAPptaM+L4
	Hu1aQ7Tmac0FAS2pXPgs8SB7WzUK1aYDRcW99wFPQ87xXd7oskuq9JS3IFACapue
	1wC1P4PyR6Ie8vmNQAI9udPLaNhZBTiaKZVYsDZIw6tTY=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCX3EdZuURq2kJRGw--.64373S2;
	Wed, 01 Jul 2026 14:53:15 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jianing Li <m13940358460@163.com>,
	Sebastian Reichel <sre@kernel.org>,
	Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 14:52:55 +0800
Message-Id: <20260701065255.1073-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <2026070115-equate-shimmy-5f19@gregkh>
References: <20260701012101.782-1-m13940358460@163.com> <2026070115-equate-shimmy-5f19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX3EdZuURq2kJRGw--.64373S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRG_M3UUUUU
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC-BswampEuVsInQAA3k

Hi Greg,

Sorry for the duplicate submissions. There was network instability on my
side, and I mistakenly thought the previous attempts had not been sent
successfully.

My real name is Jianing Li (李加宁). I sent a v2 with the From and
Signed-off-by fields fixed.

Thanks,
Jianing

