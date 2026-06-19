Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92B322B72
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842037; cv=none; b=vFv87JKQx/YsbzP4ns1vnrvTlL1DqT82hWCziN/g1uu5p5m8B7zKNlQU8XWYfmptb1o61B1laGF+ddhEwuEK5gzGyek1VzH8HgVwYFe07wyI4BwGBK4247pM6Ez/Q2GNSKTZnpOL2CDs637g/sABbDc4snleC7L9heQu0VWFh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842037; c=relaxed/simple;
	bh=pyBGYcpehEUjjtFgUFwfGgV7Kf+2dUd2PdmvjDVogIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmw3xfJxBr0QM8qLUotKYOmBnFa9oa5DUSYXOsNJlUX6fEB/LG6n6XMLIQzokvs993BQGV6p45TEpBk7N7PH64mzkXK4sdpmqdOO9kmDfelnkVZoeCp6zRomQyao5JQNUMhGqanulsXxDofvTLq8Nc3A12aOUMPNSPYbyroIZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvsIiAhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvsIiAhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF9D1F00A3A;
	Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842036;
	bh=5Z/yb9Y8HER8Bh8Ma09v7AxnLAJeH2mHubtdwln6D38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvsIiAhl704PasGvFMTmYf7psWMWswytVyu5g1BIL/cvzh9fQVTy672dezQhSTCb1
	 coGizhOrPCN3S4UPIRW16dpss0QcDsRRzaYJWa344qZ41DFLKS4/ZpHp4IEfsbpdMw
	 Ew7ZYYTojE54GU8mdkMyrBm1Cpjyp2K0ThRx0RzlMM64PO2eoJfky7sBxOiDpOpc69
	 O1HvGkTdTypZySkZsK3v+vc4UghKOOYbQOTTgJDUEpSrhTeKZcg1BNm39OvPnKmm3h
	 O4mKSIMBeo3St6d7M/iO+0eEmmWs77kXlGHebocqK0tqSQShJv9jFui46zlGyVTXLE
	 /txM0fTYNLFYQ==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.1.y 0/3] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:07:00 -0400
Message-ID: <20260618-reply-item015-pedit-61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618034034.1525175-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH 6.1.y 0/3] net/sched: fix pedit partial COW leading to page
>  cache corruption (CVE-2026-46331)

Queued the series for 6.1, thanks.

--
Thanks,
Sasha
