Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544C52759B;
	Thu, 15 Oct 2026 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066902; cv=none; b=RtSVFcrOLvXCqXDKxlFA0LUUuIDzccF/JYenxwhcn/35HxP/r8fDQ+o+jbMD/qakBasgj9eJEmb18ck+o0jf7sddTaLwRcEUN8cRFzeJaKzZVSKwqpjzC9zhxuvw/yO1YL2B+Cjj6FqkM0/VqnKmwncpeG4XWyAHYgFgLnxiKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066902; c=relaxed/simple;
	bh=a66mFgywPF+n0GZdgFeU8H+qH7pjNFUbAN45tBh5WGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyJvCy39WHyPSVzCpQbbZqh6unoRnKgmqeS9WCMYxhWCx0SjsIbYqXC+oN+JIeOkJfhbyQsGrMBEyhKyAFc7OF2+8SuBUFGcxtaUAM/cZ+UtcfPAuzfauEDpLwCMZXsOPBFhwUV22n8/s/pdrp9n9PU7kU9j1PHtG+U+latJGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRQylqu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRQylqu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E271F000C4;
	Thu, 15 Oct 2026 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066900;
	bh=s2DFh3opkhL5I9SNChhX3Tj4sbd7U6t4Jdpoxk881EM=;
	h=From:To:Cc:Subject:Date;
	b=YRQylqu0VrJA2omQ6+ineBjwykuTBGREd79ghFjvgeaZnN/Am26AnZwr6IX/Y7q/V
	 6SP6H7iOh7vq98ss4L530c8dkinIuf2who/y/cod3K7WkuqCUanOLscBdnfh3ihtLO
	 o7/mc2PGYsftSoSEcTCflbtXa+76/dlYI5rsQ/Y4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.272
Date: Thu, 15 Oct 2026 14:21:43 +0200
Message-ID: <2026101543-chariot-disinfect-8cd6@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.272 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Antonio Ojea (1):
      netfilter: nfnetlink_queue: unbreak SCTP traffic

Eric Dumazet (1):
      ipv4: free inet_opt and ireq_opt after an RCU grace period

Greg Kroah-Hartman (1):
      Linux 5.10.272

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

