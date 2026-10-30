Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357423;
	b=mEehNuCOejY/OAkeCFVXpiQf1WSBDoo82Vs5a38M/49t62F7kKDaDQKhBhwo32oK+Hoe
	 SpVthxBEDCt56mLr5lq1B/UeK3+XmrOazDkM/srG12NAxIjBTzDzLFGF2Ia8JipXZtD51
	 NjcuBSClBrrP1Bsq+O7obXOuQ3wlhBgPWFrIzrwAgZIxiyBymBC5GrbbJvWw8XxIUCVLJ
	 0mi9PP07QqqGyMOnWMuavPF3ghQbgDKgkcptMI2lkANM5V40l70mk3TmqVC35is0lL/l9
	 hoyGKaJGwU8dU/B3cQB6zSgvC3QyE4PClMsbTrKQ2SVMM+VIJVLnqOaYhSfrsqgQnwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DjtoL8ZtCz0GQZpX57ulkcLnwiYsE5MZAt/R4gtCuDU=;
	b=1yZlo5ZlAsre3afZNmEWaClvOdQbylcLs2A1SUEEs2mv117RE1p0Tsi/IQtwIM62ntfh
	 QMMmWb6Xj4V+SmZygZtZSNPLDzqNnPSu7VDUvlt5AFZWBrFfAsJJ5ghYC0g2rIckP6A8e
	 zMI9ngr1V+8tsTc0jQMkw378OSeKi/L31VDA5tA2BiTTsggBC1191eC6U8alwY7evovRg
	 MLhXXBM526oo3e/uilo1glA7b998u5DmgcqCl1ikaemXwD9yePmImP2VL9bL8mphECMBu
	 ituLhKyw09M9jftYtIDfsMzOVGFEDOMntZijOElNtmKULSf7yDxpPKKonh/VlIBe8zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPgT3h7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D9606A8E1;
	Fri, 30 Oct 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPgT3h7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAEA1F00A16;
	Fri, 30 Oct 2026 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357422;
	bh=DjtoL8ZtCz0GQZpX57ulkcLnwiYsE5MZAt/R4gtCuDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EPgT3h7ThJM3qPhWKv9VEhEHiyJcgoTRyug24Hv6vbldYncqzljke4bEm/FZjFK3b
	 qeJ8fDNJB/iL+aB7nLvUeP8MVDoGOsMLfQOS9apx4qQO1ftoKYsgRIuLakePMNPNSk
	 uIDFNfNn1mf84Alv/DeI9bcvHQqcI2+W3UQp7iuWxkAcDspuZTiNmhKTQ01WRB0IrV
	 z9z5qU6F33txSYcKok0vgX6h1a9ZMO3qYoztNfsUrD1xHVZ+wOravylpXE1e+KLI87
	 03Z+U5zToyJeY5qm1+WLBpR3NPYd6ctR/HYnuD99WkDxs6CEc1doeox/p63SPwVZZk
	 SOXBmaln8LHAQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Hardik T Shah <hardik.t.shah@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/21] soundwire: bus: Hold bus_lock when looking up slave devices
Date: Fri, 30 Oct 2026 10:46:40 +0000
Message-ID: <20261030104840.3361217-2-lee@kernel.org>
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

sdw_get_slave() iterates over bus->slaves and requires bus->bus_lock to
be held by the caller.  However, sdw_handle_slave_status() and
sdw_clear_slave_status() drop bus->bus_lock immediately before calling
sdw_get_slave().  If a concurrent slave teardown unlinks the node via
list_del_init() and frees the slave while bus->bus_lock is dropped,
sdw_get_slave() can spin forever on the self-referential list entry or
dereference freed memory.

Keep bus->bus_lock held across the sdw_get_slave() lookup in
sdw_handle_slave_status() and sdw_clear_slave_status().

Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
Closes: https://sashiko.dev/#/bug/linux-b0e65a93-dfd4-4e3d-a96c-8f13ba0aafd2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index aeaae5a57c89..15c66effbf4f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1907,9 +1907,9 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			mutex_unlock(&bus->bus_lock);
 			continue;
 		}
-		mutex_unlock(&bus->bus_lock);
 
 		slave = sdw_get_slave(bus, i);
+		mutex_unlock(&bus->bus_lock);
 		if (!slave)
 			continue;
 
@@ -1954,9 +1954,9 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			mutex_unlock(&bus->bus_lock);
 			continue;
 		}
-		mutex_unlock(&bus->bus_lock);
 
 		slave = sdw_get_slave(bus, i);
+		mutex_unlock(&bus->bus_lock);
 		if (!slave)
 			continue;
 
@@ -2052,9 +2052,9 @@ void sdw_clear_slave_status(struct sdw_bus *bus, u32 request)
 			mutex_unlock(&bus->bus_lock);
 			continue;
 		}
-		mutex_unlock(&bus->bus_lock);
 
 		slave = sdw_get_slave(bus, i);
+		mutex_unlock(&bus->bus_lock);
 		if (!slave)
 			continue;
 
-- 
2.56.0.317.g454f8302e1-goog

