Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416246EC82
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016206; cv=none; b=K5S84l1w1/s8cndHkBYF9YX7EO/maf5CXySeJ2Yt0wKFCW55xG3R6UYxb59y+UyEeE+u2ueW9V/cgR7mHxRnfkM0+iBnmIiMNrKFPoD5IFx16q6d5PusEchr2j097NLUhr/l4eDtkSNNSeJj/bpYTNDWHJ0K0Xzsi5m3/rFrG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016206; c=relaxed/simple;
	bh=cFhk87ZTtOJO/6Tiz8OBDH4fy9+fTnTdNr9ALcwi9yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y18LAD0f86/C+p2Oy2B5QhzUh4w/4wcMGrdWDoJM0kiMVI4TgS/ii+fFBQARB9XmXV1Tko/9jFZ+HMD08MfcZvJa1NdXPnfAkHJ1QvQbo0d5EWuK0YvvEamKAqVAEi3P13cDPHfWYNmBZ7Mo7zO11IB2dt1J3g10kibzHpsacBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOib3h98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOib3h98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ECD1F00A3F;
	Thu,  6 Aug 2026 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016200;
	bh=CIYsZJPtNYmG9AOkXtf39PyI2DHEVgf2s4Rfd+BvgDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOib3h98g3RSV9XT5hy/lWZb12QEh7kfgyGDSmpnASC8PMt52SBJm5HlO7U3J9f+0
	 /dpVCwumBzjk8U5yYfgwPN8py3zJYJGEnggQlbgDQJsn6pYx8m1UOJGQjqgokmzWw7
	 4icSauYtreTyyRb8QTv+04KO2YX4rPTw0XvpAJ8kz+gnoCnrb9SHZLQTLlUhpu/WEE
	 KPZ5tXYzoteTmm7nPjvoAxY/0WhI33gWavVuQ9K68KbsvzIANRl2kZuKD6ziwh1v2f
	 TZL4KtBMmVw+a4HI0JyxFCfdKwRX57R0ftE5xbXaOny892seGxlNc8CxpJ1M7tylFq
	 b+qlYdJgcIYKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6.18.y] can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
Date: Thu,  6 Aug 2026 07:36:11 -0400
Message-ID: <20260806021809.0018-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805125414.30592-1-socketcan@hartkopp.net>
References: <20260805125414.30592-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb->hash echo tag doesn't work here.  isotp_set_skb_uid() is only
called from the TX paths, never from isotp_send_fc(), so FC loopback
echoes arrive with skb->hash == 0 and alias the so->cfecho == 0 "nothing
pending" sentinel.  Upstream is fine because d4fb6514ff8e stamps the UID
in can_receive(), but that commit isn't on 6.18.

-- 
Thanks,
Sasha
