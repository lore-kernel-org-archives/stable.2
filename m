Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7323D7D6C;
	Tue, 15 Sep 2026 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437842; cv=none; b=tD8BCUKZnhswGsYQjXiLJbriEChMoHylqPP/78fbiBXZe1FkxTliBbh+ohvznNUFN42kOszmcWEom//9i3pQz+FI689YMbye3/vHama8yCyTbmtnLsrmWHVV/Tok5umvRWR8jplUeNNoidSt1IgfQP6bTz76Dq6IHCz1vZ9VwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437842; c=relaxed/simple;
	bh=xgknFQhI6Gi9FL+RBgQK0JznXAMYNBAeel35EE3vNco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiHaEB0cFbSkSd/Q/V4cTS/1vAs++jdcrz0MXugiIU2YLJxzINJutFBoIINAJeAj2Jh/leijotOtzpZmnGxUKlOUKqHjyYUq7HjLO4KyB2+ZgdCPcBofb7FWHdK8v7Eqy11Ce+Jjwf/nEFp4kJw0oKja8MpoCZmUTxRFq4IqgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNh83LG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNh83LG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55AB1F00898;
	Tue, 15 Sep 2026 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437840;
	bh=2ExXhYw4140NQhYA7NJ57bnziNBZPppsMFWVZ83+lTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNh83LG0DIQB1ESdDkT1rarha7yVCWZHZkcXBckw9hojvmxaQfbNbJ+l71CvRBYjy
	 JbO0b8+kDI5VjH9BEZ7/lRilKXwINegOmx9sDJpc3b68wDBDP8nQklsHtOBgaW3D2z
	 H48Xxq9JvzlsQvURnUTFUpNf9jwG/Kp8VETRrWpEFLMXyl7Qt97Oy8FKl5A3e+l9EN
	 RzK4a5v6pR1Tu2J5RDbzxVOa9TlGbrAPblozPRcTv4oOe2Ckkzl6vGrxAUxiDsqeFz
	 SS7Gv7jypkU6TwYCif2SlgVcIO6ki2Su3HW+JjAtUx4s/PfQ6JbBunGclUM7kOpSf8
	 noweQMIgp8CfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Mon, 14 Sep 2026 22:03:33 -0400
Message-ID: <daily-reply-0017-re-damon-merge-regions-remaining@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911135003.96395-1-sj@kernel.org>
References: <20260911135003.96395-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Once that lands, the other four branches are ready to go.
>
> Cool, let me know if there is anything that I can help!

Queued for 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
