Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487941;
	b=R5/242tjydElX2qdadot1zM+1broSW5vdh23Qb3lauYRGAhmho5XPGWFdc1yHjBGnB77
	 I8MJj0mWza5HHnbjd/7LqSYIS1VDo475tn/6WjS/og9orsnOmygB0eH/CMUqeU3TwwwjA
	 vSYuudGVVDXWJu9p0c+qrUwe7rZ0QWc64dAZo8xRZRT0BAgAnYgvumrbCsKndCYSYn2eL
	 MCWisnVVC06Io0B+tW88dmWKkN9X8+ZNv0/eLo7r9tVZKpFqIQnC8w8K8K3D3CbjptaM4
	 OZzOP6OozSZS6LuRCt7Iggo7uknOX4vWyYak9t5fHbYSZs4X2u63i6au8jc12knXPsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487941;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxtGBN2glWF6C8GA+0CSJwlB27w7Ez9V7PeT7YJ/Diw=;
	b=SplxYWi9tprf7mnh7rXjt+wmDKElg5xdzJb4QDBNisPW4oZLBTCyQyVhZwrKW4RUvSMC
	 AYk0G8c+YmWpCuATRqiTMnpDyWqgW2ANiC5T10LvCxkCDxFZF4K7LSwa0rPXkC5RiK92a
	 8NzHw+Ryg/l/ko4mD7MMxlA9WJyLnHREFaxanFLB9cNoSZ8QUbUe5GmFDGJTzGYmT0Bv8
	 nu6wtzdKlEuEMrxjoDwIf66mA+wQuwv5ba+tT2DPZtFcS3ipzVq+v0X3Ipy2uS13TOJwP
	 OcXrbUmBKEvG9mByF2GrZRwRyNSWvQKXSwZDn5o9rVQYPukHCqQ2DT2jaDx2KGcL4mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=spONBNO4;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A8606A89A;
	Thu, 12 Nov 2026 12:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C53A8606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=spONBNO4
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794487929; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OxtGBN2glWF6C8GA+0CSJwlB27w7Ez9V7PeT7YJ/Diw=;
	b=spONBNO4lEj1LGJMlCANeljE8TWPk5LEbfe/vLh2EngZ558UOQylKLP4kIWov2d9Ux8Xd5pVM4QQN5b9EJd8ItzOAcSSvLw+vL523cDzZdpaugPKoRYIkitOJxDSckW8/D3e+0YX3dLID2GlKmDhLjPcXVmKMWzldgWF/bC4NIE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04437039|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00378321-8.81247e-05-0.996129;FP=14274725869513639104|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k0cpddf_1794487927;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k0cpddf_1794487927 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:52:09 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Simon Horman <horms@kernel.org>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH net 3/5] net: wwan: iosm: bound the ACBH command chain walk
Date: Thu, 12 Nov 2026 20:51:59 +0800
Message-ID: <20261112125201.1019-4-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112125201.1019-1-fangxy@xiaopeng.com>
References: <20261112125201.1019-1-fangxy@xiaopeng.com>
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

ipc_mux_dl_acb_decode() walks the command chain of a received
Aggregated Command Block. first_cmd_index is passed through
array_index_nospec() with sizeof(struct mux_cmdh) as its bound, which
treats a byte offset as an array index: every valid offset at or beyond
that size is turned into zero, so the command it points at is dropped.
next_cmd_index is not validated at all before it is followed, so it can
point outside the received block, back at an already processed command,
or into the header just read. The walk can therefore read past the end
of the skb, revisit an earlier command indefinitely, or decode an
overlapping command header.

The overlapping case does not fault, which makes it the quiet one: the
current walk does not check that next_cmd_index advances beyond the
header just read. An index into that header is therefore followed, and
those bytes are decoded a second time as another command and
acknowledged a second time.

Bound the commands by the received length and require every command
offset to leave room for a complete command header. block_length is
checked to cover the block header and not to exceed the received
buffer, but it is not used to delimit the commands: the driver gives
the field no meaning beyond the header on this path, and its own
uplink encoder leaves block_length at the size of the block header.
What arrived holds either way.

Validate the link to the next command before the command carrying it is
processed: a non zero index has to advance past the current header, stay
inside the received data and leave room for a complete next header. Only
a zero index terminates the chain, which is how the uplink side of the
driver terminates its own command blocks as well. The offsets then
strictly increase, so the walk terminates, and a command is no longer
acted upon before its link is known to be usable. The array_index_nospec()
call is gone with these checks, which constrain the same value properly.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 46 ++++++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index b573067a366f..2c4f175233a1 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -526,30 +526,60 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
 /* Decode an aggregated command block. */
 static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
+	size_t hdr_len = offsetof(struct mux_cmdh, param);
 	struct mux_acbh *acbh;
 	struct mux_cmdh *cmdh;
-	u32 next_cmd_index;
+	u32 block_length, cmd_index, next_cmd_index;
 	u8 *block;
 	int size;
 
+	if (skb->len < sizeof(struct mux_acbh))
+		return;
+
 	acbh = (struct mux_acbh *)(skb->data);
 	block = (u8 *)(skb->data);
+	block_length = le32_to_cpu(acbh->block_length);
 
-	next_cmd_index = le32_to_cpu(acbh->first_cmd_index);
-	next_cmd_index = array_index_nospec(next_cmd_index,
-					    sizeof(struct mux_cmdh));
+	/*
+	 * Keep block_length within the received buffer, but use skb->len
+	 * to bound the command chain: the uplink encoder sets
+	 * block_length to the ACBH header size.
+	 */
+	if (block_length < sizeof(struct mux_acbh) || block_length > skb->len)
+		return;
+
+	cmd_index = le32_to_cpu(acbh->first_cmd_index);
+
+	while (cmd_index != 0) {
+		/* Every command header has to lie inside the received data. */
+		if (cmd_index < sizeof(struct mux_acbh) ||
+		    cmd_index > skb->len ||
+		    hdr_len > skb->len - cmd_index)
+			break;
 
-	while (next_cmd_index != 0) {
-		cmdh = (struct mux_cmdh *)&block[next_cmd_index];
+		cmdh = (struct mux_cmdh *)&block[cmd_index];
 		next_cmd_index = le32_to_cpu(cmdh->next_cmd_index);
+
+		/*
+		 * The next index has to move past this header, stay inside
+		 * the received data and leave room for a header of its own.
+		 */
+		if (next_cmd_index != 0 &&
+		    (next_cmd_index <= cmd_index ||
+		     next_cmd_index - cmd_index < hdr_len ||
+		     next_cmd_index > skb->len ||
+		     skb->len - next_cmd_index < hdr_len))
+			break;
+
 		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
 						       cmdh->command_type,
 						       cmdh->if_id,
 						       cmdh->transaction_id)) {
-			size = offsetof(struct mux_cmdh, param) +
-				sizeof(cmdh->param.flow_ctl);
+			size = hdr_len + sizeof(cmdh->param.flow_ctl);
 			ipc_mux_dl_acbcmd_decode(ipc_mux, cmdh, size);
 		}
+
+		cmd_index = next_cmd_index;
 	}
 }
 
-- 
2.50.1

