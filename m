Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4CA3CF962
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701621; cv=none; b=EynYDStk6Ah0HNh6kKwVdWklbOIjd3Rfx3uTRNLHcjS/wifo/KW1xB7uJNFwjIwO8Tu8EkrIGX2iC6XjC9kOh4hBEp/nKoLPNuVZKd47RGybxmMM8suTUgyhU5Z7XxiTkxzXjKhGaazsFQVBF/G8UN+k/NrQ6Ka3KkZV4lQ10oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701621; c=relaxed/simple;
	bh=Wy8F/rsw9PQnO/aiULGGk73vCUj5uIgbqJRTBNnYRFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaXpK9pVVZE18lqf0IiVQmt+OlKnXnA7mdXXfyOknRJq8Jz631wl+UajjDbV2xGA/LpXe1hcYemRn6dG9ZssX8phicnuOXBuIOK+7hfqU6+KedznG9zj49pex4hGFJ+evjACWf0NB3NQAethlZ7w9A144vQqqWu6s14ZzOVdlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8TCud8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8TCud8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28981F00ACA;
	Sun,  6 Sep 2026 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701619;
	bh=cWbdNcdebucgAJfvKyslUckGRa+RA6AkOqHQE9rguak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8TCud8rE7tZOxMEMeZzGmfpKN6cjr3WgbgbF6tSDuBRliDawA9xhgOSoU3W6DlRU
	 PjOsa7ssPMoFlwdsh64o3OrMN7OFBTjUKnolhxUZ/2jMRKL6drrJupp4B5n3yPE/Sd
	 aGTgd/xe3y3M7TVprSpRl3luMzMAzygQUyCfKk23XyHraiA6STHoE+2T6eIpkfsfo1
	 Bc+083RtlWk3k4zwJdvyLuQDHd9jP3/sjaHMFO7cRvSeaM9HNJoO2rO8oH5iMzirSv
	 j1vfjw2j47q9bYbdRFsyXRUSTJp9RJfdlAU5hzZSa+u2QGPrbNNfiJNG3b7b/VrWsL
	 plYROrjqfXvTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH 5.15.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Sun,  6 Sep 2026 09:32:45 -0400
Message-ID: <2026-09-05-daily-reply-0015-ovs-ct-limit-uaf-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904094519.1817105-1-i.maximets@ovn.org>
References: <20260904094519.1817105-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
