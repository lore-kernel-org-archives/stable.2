Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8F3ED13B;
	Wed,  2 Sep 2026 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387267; cv=none; b=Obz/RsYF4n6m7hgvAgCV7JAgaXnWbUDWdYrlgoeZXuNY3Duj48yAoOogFn6Y05MZFNr7WgeZiA9FKrs+Vwacn2EBCG1SwuRj7DlYo5twvTFWGxWxzqjj16Qhq5KflSG3+eE+JSxQK5Gb3OAP9eBJQwTD4mobFJkZso62xNEIrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387267; c=relaxed/simple;
	bh=Oj6Ip06IetSe7j9mQ/SGPhQMWDRjFgBYwM2SX+H50V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYaDFcp/Bap6sxCDKm+RE3ccc0fblUnRZLr0XrKnFMdHC5FGQgHCoZkXsDbp7JH7bFYrzT5Iuj4KfB25TL9uNgUd4TIV9zZMigujI3O4C7leCpMMZB1u4SXr7+S9ThT3LOv6+NC5nPwkXQF08z79e1Qzrps5IeUG5JDackgGmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckTl0KmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckTl0KmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843011F00A3A;
	Wed,  2 Sep 2026 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387262;
	bh=d6ZTo5YgcocI2m0tQVLBH6ucdz7EXy2FkXWfbOWThCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ckTl0KmZPHxywSEQXyXJdwrBQI5DT4Y2DByRpFGxVYXKC1KK/6qQdlKSIH1+XsVWO
	 cp+Q0qFfaoZOO1wLBlr9xdXACVzWa86TH0Srj7ELLJC920jrSiaNMyNWa1xF2DLRMZ
	 eheFTB81hpPlbAyVRbG9p4wEIN5Nby7yuDWeWWQhJ/nrEb3OvYmjfwyI7+lFNwK+Ta
	 BWtdwytM/oAl2+Y/rnCH2onHlYtuHf2BwusOnBft2TqAXRiW3JusigkdHjM2UuNa/l
	 V4HLzdGidQvhzjFUY7h2nLDqueZcbJbs8gRP9QXN+pkBmr2u1p28UDuwnX3kn2aQXZ
	 z3vvZIBSjK2tA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Sheetal ." <sheetal@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: stable request: 7.2.y: Fix audio support for 64-bit Tegra devices
Date: Wed,  2 Sep 2026 18:14:01 -0400
Message-ID: <20260902-daily-reply-0002-tegra-audio-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cabc530b-3504-4243-86f9-19c57ceae514@nvidia.com>
References: <cabc530b-3504-4243-86f9-19c57ceae514@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Audio support for 64-bit Tegra devices is currently broken
> for Linux v7.2 after commit 4b05ccb17f92 ("regcache: Sort
> the local copy of an unsorted reg_defaults array") landed
> exposing a bug in the Tegra audio drivers.
>
> This has now been fixed by the following mainline commits
> and I would like to include these in the linux-7.2.y branch
> if possible.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
