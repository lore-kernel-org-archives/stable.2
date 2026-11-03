Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702103;
	b=5hs/av2WnhZuWnqKYP4yqstNZXvhwAHkCTGqYB2rofJlsVgz8+rw6q4BBhC15IglzbpP
	 LTk0zlBqL9gk0W64XxUyYhLIHSwyblEfyGNA13MnECikKvm+Xv6bpEuuW/UacxpU34DwG
	 G7Sws0OXkUclzID1N4JUqBdZuOsW6tyT4LgQwjfP2kdzSHJHTFyrz/Lv0YPCDv6Ar2Dsw
	 v+P8V/oiI83Uk16fswnnJzc+JlMB9UsrhVMU/OKLWu1kL4vVC73obN4Z7zLkOS9f8Ir2E
	 bYwt0/YTr2oZ9ttLJDJKrUX+ecb6FbyhPqzXE2daegkozbRinl8CXml66nU0TKpP2fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=yeM4WYHrmuhSjrzw3IZWWUvsOCXR4c4wbwU/VbHOvVlcD1yLsHGku5hzs1CvobkMeXKs
	 IWPSS6DpxQ3EMd4o+Qap9E/KPviO9aqIrHklFr9JD7ECeNWxZVfeBjAy60cE/pYx+I7Oj
	 y0MnSQZnpjIFztnVR060hSnaOgofOAA4OOuzdM4UEFcWd+bQO2xMUkctGLLOdQc0Jp9Pq
	 0zpyjVLqDo7ZQ4sKcu5IZrwIxvsXY8YrrVk/0IUFC0+fR4cegzQb8me8n9Myp8HkBHIB7
	 Xklb3j1onf+0kaJ9QhAgXr/1O2Buou7gesXimDSejEWr81ehua0UnigvPQtSUrqN2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RS39A+4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46D607FA0B;
	Tue,  3 Nov 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RS39A+4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A91F00919;
	Tue,  3 Nov 2026 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702102;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RS39A+4Er14ifQ3oDlimg/W/aG6svZur5kmIKI2S5AOza+7ES7zOtLRZYgywbfJlP
	 17Qe+a7lhqy4CvxcOnYQC/epCVknRuDnLtNSTYFcpjVW8qSm0TIoSjiH16+dm9DYEi
	 KdGuTaV/7w9x0Hj1aqXZydRGg4QbHoS5Lk0OOyqBCxZ5rWD1fB1qbhOXlPPTevhw1C
	 Us/z7V8n2ULhfydFBR6+cRKXbKPyrJnjvGSDRjIWQ1LqNk0XXQvaeudVByNtzKWe+e
	 vADFiO0wL8I/UZhMklgm5nFhBCPXdOMQxHc7DrddY9WbozMSI2jPdcAZRt6pwZo7Ac
	 CgItuOndawo2Q==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: microchip_rds_ptp: unregister the PTP clock if
 init fails
Date: Tue, 03 Nov 2026 10:35:01 +0000
Message-ID: <179370210131.488859.12378000599790705944@kernel.org>
In-Reply-To: <20261103102900.1340854-1-vulab@iscas.ac.cn>
References: <20261103102900.1340854-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
