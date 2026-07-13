Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66C3368B1;
	Mon, 13 Jul 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983985; cv=none; b=COgldTauXICPoljufi2KQjHafUel7iGiAM64JdR5t0atzvvfY4B9H8+hK4gllxIgI3vidB1/EogHJG7o7UE09aEjkmcfwOBOsXc29BnvVXBQEcx6N/KoKY5IZvStqP8SO0CaKGFDBa+1a+SG36VT7c9xRuY/4xGPC94Uk9omrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983985; c=relaxed/simple;
	bh=0PLOsS4FFVYlRgVm1kIZDCenD6z1ZGWG7lEfdX5fqNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V16w8HSaDYrGMdZEVH6asJ0xYsaD6vtUGUsgQVPa6MiebtW9YKbE5B4/7Cu/JoDO0+FSxli9KPY5Yx7lNjx8Xp6lemNTz2gYra5yX3OwQPvDWFUfJMWhBzQlmpgRRzp/2QuRZ4lX+YMZkpmdhLYI1sPh0orhJtQ4s73T3CZDg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn0tNPxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn0tNPxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C54C1F000E9;
	Mon, 13 Jul 2026 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783983984;
	bh=FtIalFibIBtfNJD/gl/cjbxIZv6lFzzxbDuNWRXzgOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn0tNPxqlFf0MueHFMs82O+varatzgA1Tqxtu8UhjCouM0zlkzO6zfV8ZEQd4KvvL
	 r9Xu9+MLG3iPs8mIGZQBrvV/7Rrz+I4YrYVqHEi4kxRh1hPVyTTDbzJwPjyisGuGpw
	 TDNWv5Pnly8HSlxsNON/ebFmfAcunEBxCaHcZneahib8LYzIcYolVSD9v7InXfVxtp
	 8S+gW5QiNPPKVcdTG3isVjcYlzoV9osf5PnuQzFDmPjJh7mwKWBkzR2NxDnoBSqJdd
	 jwbo2+Lyy3OsZujP2IgaB5lKTGlHEHfEqeOG0animS2zYntQV89gBIdq+Qy20Kuaqu
	 T/3Fx3fz+GCJQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	lyude@redhat.com,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] rust: devres: fix race between concurrent revokers
Date: Tue, 14 Jul 2026 01:05:23 +0200
Message-ID: <20260713230522.2023240-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260628174451.2275679-1-dakr@kernel.org>
References: <20260628174451.2275679-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jun 2026 19:44:38 +0200, Danilo Krummrich wrote:=0D
> [PATCH] rust: devres: fix race between concurrent revokers=0D
=0D
Applied, thanks!=0D
=0D
  Branch: driver-core-testing=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/2] rust: devres: fix race between concurrent revokers=0D
      commit: acc516dfa197=0D
[2/2] rust: devres: ensure revocation is complete before device finishes un=
binding=0D
      commit: a10639966fd7=0D
=0D
The patches will appear in the next linux-next integration (typically withi=
n 24=0D
hours on weekdays).=0D
=0D
The patches are in the driver-core-testing branch and will be promoted to=0D
driver-core-next after validation.=0D
