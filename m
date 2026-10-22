Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634656;
	b=pB3vNAG31Fo2pB+nyF22j7lNEOWw/01N/QmEoNYEE1F5e5fG1FPAXJMFokzqt0nFjq17
	 s7h8t3qAsmt1ggwMaCYOFezjEv7+O5Sv3S1NvDK48xawi7mE90XsKtKUftlUgAdb6Cyea
	 qtlzaDGK+6iDeW4GOSKtzodPkl2wJZDpVSBk9FfYbYhOSWioN/CeZF7nXB4ZvzOmxGk8C
	 PSnmv0HFYg/GiUXWWfg7bQ8exKLrkW67giNEka2uwSHuucmu+/EqYS9Xc5Mi0lHPNZG7T
	 SEiYGQwGAlFofMWPeGtQ5aUnpmEl970PRNtlgTCOeX6a2/tsjIPgEj6luVfEHMLKDBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RFSo/RSZcZwHvG3kB9k+sUY8W1QP7eb1A6/kdFTtfZU=;
	b=k8UJlsMYvTg1EgWUJYVSYe+hQHoCPUnSOb/9q5AoLt6mlrM+R1T6t6WXd/lolh+cCtpT
	 5dTiYjQMO4d/Qtzm5mrJRyGFgQhZiqoyxgboOLO30lnjGa/f8aFRhtUoBylGsQODtcK7H
	 36kLmxA1IvkExnwAWCEinRoe08fxBgPdLFmpeRHl0QVj4X8THaGdwIYwWkcM218bMTUue
	 8Mu7Jsslw7dPaYOmHM/HIMeIHNn+8ZV4jQoMtdnfZT4Crr4Hn2chJv75KVClJWZJ7P+EL
	 QPXEnZB+RGMtqv//HeDuwZDQWWRx08o6gxb3ijQn0dDLZ6IV9D7C+i9mzml++KZM5eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX4h5rw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48F606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX4h5rw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5C71F000C1;
	Thu, 22 Oct 2026 02:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634656;
	bh=RFSo/RSZcZwHvG3kB9k+sUY8W1QP7eb1A6/kdFTtfZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KX4h5rw4srsPEqAQcwR6bX/37ciXwa4C4iQmFZmShRUEZJXXDxoIYcdlrE0idg7iD
	 N2/IoltrFGboIpkPJrwfIiNZoGsOhoNj8tgPOOcGf0A0Wduq+slzjIert7gfPl8oxv
	 CwY7OydiKJI1zx95aF4OChqx4a+760myxOOTTYjfBj4WdLwashIKjBUm/7btT8YrIR
	 vqiWyho+vrbIAyPQprWCyYbY6Mg50OsG6ZHX+HYHdbdPyubiyXjH8HIqntvj2dx4WU
	 YIH2a770+VbTgl2FrjfnjLnyvL9wzN3ReWZCHx7hkE3CK0BI0bVccVoNCRkoiv6A/W
	 wIza/XEvGKdlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Di Shen <di.shen@unisoc.com>,
	Ling Xu <ling_ling.xu@unisoc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.6.y] OPP: Fix race between OPP addition and lookup
Date: Wed, 21 Oct 2026 22:03:41 -0400
Message-ID: <2026-10-21-1-daily-reply-0016-opp-add-lookup-race-6-6-already-in@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74405-6-6-v1-1-cf8212266b3d@bootlin.com>
References: <20261020-cve-2026-74405-6-6-v1-1-cf8212266b3d@bootlin.com>
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

> A race exists between dev_pm_opp_add_dynamic() and
> dev_pm_opp_find_freq_exact():

This is already in v6.6.160, so no backport is needed.

-- 
Thanks,
Sasha
