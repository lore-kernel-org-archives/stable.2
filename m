Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7252F7EF5
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209274; cv=none; b=VBS1Bwkr3xm6DOWAUDL3mLjBc72GGHcKNgYz3yDogAmTuHESgMcZHn5QcacGdQHt0jZXT6xxwkmLJzBpJAAqfz6GnmKeevc9ddRB0pG4HFyObNu5aepQPxy9XON4PTaaJ4d/A7nMhAATZ0KdABCAIRXXhyrGzLSBg4Pmhu4VIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209274; c=relaxed/simple;
	bh=NWxRacHvYx+NnM38/yUYfAuNvyy6HbRBGOoF0gtU7pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLyunczjtBf5mb5he//BIm6YfJV0PuFveMQiHYoVg39l25e4SU327l4DkE8Is3M0ZHaysmlOj6PosibxJtmZRkBMHEVYeYU+bpaM5Rs5wMYyVga1fMPvSk+4MnMZj9dE4wHOWsDZENPan+UiP9SG1ezbhiU78OwKG12yBcbVqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGxooKgn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGxooKgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E290A1F0089B;
	Thu, 24 Sep 2026 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209271;
	bh=mhRlYvC/UJSP6DnNkQb7fr21HAdEU5ySasYcGOqWDas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IGxooKgn1RmvJuXd7AggJ2gv3CcvilAPCmq93m09lZ97Rk9pKlHKhki+2kn1jCrKX
	 ACXwIWScGLH8F2IwTSMhgcC2m4k66PnoihrSCh+utUzVFbixdmNvYSDdqLSjwD4eGg
	 ORDO0CMblWoPJ4REztcWymH31usyI2PYb+TTqJ1a0lcUCXJx6AH8saAHy4FAT0WSzo
	 Ulyrhg8Fd+n2krXdJpKQkIPVwteCFG4k13SxHc0C+nyRVZxJ34Zo1BvcfPOsgr6jWq
	 tgv4mlSQf7XvRv5Wkdpu7xEZKZtej0bIZ4lGx3Friz2KA0gXnRB4MZ0T9kfecLEC7N
	 LNtfAI8YtB4qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.1.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Wed, 23 Sep 2026 20:20:55 -0400
Message-ID: <2026-09-23-daily-reply-0006-re-spi-zynqmp-gqspi-shutdown-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922140238.668400-1-itai.handler@gmail.com>
References: <20260922140238.668400-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ itai: context only - zynqmp_qspi_of_match[] still sits between
>   zynqmp_qspi_remove() and MODULE_DEVICE_TABLE() in this tree, hoisted to
>   the top of the file upstream by commit 29f4d95b97bc ("spi:
>   spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal
>   platform"), so zynqmp_qspi_shutdown() is placed above it ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
