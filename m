Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B12371048
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275285; cv=none; b=NXr7CX93Y6G1Wxsle7f7XgQAES1Z6QC65cBZYthMhhMF3s+T0r/BLQitegxpweMqV8Efj3C5teaqEp1HJuT2BcdSHGHdAD2R6F1kCfyWE5TDVNe/Xf6UCRGppvCLdFeSXbPQFoDz94hjmT19HbgwXlr6R1RzQKxeAHLhm7PmG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275285; c=relaxed/simple;
	bh=IZHwMgvR7iqLgYv6719gt4wrdGsbCdFipyHP7Ua8eLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEKOmrQdMOov3R6PX++utQaHk0saAg7qX/IWtPOBK8RGKL6LA3XAlzISEczfRcJB4JX3Elvja+nDX4FzuTAQ+fB+QOllaHbu5wJBNlRhDlR5gcxaf5FVmO9+YB1BvE8Y3OwAKbOUJnG5ei0cCPMqkIF9SMA7YTKbc7bvQBULLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOin+Qs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOin+Qs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA11F00A3E;
	Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275284;
	bh=IZHwMgvR7iqLgYv6719gt4wrdGsbCdFipyHP7Ua8eLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOin+Qs0+KK7jm7yHrrUuqTJkM4s9nQZutf2/ESsBWNX64ORiDYZ7yD5vqPCqSI8c
	 CEXWl0lmbcpaD801tmrrqrNGwYfftOR9Eq9nZEqukhTklC/5/Ejm8ciU4VkaKMeunB
	 Tku5hHpPoWoTsxNS+r7kEXQHcEWaBUJi+Xx1OAW1Inp8h3AGcWMOf6WxdsF5FcMnw+
	 xqgO6nCmLtFfaRdbm0JWLpRQfuAToyHGwIitMWziJn2Mu+M97XBWSvvhpX76j1C/pm
	 205pp9vVGrxmTgww11THmu48ZnwqGKt6UGVM52kQ9ZTi5YdFAxg50qDMMQZQcMWM1g
	 8LGtIR2UXVaEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH 6.12.y] bcachefs: validate disk group parent chains
Date: Fri, 12 Jun 2026 10:41:17 -0400
Message-ID: <20260612-stable-reply-bcachefs-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611223835.73757-1-kylebot@openai.com>
References: <20260611223835.73757-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:38:35PM -0700, Kyle Zeng wrote:
> Reject parent IDs outside the disk-group table, parents that reference
> deleted groups, and cyclic parent chains before the groups are imported.
> This prevents crafted superblocks from making the CPU conversion walk
> past cpu_g->entries.

Thanks for the fix. I can't queue this for stable, though: there's no
upstream commit (bcachefs was removed from mainline after 6.12) and no
maintainer Reviewed-by/Acked-by. I won't take a stable-only change for
a removed subsystem without upstream presence or a maintainer ack.

If you can get Kent to review and ack it, I'll reconsider.

--
Thanks,
Sasha
