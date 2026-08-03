Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F939FCB1
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790024; cv=none; b=NvGPI8XE8Pp4Vf9LfNlNHNnkcMWsMTt/uPHm0PrFNZPEuX3MdsHRGVlwgx1E8q+zyF02DTw3R/MG7+Hqz6FgCNZrNHiOnhU/nv4x63pZlgv1mKYAOyW9HcsPhqO8M6JujVWkTseUyW1No7wo6PGJwZ/RQ65mYymV9/8a1zbrxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790024; c=relaxed/simple;
	bh=SB4P9w0n02qbNXVWW3nL17eHzOUQeIVWPePyFtNZvMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HESB0/RQN72CZJ/Ra5LVX0Ba4BLycXj61gfbkZZgUBup1xnd/f3nvpzQSIgWQ2UqgdXHq7+1ZK2HscwqXZf4Ve56/tqsdwxXNfzGdlxd2728z6m+K721ITMG1kH1udFC9YZRd44q3GzbKD7uyaZENwEr3gMscueiuPAC0aEL0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddjGDy0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddjGDy0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B881F000E9;
	Mon,  3 Aug 2026 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790022;
	bh=EarqwElUHrNhh6WiCnRJ74QlcnhMj9s6N5VxQeRrG28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ddjGDy0/ObYZpYE9Nh31/SKryYET26I/X7+KZhWQUfSzRcynsSe2hGe3KhKEOwB6g
	 J71iE4WMGPdhV/DU7oEGtzdDuInDxxV9luMvPlulGsM+x3DlzxyEgQtDpFSwlDxgSX
	 K03RZndPUUjT2n6NJ5BbopbxCW054coYot9TFCILWOFizuJTAFR3ik3No9KM0rsCcE
	 uFDa8A/q3kuviCXL84Ozw09uZS08inpoYfIUteXnLMnHSZyRIin1FBxHF8uQUVGuq9
	 vrR7xdE2fa+KBhLUD753knoG+0uF9qHY0Ahyb5R1I7FvZ3BpOXBI3+awru7KUbuM+M
	 QxSt/xXgGJ/JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 6.1.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Mon,  3 Aug 2026 16:46:52 -0400
Message-ID: <20260803203500.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802201825.3816958-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260802201825.3816958-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 02, 2026 at 10:18:25PM +0200, Youssef Samir wrote:
> Fix this issue by limiting the maximum number of server registrations to
> 256 per node. If the NEW_SERVER message is received for an old port, then
> don't restrict it as it will get replaced. While at it, also rate limit
> the error messages in the failure path of qrtr_ns_worker().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
