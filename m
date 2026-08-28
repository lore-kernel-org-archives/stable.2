Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E03D5C3C;
	Fri, 28 Aug 2026 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900003; cv=none; b=gBQs7EnqV9S0KuE0aQ+4wYNUK2lDjhNJI/0Y3ywzu9z6kZ3bQ6pq9lu1DWCKO4Q03ENYddiou/AOejoN8dhG8soU9OZ0QNoAe1TQdBOHaGQp63IqD3XSkmcGGO/wDzniKt+0wrXI3JgNw0mKJSpg+Fv20ZJaR9VKRURNB33g6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900003; c=relaxed/simple;
	bh=JCSxsg97MO1BXBWpT4iYy8NjvJ4/omd28PhxjOqSf0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFFPCbX8hzDxtYxVbmh1NPnIbZ3pvqNYWuO63wzW+zlGrL07bk593ClvDquysYkMQ/4i4eiEROF1mFtr5eOREw7bbRtng4aQioROsEhz1vDgkMBLm0e6+krzYLE2kgyXnwzwrW4jr01G55IuTgcY022DwjRREJiVzehp7F6zzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyB+xv5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyB+xv5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F99B1F000E9;
	Fri, 28 Aug 2026 06:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900002;
	bh=9Ej3DFo3VIgyu2LD/Ex1iBRF1+7rwnHBYs8DHJ+Fm0w=;
	h=From:To:Cc:Subject:Date;
	b=hyB+xv5nGCAWlzTvD9kegPkry2wXEc6weLs3PfIpl6MKNKPDgFkalyd9F8FZR1nle
	 Xh4xY4P0fAsxjV5dVZR4oVLlHO2XYK2i+u5W3f3Mv+SP02YR3O/u87FOH/9J3UkF64
	 DK0pFWAUXOpdcQihcMGSHrBk/toc4LrEywzWYHRk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.155
Date: Fri, 28 Aug 2026 08:49:40 +0200
Message-ID: <2026082841-endnote-stoke-44df@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.155 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 6.6.155

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

