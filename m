Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F3D5679;
	Thu, 25 Jun 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384137; cv=none; b=Uqf5ecdc1vnN0SduFNEuW04Jt0I+YWOfrtoZDpA4CO3Kko+oNkNS9V/q+nSEgSOncRaP9R5ISCFcR4PvMq0FvYlMzK8r+7bLctvN8BdxCuIe2pBDhraBGXw65ZYLAbYl6SC5MBIZZkvy/gjo7Qwg3p34PaMCfTjxzoGuO4h92Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384137; c=relaxed/simple;
	bh=XTP4gLnNhtDwujnIHswNuY1jeQ6uQQxBay4IFYapLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6kDpLx6chrtqU1MPAWrDx+CDC+RqTAlPWxY8/483wg/aCzcH5+1qercbF1DF4ayYTp/V95u6Rj0O1HgiqDScOIClejNHkEnHeO9rhhW89fiogy4v5zMQVOnRPjh6rL4tzsHKoxKwN1muvjMsPqZAnT2CxVIAUkahu8w/t73TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkO2uEe2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkO2uEe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0591F00A3F;
	Thu, 25 Jun 2026 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384136;
	bh=XTP4gLnNhtDwujnIHswNuY1jeQ6uQQxBay4IFYapLRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XkO2uEe2UUQykS+6FGu247cEpZCpoRMM7M47wFT4XZwunLPANh89Ow4tNA5Rxe53i
	 Dw0jV2r5l7cColFOH/+KTN7PihMAiLedMY4FzBUKI0gDiVpr7+W98zGZQkLWgvMmDG
	 ZMjVJYgSS8ZybbnNnedxLR4VjV08Zsg00sYPyJoMQOiRez9VE7/TgVokEUhwUqN7o4
	 ex9qRD1OQ1YLYL7lQj6xrkf66Rv3o8Y/mdyojzviBzaaKYgfEB25aQX6Xucs9XXSUj
	 z9mFR7WQBv/D7JRfoVbHa/N2WNcp9qPQcjBu85chtVNMnymAeOfNDbWZAO1D+WwEB6
	 R6b2pzl2PoD2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bjoern Doebel <doebel@amazon.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 6.6.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:56 -0400
Message-ID: <20260625054005.0012.ringbuf-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122258.2476991-1-doebel@amazon.de>
References: <20260624122258.2476991-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

Queued for 6.6, thanks! 6.1 is queued too; the 5.15 and 5.10 versions
need a respin - see my replies on those threads.

--
Thanks,
Sasha
