Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239636;
	b=t1CJb/I7CykdG7B4QSOocesLRfchW0P7wfPY+rt2EyQt2Mkh1DnogA9pgcAJctPPHeZX
	 dh55e6CxyR2Gb1lQ+bgjZU74DSKv8PoCpr2RMRCB0lQS1DD4dAR/h0R3iGtvxkhIiMYvc
	 rkDIcmZPVH2DAiiYhh6Lg3CHG3BfvVN+uiSH1Kb7W77TGNQxbsRdBNpO8Bzgu+WTvdRFi
	 K50Nj+WB77YQqY5ahKPJR/hVWXutURVuhIvsBflf0QPUxWkGDHBKRrLtUX/UfU9GMqqaP
	 FlThosFGv9LZRf5Aez0Ls2P5R/9PsSkgGtkBA4arl9foTem7ddazPtqCWE16a2T8O8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0JI7u5St9ZMS8yEnJep1Ah3uu5I8IAcjoXl98vxnLjY=;
	b=aa535Krao396AjIJn6PUvcVWm2937hq+10tSjWfY18o3KqhYIzmBUt1k8cVVOf9KA64t
	 ohyPn3NZQXNFN8qDj+wuRgeRwnrd1u53Ga4DhHZnCEKSRiCsNiSZptXi/AV41YOee6r77
	 Zq1qBmgaFoTGgHWyOsjIOAer23pZotIOCN4VqzLRj6cAUqdKGulU2NDEZ0OQGDMOaUPqf
	 6m5YF6O+Kf7LEjTAVyB4vlhV4hDgjeeoA5zkkjrCxlnMavbeOT6C31uixmB32WUk17oN3
	 FazUXX9q9R8ZvT6jADsm4qTOaccYHk7LNHv8z5mMo8EnGS7pud+pQRllUxGUAU6ovzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isVbsNsr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B798606A331;
	Mon,  9 Nov 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isVbsNsr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C655E1F0089F;
	Mon,  9 Nov 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239636;
	bh=0JI7u5St9ZMS8yEnJep1Ah3uu5I8IAcjoXl98vxnLjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isVbsNsrn9NZOdBU5mErPk5TiX3NEjSLARVVHps/YGyjo9LS7nhGymakNjePnMZpI
	 z/Ue/vNu1cBO/g+jxWK29QXU9o0g2JuQfW1fjjRG7mv6CXsbXe00lfl2evdkw0huZF
	 tomeCp+Ra3XMXKx8UrjZcjfdoIteH/dbLZs3B7mxsDwlgB1ZPcrGA2ivAkBeR+xJiD
	 9jd6oswnxsgSTGyXa9Z/QVCVRdgsRTBt7Apk5SJ0FgnkURjQmSwpahVlAM0YuaG3Kt
	 aqtE5eLkfN8DuFHrApO11Or5Pmyop0OVHvIAsmhtAAB6PrhDdzxz/13YBvQ02qQRln
	 skL9QIUhQX3Cw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Mon,  9 Nov 2026 10:53:12 -0500
Message-ID: <2026-11-09-1-daily-reply-0030-rose-ax25-41@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YDcJX5SKpss6TTnKwu83BCAWOrSzLrPAVmf-1hNryXLGA@mail.gmail.com>
References: <CAFAa3YDcJX5SKpss6TTnKwu83BCAWOrSzLrPAVmf-1hNryXLGA@mail.gmail.com>
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

> [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)

Queued all 41 for 6.18 and 6.12, in mbox order. Thanks.

-- 
Thanks,
Sasha
