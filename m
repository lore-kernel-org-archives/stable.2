Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BA3AB27D;
	Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499672; cv=none; b=fKbnjTwbub7H4vxZsY/Cni6Ui2jhrdE8X6+yZWoAkOQbMyaMvV7T9wW4XEN29Th3FfOE7O4LqAr0RvcThY7Km1GfurLnUd12psn8j70/AkX/EKc2YjTYCfOdeuTRRieMCoQQ24pFx4/h6ZfAVnE0lmLsJnEfZ5kTnXCqhYX1NFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499672; c=relaxed/simple;
	bh=9dx/cPeeS3EZyWVUhZm9JNLLMe4HXCD0yvK9G8YhFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoVp9RbUWm+dBO/DtZ19dELUc+IaGstcCBHxFcM03yuqYVdvPupg+ttQt0ZAqM3eXu3z08Y4pJ+lEF2E5SBNqPJSEWI9P6PHPV2IR4uLuh93nZIfmfknNxjoDPNi15g456u2n6AFpGbBk92bAVSEfPlFt6wLMBeDnqhldWzH/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3/Fc7aG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3/Fc7aG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337851F0089E;
	Wed,  3 Jun 2026 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499671;
	bh=BnZk5HC+TBlXGYAKvZD89rVJdXlgoZdSOfldLPIJKAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3/Fc7aGm9iTl9uSs6ODzNOGMCPDzXlhJkq7xv0LXjQ61T2qttWEBu8IFFIAwemDr
	 2jnM6ow2EiXNqNK18/K7Amk46TIzH8t93us8Ny7hH01THglO1fpKRM1In21AMB4Id1
	 7jrTGtr1b1TPZcmDk4p3cRGeISJoSnGSUVUTLKjcIHr9mW+6hiOxtCgbJQTSChtzdV
	 sMhhCf5Wr6A06Sn3C1kftXKJoK6t4025ice1WChfwgtqnr38nnR75DnJKI4RSI/rA2
	 Px7QdZdeHo48Kq1xrRwQCsN5BkTLjmC9fzDh57LMrsR5g/i0FNUJLsi6/hcF7ymp87
	 sYR0/e6OA0rQg==
From: Sasha Levin <sashal@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Jakub Kicinski <kuba@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Jo=C3=ABl=20ESPONDE?= <joel.esponde@leroy-agon.com>
Subject: Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Date: Wed,  3 Jun 2026 11:13:56 -0400
Message-ID: <20260603105137.lan8814-qsgmii@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
> [ Upstream commit e027c218c482c6a0ae1948129ccda3b0a2033368 ]

Thanks. This doesn't apply to 6.12.y as submitted: the hunk depends on
feature commit 19f1d6c7230b7d, which isn't present in 6.12.y.

-- 
Thanks,
Sasha
