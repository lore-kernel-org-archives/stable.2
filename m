Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED71A6822;
	Tue,  6 Oct 2026 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322605; cv=none; b=H48C6Dm1UgsU5j0H7dc0e0mEHdWm5B+1mZxd5ycYy6v2DbaTUJqYCeaJpsq1/XJBv/S8yPZ/YDwz76pZzn48aAij31v+fRr13QjM6IpdXRnfKjrnqF4PG898gIP93bdgdqJ1mu6hCGUsd7g5lmWHIzjK6vbcUgql7lh20k4L4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322605; c=relaxed/simple;
	bh=sdS5EMotLbBFut5HidI6DaxqgnT0fZqEyOmzsGz62T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp1kl1Q5jNJrenHLOYHd1ZFKd/2G2LmOV+r+8O4xfGIhdSqjr9ItkHwMr54B6L2O/CojJ6ARha4A/dTyq5SDEoswPMx8yiPsMDJ28X8g4B6irl2Do37PyA3oSres+pGKPEbkFYF2q9SE1Wzm7AVniBoEud60KIvbX3MB8KFU+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+oPLv+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+oPLv+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460791F0089C;
	Tue,  6 Oct 2026 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322604;
	bh=H00qTEtUiM2ixmGGSKOBHZyblRAnzgYmrRT3CM/7lHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+oPLv+x6i+AHS8e9w1HbgrAxZbSM7irn3ek7UE+wnQoYNqGqiLtWR4gyLqiBiBMs
	 TP3pwzvT5a8EGyYHyvUMa8ytZ2OFDb508K4kS4dQMxtxKWVWu/aYflAaFofxzqEdCO
	 1HKxmRdVKHOMoHJX3C/c5CNmH12ZPefFmbVhul4jIgMfo3xYVtsLknUMmxUrvkSlje
	 e7z0S2fp/illBAKo8TOVoLKYuY1Pv7BoQ3FZK9hf9lgqfPgIn/9uZVRRMRv0sGam3s
	 lEiEJ2WB5XhWcedV03Hxj8rXee64g4NtJc2S8GkTBNObNtFc+20XxMyFsYi787ZpMk
	 XXk1K6rQF2tiQ==
From: Sasha Levin <sashal@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>,
	=?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Joe Damato <joe@dama.to>,
	netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Stefan Fleischmann <sfle@kth.se>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on macvlan/vlan with bnxt_en
Date: Tue,  6 Oct 2026 17:35:52 -0400
Message-ID: <2026-10-06-1-daily-reply-0020-bnxt-en-vlan-447cbe95@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005145430.12777c2c@nargothrond>
References: <20261005145430.12777c2c@nargothrond>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'm testing the patch on v6.18.55, and it looks good so far. 5 hours and
> counting without any issues.

Thanks for the bisect. The root cause is the bnxt_en small-packet padding
and DMA length bug Eric Dumazet identified, not 447cbe95ebb9 ("vlan: fix
skb_under_panic and races when toggling HW VLAN offload") itself, so we
will not revert the vlan fix. Once Eric's "bnxt_en: fix DMA mapping length
for padded small packets" lands in mainline, we will backport it to all
affected stable trees.

-- 
Thanks,
Sasha
