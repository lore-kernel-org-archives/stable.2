Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26473470E8B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860260; cv=none; b=Nh3fBIuHWlQB+FoVcYxlljxAgJYB6iwmhhcLZhp59XPuV9PABZFTAb+fkeRRAWqxwrXh0L9j8L7OZFIrjcZmmA+7c1Qgm0c2wxEv0gKlFbxNu4fcL/NxHZ/RNlNVqyoiHhccr5FJg4sa4e1lMVjHA1bPlfkNRJl6/bncgYuBMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860260; c=relaxed/simple;
	bh=rU6/NcSV6wlLvUaIiIjQl2cds/mD4DK5bYnjCOtOQ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgnPbd2mb/+f6nyB7MpIGiL2LZ+PC1ZBkBXd+Bmtl+oLJ1trQy53CvCHFAajGVK9s/JO8C+AIb06GdZf9nnd4t4REGeODS+S4+l0gk3yJpxwdijohjyJHTVHdqRqlQu0x3JwkLKYL73CFpUu4RgfRUXY0TMpbz4a9uA+UUHf7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=luB6FJbd; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="luB6FJbd"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15354aa70e8so2838211c88.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791860257; x=1792465057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RJ4GyWHSPpIYsWpDseMdmR+JugHfXlVBzuKwLssRqI=;
        b=luB6FJbdZbr0o8Ab9fQY8Y4FpIEsDSMMzELrrJHKPDaZliUIg82gKyWEIIFVb2R8PK
         BhpTDsBywetxDI4QmijSV6xBB36JHbJXhhRc8LnnmtAsq4wwD6VX+cdPooxgIVe2XJR2
         Llg06DD8cYUN+o1zH0TsQA9hf/oaGQwAM+nnBM/L9PIWOzALSDnkEB6mjkDzMXeU00Qf
         op3BjGkfsfqxkGfnzXxUf28Bjf2kckOPBFzJFG7Qae7Um0N0VN7NpDxVVZTNoKeNtBfg
         OlIlYBR8OcuecgVfeuxMetz08CUIvUVZsWnFkrMEzgxFXXlVQiqwEgtA8KvWJpmt1O+t
         rX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860257; x=1792465057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RJ4GyWHSPpIYsWpDseMdmR+JugHfXlVBzuKwLssRqI=;
        b=OV+DHC5/SIoC4amaVokhJi1h8DH5jJt+JQEN4FIQkmYfH5tixnUo89E9eUcbnz0yTq
         hq7AB+TjId06VTaVqONAE83CuCLfY7DWQ+jqTBLU3aUOFDLFWOqaAdlWKLmv3haKl4Wn
         WQAdqkntsbueDUu7AhGe1bSppmIEahki72Z9NVdfB83YTdMl/OMTvGe8D1V31tHS024K
         9/Lqfy4rUwA2wJFoJNu+JQfGxyDXA2igvI9tp9PfRDb1KFzlQQDAsIvjbYupHzdZwjD/
         ats+8ogVEu/8AqFItn4nOcBuwPlkvY32IoVrIiC1SYVpyUzgzsDQl6xZrdz/Oqc4FWNI
         PCnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXfRzoNj8LwnjP3V+l3Y8uACqiCcOQRfO+XMxcOCE1tWlyRCilZfdApuVjSpqmp0CZbDZ0rsE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIseForudKN7zqbo21kISNRjwUdKap5/TTqlJ31jRDn8er+Xf5z
	WmcP0oK02mbmgA9ZjIywyWWGPGViVarumbbUTf+qHs6ieJHE5tMdDWeJ6XMxPHRg/+g=
X-Gm-Gg: AYBFou1DTdQp4H84N8bGn9sazWHHTUPgN3QBbOjlLsCYMTyff/b6S9BsFuHEv3EuXQl
	6lit8Y/T4tBIVb+0ZtgB3xsK4P/QUvNlTEkTHwbmSe4SrVllZ0yO5P6XdraQfrPQawIROjtN1wJ
	9K/0K02jC5ixWDb1CTB/zJmwS7ooSWfXilgxmfQk9CiVlvBYlg1gwGJFHC0KEz/T5qdbogm4bGx
	DHAGVnxIKvEK6myDMUue3GXZ1TowwqLNdUEg//oKuG8Rpp4dYRrFKWJo9D3R67NJIKp835ZQq4o
	rrwvGMQGTFMBj1btuamNvYl+SQ0vJ8JGGBtZcJejPX2R8ACanSyV3U5OYGZxdRN7z0Oy+qBrTC+
	dtMKQCU5QIkkHxY7lVDLHfx9YzNju3DkIeoJO7L0QzR/JcqDubP4oylKDdNn83MxpSetK7SFZvo
	6fJfddnRnqru0kW/7sFUk5ugUoJlwMZQyHGoU6APDoPtjumbkso+w8hvv5v7yyrFu0WD/cmKeRa
	dR+8UEhBBFHd/u7xc8Ufy7Dz5ioy0r3aQdMOtwNuEvA+8vRzAmsiy/zEJy7/wtCsVWWTa+x/oUm
	EzQj0RzNzVQM+Q==
X-Received: by 2002:a05:701b:240d:b0:144:eb46:c3f with SMTP id a92af1059eb24-16a572659bamr17782878c88.2.1791860257094;
        Mon, 12 Oct 2026 19:57:37 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm34465316c88.20.2026.10.12.19.57.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 19:57:36 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andy.grover@oracle.com,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	gio@octane.security,
	Shubham Antil <shubham@octane.security>,
	sungbyeongchan <tjdqudcks0424@naver.com>,
	Robert van Eijk <robert@octane.security>,
	Paolo Gentry <paolo@octane.security>,
	stable@vger.kernel.org
Subject: [PATCH net v4] RDS/IB: validate receive fragment completions
Date: Tue, 13 Oct 2026 08:27:29 +0530
Message-ID: <20261013025729.40815-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_ib_process_recv() accounts every receive fragment as contributing
min(i_recv_data_rem, RDS_FRAG_SIZE) bytes, regardless of the completion
length. When a completion is shorter than the header-declared amount,
receive accounting can advance beyond the payload supplied by the
completion.

Only an IB_WC_RECV completion has the buffer layout expected by this
receive path. Other successful completion opcodes must not be interpreted
as ordinary receive completions.

Reject successful completions with any other opcode before processing
their length. For ordinary receive completions, require enough payload
to cover the amount accounted to the fragment before linking its page
into the incoming message.

This is compatible with the current transmit paths. MSG_ZEROCOPY is
restricted to RDS/TCP, while RDS/IB copied and page-vector messages use
full-sized non-final scatterlist entries.

Found during an LLM-assisted source audit and validated under KMSAN with
a malformed short receive completion.

Reported-by: sungbyeongchan <tjdqudcks0424@naver.com>
Closes: https://lore.kernel.org/netdev/20261006205204.1322102-1-tjdqudcks0424@naver.com/
Reported-by: Giovanni Vignone <gio@octane.security>
Link: https://lore.kernel.org/netdev/8a6ee1d5336ae65b8ffdc8c40a1135657207e204.camel@kernel.org/
Reported-by: Robert van Eijk <robert@octane.security>
Link: https://lore.kernel.org/netdev/8a6ee1d5336ae65b8ffdc8c40a1135657207e204.camel@kernel.org/
Reported-by: Paolo Gentry <paolo@octane.security>
Link: https://lore.kernel.org/netdev/8a6ee1d5336ae65b8ffdc8c40a1135657207e204.camel@kernel.org/
Fixes: 1e23b3ee0e94 ("RDS/IB: Receive datagrams via IB")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
---
Changes in v4:
- Reject malformed short fragments instead of normalizing their length.
- Reject successful non-IB_WC_RECV completions before trusting byte_len.
- Explain why MSG_ZEROCOPY cannot reach the RDS/IB transmit path.
- Add the source-audit and KMSAN discovery details.
- Remove the author's self-Reported-by while retaining linked reporters.
- Leave maximum h_len validation to a separate investigation.

v3: https://lore.kernel.org/netdev/20261008124940.13371-1-shubham@octane.security/
v2: https://lore.kernel.org/netdev/20261007062135.49946-1-shubham@octane.security/

 net/rds/ib_recv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index bd6cb3ffaa..aa50b85b0f 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -949,6 +949,12 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 		}
 	}
 
+	if (data_len < min_t(u32, ic->i_recv_data_rem, RDS_FRAG_SIZE)) {
+		rds_ib_conn_error(conn,
+				  "fragment shorter than header-declared length; forcing reconnect\n");
+		goto done;
+	}
+
 	list_add_tail(&recv->r_frag->f_item, &ibinc->ii_frags);
 	recv->r_frag = NULL;
 
@@ -1004,7 +1010,12 @@ void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic,
 	 * event is processed.
 	 */
 	if (wc->status == IB_WC_SUCCESS) {
-		rds_ib_process_recv(conn, recv, wc->byte_len, state);
+		if (wc->opcode != IB_WC_RECV)
+			rds_ib_conn_error(conn,
+					  "recv completion had unexpected opcode %u, disconnecting and reconnecting\n",
+					  wc->opcode);
+		else
+			rds_ib_process_recv(conn, recv, wc->byte_len, state);
 	} else {
 		/* We expect errors as the qp is drained during shutdown */
 		if (rds_conn_up(conn) || rds_conn_connecting(conn))

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0
