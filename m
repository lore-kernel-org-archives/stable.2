Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACF3B83E0;
	Fri, 16 Oct 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150075; cv=pass; b=JDA/skpVphRIZx/P2oj1g9Qsqp5aGqb7GrqO4i+Ihuh3eGl0L54f+C3SpgcuW6aKOHIHHId6AE6WbzvGGRYABNR0AtGd36BcoW5YDlBuieYo6PlItdCkJXAmS5UARlJZw6aOv+tsD7xbRWiYa9O/Rw5OI0EkKD1RkkfhXBmr/64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150075; c=relaxed/simple;
	bh=2ixrCFJ69HyZ7x74rUGUp7aQspQfHfU9z8w0jtiD/dI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TH66sJ0PeoVWqP0xNI6OvTFrFU2sbIcMBVsp7o3XdlLHHbds24dIZA4Bg3x7u62zVapsz0WpWaIIxgPgsDZQqqQw61LRN1xtUzwt5uvBkTCatYofUil9SOFEzFXlwTk1kqWFpRe4xY+/Zsl0bh43UVasK/Q12GiSgzCRrVG7QiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZFuCIG91; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZFuCIG91"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A16EC201260;
	Fri, 16 Oct 2026 13:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792150070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgpJsmMZ3GetOtymAsscVBBciUQWz+Urf241FBr2MWo=;
	b=ZFuCIG91ok6tLEngzHohVfX5UR3OxAfoRx7ZZn+GwCsyHozrJGEg4DW3gkV7NprUMwMNzl
	+CJ07Ld/pGR174duhAuErnEQ0PT83IaTEZk4pXtHG7cwjPzeR3Xr8ShnQwi9+tCRqsq1um
	KI0DUrHZItjw0jbpZQbQuybpWiEzQ8etWQGUsaEoFJkR2XmyACMf2vhTE7JtgeqBkEkUsE
	S4c2fLvan8xFhtz94+U7Yoq631YEXLaqUizDpbsQ76wNX5HzlEWCSPa/T4YQIaDjB3Ozmo
	ZQOYbJVFaTgkcf9w3FpVYv4vvnLrEJHb0Bjk5q2u3MbTwwNUpu5sCI6SPGn+pA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792150070; a=rsa-sha256;
	cv=none;
	b=Jg9bRMIiqfiSYd4RLmbe0+yyDpHfoSEqN7y6ADS6v8ci1fGH3iQ6iynRU3rzFchq9JDsAj
	9M9/qZLB6vc4NNI7YxPIBMUFEI1KLFgRCJ/AR8z6GwbAcFhHG0X6lleYnAv+Gq6FmqfryV
	/MuK2jeNqNHSxrnac+MoOZJ8kqX54MXwU9tnOJktBnuOnp4uAQUOjN04Yxh2lOg73WdG27
	ByxjxTSYTxgvr2PfUeGV8MsJ1sT5naxUB7cmU2ZY2ld8vEAgWr5kSw7l1IDIdlJbJ2B3db
	b1hUezRv+4hvXMcm9zqMnDa2dPfSCJriuW+8Lf0j6TwXpe+rTB13Qbcs0po8Kw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792150070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgpJsmMZ3GetOtymAsscVBBciUQWz+Urf241FBr2MWo=;
	b=JEcGeLufdwBruNxKUw+EbivoY5ToAG+C08cFBb/sluc22lx0lnz0yjnDP9TEs95uzuG85m
	X5wurfLO+qqyN0ypysmzMZM9CQWMDVe2vN5xKQbYJFobH/V9cvLUoKvqbQtb0GP0M+tPDi
	jshhrNiPiOZTOpfA5eMWjupicqAijRSnj76V5AWgsTMmMO6CcwirCzhN2wZ4nmD1VbvqSc
	Mpb+te3LUOil6091SRNuQPywBpBmPhab0whvf4Uuo/B/DiB19G+mS79Hc1sNiKP4czYsLG
	oDCOjroMj/vgHB3oyS3sN8RrXBTKGayvmjLl1bCfnANOWC40RDkZUqbMLSSd5A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHg6I-006Az2-1i;
	Fri, 16 Oct 2026 13:27:50 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 12D075C60F6;
	Fri, 16 Oct 2026 11:27:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, stable@vger.kernel.org
In-Reply-To: <20261016110905.422684-1-socketcan@hartkopp.net>
References: <20261016110905.422684-1-socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v2] can: proc: reset pkg_stats atomics
 individually
Message-Id: <179215005975.1270011.3236350059569858635.b4-ty@b4>
Date: Fri, 16 Oct 2026 13:27:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=306; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=V+jTgMbmXc6vkwephy/qoPBjGCJxSeRsHstGZ+PJvqM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6xGXYf2a2t8mdh/EPmH7cbPKIFDO81epx1mCx4rRqr
 RoNx5eWHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjIf2GGP9yPv04JNMjilhB6
 F6lWtIsr1nTGtIk5G+/OyXxuH5xe9Zbhf3X91u6JnIs+ntR+vPYXn3TklAjXBSk/hHujeExNvxZ
 zsAEA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54


On Fri, 16 Oct 2026 13:09:05 +0200, Oliver Hartkopp wrote:
> can: proc: reset pkg_stats atomics individually

Applied, thanks!

[1/1] can: proc: reset pkg_stats atomics individually
      commit: b2e10ad6fda77450cb6c49dcd4032140395a2b16

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>

