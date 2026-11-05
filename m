Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903975;
	b=PAnBq63dlNiYrifmmEJzjzfeWaHdALSu1t54JBB8z7O0ITRg2N56lBPkkupP3+oASdU+
	 LdkCmCVKnC+zBveQ0f50mgUPc5JUW5Dv/A73PNkdaILRL5dC9y3zSrSG4H/VO56ergshI
	 uL2eSKjYq7cUhdT/XX3dKvk6EDcl+MeAwiizOnUuL4uhJhBXXCjKn6AV+EQEOQZ5TjkX8
	 4cXCjDSSX/1V+7Vn/v9gBiCoWUIEGHUyUj/vW0wqty7AGdNYM6bYgW8OzVsGtiwbRKsfM
	 LJL1SFl6XIqV2cpa1HadHK9uTNc115gXCS45r7n/8CxQzsotl23DB+ayCX5WTMQ8TBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YwbnbRhHmCfVoQcY2gvOMp4PY56dbeFZ+Y8zAcnCGdw=;
	b=115BtruaTgzb7F2wHNGL1VTgFA8CZ6GuFELBgsQONMl9etlY2Lzyym9+9S8uzmAp9s5m
	 njQ6DJGXQdAOTX/rr1OvwLS7v5MMt69fHvfO/Jaiad3GznAHGdAU7MlOpUZ+RHx2HUGjI
	 VH0qHh2s/U4V5p7vdY1TI9WL3YjUfkJuePuGlcJoG+zZsHcDNPLl6RXbJbWpNu45sSjCK
	 3szhJvmqIyXuxcvRszPVIFQinevbC1hMwhq6soPhM35JNsQw4ZXWBfpSmTFBDifv2OnWd
	 rJGKyBe12oVp4imN6/UahcFZcSPzNL22Apum1Ta/gkTpIBVW1y2KJ8U8ktfjR4+nuFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMnvZfBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DF606A33E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMnvZfBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B1D1F000C1;
	Thu,  5 Nov 2026 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903974;
	bh=YwbnbRhHmCfVoQcY2gvOMp4PY56dbeFZ+Y8zAcnCGdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMnvZfBBwlEjQkfoRssOh2n8T7p5d8jMSpnDo0P9WKGyCsxCnZeCNjDGm6YyavwJp
	 fz48+8GxrL0hrNXQEx4VtjfKp/XGwKZ+Nyl1yY2F/3F2/ism0k4ihP8l3LCmHazMMX
	 YEB/JG7jfdQBX3eNpVInlb8cP+H6dPecQU3wGQEDgco+kV17RME8RSoDNrq0snWsdR
	 XrB8jpibHp7iVOEAFtm0MtETS9yVn3/OVYw780SRNT7uiuUT8/NJpv/KYCclnTtIHf
	 qXjCr5ODJXXTQDp8brQG/GIApsSD801YqeR0dZ+vkR7Z9g1zQgARZkHwCStdZRb/VQ
	 whvZMhbN/8mNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	xiaoyao.li@intel.com,
	sashiko-bot@kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Thu,  5 Nov 2026 13:39:17 -0500
Message-ID: <2026-11-05-1-daily-reply-0012-kvm-vmx-bus-lock@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105121320.2093899-1-xiaoyao.li@intel.com>
References: <2026110458-starch-scroll-7508@gregkh> <20261105121320.2093899-1-xiaoyao.li@intel.com>
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

> Preserve the negative return value from __vmx_handle_exit() when a bus
> lock is detected, instead of always overwriting it with 0.

Queued for 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
