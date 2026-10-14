Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD152D949F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941246; cv=none; b=Tg+XCYTfjX3F+ygs90E5ZxfcuipZiYt8tws6CDOBB00feEA0Dhsxgq/XHgDoVBGFi56CL3z1Y+bVU03thtDRUkdY3lQlwrq2b1eQICeOzESHTkSJcweV3/wtKdEXvbCHzBt5w0kFueSqdzZXDUpSgUTyQRdfgMurEPoBu7aBePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941246; c=relaxed/simple;
	bh=4Y4vSCA68GglQoe8UaqCar5omnu5n7ZaNRhGqEchy14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RssER8hUKrFBneiRhNMd6oOjobccJjnvgcBaZhSiJedT3NU+y+S+rDKRm0jX2mb/8slI+jx2OiXP/nZ/skrxUb3/BIqupG3LT5sltOVNl49oMkKh1M1jVnxEGbgamtnAPrcFZMiq85HEhz5mlNt1F2yfe5VtIU6BcKA1GyY8j7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxJ/Qg9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxJ/Qg9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9DC1F00893;
	Wed, 14 Oct 2026 01:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941244;
	bh=dC7uVZ5JuPWU+ovbaZ7b8lM9/bDD+Mfm3UXeLGskSnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxJ/Qg9tlYAlR0XJP6TaIjkX8b2PpmhU+7GKr81w5DDTk7TeCA/Cio0vSHk2nHbUD
	 SpaO6hL8XrKsNGDJs8Ql6fkMRFZJk1xyGApr8Xi3QBG9pKxRN062L7QwtIKcI14Xrv
	 Xa3rATfJzopgcDXyp///+LkeAAff7Yd29lshrreEsLmCnI/OeEM2eXZ47bHQ1aymAQ
	 hEh8ONmObWkjzZ43PfLcQ535BCKullE//5SgImlOD1J8FXd8GROxf7u/RCFARLoX9N
	 1a4nudd83nxbjW455vgKsyYC5wFzyAl/2nB0bEJKAiQIJDUK7j4i/Eel9IfCh1fdnr
	 f3sWzDIczFM1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nbd@nbd.name,
	Cristian Papa <pcristian292@gmail.com>
Subject: Re: [PATCH 6.12.y] wifi: mt76: mt7603: initialize global station WCID
Date: Tue, 13 Oct 2026 21:26:54 -0400
Message-ID: <2026-10-13-1-daily-reply-0003-mt7603-global-wcid-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012144231.22154-1-pcristian292@gmail.com>
References: <20261012144231.22154-1-pcristian292@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Initialize the WCID before publishing it.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
