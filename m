Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DC1EFF93;
	Thu, 24 Sep 2026 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209267; cv=none; b=vFo1yrR9TzKDEUN6BZ7YHEa4Co7x0F6g1fvtjS7yCmpSdlftcDET6PGf70tTmuwxMgtu2WstPRx01/KGd/hDI/Jbnp8wxxSie18yWzdQcsTeIbLK1lmeFsrELdiatHQhvt7vq67SyMjFPTwUvZ5lAS4mmxNG2ZfQceBmOYiZMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209267; c=relaxed/simple;
	bh=N1SzXhBwD+iUl+eXWAnkSkObvLaafpTF0uhEY/uZ2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tekDLeCYosU4FTtNhmUYDPUu17HQFnW3Lxvui7VzgoW7j3s/niR4nTvRMcrYGIVRKD5eMzW6RSx+XYIrDrMayDnyeD3KJnIMkons2osogApCEVqQqlC4VT2bQzDTzR+4DwurvDnJJmywQdYlqDQq0LjY5iU48RdZzo3NNr8LXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB7J7c/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB7J7c/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6DF1F000FF;
	Thu, 24 Sep 2026 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209266;
	bh=fyjn0myBrPKpSh/8yzFQ6bTCWqQp3Ipcz/x/BHY0n4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mB7J7c/7Q6bLLZ4CVRjdVk2g2JEHDTFz3D7YAWasbxOUrevAILQA8ruOk8yaJnINR
	 tWkGZKDXaJ0+MYQwNBtgR5K7/pIM06nxW8nu7a7gv3lrtEcePEqsujdG50zu7GBOJ8
	 YBP1FkHrfak0ADKGZMoOQ7UqXlvA2krMrWjJ/p0XY/4lkjDleXVRh75Lip/l6zI6zE
	 zPevaBmjSE9+tUdawSODRagZ1ELh8iNqgZPLylLVw4EVlyjTR7NKN3Cg2RNMEHYFLG
	 PPqu0adD0zguuGiVKmU0OtvQRVcdxTavY2dGC9gRqUKoav1NMKkabn2vukp+d7RJgd
	 3uKCgkhPNEPRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: Re: [PATCH 6.1.y 0/2] Bluetooth: backport CVE-2023-53762 to 6.1.y
Date: Wed, 23 Sep 2026 20:20:50 -0400
Message-ID: <2026-09-23-daily-reply-0001-re-bluetooth-hci-sync-cve-2023-53762-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194838.26223-1-artem@trailofbits.com>
References: <20260922194838.26223-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This pair handles CVE-2023-53762 in disconnect-all cleanup. The
> second patch is the immediate upstream liveness follow-up to the UAF fix,
> so I kept the two together.
>
> Both changes are already inherited by v6.6 and every later mainline
> release.
>
> Could you please queue the pair for 6.1.y?

Queued the pair for 6.1, thanks.

-- 
Thanks,
Sasha
