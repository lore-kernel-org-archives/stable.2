Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC93AE1B1;
	Fri, 28 Aug 2026 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900025; cv=none; b=skXHZ41FWk8Ghb7fso9Snnf5XBGFM3tjKGl6LP+aUN8Wf6w/OmhI3vUnn1pODsJJtNtD+hoOu7CXizn4P/GlIdRlPbklPcGJDfNAS91M/F+yRj7CxIo1YEZvui4XEpl60AI89xzqwCOoSDUQ8B8di0IB1JRTchUhBxoVt60F7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900025; c=relaxed/simple;
	bh=irsOZzK5VhnhZh1phv80NM2cbUYdWKEvfvTce9zlGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5nhvkjK+2Vr+yUzNnLmdcRe7y4Uaawxk3hV0+cP7UTftmQrjIS5zeCMlmbvJy+7HYy7lncjjyWY3kajqcb65R8yKtVaf2AuEdDEFoYNfaqgYiBvFp4QlsNMsAYF8ywlaAXru8nyW8gk4aCQxRug8Phr5qF3Ctsio1A3slTReHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/z0hQXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/z0hQXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547BB1F000E9;
	Fri, 28 Aug 2026 06:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900021;
	bh=hdeb8JEw4vkh8Cgw1Wm9edTeX7hdrSj7MFM7NDEp7B4=;
	h=From:To:Cc:Subject:Date;
	b=o/z0hQXyyAnv+ML326tWdVj6K1XKufA1+tbeVA5Kd/EB+orGgUI3t+tarnTRttLY5
	 oo32JaGZ8gikSZogcqSPrmTAz3ToBhg1rwXhaQwPNxIDiRg+xAQyGF4EHTX7NibywU
	 ZqaZhUS6Di/mfQxyQ9q8VZGvxLeFaFV4YWnDBN5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.12
Date: Fri, 28 Aug 2026 08:50:10 +0200
Message-ID: <2026082811-freeing-civic-69fb@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.12 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 7.1.12

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

