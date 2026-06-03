Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38A3D1709
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499695; cv=none; b=Y6veiJb9cVOA3q7f3WVmnsaDsAs3ZwsD9XHWOu5tWXRDZMjKZdQ4n/GroOugujpfwc8ArkCK6QO5AEQb7qyq/WxmAGkOF9PBhxH+4MN+GRMvM17xtfz5eLyEcjUCEq+S03NwxaTesyD9lCSCZL1+MdjY3JxX4w0ER/1/IvDj9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499695; c=relaxed/simple;
	bh=IQjyFloxEuRb41i5z5ImLBazvqc5OmpdohGRF22zwrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4e/bw1jzWLE4EMqdNh6iFaEWpCTTJ1L7eU5darvYaHVW/yg899Webd8XdVhwJrOYnv3Z7h/47K4ftqhEx6tfOnoZ8HC/EXEjvUFB2MCogzkgZ8vQ32ZHID3570vrlO2+Jxb5FKAq14GTY/nCG5ro9+EsWSxQ16HukDAp6xVyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmWcDaLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmWcDaLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089AE1F00898;
	Wed,  3 Jun 2026 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499694;
	bh=8lBTrZuBd7byqbnusUy2MCtApz/gd2Q5Qeb+J0gnGKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmWcDaLHj9sNZPTOydPR9xqVRVCufuqqxBs9wkV33Uv1UXJ4yJcavhDIVD1VHqKr1
	 oPNrB20wAH6Nokpu5EujkbHGYdASz6aZNDdT8ji4epVJ6ZQXgJH7n3SZA1q/W4GGh5
	 rxnAAN+tXNwThIToX3oeUcWxyt45Ki4jbQ2BRnN1W1QB/g8tQ7yQF9Hjc/73mIa0pn
	 aDYOPOqiOqk+NAIZ68hLLHLxERaez18wmOK2PMsptvu+E0ZhXJvrPHEHfbXrSL5DW0
	 dyoSPIY+S+RNgB5WqsniJjLDVPmjoqPhjTbLNGL0Ca3c/3EYmWE7rcCNn4WH0w1fCA
	 r5qG7ziHwglpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.1.y 1/2] batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
Date: Wed,  3 Jun 2026 11:14:20 -0400
Message-ID: <20260603111500.item053@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194908.473287-1-sven@narfation.org>
References: <20260529194908.473287-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha
