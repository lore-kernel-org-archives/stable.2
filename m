Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95416F288;
	Thu,  8 Oct 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463568; cv=none; b=rofLYya5UBkeGfYxMgNaAxDATZIgJ7+YvO6VlYtcQVX6/3LcUocLrfK5TmK/Yll5wjRp3d84mQGoyOJCrn1fMHJowt1zpXd2P88yEIZTJysgKQrZkMC6Dx39uZcR9DurjxeZlug/ortNnIMph1uoiDMOTcuhO3dxOObMjFzszKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463568; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7hyG7v60VHimPpWdUXchxWKGb+gZoEko5QMoMfor1GDetTZTWD2Fj8T7+oE/UcP1UXYhygpamZyJ5I2R0ZKLxcTEnEU/vWAowAxXT2FjRvRNNB4R32pKhfb2sLjcaEvzS4Ojf4eQhceWLmyOcna+ao1L/1YDzyybZSit2BIbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBqSq/Uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBqSq/Uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB531F00893;
	Thu,  8 Oct 2026 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463567;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBqSq/UfhNLMB/2xiNjrdCV8P6K5rMyyNAUapZyhEebtBml9v1PAZPDPbBfyXVX24
	 OJ82GYjs7wzkxCZ4z0zVpMwrgTvWaRYMjKyLqqwzIv7MQ133AdZUtSUjX2ZJi/pz7V
	 xfd4VcldWlVVcJaSIrcNGgI43lbG0aZ6xei7HcjkhIvtWokM3I8YbNgjdF3S+Qkzr+
	 +Ij831Q+gK9q+mUlVXGfzwUSzFD/Q0oxz6QhhfCjux0jXL6+CBm9ZVip4zcsvH+e1r
	 ozVkGc0w5RmG1MHNDDDahQzTelkJ79FaL26qrmKD4VFcF3TjG79TVzmlqUq865+ZSR
	 4T/L8zJC8Ct3w==
From: netdev-bot+sinfo@kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
Date: Thu, 08 Oct 2026 12:46:06 +0000
Message-ID: <179146356621.2527009.11001901701574636880@kernel.org>
In-Reply-To: <20261008124106.665014-1-Jason@zx2c4.com>
References: <20261008124106.665014-1-Jason@zx2c4.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
