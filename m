Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA84511237
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018109; cv=none; b=CuNZTCQU98lESIZWXxgqaJQ/tmx1o5fblf+UZiZGEiJs1MWftQE/hiEvcF2nXQKREP+sHfvuSIREa4Iashgqu1eR9zIH/V/lyqqd0AHrrifhANIc4YP0hhfbpZEClZ5V2lul9Hh2eDNIHpPracRszuOiL8KIl7Bt4Cb1swAYA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018109; c=relaxed/simple;
	bh=bd9m8m8d8IU5TdoGPuXOPXfhFCNyVe8w1UC+Y3VxWS4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EArWDKxiHgt/uGOWzxCsY6Chv9RZVzXaHsYAPo+XGLSbDqhmHVO/b1uOC6T3fuO/gckoOvddfSWI7Ky3cGP5xHq76e2LdGFolo14+/xKJpTvF7OUkROYzGWGAxf5u4cmBxRi+How5Xt7Y/CG2mE2ghMV9MBzi6ePla1iznkdxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kf4O8Fl7; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kf4O8Fl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790018103; x=1790277303;
	bh=bd9m8m8d8IU5TdoGPuXOPXfhFCNyVe8w1UC+Y3VxWS4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kf4O8Fl7A54p61lJ7HjPMbkNGrBE9CSJk1NMtUk4Lyo2MjD+4IqgpWO2/SuSyl9p6
	 X7UIGxuXSrZtg1HFRY5y/8/w1QB3SfDB95zUSpXScv70W1tNTVG1LY1KjtU39verpF
	 xwXC9p+oaAB9WvMcrWXgL15zswUhIss264tWD8JUeFoJtEQmNcYyTrDAl3T0Z0xzeb
	 kHQNtXi2UcR9Ngf32PF0jT50weY87m2Y/pc/Ug6ludaxlhvgbThVW/Aq0aGckrbCyG
	 78udeFd9nJs31HsJYmf/YlnvlIXis+QboobwBlHz04w2TWJWwuWGmyL88ijASeUW7M
	 GwEh7At6bVYDg==
Date: Mon, 21 Sep 2026 19:14:59 +0000
To: "scardracs@disroot.org" <scardracs@disroot.org>
From: J <fooqux@proton.me>
Cc: "corentin.chary@gmail.com" <corentin.chary@gmail.com>, "denis.benato@linux.dev" <denis.benato@linux.dev>, "hansg@kernel.org" <hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "luke@ljones.dev" <luke@ljones.dev>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
Message-ID: <RbF1TyMN6iplUfewUXWzlhOxOMp1WkAHxVSWwz8V_iojKG6YZMv7QLTq6nSfIrgYOanHbEUOEaNHnM82NFp45BJUNNVqlV67ZdLG1RYLdpk=@proton.me>
Feedback-ID: 137864333:user:proton
X-Pm-Message-ID: 44c39749554fe0f2bc0c18dd08d03646ff699271
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested on a 2025 ASUS ROG Zephyrus G16, GU605C for a week. After applying p=
atch the twice-daily haphazard crashes experienced on-device stopped.=C2=
=A0
Tested-by: Jasper N <fooqux@proton.me>
