Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324246;
	b=khfb4ADv72tR6UrfeJ0+bisiz9ElS8Nbxpvuz0j60xR0MpmmK7OcHfUDDtR6AE/uPcsN
	 FracDXG3zR7od2A/HsZ8U6tSzFEzddJmPbgfdtU/DS49cKJNVM6IFKtMUHjJZP7PSSbMp
	 qkPJKXySxoDYld1f2cKsbHvrXhNUmSrw1I3Z0wiACzH5dpXkj0TGpLli5d+gIjKhK7P27
	 oftWjlhCWP9RdOzNWW/8ppZABqjhjvuPFYkC1vZEV72IbQeRqTktDBcRHM5qBPGQmJKs6
	 gmCqsFMTfxVgfFrxV16R2N4hCZ37FVOtLIhWzxyNROsLTU14w3dfNVfJLAkMGyoDpxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324246;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ia7dbg03vpds8+VV0gIriA7zroQEwNdk38JfTfIjEuo=;
	b=VVkQaBdf+c9BN25mkccDpJBZcwF5d2Z7nKA1UzuQiqFbW3CIZ8LXNNHe1dQCEV4hC+Eu
	 FhF01p6z0kxomIC/PQThwu1vAQqXm7/1ml60Hrim8yRfJrOE0F3geoMRm0uyJvJj2u1h8
	 8eWO81ERE9FRRZBHS9d4rsn2S0pbcnUhnZUZnK853EY3elkg2i/WPH4QRKNujfdnpOTBR
	 o8dTqtRpu6ftEJH66CcAFK01MdTgWudOIVTyNGzBYQ7QAV26+5Um7txSgPNBLBJa3KdW1
	 F+4voqNKh6fgrbDUEcFdf2QRDjFja0T0oXdUc/OnCx7bJ+T6+IQo9Wvgxv01u6rfEhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hqQl/qR0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC9606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqQl/qR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29591F008A1;
	Tue, 10 Nov 2026 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324245;
	bh=Ia7dbg03vpds8+VV0gIriA7zroQEwNdk38JfTfIjEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hqQl/qR0YCd37I9JDU7/lVwMJ5052Dy0WEym5QilbzbkH7qPBrjVzJnkGxIQblVC/
	 dG1NXPuqsviMFWx7QtyFsW4WNjov1WsA9Djj8NnOIdkt4pIneeJpMlP6LK+AEnzmKQ
	 LX+obmhVBXZn8KeRVJ6CM5vAKXgTCPreIxS9uPGGFMIFNFji1ShoCRzDjGEfF6wQRg
	 ZZPqpRRoONezP1Jstf+qYBLVwAIOC/XNs/U+zmLIJ+mXHfthh7TcgUU/L0G4xvIbUM
	 E63e/TUo2ohMZUoh3UZYVXr53wX0iNJSpLyHyhlxedm8+TJj6Hbg6cAnGmbfR2MUVQ
	 ggaBalr9+kkXw==
From: Sasha Levin <sashal@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 6.6.y] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
Date: Tue, 10 Nov 2026 10:24:01 -0500
Message-ID: <20261110152402.2141028-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOQ4uxi7xkQiYtjQNuso0MC6KGGpwGbd+xST5NQ_aYOtaoAixg@mail.gmail.com>
References: <20261107052836-failed-6.6-669bb5af15d4@kernel.org> <20261110032904.180619-1-sashal@kernel.org> <CAOQ4uxi7xkQiYtjQNuso0MC6KGGpwGbd+xST5NQ_aYOtaoAixg@mail.gmail.com>
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

On Tue, Nov 10, 2026 at 09:10:17AM +0100, Amir Goldstein wrote:
> Please drop this patch from all stable kernels or apply only together
> with the followup fix.

For 7.3, 6.18 and 6.12 the backport tooling picked a522dd871024 together with
669bb5af15d4. Both were added to those queues in the same commit, a522dd871024
sits after 669bb5af15d4 in each series, and both are in the current 7.3.4-rc1,
6.18.63-rc1 and 6.12.117-rc1.

The 6.6.y backport you replied to was a manual one after the patch failed to
apply. a522dd871024 won't apply to it as-is, so I'm holding the 6.6.y backport
until there is a matching backport of a522dd871024.

-- 
Thanks,
Sasha
