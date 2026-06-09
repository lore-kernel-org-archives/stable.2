Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C389265620;
	Tue,  9 Jun 2026 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966341; cv=none; b=GFuCPxnXzVWX8DLBFHtURkta0mPH/COzLuAHDMXObWSe+vZ/dAUBrty32giBdb/6ObV4RiVUWNW+t94CNG/E6Me/6BOacBBT/EOJgy91Zl6PcR5QVgxHAx+IRUBiGDFmcubt3uCWl7EX7UiblKZ0YA2r3IuZuRaURqFxHafuNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966341; c=relaxed/simple;
	bh=h7sRxlF8QUT/ED56jne3FRSt+5m6QitoR/LjFdcTuzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwcarbcp8cCF95xdwViszDWetLlSA5Qqf6UU9iTUmfT5QrTZOjyDNfCrJGR4cH6fu7k4PNAXSnooB8rPfKQq40tsWlO2BCEwoRTfp+ylpQtVy7ME4aG1UkNtKQ4vmf1FebUM4bjWM9jY7UsRfXPoNac6zaeDTxKsVDgaz9XUQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAIgxeiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAIgxeiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E71F00893;
	Tue,  9 Jun 2026 00:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966340;
	bh=h7sRxlF8QUT/ED56jne3FRSt+5m6QitoR/LjFdcTuzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bAIgxeiNnB1w7+V1aCZro6NkhnVrf4Kb/f6+3HsmIyG7IcgRV5g5ILY7bR6ID/QHp
	 GmypvjgwqLtoJ9R636603hUcPY+Y21ABxACr16aQlNPGvWdffj03fc5XClyllDPg32
	 CGdSSz5pLoCqmmBDO5Vnbw9USyUlR7a807wS7Rnhxz2gQ/JsDfFCpEgZJt3wP3GXlM
	 Tl5wS71qwKM3EiwlzL+YMXuiZMKWqJwNLDK+cPiKqjCyhTpWdv7kOKoMrF1nkzi4Mk
	 o5SfOytd1xbIGqxyOMJJYqVQcgC6hq2E5+Fm0O9tZKZz0gUW/pInqBESxxKn+MUgTF
	 y/FNAnVEUo2KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	yichenyu@google.com,
	kernel-team@android.com,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,
	Carlos Llamas <cmllamas@google.com>,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	"open list:802.11 (including CFG80211/NL80211)" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] wifi: remove zero-length arrays
Date: Mon,  8 Jun 2026 20:51:57 -0400
Message-ID: <20260608-stable-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608133216.1396790-1-cmllamas@google.com>
References: <20260608133216.1396790-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] wifi: remove zero-length arrays

Queued for 6.12, thanks. I dropped the leftover "Change-Id:" trailer from
the commit message while applying.

--
Thanks,
Sasha
