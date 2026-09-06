Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E662C3757
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701619; cv=none; b=OZg4O6j8C9tVV2Z8Vm5RPYDydzmninLkh1IW59XQ+iU1a7h1Y8JkqfCQrXp1jUcKRFHsx0WZbpO/8BhZACKFZIsuWzAnLmHjYAOJV6Hj+7SNAjm1KQ6KI0sAfLjXER9wILdXP5SgaYLWW+Oc2CSPuWremFY/kLrBs8Db4LEom4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701619; c=relaxed/simple;
	bh=2/C1E53ltzCLJrXSEdsa1PEhbVFs4HWFUi2+/nGnOkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/16uBtsMxeOQfM5FKthiDrhiQ4QJk0VFVRmC6amR61r02Hnj5Ke3s/HGpDNUcLAzk1vP/ec9hHqhGZ8reFIAbQhvl0VYe4Lx39ud0MopY46ub4exUNzYceZ6YUFuePhRBFq1UJd4lD5zMAERQcKx6XqblK1a7IF9I43M09vJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYc/bGEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYc/bGEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92321F00AC4;
	Sun,  6 Sep 2026 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701615;
	bh=oyM8VmxjfzTZIqfXZb3MACladf4ClyiY+CJzbpU67wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYc/bGEqtLHvP4JyZ0dCr+22chjlYlNnKhxIxf1exEzvmiyPWsncbJL/pKXlEtU+p
	 R6nBX7EWzVW6vkQkSxvlwW4fl2oatKays9TYCf4a8SA8I1CjjWCw/Xnyp1V9h2ux3W
	 K5AyYEz8r1hs2RdyLelAoFhndKt9v/zMejZMoizaBCugvmp1Kw4n0ZVO51Qp5bLa4V
	 xBYzSuS8wA7YkFKJVinoHvMLPB0oz40SAdvc27vaJ8aaghvgS5G24Ih/z6dj8L8wEr
	 LvumRckps9me0lMNeG11NJR32CFrhiMLNCOwveyVZTPqFqjPmdmnT9OSdPl0GkIcDC
	 gmqVj+9gSgOhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yuqi Xu <xuyuqiabc@gmail.com>,
	Vega <vega@nebusec.ai>,
	Nan Li <tonanli66@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y] openvswitch: Fix CT limit teardown use-after-free
Date: Sun,  6 Sep 2026 09:32:41 -0400
Message-ID: <2026-09-05-daily-reply-0011-ovs-ct-limit-uaf-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904091838.1811303-1-i.maximets@ovn.org>
References: <20260904091838.1811303-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
>
> An unprivileged user can trigger this bug from a user and network

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
