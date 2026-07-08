Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693042DA48
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527494; cv=none; b=Jqx4qfb6leYL7v1stdbt5kwN4UEOXZuM9QXE/JoSRN7JINb1nA9dlRhMI0Bz2TlbdCubT35Hz86lh95Zkm8jvGXgVS0pTrkDJHiyCjssLN5rXE3ejwDMrgau7PRH7y6K4ZTy6ulhZrgmxyOQlo6b2H5UPTv7ULKovHSJbV2oDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527494; c=relaxed/simple;
	bh=I9ecD7oTEnIAJL0N+kY/POoX4ghv4WJW9JQDHx2+I9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfRLGwg9LzocVHGMMeXtojOhySNK20NeDmco4v6bPFDAhtg6nzSZD4AZTUEJ5xlf8Wghw/pYyDfIEG8nx4slMDjdE6+CSYDUNd2iW9p3cf2ZceKW9VggAdgbCnUiWfKThPJ08aZyz+hy3fcyMg2m9tS1v1f1OLFscwYZxOF/5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLn6gDMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLn6gDMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B0F1F00A3D;
	Wed,  8 Jul 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527492;
	bh=5HJScMeCJe2V3I6wp4M5Sd/8j1OXpe/dWR29Mr/0ajI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLn6gDMdQ3ze4VISZjYydhAXRj/cWGBDmqp2qx0QKe6ev95D36RasrQy6Z2zWcvwk
	 0STT8vn2ditcQ/DYbXQybO3Ql67RCFSFtc9Alr1DrSPpeGFxWkMXZokI7mTIblsZXS
	 RcSgZF9vrf3sqRuwVHwnUSOR0fHN7tfz2SVzRbK3L2bppt52rshY49wRRedd+mzdUQ
	 ynQN7tsWXLT0fSwPD8J1J8EItiUmvADQMJeYrHd/+O9ZoKN8f4DW9A0btO3OAUDQwV
	 jKh42ITy2IkldTfKBzWXEeZop4mBdThJqpV+roaVbvQ/a1Ww1YvKP+g6ETQjU6RWYk
	 c9dfX1Zcsc5sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Darshit Shah <darnshah@amazon.de>
Subject: Re: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y] KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
Date: Wed,  8 Jul 2026 12:18:01 -0400
Message-ID: <20260708120503.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ak2B3ewAu6g7hShc@dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com>
References: <ak2B3ewAu6g7hShc@dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 07, 2026 at 10:47:42PM +0000, Darshit Shah wrote:
> commit f1edbed787ba67988ed34e0132ca128b052b6ce8 upstream.

The backport content itself looks good (the asm/unaligned.h swap is the
right adaptation for these trees), but the mail is missing an in-body
"From:" line, so applying it records you as the commit author instead
of the upstream author. Could you resend with

  From: Sean Christopherson <seanjc@google.com>

as the first line of the body so authorship is preserved?

Also note that 6.6.y already has this fix queued up, so the resend only
needs to target 6.1.y, 5.15.y, and 5.10.y.

-- 
Thanks,
Sasha
