Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8594052D4;
	Fri,  4 Sep 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505380; cv=none; b=HwS+vLgFQz3jLWsSmpd1U+/GyL5KnLFnzqiDwAxuPLi9cKvBEnPLsnqHJJuk7I9GZxkYhgihS5lPhNV2SRTawQeR/g1j5buDsI7qewkfPefgRpKgO0m5d0LVndaZLMyGQ3t8WS5lOMMsrASR+D7G7aKZcqiXUsNkTM0ibpVTXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505380; c=relaxed/simple;
	bh=LDWBVc1y+1fryeW3GilPMmIhntjcCvC5Zt4gLC2u4w4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rKzbnGGAFOSfZ6JS9gL4GmWyIKonJHYCU6ROFAXcwebux1pmKljQVzTzWn1aGP3OBUH55ogZY0QLMqY6mw1yeBrze9U2lHf/K4R+z7TZqd7k85jNOkkhAGEdyY1XjVdeGEfEOGlUoMFJCLBOOI9J52dMCG1CPpsLAWXKI5OklLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BiEbd8l9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BiEbd8l9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbnV64XTpz8tYt;
	Fri, 04 Sep 2026 09:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788505374; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkTXhSUxZlPterV5lsTm8TrVGWaiq1FzBIugDqMjlws=;
	b=BiEbd8l92lFlcr7LOcHlM8gA643/Vc9+1R88BCQ7NzVLApWfJAPWQCSWRvFFy281WlhDw0
	PezwhO4w2JR7tNEQQH7wLJ0xpNY13YGV850R808XXB6pO40xbojMW1Jh0ww70CgKNGs8lh
	vppiq1JZ+oEiD1LcYM53MrdvvtqC44Pn7ihn+GGfL4EtqliQOErxqEXF1uNwiWVwKF0B/F
	WjEPHaFa0wQcZSKfF4PtK60sCOedyJUXgI7yYCs41ZSnXP/gqvEGIQYK36fPK8MqTy9YnF
	avdvHuMEJGM2V3bz6DXJopyh4JfC1x/4kFC+6+DNIkJs4M6qUk0kttMe+oU18g==
Message-ID: <fcecfac828dc3f338d59125d6f0306534e1e2429.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Create a fake device for KUnit tests
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
Date: Fri, 04 Sep 2026 09:02:47 +0200
In-Reply-To: <20260903121558.782854-1-oushixiong1025@163.com>
References: <20260903121558.782854-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 4djizz5oszf5r9qr1y37yya6k5mi3tz1
X-MBO-RS-ID: 75dbe8cd375fafa4137

On Thu, 2026-09-03 at 20:15 +0800, oushixiong1025@163.com wrote:
>=20

[=E2=80=A6]

> +
> =C2=A0#include "sched_tests.h"
> =C2=A0
> =C2=A0/*
> @@ -288,6 +290,7 @@ static const struct drm_sched_backend_ops drm_mock_sc=
heduler_ops =3D {
> =C2=A0 */
> =C2=A0struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, l=
ong timeout)
> =C2=A0{
> +	static unsigned int instance;

I know statics are initialized to 0 automatically, but writing it out
explicitly is probably advantageous for readability, especially since
we're incrementing.

> =C2=A0	struct drm_sched_init_args args =3D {
> =C2=A0		.ops		=3D &drm_mock_scheduler_ops,
> =C2=A0		.num_rqs	=3D DRM_SCHED_PRIORITY_COUNT,
> @@ -297,11 +300,19 @@ struct drm_mock_scheduler *drm_mock_sched_new(struc=
t kunit *test, long timeout)
> =C2=A0		.name		=3D "drm-mock-scheduler",
> =C2=A0	};
> =C2=A0	struct drm_mock_scheduler *sched;
> +	struct device *dev;
> +	char name[64];
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	sched =3D kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
> =C2=A0	KUNIT_ASSERT_NOT_NULL(test, sched);
> =C2=A0
> +	snprintf(name, sizeof(name), "%s-%u", args.name, ++instance);

Any particular reason why you begin with index 1?
