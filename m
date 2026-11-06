Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.190.148.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944637;
	b=P3SZg1PV2BtMp8Wp3hb7VWBYZQ/PJ8BA6k9vLHxAk8DnLuB9CgZWb52ouAvWG+Eyn/pd
	 wsWs7XBAwSvmrCZNqbdXnW+U7SRksjts42hCLjij4r6fHTRKTuznCL/IrX+pS/lML+NNn
	 UToetmZUv2UDNjeqjb60s9UKq+eXXGEGj+Txra/xzw1uIe9S988YBjbaEvRPoFIbxxXbD
	 5CGUvrW5lPbDfFQWZng51cps6ghGtLtTbVmhN1gwZTiBlsYgZQB5mYLG0dXZXnCjBZ3yM
	 Orq7M8sfYCvin8eG09V4S0lvTcWwqQtWyRbAslJ7NWf82d4V1vXkHZw3d6O/ew3T17w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944637;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=V5Lnobb+4I39QfB84s55NYKIPzzSfTvTzIQ5ko8LurA=;
	b=I9yR+5OS8ZO4LOP9FG8El6iG9nnpIV8jt1kIM6TGnckl0TmV0FTVuNaQ5gSbhtQsejWB
	 dq06aH841dQyTTluKfBfD+1UvVsv6b+psob1otDHXCFrVMGIHptaPGMWeRJO5KKpcynf1
	 O9ikqSTxvsp/lPhmrS0UiKblflP15fiP6zV2mdVTZlf82V8G2gp8pLYHtWfnKkcVNoihU
	 ie24IgjGEL0rV/nSqQQtPVhmtTdLXaFw2nXJJ6KsuvvFPUDcx3ILwrsmkbV5Oz7QdnQC8
	 NTAMLLbggt0YTVSEmf0Ejdn2pLOqu4xhMIdkZYeCA5Jg29aczyAfBLnL0eTuBae6iDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=foundata.com;
	spf=pass smtp.mailfrom=foundata.com;
	arc=none smtp.remote-ip=195.190.148.227
Received: from hera.efm.de (hera.efm.de [195.190.148.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0286606A328;
	Fri,  6 Nov 2026 05:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0286606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foundata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundata.com
Received: from hera.efm.de (localhost [IPv6:::1])
	by hera.efm.de (Postfix) with ESMTPS id 4BCA140C3D59A;
	Fri,  6 Nov 2026 06:57:15 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by hera.efm.de (Postfix) with ESMTP id 30EC6413304F4;
	Fri,  6 Nov 2026 06:57:15 +0100 (CET)
Received: from hera.efm.de ([IPv6:::1])
 by localhost (hera.efm.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id sFwEJI33bHUb; Fri,  6 Nov 2026 06:57:15 +0100 (CET)
Received: from tpx13-pf5nr32.fritz.box (ip-037-209-109-094.um11.pools.vodafone-ip.de [37.209.109.94])
	(Authenticated sender: ah@foundata.com)
	by hera.efm.de (Postfix) with ESMTPSA id 899CE40C3D59A;
	Fri,  6 Nov 2026 06:57:14 +0100 (CET)
From: Andreas Haerter <ah@foundata.com>
To: cnfourt@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	leon.yen@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	lucid_duck@justthetip.ca,
	matthias.bgg@gmail.com,
	mingyen.hsieh@mediatek.com,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	stable@vger.kernel.org,
	yu-ching.liu@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7925: fix NULL dereference in CSA worker
Date: Fri,  6 Nov 2026 06:57:09 +0100
Message-ID: <20261106055710.222567-1-ah@foundata.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025140123.12056-1-cnfourt@gmail.com>
References: <20261025140123.12056-1-cnfourt@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 10:01:18PM +0800, Gris Ge wrote:
> Reproduced the panic by injecting CSA-less "abort" beacon, works well
> after patched.

I hit the same oops in normal use, with no injected frames, on a
ThinkPad X13 Gen 6 (MT7925, 14c3:7925) running Fedora's
7.2.14-200.fc44.x86_64, not tainted:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  Workqueue: phy0 mt7925_csa_work [mt7925_common]
  RIP: 0010:mt7925_csa_work+0x83/0x160 [mt7925_common]
  RAX: 0000000000000000 RBX: ffff8eeb5bbb3910 RCX: 0000000000000fa0

The code bytes decode to the dev->new_ctx load followed by the read of
def.chan for mt7925_set_roc(), and RCX holds the duration of 4000.

The access point announced a channel switch just after a roam:

  10:58:02.90  associated with the new BSS on 5180 MHz
  10:58:04.05  CTRL-EVENT-STARTED-CHANNEL-SWITCH freq=3D5180 (80 MHz)
  10:58:04.47  oops

It has happened once. Two earlier channel switches on this machine
completed normally, and the log does not show what tore the context
down.

The impact MAY be worth a line in the changelog. The oops lands between
mt792x_mutex_acquire() and the release, so dev->mt76.mutex stays held
for good. WiFi did not come back, and at shutdown wpa_supplicant,
NetworkManager, avahi-daemon and systemd-resolved all survived SIGKILL.
The machine needed a forced power-off, so the stable tag looks right to
me.

I read the patch against master and v7.2.14. The chanctx hunks apply to
v7.2.14 with an offset and mt7925_csa_work() is identical there. I see
no new lock ordering problem.

I have no reproducer, so I cannot offer a Tested-by.

Thanks,
Andreas

--=20
foundata GmbH
Steinh=C3=A4userstr. 20
76135 Karlsruhe


Web: https://foundata.com
Sitz der Gesellschaft: Karlsruhe
Registergericht: Amtsgericht Mannheim, HRB 714807
Gesch=C3=A4ftsf=C3=BChrung: Andreas Haerter
USt-IdNr.: DE284122682
