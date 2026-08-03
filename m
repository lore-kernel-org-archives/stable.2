Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EC30C60D
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790026; cv=none; b=UaiqinoZuczNzv8ubv5OPR4T1AzfvligBDEx9yRP/jizmPuVzbefffRpoaL9Wmdx8gAhLjwABQY3qt5D1nkSwfkoky5lGG7ycD7B6oYm2b0/LU9jMkggzyxL/yjcpys47ZQaprAtGzFixkdb9W1N7RnPZXpmmnUz8+0PIPBnD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790026; c=relaxed/simple;
	bh=HHT2GwD2u/1KBvYcFdYeo9o6BVJGOZuOQodubFY85UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei/nwu85AoTzwQlTbj3qNRO97iRsV907G9ESYjWO6xeudQRk20qbu8hZz8UQ5YXoq6NGI1y4azh9hiKXgDAGpxw2V/0qkI2cv59pApgX/BLbLR88zD/b63QPEh9dXcazI6oFarkNDC4THd9golTDl9PMSkRrZFLlj50Zk0SJE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Quqb2uAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Quqb2uAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F221F000E9;
	Mon,  3 Aug 2026 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790025;
	bh=dnfpM13eCUbVyzm7sT79kRxhuKWDOWJDgshKCnkDC9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Quqb2uAAeu1Wg95aJkyjK9s122o/eSqNwPqJpwnAE+DPgVofP12tP5LQP8KV0MK6a
	 7MMT7k72rOINbOB0nY5ioTnAMU5IJbmn1UFtSFu1pqcUZknTy7Vgkw8fkNfrFE8DSk
	 rUtilpw1N7x1LftTNTae9wISfOBd5JBErssUj6u5ClG9KLERr3G/CMsygqatCd+4nY
	 h+X+u5FLBOr9ikBgjAEl5MY5xgPKrjgTA3aIxH86ANIQn1yt3vXQ/1vqZgLl6KhUhW
	 Zm18eJAwyyXKo8t4PTSryFSqanMqxAMPJ9GSUbiNfnFAsvrea51d3RjlOVV1xgDwap
	 fflkDJjIWYVSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH v2 5.10.y 5.15.y 6.1.y] net: qrtr: ns: Raise node count limit to 512
Date: Mon,  3 Aug 2026 16:46:55 -0400
Message-ID: <20260803203503.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802213352.3885294-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260802213352.3885294-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 02, 2026 at 11:33:52PM +0200, Youssef Samir wrote:
> The current node limit of 64 breaks the functionality for a number of AI200
> deployments that have up to 384 nodes. Raise the limit to 512.
>
> Also, the backport of commit 27d5e84e810b ("net: qrtr: ns: Limit the total
> number of nodes") to 5.10, 5.15 and 6.1 dropped the node_count-- hunk in
> ctrl_cmd_bye(). Add it back.

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
