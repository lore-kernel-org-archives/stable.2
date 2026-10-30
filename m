Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357449;
	b=NuJXb4+YNEnjR8q03/hGW0uJi/SbcZnrzN32MpqJ8evGPe9ACIbnw9spTSu2JVUMMU4G
	 oZ2zZSVewTwEkd/RZs2bJ6xmKbHHUb1z4yeZ3jFngPaX6QUOc5so/5jw70/aefzFE61yA
	 nC+gr7v6Wzjr4HK8gCRRjH9rMz7jqWMxdoFQQpPH+MpjkGcvHy9ppT02uAsVe8X/fx5T4
	 wjO30zu4NLtMYu5Yekag+/lqkyyHp5lOVSlyOTUnjuHTbUa7GexFyDo/C+/6N+sk5SohK
	 xTrH/CUU1bE/DFS9y96ER3ujzuwhOy9cumXOHbgekzXrwEjhxZBE1vy81nuqFNTYalg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sXT+nqoG3JcBZZLIfztu38Rfih77/q6GZgRF/MOrDFc=;
	b=XvvEhm7258jqWoXp26zS82xCKONCgxWonadkKzmX9YguMM1Y+uVIHNWmvlO7BCYX/DAg
	 F+5oI/Xu6k8JjRiqOk0rUiGHlpZ+Lic7URyKiSzUb9Tjy/zhSLNgYG1lC8IN1oBxBSq+M
	 q0anOxUku0/2vmDA73OAUlBV8ezF1DeXlbfZNdQ9jaG29qV/RCA+FcugPbG5SjRWTl9Va
	 F5UISOfLdZcxcNRXFZ+AEk4ajk4Kpv5iKuP0XG3B7YuNZZnIPwqp0qfz4dGrE2A0dqVvi
	 PBjvVEX4E4EqC1tHjmain3PNN2y/Uof3EAkjKP13lTFiD7a0y/C1mbzn8carLNipM0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPBvXQqR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF4606B972;
	Fri, 30 Oct 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPBvXQqR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037CD1F000C1;
	Fri, 30 Oct 2026 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357448;
	bh=sXT+nqoG3JcBZZLIfztu38Rfih77/q6GZgRF/MOrDFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WPBvXQqRna6Lw26P+AfJSNlfSdRbhBAmCDFzaLC/d1GClOZoJJUmlHf4jMhD3Jlph
	 Lax6G/F4sPh8viWFjf+DSZhpWbLoPMBmxyVCTO4A57l0SjV85uJzmsSnxvVLvbC83r
	 pIAN0jI6vPohWj0sbNQO5zSk1kgn/0rzWecvmQ+Q868YZd2lF4/bRJWs1RM+7o4GtG
	 sHeQ3VDbzfteLRrSDsOQRu5ZvljjyBoZiiqbACHZeazx7CDhKWKhR+f+8J++cvU7IV
	 rPtVThqRFXbh2+DrRI8hGMmul/zc8bt2wV22ZrhcowYQhCJ+uSq9h27BN7HrJFJVEq
	 GBeqCwxgfE4sw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Rander Wang <rander.wang@intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/21] soundwire: stream: Clean up allocated runtime resources on config failure
Date: Fri, 30 Oct 2026 10:46:43 +0000
Message-ID: <20261030104840.3361217-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

In sdw_stream_add_master() and sdw_stream_add_slave(), failures during
runtime or port configuration jump directly to the unlock label,
bypassing alloc_error and leaving newly allocated master/slave runtime
and port structures attached to the stream and bus lists.

Track whether ports were newly allocated in the current invocation and
route configuration failures through alloc_error so all resources
allocated by the failing call are released.

Fixes: ac3bc88cc56e ("soundwire: stream: separate alloc and config within sdw_stream_add_xxx()")
Closes: https://sashiko.dev/#/bug/linux-546e137d-6e4d-4f22-99c3-8ccc8beb5350
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/stream.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f225e5438ccf..97338a13c1a0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1026,14 +1026,18 @@ static int sdw_slave_port_alloc(struct sdw_slave *slave,
 				struct sdw_slave_runtime *s_rt,
 				unsigned int num_config)
 {
-	struct sdw_port_runtime *p_rt;
+	struct sdw_port_runtime *p_rt, *_p_rt;
 	int i;
 
 	/* Iterate for number of ports to perform initialization */
 	for (i = 0; i < num_config; i++) {
 		p_rt = sdw_port_alloc(&s_rt->port_list);
-		if (!p_rt)
+		if (!p_rt) {
+			list_for_each_entry_safe(p_rt, _p_rt,
+						 &s_rt->port_list, port_node)
+				sdw_port_free(p_rt);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -2018,6 +2022,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 			  struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
+	bool alloc_master_port = false;
 	bool alloc_master_rt = false;
 	int ret;
 
@@ -2063,18 +2068,21 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		if (ret)
 			goto alloc_error;
 
+		alloc_master_port = true;
 		stream->m_rt_count++;
 	}
 
 	ret = sdw_master_rt_config(m_rt, stream_config);
 	if (ret < 0)
-		goto unlock;
+		goto alloc_error;
 
 	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
 	if (ret)
-		goto unlock;
+		goto alloc_error;
 
 	ret = sdw_master_port_config(m_rt, port_config);
+	if (ret)
+		goto alloc_error;
 
 	goto unlock;
 
@@ -2082,6 +2090,10 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	/*
 	 * we only cleanup what was allocated in this routine
 	 */
+	if (alloc_master_port) {
+		sdw_master_port_free(m_rt);
+		stream->m_rt_count--;
+	}
 	if (alloc_master_rt)
 		sdw_master_rt_free(m_rt, stream);
 unlock:
@@ -2147,6 +2159,7 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_master_runtime *m_rt;
 	bool alloc_master_rt = false;
+	bool alloc_slave_port = false;
 	bool alloc_slave_rt = false;
 
 	int ret;
@@ -2197,24 +2210,26 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
 		if (ret)
 			goto alloc_error;
+
+		alloc_slave_port = true;
 	}
 
 	ret =  sdw_master_rt_config(m_rt, stream_config);
 	if (ret)
-		goto unlock;
+		goto alloc_error;
 
 	ret = sdw_slave_rt_config(s_rt, stream_config);
 	if (ret)
-		goto unlock;
+		goto alloc_error;
 
 	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
 	if (ret)
-		goto unlock;
+		goto alloc_error;
 
 	ret = sdw_slave_port_config(slave, s_rt, port_config,
 				    stream->type == SDW_STREAM_BPT);
 	if (ret)
-		goto unlock;
+		goto alloc_error;
 
 	/*
 	 * Change stream state to CONFIGURED on first Slave add.
@@ -2231,6 +2246,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * is intentional, the 'master_rt_free' will call sdw_slave_rt_free()
 	 * internally.
 	 */
+	if (alloc_slave_port)
+		sdw_slave_port_free(slave, stream);
 	if (alloc_master_rt)
 		sdw_master_rt_free(m_rt, stream);
 	else if (alloc_slave_rt)
-- 
2.56.0.317.g454f8302e1-goog

