Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB862F8EAF
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252271; cv=none; b=kb6Faze40xVfzvzTZbrEIzSsinieW5CUG/2clzQ+kBap9snaT5V2Fw4mfvb8P9uxqnCE+KKnqmwdFXXzYt/S6zBZdeiYjVj0U5VE7/J0v9tjI9UDPln0duuPP/Vhm4YcoFVCpvgaZuRINK5oS/98u3ybu+AxWHjIRs9mTakistw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252271; c=relaxed/simple;
	bh=1r425Zmj5VoxjN3l4dmp1rLhmYGzjRl125kxInV+xYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0roxxE5IN65ArWVJ9uHQ4Kx1BMSHIpEUEQYGr8kArWycy+Fp6um9XcOoobPPsM7+tL9XsZVLavRkydjQoGqFbSC7hTXPm64z34rvcbAFMq8QN545N8XOan16ahx+SAPncI5MkOpLx9Erikv26AWmcH90rPNvTvsnPio9/K0tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuAeb1N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuAeb1N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D71F000E9;
	Fri, 17 Jul 2026 01:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252270;
	bh=VhmLZa37CoU2E/otFta4x2kYCxDGNObo0l7Q0q06Vbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuAeb1N02LkCKBAF5SpXaqQerPdcT7tYJu7UC9UmYNB7DeWb+uWsrZmg6t7ATiwcg
	 7SHFnAgJxf2B/gfGt6rgxUpjbLvY6ZIMnjVQkjnCDv91ozeFRBP/cDbR+2Oz4sBMht
	 4PcsnPLJU0GYVY30m+3lNSCLAJn4ioN/CaQ+yk7cgXSUNBn6nYB6fNivf8Fe+PH7An
	 8GmxOgdEZWae/V4JwMubtV8QCfJFyxG295ejr8QWGwG+FitNHmTx9rPGIvL+VNQar7
	 p+dlIO3GCj6ZVIgprxVeA7GqNuDu4lzQxG9ksfN0EfWM+h1ffrKrZUhaDsXah+GScV
	 RAPEtYFt8vGXQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	stable@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access for non-replacing" failed to apply to 6.1-stable tree
Date: Thu, 16 Jul 2026 21:37:30 -0400
Message-ID: <20260716232340.0003-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <afa8dd4e-eac0-47f4-9c08-c9fd278a37a9@chenxiaosong.com>
References: <afa8dd4e-eac0-47f4-9c08-c9fd278a37a9@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 02:20:42PM +0800, ChenXiaoSong wrote:
> Okay, my team will do it.

No need - the cherry-pick only failed because the released trees don't
have 13f3942f2bf4 ("ksmbd: add per-handle permission check to
FILE_LINK_INFORMATION") yet; that one is already queued for the next
6.18/6.12/6.6/6.1 releases. I've now queued 851ed9e09639 on top of it
in all four queues.

-- 
Thanks,
Sasha
