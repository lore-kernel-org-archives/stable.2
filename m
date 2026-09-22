Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF45616DF;
	Tue, 22 Sep 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091552; cv=none; b=Ygj3aF9gTPyIDFJ87J/vYzmzWvV7ailnyDa77PXrGDCP/TEHBczrjUl7/oyECr2xecSr9DABrq269QwI7F9arKBNrqCHjRg2b8uuFjAPJi6o2gIi3ilLkG7Q3/ELudwLhe+q0TFEJFzxFTVDik+dXinHfJUQn1omVvB8R/PKcp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091552; c=relaxed/simple;
	bh=rYsDJpUjVTW9b/i1oJtFM7HLMhQQNb4/jMkc3KI4OgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2c2G0xCRdnjbhXjUb7UyQ0OOPR0jAyrT4/WHngQsfldF8fg4asnVpwA0p1BlXQz4Ypo26fzXLFyoKxAv114NQxVWAAx1+/es/rsHTWbbppMbbq3SE6H9VG/WMdKrHsXce6kfeELfSQrNC3Q1NOF7BHnMao//lmZ4csHmC5j0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2xLrZhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2xLrZhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C141F0089A;
	Tue, 22 Sep 2026 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091551;
	bh=eslupbQWv4/K/Li2rbfQ7NpkGlcRDjXXiOldlACBHFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2xLrZhH0/osMkUnGNl3cThTq0rzAZH8BhOQkYAdA5uvFzaCNYY3OTrPonbFzH91Z
	 hJxh7VGum+gN8Y8dd3VZrjdNMxnW7kpp2mrXfsgnLSlu/NPsXyoO3FCxqIYhoZ6SxD
	 waybR9xCUvbpZhx/qYLQITmHWjBp5T6fskMXtTKF36OB85EGKqgl6InLrprlfyxXuO
	 7nciQ0Fh1p3DywHTaXf7L5mJi3GRTYpFnkfE2mKY0kbhoqOhZWmlXUMXP+XI3NCeUZ
	 x30bZeUim/mr3qM4Jr/DCTe2vEv4Dpar5mY/VpGoTjpCXF4Itbyxiyr8QNOjqxX7Bk
	 kDE7qEIbIWUDQ==
From: Sasha Levin <sashal@kernel.org>
To: Grant King <gking@serow.io>
Cc: Sasha Levin <sashal@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input <linux-input@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [REGRESSION 6.18.48 -> 6.18.49] hid-asus: ROG N-Key keyboard dead, also in 6.12.y
Date: Tue, 22 Sep 2026 11:38:59 -0400
Message-ID: <2026-09-22-daily-reply-0006-re-hid-asus-nkey-fortify-handshake@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAGwozwFcBQkdR1SH-11S-pXsWW3GAxZBUbC5WotAOu8uzcDpEg@mail.gmail.com>
References: <069bd866-4eb0-4c42-bcf4-6983ba59aa49@slotpi16m74> <CAGwozwFcBQkdR1SH-11S-pXsWW3GAxZBUbC5WotAOu8uzcDpEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 0919db9f3583 came after. You mean e82ae34af29e910 is missing that
> increases FEATURE_KBD_REPORT_SIZE to 64, correct?

Correct, that is the one. Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
