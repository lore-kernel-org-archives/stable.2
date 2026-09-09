Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84F581250;
	Wed,  9 Sep 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971399; cv=none; b=WhC/2XMpRMus8StqUP09oSeW5z6fkduGr9sWHODLHUfHEW8iTC5KXQbeWeNnYLVofeQNOJsUVvPA/cc1x89mr60GWPmcxjg8LyLMLv5YluNfdbGKnEXlXDzpeSv5BbJdHvUdA+wtdVtSyPUH2bv3UOM7YvFMJVnqj59HlYLRdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971399; c=relaxed/simple;
	bh=krwfMdiCMzFHmtZQPPfEjSMaKs13pUHMuJ/roEuywc0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=d5k0GKPhydOvNP6MukEmf3b2yqMpxZt/o2avrjpIrXVanY8OYcGQM4QwIl1AUCVlcgn4aBranBiIX7Liuy06N8GAHNZc4ltTeLQ7whrOZdmLiCCUsaXfSraPl1ZHLn3gBjmZYohzq/n0M6PB6cW+/bSWosLvdkQxsWdn0OK3kEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ppFYb/AV; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ppFYb/AV"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hg5r14Yl6zMlH1;
	Wed, 09 Sep 2026 18:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1788971393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GijESrXrggs2Ng+WJhK7xqr1s12SqTgNBkqbolGvWN8=;
	b=ppFYb/AV/USeUbcdcR29K2xJdq/CI8DWS0hMJ9UpxWWY1Z8ARX7DpcS2qtYaipyieYBb4B
	HjCKJkkg4N1Ktu8goUFujHHJw6ArW5WutYQ2keWiiILQKA2VYKD4pPimbbYZiu/R5T9/w9
	ll+RcxVfbQK3zK0NQnV86vqbQCpCI+0NkES5KGM9OtdGwlf33EIeInm7s0H02dKXNNQDf+
	7S2MoNzq/WFj6bM0itWL6aIeXGH4KuYbA/HJqeZ2UAXz5DJdEcA9IIdDsDhJBjVP19FAdu
	XyBnqAoRs383NTaUMzcnaQ5gExwsgK1SweDdc8mnSrNxCo6r/gy1j2CKDFr0/A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hauke@hauke-m.de designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hauke@hauke-m.de
Message-ID: <7dfa42f6-64c1-4084-bfea-d57500c245cf@hauke-m.de>
Date: Wed, 9 Sep 2026 18:29:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hauke Mehrtens <hauke@hauke-m.de>
To: stable@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Language: en-US
Subject: network flow offloading broken in 6.18.45+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4hg5r14Yl6zMlH1

Hi,

flow offloading is currently broken in Linux 6.18.45.

Since the backport of commit b5964aac51e0 ("netfilter: flowtable: 
consolidate xmit path") to Linux 6.18.45. This is happening in a router 
with traffic from wifi to the Ethernet device when mac80211 returns 
-EOPNOTSUPP.

Upstream fixed it in 871df5007eda ("netfilter: flowtable: bail out if 
forward path cannot be discovered") by not offloading the flow at all. 
backporting this change looks more complicated.

This cam up in a discussion in an OpenWrt PR:
https://github.com/openwrt/openwrt/pull/24800

An LLM suggested this change: 
https://github.com/openwrt/openwrt/pull/24800/changes/394d741e6e76ecd172dbbf1d9ba171e378211734

It seams to work, but I do not understand this part of the code god 
enough to judge if this is correct.

Hauke
