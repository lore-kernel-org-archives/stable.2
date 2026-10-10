Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462933C1D66
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604294; cv=none; b=pad087saZvYsdunq4EYg65GRwAT+3/IgNdZAlU+RFBB64dC2H8gpwNw69pFnJb2B2RYAjk8Mc0V4KPXqF44RBGWbqXkkSefUTbdsRoTjuC658YGUF7QlUcqfILcgsJVlraxOH6BfFglsMTaVzd/K+xi9OhTUgDd1veav84LGJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604294; c=relaxed/simple;
	bh=sH6RDIXqtcSaRdhK2UmsMtiZfvBUar3SlrL/9W/xOGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yeqpf71cHQvFC5nkgmzPONx11uWi6GyU/ddIEei5L+2YKNbUp6halDtWRnkvVZU0n7wR0XhhHTy3a/MwTp0BZb/2NoqRSOB4wFcCJ18pYIHfqJZICFnWaGG2gmjK9iOXZ0+FSviPhaNjWsWwt6zfunZFL+naqe533Wb1r4ZP3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV6xJQoA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV6xJQoA"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a9841363b5so4523571fa.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604290; x=1792209090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLUcntEk8FCrnINMbHp0kpYagVExENgZra96VBh3yrU=;
        b=KV6xJQoAobHoF6FiW4ANy4ecaBsa2Phc2MCHBeiyTvPIccoX1BugFqBzw0UXG3C5QD
         gGHX+flIhVBgmyz8wpXfFMLPN5ktoxlw+JGKmVVaMS0YanGvQQ/4xIo4LEYdlkL+ELyB
         lrYHqa1X2sdSHLeoxIAmVIx+pG2yCASDG5R/1nzCuZmbg+Anc4GRLVS/0aSfZBO2bT9Y
         wDytOL6wXM3P8pCHMW77AS7VLVH4JmtJhlGsyjmuzu3Lo1uAPA9pZ8NZjrmLa+JWlMQ3
         nAlM7LVOjHH5lt+dHm4s5Yrl/zj1sWemIwcz9X+rsXstExvaH5eRA0lhtQXaE1ybz8Z/
         Eqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604290; x=1792209090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fLUcntEk8FCrnINMbHp0kpYagVExENgZra96VBh3yrU=;
        b=xkivx+YOf4FI/GppDd00A06EhFgndeoSlS/ig2fASWhy3mAc6ZPpum918PL9Rl8Dcd
         BcqBpFeLgUvNgie/0jOz7Py5QaUPlkVUUFEclSv4rgTms0ScGkHrtXRxHLGHIt/3neKE
         V7AzoTCwuhZ/CiDww82ytEU178FziSlvqScJKOjYE82VVDV0it5VVj8EZTwWcFiTcR7w
         u19HL8CWduNv6r1gVlYTS54V+rW1su/qjkGBTI+ttC0DqizJNeVICBWKnufUE8RcwDEN
         JopcC4dtzgZ/WmxQiYo6c82nZQM77QU9V2t45FNY4eixpd2BR9JFq96PCtZ0kjMgfZOY
         iDog==
X-Gm-Message-State: AFq9FYJVRWuEYeCg8H3e8e2IFHNw6AQbLPNjg1o46EHYFQ++lNViLoUL
	qsFFhdpzPSg31fNrRrK5Q+X2t6MvqbF80+9gUb/7tcituVfZ/77dnoE8B8DKpmoRYV4=
X-Gm-Gg: AYBFou0NE92UfytOzt3FiCM/O8HMkOWkpnmSfs2ptqXWiEM6UT2B6sj0B3F5aEtt3tA
	QGMZjY2AP3oe8UV7gP/Q3KeYUULFrZjXMLoai9Rdd8jOUHUlkjXyc3F2KromjRnQBk36rSkfp0r
	QZ7OfZqdHYUv0C0EA79yKp8FyjLrcc8yScwlkbhHOpcDb2s/LYiN3cXZzYTDahDenFnC77VDJQM
	9U5BMZ2Oa8VR1p7+MHMmUeJIx58xYxuVHWkznIJq/6doMHBuht6btVxOgtaIPXfgVvhMEo2Gj5U
	r83m+tlhiQ2a0pmzHZYB/TXFMF7XgC3dUH5CaETYIMLO8uswwfpp/8SbMyKo2cv3Sro0vLJEUUW
	9h064UwOMRI4nvlD6WNoBF8vdVXzwWtnjyNpOTF+iGjNI3rfpC9Ti+pr8zObFW9mAtxOekTkmVF
	B5UG9qkU7kji3Ehl0ngXd97xDY2EyPII3UlCe3o6uuXmFx81iuZyNlGjPhL+1S7SLiMrGybj2dT
	C+ThFCx7WP1SXNJaxjkdUWw1eSyjY4EUDT/54XMHOc=
X-Received: by 2002:a05:6512:2243:b0:5b8:f202:7749 with SMTP id 2adb3069b0e04-5bcde8dec4fmr1398910e87.59.1791604290046;
        Fri, 09 Oct 2026 20:51:30 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:28 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6.12.y 0/4] tools: ynl: fix spec validation in 6.12.y
Date: Sat, 10 Oct 2026 06:51:12 +0300
Message-ID: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026060807-egging-prune-a3ae@gregkh>
References: <2026060807-egging-prune-a3ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two 6.12.y backports added YNL spec features that the 6.12.y YNL tools
do not support:

 - 6.12.93: a2de9c7f01b3 ("net/handshake: Pass negative errno through
   handshake_complete()") adds a "scope: kernel" definition to
   handshake.yaml and uses it in "checks: max";
 - 6.12.111: 45ca9f59b6c7 ("net: reject oversized tx_queue_len at
   netlink parse time") adds "checks: max" to rt_link.yaml, which
   netlink-raw.yaml does not allow.

Since 6.12.93 "make -C tools/net/ynl" fails on handshake:

  jsonschema.exceptions.ValidationError: Additional properties are not allowed ('scope' was unexpected)

and since 6.12.111 the in-tree CLI fails on rt_link:

  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml --dump getlink
  jsonschema.exceptions.ValidationError: Additional properties are not allowed ('max' was unexpected)

Greg queued fbf5df34a4db ("tools: ynl: add scope qualifier for
definitions") for newer trees and asked for a 6.12.y backport in
https://lore.kernel.org/all/2026060807-egging-prune-a3ae@gregkh/
fbf5df34a4db alone is not enough: handshake.yaml then fails on the
constant name in "checks: max", and the 6.12.y generator cannot
resolve such names. Patches 1 and 2 add that, patch 3 is fbf5df34a4db.
Patch 4 is bf5a54bc0e3d ("doc/netlink: netlink-raw: Add max check"),
requested for 6.18.y in
https://lore.kernel.org/all/899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com/

Patches 2-4 carry the upstream changes as is; in 6.12.y the generator
is tools/net/ynl/ynl-gen-c.py. Patch 1 needed adjustments, they are
described in its commit message. Like upstream, it also updates the
generated net/core/netdev-genl-gen.c (4294967295ULL -> U32_MAX,
2147483647ULL -> S32_MAX); the object file is byte-identical before
and after (x86_64 defconfig).

Tested on top of v6.12.112:
 - all 19 specs validate against their schemas (2 fail before);
 - make -C tools/net/ynl builds without warnings (fails before);
 - tools/net/ynl/ynl-regen.sh -f regenerates all 24 generated kernel
   and uAPI files with no changes, net/handshake/genl.c included;
 - cli.py --spec rt_link.yaml --dump getlink works.

Jakub Kicinski (3):
  tools: ynl-gen: use names of constants in generated limits
  tools: ynl-gen: support limits using definitions
  tools: ynl: add scope qualifier for definitions

Remy D. Farley (1):
  doc/netlink: netlink-raw: Add max check

 Documentation/netlink/genetlink-c.yaml      | 14 ++++-
 Documentation/netlink/genetlink-legacy.yaml | 14 ++++-
 Documentation/netlink/genetlink.yaml        | 14 ++++-
 Documentation/netlink/netlink-raw.yaml      | 20 +++++-
 net/core/netdev-genl-gen.c                  |  4 +-
 tools/net/ynl/ynl-gen-c.py                  | 70 ++++++++++++++++-----
 6 files changed, 112 insertions(+), 24 deletions(-)

-- 
2.47.3

