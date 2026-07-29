Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6B3AAF4A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340836; cv=none; b=qkb14LbIr6sE4qlL7Wkx9fWuO3famP73QxBCC00FzWuqLBM2jcfhiJkLwnxhXQwx/glxdT+7AseO/JwBpwpOGhiPqYYHhQuWZyFrMaZCT+Nllgz+Zr0Lj/+2BhTXhZqV77eoKGbkIGG/Wl9WIhJMxDq/vBeUl+BTOj1dRrFc+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340836; c=relaxed/simple;
	bh=wGk13vL35KwG3l0xTxS+K1aQKa+KpFO1SrTRXLK0xuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjwA4bI4rnr4ouToFlx/5m0XxcgK3MpnhSdYCV+eeKNgfpc9XIF6uLlKqxXabh6+/mFbhDcD1+3CEk2WsXdhUkQvWZbD8tdCjfMFgJ8HWSOxHS6w0/aheIx2cZU4iOV1n44EqFcxtf8dAWonvO6AQxjRTB9HgZB91GBlUXfu2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=kHzVSBmM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="kHzVSBmM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so2863a91.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785340835; x=1785945635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mi7DTUQ6I2JLv7hCuqy916IrqtjL9UgcrN2Dk8y583M=;
        b=kHzVSBmMze66yf7sXerQmvWqALFENLBE4hemGdXQ/RqF14VblyD5kxugNeUyOo6mRi
         sBbd2CvHXIqGDPiaMCHXyGgJq3WlL5OzYbUyoxNpqu6vRzKv7LfoXezR6iP62xg17D2b
         o7r6E6u0/xi/WFrHKNPA2KeoUKO+Z650Elco7LhE/6I5GqnRZSXEPVyT9FkBEtEOFp4b
         slfaOtB4mk3oh5F9pt3TSgTMv2oWgIpkxRK5L2kAid7zXkx+9nChPV2WeH1RcnU70yiU
         wKaIMbluEfn5oGrNSeEPJAyan5+XrzZqiDN/wOE2ofOP3IZfERS+N9p0qut/A5TKJYUC
         cD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340835; x=1785945635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mi7DTUQ6I2JLv7hCuqy916IrqtjL9UgcrN2Dk8y583M=;
        b=d1mZ8ocgQl6241Ca0HbkZx6dDBb6PkBwz3xUXHpZK7gKVB2myrJkJWAp/xs8zT6Ns5
         G/FRMOvqPqS9mizS4gr7ucomi6ylW2yKLGKRpklb2Ytg6T6qDiKs1MfBkw5Bkns2XN5i
         0akcV7i59NFMlHQyQrEfGFSScA23XIzG82E94xM7kKfUZ2vY2Lti3d7EBHqdStPFN0gI
         SinSPD8Np5HV6oX77A/8Eo0MdyIoZmj9xz1ir8H8TT0ZJyBqmYDprF3JB3R+Jh3YwgnE
         z0jWfD8bm8iHYPVvyHJmXMjZG3McDa3xOXQtUmTpbREyB9w3wtbVL9G44AsZ9/55SADz
         OIJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqV68IgmSdq/iynJ1MYkD4TdVLiTJvp1+eNu7//aX+HM2TW+IN2SxOx6H/83GxYfNtSQckpqPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGS/TDDMixxvW4JB2UAwkpegMQNk+fpLY7srv1Qil+SSB7+BmQ
	j6opH05dDOYr5GrJ2XJYwJbBAac1MwBZh1HxZtcaAzjvb+0SkJ7jSDuua4FlxRTjaK4=
X-Gm-Gg: AR+sD12fAlSlTBpBFBVhqCmOMZqV9i2nbvgTQt04/ZeijmF+XSF9co9/CvbM/9J8L5T
	LnNJ/88rnP6d1wicY915OgZDiI9beSqp4xbTx1Zbg5yh87JSyMuq+Y26OwO4p0/R8L4ZzPay+9Z
	5erh65RdIoybv4VGuLbh8zSjGYBVM70FA9+o04pMjL1wug5LAKh+VOR20YaYZ4rzeMCtC2j8xWg
	rSjCM/hjC+SJGDFpdO0nqcItunJLHM3nw2q67z84inxN4++C8/UgUeOJH81nDiJL7CkbQNzHkMr
	QZ9TAEZRAHRFFApCLBJ3wpVT0SXNjwCydMzaT+HJE2rUnhxmwh5PFsxJPoPN8HyVVvNh/S/ekOj
	qx8UipxJJZ4OitZ6qHGjk/LE2r4Vet4DwILD+iwgJT2kr1itHdL7wX3AuS6PgK8QLchwqw2B3Tw
	5v850MzC+TnHduNwu37cIHdCXewu8EEFH199BqhXR5WIUdqCB+XUswHjPxrzhECpKiYIVQxyadl
	p7Qjk3Gl8bKFKBp882q8QYClQlQ
X-Received: by 2002:a17:90b:4a90:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-38f8368746dmr2143556a91.13.1785340833898;
        Wed, 29 Jul 2026 09:00:33 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f12f965sm1615685a91.5.2026.07.29.09.00.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 09:00:33 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH net v3] sctp: keep chunk->transport in step with the list it is queued on
Date: Thu, 30 Jul 2026 01:00:28 +0900
Message-ID: <20260729160028.54546-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__sctp_outq_flush_rtx() moves a gap-acked chunk onto another transport's
transmitted list without updating chunk->transport:

	if (chunk->tsn_gap_acked) {
		list_move_tail(&chunk->transmitted_list,
			       &transport->transmitted);
		continue;
	}

The chunk then sits on a live transport's list while chunk->transport still
names a different one.  If that transport is removed - sctp_assoc_rm_peer()
from an ASCONF Delete-IP - sctp_transport_free() RCU-frees it and the chunk
is left with a dangling pointer.  sctp_assoc_rm_peer() scrubs
peer->transmitted and asoc->outqueue.out_chunk_list, but the chunk is on
neither.

The pointer is not followed while tsn_gap_acked is set.  A SACK that
reneges on the TSN clears the flag, and the next SACK reaches

	tchunk->transport->flight_size -= sctp_data_size(tchunk);

inside the freed transport.  KASAN reports a slab-use-after-free read in
sctp_check_transmitted(), freed from sctp_assoc_rm_peer().  Both the
removal and the SACKs come from the association peer.

Set chunk->transport at the move.  The ordinary resend path needs nothing:
it reaches its list_move_tail() only after sctp_packet_append_chunk()
returned SCTP_XMIT_OK, and __sctp_packet_append_chunk() has rebound the
chunk by then.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v3:
 - drop the redundant assignment on the ordinary resend path (Xin Long)
 - trim the commit message

v2:
 - fix the root cause in __sctp_outq_flush_rtx() rather than scrubbing the
   retransmit queue in sctp_assoc_rm_peer(), which cannot see chunks already
   migrated onto another transport's list
 - correct the Fixes tag

Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.lee@xbow.com/
Link to v2: https://lore.kernel.org/netdev/20260729124929.5885-1-baul.lee@xbow.com/

 net/sctp/outqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4..e92fb9da4647 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -650,6 +650,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q, struct sctp_packet *pkt,
 		if (chunk->tsn_gap_acked) {
 			list_move_tail(&chunk->transmitted_list,
 				       &transport->transmitted);
+			chunk->transport = transport;
 			continue;
 		}
 
-- 
2.53.0

