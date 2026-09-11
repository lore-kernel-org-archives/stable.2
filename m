Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8B40E8CD
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110127; cv=none; b=t7rI3jU7rzYHv/YYLZrtRH5YCxE8+vWKtYVaV/fMwyj/kfpwoCUPZCcINtDai52qiJlYluvnrrkPShMJ+yX4neoPd9VM54YgCEZ7OSA98omE8tYcP/c+75NFeQQ5pcC934Oy8++LRlgauXWgakn/5LxzH7G0ojZk6JIsKh8EwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110127; c=relaxed/simple;
	bh=P9jxrDpaV54ySC7U0tV00k06VLLWdkHZGIv12HwM76Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sqfIF+F1Fyy1b/Xhiilb5H3+r8s4I4dja2QS4HEI7OHR/yUZbC/76KJmnWZbpfoqIfW3PyCkCiuL1WkvUhQ5nvct+9WGemT3Xw7P4BJ3ATBQ/5t2MFPu/isTlI4gMWbrQzvvVknlo1q7YWyuKjRANte46a25d0OBbqioEoWKvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu6LPUsU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu6LPUsU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so588008a12.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789110118; x=1789714918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzbEi/V1CwFrFrFwgvIKsmJKCXogoXWxxHQNHJL82hw=;
        b=lu6LPUsUXTvkcgKpWJkilaLlgYF8wSVoRgjR8RBWSPI1SvW4X8PRZSAsdnjHQgueiZ
         OQU28G0E9KZG0hTn7t8MtjpKv/++HWUKSpBwSeVMkgXIUjNbpw2cRzoDjnNcWN6Ed57K
         tXiTgoBgjbsdkEYWQ2YQxkMeYehOaYeA0+PD7lFujtnxjKHd8HA1/ogZxLHF/xMo9MYm
         Pgccqz3m2T+OForFRtIkRkCVPkT1SgUE9EySiIOuvKuELQ+MjcVqkBEhbo/xMZxoBwRa
         VduHRaTe/GCABGbaaH9KasaP4iJsLN8CEtAqyeGcrlyFJZqLE19RQCsV26vLycqJ2HkT
         6Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110118; x=1789714918;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VzbEi/V1CwFrFrFwgvIKsmJKCXogoXWxxHQNHJL82hw=;
        b=JNxNdGnGUrc588UOOz2M4c/UfmtBBtbKrJOJyAa+zfr7f9V8j39Y23SZdYrznQBC/H
         4B9wYoZth6pEzVRrBcahh3kZGWAvqBEq0O9hfwyV4RKZct9U3Kq7ueNEx0oXhi6t40Ed
         GwUiEhfT6qPFlQ+JvC/H/yMpb+Q2G+Iw5qM7QlzPI939mt2+iVrlr4ykCgkA1cdWpJM7
         I48vC7sps/8OVpqBpNWkAMwxECt30dOapRp5SNNNf1J9SMSQzFJ6OkrenQRo9aOiV2Py
         w15Ta6VF19Lrr4Hzsmq381SGO99P1BOas5IkIUWw3C9Out4jgzzZuuubpFVQQaEsDcPC
         vs6A==
X-Forwarded-Encrypted: i=1; AKwUvByQCZW9ZJqE4/cFSxZyq2T8zKPNX31hwnh7QuzjGIfUg4g8kyPtaKV4T/eMHKNYDad8f6A7cjo=@vger.kernel.org
X-Gm-Message-State: AFuF++nTyqp08FbbjLuanwmzYfIDPCfSyZ0R5ffw3Yn/C2V6FIJP29pj
	+tM/S2fb/UUgbcs6maHvNhGTEGrfkAw33NTkiEURaOYoWg00QUfJx19L
X-Gm-Gg: AYBFou31hgZKcPn/mEfbhbwZJirM4K1cN8j0DE9luv5Eup+P8QyThZcmw3N7Sjcp9lH
	zd6F8JUfFGxIOb/5TtG3thwXl68qMTzepUbM5RrRYvhBIbD0FebmisSY85IgMDfpG1ez0txAOu9
	jcLoqu50P4nX3agYJMuoOTv9qFvXA6feIKTyQQ+9aLhOYa2AeTkOHnFMfNYuq1xO8p859hXgUgU
	X75BGGhYZhs6Iyix0AXKRaTgDNbT0KMtA+nSQAjO3WOTgLOA/PkFqRtyGaI9E8Us+HmCe/rKN+8
	zNf/1O1dUCz5Brbt3iO7LuBpz2XzcnQUuGqBar75NSnw2xN84iUM8qEjKNmV0ELJ65BlGFbC9KL
	XyBK4cYMYoRpOAhQF6hAQD3KTJp8VLupg0SYHclGRyCb+bZ/OUq90VSdi7whb7S03m8YcihDjJ9
	vz80/eBAUIl5X4MM5opF3x43xPOh+CPvd5PqIdobbwfPvwHUxXUgpZiD+a3V3M2/MXN1plewbQi
	z8SmrruB9uey+FsXR8uzUJ135h0SRBdSIk=
X-Received: by 2002:a17:90b:1f8e:b0:39b:2b5a:8dc5 with SMTP id 98e67ed59e1d1-39d9bd987a6mr4612505a91.6.1789110117795;
        Fri, 11 Sep 2026 00:01:57 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d950913a6sm3531349a91.6.2026.09.11.00.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 00:01:57 -0700 (PDT)
From: henrymei <ljp1205831794@gmail.com>
X-Google-Original-From: henrymei <henrymei@tencent.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] afs: don't re-queue expired servers in afs_finished_fs_probe()
Date: Fri, 11 Sep 2026 14:59:36 +0800
Message-ID: <20260911070146.3516452-1-henrymei@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

afs_finished_fs_probe() unconditionally re-adds server->probe_link to
net->fs_probe_fast/slow when a probe round completes, while
afs_server_destroyer() removes a server from those queues at most
once: after afs_remove_server_from_cell() sets AFS_SERVER_FL_EXPIRED,
every later destroyer pass early-returns and can never dequeue again.

If the probe dispatcher dequeues a server and dispatches an async
FS.GetCapabilities probe while the destroyer is between rb_erase() and
its one-shot list_del_init() — a window the synchronous
FS.GiveUpAllCallbacks RPC stretches to a full RPC round trip when
AFS_SERVER_FL_MAY_HAVE_CB is set — the completion callback re-queues
the already-expired server *after* that one-shot dequeue.  Nothing
ever removes the entry again; the call release then drops the last
reference and the server is freed via call_rcu()/kfree() with
probe_link still linked.  The next afs_fs_probe_dispatcher() run reads
fast->probed_at and writes probe_link/ref of the freed object:

    BUG: KASAN: slab-use-after-free in afs_fs_probe_dispatcher+0x520/0x640
    Read of size 8 (fast->probed_at, fs/afs/fs_probe.c)
    refcount_t: addition on 0; use-after-free  (afs_get_server)

Skip the re-queue (and the probe-timer re-arm) when the server has
AFS_SERVER_FL_EXPIRED set.  The test sits inside the net->fs_lock
seqlock critical section: the destroyer sets EXPIRED before its own
seqlocked dequeue in program order, so any finished-probe critical
section serialised after the destroyer's is guaranteed to observe the
flag, while an earlier re-queue is still removed by the destroyer's
own list_del_init().  Live servers are unaffected: an expired server
is on the destruction path and must never be probed again.

Fixes: f6cbb368bcb0 ("afs: Actively poll fileservers to maintain NAT or firewall openings")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 fs/afs/fs_probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -80,6 +80,16 @@ static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server
 	bool responded = test_bit(AFS_ESTATE_RESPONDED, &estate->flags);
 
 	write_seqlock(&net->fs_lock);
+	if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags)) {
+		/* The server is being destroyed and afs_server_destroyer()
+		 * dequeues probe_link from the probe queues only once, so an
+		 * expired server must not be re-queued here: the entry would
+		 * outlive the server object and the next probe dispatcher
+		 * run would touch freed memory.
+		 */
+		write_sequnlock(&net->fs_lock);
+		return;
+	}
 	if (responded) {
 		list_add_tail(&server->probe_link, &net->fs_probe_slow);
 	} else {
-- 
2.43.7
