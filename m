Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC04302FC;
	Fri, 25 Sep 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362119; cv=none; b=c2NJkwXJxXXi6qeFq3Xq2Kc9nh2Bo86OAhmaX4ePo8Cfz6fWPxnqZR+WTAwOc4s475isl9mB14EJdD16uO9evwCGsI1yVANwXbU3nFzDpSMaQdJgsTXGBGD93D0EMmO943LbFPs51khGUjyaOKFDWp+6LJjwcaitqSJsd7VUanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362119; c=relaxed/simple;
	bh=v597xxRoqaLyRWVJAUNDPYTFUXIwPtMYhIGpjBbvo8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKOapZK4hFTRaEvnuayvCyB1ZK2WHB065UhM9gNpXXNniquzH0qZOW2dtOZd4BMW1lrBTz5zwtyqPY3qZ3zgpuqM0jg2YhqUFsCp/DGNBH1qOAL1rVXvCyUMRUByStbbD9xsvhLQoJXlgapztjKYSc1S2fFG4vmAWW7qAQA6W/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtpkkkdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtpkkkdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D541F0089C;
	Fri, 25 Sep 2026 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362116;
	bh=b/H6EFLlQfTgJpgg3A5ph13hVMMua26joQYGc6TG13E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtpkkkdQyajIO+9LVRO9Q1BhGnExME44Zo00YZLL0OzqIsyj9XTcuFE70+qqb+PxO
	 z7DYaLssPeS+OoBK0ckryMD58MA1A3bJ4KJaDOc06bViOvXhYlohONdRDDvVVHNiqA
	 gMF9113ZyKw17Kci9GlBz17b2WuyIH29GDSF8dWld2G+xusrZ8fnTzhpMNoJz4hEYS
	 /KdK+xtWcmEj3suMPVtlfja15MH7S3Tf1MgKQ38cHy4JZiP2hMegpfl2MPl+Azk71g
	 V9t297T6CS+HvhTLM9GRCvXa5Rjou+ycYlrzy+B7PWph9jzGZdUZXj1N7JaLNKUxqh
	 vlUQqL0+dx5ag==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	David Matlack <dmatlack@google.com>,
	Kenta Akagi <k@mgml.me>
Subject: Re: [PATCH 5.15.y v3 3/7] KVM: x86/mmu: Derive shadow MMU page role from parent
Date: Fri, 25 Sep 2026 14:48:06 -0400
Message-ID: <2026-09-25-daily-reply-0014-re-kvm-mmu-role-prereqs-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arVZfjUskXC54OKZ@google.com>
References: <20260913155523.7423-4-k@mgml.me> <daily-reply-0006-re-kvm-mmu-derive-child-role-5-15@kernel.org> <arVZfjUskXC54OKZ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I vote to backport the relevant upstream commits.  Reviewing this without those
> commits is a pain.  I think it's these, to get fairly clean cherry-picks?
>
>   dc1ce45575b3401102568dd60ba8894849d1d64b KVM: MMU: update comment on the number of page role combinations
>   41e35604eaff2266ba8523787ebe99c5ca4c4045 KVM: X86: Remove useless code to set role.gpte_is_8_bytes when role.direct
>   b46a13cb7ea1137b2e01dfaafcacd5cd79db8390 KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
>   bb3b394d35e80d7a58ce015191e4960a13f54ba5 KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the direction

Agreed. Those four apply to 5.15 in that order without conflicts.

Kenta, could you send a v4 that starts with them and then carries 3/7 and
4/7 in their upstream has_4_byte_gpte form? 3/7 doesn't apply on top of
them as it is now.

-- 
Thanks,
Sasha
