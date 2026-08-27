Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E532439322
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858837; cv=none; b=ULaUIuaeWYd1JFISYkkh4Eg1VJvo1BPSgW5iXqlAUcc97cLr+0KvuJzQcChlN6lA53+Krd5pP/lF78JIIEJSLcBIR+dC1rfl4FVf3URE+meYed3ECEwm1Z/RbzTGjbe6610mYd4oQLKEXrdmY6IF5inaXX90KLLib803MvpxYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858837; c=relaxed/simple;
	bh=j7b5lyYB9ypAh3Abyzkgp8Kxyol5gdcRstBUuxw4Qi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KucKlsvCXLwKmTOP4XDd8+7dzmHRf5/zp7DjSDBUS+LwtE0+aNbVP7tSrtZUjp/gIBqFBO7O/V3uQxioiT52Yl8WuiLc178nMKLBk/yWxbG3Ybu38pLC42ACaG+LYG2EoxgymgrxQl8CNSifLrDe2QzEsLco/y3mu9H6pnPDcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BvEU4s0e; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BvEU4s0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858802;
	bh=j7b5lyYB9ypAh3Abyzkgp8Kxyol5gdcRstBUuxw4Qi4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BvEU4s0eGOlf6/n8nzTTTIyCKQDfLbK3yET6WXjJaatnDM598WY/jETT3NwG8jDE6
	 4wxj+0L2tuvL6MRrirxwTKzOlWV3EQnlbjxFu+Vd+YFZoou1IekXjBfvLYbpbbwZJs
	 Hrhua7n1Q15ZDcc+L9NssE6g5XnK6CH50yNEjgx4=
X-QQ-mid: zesmtpgz8t1787858796te29cbaf2
X-QQ-Originating-IP: EWzZo0X6oQksIDlZ02JZ2j/o3laqRWgnDQq+2qBx7nE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:26:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17449751723102607052
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: guanwentao@uniontech.com,
	gregkh@linuxfoundation.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/7] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 03:26:34 +0800
Message-Id: <20260827192634.21200-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827191317.18119-1-guanwentao@uniontech.com>
References: <20260827191317.18119-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N649AdNySAiwGjefLI0KXawQn3JM7jkGD2Q7s/jlJyGBAJhxyZNNvLFy
	oGnghfC6F401DiXWvSbKncSt5e0YIJx5J9wImEN3PL49QpwQeyNUlv9T9H8QsMhD5sunPNU
	L3hDxhD92UdporKgqJlqfN4rlHKuIn57WOHdBO+mfV6X4hyYrOE7A9AAtQXrEsXgJmBjS8D
	S6gP7F+i26WB7H7HX+9PrjZrqSw36C7rG3v8+BCmptYb6YRaaq0J3ntHS0Vuhvsm8YtdIow
	i0BKDeAOM/Q94QMCT5+ODC1z6y0F5vOOLwtigX4gdI6Xwaj5nCN+Oy3pJoAT6zL5tHtKw3A
	kULyFUsvzeQCUjWALPMLk5MrJr0GX3Lp8HqARRH95PSkOL9jaD+BRKVdUBnXQJJ+gpS3t3Z
	tyvK/bBZx3cAVPv9gi+tPiYUhgCuw2shcygis367n6V4m1ss5cPZVFH+zsZlX1Y3+/sLwH4
	uOmfYtUhAOaEqTM5aaFXLA8D4WVnoit/AT9MJEMae9xmzqlcFbQjKBAvWP9DggpzlXUDkJg
	fCZuEuVVCXw+eBUKD/OaLLpbPxLRYTjvdCvx+yZtmw9WUjdKVV1YVHanRJe2VGpoLy9HOsD
	ALCYawz+vk3TP3LJjwLnIAilg5UBWKwjy5qHkEQ3Fnz+RKWUgKwXNdYP/xy71rd+n+FYTsK
	jGt4swBPheFg3KLFNKsSBA7nr8pZ+ky+1mpOB70EkHBnADOSIdPef7hyj/dXhRArMAfzxPz
	x7BQAVsqwzMoBkSqiVMYhfVjkDUYqFtMxc7cE/aQN1SWKJEKsX+TSdfifP+xDHkcYz6XVIL
	5SGDQHUg6Zd8shZ6GkZwN7g8BbxtKPZYsmRmDJLilZ56JRp9C0+5gTo/W/xiXxiisB+TN+n
	ubajfYxCF9wQ9X2dfy5qD3Ksfoq1FKRmWEHh7YUuTbVPguwwJ3JJadDcgTsF6ZwsrC9a7id
	Z1jP5Riv3RxiJjzKUKqSwk9egYBn8mvQqpjykzfSs4czeWGemgadeTEX3I9RsmRpsOdqNjG
	wso9OTp9LEs8lkIo1Bx4En+ktYKOfi1MMj/8MeqG18yLvBCpG1umLFP3QhH5ZyL2W4sJrzZ
	Mft9gMl0pJ2bK11QfMDaA9TClU1z8sFdjT1Z8VaiqPOEGVgH+6veLsyh13uJAdYmKP/JyWD
	+rSC
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Hi Greg,

> Backport "selinux: require a class's permission values to cover its"
> more cleanly, base on Sasha`s backport for 6.6 before to point out for 6.12.

For 6.6.y branch backport,
I prefer use Sasha backport 9 commits for 6.6.y instead of change
them is well enough.

Link: https://lore.kernel.org/stable/20260825112440.3543785-1-sashal@kernel.org/

BRs
Wentao Guan
