Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B619435EEC;
	Mon,  3 Aug 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790030; cv=none; b=tNPEKgrUh95lRADMxO48LZ7ZBne3bUwOFCTYcCjcEFpDUKhFzCKQn8sWS/FyH51LpxmUQRAeO6tqOxAH/PCg9MAFl70af96hdlCEynsVeMiDoXAT5Cu79njzNGGxOvSjYXJtPBu7L8jT9a3dUBoxkHzOA2V2SfNJ/4ynzCjbzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790030; c=relaxed/simple;
	bh=/QgB3jtisskJxFKW92yfJO0NpIoT3PtBoD3VMzK+axs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNrk3m0ZDbQ+ntWZfqihZjXc/YxuXQ612OuWBeBVFNV6i4UBj4GAjpY/sea9XQZNc/hwYl6Ln8vOqgDQK5vNT+A5tnIOcGeuLTE+onnRLz5lFOLajs/HzIdudOhrPi9qZTTH5JXTTwgqHdZllkn0y4J0m2cigaok4ACotrDtZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXgNvXu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXgNvXu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D78A1F000E9;
	Mon,  3 Aug 2026 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790028;
	bh=0ro0ZOzuINq+G1JR/FDaEUVjJk1Y5xMtbQw3/UqOQqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXgNvXu7vL7JL+29vQ0Sjf3NzVOpmDQpHsBEQP2Z6dMXXtG5Crd6qQNaYJc82YKoV
	 nyI4e3X76krXYBSjSK4aecv5EEihFn8s0aWKkLENMSghrlY61c32Za6OmJOdDcVPv5
	 Itso9F1xzp/nLrCqkIvvklLOubF6u3liDxeGUadOiyksa+7+fg5saIzRv6/ELNK71o
	 s0kJQzOkduDu0BXQligCJ516P+kqJXsftYvnZGO5vNjDTOnpFnydPAuq60xp5REi3p
	 96nX9CchF5UX4Qidr8we/NVJmVwyITT0IR+C06Jv5m7m3Ypg8FUDgr05Eigsltk1nX
	 0fI163z9i4B2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 5.10/5.15] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon,  3 Aug 2026 16:46:57 -0400
Message-ID: <20260803203505.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803081414.729798-1-alexevgmart@gmail.com>
References: <20260803081414.729798-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:14:12AM +0300, Alexander Martyniuk wrote:
> Channel configuration that was duplicated in l2cap_sock_init() and the
> various new_connection callbacks is consolidated into
> l2cap_chan_set_defaults(), which now inherits from the parent channel
> when one is supplied.

Did you even build test this?

-- 
Thanks,
Sasha
