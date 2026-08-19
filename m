Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63E846A;
	Wed, 19 Aug 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140669; cv=none; b=HuWUKzVRroO18a6A9GcBH8+cGaOCVMyaeAtlqCPGHJQhp2vVfaX1gD18K3UNA7is5DWCxKbPnoDPYR9X+E+gqJGXp8ycyzbq+dwHXtMSLootslrfFW157jWzpy2JkwElIu6nxl9A77WCz5gW56ApuZCWfc0SkBSwK6EmymDVwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140669; c=relaxed/simple;
	bh=r1K6h9j7IK720pkFFbS/gcz/lr2ZBCiz3V9XWNjAkjc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iB0iYa8sWK2uu0M9wR7mH525Othnt6PAD0rNYF+n+98k41SSy+dQ2hHs07YQOnojLd0Xtk7sYMjSlg2RC1Synvr9ufmoHk4bwIodU66tfedKJltvHXyHpq+iomf61/nIwjYdXbjV39xH6N7iR8aXfpHOBSksQfveuUQwZwUA4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EnDkXACi; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EnDkXACi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787140662; x=1787745462; i=markus.elfring@web.de;
	bh=4JUp1TvC29Y0XdBxPcuuofIQeL97+Wmk7E2pqYVVd9c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EnDkXACifA8AeP+vF1D/doNfX2hPqt5EGcVss2KTHJ+/i4gZDgwTTIxqr2UJomFe
	 Txj4xITg1PrFZ2kHV16P3aC9zJaqBB14QEEzXH1U9v7cwuAvpVgf/Z7nsEVPS2Gap
	 i+yRL97q9UWQJ7FGFBOykA8ZRzJ3rsxfP2+4rZmchYA1HKgdF+fr6IkbMHLddJt5C
	 p4mhGWCFqYmXEDsW+Ik/BgBfgP7p10I0RtIQM6H4aNobRb0/iV7yA3RVUoy7Bf5qL
	 pZVhv8ab92kQ4bdF1xzXKkUBUtW4tMZiMlhmOS1pVFqzsKTM0nhg+n5nWIz27zGQq
	 1zLtv5w2IIgz2Wk0LA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYX5-1wlIAp0OAD-00tbht; Wed, 19
 Aug 2026 13:57:42 +0200
Message-ID: <ee366627-a286-46b8-b343-7f88064a25de@web.de>
Date: Wed, 19 Aug 2026 13:57:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Herve Codina <herve.codina@bootlin.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Linus Walleij <linusw@kernel.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260810-ti-sn65dsi83-fixes-v4-3-ae9c95c8d162@geanix.com>
Subject: Re: [PATCH v4 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-3-ae9c95c8d162@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9X8xJNqqSDy5L+/Xi4A1PPG9Mb75bkoa06QyoOFYQDj10XI25UJ
 0G/e6MZD+PK1PcgL1HgkZbSLM7y1Q/9MpRbDhs+yq8XGtZfe4htMllyFVjt1eT5h4LZKhyQ
 iw2J2xcrTA2bp843GZ3Kcpaa71biDYZXhziXHG6UMTlOyeTmY/yk8RHZeZvaXlaeo3i3NdG
 gKxrWyIfkENPERRfWnsoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:82+q6PYEpeI=;5w5SrlpHPtRijm2hbaQr0dPgzxv
 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

> This adds support for =E2=80=A6

  Add support for?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n94

Regards,
Markus
