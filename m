Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291335;
	b=TWQyD4N0/3EyIYDHvJXdfAK+2PND5/9TUvL2AYluCjg2z4ZqAZ+IbFJQv5Y93mkMY0LU
	 SRvGsmMYqWruG0OKB4K8xR3C9EsqqNfF0c+X2sB6BVX/DYCRZJ5vPY6fKX42zl4n1a8Wr
	 NvtIsd5Er6GhohzeEy4R2nXZ2ug6nDgj8FCHSLmUGcVtbj6lBXsQJddwZtmJ2pkloE9cS
	 uGQapBVO9fltcLqXICRDzoNqbjrQBs9RQPufBR6H/Gp1ujXhMVr8DYD2mhLp/NyRSYbT5
	 kPkhu09cHiIwdizKY3L5uVbXtnBPVH5xhOXlxGTVgsKwGE79G//iL+lZrPFUnOZkbUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Wojo0YNX1wY1A4OzGrPZV8zhtoYpqEDUjtkVxu2R0Zkg3aldsUClYuGD9rabqhNGVMeV
	 nI6FTo5QNPnQQIyjrZZyuORaM8ivq7CDaFf/DDkHepgvRt5O6dmaXYt7x4uEcNmNCfH8X
	 t6pTQFiY2eVSMopOKW/o93l4KTlkCKmBEBz4nssEYO/kvXXWekcvaeqpnjiF3LGQURBzQ
	 8WATP3U7sd+ywGjA2htjyPXuAXLWjotXZQAapbvwgiArYsiszCnzD/ycUzBqabqQeFF3X
	 CFL38VOfvE18TPTU/M1ugLUaShKQOKJOKVmVG2Q8iGebV3usVN8bnpXvmQlM6QGHKhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSujorYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC36606A31A;
	Thu, 29 Oct 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSujorYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6132A1F01824;
	Thu, 29 Oct 2026 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291335;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSujorYcfiRBzaSTB+a/diC5IVR4RRII+P7sqj3KbJ9GNrgeueVyUYkZ9925aPCFI
	 dnmqq9BIS63cRAtlJGtLFymI3o11xUIQiyhlKzUcsBZ5oRuQYNAqsYQhrZEIq8Ydmz
	 MdEFZMF1b/iK2auJfHXo5B68ZV53ZgizDPez98cud4miPShqOHO8fGyfYqoyMgZXZm
	 9d82lhu1rJsOoLFLWiw+7bLlEGwbexYQuxdvVL1dFOIml3XIRuu85Z+4r/PcIR+WYp
	 T/Y3ccaW9fftGU8GEeKkfCHZ1ub0Sll2CoNqzVyxghhFP8QB39g66HZkY/gsEeseUh
	 pvyZHtDTjuWdg==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "John W . Linville" <linville@tuxdriver.com>,
 Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 net] nfc: llcp: use disable_work_sync and
 timer_shutdown_sync in local_cleanup
Date: Thu, 29 Oct 2026 16:28:53 +0000
Message-ID: <179329133392.3327.1911358623600296609@kernel.org>
In-Reply-To: <20261029162419.2420980-1-tristmd@gmail.com>
References: <20261029162419.2420980-1-tristmd@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
