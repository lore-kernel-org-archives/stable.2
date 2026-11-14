Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657557;
	b=Tn+z8g8SpbCGRZMwggwwWXQ3iLuD0RSvHXrv2ptDshHUJK3lluiOVvCMWpQpBhmIYH01
	 gDS/R1HCfNTW9n2tsSUOCIO3Qd9QB1aaYeoPs215JUFyeF9npWfCnQgN9T01eEr7eZ3YJ
	 buEkSe8HLIGvIRcYE7QNG8baZgkQiwoVr8W2ixMd1HwbdUNeJnqox9Un9t+DLgA5LgwuR
	 L1AFxt3yeDrVQSmI+tbvAP2MzHKUjec1ceZwVLktOY1UGRef4mrtfKHdSgJgaJIIZ5xYu
	 m/+UENS3vmCZOVJlGUuR5VFVP4+AdiAwZDoRMwKBYktKYjwuQgyfqROOGOTfJAfvJpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657557;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=SGPTqsO6MgAYzZAWhqQxqhnt7jBagpsmDsCAnKu5nao=;
	b=Be0r7pALKXpRUlOjsCxpV4ZQv0S1RpqDEYMW+htTuuxp5x+d/9+r/XhMawkDplc19hXi
	 RpT72axOrWfj2RL3KM9Q3XHy3PQXrn7MaO8Qx3McBJ/Yt1MhlRVjmnUQVErmdCmsPYqA/
	 Vpx4pTO+VBDONQCwndbpyeZrZhx1PcLshrFW6icEuaZnooKQ7bFwLIbI4dNksSJ2fjLyM
	 lm+EOWB4bIXMElgfsJ6Ep6V+O8NR9vmGxsxOVvmsi/xApiWujplY3WjeMv4CdFOnIkGuv
	 bPcxxOJcbLITGc2sU63m13lHes9FZlSbdiqYv9fTM9zfuY4MRguT4hWgxfnbB9UvWdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7vwetrx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057F606A338;
	Sat, 14 Nov 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7vwetrx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794657556;
	b=04s91OPQNRyVs09VVJRhJcKLGFeR1jyG1DQTkf1jIbTsF9wfP+bgRjKlu3U8VOWaIi8E
	 g3SCPVfklehPr0xgFTcfS/V1eBMffgj+FVv/xgNBF8Pqo+x/XSNeh2phQc2LhzkjYGUgF
	 cjMBabiuRAfPjJRkfJ8LqkUBFq5yZihCUHk2oM0uy05o5jOwrHLJ83tBfkjOtyEPbv5ow
	 7VsmLFG7KGpurBlrW4lgl3GFS7knAvbF+Nwq5W1apLrfkROOzd5Hib3lBEHnVxrJD7FeL
	 ro8ovkiethvmkEGkt8HzXaMGugcmuVKV0yXDg0yXjno30DKK6765We06ozPj++TCXYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794657556;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=SGPTqsO6MgAYzZAWhqQxqhnt7jBagpsmDsCAnKu5nao=;
	b=CKC05pA1VU2pF3yMKIqP/seHa6/Ri4inRp/7GmR2CXR6dt6quVxzvMGs4ViGlGc99cUh
	 BgRf1FHkt02AFKt6MenqVjE58ctMixZsCU99G9z3jjE8B3K21h/+QzZXZLti2hQIEqhJa
	 /1DDObn6vwH+dI7gm+dwvG1TfXg7b+5KGca/PoC+sot4lqgVDtPC1Pi9QMLzNg/JxFnZ1
	 pgMUyULIJsKNDl1y6cUlg+5BAQtKQOXYXeTlpDsNlFVz8gqJniP04VDAOk3nQDf2l7nII
	 sCxg//5E0LMqRUE+owCYrAtAw01rs/FtYLzfu7B7vhVJlPNg6Ny7Z5E4cAE7qkanffw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B97EF1F000C5;
	Sat, 14 Nov 2026 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657556;
	bh=SGPTqsO6MgAYzZAWhqQxqhnt7jBagpsmDsCAnKu5nao=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=J7vwetrxyhgDc1bMZ02w0+zfMKCB8p51gWPYAribfNwcqQ0fjeAP/YrgjjaE9SELV
	 imGJVzErQWwi6z0g7Lm4unkWamVcRcWMyTJGHwefaTfDeNuUqnLeHOs5zughJqeZX2
	 IyUTUYn7CkBg3rrt/fXt9ZdCR2FMc3VqP8AjNLV8ak9XdrWMTi/++R44vx5IgiDFwP
	 U74rqQT1Bq65FhqnYjccM/iZoVIIHHc5C5pTaax5CXcN22c77/d/caQ6JlL7tSiHt/
	 3egI5cTjDLaLG6MtE5w6xvEAGslnyo18WO0RGMKSmEIyg3xVzcCaFhxgASHktdb6VW
	 o8tno/znEtRyw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1953149D63;
	Sat, 14 Nov 2026 11:59:15 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Subject: [PATCH net v6 0/2] vsock/bpf: fix recvmsg deadlock and
 zero-length, OOB, errqueue reads
Date: Sat, 14 Nov 2026 12:59:13 +0100
Message-Id: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTU7DMBAF4KtUXmM0YztO3FXvgVj4Z0zcorSyg
 wWqcnfcsKBUEcs38+abKyuUExW2311ZpppKOk8t6Kcd86Od3oin0DITIDQCID+5UXLkIASP6ZN
 XwUlGVMKAVmhZu7tkapvVfGETzez1Z1g+3JH8fNNutTGV+Zy/1s8V1/I/Tyq27KMl0w0WTa8P9
 B5spudAq1/lnSCGLUFy4M5D3wknggzuUVC/AoLeElQTfB+k7kEOqMKj0N0LZkvoWlbB2AgqQrR
 /hGVZvgFGlmr6jwEAAA==
X-Change-ID: 20261001-kbh3-1-022-fix-v2-e3f14290641a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794657554; l=3483;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=oCUVwPiXCeqIHuwbjnx61UNm7RpiSOaK8qnCMX86plA=;
 b=SBtY0Q0J4mm6Q5RNdLEvY46voh9guicx+y7o6EeKYnrkbLGQroplH/ZgLm0FekY0GT9EANt5k
 fyggqJnITvNDzzWXP1kUw+f8D9weMdXgDvXxpdIsdCHH6H3Nhvt//FA
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de

On a vsock socket in a sockmap, a blocking recv() deadlocks with the
virtio delivery worker and stops all vsock rx on that worker, and
zero-length, MSG_OOB and MSG_ERRQUEUE reads spin with the lock held,
wait, or consume stream bytes. Both come from the commit that added
sockmap support. Patch 1 hands those reads to __vsock_recvmsg(), and
patch 2 releases the lock around the wait and makes the wait loop.

The deadlock and the MSG_ERRQUEUE case were found with the help of
Anthropic's Claude, with Stefano adding the stream-byte part; the other
cases come from the netdev Sashiko reviews and Alexei. The reproducers
are available on request.

Changes in v6:
- Split into two patches, the zero-length, MSG_OOB and MSG_ERRQUEUE
  early return first, as Stefano preferred; the deadlock fix does not
  need it. This is the reverse of the v3 and v4 order, and 2/2 no
  longer argues for one patch.
- 2/2: check the transport in the wait loop before the data, so a
  reader that wakes after a failed connect() has dropped the transport
  no longer calls the data check, which warns (netdev Sashiko review).
  I check the transport instead of swapping the two tests because
  hv_sock reports the peer's FIN from its has_data() callback. The
  WARN_ON_ONCE() at the top of vsock_bpf_recvmsg() is unchanged.
- 2/2: reword the comment above vsock_rx_done() (Sashiko).
- 2/2: leave Sashiko's signal-and-timeout point as is: such a reader
  gets -EAGAIN where a native one gets -EINTR (see my v5 reply).
- Rebase onto current net.
- Link to v5: https://patch.msgid.link/20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de

Changes in v5: one patch on Alexei's approach, falling back to
__vsock_recvmsg() instead of copying its return values, which also
replaced the v4 comments; covers the Sashiko review of v4; don't cite
the selftests as coverage of the wait (Alexei).
Changes in v4: comments, one data <= 0 check and message changes
(Stefano); rebase; retest with a new dataless-wakeup reproducer.
Changes in v3: split into two patches after Michal's note; end the
wait after a reset read with SO_ERROR, and MSG_OOB returns -EOPNOTSUPP
(Sashiko).
Changes in v2: loop in the wait and stop on sk_err and peer shutdown,
len == 0 guard (Sashiko); MSG_ERRQUEUE to the native path.

Not tested: the lost-transport case and SHUT_RD with a pending socket
error (both checked in the code only), transports other than
virtio-vsock (PCI) and vsock-loopback, more than one run per
reproducer, a sockmap delete while a reader sleeps, the signal and
timeout case above, the vmtest.sh ns_* tests, W=1 builds beyond
vsock_bpf.o, the selftests on patch 1 alone, and anything after the
rebase: the runs were on the previous net head, and the rebase leaves
vsock_bpf.c unchanged.
Still left for separate patches, as in v5: data that sits only in
psock->ingress_skb (the loop can now reach that case after a wakeup
without data), and READ_ONCE()/WRITE_ONCE() for the lockless accesses.

---
Jerome Mohm (2):
      vsock/bpf: fix zero-length, MSG_OOB and MSG_ERRQUEUE reads
      vsock/bpf: release sock lock while waiting for data in recvmsg

 net/vmw_vsock/vsock_bpf.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)
---
base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
change-id: 20261001-kbh3-1-022-fix-v2-e3f14290641a

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


