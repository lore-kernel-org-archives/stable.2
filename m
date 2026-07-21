Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819B48C3FA;
	Tue, 21 Jul 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635726; cv=none; b=R/06YWmxguaROe8+Hm+ddaFxG91B+Q58Nm85qqyHGapmKrGAjx98bNSWrX39ZQ75h9cvrGt9t/7yozPtijCd24b2Hmw7iPyHXwH2RIym2ca9ogCbnAFIGyM3M0iEGCSlX1oDXmFYyPUQpX7b2Fwk5xA/VLBLn3MqFNEetmV4Lio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635726; c=relaxed/simple;
	bh=nAcHw18VkRljBSE9Zc8MGMUoeU24ghesvCVM1iHKHrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=od6FWQ1IfBQZoJX79gkZBGxJUaQ4hm9TwqNFR+Bh6J1hGYtXD2bwZyDcB7SOeVfXpWZqhQ6CjIIaDgndRmATVCEMKjXKd8oPuGsUPzx1ZbzZP1yvllj82K7pCQyL3rJ5JAZKfUq6WkMoy4p99tqudB28f/ia1bwataxOwSefqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azZZpkGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azZZpkGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C271F00A3A;
	Tue, 21 Jul 2026 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635725;
	bh=I5J4zxuMl09jkauxsHvDgqgY6WrWVwGMtjVL60KlIG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azZZpkGJqDkBmabgi6igUeWOMfGi4wQIDjARf8MXIsGRNsUkSqzzODVvkdrZ26r2P
	 dn2Apv/rYnwSTE8OrNvgU/vRxzNcoRANJ11cpc8BtwisA9mq2J9NroaSr0xXEnPNGb
	 0PKr+yBRri9XfY/5S5EaMty+z9SsImJ3LGMkOz2HC9YTJti21PUdG6CgJNTV32mjrd
	 quMisFtCR2N9yaSvBTXJoZLtblAJb4RhjzY0QEvl25PNQJVwpfUWhU/KrcQyb7DZNg
	 pkfXl+27y7IbB0H6DhFgk1WuBec35irKMyIg0eL48cNZPEFFp/6svNcHRsE6UNF0ga
	 jwaQ9gALv1eTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: Patch "dt-bindings: vendor-prefixes: add Gira" has been added to the 7.1-stable tree
Date: Tue, 21 Jul 2026 08:08:36 -0400
Message-ID: <20260721120236.100002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <811630842892a53858bb6c6504d31fa9cca0fd4c.camel@pengutronix.de>
References: <20260720111729.362978-1-sashal@kernel.org> <811630842892a53858bb6c6504d31fa9cca0fd4c.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 20, 2026 at 02:46:30PM +0200, Lucas Stach wrote:
>This adds a vendor prefix for a board that isn't even upstream yet. Why
>would this be included in a stable kernel? What was the criteria that
>qualified this patch to be picked into the stable queue?

Dropped from the 7.1, 6.18, and 6.12 queues, thanks.

-- 
Thanks,
Sasha
