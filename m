Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D213D6662;
	Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384141; cv=none; b=LBYc43+hhbPkJrcKq2uVM6Qy9Z630agUT05Rbzm+ZIXSYSEBiRYP44dKoASqJfE2NTsgMO6RFH4vDfMe0ISGx+Pa4CzpGDWb7j9y2RLsITgTJZHBih6+ClG2gWUjJ8NEMFMnp9C4VbiQVqYLqMxJPtOC59xYWMXei6Hzkh44a8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384141; c=relaxed/simple;
	bh=+eqO1Mtwi/LEWPGcYOR45C9PwqXsrt9yRzEixp0DRg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHDsri+R3E7JdB/oqwReaURfREJ2lZspPCrqbQdrTjUkNgmMBnqY106F7qPsaOyg76SI1jSQeaXaCWBHFYEHu8+4H8Tanjun6ymHFPhLGXyMu3ybWsB+OfcEbI1p/mHc8RR6dZ2OelpIOGIEtCrCaKuk2pw2ci3G5IWGamYYKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnRr/Rd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnRr/Rd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F021F00A3F;
	Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384140;
	bh=+eqO1Mtwi/LEWPGcYOR45C9PwqXsrt9yRzEixp0DRg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnRr/Rd59pQkrSE/lxaziuX6mKTMn5V7F6EUCH4Ki0TPvZ1eWBpnwYwuRMclphkjS
	 G3Kq3gCY71Zra6xKGRuol9c+lAi3HajZuepmlOKrA6yOIbZqely5Ob39oRmpZv8reQ
	 nzuVETRnYD9Zauc26FytIp1UW9l4ozEGCpsjoVxCyy2YrhwxUN+kpf7rQzblK1yCuG
	 ch0XsTdLw6EprKvnrMnCPyuQRFuxiTalBtO38BumTuBjpgYyg3uHn7Mpr//rZ0/rK+
	 amoLsj58yXd9qcySQtHfR5ma9/6jxHmnsPTQzj4GFDIDNYcFohEpnT/AbZ8AHBEUUU
	 a+1zZkFOEqYMA==
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
Subject: Re: [PATCH 5.10.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:59 -0400
Message-ID: <20260625054005.0015.ringbuf-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122413.2477871-1-doebel@amazon.de>
References: <20260624122413.2477871-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

Same as the 5.15 one - I had to drop this for 5.10. The
guard(raw_spinlock_irqsave) conversion triggers a new
-Wdeclaration-after-statement warning in ring_buffer_read_start() on this tree.
Please respin a warning-free version for 5.10/5.15. 6.6 and 6.1 are queued.

--
Thanks,
Sasha
