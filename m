Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E227420477
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387266; cv=none; b=YqV/rPYhhXVK94NQrnezgPKx7oyRI7yJjT6HS9cUCGAhcXYihBBACKn4g9ECkHTGb5zJllSvQD/EKRbCgFUcP9Ss2UO67D9HvZdf17G9vvsJh3C1LSq49+sQvk0B2X19jo+CH4NmdPWtC+VjPIx39C+z33CYiLXM9GQgVzxAfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387266; c=relaxed/simple;
	bh=vh3O8HwL6whg3wTPW/ahU+38N86R9OCMLicRy5E1uE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A00HU/PAM8iz/MyVx6tcDrB23TyxyDoyVMAeFL0hCTyYo2I7+9TS+QfpCz//+UjXmE0Dl44X3c5kIxoOiAksdY+IHzEC5eNwaErwgw8JkJ8ZJD2aW2EpE9aNtlQYd7vRbHXk8+fZuyzJhCH/1KcYvbLEDihjyMBncZNVvxwn3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHLpdmm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHLpdmm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50F51F000E9;
	Wed,  2 Sep 2026 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387261;
	bh=8wTemToUBJccdi3qF9T5f6QBbi6WpKhiKCgyEsEzl4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHLpdmm2rqrkSpSgl+lG8ec02LrKkpd51BaL8S5uN3P0dndeUGSfjkOhsExiBOb7p
	 OFyRzf+QXa00rUfkOYXVt5irL+67lWPDvm3aF/L8QbVRg9hZgx8PxKIv584Z2zeE+0
	 Nh593jnEh9YyrR/JQvyLzG2uiNmH68G0E+m3/D197siRrEVs+yHmbl7QUr7nREXn/p
	 aMOKjt7ZqhnAb7Rr8UWrXBrGw0do0nRt+6TVTY0Nh1P6iti5qW5WN03vAsSpSNT/dP
	 ogo2NvHQTcJEZsS/qVtK2rL4zl+7SMSw0o0c2kn7BmuDSIvp47pic9NDqs/uLRY8Mc
	 pis253dqvdmGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marius Hanl <mariushanl@web.de>
Subject: Re: Stable request: Backport d5164580a994 to 7.2.y (amdgpu NULL deref)
Date: Wed,  2 Sep 2026 18:14:00 -0400
Message-ID: <20260902-daily-reply-0001-amdgpu-hdcp-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6b456fd4-e66b-4b61-8d89-9fb50f078b08@web.de>
References: <6b456fd4-e66b-4b61-8d89-9fb50f078b08@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider the following commit for 7.2.y:
>
> commit d5164580a994 "drm/amd/display: Skip Update HDCP Config In
> Transition State"
>
> It fixes a null deref I got today:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
