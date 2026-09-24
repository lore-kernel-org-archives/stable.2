Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6C3BB104;
	Thu, 24 Sep 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242773; cv=none; b=LVoUMtpQ4AzqC64BhKmemneGtXapHt6tknwMgLcjSt94XRgRvBP2Ck6ZYxTJFnhlJSrr854xW/HqQ0r2oLCl37zs1/oKZuBoP/fethBN8Dj/fT+8Eeg7ztKcZIWyXSEBzzgnQq/0nx/9VNSPvwKEhkOf9+nTbtMlGwg14ktpwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242773; c=relaxed/simple;
	bh=jJ+Eb+1ydqqbJZ+lEcFQGZ3fxaw3MkCVu8JYnWNLLvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=No++kk+ACH6/aVoHvLGtd6LgvY3jW0YqPyyXjJD8SXRcsXYMv9rsTy6UrBP8Jud0Ikh7ADdw5Vz+XFOukV/xc9Z+o+7cZ783nqwjckBjQm+ksJJlciaXJXDR/sQQ0XbRGI+2vkKrcHUQUsDwbDpwE9M966uwUsUbIAodMOVTVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLqSB++m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLqSB++m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205601F008A2;
	Thu, 24 Sep 2026 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790242763;
	bh=jJ+Eb+1ydqqbJZ+lEcFQGZ3fxaw3MkCVu8JYnWNLLvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PLqSB++mhig73psN7KdzBeXJ176b2oUxYGos+x5Xoz72K7E0Bupncs8y15a8SG9fY
	 k2DeOx9oa1+CcIx34MjQlOjsJ8PecygFGpUcFZ08rvEb39DxmhAmTLKKHoSoTGD4mc
	 /9KcU7kTEhByTHEdJDQEdb7emnkp52aqIhGRuq722Z2o4un4MtfuzM6A4PWM1ma5oA
	 WhHQAwzdHnBRBpUnIo1vQFE09VdZSuXVkCs6LfqaMrOue4LekuPxGP+AgS7q3QHzOq
	 Tvs2vK4rFyQq6hcAtZoz+ZgknxysmXWE9NNgZln5MwqPpRcaAI0KZW0T5E3Gak82et
	 Lxm9TL7xP6Tew==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>, ojeda@kernel.org
Cc: boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, rust-for-linux@vger.kernel.org,
 stable@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu,
 dzueck@uci.edu, pgovind2@uci.edu
Subject: Re: [PATCH 0/1] rust: configfs: Fix incorrect subsystem root check
 in `get_group_data`
In-Reply-To: <cover.1789770689.git.pgovind2@uci.edu>
References: <bGK-A3rROoAQiuwhu2X-iYVDvucc1an2Zql_F7rQ1d8ohSa5gEBXjEJZOkPgw_dBtBPu7LdYwLEmXsrCnN84GQ==@protonmail.internalid>
 <cover.1789770689.git.pgovind2@uci.edu>
Date: Thu, 24 Sep 2026 11:39:06 +0200
Message-ID: <874iff2dl1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Priya Bala Govindasamy" <pgovind2@uci.edu> writes:

> Dear Linux kernel maintainers,
>
> We are developing a tool called FerroLens to detect potential
> unsound behavior in Rust code in the Linux kernel. The tool
> internally uses an LLM to detect bugs.
> We then perform manual analysis to verify these reports.
> FerroLens reported the following bug in rust/kernel/configfs.rs:
>
> In `get_group_data` to determine whether `this` is
> subsystem root, the following check is performed:
> `(*this).cg_subsys.is_null()
> `get_group_data` then tries to read the `data` field of either
> `Group` or `Subsystem` structs depending on the result of the check.
>
> But the check always evaluates to false in `get_group_data`, since
> `link_group` in C always populates `group->cg_subsys` with a valid,
> non-null pointer.
> Thus, if `this` points to a group representing the subsytem root,
> the incorrect branch in `get_group_data` may be taken,
> leading to attempting to access `Subsystem.data` as `Group.data`.
> This is type confusion that can lead to data corruption.
>
> If the `data` fields of both structs are placed at the same offset,
> we will not observe this issue, since the attempt to access the
> `data` field will be valid regardless of the type. But this layout
> is not guaranteed by the compiler.
>
> In particular, if the kernel is built with a randomized layout
> (e.g with KRUSTFLAGS='-Zrandomize-layout=yes -Zlayout-seed=1'),
> We observe incorrect behavior when using the rust_configfs
> module from samples.

Thank you for the patch. I think it was already reported here [1].

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/all/20260608-configfs-fix-offset-v1-1-7f01b8fb9e5f@kernel.org/

