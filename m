Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B35329E46;
	Fri, 28 Aug 2026 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881602; cv=none; b=glBxL7259+8gIZ8ZGmq8lp8mfxVNCXhfXHmusjeh/A6gnEWy79mfcyH8NdcxFZ8pnH8pA9R/hll8O+R8Uq/uurXRbFQlIqIVu+u8nOnNC/ne9MlXoGivFB1Woz+HiZBPR7Iq4RKxgf36y59eAGpdyKAbxtUYw1/sb0zlUO8RaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881602; c=relaxed/simple;
	bh=GxB3EcpkP/lKVH+HFC/igWI9F67J5r1VtjiExiK5eIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhDZA3D/Yx7AOzWZ5HLFWiHJ4puTunHx6FC4s4iwlO1UFSr5ayYJqCTHj5DSYAqz447PZ5htCgRx37hD9tTzAymX5Oo1HIDgNvBgioGNYh/5WI8VxRtQ8RLJ2topPt6fBIU8X7ro4MrmEAiHFYyhiF1I05qE9No6fRMp1u2JvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XteSyjah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XteSyjah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C70A1F00ACF;
	Fri, 28 Aug 2026 01:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881600;
	bh=FixzRpJT7uo+WgEkGBPUVuEw/+KaJ7ABFhGFEOZ/7hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XteSyjahfRvX0hjyHGAlgCG3HwC/LQhiIszqJiDYtX3NFCOF5puEMqXFaVibIvDCw
	 8/kn3fOKi+PbifiBll5wcvYXMYLZs8hN694WwLJ+/bgeO9szbRyfJSHsRsGLLqqOBJ
	 5s0TtxbN+CKfrdruPQCzRaRookKOm5tFG9tjZI0rH8fqgbOIxiisd/qKVBviavR7Ip
	 9+/wnxh5zoClg8WmsBITJm3Rtl4tajimUYuE7Ai2/MNtv6GKrsmqwhQBS61ZeO/JkQ
	 Vvs4bdfHv9YjusuZVN4m4vFvKYuAJWl0szlqDCeaLIkMPLWr8XikUZkcc4cUVAYxCy
	 UDvdAV+5PEPzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	asml.silence@gmail.com,
	vrazdan@openai.com,
	krisman@suse.de,
	axboe@kernel.dk,
	io-uring@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
Subject: Re: [PATCH 6.6.y] io_uring/io-wq: fix worker accounting when canceling creation callbacks
Date: Thu, 27 Aug 2026 21:46:24 -0400
Message-ID: <20260827-stable-daily-0011-io-wq-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825-stable-io-wq-6-6-y-v1-1-c9f890168485@openai.com>
References: <20260825-stable-io-wq-6-6-y-v1-1-c9f890168485@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Decrement nr_workers only when the canceled callback is not
> create_worker_cb(). Continuation callbacks still release their reserved
> slot, and both callback types retain the existing running-count,
> reference-count, and create-state cleanup.
>
> [ Backport: retain the existing wq->lock protecting worker accounting. ]

Queued for 6.6, thanks.

I also used this patch for 6.12.

-- 
Thanks,
Sasha
