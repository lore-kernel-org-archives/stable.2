Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E638838B;
	Wed, 14 Oct 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991213; cv=none; b=m3a2wjGhopDjc2M0MypV9NMGQpmi1eKPw6brO8kft8w2GpfuJHvIqV8xd/5Uvcd/pGj0VotlUDd6EgfcEoPoN45zHNeegKpIovsuXrMYIYpDWxivZoa9bhtYxqY+B3ndNLFjMEGgluxSTXippyePAfPjnDfqsK22Itcamijkwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991213; c=relaxed/simple;
	bh=ZqABjc6D4Ao/BmE6SUrZuvp0EeRmvS1CofLj9UeUXkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sw+1dhog63E9ju+TpRufgW0rWwbvCkpxbWrNGoEc1Xw9fO8QEFHvByFoU5i2K9qVN4SsB37XVIgvMM/biPhB6o9L7SkNNxfMnTYRZNaZpeMGZPG0B3dOvSOhdEivFyQhKDSP6wVGZE9+4lN8eQwrMKFe4oL5Oe0JIZ1A0wMB8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtoWPpl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtoWPpl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB4D1F000C4;
	Wed, 14 Oct 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991212;
	bh=O3WyBIrOjeOhX1lO7ibQGpENf3bYQBgFUbIdhbIOHLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LtoWPpl051yNcApac6fpfjnS+XgldKeifspPNP9fc4jIqE7zFLvtvuOyMmPO29/6R
	 ZlpnxBS3wtEK+o0M4+ygOr4Ni6SLFU/UTXBC1qMCvbjevfrV46aK74tY7zhZ54ONnp
	 rz9iTouQZmwvNXqLBj8+egPeBy3o20FPIx/gGrwbKIddUJ90HCFfCakA46ONtQoATI
	 GQhy9/I496Y6+4xdFWmxpszve6fINsVSjVHmeveEUQSXoaBAl/6BNqagrtoIhEqjLo
	 NHlHDaZSWZSu3vtMKQ7/1L9wGQG2WWlLM2FlRl+6WBb/p8SOs+U0FM6nEkPNfP49I1
	 M1m8V5P3h3ZRA==
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, 
 Mattias Wallin <mattias.wallin@stericsson.com>, 
 Ludovic Barre <ludovic.barre@stericsson.com>, 
 Samuel Ortiz <sameo@linux.intel.com>, 
 Julien Delacou <julien.delacou@stericsson.com>, 
 Alexandre Torgue <alexandre.torgue@st.com>, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260924144355.1604369-1-lgs201920130244@gmail.com>
References: <20260924144355.1604369-1-lgs201920130244@gmail.com>
Subject: Re: (subset) [PATCH v2] mfd: ab8500: fix child device leaks on
 probe failure
Message-Id: <179199120992.1194488.8547333779686899093.b4-ty@b4>
Date: Wed, 14 Oct 2026 16:20:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 24 Sep 2026 22:43:55 +0800, Guangshuo Li wrote:
> ab8500_probe() registers MFD child devices before completing the
> remaining device initialization. If a later MFD registration or sysfs
> group creation fails, previously registered child devices are not
> removed.
> 
> Use devm_mfd_add_devices() so registered MFD child devices are removed
> when probe fails.
> 
> [...]

Applied, thanks!

[1/1] mfd: ab8500: fix child device leaks on probe failure
      commit: 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022

--
Lee Jones [李琼斯]

