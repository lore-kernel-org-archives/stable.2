Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AD3A874B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496512; cv=none; b=H8iW0aawr+RNniDvDcZkt21lepFcQx5+CDcFcDahLaKe3IMLUy7Vx8P+3JsC+qA1XX7ZY2Ei8nv3AwN0qJckCK/Af78prkojIzoz70fU53Ggp61edv1TmUafI2DMeRQbaMQpqzIW7heM5K/pcNlCh5kKPEV3fY+zdQiD0VkF/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496512; c=relaxed/simple;
	bh=xf/ap4Nwpq5rJGrgDs31OJFbYwHfEZAEnETFqYFEC6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+958LjtPTsOj6zVHzkrFRwG5l74WnxWTrXgihk+tToOVCDgnLZWsNTywCOG1/q7ZO9nFgcaF9E09Ov6a8PtzBc2Nx+qN+CE9nV71a4Ukw3Oczy0EMIhWeUdHcbzyQj1VrcyYf1r+3GH5iti8WZB1TJi9+xVMB8NXalflfCvq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjLGPn6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjLGPn6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E401F00A3F;
	Fri, 26 Jun 2026 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496509;
	bh=2h+I1O58mNJLHuKH/yasZw20DepNNPMlFFX8dUbNewk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RjLGPn6T3ulU+4PjpMFCQgZzAAF3Ct9bPfdlgTCekHsW6b+ohXOMwRqg8wQNpcUTN
	 JCDdfewe3zOaYVBe5BfN4sr+j10KP2qcdUfHTZLl27Erzgk0jSQux6wSnNr9pZ/ksY
	 FD0aSupnczGhMF81Neac+GCLIM/Cl+GEdFG1F4bOLdqxnsZ0t1A3a3sWbR0aVb2aRe
	 zg5QelBFhMxuaR1JBC6Yf+sp98xVo3MbL38+X+dX+k+ICNcXDbjy9Cxrh2vEWFL7VD
	 Kg1rWHU8UShhupqTx5ua4CYTdCRB6JRpmVUWF54rz+DVz2c80at680ZK05HJHVPccu
	 pQnijORcTeJUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <amartyniuk@astralinux.ru>,
	Alexander Martyniuk <alexevgmart@gmail.com>
Subject: Re: [PATCH 5.15/6.1/6.6 0/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Fri, 26 Jun 2026 13:54:35 -0400
Message-ID: <stable-reply-item015-sctp-bh-na-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625165335.162311-1-alexevgmart@gmail.com>
References: <20260625165335.162311-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15/6.1/6.6 0/2] sctp: disable BH before calling udp_tunnel_xmit_skb()

Thanks, but I don't think CVE-2026-53070 affects 5.15/6.1/6.6, so I'm not
queuing it there. The imbalance it fixes comes from the
dev_xmit_recursion_inc()/dec() pair added by 6f1a9140ecda (v7.0+), which
isn't in these branches.

-- 
Thanks,
Sasha
