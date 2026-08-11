Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805537C90A;
	Tue, 11 Aug 2026 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454086; cv=none; b=Kqjo52Tljx6ktXT093Nn4fsBixLdbcbJg97Rrv9jCxUW3/d9WMl+KI4vdvNW+VpwB7n7Gd04aGEhd66qPULxYdRjznf2x4MD9q2SsbOZgncVoLXDnKpE+Z483DvF+U71qRqFL5pONhPo1VQsG2teF4fB/4N6lRHMPgU3FB6ibDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454086; c=relaxed/simple;
	bh=x0M2ebb4YGCTw57vP6EAz1gS4hevjwIbdS/kTKIzesU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYsE28AbtCibs+EfehIjrA+q+Ut/e/QDKyYEjONG2Voju7SVU2K1Huzibx14TIiDh+i+em7Js6s8ZQveOvuYOls4j+TY0r8qdGsb9I3wH2uSK7b+5ztC5mK3/9duxd1YwTfIxumzmpc7GEIOVwOjmvOYr+ZALFE1MRjlit7QTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TxsyJp6v; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TxsyJp6v"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7A3A71A1570;
	Tue, 11 Aug 2026 13:14:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B0EF6033C;
	Tue, 11 Aug 2026 13:14:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5489911C48B99;
	Tue, 11 Aug 2026 15:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786454075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x0M2ebb4YGCTw57vP6EAz1gS4hevjwIbdS/kTKIzesU=;
	b=TxsyJp6vpip6ZK2Pwk+FYoiRoecSZpKedunO4WsL9GFo+87sJE32da2w779sqlYoYr0bjS
	6lxfY2bzYXm79nN8QqlCtRYzffUmGCtf4sVXbVxykg2ljgL8pN4OPGdXqVwXBhdNvWkosM
	J0UcXIaHvLFEqe8I91e/dIPreK0F6HdlaevWZS/fkMMC5k7cPiBpKEoklcOAPr1VmZutKJ
	awvnFL0l150nFR6mDgmEI/qE+Rz42tfR3IfwIjLyEpz0MmPiP0SV8/prdU9vRz/ssBHo33
	s0Awr6+rYqNQY8ZexMNjIxKKrP2JR0CZ5XZY5Ch2DBLq+lh94QH4VeVKFanVJw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Fan Wu <fanwu01@zju.edu.cn>,  linux-wpan@vger.kernel.org,  Stefan
 Schmidt <stefan@datenfreihafen.org>,  Alexander Aring
 <alex.aring@gmail.com>,  Varka Bhadram <varkab@cdac.in>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ieee802154: cc2520: fix RX tasklet use-after-free
In-Reply-To: <491F951B-3C7A-45AF-8842-C581A2BA6ED4@zju.edu.cn> (Fan Wu's
	message of "Tue, 11 Aug 2026 17:48:26 +0800")
References: <20260811010359.131381-1-fanwu01@zju.edu.cn>
	<20260811010359.131381-3-fanwu01@zju.edu.cn>
	<87ik5hoycq.fsf@bootlin.com>
	<491F951B-3C7A-45AF-8842-C581A2BA6ED4@zju.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 15:14:27 +0200
Message-ID: <87v79gol3g.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/08/2026 at 17:48:26 +08, Fan Wu <12321260@zju.edu.cn> wrote:

> You're right. I failed to trace the receive-enable path, please drop patch
> 2/2. Patch 1/2 is unchanged.
>
> Sorry for the noise, and thanks for catching this.

Please send a v4 with a single patch.

Thanks,
Miqu=C3=A8l
