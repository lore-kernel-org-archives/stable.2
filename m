Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7A330675;
	Fri, 28 Aug 2026 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900000; cv=none; b=uWsVtphyoCoBT9kb88fHQSMFENfiFTPntqoaFg/DU0TapdlStKysFzThhvf4LxrbqllOfyOfiip1qVqDZO7fJl9nOyCoIbQxPauK/s1KLVip8Xpj36vupBltg5JZ79ZG1f6z2YgyYF+zOFxnklNP33XUKQBbeslK6ev1oXS0HL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900000; c=relaxed/simple;
	bh=bt07MTFY41RJdifvQ47BgZuK7L7wNIIOihr4gQxL+ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmTeU2bjDInbQJJjJhg7hDVdX6lFitDjoNSmo47NLM3Bs0EI+Unhnf5MsqgW/AVYYGMFT3frQJiqtiRGcJtjc0Q6IMN6XYwAuAJbmzcMelU4uUudfiyJw7dQcuUlXeDq0jj9xvI+feXj9ywIiwnNzT/jNWb8Guz+NYJ4AiJXb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCcDg3fH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCcDg3fH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91C71F00A3A;
	Fri, 28 Aug 2026 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787899999;
	bh=TcydSjtBcz/fARQm7asalJKa5Hc4+CZXloIGFgDjRXk=;
	h=From:To:Cc:Subject:Date;
	b=RCcDg3fH9j6JU/JDP1O1uLow2JwU9JkEexBMkmDQfCHcm+VMKlm3Knqn/gxjBI9NP
	 DduyuQTAJoe8Q6M23sIRdly5852A5DA4GYlzNYS4BcbfmMIzFcAd8fcO/enoeqcGfA
	 Zf8YTbTUwZUTumfLs3zcr0C25b+mKId2SPLC8dvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.186
Date: Fri, 28 Aug 2026 08:49:32 +0200
Message-ID: <2026082833-disclose-numbing-29e5@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.186 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 6.1.186

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

