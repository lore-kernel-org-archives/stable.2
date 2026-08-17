Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB0305E3B
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 03:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937130; cv=none; b=lKKDFevKQbQevg14Rw/zD6t69+qXLHSnBwwmE0wxBrJ1OJfCxywGYeiTeuywXotYFWiwo8h7cCS0tvp5yQLrJFyjEO4CedxqrGlCtxM6qTtQw3mb2WyQ5X4Z3COSDhfTedMFh1eMBhUz+DRYMOU6/bq7tXzh5JIeC/VJQX+1PWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937130; c=relaxed/simple;
	bh=fV18YV7dbg8VnKSB7xJGtFo8diWlDeBoDI0gB3CxWn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7vCXepUoDFbverbuaGv4Ahm/dqEKMzgk2jS1WvBkAznoI3ut8AXdXtptC8lb5ufg7tSTE2bB2hzlCmyJDloeR8mdNXd2xQp/SLiUgSi0pD7h1yN8wn7kcqaT0sTYgcEuB7NbhIgJ4+Xhxu/SrWuWJMWh7sHuWIgwtRGOdbsulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg69unXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg69unXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FC31F00A3D;
	Mon, 17 Aug 2026 03:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937129;
	bh=7YmOGGmw+A3TS9ltJDJCjd14UzLwnQZqQxFPh9WqDcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qg69unXxJ88za85+w9rXxgS1PnzQfMaVwpLrtmwHehnCkMLd/O+XC6Avz0pL9ptxd
	 I671hmEXr05wzQq8RZSpKU++W4Tx1Cw1/9AW742S7Ps8eKuN5NgbScOYnGsnVJG7Of
	 RUUNK+ceU3Q7JUfFoEp5V4VFSbx2N3HA6TWDLM6vY1zR6jsy1P9do8sTl97WLZRe1N
	 ntBJvkZZQuG8of6PN7q8WI0QnfBIyC1aFAsu5Hb58+IM6b9BpTo7dlwaU6aWVjsfJ0
	 201+m3lPZ5NKp3R4V9sJRi86D4GHLuCUKr6QBsfFPR9lcixliytiQR8W4nmofRmjS4
	 QEzVS2KuxG0OA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 6.12 0/2] Backport of 6ee149f61bcce39692f0335a01e99355d4cec8da
Date: Sun, 16 Aug 2026 23:25:15 -0400
Message-ID: <20260816211000.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814052439.430858-1-nathan@kernel.org>
References: <20260814052439.430858-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider applying this series for 6.12, backporting
> commit 6ee149f61bcc ("kunit/fortify: Replace "volatile" with
> OPTIMIZER_HIDE_VAR()"), along with an upstream fix.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
