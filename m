Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602471;
	b=SL9+xs3Dk4PxLf639IFTRFene7zPRZgS7oc+M23tebZlX0b/0CMSMxuCvSQL5MMIr646
	 r9dlzp1xVWr646eBPFvVmqgG9Go2SuvccDKuQmVjFrS3OUqj/mP94/MesVY2CNhqbQwMt
	 axBnutR65wD13947E2w2gzkvHTAS0rc1LprHW5GDprlL17H3FyLncmk3cp9SRgKMZxXMH
	 FWcY7saa8b44wfP/zV7dzsFL/zTkCeRwtKH4JPrmCgnXzJBZ1z/wTx/5oQks63LvQg5IQ
	 4yuwDhnL7RXG2N/5dIUhjeE83gINboisjQzvqThrX65+4v86SvTmoiKGbnDq70pE5YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ewNWW4yq+zdRnHiCXfYXjIRESaWIdaQs5Do6jN9BCYU=;
	b=4CEcLb7X/tHJVIJarSIuZbi+Xr1fMrNpiyEixT9hueZ45hb+9z8pjnNuDUbzEWbP4Na3
	 /ukgwFuKN/EPj+i58gyHpL5EMHZu5gGda/4XXqpFxgeJog8tCsru9x+8IRkm3KBZpQXf1
	 PxFBR+02p0iNpQog2F6TJTeR18oRN98e5GlWipzws88KWQXatgMf+UmWrifaeR6L7h8Xk
	 IUpkzHVV71/cZgAPP6erSIYRMm3Q81z4aSb4+ZJQHQxUBuCOjiMOCkZhlXGw2+ZrzCuwN
	 Z9AtorhMaMC6MBrRBa2SYGGLDi9qG7wQX23m6x4mpMDmz4Z9VSm0a2AexFwYUG/qC9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dGAz0hrc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D76606A320;
	Wed, 21 Oct 2026 17:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D76606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dGAz0hrc
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 21E7C2009B1;
	Wed, 21 Oct 2026 19:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792602465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewNWW4yq+zdRnHiCXfYXjIRESaWIdaQs5Do6jN9BCYU=;
	b=dGAz0hrcyJMWm14/7Mupgi9t/aYsjkAbIur1vA6KMIr8xiJi/4+kgGV0iSlfODE/fBdEU8
	ROXctmvagSPFKkJIvHFjrpKVpiAy2kcOeTBiHADBeBjmTRdGsEVTm0c4bneI3HPq8zhvBB
	yf1rDKZSsDsF0X5AOubEqVo3bv0ZBawv9+3khfMl/35B8qMf3u/N2hXh1oN+SRegY3T4+k
	/yxfdWWd4ISvlRfiAca3zUdL0WOgqRJDGQ35pY1dHJUy+gsY9ug0wYLw4uNeg9AKCDT0FI
	YLDW2jp5x77N5L/6cpvc+7rTMkK9/OrM8amGjnKhzs3d4eSzv9CFpFrliNN/sQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792602465; a=rsa-sha256;
	cv=none;
	b=LyKFDBJJqv9p1VobVVD+4XmKL181HdqsvxrBRokFUY+Xp5JWLHM0VOaWygJN18QF8CnVYn
	Cy+bUw6+MQXc9S7zz8n7glaZJQQTJlUcLxLmiGoyJLTwTixXlyHqy0LHz/4GnsdINHjqX8
	wQYsSehF8jOqJGRW85aFLAglAADxS5edVjDYDqzbwrx739TnSb1u6kMfnCM/IoEAU9HAfW
	s/+EHHkz17YVVWhk5g5tGuEgRChEKrwv/vnvWKWFNyw66giSUf54/U2GIFmoUTih6wt/4Y
	4sZhjzMTWteFMfIC4Qd5C/W4GdrsnPwWGaygBzKkvw6OT9T8lkq9hTpSTUnMpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792602465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewNWW4yq+zdRnHiCXfYXjIRESaWIdaQs5Do6jN9BCYU=;
	b=NFYVEyTtl1tNosfP95h4JqgVgUyBfcbCY4kI4QIN6jniWP6DO7HVVHfUx8nNG5hhdkxlnV
	wd3wVAINjjAywSIZXYkjP9ZhAC59EQ1ZqSYkwtb8Wn+S6WJuMFeRMoD5jygaO320zBSuBC
	CAU5qBnAGrdnB3nEi0Tzl35WkpT0v9lCp7c5zNEg8QYv92K9YNsZO9KRYJOX+Nfxr8fBaa
	GooLmCdSCqaEMza8i9RnJXgfvdWWIfPKzcw/aaV2x5stwn+PfG5DEpZ/wbrRkmpp1Yuo5T
	cP42xLey3+EfCA6PebMZfk+TDMuTPkicAiwkVDY7OPNIdmJ6pgLuo5aIK4z97Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJZmz-000aJ3-0A;
	Wed, 21 Oct 2026 19:07:45 +0200
Received: from hardanger.blackshift.org (195-200-20-154.mclarenap.oninferno.net [195.200.20.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 577CE5D0404;
	Wed, 21 Oct 2026 17:07:44 +0000 (UTC)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2] can: netlink: fix static FD-NON-ISO mode
 validation
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <tencent_3A964832542399A780E646D6A6246335C409@qq.com>
References: <tencent_3A964832542399A780E646D6A6246335C409@qq.com>
Date: Wed, 21 Oct 2026 19:07:35 +0200
Message-Id: <179260245524.2007736.8770336947410997167.b4-review@b4>
X-Mailer: b4 0.17-dev-d58fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GDIzyaNq14Zn+RBvhFkYPG1z+H+EcKQFJ0t3p3ajEps=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi68THK7FWVlMbDD++zbtd8evfj+faDtzNfPLl0+oGzm
 KdWI0/5jo5SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMJM+Z4X/cUefNQXebk7S8
 l9X82nzaOOtRRK8p45815hJF+0VnOnMzMjxprP8yL+rWbTMey2//3ulcYXU2WbpyiuD5bN305Od
 8sTwA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On Sat, 05 Sep 2026 00:20:31 +0800, Zhu Ling <zhuling0805@qq.com> wrote:
> The static CAN_CTRLMODE_FD_NON_ISO mode does not have to be specified when
> CAN FD is disabled. Since commit 6742ca18cb41 ("can: netlink: add userland
> error messages"), ctrlstatic_missing is calculated before applying this
> exception. Disabling CAN FD on a controller with static FD-NON-ISO mode
> therefore fails with -EOPNOTSUPP.
> 
> Apply the exception to ctrlstatic_missing instead of modifying ctrlstatic.
> Keep the original static mode mask and restore it after applying the
> userspace mask, so a request that disables CAN FD cannot remove
> CAN_CTRLMODE_FD_NON_ISO from priv->ctrlmode.
> 
> [...]

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
