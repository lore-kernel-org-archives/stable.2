Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78778397343;
	Tue,  2 Jun 2026 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424517; cv=none; b=ssEmeF31Dywj62w/cbETowtsSjoXGQG0LXZGag5yWuC0WIZ30HxtdZAEmaAXpYlN3ujGhcsUuQPDwSiBCb0UyGsPdE0TGzyhbH6HEPU0H6PHr8QLkKIGa8k9kI6tO3ZxBJ+7SicV2Bo5vsrNEcv0CNJcC1y6uV/qCRQFkdSguig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424517; c=relaxed/simple;
	bh=lSHL0ykFVpQVPqqFhgG1Y2wZBK5wlkceDpGh0659FOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEM0llz/7jQyp6WPGCW00f2K9hR8Ea7Kvoyls3tIHoyMAzGVO/yF/D1VtCm21cbc0PT063ZEQL9TZNAR4EmLlg2JEwwO0GwSL0Lp54Gx6Xaf2cxdYBvyHYspy86DWC9tLxdfB/GwHgnCE4V24RB4Q4N+eXrjk70mrakx3Q1AHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZp8qOl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZp8qOl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689421F00893;
	Tue,  2 Jun 2026 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424515;
	bh=2OEXLOdDHk0EatAng4WK4yhzsbnaxmTOzJBTGsjUXlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZp8qOl+0KujBRbbShvs5ny9dU1NTVAPY/52SWS+Zo5wAaPzNUUv0P0tBWivXk1d6
	 JjmXRUYUr4l9ZlKEI/1BPj4Cl91TXAMvYx0JTyxIoZj9FcDW2UTwhtGqTYHhiaS8La
	 sDKcxq8p5Wu7ZSj/zRi2//YV1TmY5idQqZJTc170fSnmlg07KlGkVzfYvdQ+LvAK7F
	 MsrX/zSNIYHFXMSmVybmLDXr/fU52cmcs/Eu8GIF+tLQ9pHhZCD2ZAfnhLsWufCg1j
	 wxRl4iIOrcE40giOte14xhHDH6MUE/GclnQ2j0JZb/ByuTIltDYGH6r/0m3DQTBJp+
	 NWnFt9vV2fiHg==
From: Sasha Levin <sashal@kernel.org>
To: Wenshan Lan <jetlan9@163.com>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Tue,  2 Jun 2026 14:21:31 -0400
Message-ID: <20260602180900.cpsw-new-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601073708.73350-1-jetlan9@163.com>
References: <20260601073708.73350-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 01, 2026 at 03:37:08PM +0800, Wenshan Lan wrote:
> [PATCH 6.12.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

Thanks. All four per-branch submissions (backports of upstream
9d724b34fbe1) are now applied:

  6.12.y  5452443ce7e16b
  6.6.y   59cbd3e205f322
  6.1.y   051d4a307d558c
  5.15.y  f9ae7c1e69f317

Thanks,
Sasha
