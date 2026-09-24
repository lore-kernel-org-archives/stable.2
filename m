Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E2424D72
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234202; cv=none; b=kGsyRGilwuzYk7r7xsstW/vzuZ/KEcmaafIk1NJzJzfhyy1ayJYLBtLw2L8XpIcKrWHI1Xkp/nj68HTH5o/dA4zUbPmAh1tHoy+jzDS9uMBLdAwAI0H4PGdBq+MqZ/LeAva0Nbsozqru59LG0GtDResr1QvG7AZJv4Z+ohPNkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234202; c=relaxed/simple;
	bh=GTEVgAingNMNvYRd0hOrqYY22SEBjqYKvF61JqVY9do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eqe0w2CZiqXqnqDHQROBR8OhNIsoZMSs2gNnUxG8vHas1KEXFsMIoMgtbu4YbEfJCseZzreyYX2kPrqWeKxwTCfSY2Vdto0f5Ul07DN89t4wCYahZKs75eSf8SQHuSqqksJcbVO7ZZj6SsY2/JGLPQG2XpKjJvKkR9GK6xR+7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxCcrb3u; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxCcrb3u"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1297089a91.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234191; x=1790838991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DEBq3oR2dxLOGmSLGFiZZ9aV+cM/ZzcBmqDLieFfw5A=;
        b=FxCcrb3uD6nrom6kzH+joZQKgjX+gQTMX0Tg9kLJ5tp5ChTuUxTCnDqqRvsSx4V+GN
         lTt9XfKGvcd13EDV1E+I49+0vLMOD5fAv0gbWfDA3TNwsg8NLRPL2no5vGNElNaSrVpf
         TSvO90CS6NVy6mULmMGJmbbi226nKXaolR6gl10tVUzutRX0jRfWtEO0Y5ar+NAHxJ89
         XUGf9p5MXnEaxrT2/ia3kLyb6ISqxovLoqEcT5xJE4jlZmW8429/7J+OFacD+vBWuiSW
         Kl9pGv7RX1o0nqJ81pMXXav7a5VDv7+xGIJ3iPRWLD+c68tG6b4aBSSuold3tnLuspM9
         93Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234191; x=1790838991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DEBq3oR2dxLOGmSLGFiZZ9aV+cM/ZzcBmqDLieFfw5A=;
        b=i3EW8eYA+tvtTpnQai80BXG9oibTK2HeIw9Gz2WNXzEBFcm6KEYnBR9WEakLISdgxa
         eUUUrcuZUaQAfyQVMU3/I2mx+Ock8r5Hx9+PVEuOVGtIM9yoQxetqUMbV8WF+NOLxrbl
         c3sxcqDKNkZJSg89HGxpoLSNbgMatKe3QpH4OQvIMiwk4zOixOWofTzWwQ+UZFrp1sJW
         SGtVFTcG3riHo6LW+8Q1aWBg4+m4+SD2Fy5QmkhWZfRLfQWOiXPqZBHDczmQbwKLgIpx
         MV85R61Go2gzuSsQFhW+dDRYFvPhWDIL/1Mkaf24AR0UG8FKJbPgGhsg6vsM3BJKc40z
         Xpww==
X-Forwarded-Encrypted: i=1; AKwUvBz6w1u0qSJJnbExKYtunv/XUxi7oHleIRJT6Ijm/RsegMManiVMv6pk7Y8dNllZzFIusW8vr+o=@vger.kernel.org
X-Gm-Message-State: AFuF++kie0234HunHLafT1A+ti3rLlmbm2wvjWS+PrIGr1accZftoju8
	7g4RNPq2ur/cQ0Rrp3YqId6KG6+aR2fa0tcl0yKb6JjZ1rgJy0pgKzuLdzFLY+Xn
X-Gm-Gg: AYBFou2ob9uXijfQaMykfHVQo5sxbUK+58vCjWuxpvcPJYzOs2LAAxkpg/mAhLDZI03
	LNUOQ/uF4bD6xkvvVeQKvr6wltCyTjzdtjizXUeYktspSNM/73hxpFq4NjwBQ/o/1I79dMmnKrF
	c+TUuf7yWXWQpzW6Wb55upZz09xP2tcrtyzBj0YkFBfqWaRr4D9qe56OFB5lvN8CW8G8AScETjd
	g/qOz1SWc7NaEXiqvAncC53iCMpdcy/sKsGJI2IQ1qjFMjQWfWhLF6Wc/KYOAlhCkVIwC6DdfxM
	c79jio0A8OOkCoQSeh4p4zEoBbcWY2MhHPt/lx0Ss6u32AoW8RJmOc49iF3R++Wg8nIWXj1VZEq
	93Bd3rgMJ5wTwjxnjb9y2FvFMay+ZhFmEXM9Mf3qpiKYX0ydEW4somanmCwlzDlHSQVtJXZkzda
	tYmbYYCpzewUuf6oLpLYxXSEmYL+nA7sJ47HUbqM3WQ0lAzevJ2Jm2zMU/IFSMs3Ot6So7t0FOZ
	58JT7iivOMh29jvJ1hWTjRrMdEMXtHulv3M0uTLgnGPDTFiWnuuOJuih53chntA+/+Ng49A1bot
	IG9SvvYJFw==
X-Received: by 2002:a17:90b:3e87:b0:39e:6a80:dda0 with SMTP id 98e67ed59e1d1-3a09872e15cmr1359457a91.39.1790234190967;
        Thu, 24 Sep 2026 00:16:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa00sm4003402a91.5.2026.09.24.00.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:16:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2 0/2] af_unix: fix inq_len accounting and consumed OOB skb handling in unix_stream_read_skb()
Date: Thu, 24 Sep 2026 07:16:27 +0000
Message-ID: <20260924071629.2683160-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two OOB skb handling bugs in AF_UNIX stream sockets:

1. Decrement u->inq_len by 1 when manage_oob() unlinks an unread OOB skb,
   preventing u->inq_len from remaining permanently inflated and causing
   SIOCINQ / FIONREAD to report a stale positive byte count on an empty
   socket.
2. Skip zero-length consumed OOB skbs (after releasing SCM rights via
   unix_orphan_scm()) and pull UNIXCB(skb).consumed bytes via pskb_pull()
   in unix_stream_read_skb(), preventing BPF sockmap from re-delivering
   already consumed OOB bytes or partially consumed skb prefixes.

Changes in v2:
- Split into a 2-patch series as requested by Kuniyuki Iwashima.
- Update Fixes: tag to f4e1fb04c123 ("af_unix: Use cached value for
  SOCK_STREAM in unix_inq_len().").
- Call unix_orphan_scm(sk, skb) before consume_skb(skb) and use
  pskb_pull() instead of skb_pull() to safely handle non-linear paged skbs
  as noted by Sashiko.

Hui Peng (2):
  af_unix: decrement u->inq_len when skipping unread OOB skb in manage_oob()
  af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()

 net/unix/af_unix.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
