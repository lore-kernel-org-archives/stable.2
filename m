Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD174119FB;
	Thu, 30 Jul 2026 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410361; cv=none; b=DrXFeCBQYXhRc4+8QVeWrHFAUHxNocWl/0gbPeju6qenM/k/Y0XSRoLy277PqQFl+5gihPJAj2glweq/tpOFlw6xnH1IPkk0bXcQQ9xQwOD4TWihgnM8VaDqwY6OdSapP1fLMA0x364Kf3pVhKvWN9SHsjaD5Q8PD95b2zHKyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410361; c=relaxed/simple;
	bh=MKpxfHFHPsyOX3Rjk+oVF1xtSVvy4jRGxDGSV7D5roo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETZKymZ8g0mMzQl4gLkbEIkd92/BjmB1aRKd/RXHJfx/dIYiESOUgfhvzMaXIJdS5H3uLg+L2ivpgvc8tj7WF4xY5cb8YIH82iv1h0hbQVWkg4ylsYKwaQ2Ga3Ojknuhc/HbmPBcocXPDrECN7tKcxQn23bt9152mQeCJen0WXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Drvqev7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Drvqev7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E69B1F000E9;
	Thu, 30 Jul 2026 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410359;
	bh=v894Qc8ca6RTOLAQTJ2UOSO6IcrJXm55jPwPgzd6WkY=;
	h=From:To:Cc:Subject:Date;
	b=Drvqev7SWot57BK/pnd/Cwuk58y0Q1jYZ6e2ABVSurHr89I2VE6owB0fGo8aNjqn3
	 R3Iy0br7y305+TuSMItoiYoh4H3ZTHR1LUSQZBol6SQBHre2EElQ4xARn3q7LwX4mS
	 u1T7hgbbdz0vojeWiPLlNSIGjbz4KNuEkk+D2iOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.100
Date: Thu, 30 Jul 2026 13:19:04 +0200
Message-ID: <2026073004-dividers-evaluator-22ed@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.100 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                       |    2 
 kernel/exit.c                  |    8 +
 kernel/signal.c                |   10 ++
 kernel/time/posix-cpu-timers.c |  176 +++++++++++++++++++++++++++--------------
 4 files changed, 133 insertions(+), 63 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.100

Thomas Gleixner (1):
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

