Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124C3115AE;
	Fri, 28 Aug 2026 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900031; cv=none; b=TRzJCZHyXoIzUuDdC9OUDrU5flk0grvy/pTNHRST6PxRxq27KoGA7SLhaXxYILw22y7xgd8YLXoS4QkBv2xZ0Dfll+OB0dcr+zlqyzvLJu7MZ6X6M9LNWIb+9vGTrHXJ6s3//cK4Jghsd70KxTZhTplkzqykmW0y+yHAAC6lCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900031; c=relaxed/simple;
	bh=UFjXpY311fzjIcT4VVzGd71Hqtu1ooW9SD4m30v4Zb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQ9kq7hlwAXbLCPKogyFoWNFHKNgbqUuUzZcPpgTMCNQyWzNkIyEuTeuK0G5wMsGKQYTMRLU92JkIcvmQU4F2F195TcyuMz8BZW7JnjYpoUD4/N/xPNZc6sqiKhp0dEfdqZEVjn9KL+CBAwIIdXUSom1MFfSpNf3DsGUblO2qyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TabsGEl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TabsGEl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDA81F000E9;
	Fri, 28 Aug 2026 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900027;
	bh=bcal5Ra6pXLK9HxKgjmBZOtcDbJy8yl1XMUdjev8dOs=;
	h=From:To:Cc:Subject:Date;
	b=TabsGEl8DuCOS4bOMdwLMmjjytjLdGmoFmn1yueVeMugYcST4hS6ZlV8rIym9JemZ
	 mmGG53+A7eFFb7PT2xmZngCEgLsoQFt6HDTymUFuq9gbRLz3A2nswkd+B/TOnrQ5or
	 9jRlyuSMb6mJBBIpmJ4CYgOVflOX58QLcws/hDSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.2
Date: Fri, 28 Aug 2026 08:50:17 +0200
Message-ID: <2026082818-celery-dizziness-dd1a@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.2 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 net/ipv4/inet_fragment.c |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 7.2.2

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

