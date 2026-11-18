Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961215;
	b=3BJbl82JNX3BGAcxLWlo94tWbBLTJuIIyJWAC1yXibZbF3dudg18jS/jYaILGEVtM905
	 uGDbp4E8PcOaHHeuX9eWcXCf011HgH2rAGLFKsaohdJKhHoZHlaUhcVVWGfOWPXW/j4N6
	 7vo/OdZOdMGPsLO8W01zLY/pLRHHUFMka6ePpfZ2vI0cZNtcIN8vMHX1/U7LoAEG9IuCn
	 YVVXQjU6L74z+1GrQbtd5NnWlcsVA2iut2SgUx9mQbAvxu7X6YAKbFCLWKOcBw/z3DCcJ
	 aUCD9+3LjonsNy2PxXQ8cUF/ed3BDO/8+7m83qJXemkZG6DaMahnq8NLGQ8p2XzMYzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WsQgH7BU6XlQzwM1jikoHva5MxsyUwqyXNjUvngxBOw=;
	b=vbHvXMsDRN7Me6DXdZ9kb0N/onG743OA8XRATe5Pue2zcY2AKcuTR4Dhw/+t2P7oj5o6
	 Arfbt62y0QJ09alK4CwM7iboTfBCViBUfb4n65p2dfeAQ8YgksR14XRLxALMvWT/sGTtT
	 kIgEH/iMrbhHnR0pTFYEfufHXYVPVoZCxNaW7o3dZwxKtASbvYMm7hkZKndC4z/DWAR+L
	 Lnx871MjEi6rzQD8cimPZOzfidAdFnRjPL+jwBaQ66VX1tLBeyopqPuNK/44obRn/L0Rx
	 Ji0h6Y0JwZofvcmSgGX0Nhgwu7eNU8mIRcsxQmfEM+brmq0Oyaglp31GRyUAIST82cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSVZ7WrO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB84606A332;
	Wed, 18 Nov 2026 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSVZ7WrO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA851F000C8;
	Wed, 18 Nov 2026 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961215;
	bh=WsQgH7BU6XlQzwM1jikoHva5MxsyUwqyXNjUvngxBOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VSVZ7WrONu3+hODkJsc0owciFvSDXW/Am/vCd5FPZMAJpeuEO696P57hNlKxNgMYK
	 PhrbWL/QXLGT7k9eeXlkImIgKhjdRjrsNLVPrhc/LMnDKsr2iXpD+VNknxlQfgkyTk
	 g3Cc/ahGKoj283o4pVDtqvIj3nyOFKaFJDnc0+by6XiMeJCFhbTejilirRq1QXe1ub
	 Nrc6Lb2LAOOSLbtyQ2pF7Z2ARNjvgmEdaUetoxSvr1dxtxsbjxQgYTbAZi5JLCk5NK
	 OwHh47+ndnPjZU8bPeeUoiJpXyBpdjZjAmIoN0dZFNjsq19ybd3pdGIe2KISDOchW1
	 rYe5cJ9TEelDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: Patch "arm_mpam: let low level MSC accessors return an error" has been added to the 7.3-stable tree
Date: Tue, 17 Nov 2026 19:20:00 -0500
Message-ID: <2026-11-17-1-daily-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ab81e90a-fdc4-426b-8da7-45b1a80e88f0@arm.com>
References: <ab81e90a-fdc4-426b-8da7-45b1a80e88f0@arm.com>
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

> Instead of back-porting this patch too, we can just drop the (pointless)
> error handling in this fix patch.

Thanks. Both of these (this one and the "propagate MSC access errors" one) stay
as plain upstream cherry-picks, and 197a7a41e6e0 ("arm_mpam: On saving mbwu
state read the monitors before clearing CFG_MBWU_CTL") applies on top of them
as is, so no adapted backport is needed.

-- 
Thanks,
Sasha
