Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F84071CA;
	Fri,  5 Jun 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688256; cv=none; b=tA8P4uqkwrGNVlPj2GPClG5hTdbdJ0v6fVn5Nu39+AudAvlxWRJX85V6SQap1qq6tNPDgR4C6ljqmRuKB1v2v1Cy5+VCHgScMJsf/01tt2v2FCpBV6fx+UvGhQs4Q01z+kq1YcXizqBiNPWr2i2/vBckmV+J3alnRjFCtIBjjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688256; c=relaxed/simple;
	bh=QAGGheDBMNLmwJKMLh8LQmLR+7oZv2TpMSZySeZEtRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNcPWth/7bRPrlJ5Ov+SQhNdU5bu6KQvIOkA2DyMfe3mlgSgUF7ScDVijnygND1PT+5moePiwaozjh4Frv2GSlpdZ81KopfPjS7vm8Dh2VR8IeryjKEU2nqiu7tb43JhjYU/S+2tLtS9cp4dE4y8MHs5HwkLtazBsdJyieT5OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYyOOSuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYyOOSuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB2D1F00893;
	Fri,  5 Jun 2026 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688254;
	bh=mT5UCczm+tRWl8iiLwuVVtSYGCFek8xY3WuKhnZhn+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYyOOSuMVzsAuVvwhnnau2Y6YMq/0waxI8rfJanzjgyPU0vzAipI2izDnlTomgE4U
	 YaDDRw4/HtJqX5Rye6zdj4nmb71VJPeLOP+TjK69zakDj0oxzBPcg10AAVG0dKT7iz
	 Mwouqad2WWMW5Qy4SKU6DL3WlJgyzxz3u7YxmKK0VUgl5GNYoFjiecdvk48SSgbiwW
	 2DdmtKaGRC4a41viCrs0vGT1PHnWUz8Kqa8hgE0xT/2w9ye4e0YT9BxRHDCOFF/cNK
	 NBuZRCnN96Klsxnv6b+MHOlFdUpNBmBHCRIsVvrxOBQ8nseOMlEXnZdi7fRVRX+LLc
	 vDfUU0TbPsK1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	David Rheinsberg <david@readahead.eu>,
	Johan Hedberg <johan.hedberg@intel.com>,
	lvc-project@linuxtesting.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 5.10] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Fri,  5 Jun 2026 15:37:08 -0400
Message-ID: <20260605-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603234343.445-1-vlad102nikolaev@gmail.com>
References: <20260603234343.445-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10] Bluetooth: hci_core: Fix use-after-free in vhci_flush()

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha
