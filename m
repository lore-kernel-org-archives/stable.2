Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEA3CF05E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883252; cv=pass; b=acAOpc13q3Ahv4c6VQD0NwY4L0l3yVUb7xe8yyG3d5JZqGaybvPGHlwYTtr+g/hb+kG/UuxmXUv/hojoMrwl5Czk7kOpf4U+cfP1hTbT79mh7ZqycN7KHMQNSk0k90jYQO4+aUSQXCgev3F4DWwkL1OwL4y9Vzq6Oxl/by5AMfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883252; c=relaxed/simple;
	bh=Kl3LhTPxP9wi+jdqRLc1r8BJ/+OEauLNUOvaTMALtzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gLL8ci0VOVGUdyaHWUd69lB2BavZRfScJdddr6KPJ9R+bxGTLuhbgLwT+IqCzd96wCDe9mE5Z9tJk5rF/75Y0zW7uv6yaoBKFNWsMgQQ10gu/nybLbeZ6SoC3FHpyp76G+6HWUcP8pgOKgDQKxVc1ZsGpSOV+eWf2TbLMt2ZSuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TWw809n2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6WeGnWeA; arc=pass smtp.client-ip=81.169.146.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TWw809n2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6WeGnWeA"
ARC-Seal: i=1; a=rsa-sha256; t=1784883247; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AOIIWrpMwWpI5o2Y3I/VkYhM9FnFIpxVV8HcsrxkE1R/7MNedaucDXRAYYwTwtwJn1
    vjRAuUZJVuEpAsQzEdIiL2Ai6iyBXkOg60KW5anxPc0EF34zRg29fHATktPcTe2sHv++
    srrAKGGV/95d6nfk4z1mSpskjvkNq0/Isc2344oo9t3/NIiD55Ua9HMbmX3Q8wlMggk7
    LiEEjCKxn2sWkiVihUzM/Ae0ONpSdZs1TKSKp5XhD41v8Oim9yW1OYbwMONMeq9a4OGD
    eSjE6rOjuS8A4eb+8e8k9euxzeyeqbyunx5aBpVUEuaHUS/sJrNfFdKPJdEz5PMFPSJe
    U2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883247;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3Ux9bGHD9cHCU89FuH04Naom9WfuRhfQdTFJZwtRm9U=;
    b=XholTRxCgxjd5MhKIANq2cUfhHg4J26r4OkZ3NJ7znmX6vIiUhTkvdWjoUyRB9p/qb
    Ger49GE+DZCg11Uu9elgs7ImeqSA7GQ383gHmp5ANGiWwYQ1LWIkkL9csyk/DngaT970
    7V1d5u76uIg9NoR3Bu+peSWT9O33SctrVMg3TVBK2YVHYI50TMNDBMgtyGk+l8wQCCq+
    VZTPei5KIKPwcGGhAMBlI2f6IUS1OU2a2/BcXRbEFcj7MP9E3xS15nBHvvb6GxHT2zsi
    0EPC4t/jHhrjh3Y3EDgzqZ/hALzHpu+GNNKPfNQE7rZSRrn8BQYmvlUxWQth3ZUiMO/L
    0pIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883247;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3Ux9bGHD9cHCU89FuH04Naom9WfuRhfQdTFJZwtRm9U=;
    b=TWw809n2q6Ec9vjk+Xnqmg1U20ccaTVi5BUGgWTF0VNSWy3EepKRFOs+jgj64B63nl
    SOVUroE+GKiuRpv5uEr5eMqmI49mE+wU+GsMgCZTwSBi9kwpjNZRxpaLNI0llpYLtcjs
    NDNE/zUlskuRsJhEl2SrzS7rFya56OnRYAl+69b6RBxTnRW0aB7tIVqO/viM/mnkpBy7
    AmmZ+QRz6SNpLJ8nzpEcdAszAmB3RMbGVjkojFV0YDBVXzup/83DE3zcB848s23eU2TD
    7PjW+hU879VXVPaxcYo70zrUDw0a/Sskfjzy+71oaHNo0YYGIimo8sDWrTJ0G/uUJ8Xg
    m0vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784883247;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3Ux9bGHD9cHCU89FuH04Naom9WfuRhfQdTFJZwtRm9U=;
    b=6WeGnWeAKDYd58u5jGazV6U8YQ+1zTOdvij7NA2TM+sx0ifvyL58jdUZdR0cATRpuw
    fexNQ6Lmd7/zQFWf/PCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8s7rmA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:54:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 0/2] can: isotp: backport of 2 patches that failed to apply to 6.6-stable
Date: Fri, 24 Jul 2026 10:53:54 +0200
Message-ID: <20260724085356.14107-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This resubmits "can: isotp: fix use-after-free race with concurrent
NETDEV_UNREGISTER" (commit 20bab8b88baac140ca3701116e1d486c7f51e311
upstream), which failed to apply to the 6.6-stable tree, together
with "can: isotp: serialize TX state transitions under so->rx_lock"
(commit cf070fe33bfbd1a4c21236078fadb35dd223a157 upstream) from the
same upstream series, which builds on it and would otherwise fail
for the same reason. This is the full set of 3 upstream isotp.c
patches from 7.2-rc3 minus the 1 already queued by the normal stable
process for 6.6 ("can: isotp: use unconditional synchronize_rcu()
in isotp_release()").

This assumes the 1 already-queued isotp.c patch for 6.6-stable has
landed by the time this is applied. If not, please let me know and I
will rebase.

Oliver Hartkopp (2):
  can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
  can: isotp: serialize TX state transitions under so->rx_lock

 net/can/isotp.c | 280 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 213 insertions(+), 67 deletions(-)

-- 
2.43.0

