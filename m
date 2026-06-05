Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE94418F2
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688264; cv=none; b=JFg2DVqBAyD/mNm17I+9jcs73t+qFQlmMF3U4YRelicH+uxTS68BLHWqKMPSntSb/Q0h8wZQz7wqHvBDb7OW6SFUqgLx+14f9Wr7mFr97RCGRC5hJUPza6Y5yGH9Bfmt3zr8ZAMjq4wuwSCvF5V/hgJn6of/Hyd1LzJn2eOUcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688264; c=relaxed/simple;
	bh=KZZhr1nAqTo679FRy/AexSo1d31BEqEDGMrHRtoZ1+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeITbpDGoPiflG65DhUvj3mig55gPPKq4d5/bVqopc3FlE8x7F4gVdave6ovcc3C6vxqo9bTYKLGEPlCKU9s83KsCv6YxA4YIiJjZMC09MWStW5JmQzjmxtpkkv46Ulwv63DB2ixAOdjIg+rw+x2jLnj2lm3MzEgxHYN2iAW06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvxsJNji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvxsJNji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12451F00898;
	Fri,  5 Jun 2026 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688263;
	bh=DFSkp3+phW8Ar707XKfjvJ1BoCJkI8wOJrygS2qo3c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvxsJNjiDtPUFFFfCPchY3P0RSIhMgYbm7RgBsutHnkMDk6b4rr8VP5lnMV57naYI
	 HvWVWUoSFJL1DYthtfw4DIsry3u3ePwc41ECPAZX9DJBr1RBqbICTjuMlvtIteT2DC
	 ClnE/Vbfyn724kKLBa5hTlStKtKr4Kaihse6Paf3W9sInKOpPDQ8qRt4HH8Dyf7bhJ
	 OLlzRAe08QT6veoZ0uZJIaxLpfBc/OPRpQkne0RIZWtr591YywEejwuuXRK8O2RV1w
	 6Xn0Ln7iGZndGDY+m24P1HauevOAxjrCC/EV37H7BSjWKbdREcWlpnGThGHzFfXZy9
	 mJiHj28tGgtlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shaomin Chen <eeesssooo020@gmail.com>
Subject: Re: [PATCH 6.18.y] xfrm: iptfs: reset runtime state when cloning SAs
Date: Fri,  5 Jun 2026 15:37:15 -0400
Message-ID: <20260605-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604152119.1694883-1-eeesssooo020@gmail.com>
References: <20260604152119.1694883-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] xfrm: iptfs: reset runtime state when cloning SAs

Queued for 6.18.y, thanks.

-- 
Thanks,
Sasha
