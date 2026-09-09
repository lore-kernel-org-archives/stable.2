Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9142F6F8;
	Wed,  9 Sep 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985614; cv=none; b=NcoEc/3vs2sN1CIznvhHloEluFuktNO+Xmf1rPCCqlMq3e++YwaOsfOkTqBk7Yu9ioFU4UYv3tLm9IXEu1CI81Pq+uMaCQ9Dj9cEcG6Njckqg86UZoR9c/3GiG75hA1D/5HE2VH37j6Cz+ZhWKjoU1WqZTVV0i/djzNeySNWs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985614; c=relaxed/simple;
	bh=1vVq7fGyrdyHuECwd+lq1BuRtFz4Trl342l9QfR2wEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQSOZE/h/huM5y/ZjQZ2EF98Myjdz4mJlPq2igxuN729pl4YOCXAHfyoJHBD1lYa2Fc4vptvkLH7aXbSmxlAmyHHu1Sh3TG2bTe6rkC5DWfNXLqQWOLB0mz8sYTQHfdyJojHaJT+pGesbzv95jnE1X3fqMSo1J5lCHqYHMd08Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5cEw1iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5cEw1iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C31F0089A;
	Wed,  9 Sep 2026 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985609;
	bh=+e5DWdfh9HYfIAFxLqp1TH7jfUo/hYZd9pfg6dgNWLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5cEw1iyZSCNRY1Suk/fEyX1DRAkOYYixDMG5u5lnMX64cdaZjF4+liKa7Lp/N7Fv
	 cjhOHGZIjCxuw0N8CSdyuB0UmmQ3I+FQ4P9sw+Qr9T54e+PXLNlvm8NhWPdPRtBSQb
	 ZcuK66L4EoWnTvr2KB/3ZMvcmEjbV8o+udNvvyXmHYhePo/v4MriUUuURigpFA8fXH
	 kXIm/P/uFp5yiH6eE9B2o/eviL+3oCYCXuI6D8fMQEhEbah25EtBqHlTJT/MVl4Nsc
	 k4kXyx6QH1HAIgDH7ZteHA2/BIECbWGxSHPO+O+ZIBtTYqHdhvM4a0q/W8+RujlAvt
	 OTatQ1eK+hkLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/paddr: drop last same folio access check reuse optimization
Date: Wed,  9 Sep 2026 16:26:13 -0400
Message-ID: <2026-09-09-daily-reply-0015-damon-paddr-drop-optim-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909053646.245843-1-sj@kernel.org>
References: <20260909053646.245843-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It can race when multiple kdamonds are being used.  The problem from the
> race is doubtful, but the gain from the optimization is also doubtful.
> Simply drop the optimization in favor of code simplicity.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
