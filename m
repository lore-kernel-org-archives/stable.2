Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52D416CF3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=mJvOxwqFhvlYMHCFo1yyItTz9pRBGC0M66ydjH4H0uqQkpmxE7qY9HUejTa2NRD08zhvCjYvmzqVLt7hrowzyUucjCQSdb+l5GBmS3atHdGY/auQxN0vCd0RAifNljl6LCwGfmq6ZbdMgcv7jlF60cMdOhL258atoZycypYW+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=xDtBujhxdu8fOOTw3Y8BhDwPUR4/8CxXJxGhf9ZGeF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPi6H1MBzCbuimw77DXeIPVbrjyfj/AP3wQtacbdYZ+s9w5dAn4QyIDNRqchlHOc364oFBa4ozHYIaJnDMgFwOWnS3qgkd0mvNzJMGYFFppjpgChrlkryev1s3DYXRNqXZ860mkxRQB/rAnocM6MP0LfnLaFr+0yXHSqqEwxsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxp+4Vtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxp+4Vtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688801F0089B;
	Fri,  5 Jun 2026 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688267;
	bh=kiZNHPgcfwiveKmS/0ZPzPkGy4RRm5m2oulHxn+KZJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dxp+4Vtm+IodSEDj99JqSUrnR7+g2kV7BHKCk82ezRJhi3EPmOr/6dhMpBn4JEsd4
	 bUq9TZ+xU9Yhow0MmOtZp3r4JBvi4k3UNqk/ST7MtH8jqhQGJawthLjeYX+0ejgF4W
	 32pAMr0yPJ899tMFqJZR/YjGFesDfMWn8zimpyaeqT2quTgaQPQTIla+LAL7JXtkQK
	 A7k1nt0FHKqF7yfBRc7JWUiKfRGflMcWEt4ENjF9qC5DMY/uiSVxNIAYnp4HTp+O5v
	 tV9uPdHoYesE1mp42l6DAgRCWquKZHfCxVibwv17Ue1BesgkMxRcXC04r6kLixtGWw
	 439poj6yq6VQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.6.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:21 -0400
Message-ID: <20260605-stable-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121911.150179-1-weichengc@nvidia.com>
References: <2026060433-palace-registry-511c@gregkh> <20260604121911.150179-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
