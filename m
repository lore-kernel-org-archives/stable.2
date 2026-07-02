Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A933F5A0;
	Thu,  2 Jul 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007625; cv=none; b=s5jmULmgankrlHAAq18ZCHA3bzHPVMHmPnjju9VxfY8nPEqcJMGk9yceXtNggGZcg6JAgi5Jsg28sbLg+Lyz3JaXsMlFpAq2kevPyx4Izuhz3lwa8dkkBJeXDHQkObk0QdgefXU2ikiSZpM+oOdC61Jckq2G5sS+hEVtZ8W90tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007625; c=relaxed/simple;
	bh=sZsCyHcjGlTqQP+aZgJp2gt2vvbmYutugQjoHkp4ezg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+uRZm2G5h9s81Sg6wv5j9BzK02k0tVn3Hly/UkIe51WDdYZfoCdjxmUk0jXtpt1gPe5iJpY+7mv8LdJ+XXAvOWc7MsCP/s++I5QCAeggcyDb84kO4RDrdiM+TUhO4ZmiLfuVoOh+NTrZ5sPXGqIGAngmKFuqY4kA+KHi5W1dIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1C854200EDF;
	Thu, 02 Jul 2026 17:53:42 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wfJjS-005lg9-06;
	Thu, 02 Jul 2026 17:53:42 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wfJjR-00000000Fef-3yvf;
	Thu, 02 Jul 2026 17:53:41 +0200
Message-ID: <935ee4d2d6ba388c37337dc569cb118236ae8af5.camel@pengutronix.de>
Subject: Re: [PATCH] reset: sunxi: fix memory region leak on ioremap failure
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Zhao Dongdong <winter91@foxmail.com>, wens@kernel.org, 
	jernej.skrabec@gmail.com
Cc: linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Zhao Dongdong
	 <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
Date: Thu, 02 Jul 2026 17:53:41 +0200
In-Reply-To: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
References: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-06-17 at 11:16 +0800, Zhao Dongdong wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>=20
> In sunxi_reset_init(), when ioremap() fails, the memory region obtained
> via request_mem_region() is not released, leading to a resource leak.
>=20
> Add an err_mem_region label to properly release the memory region before
> freeing the data structure.
[...]

Applied to reset/fixes, thanks!

[1/1] reset: sunxi: fix memory region leak on ioremap failure
      https://git.kernel.org/pub/scm/linux/kernel/git/pza/linux.git/commit/=
?id=3D1a8c89f8c112

regards
Philipp
