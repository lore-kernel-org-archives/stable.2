Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DF58B6C4;
	Tue,  8 Sep 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907178; cv=none; b=sXG7orbOAK+aieRQH4IlmZ+uujx2tt60CLaMFFXigBHCMjQyA55Wc0X2TETJDdE4JHiDZ303wkW9knk4M/vb79ItjUvGk/Zlw5AbUm8vdXiS/oK1CD8lPG8ueWe+uTnHFustpukbWqK9EJJHoT+m5MBSTMUOZuAdgpjR/GIEAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907178; c=relaxed/simple;
	bh=3UAISimIC2rghdurbEjI9N+2ZX/LOTz76+Lu1OR4+A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfqokEEvwaQPgLXlTSL3AU0bLDl6aXZGMnCqwWby6YrC2y3xl7aEg1ztwjo28lpbtxLy2ps3emc22D6+1NA+1TFGl+XnhCwdp/5Hw8iuGMRtJcbVESrvDjZNbQbno+apWkbF3tHUkMtL6pHQ0gphFH71aC2jCZYrBe8b+CLJ7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu2QItTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu2QItTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AEA1F00ACF;
	Tue,  8 Sep 2026 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907168;
	bh=lPHDZ2mZvwtlZu0p+PH8zwGf9L/RODz5SWSKEQXB9ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qu2QItTx5bl0S3lHnm6axqMclUbDmfN6tSqZSTDVYSTKJIDiOxf2Cuaqj1Y1fnOgf
	 il74irwvd/CgUZtd9ixWXGScFDIdhu4hfpFPjT+m7+N7073cmkcvwQDJ6iyVYgdCQD
	 1NQTHwNmszlcsxCw1DGjW/+18zYxghDEXZmDEPLIiPFHQG/f7syWE465U/jTMuFrj3
	 LaL0bbyDAks9LhFstBfFIcDWT2g6x2dafFiti2oS/4KsAJAtFzK7QNfky6bteHqfQa
	 FdLvItZ4XUwnPwsD1SbA/e25Wd7tjh54khvywszivlprXg6Y1Ntblqta3/92KTuOl9
	 30zmWjkzjlQaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Artem Shimko <a.shimko.dev@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH 0/2 5.10] serial: 8250_dw: fix port leak on clock notifier failure
Date: Tue,  8 Sep 2026 18:39:14 -0400
Message-ID: <2026-09-08-daily-reply-0007-8250-dw-port-leak-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908093626.15492-1-arefev@swemel.ru>
References: <20260908093626.15492-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series cleans up the error handling in dw8250_probe() and fixes a
> port leak. When clk_notifier_register() fails, probe() returns an error
> but the 8250 port registered just before it stays registered: the
> matching serial8250_unregister_port() lives in dw8250_remove(), which is
> not called on probe failure.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
