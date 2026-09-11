Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC17443C3E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125683; cv=none; b=AOdSXoWW9mO3vC/5YefU3HTEZNRPNGVXs5jl/QAPlmefJwl+oVJsPh2JZpU7hFqlbz4wy30EtQQBYNk38RVTfpIrRgqj/grxr0WDpCcOuNwvi97xXvN6vdVk90VQBR0skvSy+7VtI7kK4kX0zHo4wdMPkEvboTsXphUw51JuyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125683; c=relaxed/simple;
	bh=s+6Dk0bWK98VzzP7T0Z6b/iFjqF9+S0wfOwMhFTvwpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuCVQODqUDKf9yjKp1cHbKkvwFHghIDkUra3aXltA5H5+I11S8qDFzIXsBKmGJPlAJZXlD9SceNVHwln64UKMrCtSri7t1qDqtMs0nWMyeievqRAQ8oCNxUR998o/izYaCyUBDp078fyK46DChw2zIEx/tQ+Xth3HFomSl2/pPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9tjRvd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9tjRvd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D951F00898;
	Fri, 11 Sep 2026 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125679;
	bh=uoWEHN4b7moi+0YJjq0Ej19D7cs1bTaLyqr77Upvm7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9tjRvd6ABKwqY9/kz/Zr0WhFXY21Q5GrNzVESkbiNoCYzG5PyHtjIRcuiE7Y49Ce
	 QLdmC8JGmEGbrmwGbKzRlIJrrIjSYRP1b4lsflEM0bHSS3DMJQZfjJHm/FhL98S+4T
	 J9rxeXD5FM+JHiHma5aXeYsI00+obqoyiv6SNtum+YI54HiAz12pnhAyTR9iK3SBx7
	 s0G/MAChPEGn6YWJKz3nnYRn8jib/ex/6Qt4eS83IUxvD96vEhQbZXugSTQpZXHJVT
	 Tfzg0MsB3+c8ZuuKQxZbWkZejVVrmT3Z1NE5vlPEneBexehBwDMaH3tCRTNVAFFgi8
	 4aWUuT5AGJJ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.1.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:38 -0400
Message-ID: <daily-reply-0019-re-batman-adv-bla-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190319.1067807-1-sven@narfation.org>
References: <20260909190319.1067807-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 08645ab95768b88e2ff85a89211994651710465b upstream.
>
> batadv_bla_add_claim() is used to add claims and modify the backbone
> of claims for CLAIM frames from remote backbones and local packets.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
