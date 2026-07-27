Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408D3BED7D;
	Mon, 27 Jul 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148263; cv=none; b=O4xqdwgtfuDibQTOijeGk2uAg/bt7sHyGUlEXo4idz3qp8/U2d9+t8ziuY6WGEbT3NjA7MGf5+QoCxP4tm86BBSnXBMco8QCa6x1cxsGIZURD2fJ3RLVoQEQJqyEbdSmJIp2mWYUGib8tQ+p5gGbBbOw+TRCrhDOXp8Rjt72bRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148263; c=relaxed/simple;
	bh=to9PBPAgqzQtwrj/xu9pXDPVNpLlo723lWlyCRiy2SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXg7aBX3PyvueyTGnX1kon0bOqstBYzgiU82Cv3cTgPBJPErKYX/MGRq0qQgj1TfcX0rKsaoFbWSDfdNhXiO+HVpgzRdGlGGhxzlGcMMiFLI/ApniF3GZO+yUJmKybPzWljlxygTyZflKP8V5vDk96zGD6EKnax4zYmJvizmNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=m+PApdSW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeu31dwr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="m+PApdSW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeu31dwr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1012EEC01E8;
	Mon, 27 Jul 2026 06:30:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jul 2026 06:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785148251; x=
	1785234651; bh=62xXIsLKNu0RPA+OUccAzZfHaVO7nDCero1BquD50C8=; b=m
	+PApdSWqysOgu0iS1S5+9zEyx0owxUtkY9/SGrgAuy7PvTw0bnxThH4Fa1GdiIhw
	ZXDvQxAm+MohztNvtdvG1zRUf+smGQO73PcYO4HAA/K4c7YRjwhaujg4oAbL0VFl
	Z4/HzJNErdqOO3r0cJYyL41mpZb6WVknde8z7AbmhdgNcmCbiqPk70cQIEn96bfk
	3q4/9QVVTTxIlwOeOZQfrsP+aCOHlqUgt92y7Eg7dAEIiEt4oKCU6fDHY8g8K4ch
	/yQPGOHxSWnbGaEajNnBMngwhgA0LVcOGA8q3Pd2lDtSfhrKOyuHjNqr19bBOdhN
	PCwhK+zxmgFXHh2C2EHAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785148251; x=1785234651; bh=62xXIsLKNu0RPA+OUccAzZfHaVO7nDCero1
	BquD50C8=; b=jeu31dwrlzqW0ndrMqWlT236sl0v7xlwJG2VsXr25GDqoQwA+LX
	PXJWsIHVLvPFUddhKNot1eaOyWdpWy0crVllwqqjWaRq25uqHP+x56oU0zB33aLh
	JhVJ4Lr0hU8j93QMysfRvd/ZX9UQDYvJVCFdhe0VuSug4idjJz48CPyvzZ+g2XJn
	MA1f81P42Ml7d16INF8C2pR1UoBZlfovR03JxeGr2sg9S2dMsweTHMs1wq97O6Jk
	zQyYZm7rmbZXEhikoKJGb65gvipDGxbduYZ98NN3biW4uukgLixt3pahi/ZDgyVS
	wCqujqq3gKgis/P4KhMF2Sko9pVa/Xiy7qQ==
X-ME-Sender: <xms:WjNnaiMVY-MBLUT0eZxL9r2fkH5FAsmUyaxkEofF7NnLRPf70q8WKw>
    <xme:WjNnas9vKY3ZpAeoOyHYnH_OExLYLYrS1Peps5xObmGgnQ7JQFtUwXoKHzkUmBDR3
    d5g2qx6B3bvKp0tDQ3KFs_Ns4SOq4_WV92siF_uBV8WL62rZhyzhSa1>
X-ME-Received: <xmr:WjNnarflr2xdwCbROEZoflJbwjXnt-su2ZWU7Y33WhFwWh8wGDQwSEbf9o4>
X-ME-Proxy-Cause: dmFkZTE8P/0KHEclaEnL8ilGwpIhu7np1u9ll2evolM0JR24lfdg/rWshD4GHU53TdtySf
    GIZpJbK4fwqAAgDVJeFPn3hJ490pWFRY2nhxntohUgjHUf89909l12nqdDYJ1dqVNID1vo
    D8Gya9jCCJALykCrsugs4PghN4a//7fu6D7tNGSc4b7RbUqqAORbL71uy3QcquLx8LExdm
    GF/2L2+2V6bgeBmbPso761Q8GUH8s9zMkxmgg+hy4QKxxxOU/ZUfQeUAYp821pXEtJVqKw
    qmXgwLpLbu0dH7j7ZhtUkJQ8H0uA+yI2tG9hhRTXFFSUto1FMB261mEyZ0YRYCkZIOEveL
    aOt9F/+siaJ7wjCYf1NvcWYiLrfukku/qeHjxPu4lq+ljM788N59xtxR/MpSYPKpFRFPo7
    5kLQ4viBZu9mSQGD4HNSvSgzQAdyHHiBv6t98Xvo7zDt/ojWuwR6UtuHwf9vcnesGOrrYt
    b1tDmylXu6RLnNTLPLNUpHJy0BH0JdVl86HA3jeKMsqKn8TodNeJx7nVCXeuwDqsUGQ+fd
    SjYjPL3IXfJR7Vf7jmwWxUwW0ABQfCyGNVBP4u8EQuG+2RwL1V9lOJIeJoqXr25m+iCen0
    OP7/aQLd1Bq/d+9GfrTD00TJDaskgRoT3c4DTFeQiNP9cSW5On7EfOjtQI7Q
X-ME-Proxy: <xmx:WjNnajwZr_jL-ekli7Zy0zll5AKpknOjOlfdzvPCIP6fdosu2Qa5_A>
    <xmx:WjNnaoJ7pwVe9UgwYePXCM1NWOy45mH0DcJkI3zuEy3xX8BrL2holQ>
    <xmx:WjNnatEXq4ZrwwLz40N-NUOuQPPqGpG38KldXR1rTfEaflVEOQEYRQ>
    <xmx:WjNnas8Za8KCiKP85T7zwlZYuJ6q-x8axAodSVQ19UgqUX_1i_bT8w>
    <xmx:WzNnavl6M5YE0k7Ec3DB3tH4g3h5uI1t7CSYd5SOIlOa96qXLQglbQrX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 06:30:50 -0400 (EDT)
Date: Mon, 27 Jul 2026 12:30:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: chanyoung <ppoo1220@gmail.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] tls: don't over-fill the plaintext sk_msg ring
 in tls_sw_sendmsg_splice()
Message-ID: <amczWCEaLMVQWZp8@krikkit>
References: <20260726105556.2719227-1-ppoo1220@gmail.com>
 <20260726105556.2719227-2-ppoo1220@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726105556.2719227-2-ppoo1220@gmail.com>

2026-07-26, 19:55:55 +0900, chanyoung wrote:
> tls_sw_sendmsg_splice() appends pages to the open record's plaintext
> sk_msg ring with sk_msg_page_add(), which performs no fullness check of
> its own, and the loop only tests sk_msg_full() at the bottom of its
> do-while.
> 
> If the ring is already full when the function is entered, the first

This should never happen. We need to fix whatever path leads to that
invalid condition.

As you write in the cover letter:

    The ring is left full and unpushed across a syscall by the copy path,
    which does not set full_record when the fragment it adds is the one that
    exactly fills the ring.

That's what we should fix.

Which I think would be:


diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d4afc90fd796..d2e399be8ef6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -832,6 +832,14 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		if (!sk_stream_memory_free(sk))
 			goto wait_for_sndbuf;
 
+		/* open record may be full if we couldn't push it in the last sendmsg call */
+		if (sk_msg_full(msg_pl)) {
+			full_record = true;
+			sk_msg_trim(sk, msg_en,
+				    msg_pl->sg.size + prot->overhead_size);
+			goto copied;
+		}
+
 alloc_encrypted:
 		ret = tls_alloc_encrypted_msg(sk, required_size);
 		if (ret) {
@@ -921,6 +929,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 						       msg_pl, try_to_copy);
 			if (ret < 0)
 				goto trim_sgl;
+
+			if (sk_msg_full(msg_pl)) {
+				full_record = true;
+				sk_msg_trim(sk, msg_en,
+					    msg_pl->sg.size + prot->overhead_size);
+			}
 		}
 
 		/* Open records defined only if successfully copied, otherwise



> sk_msg_page_add() writes the reserved slot and sk_msg_iter_next() wraps
> sg.end around to sg.start.  sk_msg_iter_dist() then returns 0, so
> sk_msg_full() reports the ring as empty, the loop keeps running, and each
> further add overwrites a live entry without putting its page reference
> while sg.size keeps growing.  sg.size is then larger than the data
> reachable by walking the logical [sg.start, sg.end) ring.
> 
> tls_push_record() marks the end of the scatterlist at the logical last
> entry but passes the inflated msg_pl->sg.size to tls_do_encryption() as
> cryptlen, so the AEAD scatterwalk runs past the end-marked entry and
> dereferences the NULL returned by sg_next():

TBH that also seems a bit dumb on the scatterwalk/crypto side. Users
of the crypto library shouldn't pass data with inconsistent sg and
data size, but I don't think this should crash the kernel.

> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   CPU: 1 UID: 1000 PID: 204 Comm: exploit Not tainted 7.2.0-rc4+ #1 PREEMPTLAZY
>   RIP: 0010:memcpy_from_scatterwalk+0x32/0xc0
>   Call Trace:
>    <TASK>
>    skcipher_walk_next+0x1d1/0x2c0
>    gcm_encrypt_aesni_avx+0x1e9/0x220
>    bpf_exec_tx_verdict+0x3bb/0x860
>    tls_sw_sendmsg+0xa1a/0xca0
>    __sys_sendto+0x1da/0x1f0
>    do_syscall_64+0xdc/0x520
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> An unprivileged user can reach this on a plain loopback TCP socket with
> the "tls" ULP attached.  A full but unpushed plaintext ring survives
> across a syscall through the copy path: sk_msg_clone() returns 0 rather
> than -ENOSPC for the frag that makes the ring exactly full, because its
> guard is "if (i == src->sg.end && len)" and len reaches 0 as that frag is
> added, so full_record is never set and MSG_MORE keeps eor clear.  Since
> record_room is a byte count, a frag-exhausted ring that holds only a few
> hundred bytes still admits the next splice(), which then re-enters
> tls_sw_sendmsg_splice() on a full ring.
> 
> The caller already handles a ring that becomes full during the splice by
> testing sk_msg_full() afterwards and setting full_record to push the
> record, so the loop condition only needs to be evaluated before the first
> sk_msg_page_add() rather than after it.  Turn the do-while into a while
> loop: when the ring is full on entry the function returns without adding
> anything, the caller pushes the record, and the next iteration of the
> caller's loop starts from a fresh, empty ring.

Please make your LLM (much) less verbose.

-- 
Sabrina
