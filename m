Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADE3932CE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931066; cv=none; b=c3GP9tant0GqyhPpDTvCOCRoLYknzUqiLBzs1AW6NcamM91s6Y+5ZQik44hoW9isnzcQKqk26tkG4qU1FZAuFjr66T7auSR8mPpz3+Ak+YHMrIHkmFC2yuof5FuWwsD5vYfIqmCk6OKYygt1I48fTmOeSbaKDMsaxsNBN+Ftt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931066; c=relaxed/simple;
	bh=3jbxzDGctzlytA1CUiLHP6fC2hom4m+HeaRRm6vj2/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1/S12Zgjko6q8zDkyeOM0ePZ+/YrCWPLr0inuaymv9SAF58IEqlU2C5mzIWjL3qHzgqWNbTCbQA+xx2GaxCyVm34Fx9RFGb0CEccARK7ZEzoc9CgK/nx/vnehM7CXttHmFhqe0pKvg43RZQuPN6DYh80WEn7zuREvp+0q1jlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/D8SZDh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/D8SZDh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caed617615so31365465ad.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783931065; x=1784535865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1cbrAJhEgylfzJ7kP8FxcJO9K7Iz36CMw32c3E+ghs=;
        b=H/D8SZDhqt0SXldw8Z3Fk4JR0x5sBb1wo3JSirgNhEJq5A0RcKq5iR5fX/H7KxfKtW
         CIxxpCahlqrq7a6OchG2/sUoG71HzHDnAOWiTGhtBa3Cp5M5Jf6Kc4uKtnVVcNmIYCCz
         ykAnhHKCMEpq6zkDV44JjxfuiffoRLv+HD8uza2DxNDkV4gWOb0YTCw+hgd/Md5LxmE6
         ZO1Rv2xloKlMp7uy+plkernrIc7L7J/crL4e43oNpHUHXxbt3YiZKxDokaDPmfGukkRY
         TEY1QmSYW/yTB/aW2o2yNEGYK8jZC1je8/6g/Nuoiqs6KLEg3z4z5kEEj21cPAp4xGjQ
         ljkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931065; x=1784535865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1cbrAJhEgylfzJ7kP8FxcJO9K7Iz36CMw32c3E+ghs=;
        b=WHtck+PuB4PDueliqOnufq7rAmAYbUrJfMaYGTPxTOAQt9e8qQVcHK0hBRmsUW6lDv
         5BCux63VroDdEaRu3bwvHCruW59RlSvh9aARisIH8nNaxfq8GAybJTlRuYgi863PiFd8
         V/3oxnG0eKRSLOZFCe7U01QfVIH1HIJqYXoGzNNDMN2S029kNqjPGiEBRQSAvRz+BxLV
         //FUCAx+uA9wUkRvFxfxL2AXS/GJ92NRLJ7CAL1DOKQvajF4hEeoqzqgg7m2iam+udea
         /hi1mmzdY4WyYM8qnemY7nFiLPwiDVG1EWAa5e+1gdzUFtQlK6s5vimjWdW57WBQygjc
         Ql3g==
X-Forwarded-Encrypted: i=1; AHgh+RpE8ri1uekeapFhmP/mhhnHoYy2hn9kwaPvcwNM+untxYWD34zqz4812jZXjA4BL0ye2LZlQ2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VKBtA+znjG1w3XgPn8XDrKJ+gQn8yQCR0K3R0uEOqHmDqyDB
	ytb0XUMfHvUtoFqirScIhJLuDZB6nyJUKre043iaGo+QlRkR0snayx7T
X-Gm-Gg: AfdE7cnEzzYBaaBAsNnbdEoMsik2WFYbJPYc8BN5OGZGoLM/jHWj2KsS+cAHewj+vZ7
	pb/0Yi9P4FpPBIgdBi8UAD/TmtNVIji0R/mHLlL3yYZGkMovhQgLG5Fwb74Y6inu78iU3hx+zxI
	CBeZfvAu2OfCVF7VqrI2msGTStWQCCSSgLKWRgTGY/jZ2kVVXQqCPSIygh4w/ircM285SjV/osY
	tlfh9OS70aO9w/WiQXReUv50h2lP2bH0rcOllIMq/vbePdcSDJgB92+1XrqIa1yjcMV8BF9jTho
	dLMy3tFTw2SezcaUpfA9S+nFbMgb/gDy98mcui2knfF1426yxLbaxSyUjF21HXJjcqLM+rRPirM
	ilb5Dv3umRYT3xtNhiZwTLVFIfR1xkd558usQ8Yb74/4/V1sOxmxNU7378aBwpiRgiXqjTIh7ip
	n7ZGmN24GR0sLaKvIORJ5uG8SN4yVYjCM3EgQ=
X-Received: by 2002:a17:903:2309:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2ce9eac0620mr79571995ad.16.1783931064756;
        Mon, 13 Jul 2026 01:24:24 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm95139075ad.65.2026.07.13.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:24:23 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Mon, 13 Jul 2026 17:23:42 +0900
Message-ID: <20260713082342.3803379-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
returns non-zero), its error path frees the sk with sk_free() but leaves
sock->sk pointing at the freed object:

	if (tipc_sk_insert(tsk)) {
		sk_free(sk);
		pr_warn("Socket create failed; port number exhausted\n");
		return -EINVAL;
	}

This is harmless for plain socket(): the syscall layer clears sock->ops
before releasing, so tipc_release() is never called. It is not harmless
on the accept() path. tipc_accept() creates the pre-allocated child
socket with tipc_sk_create(net, new_sock, 0, kern); on failure it leaves
new_sock->sk dangling and new_sock->ops non-NULL, and do_accept() then
fput()s the new file, so __sock_release() -> tipc_release() runs
lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the
sk_lock spinlock.

tipc_release() already guards this exact "failed accept() releases a
pre-allocated child" case with "if (sk == NULL) return 0;", but the
guard is bypassed because tipc_sk_create() left sock->sk non-NULL
(dangling) rather than NULL.

Clear sock->sk on the failed-insert path so the existing tipc_release()
NULL check fires and the use-after-free is avoided.

The tipc_sk_insert() failure is reached when the per-netns socket
rhashtable hits its max_size (tsk_rht_params.max_size = 1048576, ~2M
elements) -- i.e. once a netns holds ~2M TIPC sockets every insert
returns -E2BIG.

  BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
  Write of size 8 at addr ffff8880047cdc38 by task init/1
   lock_sock_nested (net/core/sock.c:3839)
   tipc_release (net/tipc/socket.c:638)
   __sock_release (net/socket.c:710)
   sock_close (net/socket.c:1501)
   __fput (fs/file_table.c:512)
  Allocated by task 1:
   sk_alloc (net/core/sock.c:2308)
   tipc_sk_create (net/tipc/socket.c:487)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)
  Freed by task 1:
   __sk_destruct (net/core/sock.c:2391)
   tipc_sk_create (net/tipc/socket.c:504)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)

Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic rhashtable")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
v2: replace the raw KASAN backtrace in the commit message with the
    decoded (scripts/decode_stacktrace.sh) file:line form, as requested
    by Tung Quang Nguyen. No code change.

Link to v1: https://lore.kernel.org/netdev/20260710014440.2055584-1-4ncienth@gmail.com/

 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..55e695748332 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -502,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
+		sock->sk = NULL;
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
-- 
2.54.0

