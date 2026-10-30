Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357521;
	b=DxGkQj4FAN/wraGl1Qr5B6zxumh2rskEEmlm/avZW48M7QFrp0hgurG3iNCbDe5s5fvP
	 d18gOFBuwkOvEAV8i7ED11vItiAPbX9tj1+0qF8OGYmHftwUNADqDsk0/UBhj53SgGb4d
	 RbjQPcB/MJcut58VDeRuMLZY4nt/Agy5AM4WKAGFbjEkx4gSjZan3QrZMZQuvmdDVRJvm
	 bvaBURbx0vZXCgh0RpKbeEfebNuQkpQ9/T9cqw9X2ww+yiIkyTSErEemAOacOfb5bUuOq
	 4TJiKOUTmwliGce1KPoxGjdcX8ZbaBEX35D4B1AJf00X2EL3rIojkMyl9MKE4+lD5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oG54i4kl5NXze2C9s+kAcCjuvcjoC6+Dc3ty3ICwCcc=;
	b=2TAQNrjWxQuwNoURQmLBszqkPAtVAlDTeiKaQeSUG/TPRRYwg/MD9J1/xq9Lg6k4WY2I
	 6fVLpSoUKQUsx11O+SL6GBR59x92Mf6n3w13hX0AD72Agz59cwMFlCyxPmZ2o9Q5lKQoY
	 7esWvCMNh7pl3Xxj30yeHzyFLe4yl/paHwnr5YmJIClPl9HwX/bDrMPmo4sIw8RxhfevC
	 GLBNJ4G5suTSI7kIUiNtV/dx1VTe7RHdbwN8lb4PD+hlwduZd/1/iEd/LNI9zasaoxftK
	 ba8xdk0wcfZNabZBU2dfo71NT6N4lb8qJRD6tt7QOzDxVq1IfQk3ZccHUneNR3qOrIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEfscRCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A8606A8ED;
	Fri, 30 Oct 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEfscRCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187631F000C1;
	Fri, 30 Oct 2026 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357520;
	bh=oG54i4kl5NXze2C9s+kAcCjuvcjoC6+Dc3ty3ICwCcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEfscRCzz9waCf/ogI3w1hzAibsVRif+HDZS5mJXty8CEoxO4YZ+lE6mZaT9yEJg8
	 wGQt15QPPEbUm/WdEgyXgNX6v3nSxIZ3rE9IUkTELOMEcGOQqG8KK8fC+vz2wwMav9
	 rSCp3xebgXrtwWw5ph5XxCINZA3bhAN7ROtrr+P7rIWkiJObvy5xFj3isS0mJZ2hLB
	 uGB29Jsh40wY18kESuUi0lqJwvHCA44ENy8gBfBs9I4G8rq73b9q6NmJZb5hLy9UHG
	 QuV8TMuyTvWV+RaztwDcKFPdkyW07G2+VKoSoxewLzBpayDcFFI8/fNSe7ovxhkXNi
	 UeIdJ4neohW+w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 15/21] soundwire: amd: Avoid static port offset leak in amd_sdw_compute_params()
Date: Fri, 30 Oct 2026 10:46:54 +0000
Message-ID: <20261030104840.3361217-16-lee@kernel.org>
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

amd_sdw_compute_params() tracks the next dynamic port block offset in a
static next_offset[] array initialised with {1} (which also leaves
instance 1 initialised to 0).  Because next_offset[] is static and
never reset when streams are freed or when the driver is unbound and
rebound, the offset grows monotonically across stream lifecycles until
it exceeds max_slots - 1 and permanently fails with -ENOMEM.

Compute next_offset locally in amd_sdw_compute_params() from the active
ports on the bus and clear port_offset_map[dai->id] in
amd_sdw_hw_free().

Fixes: 27ab4f1e4909 ("soundwire: amd: refactor bandwidth calculation logic")
Closes: https://sashiko.dev/#/bug/linux-a0378066-b3cf-426c-bc88-e4d5208965b9
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 48 +++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 9dfcdde3f2f0..98b09d81f3b8 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -469,6 +469,41 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	return slave_stat;
 }
 
+static unsigned int amd_sdw_find_free_port_offset(struct sdw_bus *bus,
+						  unsigned int slot_size)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	struct sdw_master_runtime *m_rt;
+	struct sdw_port_runtime *p_rt;
+	unsigned int next_offset = 1;
+	bool overlap;
+
+	do {
+		overlap = false;
+		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+			unsigned int other_size = m_rt->stream->params.bps *
+						  m_rt->stream->params.ch_count;
+
+			list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+				unsigned int other_bo;
+
+				if (p_rt->num >= amd_manager->max_ports)
+					continue;
+				other_bo = amd_manager->port_offset_map[p_rt->num];
+				if (!other_bo)
+					continue;
+				if (next_offset < other_bo + other_size &&
+				    other_bo < next_offset + slot_size) {
+					next_offset = other_bo + other_size;
+					overlap = true;
+				}
+			}
+		}
+	} while (overlap);
+
+	return next_offset;
+}
+
 static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
@@ -479,8 +514,7 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 	int port_bo, hstart, hstop, sample_int;
 	unsigned int rate, bps, channels;
 	unsigned int stream_slot_size, max_slots;
-	static unsigned int next_offset[AMD_SDW_MAX_MANAGER_COUNT] = {1};
-	unsigned int inst_id = amd_manager->instance;
+	unsigned int next_offset;
 
 	port_bo = 0;
 	hstart = 1;
@@ -511,11 +545,13 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 				 */
 				if (bus->params.curr_dr_freq == 12000000) {
 					max_slots = bus->params.row * (bus->params.col - 1);
-					if (next_offset[inst_id] + stream_slot_size <=
+					next_offset =
+						amd_sdw_find_free_port_offset(bus,
+									      stream_slot_size);
+					if (next_offset + stream_slot_size <=
 					    (max_slots - 1)) {
 						amd_manager->port_offset_map[p_rt->num] =
-									next_offset[inst_id];
-						next_offset[inst_id] += stream_slot_size;
+									next_offset;
 					} else {
 						dev_err(bus->dev,
 							"No space for port %d\n", p_rt->num);
@@ -824,6 +860,8 @@ static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_d
 	if (ret < 0)
 		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
 			dai_runtime->stream->name, ret);
+	if (dai->id >= 0 && dai->id < amd_manager->max_ports)
+		amd_manager->port_offset_map[dai->id] = 0;
 	return ret;
 }
 
-- 
2.56.0.317.g454f8302e1-goog

