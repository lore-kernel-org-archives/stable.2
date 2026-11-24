Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486890;
	b=a85fZmvCm5jpvehJRWJ3O5OByG6+El8ZSbvWBMRBNWqT0p04NiBWAMeEKjsgTP9pkH32
	 MV91D1Hc0o+wAs1VsbyDopBKKibSTnTO1LaSJhwpaNGxCk/U1cvMZO2eIGrT45nLK3lfj
	 +PGpVzFx5Ah2Cgs2BKIgTdwcoa9p0pzsjsuhtOeuLKYIEsZ7Vz1hir7qxEhsY8OsJBx8L
	 ESbp8wf1kyDS8VfyBVx0JzOzafQ3+KkwevuNzh7GDLr4x37sg+WPc81UYaycP9svGeiqD
	 DdfAsMdz0BiQyABjrobx8jtB9sRHdKK6YD+xVYnhCB8tA2blK/s/Bfe3mjtlhRSaTuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S167o9uoutsfP2jut1Z47ahN/OtfjROuup7AudPgKbg=;
	b=xqAIieLHuiFBAzY6xIFjwHK/zBHWkAulXC1I79Hrfo7bpHen5VKcGHmmARkfeybf8Esm
	 NOQgvlJe5emIXhxdyS/1YguETQ5GBAN4tXoZx9OSL0hg7fywJSAmkvY9nxMXBzyGOEl4v
	 tb87yOELmsxeeGMLlsynZ+fWRtfwL7dA6jj3q7HjPNaGWZNcp0s3bk9mgfHU2hRnRCw0L
	 MrQyX09NZENfMJkvF2dYmDvKrTwd+optqLHSw7Dnri9lmv42dNQ35aZ/r4BVx6paMkf26
	 rQuzq3kOxwDRX578LHvdJE5NcpMjVtM3ujRP7+w82h3tp/K5koreC9zg81An9q4kmiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpZz9fFo;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBF606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABBF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpZz9fFo
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f04ad2c46dso21960335ad.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795486890; x=1796091690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S167o9uoutsfP2jut1Z47ahN/OtfjROuup7AudPgKbg=;
        b=LpZz9fFoyKJtDc3WnHBrsmEvV1Pgqp5tX4/73EvjvaCXtckQ86HWu1lM4yKPOLSPyQ
         3Bs+OqDHcG4rghN6o+2neRpZD63e8a4GSmp/mNk8x/JJIGmuD3ddPikpZO7cLq1TUrFU
         +19rYkQxY0aG4B1JpwKD0QJ0cTOFBiuNDNManLol9/QJUqLnBpAb2+X9/kf7gS7SXDEe
         eiCE4aQTWJtXTPrus5OhWQieSbp8YtiYVYem01xsReDaLYaSwpcGEI3ZEJzyb0LFWfFd
         WU3jD7OMVfDokDSjW1E/dw9/lqsoeD4kQpyx1oSxxjYc2ora9ejnMWAHzCSNVjrKnerp
         brlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486890; x=1796091690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S167o9uoutsfP2jut1Z47ahN/OtfjROuup7AudPgKbg=;
        b=VqlUV25zr0I8O0TDs07o4QP+a1a9FVTXycI9z/si6qHNsFXqefEeQZU8aiy4cpveJd
         6Gobv2XcJJatrqDIVYgLGCdqANvt03I3l3hMNNVErNvFILxPQ+y3FxNhqf0QGDz4kHZF
         L7jW7zknHDZWV0JJDSecAAbfht9jz/9MjXKPhQnF/2HrUlqmX+AiLp3jjWkpqZFBVAU5
         wc6iFaRdZqimqoKImV82btIgR/jii+hGK3T95lRvVQ006/06luFJPlXutEGLW3ItXLDS
         Me9rV2Vfculzz4gsO5mpz1E5CmeS+cKWSoimSBr0NikBKgtntBTP2PLPdOpTlaD405g3
         +zKA==
X-Forwarded-Encrypted: i=1; AL+hErEA8dUJnJXK6tlZ3V0nsRt4pyow48fpPM3tujWBhaQy0TJVF6gmxmpOp8EHNRH9xZ58pRjtoHM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CK/a/8nQAn9/XMHhJKDtl3/nJ3ngQkXnx1geZb9O37aA0QjZj
	NRkIsPlXqPoWz/9LX5rpeVp64Q8iAP/Yv4fQsLaYmaLMjycbkJYVQgfjcWymWw==
X-Gm-Gg: AZFdTZdrPeAZMVkYSH6Ue7oa+PWCng12KCooRXz5ezrJkzH3I/zZXwQc+3FHzv1cAKh
	VlW5hULd5foiCZgrvvHPggCn1IcSA2v6AeJr3t1f+3jlAp4a2jAshSmZYljA9QHAJZd4kxyWCLO
	bk1aF2coqCvrfxtwo095BDvSmMgcePVIBGvKy+iTbvqPv7OiSCXRY7IK1DYqqQ2fUoD5IVGD22a
	56NBb/Ln2O45WvUJYJDOAXe2Z1zzG56HxEIQmh3tmGU4krDcGofLYAzRq0qRnWfvWf202kY94FR
	mKEkqv7vnAXKEQ0GvspgFpE8uHKl7NvLSiL8vxu9mZMiZ8GuKcB847Y9zXFG9GZegSFyIem0Kgv
	hRXQgu8TvPYgSSB6M6swW3q5F3BowO7cLSZApnYZ3adPNINlaqV5jsTkD1GzSBonSW9iZK49J0S
	1An7Mm34R3/AETZBiPPONkX3WX41apxSFwDh/T3KH1RjJFMEkge08P948X7lfuTWzFFh2gPORSC
	kF8Sfah+R4Ty9AxtVhzCQ8yXMY7XKDlMcpwL/4AkCSWemnx7dkalIKioemA7VpSfFZ3nshXJzLu
	kg1Qr/sNmy5+F7eyql2Kd0Hr2gUIwnTX/TsR4zLBtIE9oyhhaQnKgLnpAs3lPjmE5WNqlZNQJA=
	=
X-Received: by 2002:a17:903:b0e:b0:2df:35f1:8771 with SMTP id d9443c01a7336-2f03f1e0d4amr128824035ad.54.1795486889807;
        Mon, 23 Nov 2026 18:21:29 -0800 (PST)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0b7be3347sm7003095ad.15.2026.11.23.18.21.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 18:21:29 -0800 (PST)
From: Lin Jiapeng <ljp1205831794@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vladislav.yasevich@hp.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Jiapeng <jiapenglin@tencent.com>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v2] sctp: preserve the peer transport during INIT error cleanup
Date: Tue, 24 Nov 2026 10:21:00 +0800
Message-ID: <20261124022107.32283-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Lin Jiapeng <jiapenglin@tencent.com>

sctp_process_init() removes non-ACTIVE peer transports when INIT processing
fails. The transport matching peer_addr may itself be UNCONFIRMED, because
sctp_assoc_add_peer() only promotes an existing UNKNOWN transport to
ACTIVE.

If no ACTIVE transport remains, the cleanup can remove the last transport.
sctp_assoc_rm_peer() then interprets the empty list head as a transport and
passes the invalid replacement to sctp_assoc_set_primary(). KASAN reports a
null-ptr-deref in sctp_ulpevent_notify_peer_addr_change() through
sctp_assoc_rm_peer() and sctp_process_init().

Keep the transport matching peer_addr while removing the other non-ACTIVE
transports. This preserves a valid replacement path without retaining an
arbitrary UNCONFIRMED address from failed INIT processing. On a live
COOKIE_WAIT association, T1-init remains armed and can continue using the
retained transport until association teardown. Successful INIT processing
is unchanged.

Fixes: add52379dde2 ("sctp: Fix oops when INIT-ACK indicates that peer doesn't support AUTH")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20261112092114.12458-1-ljp1205831794@gmail.com/
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
v2:
- Keep the transport matching peer_addr instead of an arbitrary last
  transport, as suggested by Xin Long.
- Update the subject, cleanup comment, and commit message to describe the
  retained transport's use by a live COOKIE_WAIT association.

 net/sctp/sm_make_chunk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 15c2d87575a8..65594eaaeacd 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2525,10 +2525,14 @@ int sctp_process_init(struct sctp_association *asoc, struct sctp_chunk *chunk,
 	return 1;
 
 clean_up:
-	/* Release the transport structures. */
+	/*
+	 * Release non-ACTIVE transports except the one for peer_addr.
+	 * Keep it so sctp_assoc_rm_peer() always has a replacement path.
+	 */
 	list_for_each_safe(pos, temp, &asoc->peer.transport_addr_list) {
 		transport = list_entry(pos, struct sctp_transport, transports);
-		if (transport->state != SCTP_ACTIVE)
+		if (transport->state != SCTP_ACTIVE &&
+		    !sctp_cmp_addr_exact(&transport->ipaddr, peer_addr))
 			sctp_assoc_rm_peer(asoc, transport);
 	}
 

base-commit: 145480b28ca82e9fae789427cc4569e596515a32
-- 
2.55.0

