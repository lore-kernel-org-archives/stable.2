Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAB3C454F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701613; cv=none; b=a1HXTvu7KS/kSR3Vnw85Wyexfh39pQmpQnj9nJ6z8sQK85bH3XWnj7yHzleA14bvDaIYcYP5h41ZnABCAPwEnlC1uwvomwj/1VeZTBUY3gCQyX6TtL60t+2zkzGyBaAupMTWkDR0aegkVPbjI1GWsBptDl/0/uGW/HSEFdAf2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701613; c=relaxed/simple;
	bh=EN/grmE8YiMuWSSFkkG/5tf84lVb8vHutFHF4oK6onA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twzzNddoUUvZ4ERCddRNf34zF7WB6ie+rkGUOPU5Sss/xer3nvfAfIS0uaT90c/Px2MIt6kXUoBX0vOB5j4UFYYxMdZdbs3qHktrrlaE1RObQurYglbYHu1H3tLuFLnKT7c5pg1grnk7cb0q2xGGNxXlZRUkargLDJl+7QsG8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foSRNjuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foSRNjuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2191F00A3D;
	Sun,  6 Sep 2026 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701610;
	bh=lCn3kGtKKXeMc8yCb+2JAQ5OCmp1tbdzffLNUfpyEpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=foSRNjuwuyO6uyLzEDu8Y7RixIFlANvlrcl5FO+E424zy3wTxScvI48O2gt4n1fKE
	 GLBbuA5bwacE1kB+Mjtie5ujllUAa0vYR/IEP/X1cnNqkZs84FdMjCjRpijA5c7ebM
	 rVGSRA7z8YbmEIlsPycgKOXCQVrRSOAQLcGs6KaLTvDAqlvbx9CSGvSscR8mUy3Htr
	 yRtoaDY+nJouQ35N90FB7zRUh/AN1UTxzgWPkvChMXsoj6dS89z3RcmKo1dQMW7s8X
	 ctpAnumFi4Tdism0EH+Gjxw3Mw+a2WeezkryEUVCqqjOJMcQ/bI66B+ejdd/TC9Rnw
	 PPaM0piDjHe2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.12.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:36 -0400
Message-ID: <2026-09-05-daily-reply-0006-skb-zerocopy-source-skb-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904090128.1806869-1-i.maximets@ovn.org>
References: <20260904090128.1806869-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> skb_zerocopy() copies frags from @from into @to. On an
> skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
> operation on the source skb the copy helper does not own. That completes
> @from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
> SKBFL_SHARED_FRAG page-ownership marker.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
