Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34239DBC5;
	Fri,  2 Oct 2026 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979523; cv=none; b=AAHmVVVRDbP8VoBRhljZMrqVazzCZYpxF/Y2lvPC/8l1H15WB3rFvfj2iWRvbjnoErbZR6gB99jjnTZjiU5P0PgTrHbyaBMe81YytohF+lFFyK1Sdb1C9VGMlvGjjdGqpVkl1o8TJq2M0ntooc9GCxCowQ5kfvypRQKebIYHBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979523; c=relaxed/simple;
	bh=Rwsnfu6SxJy9nM+qcdf+GkHl8h7AZX7YrJ2UU+iHvqY=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=Haa0SwBJDaDPHUYok0OLmFd6l3m4j14wshfqb0TEm4ju7ZjQI8GBMmkDQ96nUtb8vgtI3gCmg+j2+Htd9GGQXqyFYAccyBO7l4Iy7cuYeTNoRxEYs+rLcZ3AbsKMd2Wf63k1nthmdQOtnlqg9XGeMhMXmAazZng3+jiiokyOmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rPMpDSms; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rPMpDSms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790979522; x=1822515522;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=QRc2jsoiNRA0qmzpUyGoXZATx6Osp3I40yobfvG2LLs=;
  b=rPMpDSmsktmtu1VSlmoPPbCjk1CeB0bewyAtidO8ZclSKPezZGEMfuPh
   FYZ2qP8nwHE9ps6azrn8ON3C5Hg1Ar0Xs2GrVsM2/vUxbY0H5BAqvUvsX
   giVZPqQVbf2Eh+bhfGggpM/87pzMs03INbpY5FMFlnJcQRF5/k4mL2k/1
   5LyrqCjj3uk01CTsVk3tszcK0Xwy5UNo+s9Ti+QB0JzEBx3WGqMNVPzJl
   iNKOO+OEOeslYqNe5iHAHBw6aa8Dpf/uBRy4+oEMJvhx1dT90k7E3r4SN
   Fquih2tZlNftpMx/zkV21Si8RvljThycSjbpArPLO9UQuJHc5/Mlzw0Zt
   g==;
X-CSE-ConnectionGUID: T65rDK6LQqSViilanIomMQ==
X-CSE-MsgGUID: rSlqISRuTuaoFFJzE8BwLw==
X-IronPort-AV: E=Sophos;i="6.27,136,1787011200"; 
   d="scan'208";a="30032284"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 22:18:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:17484]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.224:2525] with esmtp (Farcaster)
 id 3a741ae7-f0fc-4e92-9463-49bbefdf02d0; Fri, 2 Oct 2026 22:18:38 +0000 (UTC)
X-Farcaster-Flow-ID: 3a741ae7-f0fc-4e92-9463-49bbefdf02d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 2 Oct 2026 22:18:38 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 2 Oct 2026 22:18:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6.1.y] net: ena: Add validation for completion
 descriptors consistency
From: Arthur Kiyanovski <akiyano@amazon.com>
To: <netdev-bot+sinfo@kernel.org>
CC: Artem Dinaburg <artem@trailofbits.com>, <stable@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	David Arinzon <darinzon@amazon.com>, Shahar Itzko <itzko@amazon.com>, "Simon
 Horman" <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Shay Agroskin
	<shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, Noam Dagan
	<ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
In-Reply-To: <179097411333.1402591.9823193935815787447@kernel.org>
References: <20261002204534.26297-1-artem@trailofbits.com>
 <179097411333.1402591.9823193935815787447@kernel.org>
Date: Fri, 2 Oct 2026 22:18:21 +0000
Message-ID: <179097950193.1335.4142870959256103753.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2026-10-02 20:48:33+00:00, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


Issue was real, and was hit in production. When a faulty device creates
corrupted descriptors this commit stops the corruption from propagating
further, and reset to driver either fixes the issue, or if it continues,
helps AWS detect it and replace faulty devices.

