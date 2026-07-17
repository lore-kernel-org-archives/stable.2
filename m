Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AA2931C6;
	Fri, 17 Jul 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252270; cv=none; b=KqBqJ01ykZeTuAjEu+SmJ4oR8z9xor2hUlqpWR/rpdVaClZoOTghcLwj+VDI3p7ZDDb5w329nB2lhumxy2gvskHWx947zKHrelNaG4Z5lkldrY2PG/Le3bTIPAMUxVBGbM70AaLA9FUFy2xuujYxlxfwskLGCwbrvSiPyqY/f8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252270; c=relaxed/simple;
	bh=bKJIdtw1EHSndgLb9ceqhmqoztJFUzSjosguWnrKlis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A63pSCvuIwQYAQcAC6bibdimo29Lrm4QtfJyE5pVXwUDRG22kj+kErUgIZVzOQieB8ybEJ1v7Mxmvymo9kEov7J87ml5gAOspgYpIuwonaRcfO9xW/zysNrza6kYke+79lMsEXwES1Qib2ha1Z1gW0AN0WO5Z8CFOJkwIfFHcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnz6qrwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnz6qrwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300ED1F00A3E;
	Fri, 17 Jul 2026 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252269;
	bh=Y0JmhZ8pROCmk2R5GBPaMFv77g2uucL9m80QATOf3sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnz6qrwi3DFi3ZS7rV1dBwOFqqXGvR3y8uLRZveMwa9VOGI3QcN21MsaWuO1x8g6m
	 7880yH2flSdFn7cqBZ+1AJxboZOIGHUcqJZex3S/CpGsv5BX1jnO9Imuv0J5K7jURD
	 0ssLVLgV2e4wlLhOF+IyBy268zVVu05ivKba0+lsQQnTYeHgA8ZoT1XB9D0zcL8soE
	 Uu4Y9M5ZW/ljIfP+sp6KsIRVL4tMJISkP6nxht/HHrFOa9o56sbKZuz+nBUQ4oYp2e
	 hBIF9KpEuSJYf3UhTJ21xptmUtnctlhLbu57KWwbM4Lnr2tN7rErzZAfu+uRPQbwnF
	 GG8JV5khTPUug==
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Date: Thu, 16 Jul 2026 21:37:29 -0400
Message-ID: <20260716232340.0002-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alYfV2l-7p4Y3eX-@mail-itl>
References: <alYfV2l-7p4Y3eX-@mail-itl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 01:36:55PM +0200, Marek Marczykowski-Górecki wrote:
> I think this wants to be included in v6.18 too, as it also has the
> faulty commit. And indeed, I do hit this issue when running 6.18.38.

Nicolai Buchwitz sent a 6.18.y backport of this, which is now queued
for 6.18, thanks.

-- 
Thanks,
Sasha
