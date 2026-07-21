Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC62343BE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595405; cv=none; b=T0brd5Hr5pj/QPNgC4YJGjeSImUI83gMz2c47/dRybqppVdPYRE5NJHxShtZuTD3/ia+JOCGHMCltmi0oWlNDR5CntAgOQds2yMAF5YxFk/0xV4NlL/NVdedsWfEUF5+rTE9DQFygXb61DXVxS/EqPgloCgba1bjXjPVEEUPAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595405; c=relaxed/simple;
	bh=poEJTpphJRTtJSB1u2Tp+xWfae2G4IoiN1ipV7ex/a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwnmHeJgkAiH30h8nrMKm/GZb0PNeZETLTBJtlcWWIIKFwgnVakXaqrvZFOTJNB0QC8nC/fLushMHb/JJHkhjVdDjnbFV4ghjbNJXNHvvQ48ElaMYkvhTYWgA0kKoWqQ1Ocn169XTbM5x7rvrBQ5CrqdAzzprr6OYTJEzq5mMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLd4wW2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLd4wW2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59441F00A3E;
	Tue, 21 Jul 2026 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595404;
	bh=7IhCmCEv1L+IlYKWrppy1pPOF+PSxY2kfBbeu28SHWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLd4wW2H0G8+Z5TeKjEeg5tiYAOFdMWXWHMRGQxZ9IMzzKFSsSdWt5T6rfl9qHcV5
	 vhlgl4iPdsZbKEM6H+esfP4nJHjkF1Ge0NEPo5amw0PMh6j0Emza5VNtMaR7YYiVvg
	 uTu5qI0WH2+ef00/tkw/u+miH/KW5I18hotR34Hs5GFsMdzL2WHwaCSht8Z3B1wV90
	 uxTxiZgop8tn4+7U5ea+QjKM3rbEh1ITKoANEr+Tgq/ESsTk8Ezfxp2mUIlgjg18k2
	 qDPWRuUtqOh5vbSy8H9ljM8FpQu7M759q217sb70qvwoA+9kMJMQ+nENd0YwxKROAZ
	 D7VpHVBVZrgUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 20:56:17 -0400
Message-ID: <20260720175500.0010-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720132435.252242-1-sven@narfation.org>
References: <20260720132435.252242-1-sven@narfation.org>
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

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
