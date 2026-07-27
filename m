Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5C3D5C0B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190798; cv=none; b=P2WuhlZqyA63Pei7/cq2dPzWhL0tLTA1VQlDKg8G/Em+dwpQpzyH6i9CQ/jiCOgf12XvoXhLoKMtn6adCNQAkrRsF3c/IwfO4vb8dk9O4L8NMulLSjVTZp2jtIgAV0dvTQnV/mNYi0lNs3wYCrfTjzlyTUeD40/xqoeXEpmX/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190798; c=relaxed/simple;
	bh=1b+cdTHzSaapgf5YuKbvyBSDIZARAgIVKqzdxIJJF8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch3JX2k4jNa9Ze39595HawxVMtHGr6OWUZmHborILfAzvlLs65rQMnA0uD2UJXefEckmETEdUBUerFyzexcXmgxwpLZ9yhznzYpKCVhy0grZcZERm2EuCS+CoZaCPUAAuluyias2mjY/3iz5MhIX18+n5osEn72/ed15lUlyiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnrXmp4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnrXmp4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8F11F00A3E;
	Mon, 27 Jul 2026 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190796;
	bh=EdtipAMNZyfnBaNC45+WnR+AnwHNKeYOXUPL71qtv5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnrXmp4bQJzUaSeFsjYu0neas9G0Xev4lBliPbHSqbHkYbXO/GDuVazzqY4FY7ck8
	 KIaVnSDdfWEy1nwpZj0z3KxrQEGsSlW58VWdLGHrBqBr6Ca0YEOoP4lsUjH/A5KUIH
	 ZYSJE7boDuddaVO03EzREmfhbQvwitSSWEZSPX3FJ8t0cRKdOSPlE4CwN5E5N6Ih6A
	 mK2hOkjUg2haraaWkG4zVEqZvW4mWwn7mg0h2Dc2LDMbBntAvVTJPhLYPFUbpdV7dU
	 IbSXJet8tjIIElRAHmhWpyZ3WtqT/qaiBX+woa/iAEz9wpHN/uhapwINt/Q+Erp8gc
	 kqFE0AkizKSPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 6.18.y] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Mon, 27 Jul 2026 18:19:42 -0400
Message-ID: <20260727202413.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727024222.2180660-1-xb@ultrarisc.com>
References: <20260727024222.2180660-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 10:42:22AM +0800, Xie Bo wrote:
>KVM RISC-V tracks guest local interrupt state with two bitmaps:
>
>  - irqs_pending: interrupts that should be visible to the guest
>  - irqs_pending_mask: interrupts whose pending state changed

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
