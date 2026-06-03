Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0D3E16BB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504550; cv=none; b=saa5FxoMZqAaB69c1ynbGwmqP8qMgW8zVy9CvFPGXLZqrdcD3xoGu4pX00M/wVw/0Iedx4j2p3M2Tl1/OKJgSN2zPT4dW1QMHd59PYzxVBMJOVYiRXBXB/ToNasrvQBMSTqnk49oT3eaLdH51M8lzndB84van0vq7WQ1VaYTN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504550; c=relaxed/simple;
	bh=qU8KjorMFSCGfaBYoqMdn7y1itPV8ycA5Ml2oxKrIgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKEepnjol45lBn/Ry6uXOlwkRRmP23EgN5DsZK+5/lmOWoyI9AAurh9tRrwd2UhNsKcmjuE7UOclYZ3nILGNZDrB4DZYeISBHrEy5/QBZefKM1RbI6nSc0wHyrGD2pPQClKN6s60TswWDx5h++P+W9Rl7HaLr5lkPDzPCmA2Hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pTSkEWWz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pTSkEWWz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E30151A011C;
	Wed,  3 Jun 2026 16:35:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A75F65FA0F;
	Wed,  3 Jun 2026 16:35:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 214D110888CCD;
	Wed,  3 Jun 2026 18:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780504545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qU8KjorMFSCGfaBYoqMdn7y1itPV8ycA5Ml2oxKrIgM=;
	b=pTSkEWWzfyLOuLrHtm97ZF7/TeK/p7taRdgGhaKvoO1zf6872KsfitNyeAFsIrXJtJ4rV4
	U6gXeUM2+2FHFw2bdwYln9ZH/XKLvLlScIlv56+mefGoda95Uyz/TcOcU5RFD88KYqfekq
	1uCHhp2UQEkdIcbbyLXyVL7N/gkhM7zG8kUg2wPKDRY/xdGak2IUBVa4aSj0A1c8vSzRnU
	B8tQzadHLNsZrz4iKLZ4ZBUyloGCCBtN8v40CiNEVVbdhhgMiyxpJP/J8m646QzO4I1lHk
	twGw990PkXXyqsuKnP74dtgfK49ryzL2WHIaxk5jnu0EjQ1ba2jL9eN4UCKR8g==
Date: Wed, 3 Jun 2026 18:35:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chris
 Wilson <chris@chris-wilson.co.uk>, Eric Anholt <eric@anholt.net>, Dave
 Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Mark Yacoub <markyacoub@google.com>, Sean Paul
 <seanpaul@google.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/i915: Fix double cleanup in error paths
Message-ID: <20260603183538.656b6444@kmaincent-XPS-13-7390>
In-Reply-To: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
References: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 03 Jun 2026 10:59:51 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Several error paths in the i915 driver incorrectly invoke cleanup
> functions multiple times, potentially causing double-free errors.
> This series corrects these paths to ensure cleanup is performed
> only once.
>=20
> Testing note: Only the DisplayPort fix has been hardware tested due
> to lack of available hardware for the other components.

Don't pay attention to this series.
I missed the point that if drm_encoder/connector_cleanup() are called it wi=
ll
remove the encoder/connector from the DRM core list, therefore the destroy
callback will be never called. Which means no double cleanup path.
Sorry for the noise.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
