Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093735DA76
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496973; cv=none; b=S43Zu5UKMCw3uG3eDdzdBajvUIWDC4uXocvDL9tf2f3JKlrRJ59qQEn+AK/Enu5fTcUWoV8sko8s80KpvscNIrdwZLZ3tYzUZ70L4praKfBlF0Yvyr8LfnNHknbUT36hCALgBaLxHgMFnlxcPIZscAS6tnQEmAxNu/h0lmxENlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496973; c=relaxed/simple;
	bh=4OEbP2gNYq82L8iRYmLz8/ZHk/S8FwuMtxCbAMkye6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0PAVPJWtkOP44MOtsQbJL6cBM8LeR5i3Zi1ZD4Sq0Z2mdmu/pYji3es5//QARaXPnUloKXDNKr1v59gFFp9WhZU5U7hj4Ua97rCnyE0fp0Sn0TsF2oK7nrjqxaNraACp2fJEixdCreNFKMqZmA1MNch2FZS1ypnrFn9JDNefGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amEPVxTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amEPVxTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC21F000E9;
	Fri, 31 Jul 2026 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496971;
	bh=+xLz5M9K31miPzvGF/wIhxX/RPJVzsegos4ipIRk/Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=amEPVxTYKk68bl+QcFAMfPv/cfD1iYw2NRnABhYgY93B/q5MMVBtJK02LC+/cnL58
	 JfNzJOJ4ORy3UnS8MEGuW3eHcvphvtBFWlKM2cfI9dzpzqbqQi+t7oceQn6PvoysJf
	 vluLgSokgXo6KKT5CCHLqYxrLVQNf9h+EC7wHmPcQZlHprVmlNf3RCVxcqJTlPzH04
	 lKV4BY7h/jKGpPa6waYfuX7qtu7/fFu+Wan1q5KxxMOn/RLdUyYX7sIrllMsHaCt+n
	 DtB3AvyBHYM1Ev/QnH2+Egzd5tiycJzguxDQwFq5sWrnqqfxPrhn4Yn8ZU3kvbHTdk
	 yibDH6elHEYNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 07:22:49 -0400
Message-ID: <20260731112249.3667261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072940-comfort-punctual-b84a@gregkh>
References: <2026072940-comfort-punctual-b84a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

[ Upstream commit 1a8f537f5a1eeac941f262fe73078d6b08ba83c0 ]

drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
message and then unconditionally does:

  memcpy(bytes, &raw->msg[idx], num_bytes);

without checking that idx + num_bytes <= raw->curlen. raw->msg[] is
256 bytes; if a malicious or misbehaving MST hub sets num_bytes larger
than the remaining payload, the memcpy reads past the received data
into whatever follows in raw->msg[].

drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
with a /* TODO check */ comment since the code was introduced).

Fix both functions by using a single combined check
(idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
it is always >= 0, so this strictly subsumes the simpler idx > curlen
form and no separate step is needed.

Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[added missing fixes tag]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260510201733.2882224-1-ashutoshdesai993@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 65722f4b30ae..fd62d5c7c444 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -861,7 +861,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -897,7 +897,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
-- 
2.53.0

