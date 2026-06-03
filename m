Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685E3D1CD5;
	Wed,  3 Jun 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499676; cv=none; b=czpxuQyT0GrfZjzdKjaeUdJhgq86vKp7ExLwUDgNriwwFy5MeSpz3Usla1QQXPZ2BW4cUBNYiyPsshJ2q8D1N9dXbiP5+ZqlUzxIaHRyWCi7d6kSQUxtsQgNG74yykQVrM3LNq2dx2zTDgeVl3TOcm6HK+Cae6mXjSV6DtQCvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499676; c=relaxed/simple;
	bh=x2CyR83K8Ui/zDUZ89B7pi39PinAtPOk+fTNyDbzn4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuNaDakvQCcXaR7BHDkFsnZp8P0LDo7eAqfEav+Js4l/jW10arDMTHEHctgGr7VVGzmyotjs2EnA3+vieh61d3uGASoSX1PZoTsTaesFygaCTwsvwDfyldfXlZqrJ5KEdMVGV4UDihnjTdwDkPVo/nZk38WrKjbTLLuHrMvqdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvKvQgHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvKvQgHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B421F00893;
	Wed,  3 Jun 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499675;
	bh=4Kj4voNkYXV/vTBaXRccNGRUErzTkLYlawm8sg0S9go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dvKvQgHAZ3Wn4VC0Ij3yFn9JQvy68dnSAP9kzPvQSLmAPNSJNThmoI63V1idBdztt
	 Q1KKv18/X84MXwIEtUyt9eCk9eh7A2vxHlQ22Bg3Z6un8Fm38D5IBhcfyQ6t8Pof9s
	 dtgzXbIroW6o1VZeoFhFgvilBt1tj1ki/unmzZoNP24HIroG03YPDV+JokmzTMuCFz
	 dmOCUmkQJaKchhKn+tf79uqP98+DtrWccj/YGeONkfbp15yycSt5L9GKzA8J/SSkLl
	 pVKuyZWDFf7yCOl1ppeF6WGJdMA5Orz5lInQmlh5wDpYYZMXWCdk6jUUqYAgMoJ8FZ
	 oujNFJ+Fptl1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yeoreum.yun@arm.com
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	Ian Klatzco <iklatzco@gmail.com>
Subject: Re: stable: please backport 3b7a34aebbdf to 6.{6,12,13,14,15}.y ("perf: Fix dangling cgroup pointer in cpuctx")
Date: Wed,  3 Jun 2026 11:14:00 -0400
Message-ID: <20260603111500.item004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
References: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y and 6.12.y, thanks.

-- 
Thanks,
Sasha
