Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21D3C3792
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701608; cv=none; b=FFFaejfjy2+eN4XOPzW22QCirDxY2t4q4mjXsQmiozN6nU6CVcKF8DXNBvq0g7nihMQEZHv9JLMCpHkaoH674388zfpxSK9zJnhvGd8tK3md0esBQ1NtEG83ME03ydpvufuyOccc9g4+/BBSIrvjXzNgSc4yNnodxF+gw21SCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701608; c=relaxed/simple;
	bh=moZlJPRdbPRqgwwbm5qOOsxNbEHNA8s5FHMl9UUT5LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qqvp2M1D38RmrfDOlihupna1jVMyuQYx1sSxaKIhpVCChk7wM8GwLDsKGC25a/NLFv9N0fP9mXfZeDI23YxebdQyFfHpAeY4pyfa6haO71nt1wKUAhNkNQZW20Nhks85EqivBCXeDQUl96M3Bto84ElqSDn22k09UXLj7ikptdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA6IIMtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA6IIMtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED9B1F00A3E;
	Sun,  6 Sep 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701607;
	bh=EZ7GDXh1xOKs8ZMB0FM/TmB3Q4lr/NfGiO7IRpH3cok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OA6IIMtT39Fn9SaPduprJbpO7ilkhJ5YJlNn8CfwKBhuJsKUJJ1vtMQ1TPO+AoEuJ
	 tD8IyuLQ5EZrfwZ38ZqJh5TG9KVsdBwsxtfM/308dMPGd5XgZ1XDOw09y77UKOP9V5
	 Oz+DJ5K0mlwANIdgATnuiHK8wpUaFw8+EOvye8kBuMYENhQNmeusMwATRzuiKC+nOt
	 kJbr5vgRD201bJ3OzZwqtR6s39jahfwJ9rol+jVsC4wYDGip5LL4Uf3K8HVA2c9qKY
	 4wuMXWCuAp2YXB2xkm0GkjgJ+7sVXSkJnOfPa4GBQRrcgXSJw0O+WRld3ABivHYtRJ
	 BPISXuAfHNOZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jongmin Jang <payload.jang@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 5.15.y] net: skbuff: don't touch shared zerocopy state in skb_tx_error()
Date: Sun,  6 Sep 2026 09:32:32 -0400
Message-ID: <2026-09-05-daily-reply-0002-skbuff-tx-error-shared-zerocopy-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904083936.1801336-1-i.maximets@ovn.org>
References: <20260904083936.1801336-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> skb_tx_error() completes the zerocopy uarg and clears
> SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
> SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
> shares, while the caller only owns the reference it is about to drop.
> Through a clone it tells the producer its pages are free and drops

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
