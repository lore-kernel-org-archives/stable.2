Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608813;
	b=frIabWSHg809NnFW9xtB4nmGP8dwf950tRgDJcbYBLri3ecmtQO7QZEf6rmu/wBzNN8P
	 xLmtLO+IkSXBrDdiMiDaWRIMCWK9ix7ww91ig+LFMnwTi0xoakdQR43sz8bJm8inmVtKs
	 g3cV1t+1ten1QNLBXDJUBb8Gr28Mf++rw7iTG/V5qKZbh2S/tFjz0d5A6Rr++w9irgeKG
	 YIOjDZz1ENruE4Jh4IkznXLMxMYtTbpaaRCpU/azCZAnt9S/+M9Dze4D26vYnNH4PPxD1
	 A5i9awenIG3zbUbkSwgtKVaCX+4gxuzi1IUrvacFE6sSKVQQvEgidf8hnrhVQozHebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608813;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Received:DKIM-Signature;
	bh=3oaoMw5fIc0MMZ1IvijkvhqcCiuTTyPoYGfE2YDn1Vo=;
	b=n699q5XKr1bgMhe7+z07XMAJKmvujDSW0vE3Wr0k/4JInEuaBWCUsF1w16CiHmzFcg14
	 Dw15upcxW0Uv7ARHG/h+Ny5vmqUVr7FHYMH3D9u/lY4w1qaiZNqikL/sF6k35k1oadpae
	 HgKrwTACylTuwupEWsptJsnXGl+Yg6rUD0f2XSBloW4pek6uLw9txHfpGAzzIrpRIavXK
	 azM4lfO5h5AnykL0Q5GeOCtlne3zKMe229ZcJpjyLEpre1Joh7SeKK8p4e/IgllIefUE6
	 uMhqDSuPW5lv7KCRYijNp0+PkwrqnSgn8/tB7vbvXtYRhdVs1Rxx00H9M1Yv0kyGQZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=chJ5mtUo;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E66606A321;
	Wed, 25 Nov 2026 12:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E66606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=chJ5mtUo
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev-bot+sinfo@kernel.org
Cc: Federico Musto <federico@rimpianto.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: atl1c: cancel the common_task work in atl1c_remove()
Date: Wed, 25 Nov 2026 13:13:29 +0100
Message-ID: <20261125121329.2679-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179560665678.3294.8918626244463796277@kernel.org>
References: <20261125113141.99792-1-federico@rimpianto.com> <179560665678.3294.8918626244463796277@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id D5B41CC6-B9DE-492F-86C8-DDA6380A56B9.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 13:13:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1795608810;
 bh=3oaoMw5fIc0MMZ1IvijkvhqcCiuTTyPoYGfE2YDn1Vo=;
 b=chJ5mtUolO2Of2svThnz21D+bsNi/Opf9DXtzL20GQvPs/4vC/Bk8sIytq1QN0XqUaid3g1D1
 YYzfzyvlcYiPEvZ5MKSu6G+zDBvFTnkMdHBwDgrNAjAGKn3sruRVz20oj2Sej7nFPg6aLn5Pb0E
 Lh1v/ZjIHMzcKsTQMs95w+GRW2uuq4DjokOo+uN1t01DtgclwJT/KH56OiH9HVImipKpUntLsqa
 UF0Jp0xuAS8hcMmlTeF9qqlFLsEzukJRTePk082AOdkCHIs6tYgKY5IZbISnq+z4+uLPMn+mrrS
 2nalSE9/p1IYe5oWP9naAn+4/7665j4KMxiogC906PVA==

The change was not tested on real hardware.  The use-after-free window
- a link-change interrupt re-queueing common_task between the
cancel_work_sync() in atl1c_close() and free_irq() - was found by code
inspection and has not been reproduced.

It was build-tested on x86_64 against netdev/net with W=1 and sparse,
with no new warnings.

For context, the hardware I have for this driver is a MikroTik
CCR2004-1G-2XS-PCIe, whose SoC exposes emulated AR8151 v2.0 functions
[1969:1083] rather than a discrete Atheros controller.  The related
two-patch series posted alongside this patch was runtime-tested there
through a DKMS port with diagnostic counters (27 link-down events,
~4.3 GiB of traffic, the link recovered every time), but that build
does not include this change, and the remove/unbind path was not
exercised on the card.
