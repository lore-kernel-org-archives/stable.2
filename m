Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792923872;
	b=A//qzplDg0PoV8Ai+V+J0LXu06VMrrtj0cFpMHUHZLJYSiSzCberTFYHnwrimwoLBKXm
	 ud/4PhY47WoeH3VwJIjZ7LNj2rtLqoaEpyB2d+r7fewJS4mfJgX/92IFebC6qH/BCv1xi
	 NUZCtyKOCTfjn3nfGc4uevs9LunFy3KanIxCoD472CmAk/CdIOwb188YEVVMPqNZLOC9L
	 YGTfoKhnUBaERVdTN8MnEAntzr7svwsjSZW42AlfXWHEqyOx7aNbiTqaWQ1TNEtTgLW0G
	 aFKxEx2nPKeKSFQeqY3BkAp9+STqpaLW5GHl47X64d5Y/cEFkP1kjepSlArvFyxM6Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923872;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HOQH/UzmoIGTnx1h57ThuzE++YZYHn+wnPmoRVPN7rQ=;
	b=0hAjh51pNpgx0schy5c8wXTD461ZSPKh/59fJdZuGh5N/snDdLXWXbYS4OHbv95sG1I/
	 Lu1GhNzEEo05rT560r2jAcqp92zpADLc65EMM2c+QZ2OAB2jzek5OvzJqqt/BqC2T/lkb
	 Y3dEuL7ZDlSxjj81cgf6wOenH6BMJLi8ophGW24jFEmK6wU+17JIs13zDhTRtlGLw1zGC
	 i+zzcjW+ONXlExc2LpK0olo+yyjMa/DHIlDy/oqVWkpDivxEizEWQd5+vNep06rZ62qx/
	 E3SCOVW4DXhxMCNz6a2b7rR5ZEOz1QxXLbHappYCGJ4bTiVN6/nZHC3UifDMmFD1krA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.com;
	spf=pass smtp.mailfrom=yandex.com;
	dkim=pass header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=egosjMlG;
	arc=none smtp.remote-ip=51.250.60.161
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [51.250.60.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E24606A31A;
	Sun, 25 Oct 2026 10:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E24606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=egosjMlG
Received: from mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net)
	by forward101d.mail.yandex.net (postfix) with ESMTPS id EC19EC0031;
	Sun, 25 Oct 2026 13:24:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id GOcbPNXdW8c0-FgVCqyJ5;
	Sun, 25 Oct 2026 13:24:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1792923866; bh=HOQH/UzmoIGTnx1h57ThuzE++YZYHn+wnPmoRVPN7rQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=egosjMlGlkadXOkgB1h4WlCwWAucMXZNqV/3WX9ti+N9PCuyer4YRlqvF61AiGKcZ
	 bS5rPjOrxftr+UNmi+5M/f/ETvrRJRr8p4buyRuvSyjz978AnWNiR2T+fZqIwlsk0W
	 4gHvG70uf/rRir7t6fUJy9k1wTtMzA7oQf51vWkg=
Authentication-Results: mail-nwsmtp-smtp-production-main-63; dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	xnderv@yandex.com
Subject: Re: [PATCH] drm/nouveau/therm: mask the update bit when reading back the fan PWM duty
Date: Sun, 25 Oct 2026 13:24:13 +0300
Message-ID: <20261025102413.51786-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025101640.49779-1-xnderv@yandex.com>
References: <20261025101640.49779-1-xnderv@yandex.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I forgot to add my sign-off to this patch, sorry about that:

Signed-off-by: Alex <xnderv@yandex.com>
