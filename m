Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A310F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595404; cv=none; b=fRU7gPGnC/l/Yj8tQbqv0UMNcQm0C00NmdZbCCWwdnihkiuv0qpXzF5KLkPxCwRHsUXSKl/ugAErNGfYzMzAzXVHbfUBJuO0ndxHYIFHdILmAtSPUJcACBGqd4TKDrWO+ta6DDceRPUl0lSwI7OTKDWQM0Yt4QQGbqhjUCpZkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595404; c=relaxed/simple;
	bh=wNF2usCS3P5a55UKL9I/irBi2P7mzs/NUnmFEYF6o6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAgGEkhhqpXmHOQSemyHBhiIvYcoBec8kiEYSgppm3bMt7xMQT9OGL5edSDHd7v8a69mFvnx6GGXJryze9kXOPT1CZluPeCL7QFd3bKz8NKzp55TMqupYUNUEsMZtyMzmm5BKpTITCUpip8XViRfGrWUocEf5sk9vkC5IVKL6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAe5aWj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAe5aWj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE83A1F00A3F;
	Tue, 21 Jul 2026 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595403;
	bh=whQfzU+iCX4ZXS5wt33+BzAY2lP5Gc/sY8xcHzAFEmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAe5aWj9w09iBBsapSLJj3qE0naFD9Eou+AanQMFSRIYNOmrD6SLMbdjXyRRIKNzh
	 jCHlUV163+HskVjSYzM+o38jI+UfZEHtJTG57EjDBKqgLlOqaA8YgThEllleRfSg3J
	 rTfb1kuJU5ATf6ASS9f9Xu2VxV+sseDD9iPrULXG3GlpLySzqr5zxZ+k4vS62X/xKn
	 mne+fIgWVC58Abqaq/es1URLnddGS8ZRHA1w3PlBn7hDXPYvJ3LxkvCZQLbCxdnJG0
	 hvIG4/duLK3b393bHBiMv94eLWHpMw8rZ9GWdZZdNaQP0t0FvrKWSSOiwy/ir5wnY5
	 Vh+Y4xEQCeczA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 20:56:16 -0400
Message-ID: <20260720175500.0009-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720132640.304181-1-sven@narfation.org>
References: <20260720132640.304181-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
> the skb. Variables which were pointing to the old buffer need to be
> reassigned to avoid an use-after-free.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
