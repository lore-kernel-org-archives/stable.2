Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A61FCFEF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828864; cv=none; b=kKU+RrucwpWs8zxy62rfzuMgEj99M/FiuqEJxfeUduWMdDieKbPy5u8TdnSKr0WlRnpdOsrNZo3VR1YsdWVBdgUUPIXEl4yKhzjnhusjaaa0VMI6Q4XaW5uFpKO7az+QcOGRWZ+8/t3wGWDd6yiZI2GQ+v6jmqfiTFAB52Pb594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828864; c=relaxed/simple;
	bh=+DVcoLL3cwTKMIF2gt7cib/r5/FzZCnFTviaRvo3Hik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0cQ/9rLzKLMq3+WhzXOhrmC00puV+JQWJXbGTYT6eJuCv65drX/bNW3AmyqwK5OSCEEJ/5FtBpp9FgFOY4U97YmHKdEbmkyYKia/IGw2saxJ9Ym2rCc+sxPhSVopbczh0/OCEr+zfDJ1a33aeXmvB5DuWpTGkBZlHBtP2AmcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXWcwNOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXWcwNOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876C51F00A3F;
	Tue,  8 Sep 2026 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828863;
	bh=god87TCVaON5UBrSVdghkwZWZRX2OATy73xCSvV8NXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KXWcwNOT28jPfeg78p0Qnejp3SQOg7e/gBoMbCz1Ixi+zNWu4YWZtF5ZRPo0tnXvk
	 8bYiCK3JPLu2XMhDE7QfNFGCPFS8wsHNOnT3b3KALk/I2aLTDldikMcjxq9qrxh6M+
	 bQbt0ZFMXnvwqkBctNdbF4rQBtJcAw4DlUZOwhdDFZ+RNGop1B+4KMqu7SxT4dk36k
	 fiTFmEohN8M+wSzoCBwh9r3EVTyvsc5+zw8HGrNSA6ed0ALn46wFlOA+uJuyq1Ksw5
	 cBlSmmKiLHqUP7RNSOR0FziUyh2OBshL5qLG2OZTl9eL8emnzUZ80ChS/s83pWHL/m
	 OM/MRCdOAU+Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Matthias <darthm.linuxkernel@darthm.de>
Subject: Re: Bug - Kernel 6.6.(148+) - PINCTRL - Missing DEP/Selection  (GPIOLIB) - Build Fail
Date: Mon,  7 Sep 2026 20:53:55 -0400
Message-ID: <2026-09-07-daily-reply-0016-pinctrl-gpiolib@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <feaca654-9ec1-a606-6ac0-4170d2b97c37@darthm.de>
References: <feaca654-9ec1-a606-6ac0-4170d2b97c37@darthm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I found through the mail search this one: https://lore.kernel.org/all/DKXAKNXPFUD7.12UEBJYNWJU49@smile.fr/
> which also mentions this bug.
> It seems this upstream commit: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=45d2055b0067739253883dc541f37c86aad45c92
> is the reason for this bug.

Confirmed, thanks for the detailed report. The actual missing piece is
ec963d04ca86 ("pinctrl: provide new GPIO-to-pinctrl glue helpers"), which is
what added the unconditional "#include <linux/gpio/driver.h>" to core.c
upstream. That's why 6.12+ don't hit this but 6.6.y does.

-- 
Thanks,
Sasha
