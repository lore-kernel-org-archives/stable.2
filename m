Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4F30C14C;
	Sun, 26 Jul 2026 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067508; cv=none; b=bDPR6IV6lkOWWWLENkM17jRIK4hKFC2n+cyZz068rPMoOEH13jsHBENXMRAovzJrPuSX4kBq4dAOQbaV1LNwkglgdqAJvmK3x9tkNgFONJwernFHKDhZDwPpcwGBKCJ4aViImdwwGk6gtZOzQCxBjKTDikPCgQzoJ60C+44ULHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067508; c=relaxed/simple;
	bh=jOl5qCBbEmwTjvyRcObyp//fIFol1C93Oz2aOofbkUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK2EF+Z3TnpAp9IqkcYvOZPQp8LzByyilMDtseOpeu8J0ZM595eLp7eGwCZtBejRAiQl1vIbHSIqudHflGC8w6Dm+URBV21TGLmzmptHNiyQLd4V/9EjRpY8CHDdQF26L46MN/jGagWnxFvU4BBZE8jOFFK11r+ysVX6q0n90T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDzzQsaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDzzQsaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007281F000E9;
	Sun, 26 Jul 2026 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067507;
	bh=SyLiXb5AbPxxaQCiNJ4rR727zON4isSKjuoFkAK0itc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDzzQsaj2nPeBJAlKLpqiZkH5I87M286v1vaookzXWkbMulcz7V2evDeZeigGKiOn
	 Lv4FSuC8Xnt54JBmu8JbKF1G6MMDEnd80vuXQn17mjJKqnBTowK8PMmpBmgL9lfMRZ
	 B9DUlBnyRLE+e3+oYsZfucbbu0uMlIXLShC6G+bf4aLqsM4EEjUmndMoQ5VruSp2U7
	 BnaoT13+dW7iwFbLUgk//dIAcbdRUWlYlWDH2Re9temQYAaSBSwwjKxT+9AQYZ+5eD
	 UceeEhbVNI7El6df6VSY6oua6mFxtFlgPanr0djT87wqJbU2wVOZTcmeYXu49QozKe
	 XgXi40Jm1ZiEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	Seungjin Bae <eeodqql09@gmail.com>
Subject: Re: [PATCH] Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()
Date: Sun, 26 Jul 2026 08:04:49 -0400
Message-ID: <20260725192000.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAsoPpV1WtUsPRtuRHQb8VuCvMHYHG2K-NU-LKGhFL6rWBdZHA@mail.gmail.com>
References: <CAAsoPpV1WtUsPRtuRHQb8VuCvMHYHG2K-NU-LKGhFL6rWBdZHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please pick up the following mainline commit for all
> applicable stable trees?
>
> commit 875115b82c295277b81b6dfee7debc725f44e854
> Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

Queued for 6.18, 6.12, 6.6, 6.1, 5.15, and 5.10, along with the
follow-up logic-error fix that Fixes: it, thanks.

-- 
Thanks,
Sasha
