Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED332C94A;
	Wed, 14 Oct 2026 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941267; cv=none; b=IMuZt5rMdqExNX8gnzY+fkbN/3jtYIgeZY84uC15E8E/laf2hdNKliIVDFAHI9LR/4PvaIhR0pqPYWZkPq1hMakpnQrpkSZdGMAhN6l0z6IjhQ54Bxt1BPiF0VLA1IEe4yG9/7WEohBmFy3wP7TaHVTDyfqwqyJsKDndGMDMXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941267; c=relaxed/simple;
	bh=Yt3cudUSyvmrvEZFm2WltRnnDfmS8+1ttt+mWIO3HbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYO80S/LDqhgSi+6Z+Jh+R72efSPDd/u5ug4x2CNpQ320TxkWM432hfp2DexuJLZdf58NccFVCFgSA8Bvlay99STp6KCEYObcH3Fblc848Fs10z6ftak/8NK2+rLJMunyNAWSpj+RJ72Bfoobqa+y9zwQoEg323IPpClpiE6sp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAorv5bV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAorv5bV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B481F00893;
	Wed, 14 Oct 2026 01:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941266;
	bh=MVd+j60iEaAuvc6F+U/SFgTeVDPOvIpqqXN5ppAYSGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAorv5bVuqRqIK5nGE9Q5XdSTidZrX9qAV3dCjCdBfMFYAEOchTMj/WbR8ciP/rhs
	 S1q2/17STP7IBYKtmZqrjHch9/Fyxn852fNpEXiQa1qYKjEoeheOK8jRGt5K0YX3If
	 n5Ny+8cNfAohje5zBNbVUV4VbLjC9vtwjdl6DNRKe01vX3pHrZnxY+xVZ4W9tzVSLi
	 U5xbeTKy/foveFkZW6r6cO/w4OzChutXjkjOuq577tGbskC70nwWPSmR5KhpcH9AmZ
	 VyljruPCu/6ZnplxS2rAjvqZf8iFmyU3Tu0qvJRaFl6zlPUGauczg4aZGq9tKUW8vt
	 QBjg3JN5/dnAw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [STABLE v6.18 1/4] HID: steam: Fully unregister controller when hidraw is opened
Date: Tue, 13 Oct 2026 21:27:16 -0400
Message-ID: <2026-10-13-1-daily-reply-0026-hid-steam-6-18-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091138.526840-1-lee@kernel.org>
References: <20261013091138.526840-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> To avoid conflicts between anything touching the hidraw and the driver we
> had previously detached the evdev nodes when the hidraw is opened.

Queued the series for 7.2 and 6.18, thanks.

-- 
Thanks,
Sasha
