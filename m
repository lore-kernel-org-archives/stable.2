Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03613D53C
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414208; cv=none; b=M8GMwZ+OD/90PoNG1nD5opSp9v9ulEG6TZkQ0mq4/+dMtf5qqFOgkfq9A7uFSTc8YzoCiuKDCkUylkMwuo2iYuero/ItQwD+dzQU45s/yXyDbUzUUKIOi9qELN0LPAnqsISSHzUZ5tO7Bt5Zaz29O4X1Q82R0vojNpIpxZmAZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414208; c=relaxed/simple;
	bh=CO8oEXD8tkIbbZxe4z/VTaoK/QQdg+cetjFfOW+4wXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwgBr6N9JbPM7dhhin8N/QUPO4Z8MjrQnw2g5Io4P3xtcRtUP6xUE20s9gT3bOUJl7hbNGuJ0/XHd6X8JKnjaGaMMGzNXQSzuJjveff3xBMPIJAg2DwJL9Nrnto1/dnMA5/d6hOB6Cip6OQFhY1mr5CSZ2eYEG4OQwAEN54u4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0t3Q+Yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0t3Q+Yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F051F00A3A;
	Tue,  7 Jul 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414207;
	bh=W7rlmgxvpU5nTSWPk+s9LZYDcS442514AECvbyJRSe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0t3Q+YjzVg9LMkLPmTjcttl4hjwuKFQHpGDzXSENRV6f8xc8sFk5LWnNKDxyrv3N
	 5CP6tX+4tahDTx0Tft6bGc/f8MRG31KXwBj3dQgIEbC5BQ+x9zix1/6l4HtR7Uf2a/
	 CMPN4GsT6vnMTayT3VDae+Etyo3faYxQzQVtfnJufkKNoGAaE3kkt95Tcd8GyeTQ58
	 SMJ8LHUTpjAFzoCRwndD1ejfMUEDCuZvia8BgDiECQ7jRMa2xpc94yhFJb1rmsJdPD
	 SN0pjgwPA+wCGgp4vxa7+fjYp8mQcOVnTJspQNJuo84xwW3re0S78+fkYh9OEEkHYz
	 9mPizRxycQRKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	chenyichong <chenyichong@uniontech.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 6.12.y] mm/vmalloc: take vmap_purge_lock in shrinker
Date: Tue,  7 Jul 2026 04:50:02 -0400
Message-ID: <20260707044731.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <10194326.ag9G3TJQzC@diego>
References: <20260508191051.1831166-1-sashal@kernel.org> <10194326.ag9G3TJQzC@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> it seems this fell through the cracks?
> 
> Because I don't see an applied message and couldn't find it in a 6.12
> release up to now as well.
> 
> Would be nice to have in 6.12 though :-)

It did indeed, sorry about that. Queued for 6.12, thanks for the ping.

-- 
Thanks,
Sasha
