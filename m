Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF93DAAAC;
	Fri, 28 Aug 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899992; cv=none; b=Sc2M0ZcvCYdDLV9ANcjd9H94kHTtDbzCyIu2DJWagQI1Jh7Ez5YuEwzSXBVQ4f/6WIsthCkvdGJsjpvSDvhKxZ1mbNgRMW6edM+KZahdkImDBa0pWMJSPXTZK44H8oFethLP899g8uzp2FJ/PdKJrbpLKIR029xlNrUs0gOgphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899992; c=relaxed/simple;
	bh=hAwQ8N4UTY8tv8Ej8eFFCexyQqEvWdGtj8+JOTiuA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFQ7za4oD9zdkYtJ/rIkE95/kDk+j7rw5VOngvh2SntMZzWOQX42H8ECBg7YAeOsjDA0iZJ/qCvGMcf1AeUsLB6Ix57eslS09I9Gwn8YvJeRZNNcnAKV8wNaKxgNnmeIfqi+q8CDqkgQouOm0iB0HJQokiSrEObexSh1NEMVVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgauB2K/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgauB2K/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBFC1F000E9;
	Fri, 28 Aug 2026 06:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787899991;
	bh=vM7sHn7qH6XtYWO863gl/HW5WGXpEZeAflQdoZ+i+o8=;
	h=From:To:Cc:Subject:Date;
	b=VgauB2K/SAc7IjCe2SpjjTmFIARgjeeSq+jHnC1AM7u/lZ+BeaTelgJoGqj3+XmTH
	 XRrw65NfdMaEyBvSunHDS7dfL2upc+ypT15kh3xvQaFzJYBj7cnaxq9YL70NB0pjYW
	 7yrMjXyXqSIhd+xHVOmO7LJba1KjprnXvF89VQOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.219
Date: Fri, 28 Aug 2026 08:49:26 +0200
Message-ID: <2026082827-mankind-mandate-ca8f@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.219 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 5.15.219

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

