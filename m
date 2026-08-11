Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737333DD51C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474570; cv=none; b=Ey4QP4g+B2aqCu6Kvy9G7H8elVQfWI2uBoAEDGkRfZPjxJxO6KaePaZ+p31bQy8PKT7cwPwg7vS8OOVj56r8ryYvaOBJI6ljLxRdBEqLE6DrwaeHoW1TCkE9SxSaY3slT2+4MucwDMXlBj2sFPr5nqRJ8uNeGYi1AKZjtQhRnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474570; c=relaxed/simple;
	bh=QW7Zv/9tAbhuYT8PCf5K44jphJ48RTXSlPDnMmu7cBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkAJtAoK81cMDJNvsMP2HSJtQoLk7FEMW1moRdqSpLLzOsSneUmWtUPr/zC5IIMALmfyutckXj2nCIezittzRMyqoGU9D+6xREGzaKmgO/k/EsiV0gDGomsMWlnJ7dY5xn8qoPzqTS6JUUu6iIwhjfSVyVgjFY7sxwibyRsQWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wql8TP3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wql8TP3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8787C1F00A3E;
	Tue, 11 Aug 2026 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474569;
	bh=h+KVDCk8F+gQx8WV7VGgIXazqEc3b0l0j6NmWH8uGnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wql8TP3g1OpZJkmsUfyg+AIYpGsL1CfFSiWmWIjRKzh3Jw5wehWc5JyouPR5XWKGe
	 kfqNsO5wrU42zBBH/XMvYTNgl7Pl1lWhXYCC0kXfAapyWjZkAdSkItJ3VK3x/y/LGH
	 ePXKg3i614I2ezcMqgWMk4AFx+KCtAohLSU7K6AddpL5TexgRwYPw3GghscOSr1n/b
	 ao9Xa8160ysnG7w4QmOjqDFqqew5Vx+aSrRtxSQJVvukkZO4mTKrUSiPFCgItXgCFe
	 g56f7fALY5+n56H57KpmgSR31GPwy+jiDKx57y1k77Frs/FJQmNwuVkJSJdJm6lbRA
	 TtRUAwDzE+mrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com,
	Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 stable 6.12 0/3] s390 KVM PCI backports for 6.12
Date: Tue, 11 Aug 2026 14:55:53 -0400
Message-ID: <20260811184500.stable-0008-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810182128.5458-1-alifm@linux.ibm.com>
References: <20260810182128.5458-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patchset backports the failed commits to stable-6.12. I have resolved
> the merge conflicts and tested them on s390.

Thanks for the respin - this one does apply, and 3/3 now falls through
into free_aisb: the way mainline does, so both of my objections to v1
are addressed.

One thing left in 1/3: the conflict resolution keeps 6.12's existing
in-loop

	cur_pages = atomic_long_read(&user->locked_vm);

in account_mem() as well as adding the pre-loop read. It is harmless,
but it is the only line where 6.12 would then differ from mainline and
from 6.18/7.1. Could you drop the in-loop read and resend? The same
artifact is in the 6.6 and 6.1 submissions.

While you are respinning: 0cfe660559e8 ("KVM: s390: pci: Fix aisb
calculation") is missing from 6.18, 6.12, 6.6 and 6.1 - only 7.1 has it.
kvm_zpci_set_airq() on these trees still computes the AISB address as
aift->sbv->vector + (zdev->aisb / 64) * 8, which goes out of bounds past
64 forwarded devices. Could you or Matthew include it in the resend?

-- 
Thanks,
Sasha
