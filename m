Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443E5038E8
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635160; cv=none; b=AGriLS8FOxyHXlvnjN3YdHza4XpoeEbgvJIEEtgsiRV0O62Gv2Q5+fBoNPamvgyBrXiJy3hfheP4ISHSEqNvWjFBk+NN8UAqTdcGBqA2HY9sfgLokEmvSiD4KDrs9OUeZhwVRx3oBqeZ9QLs0Fq2e94ktojvjdMjgzNBbieKIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635160; c=relaxed/simple;
	bh=lkf9VDg4DSf0z8SydPhccp0Xik81JyBXChsKzl1wIns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if1NxzeEtwHgP1yjRIN3LK2PDbKOzAhzecHvHBlnxDvi6LqGbxKewJZykEwHT1KxAJ3AMUw6yPP9sJgkObh5YYcFCQ2ipbjdOqdHEHXVNqz3m4fzKYj5lkXA17MVeYXNDYZ6fau2Eg/0CATmHfIymyc0H+9C2oDxHaTWxsFE5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBZ9IRib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBZ9IRib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3CB1F00899;
	Mon, 28 Sep 2026 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635158;
	bh=VtE5RLW4jLwoWFBo3nWL7z9a0KUnTKY6rNwWX5d9ZuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZBZ9IRibKyWDnDsirXKdF72Wbq5qqsinEQxEWrK7I7J2T0+CkH+2c1MglD5SXnqAX
	 3Yp5HS59FHmR/UbEFSHUQJTQfDNqEOYDFLbCI7qV8KU7LOsD4ymQu/joYkDOLkGHAT
	 bjPjLFWPCt+OpkQkwK/ks6tcH4eGEVX/qm2aTA/No5YBZFNBVBssWqD4weAb2rrKuQ
	 TKzNfYrPJ3XB82dUOFgdkJTAxIh7ePuIqCEQx3Amu4+sSS5vg1IuteEODOoVRzB5Z2
	 hSgW1sT6/JQKLsw6q69gwft6uAMfvhYoxP48xeUq6uEGXpHwwLoHjAz/igCriNbmry
	 7uRQh8xWLPatQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Chunfeng Song <springbreeze@stu.pku.edu.cn>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] Revert "rust: net: phy: fix off-by-one bit positions in device status accessors"
Date: Mon, 28 Sep 2026 18:39:08 -0400
Message-ID: <2026-09-28-2-daily-reply-0004-re-rust-phy-revert-6-18-left-to-greg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928104855.205416-1-ojeda@kernel.org>
References: <20260928104855.205416-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit 3267aea7cdd5d5c8851718b148cd25ff1a5374ac.

Greg asked for this revert and re-add in the 6.18.54-rc1 review, so
I'll leave it for him to queue.

One fix for when it's applied: the SHA above is the stable-rc one. The
commit in v6.18.54 is f22d349940cb ("rust: net: phy: fix off-by-one bit
positions in device status accessors").

-- 
Thanks,
Sasha
