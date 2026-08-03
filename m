Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8F313540
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790024; cv=none; b=fe1Tx8NObdYWM+znKaTUw4mVVdoFiRJIfEm2TjMHT8B5c1BFdpELc4U5zTxcJ9Jbhq2U9XLPXBxA3aW/JgZ3tGwfFzULE+HjGQkLoOOqhOF0KBN1VvJ0N7xshnxTvAhdid2q2KuNCsS8jmftl8juKdLIksR8YqHY6MloChvRi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790024; c=relaxed/simple;
	bh=/FpBdPjJ4Lt2acr5Lxis0KhP/n6h/sGMxZwo8MQg/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXGYfRWF2vFfVdxERKOELVAb9Y5xkobVIaQRPj99H84tzWIXaQLz+3pWz0nvvIalhwmzKRo2WA72sMH0FaowKgElz0/bJNsyDXL3OXqB+6n5b9u/Y6m8LEJQ6sJI4i7F67Owoa0okyRLV7HKYGCrp6zPaOmagi6Sa1N0H60qzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmA93q6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmA93q6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82BF1F00A3A;
	Mon,  3 Aug 2026 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790023;
	bh=dRNe74tpiMqyByLRP0Jg7cuXWMrA0c2VIFvQ6rPM8jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmA93q6omba6s5/SMVW2rN+/9gtHP6G5kK0xBNORlj3S0oGl1y/dC+gma8vCfS1TW
	 KAL1SItf0vhWODPfWdvBf7iPBYJQxyFauYw0Na97dRUNFBcNgZxI0Togp3bQjl2V58
	 9I2rgVW0US17CqQ9HsRPwSscq5MjhV4skIhDdbYIn5j6AG2SHLpGmVL1yK5b7QhstT
	 q7MnH63t1K5DSRX3hHMQn1rPKG+LEXilqK/Vaf47fAdVUhruS+4QA4j5D5DnFIJGqZ
	 /NR0uM7ZMZFKISw5Lc3hri/ekTbHxlkMKvXWZjimya2GSXji/MWrwPT6H/zbl5uyGZ
	 9Yio5KkwwIJpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 5.15.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Mon,  3 Aug 2026 16:46:53 -0400
Message-ID: <20260803203501.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802202004.3818201-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260802202004.3818201-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 02, 2026 at 10:20:04PM +0200, Youssef Samir wrote:
> Fix this issue by limiting the maximum number of server registrations to
> 256 per node. If the NEW_SERVER message is received for an old port, then
> don't restrict it as it will get replaced. While at it, also rate limit
> the error messages in the failure path of qrtr_ns_worker().

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
