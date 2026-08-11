Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093363D952B;
	Tue, 11 Aug 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474572; cv=none; b=eUiHbs3Z8lFO0EvqNpgg+fxBMzgUOMMNxBHifLDcIredMd0qgyW+PhzzGZt2knKPiNRNsc9bwxZhw9Sqtum+AyAV0Bfhae/JJ2QsydgfHVvYdmqHnWpKe8eeXOWM+HZQRQEB9LShUDQgsgt1AGEmRYtXx8rEHoMP9AFPvicYsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474572; c=relaxed/simple;
	bh=TmsTIQ7nAW8cSyyuFw3WGquXTHNImouPlzYZ6RUoOLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4LQPeN+ZbIMvR2LmM5t+qOgOx4MDJYk7MRT5m2ZljBfJzixRYwH3jg5A4tfUe/KEnoEvXfdJpdJGbMnIYtI3mm1f+mETIdeAQ3lTPiSYjTzU7cmJyzcxMNU9EDPeMAnzqXCL9BBe3nFq7bl8d0XEPWvUtOlt8rUONmJAVPAhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNYthR6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNYthR6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702271F00A3D;
	Tue, 11 Aug 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474570;
	bh=PBukDL37QntIK2X77XSCjuOLq3J3fMEjA9hcxBhwVa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YNYthR6taZELvkyv7hyNCMLYCu5qTdGfTQIdQaSdLI3Lw1KtL1m6QfbYrO1kn0pFi
	 b8GqT8wcUPsd6HVXGn2K4fqN5IABcIfGZntfLoKVssaMikuSKH7MKx/8S8kDiHV1i5
	 7Eixg78pQgfpBIyINjYse/sLjdE3uSe4qiHU5Gcav1C8n+rnpo2uth2HY7hfFb9h7F
	 B4A25Nrch8EP4Uo+WKTXnU9vBT5hkjOqk9AaQktYMngyW7+drUPd2/W9ZB7RR7Cle5
	 j8npUxM/U52bNDXb+plyAW9WoTkMU95R6XWXN742wXe0feb/dYdmMYlMLrecru2j4m
	 Xz2ufY14UjIeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer allocation fails
Date: Tue, 11 Aug 2026 14:55:54 -0400
Message-ID: <20260811184500.stable-0011-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810123902.2611897-1-mehmet.fide@gmail.com>
References: <20260810123902.2611897-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That helper walks the whole ring and
> hands every rx_skb_info[i].page to page_pool_put_full_page(), including
> the entries the allocation loop never reached.

Hm... I think that the patch makes sense.

Wei, Shenwei, Clark - could one of you ack this? It is a stable-only fix
with no upstream commit to point at, so I would rather not queue it on
my own judgement.

-- 
Thanks,
Sasha
