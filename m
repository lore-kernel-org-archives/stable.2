Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE85239085
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828851; cv=none; b=JpsoyMPlookEJazwxKVUidoqKclU2G6Fmw9Vf3TI+PzdgpCjz1zEbZj7njdsWqjrnXlzabKzV78+3wJvedJCaVIX7T1JnD/joo/wZXBV6FhGSlIB+95cU/Q724YyAQrGNEpOJ0D19ksGj9cStFYal/TGyXaM6nmQ77Jufz7LvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828851; c=relaxed/simple;
	bh=0FtJMmxmo/k51lZf2cL0fVl+aT6E9FK650ckHx57bMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHeY0XBnWfI60ADQk/wnis/2qL0dQAR/fKLd9+MIV83CC3MXguIerE4GwhgDdke88+57OXOXtlO6MzySs2sFXXPyOIqPiOCqaoz1eh0R7z3yp1qdWwSStp2KcA95AINY6MpPxlDFEriJ2L15lGUHF1Vpv8srY6uDI2aCqUTn34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE1vOz3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE1vOz3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0681F00A3A;
	Tue,  8 Sep 2026 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828849;
	bh=C+fE+jg+LE1gQvf82ORbIiCPhyJ4OZ4L4L4rBv9TtCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mE1vOz3DXHaTRU3cpz0oA9FBRKVg/lfixhLkShS0e1CvPXgy7vjb4Yh6CHiUcGIvP
	 qFHVGp547pKWDrX3cYs3Pz9FYsRadoQLm/RzG4q4F7W6HGmEIuLKFbODX9RgHNghim
	 SnH7vUBoRMAgOZo6Att1VnB+5HqQr6rwYevufQmJq9mcTPDyiWBeVPosTgLtubGNJ/
	 BRLoNVbSi8eVSyCDTciRF3ZPvI8LkDwfGBfIlOl0cZHYNC2WHcXh6fIosyQlIQ6yew
	 h07MAOdsNLAIQmPJqBOvli2VuEIoTrLepLZoqDwFVjYaG5gwEtfgu0u4ZusVhQ1dR0
	 b6vuTbmCBWWXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 20:53:45 -0400
Message-ID: <2026-09-07-daily-reply-0006-ntb-netdev-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907025826.468978-1-den@valinux.co.jp>
References: <20260907025826.468978-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 upstream.
>
> Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
> also increments the drop and error counters while leaving the skb owned
> by the qdisc, and may return BUSY with the subqueue still awake.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
