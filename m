Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DC38423B;
	Thu,  1 Oct 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878145; cv=none; b=PVmpO/tHG4dzjL1q9wPUcNcZU7dxt5gT04bDwb0EBrKmmknavTHOpiuOJBuaE7k32f9GJlIrc/EOEIV3xQ3X1sIJXW9FphQE/K2cNWDv5YTygfM6jNAV3bnyNs/3Gb9gssg5wwP6UFFs4A/kmEGdEcJKoxb/iGgq0qLX5MLP8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878145; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iax3Bqs1UemRT4N8KQGPNsSu8x5Q4mAyavDXKdH2gPlQXH6s+pXHrlYyMDnMVThjF8yFIOptXw5JC3+2wLFymQKot105MstQQokNgd6T1c4ykf9MNoCKbxS9NdMmuMIPChbjOtbyTzPbQN02jlz+XHFYD7WSSSdm+IuDYgRIYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQHctUju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQHctUju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0C41F000FF;
	Thu,  1 Oct 2026 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790878141;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQHctUjuUNpw6LkyASUZ9HSFteDzJeR38iaU80Gktw1pGFWCLZSYF/YGGSZzkMish
	 CI0kKn39Tn2wmkI+JdM9cAL2ebawL6a2NJ098qLlJdRUahDEfM6lZIJ2T7cKU2GPdw
	 0NXWPu6qcC6lC27LkOhpl1kvAZnWG931UKFlZcorvNlFUWm7/G1eFEAK7fLlnc/7fJ
	 bxompRVWn6MverJHcn5hr7Mr9YOD8mHDYQfyQ30PHDkvD66s9hpK9WFw6pnT0nrHtV
	 Z6y6MF57oKO9tCDgYWbN7c8PKgyS1Tt2yub8EUxI6/JVTGEnkgZXKRPXyw9eL3m3l5
	 dA0HXVrqpGBlw==
From: netdev-bot+sinfo@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org,
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net RESEND] net: fec: drain PEROUT requests before
 canceling the timer
Date: Thu, 01 Oct 2026 18:09:00 +0000
Message-ID: <179087814030.1402591.9699379066974975442@kernel.org>
In-Reply-To: <20261001180258.4054391-1-mhun512@gmail.com>
References: <20261001180258.4054391-1-mhun512@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
