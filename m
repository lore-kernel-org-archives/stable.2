Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7026F46F;
	Tue,  9 Jun 2026 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966338; cv=none; b=aIfJEHjHyiWwr6vBsVVvH+gvNYqlGHW1aunLlgMhdYyMmrI9VOFvE/bTuCYoTb/SgI6au/d/5wdGvEprA9zlqITVRAc7Qz7pgYG9pc/BAhlsu3ts3XrwIOuCRuof2j8KOWJBsO4Q+SOIt9gTF74BfA0Pg89/bOJVMcAe0eaXyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966338; c=relaxed/simple;
	bh=EaCXpZJILm4cfpXaAzmZW8LL48t67vN6PqHnFFDqmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdny52V9MP8ZdLnXzH66SqNRCR9ezzVPObgKF+PkbGfef+SHzAoPzHGKIxcfXCTMI7tSJJxm3Anv5yrFutn1FDGaB8lvYYHZ3mEQXACsCatWQ6aVVzFyI3g+tikWcTuPhU0j4Vr7SPLPK8+sIGuGG9r2bCuXrt77dhszMvMY23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfAUNGBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfAUNGBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15D1F00893;
	Tue,  9 Jun 2026 00:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966337;
	bh=EaCXpZJILm4cfpXaAzmZW8LL48t67vN6PqHnFFDqmHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfAUNGBfER+OWuikEbn/Cp4JHx8OQguO6zXqm4OrpjJS93l52zZp8LQpGfEQ0+HLg
	 C1lZjnUuLicxKEcqgXlrpaqAQjHrmIq3vsZ0tAsNXrGC33g0umQR80Lw2oZlmvqave
	 k+nNRLugCDT0ry1QLjnLm6Eo84gpMYqItj4R+3g8EJdxEN03DK9BRLMIfAiF17jufS
	 NUlM14RolgZh0GBbBwqiGE6SDuaEGnPo0tvhO1AfUmFbeNNYch1GcSZsH5RWAenKxp
	 mBwRg9XXGBKyRgb28mIkmRRGFQ+B4gCfKpN4esnuCXsjqnAiWRfqwCoJAsvwuGG3eq
	 yDa57fhQmO4nA==
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
Date: Mon,  8 Jun 2026 20:51:55 -0400
Message-ID: <20260608-stable-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e03a6f5d-1f90-44ba-b000-925c43faa9a8@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com> <20260603105137.lan8814-qsgmii@kernel.org> <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com> <20260605-stable-reply-0003@kernel.org> <e03a6f5d-1f90-44ba-b000-925c43faa9a8@leroy-agon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset

Queued for 6.12, thanks.

--
Thanks,
Sasha
