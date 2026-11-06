Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994696;
	b=LA2XRPgawmgPyiMhLSBDreiIYnYEPvG8s9ylUorq4tPTcMzQ43uoMmJTGGoh+sZ3EwKm
	 9GVViV6LRvBkzZBe5P7pXhbwE7PZcNbZ1FYUuLSXyLnsCKCLwqHBPHJ8+WV0+PXcIcjRI
	 DiPeolErgwZcbP5RVDj7OkdzCVh8Y7/4pRGtZilxglLykyIPAxzxJ+biFudL6B5O9YtbB
	 dwlSpxWs6ycphYtBxW0wz+spdk50R57A1ZrZtC0bF6gZt829acl74F+CFwzSqwk73EL7G
	 aCamVljQlr7DEh9vrM9o1kNzflrI7GGd+ndiaWPGMuK7ulJ3IjDraqVkAwLStFEz/QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ffQKOr7UnubupJZqlvLZWc1enNvauuxfHnatBigPms0=;
	b=h8QKOl7TM8oBZxne5/1NV4b0sS5Zh5i7C5bfH7vKXy+/A/PDvciGN4NzJb8PBzysx6rx
	 3j25nwtf39Hh2AOp6AjLvZvjgoFDuLOeLb5tOUGmtAoKhPsSJdzrq6VG9bVYgZcaaOTdf
	 XHHasMyqGn2RXUqbIGHdBHIGbtTI24a1TslfXoqssRn9ZoFGd4ROlD4RTR/LTgeGoGNoO
	 fOT12YwghhQ4zH58ByTRYjbbfdc3zLp8G5VyI6cID/rIBEQg9QuyL4MFZp7cOhWcvKKSA
	 3+yu6AZep5LSWapLJ8mX42QowqkQ9nnkWi3FGNYcmpAISTaiZcyKvp3ze6qumNwg86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXVOwGKL;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DF606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3DF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXVOwGKL
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so9603745e9.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994694; x=1794599494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ffQKOr7UnubupJZqlvLZWc1enNvauuxfHnatBigPms0=;
        b=AXVOwGKL0ZQ/8MhHgGtDkNLemGqJKsvgcFOBO98XdAtyAOsf6P5JaiG8DLsrYU43cD
         kqoWxmklZs3+Wpn4wacCbFsr4zrTlcksjpMGgWzY3bK2RZJG+kp8h3DaMOZKm4oLHaIH
         2/VXKg6+ewO7v3fcWV61iLbPTa5t8juelzLgI5w2MdSqtvBB2Ckdf8VlUz5NfK0Fi1rb
         Gn2M1F/bC7XDrmEq7e0H3BM/f73CThA69XLc1jQHpo1qPHiFJ8wKE1jEoLK9Ret4hPMD
         u8zGMFfcfGHc+zHuVY9Rj0iKsfaKI+twppjE8I6FoyeZ4A3YjeeRM1/m79h74QdRzBYp
         LnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994694; x=1794599494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffQKOr7UnubupJZqlvLZWc1enNvauuxfHnatBigPms0=;
        b=ittAM3YBQB5/0KVCAXRpIz8/2qFrWn0cvwGiqMrDXZ5XbcGLNWo2yMxLRGQt74+Lvg
         HK3edAxe8XySgEKsRP6TnfBWdhe9LAD1aSt4aV8yuEXE2LOB/HTrqECwCLkuf/O48Bdi
         xUpGJ3j7WeLH1t8vZKiWSAHbBSbwkWsvxdi6g0YDYH5USDZNnclLEDykoyeR33bUXknu
         Ib6/cp8mpRNuqcBVVLUOThW0Q8auEwoxZOrtIO03lCv/CLiINJnVrkdeKZGOLWqgUJiS
         gfFjckNttVlPJDGFMJWbnGz/RGm4dyW3HwnrjqDW8RKluhM2CnABk60bwp5TnRUOiGHH
         AHqw==
X-Forwarded-Encrypted: i=1; AKwUvBziVU5OYJT5Ho6b5Egq1kn3gSBuHyFPezj9w9ctiH3ZmyurNEueUTqFnAVA/FqMPeTti14ZcRE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CpBpD4cGMJbmcvIFkKxmLAiZnrUOuAwthvf8qD8iUb8O6hdXd
	XF70RKB0ndTSGDBdO943MYiJvNYH0OMdYb9wZ3aemee3ZsjiVn4QhVay9eebVpW83i+DXQ==
X-Gm-Gg: AYBFou1UyyDPPpdnjaIK4COYi+OIBcVHEz9LCsx7iOh+SUo1GoSkqSzcG1TDajqQTL7
	8sDB8MdDu0wxm8EQTR8hD73lE6tPSWP4x6HS6His6cPkJ+CrEAirqj2xZrxqB1dZOHTggLJngug
	pcmOQGdWgTtvfnFuuxxb7a/XXYWnylSpLiJLJeOmeifqDOyTGVGO+FT3VwcEZmIV9JqQ4VdLKXN
	eYDI+QlK4/Vv+8KuyD+S8kVUkH86KvPOkNUaFHhsnLod3Ncj7/Y/hbP1XSyW5uvSQFXUpajGJ49
	USgtMHYo5Gq5DHza5pDkEVpJ6NNrmFRepIzgi4vPnUzQv/06TEvKN6ADmKfr+BpPhQYi/FwqGeg
	svesvE1/RVIlmZG0nhuW8r8AU+HW6VTMKdKCXM7Q0azAeCmes4xW36lYZ2cJ2dSfxntUEIZK1WZ
	OM+lL15PEirKTswdd6tIuUsrVlliXBILMj0EYGp0idZH64VLxxtPh6suY4tzaPYS8K6iXs1vdjc
	ubs23hu7yJpl7s/IGKg/RWfg2k4M1ZkBxK4kO1HHh4WBuIOI/RLAdJLIQ/W0nzmhqxLcTWq9zcM
	cCtCTxGv/vH2N2E7qLtJUA3j
X-Received: by 2002:a05:600c:64c5:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b6df4f1dfdmr62389165e9.25.1793994694120;
        Fri, 06 Nov 2026 11:51:34 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723283dsm5109746f8f.23.2026.11.06.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:51:32 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH net v3] sctp: fix ASCONF address change on single-homed hosts
Date: Fri,  6 Nov 2026 20:51:26 +0100
Message-ID: <20261106195126.1563231-1-andrey.misyrov@gmail.com>
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
source rather than reusing asconf->transport. Both DEL-IP paths can
now free asconf->transport, and chunks bundled after the ASCONF still
use it, so point it at a surviving transport: the packet source for the
wildcard delete, the primary path for a plain one.

Found by manual code inspection while reviewing a backport of commit
9b2854f86f0b; reproduced on a two-namespace single-homed renumber.

Fixes: 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-IP processing")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
v3: a plain DEL-IP of asconf->transport set it to NULL, but chunks
    bundled after the ASCONF dereference chunk->transport (e.g.
    sctp_vtag_verify()); point it at asoc->peer.primary_path instead,
    as suggested by Xin Long. Reported by the netdev Sashiko AI review.
    v2: https://lore.kernel.org/all/20261029193454.1028626-1-andrey.misyrov@gmail.com/

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
+			asconf->transport = asoc->peer.primary_path;
 		break;
 	case SCTP_PARAM_SET_PRIMARY:
 		/* ADDIP Section 4.2.4
