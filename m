Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B43B1EE7;
	Sat,  3 Oct 2026 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067189; cv=none; b=sMZaq4lsyRcfz54V0yEQeQHso7GGaBNz5hf9AAEpJ5JECBPIizySH2G8YFN+02AUsCPfr+4FnqhaoU/ojsMQPsR3qcrZjoSZ89tca4pQotBKuVLbmOgM0m1ak5DwYQgBXcWdWJ4yP2J51UkLvzIRlpXuhzDO1z19ed6Pb+T2oLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067189; c=relaxed/simple;
	bh=Ic31HEJux3OFcbIc6poO19+ZaFOmBs6cZxLUPzFdQig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUc9htI56eFeZWm2nGDiTtaUErdKkqhlxgjtN061ghMi4jqUJkFkmsMzXuk7DSrL1iy8t9FGk4DQrzRXrh+8d/U3YtSeuXhP/YLorSX1/Dmm1o9Jzr0TIPhyALWV5kdlH8DGSBYazn4Dj8rDE55q2R7sQJqxTsHMcilrmT8mTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaDNBDfu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaDNBDfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53A51F0089B;
	Sat,  3 Oct 2026 22:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067187;
	bh=+QaOQm84zXoAmhkOFMND1UHGru0OngaSsCEco/m8OwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CaDNBDfuOVucEEvBrFpJ1lt2ZdYv4rZGgzznYkeq1Ok1inYrtd9F+nVJDXm27UpaH
	 lav2THT+21IZ0YSZ8xsnLvgYfr3XcHyCIytn3cvSKJyG8qghLA28E3hCA5deXmg1fP
	 BOcE9Ie2E5d/gZRgvjhnTUrRYockMpBHsChy79x4G+e3xJUdvfXzSwfCfzG4CoAuU5
	 1qAiDA3oZSGrEsIFH5Pcvd0BpxwJvBjI+Hry9bz/1F29xks2CP+aVumDAHoVlUlx4G
	 yruJGUIjmJE2VYTM+HtAeyDMtQZpqSnpM12h9dbnLAmDBRXgO0iW6eu3IDNLGNF5Aq
	 cXmUswkcy9RyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 6.1.y] ethtool: fail closed if we can't get max channel used in indirection tables
Date: Sat,  3 Oct 2026 18:33:06 -0400
Message-ID: <2026-10-03-1-daily-reply-0025-re-ethtool-rss-max-channel-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002200059.22598-1-artem@trailofbits.com>
References: <20261002200059.22598-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 2899d58462ba868287d6ff3acad3675e7adf934f ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
