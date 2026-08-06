Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536B388890
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038599; cv=none; b=BUb6rBq26pX2qRXos+/6+K65PCagorTZqvQaKAUXxfC326UK8YUQiVfSFpQ4uWGe3znvkXMdFOoL1HbP2snAS0qri1L0UgzLRdVQA5VV8ij3ZuvD9RJ9wJirRkQvyAdCvnGX05e2f28BaCdU41rBHDacT7D1w7mPB8/6AimV1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038599; c=relaxed/simple;
	bh=1oX4tOfq6gGTNq4deqaaBt/QJEPCG9uADRBByb/E/Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYwi+3iz+F74Hv+N2lJX7lLB5CNhHsO3qGl6VYfkxVnYxdIdyC3kzCSYtZ2zaZFKlhliWBdpCLQ/grkl/uRPKc8t4z+kbfhmTAtGhZJyEChk2pFD7msFRTPMFneIESDaZFfW+m/XHg7nlb0Qd+IV2Mu4zytGSOXnYvLeZTayfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWxBIfhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWxBIfhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8E91F000E9;
	Thu,  6 Aug 2026 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038592;
	bh=5dxQ4XaPOqJufSkc16jm7kkJDz5p9oOIKtP6WAs6p18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWxBIfhBE9CZAn6px4G3jXsk0uVFSqt+npn9LJLzDYD0dVQOPCNf/8UcbhFzY7UdK
	 iWFTfaFz3+Xgl1+w+IQqlVzpk9/edcTvMas+073L191uqrSfaschuvvMSgXZqGPQP/
	 PqOECzlcmsMG3/WVD3Ed9Y0o+MKSRqXI3tbeipfHha1TMmNtuM7UWZgxp1FxGhNZ9V
	 2iF7wy/JDCMAWmRRloCtzuCTQ/JL5UV9ju1JWN46TfGwW5hHfdVSM0AEZF8kVuhvjY
	 Xfs5/zBbLio1ugqSjoBvymT0tXiFWaW1UjWaERrORwQTURNwk+KjsJA5W1j/3WBsh8
	 zw2BOoK46Sppg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marco Elver <elver@google.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
Date: Thu,  6 Aug 2026 13:49:38 -0400
Message-ID: <20260806131000.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806005214.179730-1-tkjos@google.com>
References: <20260806005214.179730-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 12:52:14AM +0000, Todd Kjos wrote:
> [ Upstream commit b66774b48dd98f07254951f74ea6f513efe7ff8b ]
>
> l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> the connection is torn down while the timer is running or pending,
> chan->conn can be freed, leading to a use-after-free when the timer
> worker attempts to lock conn->lock:

Looks good. And I can also queue up d38eaf611839 ("Bluetooth: 6lowpan: Fix
using chan->conn as indication to no remote netdev") after the backport, but
your S-O-B is missing on the backport so we'll need it first :)

-- 
Thanks,
Sasha
