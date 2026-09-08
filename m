Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9F492E32;
	Tue,  8 Sep 2026 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908348; cv=none; b=ideUXHarnyUePEW3p2LXjDKWUPu4zbsn6l43kCY2BnoPeAqOL18fzKsuRTg5oSKRnNcg42zQvYkqvgVxmRfFND3j+yzLgHxmqtmaY/z2YD89pNhLvYaLhSFzXBdtCkBhr/H8qHYUQIv11V1qukCl7RrkMRE4/UttQRMhMAKgueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908348; c=relaxed/simple;
	bh=oiaalghHzk0gPCzV5wPInH7C96mALp40vvhqB8cWUUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8XjwuYp6iJQeP+WOeOIV75mYU4JY0EwcM5Kiu0kv6NtSjQVKxxVUTGQ8YEvtbi7h8B5S72h9jZ2nXgk5uDKJ9A2Y9L8iiLq4dSiElqB8EJAnWgJrA6rP/vsCOlkgC14pr/YvnrzIWhBMMWvL3NtlJm48jbN4hhx9rsWPMY1vvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLTvT5DZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLTvT5DZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0331F00ACF;
	Tue,  8 Sep 2026 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908347;
	bh=Rp+KksRhoiT3t3BB+vdlld8gEHLeRWOqf9eUUW+XSyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLTvT5DZk/+hwuHY8qdD68+MLdvzrt/PUYpi55R7+TcrQ9qD8vqCQSvjFpu2kK9Ij
	 biN6unSldgtxOyKWCJoJ2f6lqlHgFkC+g426vCnOpeRi1/A4Fk9kdntkJbCUtsglTG
	 NJrRd9EofeJDeyvbv6H5zthj4h/mqglio5U/IZ95MaLfiMJ2ejxhbLRTG1iumSh9Cw
	 i9YL1kbxLGik48+6lczReY6WQVhhourCfhughsrZaHLA0G9jpmiv0dtUVcufT2IGDX
	 d2Qyms2VjVHE7U4OkdjiyPwaRNcDUa8IhoZENrQyWyOpDkzR4C/V2WnGyskpkmHalM
	 BgPPX3z11V62Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Artem Shimko <a.shimko.dev@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH 0/2 5.10] serial: 8250_dw: fix port leak on clock notifier failure
Date: Tue,  8 Sep 2026 18:59:02 -0400
Message-ID: <2026-09-08-daily-reply-0010-8250-dw-5-10-correction@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026-09-08-daily-reply-0007-8250-dw-port-leak-5-10@kernel.org>
References: <20260908093626.15492-1-arefev@swemel.ru> <2026-09-08-daily-reply-0007-8250-dw-port-leak-5-10@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Queued for 5.10, thanks.

I'm dropping these again...

The bug being fixed isn't reachable on 5.10. dw8250_probe() there ends the
clock notifier block with:

	if (data->clk) {
		err = clk_notifier_register(data->clk, &data->clk_notifier);
		if (err)
			dev_warn(p->dev, "Failed to set the clock notifier\n");
		else
			queue_work(system_unbound_wq, &data->clk_work);
	}

	platform_set_drvdata(pdev, data);

so a notifier registration failure warns and probe still returns 0. There is no
error return anywhere after serial8250_register_8250_port(), which is the
precondition 10fc708b4de7 ("serial: 8250_dw: unregister 8250 port if
clk_notifier_register() fails") describes when it says probe "returns the error
but leaves the 8250 port registered". No port is left behind on 5.10, so
there's nothing to unregister and no use after free.

What creates that path is patch 1/2, 57f83e5dd6a3 ("serial: 8250_dw: Use
dev_err_probe()"), which turns the warn into a return. That's a cleanup from
May 2022 with no Fixes tag and no stable Cc. It's in the base of 6.1 and newer,
which is why the fix is correct there, but 5.10 and 5.15 predate it and never
had the failing path. Taking the pair here would import the bug and its fix
together, and would also make a notifier registration failure fatal to probe on
a tree where it currently isn't, for hardware that works today.

Same reasoning applies to 5.15, so please don't send it there either.

-- 
Thanks,
Sasha
