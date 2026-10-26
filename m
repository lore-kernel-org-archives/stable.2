Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009627;
	b=2qnqSN2iW2DNIIVw42316KUGrhJN8C+9CA7QdrXwUDafAE/Rcz1eeEQdcweZR6vNO/Yr
	 dTWaMRjNaJKRXXA3UK7U+jSUcRga4+BwHsdC/WVU71zjx5TwZfqkuF7aeAUH/QHpBSVH/
	 CPicLDj+J2mvRvauE6/gPuw7s2AzjAk/wizNY/ERmaLKoBTjKZMurZnMjWHwSKO73peXg
	 PikIDyPrmP9bsWqaRWtcmJvhB6KIAqE1Sl13SgH/kuNtYganzSny0bdWp0ATymyA+6Ing
	 5NwQ5ml8wfpIEW44cjbDCF2ioH4p5K1iLI/XapzAy+PqiiZ7L4fiJedBdt9zKH1E5tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009627;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KHYNaLMhPcP0oroUjwYLBe/Xff4NpZms5BYnQSaUeFs=;
	b=ltf/p8wEhXxHVX/O0Wlk5b2SblWsirRarD2EJ9zgYlpUQdAHJ+Nn0d1kfc8H7T5Rtinr
	 eDh1qgEunzss38GKIVJNLGoNgsG933TrrzkT9IQV/wHyP+nOYV0CxY58e1iPY16QQjawD
	 596U7U1Qfg0Ceb70CL91blxOJxxijBkQNhmVgsf7lWTiwLEwQR1iIqHq4zvJ50aJEWQ8R
	 fjZlZUeSe2+QnP6RLMIFz5UQZI6kVvUtdrmcEXwSTSfpkY98/9IyB/fzeYIbfSSI3VYYD
	 XOA+mW58AbjiLxwiuoOMWqBXf/yulVC/+i2Rsn+xQWHGRDjDvpPq889h4fdSRsds2Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=navercorp.com;
	spf=pass smtp.mailfrom=navercorp.com;
	dkim=pass header.d=navercorp.com header.i=@navercorp.com header.a=rsa-sha256 header.s=s20171120 header.b=VglYu2Ct;
	arc=none smtp.remote-ip=114.111.35.57
Received: from cvsmtppost01.nmdf.navercorp.com (cvsmtppost01.nmdf.navercorp.com [114.111.35.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63210606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63210606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=navercorp.com header.i=@navercorp.com header.a=rsa-sha256 header.s=s20171120 header.b=VglYu2Ct
Received: from kr0s-hmac-real-1 ([10.180.30.112])
  by cvsmtppost01.nmdf.navercorp.com with ESMTP id MY+pcMp0STm6h9hTYIcEDw
  for <stable@vger.kernel.org>;
  Mon, 26 Oct 2026 10:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1793009619;
	bh=URLrTE/7n+/omBViu5VvD5nXJWdvITooqgzhIFLjUbQ=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=VglYu2CtbjKJRgU/l5oLc1exj0+YmkpmBywnMfwXJj4mywmxUNl1Rt5wqd7QOslpw
	 p0ctOhWa2kpqg5P1BhjMqN21fuyyW95iy2p7X2cglC11HRrUz9z+RcSOzYjKsF37OX
	 3GNVlvDQhxresy7dzyt1NhPF7ILj8VfaeAfLp9F38r/SgQfu5URKx0ipJH+cN/Im9s
	 so00FpNzfrCzJNrMpmlmKlhSuomsxuBE1BLf0VqAnLZQwN8FoHD3JZBOzhiTiHG1tt
	 rPdwd/bKYEwZaqq1L+exjiDhJSUErkymgp/eZmFFCEjL0fJySsHF5oVXsB8j3ETiQA
	 beVd6JWzikayg==
X-Session-ID: qo9U7QGhQySfr0bx3zSMnw
X-Works-Send-Opt: TPKwjAumKAumKAbZjAgmKqKXKoJYFHmXjHwYjAg=
X-Works-Smtp-Source: AqnXaxUlFqJZ+Hm/KxUX+6E=
Received: from localhost.localdomain ([10.25.64.175])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id qo9U7QGhQySfr0bx3zSMnw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 26 Oct 2026 10:13:38 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: Backport request: fq_codel stale-state fix (815980fe6dbb)
Date: Mon, 26 Oct 2026 19:13:37 +0900
Message-Id: <20261026101337.22494-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please backport the following upstream commit to 5.10.y, 5.15.y,
6.1.y, 6.6.y, 6.12.y and 6.18.y:

  815980fe6dbb01ad4007e8b260a45617f598b76d
  net_sched: codel: fix stale state for empty flows in fq_codel

This fixes stale CoDel state that causes packet drops in sparse
flows.  When a flow's queue becomes empty, first_above_time is not
reset, so a later packet can be dropped based on the old timestamp.

We have encountered this in production on 5.15 nodes using the default
mq + fq_codel setup, with steady qdisc drops on lightly loaded links.
A kprobe on the fq_codel drop path showed that every drop we traced
occurred with first_above_time set more than one second earlier.
Applying the fix as a livepatch on a 5.15 node reduced its drops from
about 50 per minute to zero.  We also confirmed that the fix eliminated
these drops in tests that reproduced the issue on 5.15.92 and 6.12.48.

The fix adds one line to include/net/codel_impl.h.  It applies cleanly
to v5.10.272, v5.15.223, v6.1.190, v6.6.160, v6.12.114 and v6.18.58.
Both commits identified by the Fixes: tags are present in all six
longterm trees.

The commit was merged in v7.0 without a Cc: stable tag and was
backported to 6.19.11 as 86b81a5c24ad.  It is already included in
7.2.y, but is still missing from the longterm trees listed above.

Thanks,
Gyutae Bae
