Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97683245012;
	Tue,  1 Sep 2026 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306496; cv=none; b=db6hmnTCQ0nbDcsqdOy9KZCoOOjmQpx+4/tmfz1UTmugpdw2vyub78wOKmSyGf7eyBTibhOeLrQscIiKPvyAj+miTA9tPnvmKDb4lscHaLJX9VmqTCEeMWKVXq2tPlgdKxCkGjKxLcyC2LnRlkhLlRJYi4nKR+uRFsDZIp42Sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306496; c=relaxed/simple;
	bh=zsK8qE4QN7/3haoGaD6w5kIcqg7jdmT69S6wxoAghiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muFnJmdxcQmqa/EpXChT31kdTpiNUuPu8AdC/gJKV0HuvBeWwgDp9KsEIb1PvaDFRx8NaIgRu+tsNZJKzT7z0itTMOZFIIDZOIfJ21fShw0edOHHaJvMoPhP7iemCcezgX0lVUiF3tX/x8lwDVuYpSij7E8EQ5BFLB5utRbVHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHhPJfvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHhPJfvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77931F000E9;
	Tue,  1 Sep 2026 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788306495;
	bh=SY658F2BXwRDPjfNb/phifPGpwXYwGX4khzMImQIVcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dHhPJfvNXWQOC0kKNV8SAvUqiE6UXcFK2kNPgku4rYzJxeHla/xnJLHZYmU4TgcYq
	 2zz9hpfAPyZFszWE5mTlZZfHRP6ZPvYmaSTfvu/pd2Wv+YjUes4zssn9pBk9aznPXi
	 mfCFJABc4aQ92FYM9Xfp6giksiX18OHZsWHPP0eLyVZXsPZP43VY1qndXmqQeOGIKZ
	 AsaT7LTBsSHRbBdOFSCYsAYzXPcmk8oWPQxGtEpA+2fFhOD2bCfT3QucG+oO80sZcw
	 edtQPXWpsjWV9War09+FFHHJvFr5rS9mx0MaRHIc2/Z5/SGxB9abOE+ELZJtTS8xa5
	 lxyb9wM0xifgw==
Date: Tue, 1 Sep 2026 16:48:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred
 completions
Message-ID: <20260901164814.00f446f1@kernel.org>
In-Reply-To: <20260827230233.94878-1-joe@dama.to>
References: <20260827230233.94878-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 16:02:32 -0700 Joe Damato wrote:
> When the driver receives a burst of packets, it can mark a BD with the
> NO_CMPL bit to defer completions. The expectation is that the last
> packet in the ring will have this bit unset and the completion generated
> by that packet will cleanup that packet and the ones preceding it. This
> helps to reduce the number of completions fired.

AI points out that the DMA map etc. path does not obey the new
kick_prod that you're adding. TBH the checks you're adding look
quite messy. You should try to fix this by centralizing the kick /
flush logic at the end of bnxt_start_xmit() ? 
Maybe bnxt_sw_udp_gso_xmit() should be returning int 1/0/-1 that
you can then interpret in the caller instead or some such.
-- 
pw-bot: cr
