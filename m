Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8531DDBF;
	Fri, 28 Aug 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881596; cv=none; b=gg1OFKIGwMAZacvbWuuaRZNkus3YP6qWPX5DvL9RlMSouZKaxyylNWKAPKGWk08oKRiYm6hmzk4EH6/3LhFgemDVILaSQc61Zc/ZOzEAXCEoki1Ko4a+6jwhGYNQ8kbyv73ul3r7nTaFjQCRUcc8oB1VzP9r6+R8lvl58W9mi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881596; c=relaxed/simple;
	bh=AV7nx/hFeroT1YnmOJlIMWe0OqRNyrCw1i1idLKRdFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X567ktc3cMUDjjaqu5e+8a+D1yP7tAMrJF/cSCXaBv3yQKmK0RDX9Cg5IotFdd879Rx7tTElQn89jIv0lMmmvo80d3MSsV3R2hDm4mURfbb0BZQRZi+5TGsMFwt+GL5K9C7KAkOnH8e46BJaA2y6Rbzh8rrJEI5nwfXE/+XwndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hok/d3t6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hok/d3t6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1435D1F00A3E;
	Fri, 28 Aug 2026 01:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881592;
	bh=X3TRLwIPMqSoNtNi7xgzngJ8JZS+cPJqCIUwBHClWRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hok/d3t6eiwU82MWcqdafYqf8Ssk+WKcqdWQzyssFoqP+ye6ihE1StqBGt/8kwpLf
	 S+nrkAw07/0y6RU8fILaBE3uOFNai4oAo9q7Ua5tQRP7zYpQkhCB5IdkToR9+OAcbe
	 n918jpBA3pN/X7SYohC8788J2vO5a/sm8/Ka26QLMtEOEXFcaMdSoXph1HArrlMD7s
	 t0Lh4n6s/Rc8xhURIW+Hmx3kIFnPWFvZPsRpA/xDrOFObhQVIzQpokXAER6kxpJTul
	 7zgt3bhl9pbJfZ2PnM8GLZrsbSz2YhFpX2Hm9KHe9deX2071ryio/EBDlwE2YAHp9y
	 +UQtlz+1r0HRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
	Dmitiry Korovkin <dmitriy.korovkin@windriver.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Juhandr=C3=A9=20Knoetze?= <juhandre.knoetze@windriver.com>
Subject: Re: [PATCH linux-6.1.y 0/1] inet: backport of RAW sockets dropping incoming ICMP
Date: Thu, 27 Aug 2026 21:46:17 -0400
Message-ID: <20260827-stable-daily-0004-inet-ipproto-raw@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826175018.131474-1-juhandre.knoetze@windriver.com>
References: <20260826175018.131474-1-juhandre.knoetze@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Attached is a backport of upstream commit c89477ad7944 for 6.1.y. The
> main difference between 6.1.y and the upstream commit is that in 6.1.y
> the function 'icmpv6_notify()' in 'net/ipv6/icmp.c' returns void
> opposed to a 'skb_drop_reason'.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
