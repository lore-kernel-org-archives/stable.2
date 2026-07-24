Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52823E8323
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882675; cv=pass; b=dgDUyDXip2bxQrh9nqFgAYcbP6PPtOhbk6BrW/O1TQeaR/fF5v3lIi6WhuU5BHLltW5awxa/+Gha9y40UPNLmHkfq6hGr16ZhKILh1T4Tt4ltSLcdNo6kcL/OUTMTqSFGJocWqRtaJypwsWGEmR2ugKutC3XaD/V13593rW+pzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882675; c=relaxed/simple;
	bh=bXqs17wSoAYLgVRezm7OvPRchiHNF5rDSxj9TSjaA2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXku3/sLChn/MH64zaUWMakSFrxd/f4wFFyoeyrhbaPRfFt3vYJygMm2G72RAy+q0TXtrCJbuQdX+Gx1Hz9AxlY5xuBF92AUE4Am6xfZNsX6bRPUfYjlna28uZ2VhdctiV4N2nN9FvKYwA8t207Dl5lfZN2GMcyR4bOODlu1Kn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=q2Rk+eJU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nl3/NAXD; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="q2Rk+eJU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nl3/NAXD"
ARC-Seal: i=1; a=rsa-sha256; t=1784882671; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L+Cevv12//8ysoHUUNhGEcza7nhr7awa8wcj672UV2KQzU2pkd7HGac3PkuSG7Lu8E
    vBD2dIKQSsf34L9IxHGCHT0LVC+/vfpIfTS7UnMUMrcv16eFgDFa0sDfnFPD9HRHQxUs
    Su8PkzT3jMt10StSQcqx/smuvh664cXRL1ZYlQ8qXibp0xobb8xQiQQe0ZQtwyHdkX9c
    KmiJ1IqgC0DFZLvNz8Vg1f8PNHMxIJSYcYQe4Hu3bv6Ll5xe6mq3SP9PhSEzPE41OgCM
    s/GyOfOjvjtB+wssnVKgwBr+X5XH3uY2SRA76mZceE5uav6l5052QbWlWIi4Xdg0JNSH
    45Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882671;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=m1+cj3FQL+nCJsiGLUe5ykHh6FvyzELxuVNv1ey4zYE=;
    b=SAOC8iwmT+D2kk4PEC7722gsAlY2afElTTrta7/6v6XSYZ0ZNqWMUuV8ehtZeL3Vf6
    vvvIBmil8B8NVJAh/7MwD12j6xrr/0UCHae5+GXvd8as+Y8FJ5lOX0u/o9hBQLLA9tRL
    UIegTvJunkEgiJ0P4EnUEhf9pjjkKLb9o9J/7XiM/d8Jvrev5lijA7wjhgqko8m3ik9P
    oXtmkH2/GGPqTfGfpVNZjnCWIGvH9r64I6vb//pZG75NRgjqLvrn5ClCv73Te5whZBoD
    +XfcLlkNAxaSznoVcEVvX5zzwbgSzpfqEtGOlUW4DH9u1WwbHHMnHygC4Vjjvk8WdGvO
    uXhQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882671;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=m1+cj3FQL+nCJsiGLUe5ykHh6FvyzELxuVNv1ey4zYE=;
    b=q2Rk+eJUgpnccch7nM+b7h47g6VzEBN9kxx9wkFu0mn/omDrbg0O1OCyjCoRBzdE6v
    dUEHTcaYlU7GdgNHXG7VZd/l+Yhgr4j83EaxOiSAfOQwYcXc2WfLth+Cjughwjxr2Lam
    kmhoMNEXU+JJ82c9svIbBTUuHLcE6Axd+JpSLB7VPxlc2gurKzlypPgrWTQevdjW4sa6
    /yiGRqz+3TJ1FwDe0yK03SzB8iUazY3IRFnHf8DvctxKw/aANBSRj0fDYPvVHwhZiwOX
    Ntbyhdhr9ziGpa7PPf7U2JROsi+GEpwEbwnE/zzYDNU0m6OvidQ1TMfdWxNUGgTX0drR
    Ir+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882671;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=m1+cj3FQL+nCJsiGLUe5ykHh6FvyzELxuVNv1ey4zYE=;
    b=nl3/NAXDtHFBWzMcpeI6PjffAGKoLJWAsEsSQkRXysMYheuz2ZGwNS/X5R8ZcM0apX
    M5DdrBMnARn92LRskYBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8iVrY3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:44:31 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 0/2] can: isotp: backport of 2 patches that failed to apply to 5.10-stable
Date: Fri, 24 Jul 2026 10:44:22 +0200
Message-ID: <20260724084425.13382-1-socketcan@hartkopp.net>
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
upstream), which failed to apply to the 5.10-stable tree, together
with "can: isotp: serialize TX state transitions under so->rx_lock"
(commit cf070fe33bfbd1a4c21236078fadb35dd223a157 upstream) from the
same upstream series, which builds on it and would otherwise fail
for the same reason. This is the full set of 3 upstream isotp.c
patches from 7.2-rc3 minus the 1 already queued by the normal stable
process for 5.10 ("can: isotp: use unconditional synchronize_rcu()
in isotp_release()").

This assumes the 1 already-queued isotp.c patch for 5.10-stable has
landed by the time this is applied. If not, please let me know and I
will rebase.

Oliver Hartkopp (2):
  can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
  can: isotp: serialize TX state transitions under so->rx_lock

 net/can/isotp.c | 280 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 213 insertions(+), 67 deletions(-)

-- 
2.43.0

