Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE99377AA7
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101096; cv=none; b=JHG2vVbpkbysbb6GCJUV8Mx86fZynsFho5YBc9EOO6fkiLtFqavxp7S12ehEamWiwQhqDbL1b3hURqJ21V6xmi64zqoTtoaJbH0NekiRitOlDFJoX/wwpV2v5lvz2CZxMWov37yCC97v2PKzkxoB+QFhLEbGKj10JqNS40CrCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101096; c=relaxed/simple;
	bh=8D/v/fO7Y+4yUtCLANhmGDtvXEyr7MM0tw/ENt8elYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3D/1XZNvlNdx8pG7JJfv5Nhi/9bvUC2UY20JTaAkRLO3wNhPaJtrk4TcezvXJKE8DFeg++SfSMe74EpkKdMZ4AI1xcstL9zlBU3geyxCp5wuKYZMZ38evvo8HHnGF0N7d344605BAl503o+ikcX5Vwr4X4jKpT7n8VVw1oBjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNRBVe9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNRBVe9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48AD1F00A3D;
	Sun, 26 Jul 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101095;
	bh=FLIq2SaqO7hKsqGG0DrceCq6Uuv02zw61TsUHq58mTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nNRBVe9Kicdk4B1jSqslpzWBI/6PTJyEX4ltqUpMPZFLdRkYuu+9aAv3oiSkgudl5
	 0EDfPU/DT2fsI/CSDjyZJ8qBFgMO8UL8f4bd7pEFomKT7pUKtf6yehqXuzGATOxmz8
	 pPLrEyIP4/pTjYNvxUSv16kLkYWSqVxKe2GoGMpyFrU/HG7oM+XaAUlJaJ/qgaWyMg
	 C36Kt8mfHwkrlvIJQrBNtU69URwRSWXxg5ITG3GBNfQSytEk8cvON2oNB48n77CXUV
	 537cABMTU23Y2q//r4IjaRzeG54Udcjf2Jx9SSiNQSxywwtwGr+ymzm/NGE7zMB3re
	 A0kle2w5ABPOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	joannelkoong@gmail.com,
	mszeredi@redhat.com,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: Re: [PATCH 6.18.y] fuse: fix writeback array overflow when max_pages is one
Date: Sun, 26 Jul 2026 17:24:47 -0400
Message-ID: <20260726195203.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725090408.29442-1-qjx1298677004@gmail.com>
References: <20260725090408.29442-1-qjx1298677004@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Split the request when the number of already attached folios has reached
> fc->max_pages.  This keeps the folio/descriptor slot accounting in sync
> with the send decision.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
