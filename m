Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761D43E4BC
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=JbqnwuOjmLRfXs2H58RWgRmGtXPhBivgyyB6zoDHdIJO9SeSbQSlabiHzaz0CXGo5HKzcSBLU6qWMDC1uG4tJQ9gcdWpTxMVhrNHtNEwA9AmddCY0r6M9fQfFIlqk6RCU4BY14jDxbxM7skiYlYoTxHdcTdd6DLONCRWZTO0RkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=rs6CPCQWT2B1psmpR09sF+LZRODo/xEO4ioaOx76Zfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8ZW0SiptxGGJwcMrESOvYINSCqp1bKErET5P17D1e+/RHIrUcoNl0n5kxkSHXbWjJ5gDSAXiBiGOXFpQTNyX62d6F59N6xNmtZ3s39BwZj4BVE3md9uPKZ0xtk+/ze+K74APzynKY1DAqb/4ZXgnxyy3PbNbaT2NlxwhHQ3eKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caB3VBts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caB3VBts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2B31F00899;
	Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688265;
	bh=25jXhYyGn/b5r+ffFKCDAh22RuqSrtU7bTZ+K06iK70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=caB3VBtsvut5JNOdrY6E2wAPA2logye5sdbyW1WjAlCNyokjZJkW4JuIoC/8F2dFu
	 cN3eESi0t3MrmwyoiuXp7+H6oCjCdaRhluhtS3BpH6LDfm1qpTRJVa6eBAC9CV0KM3
	 4Df4gUf3n7rLwmGWJ1VlsC+cXJurAn/xCkFOqaefvlUUDIiUFVqU2s2Qoqt3Y0QMpE
	 y7MN/PkIEnGBhqHWxFEAN4Db/AIXNhTjqItWucrU2M8R4bX8sVcGufsy6ZjUxqI92S
	 D8iD3ONVHML1MTcCbQpK1vZZIPf23dcLBjb6H/b+rz3SmAn+6IShTDLHbCJGNDoB07
	 AKVUnnKuSEiDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Wei-Cheng Chen <weichengc@nvidia.com>
Subject: Re: [PATCH 7.0.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:18 -0400
Message-ID: <20260605-stable-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604120914.131945-1-weichengc@nvidia.com>
References: <2026060430-deluxe-finite-6c5b@gregkh> <20260604120914.131945-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 7.0.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 7.0.y, thanks.

-- 
Thanks,
Sasha
