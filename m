Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958D279DB1;
	Fri, 19 Jun 2026 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842044; cv=none; b=l6PcfwI4HUEeVF7syUoe8CGaojvtzEdGK/h4wXM4RQptIef2MMtfFq7MQkpnUsbWP2GIAbxUOM8lXGg+9bxiwunr9iDPmZaHcCvJcgN46xlx+SuCIO48rYvPkF54h3186wcge05InxLmwnA70onoucjDbZy6e+qVTnMf6kZQvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842044; c=relaxed/simple;
	bh=eZaw6MJbBtmdq7ttzn5uCSQOrJ0FgDezbbOeK10asas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM1UaBV3hqZwTmMv9U0qVcLJEgDv8wnArsVHhIXUQgreR8cmf38QYfjNbtAr7EUwhhgs6BmH+dpE385U5UP8f1pSmW6uxAu4FOteewpaHfQB4LxlXDEytL/NzdnkmR8f0lxqGPNhjFoO1KfMWMq8kxeDRg/67ZvDYf2132cCZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9a21yLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9a21yLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FDB1F00A3A;
	Fri, 19 Jun 2026 04:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842043;
	bh=AKEfgz24t9uQweUkrwjuC12FE1DAVbSKnw7B7l+0MaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9a21yLUrBaqg+XdhpsvCD4MTABQl5Fc8KInp0eH10cG592JFalpXW9mTJdE6NBSs
	 jkW6xSFXr8N03XL+I6JI+Uzv/MEDZO8M1BgK+eaKS75S9oOZSXL8iPEnZ24DuOeCcs
	 YN3XmuIToMKIORi2EwL5Lr2IJIYwn/hx6iZtsGOzJ53IvmHlH2J1MmWKcsK/igO8rH
	 dF0SDD7SIoRsxqQmHB1vl46MLy0FnI85RNekz+mrJSNqI4ygXZuvBjQzMx9S5M2ZMh
	 oh0DngoifHv10SXElgAwJlZWpeisvLMH5OfcJVYqHYZIYD32RyFnpHz6HFx6bfAMgC
	 sscbah7tlDcvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.12.y] io_uring/net: Avoid msghdr on op_connect/op_bind async data
Date: Fri, 19 Jun 2026 00:07:05 -0400
Message-ID: <20260618-reply-item040-iouring-612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617175158.2977825-1-krisman@suse.de>
References: <20260617175158.2977825-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH stable-6.12.y] io_uring/net: Avoid msghdr on op_connect/op_bind
>  async data

Queued for 6.12, thanks.

--
Thanks,
Sasha
