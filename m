Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04F7082D;
	Wed, 15 Jul 2026 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074369; cv=none; b=auhmBU3FnbK1stAQI2kywuSFyllJMbHkKuU4YYNzHX3Fi5uIqrs9l3eODJ2OWr6LRRZx1VZV8ULE0hZQbP7FReliWIOmPehC3CW6Z+l9z3fHvPPvVP/T6nVVIIKjwswrwziE3k/Br+0aQ9L1Gyw5pzx0ElQlSJOSi3IP12sum2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074369; c=relaxed/simple;
	bh=vGOWa1lG7tlQZu5N2J6/lJmsJbJlDZzFE4q67DuTfK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXVjwL9QeuhePnuFFLdwgMiZDILTlXkzxm3aA9X7wlBHOlfboq+pjLd6ZK9kMlFPLK9ElUjX8RiNSk4NnGbbJvD7iGdSydXhOdSkMDadhDjxYcUs8oTnBL1OAXLYtnt8fb28GvB2WcUykHhCt1TrBE4BCrwd4LZBVkbyQDR3pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU3asLrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU3asLrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43501F00A3A;
	Wed, 15 Jul 2026 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074367;
	bh=n7m/GGbqac2Mb0792REfaI6YRuOV/e795EdrpgrNV6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aU3asLrJgyQAlwAnJv4HHEqGY8JOFwYW2Ui5dD2aWaMuAFI4zmBaSCjTl4B0Hiafp
	 l+jqIZ98AThbMijEsycmIx8CDR4Y8tInluRXmofoLq8pNXBItUfN6OH0aMREOzCMMP
	 COhQwwC9VX8qpDn8VvKQE2EEqbTW8e3mqmjVFeQIX3RSGgDetssWVx4jsI60bagguu
	 ulCCrDRc7P5cUu1wiZ610skD4IICtJF7LMxdbTwvCLn8QTYD47EKmusS5CfvSBS3vy
	 mZrWaIc6MT64Ts6jStP3W8wI5ZXPTQEMrZgGlkUMzuQkCUYj1Vc0rb2ljtG0Mr2gT6
	 /7sEDuc1F6BRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: Re: [stable backport request] wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon
Date: Tue, 14 Jul 2026 20:12:31 -0400
Message-ID: <20260714200600.stable0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713180433.52394-1-ismailtarim7@gmail.com>
References: <20260713180433.52394-1-ismailtarim7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider backporting the following mainline commit to the stable
> trees:
>
>   commit 351dd7d2c80d ("wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon")

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
