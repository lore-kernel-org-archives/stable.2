Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA747225A38
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565815; cv=none; b=LLzj8oxs7XAn22UJHfJY/5VmqSPP1zeLgv80ApvpcVIBFZtSn3Eiu/pyqY96svxJL0k214m+7WeDIWBk23Uqo01R7Wtpx5SDskXZW/eP8eNqkJOiCzPPE9t0EOU+OJn8S8h9F8kH+JmpTeFxyatbcXUcFRXZ/29OMNpDtoNR2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565815; c=relaxed/simple;
	bh=8+amCrpiLuknYx/6Bq/4Txe9EFIPEW+a9Y8wM9E9q7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1cyucYJJQ95+gSj7vkqOR2PhJkSSjPL95Uzv+Noyx1wQyctKV1Bm42xI762DHGxRuMW0lS5g5izUPqjE9TxkvRE46IjLz6bEHZ2Lpv+++/dImw7Dfy8QqeQu04stBfwLTKsEeZRYf8Jb7M6C5KgP5P742d8+QAHjKqtK78Ox6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDxDbVOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDxDbVOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947E61F00893;
	Fri,  9 Oct 2026 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565814;
	bh=1WBbv2P6zy+ufcReiaDpNP/Vgm1QSvVBNyB9e1JIc3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PDxDbVOZ3bvkMklfI31ijmQaZsI7JIiR2B/qbQ5gG7untont6O5ZrY32shHHW0bWg
	 unzpYpqTTxGgO9VsGhCbI+1kwQM9PXXkHtNqnUiXDkBoRelH0UxPmt4+cjnPg7ZBQO
	 Tmnw1Z/a9Afe8iQil9OFt3a8VWmMyUul9TWPCIhguwIZrk+qqv578WAi245Al6JQYK
	 cRyL3VjAw7aR0FUJ3UnbiAeddpPNVy9n/fub9dT11Z/V1j6YPboQzxdSNkuSM8P61Y
	 0s/gORTys7jEksIJ/uThHwve3tFfWJayuGkS9Q7kz5roVVSjYEgXYi2545LwWuDPSS
	 Qm1/3P0UXYG3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 5.15.y 1/2] tty: introduce and use tty_port_tty_vhangup() helper
Date: Fri,  9 Oct 2026 13:09:41 -0400
Message-ID: <2026-10-09-1-daily-reply-0004-tty-vhangup-helper-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008141649.1183309-1-ue081723@gmail.com>
References: <20261008141649.1183309-1-ue081723@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Introduce a helper similar to tty_port_tty_hangup() (asynchronous) to
> handle even vhangup (synchronous).

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
