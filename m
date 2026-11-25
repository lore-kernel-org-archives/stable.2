Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638615;
	b=r/xSUxPP26NRetzZbIkG8WJZtpBXp2sXgxr1ihOP+aS61PF/WPAghvvK0gUTa++lnq8u
	 3TDYAW8hmIr7GuXs/DN+zYxLb6zQZ4t8GD4SerIIFQhEmQihtota5g0oWxAgztF42H9Ic
	 LZXNi3/B91rCqyi6UK2l1vN6+xkvFcR+P6TlYHiAn81FULR9ffMzvOTPn0I5O7VIMPAYw
	 QcCa33xvBnSaDLV0ph7X+Cno9rnOFVQ8eDSQzRQ/MUtp4sZYm08Xu36dkyvUnfs6L+cWR
	 x6Om3fo0up+qRroqPImIZ4vnTlxv2bUOeXoUycCczWF+F7bQ4Yqk/LgACxhKGUpwh+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dB/Y0pBg3NHRJt+bh9ZKtMxsQux3tgEshsYt64sRnfQ=;
	b=XIV3hQqQ5OmDN+zRdnmf/jScXmT/nGvHFt9rCsF5VOcwBycIa8idTSeY7fq1DHyjlW1i
	 DchowiQI0BKAb3KN1KyMuOtobJ33/hwi1X68AZ0wqUDe55XHPIZKo/7+wStJAIatN7D/7
	 QgcB659Xpt12994s7XqSUMDePun36z9EHCTQNgPQnJRZg8cDPhGXgNpL9kFm5dkV8DcMC
	 xKXgaYaKbDzAx9TwNDMX9FfWpL+C2BnxxHZnWDv8DstxLN5lzTgfArOVChVr0PLl1x8qN
	 /PVsProQBh7SxvTt/d2cxFQg69sm5feCM+tNyDdb5XHgPZIKNolQPRgOx9xpEFtHkhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TcYUDEhy;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B1606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132B1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TcYUDEhy
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38190551625so12307344eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795638614; x=1796243414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dB/Y0pBg3NHRJt+bh9ZKtMxsQux3tgEshsYt64sRnfQ=;
        b=TcYUDEhyNYGx9ZCVdd9jWCvae+xbhMvmA2kaSonRJUzheZgzJMjniD9glNn9uZqtWP
         ZZuZxcEhzShN1+Z0iu+R5Fq1NRCQTlbXbLFc206SZ0ZKc7uEp38imHOnBmwI5qw7HUyy
         dBFcvENsJe/1bCX//G/GLY1wNGgN8XBEIwKwKiUkWHnk4m2tMOcbiqNaDYcyLzgfBWDk
         564Bi/iSVBXfw3G5zbHmVdo9jXaThedM1F2AHna/ay4KPokp2Faw53vJTiu8K4YKhzGr
         NiTX94IvMnjNaI0C81AXpFX6MCaekZi8dv5x8Cbh+wbo5sAL/5kypo0jYxk0i0BTSCBJ
         3vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638614; x=1796243414;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dB/Y0pBg3NHRJt+bh9ZKtMxsQux3tgEshsYt64sRnfQ=;
        b=h3TzmFjWS8/VOQ3chQJp4eQFdNd3A6ClbjDkwscVWeN7kFy3670+RQmq9amqOaOwuZ
         FLYCztdUtTKAg6D30UWRMescL2zD6fBGDwLc/bd347m2x2Ox6ok+6hpXxQMiFjdgdEEb
         bPc5nqRgs7VeRgE3+ot39tu/4r4O2UFsz7yq4w6RjWjKK1+W1onP3+CEL8JT8UiWJnzH
         AmSKEaxPUCBjmE2C9tcNzC0BfFXofoSsWx4F4V/M7VKoSvoKtzbsMHKvl8UIEEF/SSxE
         ex8DNZzb5x9iu9l2+j0Wyg9Hc9fYQVuWk82p5iK0suc+SebX7MzSObn+sEBe7/eqP60T
         ajDw==
X-Gm-Message-State: APuU4Z8qInHhyjBMyvxez2pPWN5m6S3Rn4u+nbfsS+FvdX2fJLWQXI47
	I65vRk4yte9Z2fzMPK+1kaVYf16mJYUMSTHMIPxztj81wMfDx7HkeYoytGEW5CgmQwo59PWNU45
	95zzTep8=
X-Gm-Gg: AZFdTZc1LaOy/yZtPYz+JSsCmgDFZMVvRTmyCxl4Y9ex7GpQBk94BPV1+56XVehNZV/
	u6H+91ibwN2NMWy5aAZUrXpTRDBPb5QhKMvcsos71fNRcecah0xWHGZieUnQ0AfOT02XtoM0awx
	9X8CUXU7uQPfyrBbW10W2hxsoPnbRcTutbe0d53vcvmqpzLZn0ATWENikvvJ36Zfe07JyfKdgTG
	A5LCiUfXw3AGNSKuxUtUU5Jjv/jIpluRVbXt0m5YW2GkGShCFWioPLP54ldG8q10FGdAg0CfRnp
	oyHK88HNZRNQO6TfrszJ+zAwASV4Ocz2HgE9YVEfLTdHKTCbYr+veRCgjCOJAi05zbbCpQ/8wFW
	TUji0x0BV76YD/+pftp01UhQwYjYteCvCWlTDczpamRvToXAXwY38Jg3te2QmiVyhOYyJ/DcM0M
	Gc/8ZzbqFWBis4CNKfPZiomEO+fF4ZEXkNnR/iBkBjLgSs49/yFIBkYd0oJURoBA3xRQdpCRnTe
	W3DKaMlPVaNzdovMbQeNfesFQ5Q6yGSN/XP+KemCNnpvlLaqhOXWotobWO0HU4tcrRF/BsgV6CL
	3hei2pgdRYT9ZwlFKyDoEAIvVm21C8TKFoOf5wRJupKGBVVXPsoSoTtUC7LlWQhSCTW01eczjEO
	WOhtWSwP23ImH+SSEyggJ5ywwTxg=
X-Received: by 2002:a05:7301:1402:b0:36e:b3e6:ebe7 with SMTP id 5a478bee46e88-3857025f297mr17717038eec.26.1795638613970;
        Wed, 25 Nov 2026 12:30:13 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm47972746eec.19.2026.11.25.12.30.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 12:30:13 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jeremy.jean@oss.cyber.gouv.fr,
	kuba@kernel.org,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH 6.18.y] sctp: validate cookie AUTH state before use
Date: Wed, 25 Nov 2026 15:30:10 -0500
Message-ID: <20261125203010.67858-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Tue, 4 Aug 2026 20:00:42 +0000

[ Upstream commit 3dbb44d88b1e94dd31fe43588af7437b34b44d56 ]

When cookie authentication is disabled, COOKIE_ECHO restores fixed-size
AUTH fields directly from peer-controlled cookie bytes.  A forged RANDOM
length, HMAC list, or CHUNKS list can then reach association consumers
with lengths or identifiers that were never validated against the local
backing arrays.

A forged RANDOM length can cause out-of-bounds reads during key-vector
construction.  A forged HMAC identifier also caused a 32-byte write past
a zero-length AUTH chunk, providing a primitive for a local privilege
escalation chain.

Validate the cookie's RANDOM, HMACS, and CHUNKS parameters at the cookie
trust boundary before copying them into the association.  Reject invalid
types, malformed lengths, unsupported HMAC identifiers, HMAC lists
without SHA1, and forbidden chunk ids.

Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification of AUTH chunk")
Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20260804200042.2412009-1-Jeremy.Jean@oss.cyber.gouv.fr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.18.y: context adjusted in include/net/sctp/auth.h, where
  6.18.y still declares sctp_auth_init_hmacs(), and in
  sctp_unpack_cookie(), where 6.18.y still sets retval->c.peer_addr
  after copying the cookie. No code changes. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please apply this backport to 6.18.y. It fixes CVE-2026-74752.

The fix is in 6.6.160, 6.12.114 and 7.1.10, and in mainline since 7.2.
It carries no stable tag; it reached those series through the
Fixes-based selection but was not queued for 6.18.y. A three-way
cherry-pick conflicts in include/net/sctp/auth.h, and the plain upstream
diff also fails on context in sctp_unpack_cookie(). The code change is
identical to upstream.

Compiled net/sctp/auth.o and net/sctp/sm_make_chunk.o for x86_64 with
CONFIG_WERROR=y, both on 6.18.65 and on 6.18.65 with the current
queue-6.18 patches (stable-queue 0fdc4475764). No kernel boot or runtime
test was performed.

An LLM was used to prepare this backport and to check applicability and
stable-queue history; I reviewed the result.

Thanks,
Artem Dinaburg

 include/net/sctp/auth.h  |  3 ++
 net/sctp/auth.c          | 75 ++++++++++++++++++++++++++++++++++++++++
 net/sctp/sm_make_chunk.c |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
index 3d5879e08e78..fe45c8df210f 100644
--- a/include/net/sctp/auth.h
+++ b/include/net/sctp/auth.h
@@ -22,6 +22,7 @@ struct sctp_endpoint;
 struct sctp_association;
 struct sctp_authkey;
 struct sctp_hmacalgo;
+struct sctp_cookie;
 
 /* Defines an HMAC algorithm supported by SCTP chunk authentication */
 struct sctp_hmac {
@@ -72,6 +73,8 @@ struct sctp_shared_key *sctp_auth_get_shkey(
 int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
 				struct sctp_association *asoc,
 				gfp_t gfp);
+bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
+				    const struct sctp_cookie *cookie);
 int sctp_auth_init_hmacs(struct sctp_endpoint *ep, gfp_t gfp);
 const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id);
 const struct sctp_hmac *
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index fbbfa0c27955..95c272948c60 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -377,6 +377,81 @@ int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
 	return -ENOMEM;
 }
 
+static bool sctp_auth_chunk_id_forbidden(__u8 chunk_id)
+{
+	switch (chunk_id) {
+	case SCTP_CID_INIT:
+	case SCTP_CID_INIT_ACK:
+	case SCTP_CID_SHUTDOWN_COMPLETE:
+	case SCTP_CID_AUTH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Verify AUTH parameters copied from a state cookie before they are restored
+ * into an association.  When cookie authentication is disabled these fields
+ * are peer-controlled, so they must satisfy the same constraints as locally
+ * generated AUTH parameters.
+ */
+bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
+				    const struct sctp_cookie *cookie)
+{
+	const struct sctp_paramhdr *random;
+	const struct sctp_hmac_algo_param *hmacs;
+	const struct sctp_chunks_param *chunks;
+	u16 hmacs_len, chunks_len;
+	u16 n_hmacs, n_chunks, i;
+	bool has_sha1 = false;
+
+	if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_enable)
+		return true;
+
+	random = (const struct sctp_paramhdr *)cookie->auth_random;
+	if (random->type != SCTP_PARAM_RANDOM ||
+	    ntohs(random->length) != sizeof(*random) + SCTP_AUTH_RANDOM_LENGTH)
+		return false;
+
+	hmacs = (const struct sctp_hmac_algo_param *)cookie->auth_hmacs;
+	hmacs_len = ntohs(hmacs->param_hdr.length);
+	if (hmacs->param_hdr.type != SCTP_PARAM_HMAC_ALGO ||
+	    hmacs_len < sizeof(struct sctp_paramhdr) +
+			sizeof(hmacs->hmac_ids[0]) ||
+	    hmacs_len > sizeof(cookie->auth_hmacs) ||
+	    (hmacs_len - sizeof(struct sctp_paramhdr)) %
+			sizeof(hmacs->hmac_ids[0]))
+		return false;
+
+	n_hmacs = (hmacs_len - sizeof(struct sctp_paramhdr)) /
+		  sizeof(hmacs->hmac_ids[0]);
+	for (i = 0; i < n_hmacs; i++) {
+		u16 hmac_id = ntohs(hmacs->hmac_ids[i]);
+
+		if (!sctp_hmac_supported(hmac_id))
+			return false;
+		if (hmac_id == SCTP_AUTH_HMAC_ID_SHA1)
+			has_sha1 = true;
+	}
+	if (!has_sha1)
+		return false;
+
+	chunks = (const struct sctp_chunks_param *)cookie->auth_chunks;
+	chunks_len = ntohs(chunks->param_hdr.length);
+	if (chunks->param_hdr.type != SCTP_PARAM_CHUNKS ||
+	    chunks_len < sizeof(struct sctp_paramhdr) ||
+	    chunks_len > sizeof(cookie->auth_chunks))
+		return false;
+
+	n_chunks = chunks_len - sizeof(struct sctp_paramhdr);
+	for (i = 0; i < n_chunks; i++) {
+		if (sctp_auth_chunk_id_forbidden(chunks->chunks[i]))
+			return false;
+	}
+
+	return true;
+}
+
 
 /* Public interface to create the association shared key.
  * See code above for the algorithm.
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 3518f997a7b8..5d894b18ec39 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1867,6 +1867,9 @@ struct sctp_association *sctp_unpack_cookie(
 	/* Set up our peer's port number.  */
 	retval->peer.port = ntohs(chunk->sctp_hdr->source);
 
+	if (!sctp_auth_verify_cookie_params(ep, bear_cookie))
+		goto malformed;
+
 	/* Populate the association from the cookie.  */
 	memcpy(&retval->c, bear_cookie, sizeof(*bear_cookie));
 	retval->c.peer_addr = paddr;
