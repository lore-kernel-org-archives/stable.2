Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634667;
	b=oh7Jpr2hN3Xx4vAI6VPrT4ab/MhPGX80C0E2esMnEWdQTjQlOzTDnw+SV4Cl5V99S+d0
	 peGTdRnEFf5Ky1dlL2VNK6XnT9kayanlNC8NiOyYkX2qhSqXtmhtOerhCgBXIsJ3+XdYv
	 V0FEIIsm0yv+zbtI5RWLvoUmeLwMfMhPryvq/Yd1ZzpaSC+6+LjUgyWSfchANxArq/+uT
	 3xRQnbyBaUwig+/3Q5rgsYeyuEUNiz0GYazokQihvYcVl6QfG8WKi7bbdan3lxxpqBq1T
	 rNOuJfojOVkMGf6v2/XG1K+7Iafvda2cBXnf7EztSyeyYxK7uva2IP5KE7mtARxdtlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZQDmv5WFtdOmpAOB3wVDO8mWyJoiC/XG2cWsNNu4tlY=;
	b=ermIHdHgPRZ6n6EvgxSLMahJs0SVGXLYNphijx6JVq4tmTNPjRE8jVTebvL2tFEv42Mj
	 1sJMte0Tu+KguZMYUTNrOXgpdA7FjRi/DKAT/MCPwJl+vn8MpEYr1LXvbuodyQRyriauR
	 V80B/aabqEVQWErwtElntz+2/n8asMJdPVfEh/QYTEFh6TJo5xNUuoacWzi8vYq7I6in2
	 Ls+/EMAY4aGiMGOzYIuFqTetQy/g+JFOeh98oXVzJJ2tv6dArYGWQiHpH6XdD6lRljLoj
	 CDAgOHtH/Hb6ShHYumM/6yCoN/I/5/Z4FiWV4zDEMv3juhxnDpNa9xvYHdhu9yoXtYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpCYqIpU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73122606A324;
	Thu, 22 Oct 2026 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpCYqIpU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295851F000C1;
	Thu, 22 Oct 2026 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634667;
	bh=ZQDmv5WFtdOmpAOB3wVDO8mWyJoiC/XG2cWsNNu4tlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpCYqIpUsXMDdUJ59SId2Z3XvO7mRwE6UlZg4jFwqJraTH2AnTbINhWgyGUTbxNqB
	 b1Bdjz2XBfPgTg51tzlF+MoJzFBgY2ld727hQTTbZVXExqN9Grut/BNRGOHgpRB9/E
	 DVertIdJrPWGZhyYbuFvvzfxDAh2NrB0zzjA+2YBhkLh7p0la/EfasS9GbQS626YYB
	 FUO12vpFc32v/hzPpkCPvCKDxivBuQBAb3y7d+G07D3KAY4OS29mqkGvjx6vVU945V
	 TfjQRDkarW23jrjaFYHbcOdSuO/xlRLeDdXPfwzvLUVmn9I4PvvCYTZiokKSptgrWF
	 f2elGkVCVrKEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 6.1.y] KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
Date: Wed, 21 Oct 2026 22:03:51 -0400
Message-ID: <2026-10-21-1-daily-reply-0026-kvm-nested-tdp-roots-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021024717.1734016-1-seanjc@google.com>
References: <20261021024717.1734016-1-seanjc@google.com>
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

> As in top-level reclaim, do not recursively prepare zapping of a
> nested TDP child whose root_count is non-zero.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
