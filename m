Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88139E190;
	Fri, 26 Jun 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=Bm+u9dhqPCidHXFzLhiKpqhHG45nImeQbSiGu0g2RItd0juAWFVCQ4OFJ2f4UU87ExadzH0zyEwc588hYaWQ3mI73ShsZZxS1S2IpUdt/nHYUtJJbAOFpCv1zAmNURpGTJQHb5YJ0mORoRg7Ag4hTXnwYE7Z8juDjdMgxwsB4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=06d5uVBN2Ciy3rYnnQahGW8rFiLbpJJuftkDVFAmDio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOLrm2jnih/EoBT6S0dDwMShAKEEuMCTAuRW41WW6kIdRg+XKlTCVFU2HNRAc3qZ+g2jEFoThJGD9dLGxlCFvhMIyvH+W4jaxD/tngSQz3mk9yaFW4Ofd58STKJ3XG0CZTZkm0REXZv2Esrek3oQ69XqxknvG08rpfC0ZTqSwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laQTvovn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laQTvovn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E538D1F00AC4;
	Fri, 26 Jun 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496498;
	bh=v9iG/7GG+ArpDv+swKv59Tccl8BIyxRTE8loiVLJmOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=laQTvovnboIetO+z02M7o4VfZOI9fjRNP79Mg7P0ML2zh3YalhtIXiHfnfRJrVTcY
	 bVlXHalsBnzN7m42xKFnPfeS86t5mkMvs46RLIFcABWkUxEfz3FA4jx3hMOka+1iD8
	 jEQ0CsBqmtuP/7PpMVlzqQNtji+JSMFvX5Ia8HxJIFUkLY7H7grnmYuXsQulkUbzgi
	 bHzjWvp/nqFh3BDEa5Wl6kNhXxjDaBWYrA9esl+L7760VVsq+BTVRRhpoIVjPhUdjU
	 SS/brNiukF0+K8PbWbaUck2NTIc4UP7M0QfmhqGANor7VFWOHuxiLI8oDl3kkUjDn6
	 IzgvkTIqJS2jA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
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
Subject: Re: [PATCH 6.1.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:27 -0400
Message-ID: <stable-reply-item007-hugepage-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112437.1777775-2-pbonzini@redhat.com>
References: <20260626112437.1777775-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
