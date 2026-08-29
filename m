Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97D345EB0;
	Sat, 29 Aug 2026 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974498; cv=none; b=u7zQAWqIxZ5j5jXpntEgLyc2nHVJn13pK9MGvbpFekoVQqee6rwCgtwJDOMXraPGqx40OsZ1UgXDR9KepgdRYO0jWPBgto3ixXfKQrkMWdgfWRLAkZ08jI+Qx7MlNW19pAD6ylc7PWOJLWQHPoJrAlB1DQTvDABfF7nzjW2ehJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974498; c=relaxed/simple;
	bh=xiy1plncMQqY5+3KmID4Ht6W31PfqSyJPRb6xdla1ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qis3NDQ758MFcWfrgiq4fQUT6B9utFGg4Hlcvvwug8kh5OXRlx/THff/IfpigiFv2aH6UVjNsPTDCljE8xKnvL2RdEvdzEHDSLvy8ozKSR0rmlHzvGoAEqYkQnuKj3peIxUKHtdno/Uerg3a8HinzBHeyXUibVr0/cQXhq3cUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWToiR6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWToiR6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D701F000E9;
	Sat, 29 Aug 2026 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974496;
	bh=kCzIDdL5g+UsBlRYny58cWjdyNu57PG7/tAMQ/Nw7gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWToiR6+eShgoICjqfDpPY31kZtXMa0guvWcNUghDfUjW8k57rRBGmartntVVSjd9
	 JCfP9CrMNX6JHPNv5ra+Kvpvp5U7O6qIdpa+Op5iEBK7D9DNlRm13KFAB0v4G2hmGT
	 KpQYC01HtQiFfZ6qepHjlIpCYvRcTP9kfL/VNs5y6r+cWiV/BiP5AuTG9h+8hsMBtD
	 rs9O3g2CGF0cHkQohKCISzBSWVvB5fPRNIJIkF/oQm8WrKBpuxpuPWiPbQ93qPq55+
	 HzxbpVa8Tfm1ScGq2PtgkfEeU4uUEry/77sqiLQO+HSiWKh9P7zdqMNeiJt3LnQysU
	 FHD/s5egXLQwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 6.6.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 23:34:41 -0400
Message-ID: <20260828-stable-daily-0010-revert-fsl-usb-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <32dc704af59ce1a137f076a1bdec4f2aa0034463.1787901681.git.ralf@mandelbit.com>
References: <32dc704af59ce1a137f076a1bdec4f2aa0034463.1787901681.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The reverted commit uses disable_delayed_work_sync, which was introduced
> by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed) work items") in v6.10. The function is therefore unavailable
> in 6.6.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
> to build.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
