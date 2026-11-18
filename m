Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961389;
	b=J1R4P67G99OgNeQCp4p78LpBunpu4MFPjqmF1Qsbp2Al0lKCIvXCWfFq5LeRUlRjFzzp
	 i4O1mGnaJrCpg/eScDXBQLpcr7mlA5J+iGZ6TUkBOjy3LP1Nz08ktquDdf70L224Zv7YW
	 xveZOtz185tZ+O8PHZ6y1Pjw0O6HZoKeZPJK9tzRZA7VJuQXmSAmeVDmmJzblpQFrvEe/
	 1HET7O8gT6QtmEAP4jdqYA5PZu7r6JyMzuusQb9PWOgktdV2GQbVNXHcF1dfufJglOSNg
	 YgkkvNwAOzNGkNReC+we+2ejA2y9rYDbuWa+4l0kiXJoBpDes0lkiD1tQwIgzeHWMEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WsQgH7BU6XlQzwM1jikoHva5MxsyUwqyXNjUvngxBOw=;
	b=NWAur+eT85+j6JcMlqZgUpNbHEImgNG7aCylkk5Usa5bWs1WRHMnS+BkJRR3sANyHW4W
	 dO0mRsudbWRlz0E8rJeRiJlkEpfSgJLiaXEeVQtmHUZ3A7sCwdOQBjgos+NcxLPYuc2TC
	 ehT8tZ0DMurztsskpRBzRxU9GJy9cVJl/oMq8h7UCWnCz/0NS+AWX29dgey+Lje3u3NhY
	 b0X3HnX8Hocz4EnakNnhdxLqLSGyJo/5lfN73OtT/2eEfT9SBUw1oWMDciMpmDHesNN+g
	 s9rxy9WiYpQxxpE/se/nNhcZFhVxocNuxVRFUdURqJcbyATCpaTvv9LBIc470qt7Q2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4PR8Rvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A01606A32A;
	Wed, 18 Nov 2026 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4PR8Rvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493491F000C4;
	Wed, 18 Nov 2026 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961389;
	bh=WsQgH7BU6XlQzwM1jikoHva5MxsyUwqyXNjUvngxBOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4PR8RvgKSCHVOStmkJQEvVMILbehJXA+rPxAZyMD0WwQv7t7A145Gh5MDTrECCXI
	 cOgZFFUHU5gYAETiRWbWIhuoUHsz8ICdgfWQu5LVbslkC2FPwpgu05ahtFzh3FEYaS
	 6IwvHVTg2jV06OiVhGrH4sAm7DGH4h8/diKSasT3Jq94dH+3WEWRVERMHGjZDNf3d6
	 LMWy/xI798QV8FGgXZqnZ6k3ogTlf+Jetj3tuI4xgYQhCA5iw5zkIlBDjs5ThwXH29
	 0aCF2GJcan7+SdLQ39SZeUZ+gYCk/S62uhDIHR0w4P5FI8G5j5M4T2Kw/Cry+dctHT
	 SOHAjWS+Zf5uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: Patch "arm_mpam: let low level MSC accessors return an error" has been added to the 7.3-stable tree
Date: Tue, 17 Nov 2026 19:23:07 -0500
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
Message-ID: <20261118002307.3zUgWZ-5BRbOHUDq8BVKrBK3MWMNodzJn7ZS05iBHNA@z>

> Instead of back-porting this patch too, we can just drop the (pointless)
> error handling in this fix patch.

Thanks. Both of these (this one and the "propagate MSC access errors" one) stay
as plain upstream cherry-picks, and 197a7a41e6e0 ("arm_mpam: On saving mbwu
state read the monitors before clearing CFG_MBWU_CTL") applies on top of them
as is, so no adapted backport is needed.

-- 
Thanks,
Sasha
