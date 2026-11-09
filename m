Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239646;
	b=NK8OccmfBfnrzNkSUDPy0wxtR5nPSqYNNmXmrbNbLxedXuGxYVLsmEGXGZvOzooGoTVD
	 zOStOf/ZTQR5ryC3OLzu4HhF8jRXchREMftz8m/YwiZuXZr4jCSlZ6Ux0osEXjRR/z72A
	 4++4JixOECeeMJHPgPSSjDjlooe+uxGva9i7BM6+bYXF9+13irBNcmYJImhxhVpl2ooqD
	 dzDN2yLUkpxWlzpxeivDB/7NcqJ+tCdD8Xba1XRAm/k+44znkyjCVUzLUKXxfo0n/jb/a
	 0fIJMKDe4E3PKttA2hisOxOdo6i4TUWLudm525B0m60Q5jHNUNd6T1dRrP2E3/qdgWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kd/yK4v7SD6N/JpnE5FX18W0kbT8VsJbvFN5P52eyxk=;
	b=mT5O9zo5rpF6cwLHFS0pE1gv8PY4Tosx/erU4GgzAqKG0DPAaBVq7I1e4pON37NpXPjG
	 z6jJMhYUX031NsV+pCUVSNjvgFmSAimFTMKHItvgZktbiY/iLvjpppX2Ilsi0BV2h7995
	 LhSHBPP2P+ERG7JtfIUm0cexAE5NzfMgC0L7AJdj5RgTdEDmSeODG7P6qtEG/1jaRxaXe
	 mhaC1GfJKqdRNDfUVMrnyWA4Ztct7m/0GyFBN/wcUHCuS74Fmp2bLaXq6ZWfQa1uTuiFW
	 zMskzddHyxVyYjiQmsEe3huertylnh4wTgnW1QrEA7viAuuyAjkzDXcB1CdGDxdsKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiRBvd88;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520E606EE81;
	Mon,  9 Nov 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiRBvd88
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899A61F008A6;
	Mon,  9 Nov 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239646;
	bh=kd/yK4v7SD6N/JpnE5FX18W0kbT8VsJbvFN5P52eyxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZiRBvd88y1YX3YCLUQ9r/O6Aq3yFkHUsfKLJ1ygeZXCEQ/wiQ+7EZcgPzZnRwN06F
	 X0YSv29rLzEZMoQlSFG1mWoLjED4tCFFr3xC0OE7/VR+GjZD41fPad2Zs+lsy/68tP
	 wAdnlYMWgvIzMcnkbeZtIzFRBAlDujxA+FUhH6l8zHpIBus/kkXw9jewvRuoxjPBrC
	 6TAkYtGvPZLGvSexkdUYZCMaVM7ZYhH1rAfFV1k0osyzh4t//JW7nl0FKF1bH7632f
	 eAGMdMy4uLtnOzNskx76wan+Vuhs6N63hkJRNzkM61bhGMPe4VKjwo7d4Mcw9qdJmg
	 JClG3N1hjd8sw==
From: Sasha Levin <sashal@kernel.org>
To: kuniyu@google.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	lee@kernel.org,
	netdev@vger.kernel.org,
	rodrigo.zaiden@canonical.com,
	Tamir Awad <tamir@auth.ink>
Subject: Re: [PATCH v2 5.15.y] af_unix: Clear oob_skb in scan_inflight()
Date: Mon,  9 Nov 2026 10:53:21 -0500
Message-ID: <2026-11-09-1-daily-reply-0039-af-unix-oob-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179418529889.10436.12048717656065553331@auth.ink>
References: <179418529889.10436.12048717656065553331@auth.ink>
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

> af_unix: Clear oob_skb in scan_inflight()

This v2 applies cleanly to 5.15 and looks right to me, but it is a stable-only
fix to the old GC with no mainline equivalent, so I would like an Acked-by
before queueing it.

Kuniyuki, could you ack v2?

-- 
Thanks,
Sasha
