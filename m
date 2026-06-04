Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FA8462
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531551; cv=none; b=njpgMqDneIWMDCIs48QVoq4rogRurNMFzb7LXpSiPCExVOxQPpe3ahHp1eXA2Ok0ZXvSvXTCrLoGBdtoXVws7QIv/ATG+bQebjI+IiQIdPG1HSwnoNg6xWXnPIfEcDHZ59f4m/3vGugqp2WzL38kUlFz7x1kxP5Pjb8iDKKPdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531551; c=relaxed/simple;
	bh=l9PFath+liIYfdRq9UBMC/9bi/+mnaPL/9aYDRA9Bmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beSQ1nazaf2u8U5PGzu5I1UTcunf7E6gJjDrJ7Hm4cuX9yMgz0kmt8pX8ykLVUz+IwssegjlrpBkoEv3Twiw99FNHGDoVkZzHHn4mC9kOBROezBFR3EFfZAX2NyqfYd/bKN0vGyXamSTgcltE2YPc5DJeMDR5DHvFnETCUIQLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6Ncll3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6Ncll3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2771F00893;
	Thu,  4 Jun 2026 00:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531550;
	bh=NrVOiw+1se7mMUbShZpRXB1hUvmQ385ArgMq0tw7HDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6Ncll3YPTDsMbOVjnc6GhgAhjhWeN5FR0jVkde0dUDpYKnL1Fkr/HFHdc5DeLamI
	 +QvXyLiStaVE7dht1oV4nMyFoeMX4ZGpG/jUHTLe9dcM5WR820HGmXf/V08A9xwmO8
	 aLNZIGN3dPjRpDk1KVdrEX1TyqVedliafvhg0KQG/Mr3tdU7SZNa8rwbbpqUrjKhtD
	 QB/g/VmK5wyZXJLzdyM4qoyLHrIALRbbU/Of4Mal65SfYhe+dPIK2xkwb++m+jg7kL
	 8WGLv592w9TdWy6VWUTXMDA6mH/gWy26n4PveLxL4w1iAYZ8GXmmXavcLQwxwpK2mZ
	 PBFCL/oX0gSLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please apply commit 4db79a322db8 ("net: gro: don't merge zcopy skbs") to 6.1.y
Date: Wed,  3 Jun 2026 20:05:36 -0400
Message-ID: <20260603210831.item002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ah8-6irgXpRvuZ8T@eldamar.lan>
References: <ah8-6irgXpRvuZ8T@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please apply commit 4db79a322db8 ("net: gro: don't merge zcopy skbs")
> to 6.1.y. The mainline commit does not apply cleanly there, so a
> hand-crafted backport is inlined below.

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha
