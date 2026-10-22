Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634675;
	b=RGCEgR3SufiP4C6Ffc/Ua3ae265q7hq9GsqWylQux6VFBkjkEwTDAdtyXy9dwj51uADY
	 Ff3vrJScVc+koHLOV2J1kEfgTgi3eUgmMfnaI+k10z9qIilZXGBFNnqs1CHe+usBSaOcz
	 negPMi0IRu6EP2RHQZrTFo4sm77uXIaC1p/WZn2hGlKbWMTn++S/AT5/83mTYgiLsvisz
	 bU6BOqE07vU8jl9/65bYf/WAfrVjcOHB9rhig+/zPzkYBcuR0mSfZQAJbLm9HZgAEggim
	 kP3JIgCO3mSBLyo82fW1YsYVzib8vHpZCmHChoJR+x9bCnqXS4RtP/wrUL1kn+LyhWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3KS2gnp1gTKIm4gmRD9K6NBxjohEjgX3TzD0i2g+Pc4=;
	b=q3q4iohIpM28oybgirkvSHp8t1FCiKowwBTWlcpMDkeLjkwVe2H08pdfaASyS+LeHkoE
	 3rY8jU/oOARUUd/RDClU066UTljaYwUxuuRcdqqx7webQfN8T7/s+B7sp7W9nnXa6Jio4
	 eOYVavTu8+XcnZrHKrbYgOL6yX0gEXU9/9r1wmhCZL9ogxoQYooLG0254dTnmHGDHDofL
	 jbY1oQJqoyyvxYIsCK5RdT/yhckR0wPt5M2LpLg/lBcPjOehOZkqGdSkiQVHJfDE035wq
	 8jU+TPrh4vwJIVsqLJ4KuDwYH1LCdE/rAY5kadSOq4xvymr8F+PdmRVNI4oyllMFvvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X02DsOVx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE7606A32A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X02DsOVx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85A1F000C4;
	Thu, 22 Oct 2026 02:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634669;
	bh=3KS2gnp1gTKIm4gmRD9K6NBxjohEjgX3TzD0i2g+Pc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X02DsOVxbkSFhLckQCXSZ1ABcxYUmCl2h5+0q0Ck6xkT7/mgLp/oFuwmhNqR3GPld
	 vQ3XyEpjIR3FSV62RHJ5hBHvBYtFj4Uc7cLMwf2optCXrIYMbMjQ97hRgSNMRXzuJ+
	 8OVfKLVnYsGWjOEzlr2F663sXqiNpif9a9fcQYmgZPM/rWW7cLssEpY+60KYgsEYrF
	 aVZ7XtHxqszXQ7TZYyzEFdebCEq8wHyq1PyeQdztgd2KZAf61hQzYl9yUO//HPHlOX
	 bFvzGgo4QOmr1w4WXYGt+1RWkWKbKp8Ku0iNW+Q0eT/6QJ5mmrEHetMmzH5Fqq7LSe
	 Zk9Rkxx8X2XkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Heyang Tan <thy15333007817@163.com>
Subject: Re: [STABLE] wifi: p54: validate firmware record lengths
Date: Wed, 21 Oct 2026 22:03:54 -0400
Message-ID: <2026-10-21-1-daily-reply-0029-p54-firmware-record-lengths@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021020316.319-1-thy15333007817@163.com>
References: <20261021020316.319-1-thy15333007817@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport upstream commit
>   db7b86bd97b380ece8fa39cfdd7502a9fd35e56f
>   ("wifi: p54: validate firmware record lengths")
> to the 6.18.y through 5.10.y stable trees.

Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
