Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896431;
	b=UvymDND/L/O0QupjDxXwigXVnbwUu7Yf166t7P2jssAr8OUWC1L9ztGNR+ZUJPw5hZgy
	 5w4hY0XIgGZ+lEA/NACXWKh5/z+lCo9RnODgoUKNRvFh71Aka6VJDA5KJHtiL6fLF2aOr
	 U0RqvB+eCOSUtDWy7HI+CRDwDDQIK/ktV5O/JFcPAYVKHkRovrTIoIjDAZWcnzA9Ljr3W
	 HWQ1m0X3rWZe61up9bP7fmlnrHoR/+Zk/XsJLzn7cU00DSC4LG/Rt4aaVaCMnWja7+4id
	 LHQdJggxJhHVvy54r667wnmIoxE7It3ozYHKvj3DWNQhP92p/Ne25s0Gjrm0uy7VHlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896431;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=/AyZwE0z8xzNTzh3g28ee5O0JSeolxvnrecjyY62ztA=;
	b=eO7k9IizPKhBSvOQmdbZRmbvloMHvHkiirVTcW8qcJTz5RhMv0kmqQHvLaLb9WJF+DFf
	 Gt/CENt71XeYI0+UDY/wgSA9ZK7ACxq4SHzom1iHY6P9xK2JBpQnXJIb9JqazP2FWyVEQ
	 4abprRRthg+FbMOL/DkMjW14zxs1PlT7NZkrbU1chmuiQZiJKvjwRnvY/lXpOCY7FS5d9
	 9dNjOPtaxN+tmSZz6y4EpYW8ytkX8/87tenTpOW/ihfOXkOpsMGq8zX9y/LRB3meVnTV8
	 0kL3+/jKT4ycZU3bRR1bBv4TeylPag74e23mvFXHDejyvFFf3CnlxPFs8Yk4BZKqRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=sDwBkkOe;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23666606A31C;
	Tue, 17 Nov 2026 06:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23666606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=sDwBkkOe
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AH6K6sF44178464, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794896406; bh=/AyZwE0z8xzNTzh3g28ee5O0JSeolxvnrecjyY62ztA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sDwBkkOeDqvjkF6h8i/HSEwcV7lVUHMir7fOodeWUWvH7WB3aoDopj+QvgFEOIyiM
	 luGdcMRsZgvcfAh/PTw/mTu6EZVVuRMX34ae2nKN2dA/xMVZhuaRu66ckG9EuH3Bof
	 U9nPP/n0rPxE+T84R4VRbz9mmTMDUpuaEbHkXS/iZ95ENKCHaABPnD/LfXpfd1Qm0w
	 WVjwU4oEm8yxqUBExXMILt9nsV7C9AFhH0rBDV0DyawojEHMtroD1zRYSgOQ46f1xH
	 WK4ic21MHgtgsOnhhnFrUXk8g5eIhR7C8hpaKmMAxytrGgP/Uemn5hlZQnGU/gk1SF
	 v2AgSbe+bRDxA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AH6K6sF44178464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 14:20:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 14:20:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 14:20:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Tue, 17 Nov 2026 14:20:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v10 3/4] wifi: rtw88: sdio: Fix unhandled RX
 request interrupt storm
Thread-Topic: [PATCH rtw-next v10 3/4] wifi: rtw88: sdio: Fix unhandled RX
 request interrupt storm
Thread-Index: AQHdc0hVp2N6+ZRlk0SKJddwWOckkrcx0KLA
Date: Tue, 17 Nov 2026 06:20:05 +0000
Message-ID: <2e70b353e2584643a278100a5d64b6ae@realtek.com>
References: <20261113082242.2773369-1-alastair@d-silva.org>
 <20261113082242.2773369-4-alastair@d-silva.org>
In-Reply-To: <20261113082242.2773369-4-alastair@d-silva.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Alastair D'Silva <alastair@d-silva.org> wrote:
> On 3081-based SDIO chips (observed on RTL8821CS; RTL8822BS and RTL8822CS
> are inferred to be affected as they share the 3081 architecture), clearin=
g
> REG_SDIO_HISR_RX_REQUEST requires both a software W1C acknowledge and an
> empty RX FIFO. Masking this bit out before writing back to HISR prevents
> the software acknowledge from happening, leaving the bit asserted even
> after the FIFO is drained and causing an infinite interrupt storm loop
> that locks up the system.
>=20
> 8051-based chips instead clear this bit in hardware once the RX buffer is
> empty without a W1C writeback, and software must not clear it.
>=20
> Split rtw_sdio_handle_interrupt() into separate 8051 and 3081 handlers.
> For 3081, disable interrupts via HIMR, acknowledge all pending status
> bits via W1C writeback (preserving the existing full status word
> writeback used on non-RTL8723BS chips, now including
> REG_SDIO_HISR_RX_REQUEST), service pending events, and re-enable
> interrupts under irq_lock if still running.
>=20
> If unread packets remain in the FIFO when interrupts are re-enabled (or
> if new packets arrived), REG_SDIO_HISR_RX_REQUEST remains asserted and
> re-triggers the IRQ line. For 8051 chips, preserve the existing behavior.
>=20
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

Remove this tag across patchset.=20

> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



