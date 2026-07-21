Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2E10F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595401; cv=none; b=Dc+/DRZ3IqLMX3NafQR9XtBalrf9PwhfzgHCObKoVmC0tSuKUorv7AioKap8K6oNGvXAMzyWJ2/O+MU+oR/4ahkL4dQU+/jHbQZf76ecEvVTqVz841hHIuH22DEbtGlpdFrp6DXnhhfTh/pdMzE5KaDZZ6NnPaSjfyA2Drsfi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595401; c=relaxed/simple;
	bh=Qz5SjeIdUmIdpF8ZEJZctw6haJtLK79WsesMDlLG7hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh7Kxf11YdFOWwXVnvoZsFbQyAYuq3iU/8kaPL1iYeFlWiNuZNlNf1g9XF14tzIj9sZ9NFpis+O4hSlouXiRqBNJgghfUB/68dl56FPuc9VcPRtBpkqEn8lYU7XK5LR467R+JIpDhCR7dceiuUHJ/EL0aHuYIO9fDvnpYv/qb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaVWFRhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaVWFRhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33ED1F00AC4;
	Tue, 21 Jul 2026 00:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595400;
	bh=KntugGaFwTQIQdqXc8DFG+0ij159tPCmDAYCUKM5vPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gaVWFRhwgXFtm6QqL7AnsxWxWE71e5QfFeJTBS6VTdqPBF415dT4GKp10OAo14lNf
	 FIBJ8vutpR958Tq0boyC0/u3QNfOPx/xqamyVrxudh0lvC8qmpgB/2UTXZpgOkQEhW
	 uw/+TG4FHO0dfJ6u0Wr9HftsZcm02kXGQW8rffb2VvaaCac5iy30eQOkMuuoMcfaqB
	 ZAIOmvMlQVH4xeitquUVA7u7TXtA54Hu17JyKZJ0o8fnynTZO+wmDC9rmuVtQZ1uTR
	 vR+XmZJj/76ZCd2CGLlIAptH/3LhJkfIZiWGxPeiFJSTsJBwUeQ9NBlvlh1x3Sl/XS
	 JZq8roWGVkwDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 6.12.y] s390: Revert support for DCACHE_WORD_ACCESS
Date: Mon, 20 Jul 2026 20:56:12 -0400
Message-ID: <20260720175500.0005-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720122044.2318775-1-hca@linux.ibm.com>
References: <20260720122044.2318775-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An attempt to fix this [1] turned out to be not sufficient. For now revert
> load_unaligned_zeropad() until this problem has been resolved in a proper
> way.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
