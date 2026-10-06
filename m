Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68C49D5A3
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322588; cv=none; b=YUFOFvxNGc8y6QbLi96galD78H8cU9xWbD0e9HEzzg1vCt5w7JohfKxjZQZ9CiXfzfX3ORl5hEXPSN70p/JSYb0qyNlpVRCPgIKpDW/6fqm1B/I6N0hyEPrd77uq7oM2R5bD61ELQnexq4Dt7v9L/knBVTHOqJ/1o6pIcL9XKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322588; c=relaxed/simple;
	bh=CIMRAJusXgSpzYD6ekjeEuTsE7wNmAwjhGpgeCi2pPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoBaxJ6DhQDUKfDN/tjCZlLTGBYIUIybGchAnwbddUEfqeLouTcD65df7z59P/2RjpHLzlyJl9nPPm2c6gwHtNJn/bbZbY17LINkPaMATOgIH+SmZ9qIZqJq3VbucTrEcbC5hHUC6Z5JKau1jnrwmRF5Ecr/eK+QtkJ2JQp6IOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljHpPth3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljHpPth3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4421F0089B;
	Tue,  6 Oct 2026 21:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322587;
	bh=z1xBiNecfS6C38QWjH5ciDHYX0nnUc+epVpqmanI1jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljHpPth3s4RP8s+OR8P408KG7T4gQ9ch39gAB7oS+xsX96gI+6UJPhQNvv+IhFh3j
	 SRX39xwZGy9XXkkRPSXRwsWaWP8ZWxKr1FyUYKAlf+UiUV9AfY3noTAD2+/LBmKlIF
	 P0NmeS1kQBMSKZ+hIna4IQN/Rg7OD6MzDA+5ufS4ZW5WFhhwg/tyKKb1QtpTRfz624
	 GuVvG17VaGhjygdOaIzb5uvHEco0qDsb240S95XMyCLdVypKHuDeMkCylRHTUL17fE
	 bGx83kEEkMCRoh36sk6/UkaNcpHdPEtqZeC0SML/kF01269UeyAcH7KHgxoDd0u9Ja
	 W3m+IuQ15tAmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] page_pool: always add GFP_NOWARN for ATOMIC allocations
Date: Tue,  6 Oct 2026 17:35:43 -0400
Message-ID: <2026-10-06-1-daily-reply-0011-page-pool-nowarn-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-cve-2025-68321-v1-1-f45fb28e7127@bootlin.com>
References: <20261005-cve-2025-68321-v1-1-f45fb28e7127@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit f3b52167a0cb23b27414452fbc1278da2ee884fc ]
>
> Driver authors often forget to add GFP_NOWARN for page allocation
> from the datapath.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
