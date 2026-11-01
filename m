Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571424;
	b=NK0Z3CmsIm27d2HJ8lyRr1MOfg949a+lKsu3GvpR1sF7campVKHnDamUJ8aqcuNb6vcv
	 1G7sC7S9MCvxA6O08iomTvvoqu3vRkIY7mGD5XGokVaPCqZraaTHxKHlLl7nVE/Fn0Mko
	 F8wVore+kwURo1sZgoAKo5QPxfbT1QBj6vEq+dfj27g1IH8i3QmaAqAeNUBDppUQAy4W1
	 c9/hapUjntuq0jZhHUmq53uks4XKJYhTIIpBRJ2WPt8KBOWvbKlpsPqFT7KtxqkwVDNdx
	 XkNNWhq0F3IKndawjv4fjji7qa0WmYZ49wts9UDBy/Yh3ZnT3ar17OsZZP16Ial2DbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571424;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mwQ54c5JkfJpHrp/y55v3+7zzLJcgDNuv3Y/w5BwAbI=;
	b=FVc7X8dBzPmDvsDt7RV/jlCMI4n5gIEjrPKj9b5sDeZ3zY2wcJE2mv+/nwClEC003vbL
	 7PmH6joRkftQxNZGCKk4TNF82tHHmKNzlY+QX/tIFPv6AUBix1xE6cCAWZJslDps7If6g
	 AVkLS1qxQNeURzaJCyfmQLZM22O102upbTj70/TmmmQZa6ymBkwh2W2AcxPGO2t5biz/u
	 CILjYn6Ra0hkULP/mpGCEdW6MLdHA7qBZIPJfMoTX3H8DZWuvmwuXfz0Z7lO+isLOei+F
	 AoICQj8aFIUUGi8lAIHQ6QbhrqLvxZW0gG1isNdH3nSM/dgvwzL8Nb4CxXyLkBYbbVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiQKvFdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670B6074111;
	Sun,  1 Nov 2026 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiQKvFdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30891F00A15;
	Sun,  1 Nov 2026 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571423;
	bh=mwQ54c5JkfJpHrp/y55v3+7zzLJcgDNuv3Y/w5BwAbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZiQKvFdKyyD65+V/GWduNoaVFFc7LGWrjAt3G2vakfNBLq64wie4OtAB6Lxc2cPzm
	 bU/0maqb8ZSvBgayOuYeaQxSaxCKsLoMgcR0LF/TSdCYbGWkbMB7vvPuNFOuveS/zP
	 8wg3MU06V9Si4ZkuKrfCO0Ch0SRRL/ez40yzZ7d2o2K1HKATkfWSebtBA4Uf51hMa1
	 VDiUGOOsMjstqnDIzz+e/WoXOWvM82m+tZ4Hh4r3b9RzjGQ4EGqswTPobUzsua9GPi
	 /7JnHzakObPpyVXHNcfYIHxhdW0rQnaIz0VrOtcSpkTv1hwVH+VwKuImOMK+A0TNCS
	 gvYlWm4P8QYIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3CE38003B8;
	Sun,  1 Nov 2026 22:17:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] riscv: mm: exclude invalid THP PMDs from page
 table
 check
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357142229.2624073.6074262524879972441.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:17:02 +0000
References: <20260523042052.35476-1-cuiyunhui@bytedance.com>
In-Reply-To: <20260523042052.35476-1-cuiyunhui@bytedance.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, tongtiangen@huawei.com,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat, 23 May 2026 12:20:52 +0800 you wrote:
> RISC-V THP splitting uses a temporary invalid PMD state where
> pmd_mkinvalid() clears _PAGE_PRESENT and _PAGE_PROT_NONE but leaves
> _PAGE_LEAF set so the MM code can still recognize the PMD as a THP split
> in-progress entry.
> 
> That temporary state no longer describes a user-accessible mapping, but
> page_table_check currently treats it as one because the RISC-V PMD
> user-accessibility test only checks whether the PMD is a leaf and has
> user permissions.
> 
> [...]

Here is the summary with links:
  - [RESEND] riscv: mm: exclude invalid THP PMDs from page table check
    https://git.kernel.org/riscv/c/bdda2887cbf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


