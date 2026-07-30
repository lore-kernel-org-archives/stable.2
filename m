Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9541168C;
	Thu, 30 Jul 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410355; cv=none; b=oSfoYN+4Xa3Ycn+2q99SsnUXemH1+sJylcI2qvD7gXQsfOIy2t/7DQKyr4x2yCca71v2EVObzIvOS8gT1Q5TmiUQFDIrtwBlT/+q6W4eNld++nzjVoh0bGk/eWgMQ0iysCo6LsqJmK5A42pjQMXJer7QocmZ6LZu5mi/CDqwpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410355; c=relaxed/simple;
	bh=OI20NA+v9jPHthyQURAEIZtAmAdIsvvkPRoRc1mGlbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaE/8kw7RqMweQjiVd1AaIlvpyb/ppknrbI0bNCpMNUOamE7kp+xwJEdww/S/fRoEfJh7cXWrEWIgatL6/RGOug0yyRr1pDCP+l9csqTDBczQ7G1QLCTfje9Gf74/9PUJq7tQhSDaP4aWhcbwxjEQtVNVgzApE8alh3s2zQAnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HpBD/1q9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HpBD/1q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520A21F000E9;
	Thu, 30 Jul 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410353;
	bh=Jlc3H+hgvA45jXxOzjKsi7dgiQ4XV+vybGpYjSCFAb4=;
	h=From:To:Cc:Subject:Date;
	b=HpBD/1q9Ybs6Kfu8EjIkzdhXq254eFGxZvfaHfZDSUCML/CekvEhj1DzEzuvqBFUr
	 qfjovm9D5vLHak94V/mnuaAfYBQeHx2U5Y8wpbUqcznNEIjO1pY+Arfv7UH2gRcjed
	 3OUpAkvo/BugyHAeK3YllkN+uPlxtCbIrs9nb+k8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.180
Date: Thu, 30 Jul 2026 13:18:49 +0200
Message-ID: <2026073050-arrange-masculine-6fa8@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.180 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                       |    2 
 kernel/exit.c                  |    8 +
 kernel/signal.c                |   10 +
 kernel/time/posix-cpu-timers.c |  212 ++++++++++++++++++++++++-----------------
 4 files changed, 144 insertions(+), 88 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.180

Thomas Gleixner (1):
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

