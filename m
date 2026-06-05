Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988844BC97
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688265; cv=none; b=DyP4ILRiiIfL+QINfHrxQ2PCKBGdeSwwpwdvk3TQkyTFLDavu5oBf6O08hmKLF4MlBveL6WX2K3X4+/NAvjmJ81jYJcd7KQaJYNv7651je4iFh1FBHjO7NBnRZgjWcVYqyZ71B9xllrJuksogR+9sFWEXMUD7PNK76a9I+OnIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688265; c=relaxed/simple;
	bh=MEKBTAqZiHafmVKwX2Ozu3VHmwK1MYJnIkvXj9Q3ZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VStLCABTQuQEmi7kCZq6f2JTj7CO/dxrBtaKrdacufbsLW1bVjCaDaUwqOg6TSpT70ltMeFMPPpoIUIyTnl2vLvlhi1Eez9M5PAMX84xnkGKxdqVif1o2YQpfadfOTmScGxkeUZcOQJxhk8M87kXmvDVUnhkBAW/oYNcM29tHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4PW01on; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4PW01on"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7FB1F00893;
	Fri,  5 Jun 2026 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688264;
	bh=1N4P2hKAYon+R6VSMApKddZFDV7R7fqx8h6JWq2rcI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4PW01onVhNCIgRiiYbdP7AfSe6sSxohGKm/naWtnovI73qxr8t9egdF2KGx+1Hux
	 IbfsN8KbLjhb4/qc/Iem1IFFFzzmIbocUTdJzsGqViUKpLuK88RlUC6SWtl9Fdwc1h
	 hbLrOP6D7jlS5Qcn9IoBHijK6hR+QdWETf0hVFjgepA3uI+EL5L/23SN+SFioSn8xU
	 57t6kiZhmS7nfn9IBOKePXjPoD2qoIT8pgQr2+6loklX0a5Gjm7/DXzv0GvgTr/fHZ
	 G50nGQ2tdYu31eV6exojAjRKsdibVhGjD9B5J0KYUnwUjPnG7EG0BjAboJ7wO55/yl
	 mAxd3UtapWK2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with small endpoint
Date: Fri,  5 Jun 2026 15:37:16 -0400
Message-ID: <20260605-stable-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121133.2771807-1-johan@kernel.org>
References: <2026060400-renewal-coagulant-3a75@gregkh> <20260604121133.2771807-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with small endpoint

Queued for 6.18.y, thanks.

-- 
Thanks,
Sasha
