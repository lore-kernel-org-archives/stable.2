Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B667364EBF;
	Tue, 22 Sep 2026 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043835; cv=none; b=P2aclTaSz0+RVsOt58RTth0TICuOnPvAqedBlcsO6BIWYtHWpF3Hcih0u0TrPQdBXqt8mzHUE+CuAM0GCJo/EUbYBch2EG41iKBUhn/TY3fq6PD38qIb3s/8tNrnMjFwz+RMHuCdEpmDkkK2aS/Fu5mcaaxNL6D2h+JmGJxIx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043835; c=relaxed/simple;
	bh=xoq6/jLcqwF9yk9d/FxrRv8Kp4YdOAN79i1PrTAqbZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKta3LoCADOeTYgg6t55t19DEEVYz4/MD/ipfh5y6FWIiheb4UqBvH1/y1vy/S2DZ8y+FV67RltzXNcsWK/c0KUe311S8JtiMlj+hrmOIzGVOLRBJRL1XlWO158SH/HAb+97lRSNWtITQT34pu/mcq3mwxZ4Ua7lBmwUUYYt8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaLdrqos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaLdrqos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD21F0089A;
	Tue, 22 Sep 2026 02:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043834;
	bh=VJJy58Bp2GJegnzFAIFwaP1Zzk+cIgNcFrNWfEcdySY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KaLdrqosI+azP5SNxyfJZ8/851yYYC8FqOxX25vJ9OnokOBfQS0sq4mCHH47fYLuu
	 d18m5D0YIFiYxAbIlInGc4qIduapk7fyBn2Abo9wWZmj3WwicSHDy66PNDTiul3Qd4
	 n4VP719aNd9u2venpxSkfrXUQOXSdMgISJAG/c+n6RK6cxviHiWfDucb1laQyEyzrv
	 7IFTveYBrPJ3nJxHI3FcgWD7AVlg0aIec4Kk8D16N/soKnPVLiPBlJ/6Cx/epGbR/X
	 x8/+pyvuK5BRzk2QOy7UqtXeixNvXziGTb6xu9Vsk5ihE6VSYz4p9HyDwv9rJd8x9S
	 ucyOU6ekAZ6Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: wifi: rtw88: backport 737e980e1298 and f24d0d8c3cd7 to 6.18.y and 6.12.y
Date: Mon, 21 Sep 2026 22:23:43 -0400
Message-ID: <2026-09-21-daily-reply-0006-re-rtw88-null-data-and-beacon-valid@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921150005.95894-1-pepe.schlehofer@gmail.com>
References: <20260921150005.95894-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>   737e980e1298 ("wifi: rtw88: TX QOS Null data the same way as Null data")
>       for 6.18.y and 6.12.y. It was merged in v7.1, so 7.1.y and 7.2.y
>       already have it, and it applies to both trees unmodified. It does
>       not apply to 6.6.y as is, only because the lines around the changed
>       one differ there; the changed line itself is identical.

Queued for 6.18, 6.12 and 6.6, thanks. Your reading of 6.6 is right: only the
surrounding context differs, so the three way merge puts the change on the
intended line and it went in there too.

>   f24d0d8c3cd7 ("wifi: rtw88: Fix the random "error beacon valid" messages
>       for USB")
>       for 6.12.y. It was merged in v6.16 and 6.18.y already has it.
>       It applies unmodified, to 6.6.y as well should you want it there.

Queued for 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
