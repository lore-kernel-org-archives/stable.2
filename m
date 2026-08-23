Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10D2472A2
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787456569; cv=none; b=rqpB80S0p/rpyYb7wpJlVv8QklNJJkWsk6zoG+lY2Nsa9nrpwerXqjxG6EEelChUsrkyC/mnuVmQYc33+keLhh/zBjvTBNqZhmrjdEJDpRAaF+iEQJdHM1X/bxaH2EQUZ2zRKw65TYK3X+4U+AXsIf28e2tVeLUmWof3MGJ7dGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787456569; c=relaxed/simple;
	bh=8rxia6a1mqzzWn1fqRCy9P7ukWdR0Q3Q2roarFKNy68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIXVeazxY5y3KSms7Ox0JIcRaVZPz8CvX4DM+oKBPHhC03qw3W0db5RMdo2irVuvrM7Vs7nBz6WkSA5sbdVB3vImDBOX/gekQKHjAQzYLNMr7LYvoDb3TiZ+YLRp2nvnTaN3EBl56yF6q1dLmTVmpQ3xfKEW609WG4lhm2Wbi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBW20+dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBW20+dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47721F000E9;
	Sun, 23 Aug 2026 03:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787456567;
	bh=gZNJRCHe5WMVLh9coAcy1NaLDy86KYeNDvr0RFu7TCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HBW20+dpewrG9iHY1uYDhkTwsUoOkXiWcBTcguVuFDCWqVh0xhVUPFhMV49EbOzDW
	 ZYPu57/Y4Ty4f0aOFGtTgdEgjjwJVHg9WLT0acoBOQZykomPypr2lD+HUCtCHfONgf
	 oyVJAuD9ITx0+S0XyLkCFS7CyP+MYVianEffCwS9qTgpL5KtkpMe3TJzwPTMmHZZaN
	 qmRKArNckDPoW4mFA8B+mzrVX+1druPBxGajlg576dB4HXNr4dUmobfh8DZJVlZ5Rq
	 ew2QUHshuZeFa9346I3A/XwTtTKHXlj9scmwSTS4GpNzYi9y7vbTNaCBXweu4drNTz
	 SmXcaXuq/r2Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kenta Akagi <k@mgml.me>,
	dmatlack@google.com,
	isaku.yamahata@intel.com,
	pbonzini@redhat.com
Subject: Re: [PATCH 5.15.y 6/6] KVM: x86/mmu: Rename __direct_map() to direct_map()
Date: Sat, 22 Aug 2026 23:42:44 -0400
Message-ID: <20260822221000.rc-kvm-5.15-orphans@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <010601a02454bfc0-33fc8bd0-1233-4be1-a122-da1f9490105d-000000@ap-northeast-1.amazonses.com>
References: <20260730192933.3123642-6-sashal@kernel.org> <010601a02454bfc0-33fc8bd0-1233-4be1-a122-da1f9490105d-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 21, 2026 at 12:38:49PM +0000, Kenta Akagi wrote:
>Maybe I'm missing something, but commit 2abd5287f083 ("KVM: x86: Check for
>invalid/obsolete root *after* making MMU pages available") cannot be backported
>as-is. It depends on is_page_fault_stale(), introduced by commit a955cad84cda
>("KVM: x86/mmu: Retry page fault if root is invalidated by memslot update"),
>which is missing in 5.15.y.

You're not missing anything - you're right.

I've dropped all six from the 5.15 queue.

>I plan to send a manual backport of a955cad84cda and 2abd5287f083.

Please do, and thanks for offering.

-- 
Thanks,
Sasha
