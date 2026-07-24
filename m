Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BD409604
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882711; cv=pass; b=fyMpqFdsF5jZcpPjhBqHpPxdrAuGtVp6XThMWbYqH75+NsyFEXFFNOgDFZ92hJjrQSxnzP4tGcirCjPq3gi9Q56M48GoIzYDDQlUCFs37OlP5mrIOx6xTN+O0o2UBVQNiCRCWXi2wCOGCqsIaaDtsNgVlvgDMPJ983YhgFGpjRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882711; c=relaxed/simple;
	bh=7KHQNU29i0vAC2nwDBBI4qh7fWfCoKKhVH8Cgq9LnkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tzb1cpyG9I3I03NluYqx/uEZXN2e/6U9Lh5YDe93DcYQC59nSZ8rGAqiOHB9bsXgFmgegNqs5pZDBylWsJsSIqrq/yG7FuXGd3Ia87Wr0mPf4f8r254FUL0dkypNwdimjOS9At3oqx+Q9x52B7qI8gGCHaCYN0QxQPvl5LL729o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=e2NJkhuR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TvtFrYa+; arc=pass smtp.client-ip=85.215.255.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="e2NJkhuR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TvtFrYa+"
ARC-Seal: i=1; a=rsa-sha256; t=1784882707; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WzPV/fvuEABvdGzHugFCPT60tUgaFAZ8KJC8dcjRbrsCenyQUVb6upXrjwn3Th7PSQ
    1W6b8XNV4h0+svqfZCWOyBrQtatoBk9Xz60lZgbaw8bUp6dST2S1VIX2AjKwjltwohXw
    4vFKgnGjrUxuT+G31oFsiiDyFSTMp8wKGFDacbXkTzrP0IY9NQObIQzPNcQHj5GDGWgk
    UszXQwTwrxruJernJHGWCU6TeWaoS+i4amPmjua8i0iB87jjUVquhzMdLw7pApZRXWrH
    /0wX1ItHDzmRJkl3jEUsxNmQppNRCSR1+6IsCmJpCEyOul0pHertfBvkXMN0ey0MWGMT
    49ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882707;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+7LTnPPHqbAJQARmANCVqu71c1ZgXNKkONRImeyPJzo=;
    b=WvChVJEFu3MLorRI3y1SOO8pVd8e2YlS31wXbZ7vSnQH1sCA0Z6raK0U6MmwTdcTD/
    CkqJ36N/KeApDhVlLeL7ceXoRvv8+4ns54JsjqZG8ZRyWb2qjZvtbZATeS5/24bREDBU
    Jvyho9g1Z5kAbXGkZU3UN0+4NCqe/8OlRBKg4lBz/E6hTIDEzsee5g7TsZdfqJKwPen7
    J7YVL8fB9XQHW/gc45vaHt50uOPpqfmn+1r3QpbLCPf3HfGE00NlB4RSwkbJXhZKrMG7
    iKwk2rY2eZosGL5c6WBQZsPl1NSfp7JzNjNLd6u0kq9YrdptXEBkJfYuqJ8d+p2FkC1A
    0xPA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882707;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+7LTnPPHqbAJQARmANCVqu71c1ZgXNKkONRImeyPJzo=;
    b=e2NJkhuRfaaSz2nnSDrbV0HWLrqKZfk1WDZ2bgnhmMjbXOuYdXLo25pIBRYtZfKXu1
    l7gSr6O7pTQsTb7ew2XXPrhUnk5FRh3p3C4EwnH/uYpmKNqlQKBOgtpUFeJ+MUHmcQLu
    TYvmGjLFPjpjnL9Y5Xg7sZGtZyb7mmn8lAXxoBgrxwckQhrdFsfQjSqspgBztvm9X1+o
    3Wke6u37ZD4NEJO/l7vw5KCitP1Laf8lllgsY49U4a+T6WtNb3k3GPHLOHVJ8hhyeqFG
    4kqLuy9vtFZSPgFxcU2thr9bKLK9DMABTBWomLoYR/e/6u9QzLx2GqhzYtRWecw/pvgL
    DlDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882707;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+7LTnPPHqbAJQARmANCVqu71c1ZgXNKkONRImeyPJzo=;
    b=TvtFrYa+GR8k9Yp7R341aF3nqeJn2aVh9FfjXInYoKtmNTfcyUdH0Qm/bB55k6hlWz
    Fcyk4pnKMSv9z0bgiQDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8j7rYI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:45:07 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 0/2] can: isotp: backport of 2 patches that failed to apply to 5.15-stable
Date: Fri, 24 Jul 2026 10:44:57 +0200
Message-ID: <20260724084459.13523-1-socketcan@hartkopp.net>
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
upstream), which failed to apply to the 5.15-stable tree, together
with "can: isotp: serialize TX state transitions under so->rx_lock"
(commit cf070fe33bfbd1a4c21236078fadb35dd223a157 upstream) from the
same upstream series, which builds on it and would otherwise fail
for the same reason. This is the full set of 3 upstream isotp.c
patches from 7.2-rc3 minus the 1 already queued by the normal stable
process for 5.15 ("can: isotp: use unconditional synchronize_rcu()
in isotp_release()").

This assumes the 1 already-queued isotp.c patch for 5.15-stable has
landed by the time this is applied. If not, please let me know and I
will rebase.

Oliver Hartkopp (2):
  can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
  can: isotp: serialize TX state transitions under so->rx_lock

 net/can/isotp.c | 280 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 213 insertions(+), 67 deletions(-)

-- 
2.43.0

