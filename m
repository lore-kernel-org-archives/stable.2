Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFA415F07
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270020; cv=none; b=BeXB6LIgQOQhfsjgb2HAb+z3uffy6wZ4KxEQHNMlP7kr/IYsSJcNmzEP2/oUgcbCCQLE4mQ/KLIzL9JbMHZxPLAUcNLvzwiXRdIv/VRMVsTrv67HL5htPke+wLqHbWv7nR1eqgvvnOC74UCRPes4pSqz0R4S1PgfOLez875L0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270020; c=relaxed/simple;
	bh=qgUJNbuCgdFDgW6CLiRGap1qIMadzxE8PQs8JheBUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVdhx8W8csLYHuLLYP7nVZLxjqha3MB1etgkS7tIePzyg5zmE5CdqolXnqlwdlUGfY6DES9hD7TEC/81Iq2VXUQ2gcZDQTcJhu8kGt5gYBfPCM5C2l4OTwvXu3ul7emfwts56+i8QF1nD3TxzcluobtpOqHglIHmHgz9Jiuip1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLY6EU80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLY6EU80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544B1F000FF;
	Thu, 24 Sep 2026 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270019;
	bh=tBfVkav/wtnNrPdyCNeuW6kdSW1mXwIuGWR/whtp+GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLY6EU80YSsAybJmin9WxvrC2RSG+L4A32UcuvtKiwBp21M23sO0TsnruPkJd9fqZ
	 zvnJPJdnmRt5Y1SpvFuIgm+JVGbbks5xQD+JE0Mh/lCr7RwWnQ4jfVF9XQq8GadEEU
	 Q2sIr5Cwr0zhdrcaM5ElmE7rSg1MBRIE9UVbH6lZYCWTyLbro9zHGLr7U0qKE8tUbe
	 GTWefnGyMEJpcA9vqtJS0qGB5lpjs/0hg70QfWNTGacgHZ2EH7gp5jvPICdKa74O1v
	 BwWo2/RolLySOhe0S6a/93PJ73QZfiM2VDzr56NHRXQ1uZUNRAng6Y1aY7RRYfpBKO
	 cu8E0omuqXKLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>
Subject: Re: Backport Request - ALSA: hda/realtek: Add StarFighter HDA SSID
Date: Thu, 24 Sep 2026 13:13:25 -0400
Message-ID: <2026-09-24-daily-reply-0006-re-starfighter-hda-ssid@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABtds-0tUXgbbabA=eTj0NAkRx6oN7LHk34MMmT-GsJYuwddng@mail.gmail.com>
References: <CABtds-0tUXgbbabA=eTj0NAkRx6oN7LHk34MMmT-GsJYuwddng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can I please request that cd401c70df472d3eddd0b6b055726a03c212181a
> ("ALSA: hda/realtek: Add StarFighter HDA SSID") is backported?

Queued for 7.2, 6.18 and 6.12, thanks. It needs 186d4adbb401 ("ALSA:
hda/realtek: Limit Star Labs internal mic boost") to build, so that one is
queued too. Older trees have no StarFighter support.

-- 
Thanks,
Sasha
