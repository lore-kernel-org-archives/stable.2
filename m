Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246344F7984;
	Thu, 17 Sep 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655818; cv=none; b=Z7uZc8mJoBc3j1OntEyfgYO/sCpdc02WORi8Hap/p6xo4L/RXdeR6lRufgP3rAMhcG08RaYx0GoRu5p2uLj/0RGPcYm5LUycoI9n9e57liiTViLSoSC0yRx4bOHvl5qcd2cI+sefPClXMICSV9HZgnt+Lx2P3HOUxPxLD/Zf1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655818; c=relaxed/simple;
	bh=nszi45kXm73Y7NgYq5onAqIMX+LJwX1ohh2P6iyEr3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQDUsLQXquSna2ZL65OndxRZCGJxrL+BD/EFeWiNpsLyKFZyWbkkwJvL/jHp6ZwUOJ8v7cgBmMhI9LE3FbweCrAmB8ndPK88ErTENMieXjf8yFvBsklF/Xh/IKnxA/0pYWdPcD9JQSBZH9GJ4uEUapL7vC7CSSkcglrsYfU51GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkU8BSbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkU8BSbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6501F000FF;
	Thu, 17 Sep 2026 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655816;
	bh=wbTtNovbZeKMcq+Fme6uVDAlmL8EXwA2kL/1U7fmOOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZkU8BSbqtg1MvUzQghAYB/EEHMgRjbmvz4b+h7ap4WJKOXkkw6YlL1KSpf89Pscy2
	 B5MATM+0LGHT1dnDxFBe4wfPtHYfOSf7T53E0t9bXlItT0WbAMRG30PzpaLqBxR36c
	 QY6O+jKe1JJhnyXPwMr7nfEFYroUK02zY7xPtZF90lnTpihTk/Yj5oJ69BhBNyzdkr
	 R7MbKadAsopryAllSVRFaBnzduAg3DQ1IdcqfXACOjrHXZ+Qv7p6Ag2hDNp7KX0TCn
	 abRJPKkJldCyee3eei/CSyRZ9rEdrendzzVBzrO/NgOqNtAXeFnj+60nqQz203ZETa
	 2s/9349+QT/5Q==
Date: Thu, 17 Sep 2026 07:36:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 jeff@garzik.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stephen@networkplumber.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: cxgb: Fix skb reference leak in
 espibug_workaround_t204()
Message-ID: <20260917073655.5d7c9ecb@kernel.org>
In-Reply-To: <20260917105425.2147804-1-vulab@iscas.ac.cn>
References: <20260917105425.2147804-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 10:54:25 +0000 Wentao Liang wrote:
> The timer handler takes an extra reference with skb_get() before handing
> the skb to t1_sge_tx(), so that the skb survives until the DMA has
> completed. When the command queue is full, t1_sge_tx() returns
> NETDEV_TX_BUSY without queueing the skb, and the return value is
> ignored, so the extra reference is never dropped.

You have sent way too many patches at once. We have a hard limit of 
15 patches per person, but really if you're sending low value garbage
you should not send more than 8. So that you can apply the feedback
you receive to later postings.

You may repost new version of the patches to which you receive feedback.
But I don't want to see any new patches from @iscas.ac.cn for
drivers/net and net/ for a month.

Please tell your coworkers/friends.
-- 
pv-bot: 15cnt
