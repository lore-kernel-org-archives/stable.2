Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AF3D669E;
	Thu, 25 Jun 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384138; cv=none; b=iNarc3WxfP6T7AyZtW1WYnpnVFZkVdZv66+/B9JgroNK9BUF+XgFVeqNtkLMRNAPEckn+iRhIMzWInwy8w0ruSJJKmOTwg9n4IGoobFSo+rZgTcVgx26UR/qxGdzu/Iig0c7MdrB9CxBPWCLTPJuOMRPXjGPSKxi3yTXIT/5tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384138; c=relaxed/simple;
	bh=33PZMhYYbFnkBPykKf1X/fZreJUQR4QzCZTieEJFAuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAboM6rORWdVsMtOxwbu0qpDvLabpcR0kYeAIx9x7A3FK4A6qpyqwyPnmML9KUt1OAZhfxcF+WZbi74b8bEp8LCYCeSg4hDY6jsCcl3HFj0dFMRIaaYRiViWyG4sRvmd6FjcCCOk9tYki1YwWq0iPNglmhG+Q5PjTrciLH5iLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnxrSACr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnxrSACr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9411F00A3A;
	Thu, 25 Jun 2026 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384137;
	bh=33PZMhYYbFnkBPykKf1X/fZreJUQR4QzCZTieEJFAuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lnxrSACrk2fZyouCs3exkdo19+krTSEwTL5lmWj2/tABGZtDS2x97ASTfwa3uoqcT
	 oUdnu1jdbBzNcC1TBYjEKeBswsFvxxg0fHvaccvCy/MsbvKgqAB0eZY7iXUsMnPJWQ
	 4Fm0OKnxpv0r2cp8MMBcoqxgUxsSJ+Dz21kvpQqi8w2LsPSKk0V9c16+JREf7eqqsd
	 N9TDFaUtK/oYHwi5B1Ocewd+daJC+DSfF+JEjGjJofrg65M9sLl6h6q9X4tiSb87kW
	 4KwsDB2RONlWRqj3fvOZzfiVRs5QX7LUvwhs2oG4Jz247lBLyxDqhdWwhFE+TMWCNo
	 NYXyDd53Qh+Zw==
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
Subject: Re: [PATCH 6.1.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:57 -0400
Message-ID: <20260625054005.0013.ringbuf-61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122328.2477272-1-doebel@amazon.de>
References: <20260624122328.2477272-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

Queued for 6.1, thanks! (6.6 is queued too; 5.15/5.10 need a respin -
see those threads.)

--
Thanks,
Sasha
