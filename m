Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7123DDDB1;
	Fri, 28 Aug 2026 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900011; cv=none; b=S8noDHq0FM1oJZgw8KxzqwYqQdKFA+NMZkt8/QYydNAN5XkHzt/u+6FV1utGKozIVeLHCoC6qA0xWW0TPBOX1Ce3zDezYJ3eWY6x2gEGPv5N5t4c9KY12BltIMpP5cbZQgXOZMDct5sDie9rm6You3ko8jvaAryw+q4d+plXArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900011; c=relaxed/simple;
	bh=J6yH8CLYlx/zXIseED9Ob4/tIzZQjFiLWUWAEo+qjBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svpYoXJ1FmP+k5xhIRgYPi58fBhWMBJl7dYBJ4bmPVLw5MwXkV7riL3HuJr9oX/h9/6+soqBniflsYNVhlu8NS/VB02tVpxsYk6xJb6KxNz2+X4Fn+7n+6b/1msMy0ouBmlj/bq27jt91LiGWUkVjdxkMHD3wp6u5SsnhxPrPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=We7KXfVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="We7KXfVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148CC1F000E9;
	Fri, 28 Aug 2026 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900010;
	bh=b4FLQ3e7DRlVH3wt08JDfHjDeGJSKv8ryYTGA9nQs70=;
	h=From:To:Cc:Subject:Date;
	b=We7KXfVUilN8riOCSna92eRTIyhWZFyIQIVctmHpJ/v+jM14x/EzIiutMw4H7Fx1h
	 fsQxeYzqqVlortiL/1gzM+hlxTlp5KK1PDTNRWw5Ps558kaQoddQzd0uv9KOwLZlfM
	 AiirkNfxzq6SOjlwDW9KIZdcobYcS7ehSdey3dbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.107
Date: Fri, 28 Aug 2026 08:49:59 +0200
Message-ID: <2026082859-lake-stuck-2d9c@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.107 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 6.12.107

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

