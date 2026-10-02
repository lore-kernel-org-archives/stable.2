Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C303D2FEC;
	Fri,  2 Oct 2026 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975445; cv=none; b=SHzspHTg5dTaFENrn8II78g3FTXuIhX7tEqOeSIkHsLl0EhxjNWuPE3kcFTrmJESDxaSofyv4ic5fDKLnaB/NycwUamljntTp9rSCTnPdfCQULOQvMWmiKTQgIphVLYgccAywz5qli0ooijCmLNJxy2R+bH4LGkDWG1ylPyI/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975445; c=relaxed/simple;
	bh=SnSaeyTdXmzNVrgymOXMNz6WX5KAW8htMVm8JeHF4Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNoOng+M1JXvC9idRUUyXZlry3K3DDc8HJlX7hbI65GM7xWESx7ErLOXKbl/ts3mdWf5IteK2QBZfFX5Wyw/TvCVwOv1UUOanNM1MVYDecZzD/xrrqLMpwz6WF/Dkf+vmX/tyqrDT+MfwCF7pELJjcc1U0h7jpBUolypDvYRD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKkczJWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKkczJWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E21F00899;
	Fri,  2 Oct 2026 21:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975444;
	bh=UTd82VV5aLmCE8TeXxBJ+4PuiUKnaEX1gfylvQo2ivA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKkczJWudLpXRnMlLSpa1bjHUUJwTSOrs/BEbacU7+HW/N7cZ/SJ80Z/Ulck4ysWc
	 yErQu7ENR1gBWn7RlMzJEiFSx7vcLDdoxvbQBq5QzC+FdgL2r+Iaix5UjzoriOL1+Y
	 hXoq6tKKj9XsnAWYMHThOGoC3CcrTqiAApVV3uO7rlc6ESxSlBa23YyG11TjTXvEN0
	 5yVj4eU9Vd3nMJgz72TuLkq7fwzKa0MXGsshtbliLJ4AszhNMmlMXIFyi5Zmrgq2+j
	 mi0V/G92Yz82kZ6z4s7a+bQoYlWyJcNxZa+Q4ryB3WbOx1mteS/RjpL3CGSAmaE/5w
	 luEN2AeYGE1sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tibor Harcsa <silurust@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: Re: Please backport dc16388d45ec ("Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table") to stable
Date: Fri,  2 Oct 2026 17:10:31 -0400
Message-ID: <2026-10-02-1-daily-reply-0005-re-btusb-qca9377-imc-backport@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002012542.473669-1-yaroslav.voytovych@gmail.com>
References: <20261002012542.473669-1-yaroslav.voytovych@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> please consider for linux-7.2.y, linux-6.18.y, linux-6.12.y, linux-6.6.y
> and linux-6.1.y:
>
>   dc16388d45ec ("Bluetooth: btusb: Add IMC Networks QCA9377 to quirks
>   table")

Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
