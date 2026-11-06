Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.215.233.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982705;
	b=oENj4vusrzJti7pCg7mLeZvktkUP6rGvoZ5QVuu4KKEShbDTT94LtNsXBrGaFMTtUxzZ
	 TW2pq0GlX2j7SYv7EN/YVoJtjxsI5297dLF7US7SMOnvqi3ardTmGP1setxODy8czUyS1
	 CVs0ire8bDu35DHHlTVmfiStRhnqXBT/Yj4nk+obYj8b7aje6X72e5IEDnUW7IMaWZ1JF
	 kiKGgAKZMcVhN3yNOSyarTzpdjn1sbCcF+X0dvuwEZtm2bxBkoDLhPY+Ie+Og2w+s717Q
	 hS9Zxkq0A0AEfrbU9OnYzJdGnv6shyf8Mzg3HqpVyTfRaQXol4mzNdeC3qCB9BUGNfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982705;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xHu8pGb2qY5UYa4jLSYkZgw4/M457fi68VtTjeWnUNU=;
	b=bQ5peco+6pxcfQfFIo0o95qCETN/eLfWNLA6PcJOILrRHeBbV6YUd7pznVNLGlSBYb2P
	 TYcVnJkJMvOgyUNKalGCnRH+2WLeWTKztPcAqB1+B3zSot4S5mzvtiSmV5822h4KRTfxO
	 ai3SQpDg8YcSlOjs1mgkh8VUBp0sj17rE19xpqJwlsGQ5piIW2OTqCr4G4ecpQ7bK5DN9
	 AYwWaz3ow16jgHInCtNyCWN62vcv3CG7bEEVZli3V1NKoict1shJxwbD/1/ZfXyQc0BGB
	 UFMdK+R0yF6hNF5BhTPOijcKpRaazY65xLg0rSLjqpILgOTOZ3DvjyT2FBpePkO2p5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=janestreet.com;
	spf=pass smtp.mailfrom=janestreet.com;
	dkim=pass header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=RRhzC3tk;
	arc=none smtp.remote-ip=64.215.233.18
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B542606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B542606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=RRhzC3tk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1793982698;
  bh=xHu8pGb2qY5UYa4jLSYkZgw4/M457fi68VtTjeWnUNU=;
  h=From:To:Cc:Subject:Date;
  b=RRhzC3tkWigVaXJ7gu//Lfw8iuuEd32Zu0jJRVjVTMlNpnTBc2xZ9Vgj3q4gpGaFu
  YNXwBL/gvvzHiCivi/bgcS5OPoiPnb5KCbpFih4IOryxelCS/WQkm2/C/rvZIHoBPA
  qub2bfAUtFQq03ypOFZ0xP1ViDnlAMee1qIOx4j1XC9wd82lKBw2zohBqDw3XeG92p
  qLupvqGkN9+AbYC6O66n8YKZmT8lZC/+LawZsm5Xsxy8lPvgeFmHiRTSvZnt5S/Ipw
  xFQfoDTF0y1zdiLIEvR09ig657tiHxTRKbDSD+PKkiXkjlMBrZALKcjlycc9O9OiCO
  lyfC7Nlg9VQuw==
From: Eric Hagberg <ehagberg@janestreet.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
 	akpm@linux-foundation.org,
 	zhaoyang.huang@unisoc.com,
 	tjmercier@google.com,
 	shakeel.butt@linux.dev,
 	kasong@tencent.com,
 	baohua@kernel.org,
 	qi.zheng@linux.dev
Subject: [STABLE REQUEST] 19999e479c2a ("mm: remove '!root_reclaim' checking in should_abort_scan()") for 6.12.y and 6.18.y
Date: Fri,  6 Nov 2026 11:30:55 -0500
Message-ID: <20261106163056.541441-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
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

Please consider commit 19999e479c2a ("mm: remove '!root_reclaim' checking
in should_abort_scan()") for 6.12.y and 6.18.y. The commit was merged for
v7.1-rc1.

With MGLRU enabled, memcg (non-root) reclaim never bails out once
nr_to_reclaim is met, so reclaim against memory.max/memory.high can
over-reclaim by a large factor. That scales with lruvec size and hierarchy
depth. On some large-memory machines this causes cgroup-limited workloads to
fail under memory pressure. Disabling MGLRU avoids it, and applying this
commit fixes a reproducer with MGLRU enabled.

The check being removed was needed for fairness before b82b530740b9
("mm: vmscan: restore incremental cgroup iteration"), which landed in
v6.11. Both 6.12.y and 6.18.y contain b82b530740b9, and the patch applies
cleanly. It should NOT go to older stable branches that lack b82b530740b9.

Thanks,
Eric Hagberg

