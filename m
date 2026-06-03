Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E133C768B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499672; cv=none; b=N8jbcwZnxZgzOe1cb34QIzlbPwHmkdG6o3G6DMl7N1IoLB/MP6snZOFW8uXlx17BMoS8Vb4oVbUIzKQb2gWA8va658eUttFmO5BVGg1JTWRAMoUQjd6zIEKvQhHURkbhHh279SvodrEQMljzUEdhNZs0hD+ySa/DkezvfkGOVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499672; c=relaxed/simple;
	bh=Z7XoiUUmVDjpWfREjQmhaSTfBAAAk03c8TIqrKMcsQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsACj54iti5flxKTYTdd0z1B9oVuMes4JrRkbB/eyULTWRL7ZSaOTw1FoZy7fsznnuwCx0taRbed8Yiu+1yPlALVXN8cdh8GEeTynO+mQw4uuRHcdpHmj3NDs42g0lYlJkPqxXvGji4RGJonnmkwvBWeTtAKIptIpCVwjQklwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGYYN6SB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGYYN6SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F22C1F00899;
	Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499671;
	bh=iK7xJdbxq8LN1lS2lXeLkqyYOdRiWw40yolvyhoRdJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGYYN6SBlOY8pRNSwbmhmhOgeAqf48Or5p+wbx0aEvubyK8yEuV2A35LvRkd7UsPv
	 kIawHUweM6cZTGoSN2YtkA/G+nDd/vj9T8CpCZ9ikyfY5gPdNNLpT1RigBA/ZHQ//5
	 JPM9gOJfxdOx5n3deZxoBUNxO/0MPOlaJ83IpJq8ONE1eAPwxmxqty2ypA8KPXDQeO
	 5WOSMeRoEFNzAkOyfJkfV4mdzZpoL0K2W/0m2+qdtUGYvaqRUw1Lx2i++GNyaErV1W
	 EgZMssAVvODF4XzLnJYhMw6Lyuxqa+xp/ySP90s31l0HK39G9PdXX4Nb/EYJR3PXsV
	 gGBEaGFDSUUYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: prevent TVLV entry number overflow
Date: Wed,  3 Jun 2026 11:13:57 -0400
Message-ID: <20260603105137.batman-tt-tvlv-overflow@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180618.413634-1-sven@narfation.org>
References: <20260529180618.413634-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] batman-adv: tt: prevent TVLV entry number overflow
> commit 99d9958fa10fb684b2a8e2c48a8d704122721420 upstream.

Thanks Sven. This one doesn't apply to the stable trees as submitted.

-- 
Thanks,
Sasha
