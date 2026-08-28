Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7A3D9025;
	Fri, 28 Aug 2026 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900017; cv=none; b=rkPki0IcnAGkoLV1+s3QFQHt6kbG5HpeAONR1wnRmulOKu/4J/ByJWsOcpjGnkc63/RnDkrfQ13D8AfbiYKz2khtCLWLAT0UNtkFtvWkbWm5Zn3vYpa+NyW5W91Ndud7GMgcUrTUcv4xmqESvxvztFmRxdU3Ks0ycHY29bhrwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900017; c=relaxed/simple;
	bh=D3mf/jOMZxv/OQKWZ3dFkNNOpcv2S+BazQWtnB9AQ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gp7LwvwJ3DzcPz4BtfeAkzpx6L6qEOAzHX9X5LRjvBIDKO9Fe3LjuiWsu81aOSYWysmzfpQyxT3y/XLj/TH0SQnwtokAOLRHKkOZBlG3+YuwARFLfbLIH9pAI56Yd0SzSKqJonmTrYQwJUGNe9G5AtETOahCJXgCReJpoS1vjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnZziGek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnZziGek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31741F000E9;
	Fri, 28 Aug 2026 06:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900016;
	bh=pzAaHkJhOrtxSnVwaifoOxKhqLxQ6l8lh9osUKic3S8=;
	h=From:To:Cc:Subject:Date;
	b=nnZziGekDdKEmdwjxsTcoNBLbTDGX5NLR2zthHOybVW9hWXl16b5p7EBK8UcRiRiu
	 3FNoVlj6nSPgLlLGNBKQbeZr5/ghcqz137H9I7Yk4mS57fOORGdtJYAZ+LTdtK7Ldj
	 UMoiQeubK9X64S10BVdf2Jb+KnHch7NhcO8tCj3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.48
Date: Fri, 28 Aug 2026 08:50:04 +0200
Message-ID: <2026082805-detoxify-lantern-c996@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.48 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 6.18.48

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

