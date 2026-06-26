Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778743A8FE6;
	Fri, 26 Jun 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496502; cv=none; b=PpnkQxSHJOPIJlJLbSd9gBa2RCfeCb5D686F1iUaWkKhokVZ3TboyGqeMjJK8GZRelCpXsoBtfxkxsiwz1vWWo01k1on20Sk740Vnhz7oRXdZNlHtEgU1Va57wJZUoTHuYFeUFSSk+CEhbWjWHQODcGHoviEnupufFa/j1C7pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496502; c=relaxed/simple;
	bh=MnpS/bVXBKyjAr+56/eH12Nr5innNOyULYxUUW8t0S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH/DamHT3Y/IpGiQxve+D05Y62oJLdW1yYjcyWuVNNQwrUxolS30DM4rScu4U5DrPsYh+6eoDYMoMAdh09/m1hKFsXrUd9+joA9aAD47AlFvrYfE9B1jBJurVKDVLSbARwMzJ3HwLQfG2PTnBju1pBpuZIq87Yy9HTqalguw6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2HkXU21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2HkXU21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D5D1F00A3D;
	Fri, 26 Jun 2026 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496492;
	bh=U+4P1nBtf+U+p+vNNa4iD1dzidAYl06kWF+nNUwkJ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o2HkXU21KYcZmgUY3217b2WQWuSzrG5vcHtxKLcZ/VXx7l1/T1khTj/NeHPYDw1Kt
	 yHZjIa4gx/cRDeligMy4sc51Vck873KgdpTBOTaMeguCu8sbAfKBAq2v0RKSUkEF3N
	 F0q0yet648qJFH6Pmcq9lzxYNvQa1MvLecL0bhFmjrAMsF5LBDE0Bn12aFvV0LpHw3
	 7PFS+muYtoEhBAwck9uAhYkfMYHQyY/oJ2GrS0FrQzpNtDZ8y1HMMfrFZQthdxs2/x
	 +iCcRp/L1xdoGTidMvp7lLcB2ObDdU0eqfHL9NLu182LTO8XhrtvQwPQgWtB/sA0ar
	 vyfSkfVSCTmqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:23 -0400
Message-ID: <stable-reply-item006-role-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112425.1777712-1-pbonzini@redhat.com>
References: <20260626112425.1777712-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
