Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B433B9930;
	Thu,  8 Oct 2026 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438980; cv=none; b=uwWS3nd2p24iOlcMyyPILZwETv43atvR8jDI0WO/kTiYv2/Gx9gAkstCya2D1BE2Q+hhythlHb/+RXtBeBmrHpSganVQWOPECDhmh6P1LmRcVQO/QnOSTVvxH+fxt6f0oFUcYtzzIPcji4I1WWcBrv76jWMdBmqDWMPponrLv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438980; c=relaxed/simple;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu0U10B2dMo3DSi2YeW62ceS+YzplKjy67EmeaRRNmDeDhBuNNoKNI4zgQNzf+8fb/CHdHhZZqbzIVsLph9/O2uIbdHL5tS2h4T/zau4F2hDDgw3Zh+EzXjVfefqdAgKQT+VBeMXkPkdzz/rYQw99jyGDosZd7pa4f9f+1B9h9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoT48t5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoT48t5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C031F000FF;
	Thu,  8 Oct 2026 05:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791438979;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MoT48t5sVzAyL6W5YLn2of9GYB19+j0/eAmRwyFFwMOrvJ65vFJuVgHI6yng/jxr+
	 LMTaCdvQ04wGIChcmWYGshD1vb5HOAgk4N3WF8UCkAAfWCidG9s9fblaXFyGb/f44B
	 c8YeZYxLxxDFDVMuQggqj8qIEQrcsAuD26NtSMmelRzsrI2VkMXgazHSMDIwZtiDcK
	 ZVbWZ8rO4KLViW7+BtOQcnHv5seRDX/vMwAFKHcdKdit9ZcsBfJNBBaqSFDo69xJo7
	 5kjthVZgjWEgkNRJbr9YDfS6WcZTehwIlyWQVqOQVtxoJX4gP7eiqw7qcaMixDS/EX
	 PUpMdB39p1q3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Helge Deller <deller@gmx.de>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgia Garcia <georgia.garcia@canonical.com>
Subject: Re: [PATCH 6.6.y 0/2] apparmor: backport CVE-2026-45893, CVE-2026-46254
Date: Thu,  8 Oct 2026 01:56:11 -0400
Message-ID: <2026-10-07-2-daily-reply-0001-apparmor-unaligned-dfa-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007204226.47033-1-artem@trailofbits.com>
References: <20261007204226.47033-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
