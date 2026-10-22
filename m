Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634655;
	b=Y38O1WmDePJg8BMX0DhH9T6jKoZDBqldQO/cWDKqtLJdoo8bnitIgMtfe7BxiSLkJ4VY
	 qJTgkkkenyetxc9u3RSYU5E/9bTCRVPEasopLWbGWW9KsbM0Gy2pK4lUM+NbcIJYsqsUG
	 hL0tXkqC5nDlLXS3vP4SLXyv3S38UA7YXWm0OzBQP8vCCWTdPbOffKxmXLftCNFqL1CIO
	 pLf6Wgvb7MBJtB41/U32eBCsEbxzXs2tzuZe7kRo3sS/P8kYm8n+mhzxem+UWgQRifvou
	 oz6O8uHXqpKBDhPzymNdEK2NBhRSghkbnlVYvxV7H2qeFSVGqmirelrzRmcam0ctQmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tl3OWPk6eb10AOx65O5eOmoBwo6YsgQE9QPaBHkPqRQ=;
	b=DQdVoomtobA/6/xniFntgpW6/pjGr7u4wzR0jLrczbHdLgRy7ULG3A0Xoigr6O6O/x4W
	 C9aVr3YkeK7K1KD7DPpQmkVTYEzB9uk+WMNhtE/Y+bF0Bf0dAPB/ZGQG2yBF+VkzfiOXp
	 OUjUfigtdRls7SLIrLvudtt0H4sw2hM++MhnqWrXWp0t6XX/4hTXluhu0CiNNVQKRfe7M
	 D78vlyp+98MJTqGz78yxHzfgXk6+oK3hiFavzJspZ086hiay5qlP+EKMj7PVaiVNObVo/
	 ksdq0WCzHRrYMCTfOGHQ2nRrvEp1HOzroA/9fc3ED5u8wmQauoaKz+eiuhUc5AkNZsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0UwOe9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057D606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0UwOe9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DC91F000C3;
	Thu, 22 Oct 2026 02:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634655;
	bh=Tl3OWPk6eb10AOx65O5eOmoBwo6YsgQE9QPaBHkPqRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a0UwOe9zS2NYgegFpb10aeTiVQKaPSk2IaNQJ3llyTswcufNSkv+zVrQ/B9db/lZ2
	 JD09zkHB0GD4pT6jnlJqRPKrto79LLI/Ad3cszTb1Emb/lVLl47agFR0jXA+KVmc9a
	 /2br6LE3LNIpA/x0lXCDB5LkD6ah8YNYrgOy5nNbwLd4El7AuOp2IJ9glg/67o53kE
	 6xacn+5ZFSDUcBQUiZ1rYVUUH4TCXrnECS8sarwy6NICOz5mGmAWxu6y7PsToPR/rT
	 UN3Vb6PXJ8bOOwXdAUOAV8AZQiFBc6jMUwteQvAUylzZ+96ej6KzO31vifY06/yf2n
	 cTK3WZyp89W/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Di Shen <di.shen@unisoc.com>,
	Ling Xu <ling_ling.xu@unisoc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.12.y] OPP: Fix race between OPP addition and lookup
Date: Wed, 21 Oct 2026 22:03:40 -0400
Message-ID: <2026-10-21-1-daily-reply-0015-opp-add-lookup-race-6-12-already-in@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74405-v1-1-106d595143b2@bootlin.com>
References: <20261020-cve-2026-74405-v1-1-106d595143b2@bootlin.com>
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

This is already in v6.12.114, so no backport is needed.

-- 
Thanks,
Sasha
