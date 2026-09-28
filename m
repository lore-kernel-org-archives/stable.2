Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF294F7CBE
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613992; cv=none; b=Vcb5VtqYV9kevqhkbTb5GJKrDdT+Zt1aefMMttc0X3M1zjI/IcrQ4Z5vyiZ+UMouqgnuaEawltd7RurcV2wrkiQ4zUDB8mGa0RcCpqW7kYrJ8S5fbhWe0SbbttXYicoV8nuWazC7EqKnW8KPb1KlN0tpr3UulVjDGjx0FILFwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613992; c=relaxed/simple;
	bh=bfsoKTSpOat/HslPsMUNvhnFGRQcpM/4V9lL4T4l658=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffVAMw9O0KPWXQBpee5Hs6BbTKbAPz2zRDb6r/69DKggiY8kOy57J5K+Vl9iaQli6550tputLOyM6UMtCCTACs2lJOVjl+LMDxFmVsMcjrfK31UuqKNenYinjX/94OzMnfhiDO1jaUnmI1m/E2GOWdGauM90rI2HGOgxJ7maG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUr+G9rZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUr+G9rZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAEA1F00898;
	Mon, 28 Sep 2026 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613990;
	bh=p+AKVXrkIltOqmh0tgX0NNxU61VciieLtGCPT+I3ShI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUr+G9rZdsbY1uI+e1PcBWF5Gx9S/LhieQxmhiKeJG2WdfS0i1XZ7uShXHTTl22+p
	 gStxfQZmbZGTwwbK7egPQ5+EJKyK8EySE9AYCB19d9jUZPznpLhjceklLUXJJgsmp7
	 p5xQgn1DBuGWBN6bl4o6rNwGSWaqAhGqoDCiHziAokGrREl/0qyoeA5THUn1ZH/r/y
	 pP8coWorG7nB4yxXUTRes0zPqL7SY//LZ77p4OYlBH9PGhFWg/CQ7Ci9iF8Juvq0rS
	 /BQHz6Nc3UNSm0DK29ln9kiw8QIjYDIjREJlaYMTLEmMsx/yJSSoWVu4ewsejqh3GH
	 Y7LgNDk0m9oSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Quentin Armitage <quentin@armitage.org.uk>
Subject: Re: [7.2] Please backport 6c096bb08de9 ("net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset")
Date: Mon, 28 Sep 2026 12:46:12 -0400
Message-ID: <2026-09-28-daily-reply-0013-re-ifla-inet-conf-nested-7-2-already-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <98db080b41f533cfc4abce84b6b04352b535c5d0.camel@armitage.org.uk>
References: <98db080b41f533cfc4abce84b6b04352b535c5d0.camel@armitage.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport 6c096bb08de9 to Linux v7.2, since it causes all released
> versions of keepalived to function incorrectly with macvlans.

It's already queued for 7.2, thanks.

-- 
Thanks,
Sasha
