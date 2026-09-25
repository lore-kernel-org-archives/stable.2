Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039C3672BD
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362091; cv=none; b=Cgd2rL4d3vwhk1CEZxf6kXoqICMFsvHu1VTcZW1J4iUo03SsreYnycz30JruSsWGdeNHhYsxwTUq+63DukckepUDD5k4usNNXXvIYCUwWsvcjHmx1UWSWXKz+5RRD/tjcoGSjgCJ2xpJWxpIW12Pa8LlcMSq+OAbANrZIiJ8hVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362091; c=relaxed/simple;
	bh=BObuDR6dmdZHs7aU+i3DU2ZV7aI1KT6Kpw29Jy6MgdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsJ72KTDrKm6NePiQGW3tIr0Ux6l/OlwHWHikMAXAb/7yBFeQLRQjVfLqEOJTJBccqayieVASJCYRdDiyL1Iy2txUSrGqaepRwzxU/09RmRgyGDafy1F7gY+6WGsmG7vIenRU6rsUwIf7bJ/479Ccqf4QzLBg/UciLnqsNuKLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdiKO2+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdiKO2+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9831F000FF;
	Fri, 25 Sep 2026 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362090;
	bh=+R12GeE1L9EPyAROJI4hOkIrZWy6DnbKX0/9YbHE6vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdiKO2+ahgYsRGyqZHBtqs5edOXPeUB9uTYyIauivjavsB+JhPwrkP6ViNTVYLX29
	 jkmIApCpyjaVFrQJ1763QOJ7CGQkDuO8sRGYlB25VRizyZbOMX86vwnPISZKuU2rMP
	 whLUansYTlYHbrrplBFOS0pkUJ+tegWnWchfVnHK3gkyXkkTMLmg3HAXd9+X/La7h2
	 WTz8N29Sa0X2VVXVWVez7C/ZC9+X8jxS6x9DWnf0lsUpHQ+Myj96Zk6jXoS9rGeZx0
	 9TxgfCIGgan++2HEdiELE3JHlDBG+j8cGEJRoDoOMsQLmqB/rlPmO+l64QUDQgyTMF
	 qh9WoCP9QnJhQ==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [7.2.y] NULL ptr deref during DPMS
Date: Fri, 25 Sep 2026 14:47:53 -0400
Message-ID: <2026-09-25-daily-reply-0001-re-amd-dpms-null-deref-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cf67c71d-b34f-4b28-bdfc-6a1742e5c756@amd.com>
References: <cf67c71d-b34f-4b28-bdfc-6a1742e5c756@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It was identified that commit 8fa813b7fd1ec ("drm/amd/display: Remove
> sink usage from DPMS") should help it.
>
> Can we please backport to 7.2.y?

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
