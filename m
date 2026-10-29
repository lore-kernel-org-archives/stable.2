Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302505;
	b=Ucb/NNA9BgDnJy+9N8bE9DtUu+iOnQanmVQH1DGg3vyVh34a6c4IdLRXHtmPdSBBYptx
	 GNeTwa5lx0/KPVamaDNDGcmwRbf6FNZU8G/PfhiF/Xv6XF7+Y0kPMCdFcsPTvlMoDC7HS
	 i7OZqwrq6UijagRP9FlvnsMvouLEIieFPQLqktzAxysgN6utkau/3A3SvmZR3/9MviNRu
	 syTIJYNo5+VKkZMXimTdOIeAtkb/oWwxxd0FNBvGykFpwG5Q4/Mmkg98kj+gyUHiugwS6
	 HbOKle/806ahtfMYgzmlO2uTFVOrSHK0ubnR5Vv2NNW8Hhabi3hzpltSkWAlrYI/EYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=laioZ8N0OQR8oGU3jFarnfPkuthFm2r6CwyVihbfb8I=;
	b=O2HcP0gxmPB5QAYorNoAb96Ra6nfUkVhB9BK2f0VcqsD2AULqTFiA7p3JOipI6A7amWs
	 hK5U9LeufVeuZdb68JRs66hB9vwNhVn5PFvNkl4MIPYSn0Q5blfMRk6cxGVnfYKttMPp/
	 YKB/FoAqU3wZHsjv0RoMcdl0Hw0KfAEkRxdhbDYf9BbIG/wR/UuP0RSPLnFaYoIPIVlYs
	 VT0FvPuUb4r8JgEAt0pTZoNjLDmDbzWG0Mi/WL331ecjjEw0it/rWhaKnAwd45KWvTdWF
	 f2PHJ46iHzEGcVQhbtCD4j/SIF9Hx/18AeSj34g5vT8J/6+pj5a7z0nHctehNh3z7SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr4pNwCK;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC160A2603
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ACC160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr4pNwCK
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1222852f8f.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793302503; x=1793907303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=laioZ8N0OQR8oGU3jFarnfPkuthFm2r6CwyVihbfb8I=;
        b=xr4pNwCKgYGulSw/az3ibQgRd3q7lIyi9gAtf0ESPFgOodSG05E/NuzpYrS9AdfFJq
         /3XnLbnR81g0VIcYmNAbug97vSIHtPJoNSreJGScZ+D6+n1Z78pDSeecZp0ARZ8yxZqH
         ySR0BaGEWVVQv+B6HqFTgKIAFx0ANskp4JqGTrj7rzVYeYttOkZ31xZduzyXAwfSW2ih
         XSzjfCh99ugHcJbRPc3X5AyaqtFh4YJ7y9RXQUp5EUjP9Bp8EhJEJ4z9p3eh6h2Zr399
         soNi82h30lyjo8knSvtarMORMcxjDxE8Fpywhu/VDW1XI8pwVNkPu1JITIMBxOj82+Ol
         dnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793302503; x=1793907303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laioZ8N0OQR8oGU3jFarnfPkuthFm2r6CwyVihbfb8I=;
        b=sRez/8NVIabOMj9rADyIIieFKZGU1hjGXRpqXGsgTaAQm8pJPw0j+wBX7hIlx4dKBX
         zB9vX3KUHHwuDReqIO7X03itmEHKLIQapw3lS5QKzwlPV3CBUpOyaU5Q2AZLqDj2k9en
         VMJRO4vtxsOlmnWr/EW47+CTtHcJoVAqX//DCA2pn9IkaSpx//RSdD64+Y2qE93btB6W
         bz2NsK7Dqy8qFdrbousLloGx99ITD300X6+TtmmJ7XXaNrTraL1rEdXldmRMDTJcaXbL
         bqYv2/lhJ1yLrIhHeAj4zI+sI4gV7Q9EW0McuNox2se2ru/yvn8l2BLxVvTCruMdBwsR
         F8SQ==
X-Forwarded-Encrypted: i=1; AKwUvBztnpJLFU3dH5/VKctE52zYy4bc8t0y2v1XUwk/xdmBnkdemnsXPlkAlpQWmMY8LiAE00Ek+5o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXBNTacrTl9DZs2AEeSMnlufS8qLlWjLTTtIch2psivyc5/A6/
	L0Wixfp/m8VvIToiBX1aE9W8vf62qMLAsmd/wq/n1rJBINgRTKqhwl9P
X-Gm-Gg: AYBFou2J2kbHtY8FCyJ4wOaFfQLnLb7v917IRJlTq3AELpZAYRDPY0mSOT7Z2xW50Cr
	MQUTW1WS/R1mIv1cztFKvGZg388yovO+5dZsQrs2apLnZCMoljXdaHcmSLZ0Ptt+PG3Oh6KvH9W
	dwt7lEQWCJB13F/XMnLvMvGoWu+XejroDE66rzsgavwTYAcQhbbIxeCMplHTum1oDBBmSZmk12v
	/a8Z5DLIrkzIsES2z+RgjKhffUfGgilfmyYBW11DtbgmZ88CtPmp9NJqJ/tEH48dPi4BN5rMJ3s
	M6gRAZEH+YO+esUkyxPjLQTlHob1SsZ6oS2sGE9ry0EvT2rc2pzEXyUZxHhSSjEbENH8jgfSX4M
	11hA1iKuYv7Oq5vaPb5VXC7ddAKUaD7BSoJ/UeBWUSk1b8lCFcUxfB7+2kc4BigmPBArH0Sllfz
	ggGHkXKyTpz3oLwI+VnjdgRV3J7bs2SghBbXj5kw7c83PL6bys0ZTWyn/eDlQzi9b4GbLLo+X/0
	fM+eia97Xc32eOxXDIg2E+gV8/DdElyUw2Ca0VnkniFXsaT5pa7I1N60kZ/laAjwrH498LOYXvh
	9v1rJ0gkeSBjNiqRFyjSOdEG
X-Received: by 2002:a05:6000:250a:b0:48a:f073:336b with SMTP id ffacd0b85a97d-48e6e2fcd88mr842417f8f.23.1793302501851;
        Thu, 29 Oct 2026 12:35:01 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb81d48sm274585f8f.24.2026.10.29.12.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:35:00 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>
Subject: [PATCH net v2] sctp: fix ASCONF address change on single-homed hosts
Date: Thu, 29 Oct 2026 20:34:54 +0100
Message-ID: <20261029193454.1028626-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in
DEL-IP processing") refuses a DEL-IP of the transport the ASCONF was
located by, so that a later wildcard DEL-IP cannot use it after free.

This also breaks the single-homed address change (RFC 5061 5.3.2). The
host sends [Address Parameter L] [ADD-IP S] [DEL-IP L], the association
is located by L, and DEL-IP L is now refused. The sender never gets an
all-success ASCONF-ACK, keeps src_out_of_asoc_ok set and stops sending
data, so the association stalls.

Fix the wildcard DEL-IP instead: look up the transport of the packet
source rather than reusing asconf->transport, and clear
asconf->transport when a plain DEL-IP removes it. The wildcard delete
can now free the old asconf->transport itself, so point it at the
surviving peer; otherwise a bundled chunk would reuse the freed
transport.

Found by manual code inspection while reviewing a backport of commit
9b2854f86f0b; reproduced on a two-namespace single-homed renumber.

Fixes: 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-IP processing")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
v2: the reworked wildcard DEL-IP branch could itself free
    asconf->transport via sctp_assoc_del_nonprimary_peers() and leave it
    dangling for a bundled DATA chunk (sctp_assoc_bh_rcv() ->
    peer.last_data_from) and the following SACK; retarget
    asconf->transport to the surviving peer. The pre-existing wildcard
    SET_PRIMARY / sctp_source() point is left out of scope.
    Reported by the netdev Sashiko AI review.
    v1: https://lore.kernel.org/all/20261022163639.2566945-1-andrey.misyrov@gmail.com/

 net/sctp/sm_make_chunk.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index ddc31a5..9719464 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3151,9 +3151,12 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		 * packet MUST be deleted.
 		 */
 		if (af->is_any(&addr)) {
-			sctp_assoc_set_primary(asoc, asconf->transport);
-			sctp_assoc_del_nonprimary_peers(asoc,
-							asconf->transport);
+			peer = sctp_assoc_lookup_paddr(asoc, &asconf->source);
+			if (!peer)
+				return SCTP_ERROR_REQ_REFUSED;
+			sctp_assoc_set_primary(asoc, peer);
+			sctp_assoc_del_nonprimary_peers(asoc, peer);
+			asconf->transport = peer;
 			return SCTP_ERROR_NO_ERROR;
 		}
 
@@ -3166,13 +3169,9 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		if (!peer)
 			return SCTP_ERROR_DNS_FAILED;
 
-		/* Don't free asconf->transport; a later wildcard DEL-IP
-		 * parameter reuses it.
-		 */
-		if (peer == asconf->transport)
-			return SCTP_ERROR_REQ_REFUSED;
-
 		sctp_assoc_rm_peer(asoc, peer);
+		if (asconf->transport == peer)
+			asconf->transport = NULL;
 		break;
 	case SCTP_PARAM_SET_PRIMARY:
 		/* ADDIP Section 4.2.4
