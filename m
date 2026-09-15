Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEF3CFF6B
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437829; cv=none; b=b8Hr69K14QWFSC+RRZChURoZbMKfHLbRorF/TcAa8gYtSYvI0TApWZJMzAN7p/Zv34Sm9w+P/EPU0MNqwUy2LfaNLxc8ZRVPnhVHwbzIUl1CzASSanoUuo43H3AHbSIveOIyLB9xwCQMlHSe3pYD0Y0fozJD40uymIK80UxX31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437829; c=relaxed/simple;
	bh=rKlz0q+fiEcco1baF8sNaf99xw/vWbxveYvdcgs3aUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h31sMbAqdM9FsW8OhPLJDDvc+lMD7KMvpJWjnbzhzvwFgYIRkzjyu+CRvgO/K68ZJ+gpTO8nnRcSa0v13lxb8u0meg6hsxaP+gXnW8y1d46t+msegdG8DDNKHHaYEKdeXbW9pFSynjSWa2EyT0u7bYraNS/5Ew9l6RwUsxUBLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6QNKLhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6QNKLhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047901F00893;
	Tue, 15 Sep 2026 02:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437828;
	bh=uTOXD0CcNJ3h8OzTcg7A8+b4Jno7zuN5Ic6L5HbkSh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6QNKLhxfNbs5u+BvVWbA7SUAZZlfUI7xZZ8JnQdwxstqjqf765e//DkQwO819bbq
	 N+5YDNLpnP7dNm6oTY30+zlsF3HHhs7cnOAGG9VSb+xF407d2HNO/i/1UU1T5Hvknx
	 CSNdaTbIkrqTOeOgB+OY1PkMoakRWAoMIkhrN31B5Wzazum/aeq79B5WM5B7KFLLKB
	 hW+hfYohJIVbaRtJ9CyzRenVysYgtAVZYbRj+2XYhhN2xyEkmdzEAMc33NT5aV8QSO
	 tUNCMU7dhqzrvTJYUg8cPZ2NTYMAP0aRvOhjNThPhIGZkql6KelizHpGR79cXDtC9T
	 pEh2pyTJbZv1w==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Rainer Fiebig <jrf@mailbox.org>
Subject: Re: 6.18.51, bisected: standby/hibernate problems; rtc_cmos error-message during boot
Date: Mon, 14 Sep 2026 22:03:25 -0400
Message-ID: <daily-reply-0009-re-rtc-cmos-irq-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8f2a6bee-9357-57e8-22ee-fd04637494a5@mailbox.org>
References: <8f2a6bee-9357-57e8-22ee-fd04637494a5@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sep 13 23:20:40 LUX kernel: [    0.533984] rtc_cmos PNP0B00:00: error
> -ENXIO: IRQ index 0 not found
>
> Bisecting between 6.18.50/51 produced this:
>
> ec2d81115485de3f604f86edc4d9119a213a59bf is the first bad commit

Thanks for the bisect, that is exactly right.

Queued the fix for 6.18.

-- 
Thanks,
Sasha
