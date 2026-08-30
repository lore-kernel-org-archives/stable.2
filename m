Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB629D281;
	Sun, 30 Aug 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788058908; cv=none; b=BezXK65NAL3mVWIFNQ4uFQonLJ/+rz/+41EebZPlYnihNDxJpRSi4GmygGniPGhlic3A6+x8rMF0A3Rr3in5/xos1SOWXWNOHkqxBLWmVhCGzEgsr+ZyzH0IUDSU0lAxQvoGBiHBfsc0vW8VSxXfsIEsQaevnPh2a9ALoc2r2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788058908; c=relaxed/simple;
	bh=JUnobn2v3cO4dPnb0BFKkelEAgNeebzyOgm48b9CKZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYPMheXw28gTdrPFLhZ6Bjt7/Jpb38Caa8YGCvw3Fu67pIhmKgG/rAnF5NwI81QaqB+cMmY0IxjYEZTYOvZhsv5VDXMzJexW1LzOhRp44Zvt2e9igNyS15w+sQ9PgjDT0biL3kKBjpjnwNjPyYdlWpMjaVRuL0w9KwoscING5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/FnjzaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/FnjzaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B90A1F00A3F;
	Sun, 30 Aug 2026 03:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788058907;
	bh=P+cQXni6U3GYPHJ15XaoclxNFXZQVrVin0rhjt5wetc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/FnjzaJ64ornvXeRTDKXE5eOIoYf828KX2SCoku6JcO7QAHoEnukvJDnYRxteIhn
	 57x+dniQ0KQLcBQIVDv2j71HGAPmhhKSSxXueD6vDcvChRAbGQshKMTaMtVF1OKPRe
	 jDzIKFX1wUyXgyB+g5ki1XYn7UvuyXpPzQIC4zQoGSp5/iKVtloOkosY9HWaG89GjC
	 WHrQX9qBBXKTZCHuTl6/JFtlJcT3a0DYZApunERTJ0AYcCxd7KcbX449++FLRwxcgH
	 l/ShpDezTfZD37kxZs9mYTBXBXH1PdzasuqLdoC/ma6Gn6ST9SQ4SbWCAIUXMzGBc0
	 Jxk6+G4FLYouQ==
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Marcin Dawid <mdawid@gmail.com>
Subject: Re: [REGRESSION] 6.12.y: s2idle hangs after 171ef40fce41 ("PM: sleep: Use complete() in device_pm_sleep_init()")
Date: Sat, 29 Aug 2026 22:56:44 -0400
Message-ID: <20260829-stable-daily-0004-pm-sleep-complete-revert@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829094750.574649-1-mdawid@gmail.com>
References: <20260829094750.574649-1-mdawid@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 29, 2026 at 11:47:47AM +0200, Marcin Dawid wrote:
> My ThinkPad P16v stopped suspending after a kernel update. I bisected
> the problem to commit 171ef40fce41 ("PM: sleep: Use complete() in
> device_pm_sleep_init()"), the 6.12.y backport of mainline commit
> 3855941f1e40. Reverting this commit fixes the problem.

Thanks for the bisect. Queued the revert for 6.12, 6.6, 6.1, 5.15 and 5.10.

> I only see the hang on 6.12.y. I also tested 6.18.45, 7.1.8 and mainline
> 7.2, which carry the same commit and the laptop suspends normally on all
> three (see the table below).

That matches what the code shows, so 6.18 and newer keep the commit. Upstream's
argument for complete() over complete_all() relies on the completion being
reinitialised for every device by dpm_clear_async_state(), which only exists
from the v6.15/v6.16 async-suspend rework. 6.12 and older have no such call
site, so a device that never reaches a phase list keeps the one-shot token and
a second waiter blocks forever - the same exposure your machine hit, on all
five of those trees.

-- 
Thanks,
Sasha
