Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982965;
	b=Oa0/esQb3sZ3pzxblB+xvqydEKNPosuH9ICS+Xpk3c1CfS/ofnhtUFa1knKrkBblheGK
	 8yqgqNd7lTaKyl3O9aVfFfBMKYR7E1I7cwMJEHfgRchaZkbX3zcM/smE+Dov8ngw1QDmf
	 j2a7ss+uKuowmw6x7AeNpEqw4JZsnPyZ7S9ego6brEZWanE9Oc0sLGT9Qhp2BgiLXXqWp
	 fWMD/4Rnew3hjIggI+7UQpCT4070zmcjMBkbEvzbyw6laVSdtBgAf/RVpzbjOdJzUGAT3
	 0TBXOGAFMskJryCPfj4aRj6R/2w0xaG47lhlcnJeMPu4FVaI+FtyUf6PoU70e0jsb3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ikaZ36njCFfn/vQAe5EvHUmMYcmbSo2P2BuFpD/hzFY=;
	b=4K+Ai5WgdboVARWIM5vtTxS2wF3DHftIGXwsB3CUyMc3WK0BYzQ4EalhDmRZquSftXoy
	 p49CkPjshBa6UmkcsMXOWT/GVulAtRs6Soxu1PSOmKrqATgDUkF/b5UjUqJtn3+S08mxv
	 rcmM2P0yt+IcxRA2usCxbIMnI1bC8Sb8jMui/g8RifUaFW39V70aZ0E812V9D5CpbGTLF
	 CUnyRFs8QRjeMHhfmp0uTPQj6OHogvGdEMSiyqxJJ8C6tEzwLSdnzYMahXcbzaE5AqwzR
	 F7kyKhyS3klcxq7bpBbNFwwRHhqwVMqCpcRGTUe4ahoHlr/zhyvLpTVncRxq1OQ7Mzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTfNmR85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A71606D825
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTfNmR85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE89F1F008A2;
	Fri,  6 Nov 2026 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982964;
	bh=ikaZ36njCFfn/vQAe5EvHUmMYcmbSo2P2BuFpD/hzFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTfNmR85dQNxBVMoJKMLv3cVmQSDKpg1ZBL6yfZtprrkyCnleTwqu4pPX+lF1rx2W
	 OvIqtFGT24AiJCDxYiIz0ITsjfSV3P2DeAzWsMN4ipeRo+otevY0iSga6ieqJf7nZH
	 B4o8inePnKjsQF/vaMNH9JL6OgBTU+465aI6lwszuRFZUygmKOMQWibPFZQxxiL4Xf
	 hFR08+Gb/HcCp33JiMv0z1PvST3h5XwPo9Lg8fWmnI/ogSD6IT9O/oQB+EbMj6UaJk
	 WQX2qbQB+t3Mlc80xBzDbssTAzGT6cz37xzCZzQk5U/ykJMusKru1QiM/tgRwY33t7
	 3AqNDSxqVwiVQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Subject: Re: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers" failed to apply to 6.12-stable tree
Date: Fri,  6 Nov 2026 11:35:42 -0500
Message-ID: <2026-11-06-1-daily-reply-0007-smbdirect-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1cc78f27-f1d8-48aa-861f-1f8a3f84b9b3@samba.org>
References: <1cc78f27-f1d8-48aa-861f-1f8a3f84b9b3@samba.org>
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

> smb: smbdirect: fix buffer length underflow in RDMA transfers

Queued your backport for 6.12, thanks.

-- 
Thanks,
Sasha
