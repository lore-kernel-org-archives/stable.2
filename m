Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357441;
	b=Baq0DXrBCgNlLPZEa7rxQR7f4z5PpicT1kXLLFIpN8S55eyJivwUOBQzScZDQz6Qbwkw
	 IS22VL+B5uSn4rOcKub41i8IDfqEljo5A4hG14sXIH/g4+XUmP+aRI/JAw4n1gDdgaLkA
	 kqD7nWNavGv5iAWEUmbFsOH8vGFKW/JIxt+ZxUqU7+IETpnbBCOm1GtdBeRrshErojimL
	 p4Z1WSzS96joAFWWfLbiB4aVvCAWADdEwOxyjWqmrItUrdih5fqOBrNbfPdHtmZSiyLeU
	 9GaYvQNWshZLxwzZnVwaESMaon4u5HcaZLxo1/DdRcYOvOV0xGsaLx7WMJQQSrM0zqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nxmRpFjzBtqQtg6QbZ/WLqfmkST/WPtasD+tCo13H/4=;
	b=avr8s7Du9GnRXQ3DWtD6xeOC5ofCZesvcZVKq+D4rySMNKfPjeGyJkOiayPeK+iVMADH
	 l7uQQAh5u59pAoiSRrWLZ6vG1rQcObquw4Mjm/pZoGujmDi0S2x9VYOof8rh3kr/5n9pl
	 dSMRvuj+JK9fZJg2Wp/iylN83xdBWThzQ7ERv7lwg3tW6xQA4f8pE0OrqgPSRipFrlQ+U
	 2ZhSMv6H+KofDFVeBf2HZS5WYnfMpEsDoQBZEFzhjdQPtj6You3HRVEDHYndkOU66VRaV
	 jnyYKGHFifMreKoDNOaMRcf5z8OCtz3U7YvbsONdZ7A4t/lQuEeMTIy1/eMeb41QL8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czKiws1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB0606B941;
	Fri, 30 Oct 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czKiws1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2821F00A1F;
	Fri, 30 Oct 2026 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357440;
	bh=nxmRpFjzBtqQtg6QbZ/WLqfmkST/WPtasD+tCo13H/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czKiws1qs/nib7N7FZOtJfcQk7ZWzK9rns2VbCINBdfE+6kN8IWubflmNPA0zbR//
	 rfB7woe9JTFx21EwFg7I9LY1T5Du/ggUPzFXHvrj0BlgakeThp91cawm1L+o1LyqyL
	 1AHGmtHG74MAlfEoWbZala91E5G3NEYnP0Oi35MZDl8hcTUZff8ulf7/C8m0qYjZNV
	 dIlKmtLzkn/+rToToYj9YKqjtnpC0jTzaekhFairYUH0q+L0LrURPa6sn62Yyb4VPR
	 /nA573x1xTko2fmamjoeup3Q6fih2Mb6pEQoQ5qYfnN2ynFrXGVL9XsJGKZEp83SNY
	 jcD73pBkMsn9Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Rander Wang <rander.wang@intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/21] soundwire: stream: Prevent m_rt_count underflow in sdw_stream_remove_master()
Date: Fri, 30 Oct 2026 10:46:42 +0000
Message-ID: <20261030104840.3361217-4-lee@kernel.org>
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

stream->m_rt_count is only incremented in sdw_stream_add_master() after
sdw_master_port_alloc() succeeds.  However, sdw_stream_add_slave() can
allocate a master runtime without allocating master ports, and
sdw_master_port_alloc() can fail after partially populating
m_rt->port_list.  When sdw_stream_remove_master() subsequently tears
down the stream, it unconditionally decrements stream->m_rt_count,
underflowing the counter when master ports were never allocated.

Free any partially allocated master ports on allocation failure in
sdw_master_port_alloc(), and only decrement stream->m_rt_count in
sdw_stream_remove_master() when master ports were allocated.

Fixes: ac3bc88cc56e ("soundwire: stream: separate alloc and config within sdw_stream_add_xxx()")
Closes: https://sashiko.dev/#/bug/linux-bce288e6-c97f-46dd-9fc3-023c33d56f36
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/stream.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 0b00fcdcab2d..f225e5438ccf 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1113,8 +1113,10 @@ static int sdw_master_port_alloc(struct sdw_master_runtime *m_rt,
 	/* Iterate for number of ports to perform initialization */
 	for (i = 0; i < num_ports; i++) {
 		p_rt = sdw_port_alloc(&m_rt->port_list);
-		if (!p_rt)
+		if (!p_rt) {
+			sdw_master_port_free(m_rt);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -2108,9 +2110,10 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 		if (m_rt->bus != bus)
 			continue;
 
+		if (sdw_master_port_allocated(m_rt))
+			stream->m_rt_count--;
 		sdw_master_port_free(m_rt);
 		sdw_master_rt_free(m_rt, stream);
-		stream->m_rt_count--;
 	}
 
 	if (list_empty(&stream->master_list))
-- 
2.56.0.317.g454f8302e1-goog

