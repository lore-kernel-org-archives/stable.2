Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86473470E82
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322700; cv=none; b=R5QxdlWOhv1Qh3EZ0DHr9E7XMOcKMZ7N5m5wTMvTyhbuUjuahZqld2PRQ6xpSvj17QIbZY6AJ5mlJRd1Jp8rHp9DpU5WeK6ED/zI7//ekz95XkTSUgJrLEeZyvj9izkkIt7j6RbYqnvbAV756zpGW9UqytdUc5g6hmZ82IF08Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322700; c=relaxed/simple;
	bh=YdXCyiR4X2cySroqkx8YE1OuoWF4OvlRFcmWraKLe2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUgsiZmzo6CUUwBREHSgUTUtgD/jh0HjJs+oP9j2Kg9+oap/mO6mMcQzCISXkS6ePvg/cneIU0ktPe5Zbb57oR2btfzw8shIxZXsGrKH9imdEgAO4rSyupmK9R9opHQEbV7MdasmBW5o0oP1+pyyXum8RqHMzbf74U2WJfUuFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJY6CjIe; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJY6CjIe"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc7661e6333so21155a12.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790322693; x=1790927493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSaUcI/6lyKsTgmNsM+ZpbW2BjhwM28sFNv/ftCi/QY=;
        b=nJY6CjIeCMHEp6WfJ2lMUgPX/bQ4zhBS3qbJUZ9BH7eYJwzvQh97aOaWjTnXZf9axb
         7aQbWdrIwGubGq/0tLe4l0o2ysjctleLCZ+zqj26l9MPw5mtxdQm36vDMBz91rdal0EP
         a91fkZVhRil4Xu7wF+/k4AFkr9vHOz2cfz/jQYGvSUShkpF6ohopVqPoyTmaa0VK3nh4
         Z1lAEJhY6IoxgjExIhSQwNiPysop1JU4TG4uUyO62hj64VnEybjyfE2DTo7+cI3VVZEN
         OOA6W3izMorEOgI6qFmIljq+d3lAuqvRBrjnUH78Rl9ZOYLzHxOKWz4gGH2f+Qx6SE1Y
         4omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790322693; x=1790927493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSaUcI/6lyKsTgmNsM+ZpbW2BjhwM28sFNv/ftCi/QY=;
        b=GIa2M6LpXNNtphJElbDKg977n0tzGEl55tnn39RfH1sDrU2Plf9GO5bQsO7NH9lpGn
         9SCYA47JFmf5jCEN9VCYVXWiKx9Kw667O0lD1gm0b6XgdVRlwA6yxFL8uHWNcMa5Flkl
         limLfgIZpf+pGHmbi6xcSCLRSFxSau/ONCIsPUTgXPY9JiIXKMI7hTxOGfQnn+RdcJI/
         MJ0OczIe/SZRJ5MylfRkGd5lCPXmLD04jpB0hDyb3lN2dhn63oy66w3WC3TkwJXHVP/c
         euqjPQ9ML+EGNMjo+++3M/Srj38qKEZK7kHiMLE+GE4xz3WkDiNN+nltTF2kYLXxl72w
         708Q==
X-Gm-Message-State: AFuF++nkV8yi5a0BoyXO3H0QpkwmtacyC0N6P9Nf0WhpM+oLWyD/4YCC
	W+2wooS6D5Iic0CKBj/qUc5esfz3E5VWyYoNXgkShxVd79PcToVNYGGYBqxY3A==
X-Gm-Gg: AYBFou33bihg4ToAmB3P1UzbWSZ0Wsj0SZ4THoC3lEduBqvyqeaEOZ4m0Kpt9H3osth
	k3qAIUyxR+mYOSB69qHaFqapZcgPuHPBT3ibpgbimOo/ErC1go6d935FtaFfLxXNCo6SRucqLv2
	Yn9UL7ohFOik+Ur5ENXar0gQ1Bz2Xg6yKv8bq0L2PX17dcJkAgKVQsnwHaeRVTu7Ck7Z/zfTCZ0
	Y9/OkMTNF/3S14geoinsxevtXUIJHXtYRMhp9deyJMSF+oSDMuscr83aX7eXqeejkzzdZ7LaZew
	sZQe6tyjx8aLlUsaF6fWZPkV8NvVqk511mxWDCT3hxNfA0nGeed/67itl3huxJwXLR1YoIaBoHy
	t5QUb1HRfMc1TOhoApnVp/cXYPCoQhszXwICyVtOrZXUAOGVtN/CbcGwONFg4zpNvBy/EcNJpeN
	yh2otARJC351qPBuWPK35MleLvdeEVcPw2FoEtebbLzxBaZoq2vVrLKEbeiNpZW1kHFyQlRlvNF
	YzmfxN7Zfg=
X-Received: by 2002:a17:90b:1c05:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3a0b26674c6mr3027118a91.6.1790322692718;
        Fri, 25 Sep 2026 00:51:32 -0700 (PDT)
Received: from localhost.localdomain ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc790c80e62sm255962a12.28.2026.09.25.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 00:51:32 -0700 (PDT)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH request stable 6.12 6.6 6.1] netfilter: nf_tables_netdev_event UAF of binding chain
Date: Fri, 25 Sep 2026 07:51:24 +0000
Message-ID: <20260925075128.646-1-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092558-grime-yahoo-6b34@gregkh>
References: <20260925020025.616-1-junzheyu1@gmail.com> <2026092558-grime-yahoo-6b34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

The two upstream commits cherry-pick cleanly. They are Phil Sutter's
"Tolerate chains with no remaining hooks" (fc0133428e7a) and "Simplify
chain netdev notifier" (375f222800bc). The second is the follow-up that
makes list_for_each_entry() safe once the notifier no longer deletes the
base chain.

The 6.12 diff does not apply to 6.6 or 6.1: those trees still check
NETDEV_CHANGENAME in nf_tables_netdev_event(). So this is two series,
not one:

  [PATCH 6.12 1/2] and [PATCH 6.12 2/2]
  [PATCH 6.6 6.1 1/2] and [PATCH 6.6 6.1 2/2]

The 6.6 series applies cleanly on linux-6.1.y as well. Neither series
touches the rest of the netdev-hook rework.

Tested on KASAN guests, with the anonymous-jump ruleset from the
original report (base chain committed, then `nft add rule ... 'jump
{ accept; }'`, then `ip link del br0`):

  6.12.111  no slab-use-after-free in nf_tables_netdev_event
  6.6.157   no slab-use-after-free in nf_tables_netdev_event
  6.1.188   no slab-use-after-free in nf_tables_netdev_event

The same ruleset hits that KASAN bug on unpatched 6.6.144.

Thanks,
Yu Junzhe
