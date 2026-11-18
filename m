Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020855;
	b=XCiRffsQrlH9IJ0PQneGjcjctz2rj9iZ94UOg8x7gDeFXVHFgn0qXD30Q1H++kvyLuFJ
	 KpP2STpq1coy99dAMX5vbhPQRB7Eq3jgqTnTw5Zto8l38UfmFJTgoyjrOhjpy1giVYyad
	 nGvZpuZU4AWIYnowPM7LERAa+N/SRrX3BZZJ9b18K4sYKieuMPtaHCs43+Ja+HavDUIW0
	 iRsyu4bS6VZYtBUXv4KWR9tM+OxKUfDWMi1h1/fUnFaAul6V7ph/hSNnXN4Mn6pGxnY1b
	 ks9aQDNRN9+2QVLV4UfMOhySez46l43omNErA/pGbLg3PuhQyE7Zxto1JTK7Smy8tGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020855;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yD1/OR6ajdIF7WPOaJ7OQK9lcxiyH/vK4kcEYe1fozU=;
	b=UDYSAH7ztyfXWD5PgFFJHIa2v3DdDC/HIXw94RxBajLth67fYYq/VDk8ohfiX3ttHis/
	 A88LlTtnGGGsLkr4qwXaAFzy89FaoMibncpubEaGgvn5iR1VaJI17+2CAhEq7UJbqZvK0
	 /E3W1q5sREOMEjBGFEjnAyGluCqu6fXhyqmdrzSw1wqVrz3C5gUykjB0XkNE5R2KdB4tY
	 CV51TTlOauwcztoQZoDzcTwAY7KvV6SF1WRqfdaoOAvJ/qIfqPOeJDc3L8SWYdVjL+YZh
	 h/aoWAt/Kj0QEsEsxNQbeXX8sJRtv7OXdK0tvcBAQ+6CBurCp8E0+PjoKBOrjxoNrfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.com;
	spf=pass smtp.mailfrom=yandex.com;
	dkim=pass header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=BadVSQLR;
	arc=none smtp.remote-ip=51.250.60.162
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F49606B587;
	Wed, 18 Nov 2026 16:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F49606B587
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=BadVSQLR
Received: from mail-nwsmtp-smtp-production-main-94 (mail-nwsmtp-smtp-production-main-94.yp-c.yandex.net)
	by forward102d.mail.yandex.net (postfix) with ESMTPS id C9819C00C6;
	Wed, 18 Nov 2026 19:54:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94 with ESMTPSA id 6sdtri0d1Ko0-vPZdlYXj;
	Wed, 18 Nov 2026 19:54:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1795020851; bh=yD1/OR6ajdIF7WPOaJ7OQK9lcxiyH/vK4kcEYe1fozU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=BadVSQLR+kBn5498Kt1JFpF1P9/hCWn312ACxj1yA1JxmYjRVTBPBOe9cuZqQAuHy
	 yHX048ViUFKo72m+HcxA+EUoyExYlmEyhScZc0Naj5D0ZQEy85Ty85BpJEI/yWIv0s
	 oVrViHJ0AEgbHEpoEbQ5FpENkKkaLvc/6KAAeiBI=
Authentication-Results: mail-nwsmtp-smtp-production-main-94; dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Martin Roukala <martin.roukala@mupuf.org>,
	stable@vger.kernel.org,
	xnderv@yandex.com
Subject: Re: [PATCH v2] drm/nouveau/therm: mask the update bit when reading back the fan PWM duty
Date: Wed, 18 Nov 2026 19:54:02 +0300
Message-ID: <20261118165402.53610-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029130012.21738-1-xnderv@yandex.com>
References: <20261029130012.21738-1-xnderv@yandex.com>
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

Hi,

Gentle ping on this one. v2 trims the commit message as Martin asked
and carries his Acked-by. It still applies cleanly to current mainline
(checked today, 2026-11-18).

Thanks,
Alex
