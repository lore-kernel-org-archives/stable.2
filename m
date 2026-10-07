Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF0289E13
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407030; cv=none; b=ONJFbd3IR7A6bXqLT9D/RYHAlbTBnO2N8bQuwZBbI2q/A30R8ai5W5V0RQ8tOEPtWM0VpnE+YvETt/1RIDRLdeyyyQWGii8DkDH7vxil66WcDIE12zYIvmAd5EzhcwQK6Hrieb5yNW789cjszY2ApKc7//zW7FuzgUmBPMnHz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407030; c=relaxed/simple;
	bh=DCeNZ7M/6KdNggShZZ0yooPrlBG60KVyQYwZtcrGMOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xoqbtfgsr03pulCv8q2lKWxBCFdO5aMTYObFEHTTN8f8xDeAelcGu+k6u4qhG5Kl2IKZlR0cfWjckQ7nb/1st5pHM35RpTd/Y87k5nXkGE6W4gAX64E41WJt0WPcma+ts2P9otzO132iw74YoMlGZ19mxNFy7uzpJ/pAmIc/ZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5J7DOgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5J7DOgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7DA1F00893;
	Wed,  7 Oct 2026 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407029;
	bh=/bGE/7X7RpLAQBKgW2IlQQbB9iYy/BsmyGUI81NsRwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5J7DOgRFzBGr1cw/lztlsJBG/M78RCvm6FhccwlGw9kAHtuffCNisinGFT3xNHvO
	 MjWfnLuixuZ+0m1WgV4VbHb+4dHKDjP1aTXW3ACrZ9zw0gOsfJVtxTmSlfPngX69gu
	 etbQwxHYEXV4KNZq7sUNClSzHW726ToVMTTMqmf/fMymMBmLWMcin5lNjP0dAU4hcd
	 8N6SZsx/+W1+8CEWdGjeaQ6nopMQXG7r2yPTgkdqUsE22UEuf+SE5FCaoJ94J2hy7/
	 DObhwFW5h+yTphFqZVH9NK+LP880xP3qG4qW2nHhNtByxcwGjweK9CbPZxnlyzre/+
	 qdkojQwEFkOMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH v2 5.10] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Wed,  7 Oct 2026 17:03:20 -0400
Message-ID: <2026-10-07-1-daily-reply-0003-smb-setuid-clear-v2-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006161421.1948193-1-doebel@amazon.de>
References: <20261006161421.1948193-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a file has the setuid or setgid bit set and is written to, the VFS
> strips those bits and issues a setattr with ATTR_KILL_SUID/ATTR_KILL_SGID

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
