Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CD47F2E1;
	Thu,  3 Sep 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439091; cv=none; b=lDeqAilrlEF6kIBCVhKUJHw3rAuldpEd702ENowwCSmkSGKCHM12pesZP3Ab9Ohq+hA3zBZllZg2gdB59e8j2B5gjQI5FXv63ByMtpswE+XwuzQ4yV5oAo4KcawzM5hXSfU25HvyjBYvwnBA2DnmJg8bOMMN4Uu3OiLL+lhR6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439091; c=relaxed/simple;
	bh=urmx6qLh7VqDwwY05WBP8jBUzRmTsPXeBMyOQrawmAQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=chC6YFC/lr/WkN24DEMeBv+QVzlMWkUCKMW+WuAElKsnZvLFBIzJSKAZ8QLuYUGmqHMAu+1hc0I6bwvRseFyVZo6QoZehf8hFBGv06zK3hIO3Z7ARF0cRE4f1omto4d0VsSnmSMiuZNxbvOb7L4GGJKDSzrJLXUtq7Zg55+4xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjV2fdHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjV2fdHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DA61F000E9;
	Thu,  3 Sep 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439089;
	bh=urmx6qLh7VqDwwY05WBP8jBUzRmTsPXeBMyOQrawmAQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=QjV2fdHL6Lnn2dWGdkkV730m1GgAhDgcmWXi52teSaNbSIn3W98RCHSjaw1+KLLck
	 KokUNqf/xK8fMi7vUiwyhN/dKzUEtA04rcYwmTIwHcDY9F8BjAzYDR8bB8Rb/T4xbc
	 yUdMZ2sZ11OEKpkRA8utOYoCzy6T3Yet2FmrHaS4TQa1A0hhM539FQA2jDUYOGE5DU
	 YY0phxpSVFVlZAxiDqA/ntr5GpEoxWaJco7nVdiRTwzpQnUwC8AYXWYlqH2udEO0Ql
	 NZRNeXJKOjVFmecqqDVP+QRhqZdRzJa0UuY5SqzGGyWju/IG6Hd7EAQ/GW8LoZdjKT
	 hrCNijZa63+oA==
Message-ID: <8680c6a6bc2793ab83dd4e921bb370bb@kernel.org>
Date: Thu, 03 Sep 2026 12:38:06 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: oushixiong1025@163.com
Subject: Re: [PATCH v2] drm/sched: Create a fake device for KUnit tests
In-Reply-To: <20260903121558.782854-1-oushixiong1025@163.com>
References: <20260903121558.782854-1-oushixiong1025@163.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Matthew Brost" <matthew.brost@intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Philipp Stanner" <phasta@kernel.org>, "Shixiong
 Ou" <oushixiong@kylinos.cn>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Thu, 3 Sep 2026 20:15:58 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The DRM scheduler KUnit tests pass NULL for the dev field in
> drm_sched_init_args, which NULL-pointer dereferences in the drm_sched_job
> trace event via dev_name() on sched->dev.
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
