Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2973EDE52;
	Thu,  6 Aug 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009342; cv=none; b=UA9ItNaARu8oHA092XW+UV68Io/M53uyh7oqc4NzsRPPlTQxb8SkeAXljMyht8mXk0UaVmCETzZ8udkfukYxEpozAC8UrhtwKbhphlX1vR++bwAAnyHWo+gHR7MdbO0nvWecEhFITwwTJ9RJOcfLKcPcExKhfVfailHTLq1SKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009342; c=relaxed/simple;
	bh=NdHESAUQ4ZO6TTZqFAnJH2LZTpjC3NugDkSacKLyIhQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YxVfgOiUOO8tkowm8Sj5DDTU6i7xO1mdJ78wQDPLgqYsVlxbsOT+NhlPwFvhTJ/jCRHW6jd4mKCa1qvJ1OAjQdBFer+Msw+AUIf0CKnEgXCzWV7A5ZhHNENQA6r/KjkU0ondg5P1JhHPyDCRfQPFKD6K/2xpovWYJfZtbADvwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Kfe9CIyq; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Kfe9CIyq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rT8Zobk1iBQhKG0Wj8n/FYGLbMjCTM0mrGrG44eUbVM=; b=Kfe9CIyqtbcavsRSGzUV/lOid5
	ZvRix7Szp+4IvlUpTi16nNELVIk0NeYAf3t/jcq+lfFoWKNIxfnHoER5gcEGmKyy6eTSma/9qM2GP
	6JJtEYpCdumjaPso09lYSbXsztQW68ted+CvdcruQbG7czqQjfh/q0lqP7Gi/mf03xJDqbVpo8/l1
	oQvZS05pjvLUCQvVmaUd+/DEtGOx9DAsUi9qyePBAucq7CAOKrW0/SwB6Mn1WxxmOgVzerDdlgz2u
	WdZmKfXvSTSvZrKbNgvSYWk4uBUncLU9pmB4jo8RIQ7nsr3Q8oDikWIi5Hm6gS+VCC38NFyDE+/uc
	eSSmKDlw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrucA-00EbHa-0f;
	Thu, 06 Aug 2026 09:42:14 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net 0/2] net: mcast: do not write past optlen in the source
 filter getsockopt
Date: Thu, 06 Aug 2026 02:41:59 -0700
Message-Id: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhWdGoC/x3MWwqAIBAF0K0M9zvBHoi4lYhIm2o+stAIIdp70
 FnAeZA5CWc4epD4lixHhKO6IoRtiisrmeEIjW6MttqoPUz5Ghcpqpt93Rprg/cGFeFMvEj5rx6
 RLwzv+wF5RreGYAAAAA==
X-Change-ID: 20260806-mcast_fix-4db13688cbb6
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=leitao@debian.org;
 h=from:subject:message-id; bh=NdHESAUQ4ZO6TTZqFAnJH2LZTpjC3NugDkSacKLyIhQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqdFbx790JWaHd7c3tkTTziI2FnSTDZqk6YmPzZ
 wzJCTINM0aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanRW8QAKCRA1o5Of/Hh3
 bbpDD/91Ofm+9GC2NPArtk4rtNJDHLyWs89KhAHO+Be65+mZLRTl0hJSJF9vZlFGJJERujiVfd5
 Ge7RdGhX7+BbuDQ9YEz/+xF9ec8u04OudgxM4WnV7NVrGAdgLOCKzPMsC4SWJ4xbPNG0YHQCYpQ
 FTMGn85STBeaEK0ORRmaWRP+nnRvBrU+PvWIOlN2ACJbEshWv+xAi7EK+PEn4H+YKd6BgwmR0qm
 a5emaJqaqUrgBQ23uYpnA0gONmw3ezVXBXAss85BlW4K6PTW/RF1dzhhofWCIc+m1OggXtAFORb
 WlF6UCU4Em8UI8vh6c25d4F9ax+1vIUxNb7EnYEPV05oGecw8aV/l3ePdheLTByy85DuPcJ7gWO
 0K5sqZiQKIBAo7ws+tp8/4gSr0VOYnj5O7sVoBSa5yzC8kTKAJyuuPyKp995GSo2IrunWuGmNpr
 oArqA6cCme2nAANIvuazajB6Lr5ohqPfrySgWlC+TtgJNedr3/hf0o7SDd2XCPktH9hVNybc5t/
 OdzwhLJMZxPyJrhoMr6FrBLpGA11aYx9Vg+LXeMS8CnX5QR0p2TZoonjT2rt16Lbz22uG+2m16E
 92OnL7LLEry0BRxhkfU6WGk/tvzI3ACbLqCfFy3c3U3KXrvSJmr12hwm8cb5ntpNJEX3LtXYj+c
 ukMiTJc5HESuh3Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

getsockopt() on the multicast source filter options writes past the
buffer the caller declared. Only the fixed header is checked against
optlen. The number of sources copied out comes from gf_numsrc/
imsf_numsrc, read back from optval, and nothing bounds that count by
the space left in the buffer.

I hit this while converting the mcast getsockopt paths to sockopt_t.
Fixing it against 'net' first, so the fix is settled on its own before
the conversion goes on top.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      ipv4: mcast: getsockopt: do not overwrite past optlen
      ipv6: mcast: do not write past optlen in the source filter getsockopt

 net/ipv4/ip_sockglue.c   | 16 ++++++++++++++++
 net/ipv6/ipv6_sockglue.c | 11 +++++++++++
 2 files changed, 27 insertions(+)
---
base-commit: b0057c68df711bf6a62033c072ac61c4f9d3cbc1
change-id: 20260806-mcast_fix-4db13688cbb6

Best regards,
--  
Breno Leitao <leitao@debian.org>

