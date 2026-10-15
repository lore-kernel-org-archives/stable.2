Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC052CCFE;
	Thu, 15 Oct 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066917; cv=none; b=nfJMAbgi9BTyIDrUhwomh5i3SvFIu9JKUVJxwMIfWZNXuop8CxMnarf8BYOasIfHQKR6GpwsOFRn+J1M0h63Ni9GZHG9T8NJCCwGjx3JoqGYWOFGOiSs547lGg88Ol/meJUa+l5u8LSSitCnY1UT4zm+A4NoVmPkmDab+/v+gbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066917; c=relaxed/simple;
	bh=+N6A0w32e72A+v968IB4dDXhkgzm1NRkG2SSklr5oxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4+DbiB0KbNb5IY532lXJRJZLhAOJ3W1oQ5eahzLbN8FWjEllgP4PDEX2GQ43oocp11CoKDdClwzr+W7vlzL5pxKroKn/uNV2wxB630SdG5gRvSHREHH0HvVep09gp6ArwcBOFVZ0na40q2i/5C66UsPlsM+3K2QeTRHMwwWWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8VdwxFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8VdwxFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68601F000C4;
	Thu, 15 Oct 2026 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066916;
	bh=X/TPRjQTlr4k6WtuT/Vn1K/U+fkb6Tl/7ge5TmhZtzs=;
	h=From:To:Cc:Subject:Date;
	b=R8VdwxFcE9LP1jXC5H96xA7YPqSrXXIuzbOq+4Ki6AnU+WF8Shr6yqSh3mlFA90i2
	 NnQx3Ke+LJUOg9BSrY7TSjXNn1o+QNSy0oz1jP8LJpo2hkYCTviVosjSTPTlbTtZxe
	 bkE1DxwtXC0qn+SNNDfneUXWCXDPrza5OS00Sc5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.190
Date: Thu, 15 Oct 2026 14:21:56 +0200
Message-ID: <2026101556-skinny-abstract-77eb@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.190 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 +-
 include/net/ip.h                           |    7 +++++++
 net/bridge/netfilter/nf_conntrack_bridge.c |   10 +++++++---
 net/core/dev.c                             |    1 +
 net/ipv4/af_inet.c                         |    2 +-
 net/ipv4/ip_output.c                       |   10 +++++++---
 net/ipv4/tcp_ipv4.c                        |    2 +-
 net/netfilter/nfnetlink_queue.c            |   19 +++++++++++++++++--
 net/netfilter/xt_CHECKSUM.c                |    6 +++++-
 net/xfrm/xfrm_output.c                     |   16 +++++++++++-----
 10 files changed, 58 insertions(+), 17 deletions(-)

Antonio Ojea (1):
      netfilter: nfnetlink_queue: unbreak SCTP traffic

Eric Dumazet (1):
      ipv4: free inet_opt and ireq_opt after an RCU grace period

Greg Kroah-Hartman (1):
      Linux 6.1.190

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

