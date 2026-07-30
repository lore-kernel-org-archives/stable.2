Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AF36EAB8;
	Thu, 30 Jul 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379231; cv=none; b=AetYvPEboFIC/7pTKg7sgV64w6IdtZxyDzchMLeuyuO6LHFoGQNe0e73/GkAeWBawAWFei0GpVOE5yLc/RZfUJpN3oRaBENNBT+yjn0aHi6i8oOI0jn0Z+ppjYF5vFCSBaLeTBPeb32/qcLvi6q/6wuWGHLLIKt8hPbmyRpcDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379231; c=relaxed/simple;
	bh=FHV3yx0HyV7LrdZ7Z27HxNKxFi5eNlJ1OUboqjhOOwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6MeYApO8feOjZe/W1x7zMcY6ZeT7mQfXHhf75knCl1T5uqHCWhJcexUQNj7yrlb0bVjH3R8shReEKnbLwnyJM+KEtk/d/3sgWNn6snKsPGj7SWGdQUKj6vXUNxcoT8rbsYpd8ULI1P8yHz0ljWRdHpEaVdUk5c2OsOXQrZr6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikKghXWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikKghXWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C51F00A3D;
	Thu, 30 Jul 2026 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379230;
	bh=RZbhRJJBFL+blJ2QAZwZ7Rdj2VHRXGXPq+mw5wsxmX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ikKghXWl7avLYv7wsUALwuCaEgON1Enbib9Lksm3tKOWSlSCQBpkmHzX+/g8vabsV
	 ckX1QvA43R0dJV993WYlJpcdzF+05Cu1t4MJwmKG2K2XiwKqG3xurzclxt3Ek6eJH4
	 cBZBrHvJzQU/3igqCYRZYqAkzTy5c0lPXE/dxvNgMVgio+mfavodBrF4BNNI4jsHlw
	 bHz7dWwjPfbGQCmm2PSyvSEX1KM5Kc4liC/9hR2gJ6GIuQ30vfickhKHdYudJYzKdc
	 S7mML6ZI6BV4RZRW8J1X9T42xLM8O+bYVx7C5P7sCQwkotrJBgShvLvUDiDdETA5f4
	 8zHIPqElyaN8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	jiayuan.chen@linux.dev,
	martin.lau@kernel.org,
	bpf@vger.kernel.org,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Wang <wanjay@amazon.com>
Subject: Re: [PATCH 6.18.y] bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
Date: Wed, 29 Jul 2026 22:39:58 -0400
Message-ID: <20260729223316.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728202658.8687-1-wanjay@amazon.com>
References: <20260728202658.8687-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops

Queued for 6.18 and 6.12, thanks. I took the v2 for 6.12.

-- 
Thanks,
Sasha
