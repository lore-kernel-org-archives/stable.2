Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344386;
	b=YE0mf9gWFHL3/eCtbg5cjCZ8R7nvcO6tXzyCYpJT+F6AkaFtvrBQxBmsmdoIrD9+kLkF
	 ieVV/uyWypqxCEacPEH+7kwS3YLo+uxTltza+HrF/1/rR6A/DLktvMiIf1rPlMsmxi/mD
	 gNUnDsOb0aoAz9MN+vv0x9u5mWimiI7iwEKowbspHZpdhcxGsmtrLFRn5hYJpmkpdhMq0
	 XFslhxb6UXWiVahaNiWi/vOLtRDmaKzjA7XN2jx0S9bhn/CALneiFC58vfeTaIKnv0Ol6
	 iMJjMZPNE3b9O/UdFHi0uW5laeDbPemEn5Lj9ldE6ihA80CzD1FPHVEHAPKNG6gePjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344386;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6wq8I2dTfhSXiut+aiaMJxK32mytrZQllgM8D0J/y2k=;
	b=1deOTqUbkM8lnCprW8xfiDU5rXv1btQtk3/64qqIt3Bc+A9qvszMNfAKx5JRaJs2kbmM
	 xLSfb2NERAt3WVC2MS5r/gSJh9MtJLjhpW1PTlRvaN/RtcqO8kFxdRmzxAdhFKiN9WspK
	 E7UAgvafPBBhXCMa0unnXRrWVX8RR8fycgdldOhS9g3BzS+EWKNLXU01BqJ+IqW/Kjw6H
	 T+TeMdE30ev6GOaOOi4szKv/aR6pwqBLSTu2PgFyPnlyfvUugwj60XLYMQNLyUtF2Gp7B
	 tI/VFMIppYSGEYxcX212K+ANLLO9oIr8ajNMuDo5GIzyMvxYhOjAqiL33CrC4Xtxdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO8kwQEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO8kwQEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649FD1F008A6;
	Tue, 10 Nov 2026 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344386;
	bh=6wq8I2dTfhSXiut+aiaMJxK32mytrZQllgM8D0J/y2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YO8kwQEQwyvJW2Xz4VLR2wXUdSRpDaHM+7618hPspRyXUSrbTWAaEvLHAp3OpRM33
	 rTPgzTxRamFeUx3X8jAtOMQudCdWO3hf+ai609RLIFWUGi/XxQ6kLwusAt7lGy8nm/
	 TXNNajAtaNjfV7Ao9G+ZvwqKDCNqmZxWT22MmsBt8aw9H2OJeViyvQz0Lf3D3FTjzx
	 qr8IW39AmeVAdlKthwdd4ve+Z4pHiJ+PT44a8BgPy2yXYIfpt6QQqMRjmV87BNLLl7
	 DIS+CLxu8ykGij4KKoV3JI4TZeOg4ECFFHrbDVbX07We536u/LysN6mLYwzRJ5JhYS
	 Mta8U3hE8yUSw==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	shawnq1@163.com,
	jstultz@google.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.18.y] timekeeping: Require permission to set auxiliary clocks
Date: Tue, 10 Nov 2026 15:59:09 -0500
Message-ID: <2026-11-10-1-daily-reply-0013-timekeeping-aux-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87tslpt4fi.ffs@fw13>
References: <87tslpt4fi.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> timekeeping: Require permission to set auxiliary clocks

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
