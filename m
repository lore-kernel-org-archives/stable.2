Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674051DE06;
	Fri, 18 Sep 2026 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757559; cv=none; b=Jz2/X86Y4I9kgz9T9Uccip+CnSoj+pXn1UDYtUEyg/3dfsCB24HEeuJJKCAmdJ4uUYkQD6jpeaF0Sw5JKhOhs2n4SwIkATdQYm2tEjTAYx+lVQSNn1/s6XVAa0IHhbCFoIzkfRlg8pW3Dt3zXf1MfdrlLxb0VsQVpUM+HuvY3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757559; c=relaxed/simple;
	bh=jSplCp608W8zvy/HRNFhJGdjTGJXQewtsjhDhe7O3fk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjaOglGsIZspxYj6W5FTpI0BHbmubZLR9yPcips9Y8LJC2Xml+m0fx23wycFEan1KthVqJrIm8eUouTA1hnjf7PPXaij1nWph1L8uQ3VJZ4nuR3E3kE2wm2Zhg5qs9iz494JeU3BLAKXACmg28lgNlvE8dOD2xt5uzoX745cqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=dc+Wqg4n; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="dc+Wqg4n"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789757534; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HaB/sL6M7ENFIsdooYd7DiubYpOPtvusj4eMYtWGeO4=;
	b=dc+Wqg4nxJ2yetUsXBBuCQoU1MPE9Yeg6ZZXr/dZfPW0iALZea7/l7AAGnZY+9B2z3on1B/6BtF5FDQNobYqMY2lrJRFM0wHAEUftk1A3vFJJDiVJFBXx8fu2xp2CIp+QWCUgFsqXA416Jvhiyluspw3MGKLBkS6m8Dn30oiiwg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07598486|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0147701-0.00349097-0.981739;FP=18298854939386791537|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.jH0QdR7_1789757532;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jH0QdR7_1789757532 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 19 Sep 2026 02:52:13 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: horms@kernel.org,
	netdev@vger.kernel.org,
	netdev-bot+sashiko@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ilane@ti.com,
	david@ixit.cz,
	linville@tuxdriver.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: avoid unbounded skb allocation when max_pkt_payload_len is zero
Date: Sat, 19 Sep 2026 02:49:30 +0800
Message-ID: <20260918185209.2675909-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917132433.GE51261@horms.kernel.org>
References: <20260913101309.891633-1-liuc63@xiaopeng.com> <178938411495.22033.4311942083485691702@kernel.org> <20260917132433.GE51261@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Simon,

Thanks for stepping in. Answering this is on me, and v2, posted
right after this mail, covers the other form.

To your question: no, I don't think any of the three should block
this patch. The TOCTOU race and the conn_info lifetime problem are
pre-existing and this patch widens neither. I'd rather fix them in
follow-ups than fold a lifetime fix into a 5-line bounds check.

On the UAF, you wrote that it "may actually be made worse" by
this patch. I don't see how. The guard adds no dereference the
loop doesn't already perform: with the check removed, the next
iteration still reads the same field through the same unlocked
pointer, and the list walk is unlocked either way. If you have a
concrete window in mind, please spell it out.

> - [High] Incomplete fix: a controller-supplied
>   conn_info->max_pkt_payload_len of 0 (or 1) is still consumed by
>   nci_hci_send_data() in net/nfc/nci/hci.c ...

Agreed, pre-existing and not made worse by this patch. Sashiko is
right that "nci_queue_tx_data_frags() is the only place that loops"
was too broad; nci_hci_send_data() loops over the same field. Two
scope facts, though: the RF path uses ndev->rf_conn_info (allocated
in nci_rf_disc_rsp_packet(), limit set from ntf.max_data_pkt_payload_size
in nci_rf_intf_activated_ntf_packet()), while the HCI path uses
ndev->hci_dev->conn_info (allocated in
nci_core_conn_create_rsp_packet(), limit set from
rsp->max_ctrl_pkt_payload_len). Different objects, so the patch
doesn't miss the bug it fixes, but the sentence oversold it. v2
rewords it.

The new check can still reject a zero on the HCI path, but that
buys little. For non-empty payloads the unsigned underflow in the
loop above drives len past skb->end into skb_over_panic() -> BUG()
before nci_send_data() is ever called, and what does reach
nci_send_data() gets there only after skb_put_data() has run. So
the path needs its own fix.

That fix belongs where the response is parsed, before the conn_info
is published. rsp->max_ctrl_pkt_payload_len is available as soon as
rsp is set up (rsp.c:315); the object is allocated after that, and
is on ndev->conn_info_list (rsp.c:342) and installed as
ndev->hci_dev->conn_info (rsp.c:345) before the field is written
(rsp.c:348). A check at parse time means the object is never
published, nothing to unwind. A check at the assignment comes too
late: the object is already linked and already pointed at, and the
existing error path (free_conn_info, rsp.c:352) only covers the
pre-list_add allocation failure, with no list_del and no clearing
of hci_dev->conn_info. A zero there can only be the controller
reporting a broken limit, so rejecting the response outright is
the right call.

The RF path is the opposite case. nci_rf_disc_rsp_packet()
devm_kzallocs rf_conn_info, so zero is its legitimate initial
state, the "not yet activated" value, not something the controller
reported. The activation notification can't cover that window, and
rejecting a zero there only restores it for the next transmitter.
The reproducer walks exactly this path: RF_DISCOVER_RSP creates
rf_conn_info, the injected ACTIVATED_NTF stores zero, the target
still activates, the next data frame spins.

The entry path doesn't help either. nci_send_data() takes the
non-fragmenting branch only for skb->len <= max_pkt_payload_len,
so with a zero limit a non-empty frame reaches the fragmentation
loop no matter what the writers do. The check at the point of use
covers every producer of a zero limit: initial state, the
notification, any future writer. That's why it lives there for RF
and won't for HCI.

The arithmetic in nci_hci_send_data() needs its own fix regardless.
With max_pkt_payload_len 0 or 1, i + max_pkt_payload_len -
(skb->len + 1) is evaluated unsigned and wraps, the "last packet"
branch is always taken, len becomes the whole payload, and
skb_put_data() runs past skb->end into skb_over_panic() -> BUG()
instead of merely spinning. A plain != 0 test wouldn't cover that.
I'll send the arithmetic fix plus the parse-time zero check for
that path.

> - [High] TOCTOU: the new guard reads conn_info->max_pkt_payload_len
>   once but the fragmentation loop re-reads it on every iteration.

Agreed, the window is real and pre-existing. I've folded Sashiko's
snapshot into v2 rather than deferring it: the loop re-reads the
field either way, so the race itself is old, but the new check
shouldn't be bypassable by the store it guards. v2 snapshots the
field once with READ_ONCE() and uses the snapshot for both the
check and the min_t() bound.

> Pre-existing issues:
> - [High] Use-after-free of struct nci_conn_info ...

Agreed. Unlocked list walk, devm_kfree() straight from the rx
worker, and nci_rsp_packet() dispatching CORE_CONN_CLOSE_RSP with
no outstanding command. The HCI side has the same shape:
nci_core_conn_close_rsp_packet() clears ndev->rf_conn_info but
leaves ndev->hci_dev->conn_info (written only at rsp.c:345, never
cleared) pointing at the freed object. I'll do the lifetime work
as its own series rather than smuggle it into a 5-line bounds fix.

v2 follows this mail with the changelog correction and the
READ_ONCE() snapshot; the HCI loop gets its own patch after that,
then the lifetime series.

Thanks,

Liu Chao
