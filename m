Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81739D6D5
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473251; cv=none; b=ptrznFnj7D4y80Z6JkjoBOGhlD6vl0Wg49V3WffILWz47cjuIqki+EiBYYgD4M443nikj4T9PkbWMiB0ayqWv1r7F3uLbkoqmdW+lLFw4xIXvxzG6zlucII8VNYijc/YxGwt3IdsOjBaLLI+sz2voW1uvhgztjK4+Bshw8tcrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473251; c=relaxed/simple;
	bh=rZvfxXWT/Ju6wNDokeplgDgM8qky96jPfxTT8+ySL5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu6+ZsheunJMG7kaNkEvXVqBV65IbmfaJyLSQOjl4lH5BPEKknsaS2bAeL0lWuRjr+qEN44sHqY8o00tTyuNFJkjT4PzJ/iefGZV6D86EZojv99jyYRiPkf5nze45XpXB3psm78p2+GDmyfFu43aESVN6lk0ddnlzl8V331MghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nArojkVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nArojkVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B031F00A3F;
	Sun, 19 Jul 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473249;
	bh=OCL2qh+zdI8XqeIo3rAuAWMcrdTxSS/aO50+lS3r178=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nArojkVrBXWi6MCYyEG40UucoN42DqCoZCy7DzkA2pG9HfgSF5jU93M3TNS8UKyji
	 +nAEvX1PRcgLlifkpZY/EOjrBIqUWqwxunIzP7PBgmFJPn6p+jabpF9p8LL6GUj2Jt
	 UKbSxr1zDQL+cIr8SKf0RdAwJcgAY2iWUbGQiodPIuP+doGiHrxGQOcaNykAO7Etlf
	 kKRfdBsTn3HpQi8h2kb/vGCALVwz49u8czBWvz2Z1OG20PwP+UMM7r+uJqkvprGmWl
	 yCH/mKpKuJ9M5+Oiwq/CCaey1J1ZEXC+HBee/G6qRUo014oGWHGZ2XavD2sV5aY6Rb
	 uPUJUbGX1f3/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and fixes
Date: Sun, 19 Jul 2026 11:00:22 -0400
Message-ID: <20260718192718.0008-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717044731.121353-1-shung-hsi.yu@suse.com>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patchset mainly aims to backport upstream commit 1b327732c846
> ("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
> 4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
> tests for stale delta leaking through id reassignment") (patch 6).

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
