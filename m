Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA02538D7C;
	Tue,  8 Sep 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870570; cv=none; b=E2eRZdB+Xhqfl5HHY8vjzfAAAm2+enUf60GRa/mqCXINR/h8RLd3h7/3Sokw4+PC0OBXKuzrIpuK0LTnMeimpDQMnj3RgZgA34hEQIRuZUgKi13qkWRCoOEKI9QD8JitiLzg7sz0yuj/Wo5ut+kqdCfbbd+HyZmkgg51RhGy9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870570; c=relaxed/simple;
	bh=5cpwCirlfpQ7b0q0uxJLsDK1aH2U0BUVu/3a4N7TqfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzbUgeJrJUJ+80e1ay3PJTXFX2XZv9gEIufom1b6tHSWb0N04vyUMGT5IEprw3a5NRa1Y9yzCrAyKxV81wCvTd/gbBW0cVcBwPep6t0ewpqkKoJNarIiBdSv+xXvlAfa7sX/XVEMTXLPMK0l9vuyiLmoX+0jT29CSnM/cXQ11DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BUtw6t9N; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BUtw6t9N"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hfNXz7518zKnSD;
	Tue, 08 Sep 2026 14:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788870564; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cpwCirlfpQ7b0q0uxJLsDK1aH2U0BUVu/3a4N7TqfY=;
	b=BUtw6t9NoGUStX4XvZU6VN78mz8+oT46GcgQXDbmFT25x23El62/FA5yMigCdXG2rx4Xza
	ugAb5mMZnT1wFfpfcWvcch5jCysnQb02MYTLf826w/eal3nVZRh89/pD/gdxRF+E70VBZz
	SrsZI4tDkSW+AKAW+r2m5hQLi2U6YGjfAraFazUXXlakP1e3CQpCAKvs9BE0hfzCG9wodC
	akilzea+5+jVKgepf+Zk+gAvle38YIxmyyKsxT1vdAJkuNwM7T+9XmiPp+hXHRHUQaqGNR
	qB+cp8Zm1G+tBA5SBCm6hHtMkFo/9edDY+BtvSrjaHGks5NS6tSbQdmH+zDkXw==
Message-ID: <bf1c4ad1df5bdc93159b65d2acfbeffc4ae5df7b.camel@mailbox.org>
Subject: Re: [PATCH v4] drm/sched: Create a fake device for KUnit tests
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: oushixiong1025@163.com, Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
  Christian =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Shixiong Ou	
 <oushixiong@kylinos.cn>, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 14:29:15 +0200
In-Reply-To: <20260908055941.351486-1-oushixiong1025@163.com>
References: <20260908055941.351486-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 6fee3086efbb3b57d24
X-MBO-RS-META: ory169k3wbdcseghx64t1jxx6bbme9ss

On Tue, 2026-09-08 at 13:59 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The DRM scheduler KUnit tests pass NULL for the dev field in
> drm_sched_init_args, which NULL-pointer dereferences in the drm_sched_job
> trace event via dev_name() on sched->dev.
>=20
> Give the mock scheduler a device with kunit_device_register(), which is
> also cleaned up at test exit. A per-function counter keeps the device
> names unique, since some tests create several mock schedulers.
>=20
> Fixes: 5a99350794fe ("drm/sched: Add scheduler unit testing infrastructur=
e and some basic tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>=20
> ---
> v3->v4:
> =C2=A0 - Initialize the instance counter explicitly

You learn something new every day =E2=80=93 apparently that must not be don=
e,
according to the DRM rules.

My bad.

I reverted it locally and pushed to drm-misc-fixes

Thx Shixiong.

P.
