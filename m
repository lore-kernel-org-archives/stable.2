Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C2330675;
	Fri, 28 Aug 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899989; cv=none; b=afMqprjpfuU+vokt8G5cFhI4y4ugZ7M83tLtoQctNOBW4h/6UIoyKFA/neJFp+45qurU1aUohV1mINfzF+59vbqOjMjwojZ0I1SQLjzyaBUhOPftr8xO4M4p6BuGONem6ttg2Q8KOffkbUs1i06qqhXnhi8VfxO9606yd37uaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899989; c=relaxed/simple;
	bh=W2U4qGrNun4G94mUR80gAY8Hn11/m8uW4jCVrYONm5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4j9ulGo8FeAVhtnGSWK4jpWILCBLCG/nokUMioA61Ra12YTzQ74Pc11Vy/kfRbAsxtNyIRFUmswQw80jSuW8dczKaIox2GepZ1CFb3OlEv4Q8oprG8bNyzcxRSZBTzRHkLgQdO57DyXn+YCMD1MAlu2RzSt7V7HrlAPCJiWy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bg5Sr4+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bg5Sr4+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B685A1F00A3F;
	Fri, 28 Aug 2026 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787899988;
	bh=hFvXOF1GI1ZjTPZI+doNFzDEi8WqnfxLr7ke/eChHmg=;
	h=From:To:Cc:Subject:Date;
	b=Bg5Sr4+OLTRrFIa3nb8oewcCfaKlG9gaSB28pvJQoRmApunDCDTXTVAqVTIvplEvK
	 aGM6XCAryvvfixBw0gLYctmRgAag7XDX2QphmXcKrOAqwPOD4dbkN9OgRPBETApl01
	 szMC0yNSVmw5oO9AtDOZzXwWvuW89apUfioaGxrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.268
Date: Fri, 28 Aug 2026 08:49:19 +0200
Message-ID: <2026082819-mummify-reconfirm-f189@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.268 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 5.10.268

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

