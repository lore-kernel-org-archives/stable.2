Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1C3AE6E2;
	Fri, 26 Jun 2026 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496509; cv=none; b=JEa6VpUuWTF6B/6IYp664GF/2bKeIq+K7wsddd6Uu5MpN8BZacJJJnn7Iw16eZAsb9a0l65V3By1j2QufgfUkKvBMhL+HPqWH23N7NCBZMzk7MhNkkZVkuoomc0Owp7T4e+C0AWPB7GDdr/+zomeQvu6vpVJQw5dIPugDFa9iWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496509; c=relaxed/simple;
	bh=6wKDU8kni+D8gUhr0PCGpJlV7eGVnjMqrAGLV42zaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnARjhBk7Rdu8bNLJS9k0hJ4LyWVoIbMZbY/YTgxD8wVKzd/CI3HxHb2EPFBTS/yWuZ/lJI1TFDuzyj63xN5IblAuQrqUlPKnl7iRmUVVIhnlbwEVfS4pD1yMKeABCpwatSTAWKSUKxn9+md6RHX9s31nyotKuB37Ov4YXiJdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMhjP2IM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMhjP2IM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A271F00A3A;
	Fri, 26 Jun 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496506;
	bh=utEY7dFJCHv4+42jYfaqUfCjumDWcSH8XwSXFZdUCrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMhjP2IMzQcegqX8LP490RlHbBBBDJeTeHUQnyMWl/7Kvwy4WWFoSuk1CoQPrfv6n
	 jd2mtEE7zfSIwOgugnIlJvVo5BVDP2ZrdNhCkyWpRvDH5DNNLy1ZFjiJV8Qw8ctg9y
	 yGAyrDR1LkrwTQDQGBcWQb47X5mjGcU2JGLivnL83Z6NjF1ma2LQ5iKwRGLNvXhSOS
	 SJz2xrtMyseU63OQxvfyQ3KTAHwsVaDWHlzColLXrpF9CiXVZ8nXf8bhzyyhrjzo/e
	 1Hyd/Hr3Smayhntxxeo2lvzCKmFmw4JMARfnSt/AkewLylNazjg6cIIDkzIYY7OU0L
	 mJ7xlwZN0Bm8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y 8/8] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:32 -0400
Message-ID: <stable-reply-item008-kvm-515-respfn-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112606.1778248-9-pbonzini@redhat.com>
References: <20260626112606.1778248-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  -	if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
>  +	if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&

This drops the !kvm_is_reserved_pfn(pfn) guard instead of adding
is_gfn_in_memslot() alongside it. I think upstream could drop it only because
a8ac499bb6ab ("KVM: x86/mmu: Don't require refcounted "struct page" to create
huge SPTEs") rewrote host_pfn_mapping_level() to stop touching the struct page
but that commit isn't in 5.15. Does it make sense?

-- 
Thanks,
Sasha
