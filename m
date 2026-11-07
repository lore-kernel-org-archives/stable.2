Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038845;
	b=f3WwojplIL21EqERdJxOfkkrEBs3/bZ6bRFQd7qKe6e1zcrWOYtRkyoLIK2/770ERZaL
	 FX6R8JZJTkTFazxwEaEhuUItQ3rKAIk6hcqKWx8ZdGqT1swsJB0Z0XcBFGeV9XEm1v8hS
	 ZhPgUbAjUr+FiBLzmXRmhY8dXE2WLg10/DCNlnK3CIdrlEazaJnNEV3UD+dueNPi+LUFO
	 uPgtloPItwX0+0x15rN7uYV3V/BGa98aTEM7ampVGZSZWK1tbWLFNeOOecgmDj1c3Sp3j
	 vqPZH82EMQ3xby/D8TcFJ92mmNhkBeKeQ9iLSoahY6SMr4kPCyV9XpeSbXnuYQVw1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038845;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ZP9NtSrlooK9VhB0rSMTcWQqhg5ZFlrIy3RevyzKXN8=;
	b=XSHSOEG17wq/ffMNuvnmKGQIv0Kxnhm1S5QeV4bFtCF44OACvrwTuPg4um5U8DFkymjn
	 k3664EIpUPfVDg70mQPuLjJGgKKo7erYCZJwoCZ0YzNV9VDpeVG+pRurrmryQ3aAPe8wT
	 Wu+PfA5TE65363V8NsEqZKo7yqgP2CtbJ/l17FqrRFSVK7SSaI8GqB2GCL0KVt0JYJBaP
	 w3ny0Y7W/PpQE1UFHg82y7MLXfN5JnbmXQllaiSMyGN/RIklEGI0QK3UfeUfUBu5BZyef
	 fYGS762GkyRbToM8XeOLrKSaNjZDRy6Y5rP1k+9vlkvF3JmV6xAuR6gP16ya1sHYFFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2B606A330;
	Sat,  7 Nov 2026 08:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB2B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXhP443O5qzr5xAA--.13418S2;
	Sat, 07 Nov 2026 16:07:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans de Goede <hansg@kernel.org>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 0/2] platform/surface: aggregator: Fix packet list handling
 in ssh_ptl_shutdown()
Date: Sat, 07 Nov 2026 08:07:30 +0000
Message-ID: <20261107080730.0-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXhP443O5qzr5xAA--.13418S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4rZF1rAr1rAry7Ar4fXwb_yoW8XFy8p3
	yrG3yvy3yDJr17tF17W3Wa9FWfZF45Xay5KrZ8u34jvrn8JFW0vr109w1j9FyDuasxW3W7
	Kr4vqrn09F4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUgUKsDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIEA2rub5HADAAAs1

Hi Maximilian, Ilpo,

this is a split of the single patch I sent in September, following the
review comments from Ilpo and Maximilian. The two problems in
ssh_ptl_shutdown() are independent, so patch 1 corrects the list that
pending packets are moved to, and patch 2 makes both drain loops safe
against the packet being released while iterating.

Changes in v2:
 - Sorry for the delay in getting back to this review.
 - Split into two patches as requested, instead of one patch that mixes
   two independent problems.
 - The pending/complete list mismatch has its own changelog describing
   the effect of the wrong list node, as Maximilian asked for.
 - Both patches carry Maximilian's Acked-by.

Link: https://lore.kernel.org/all/20260917135607.2154130-1-vulab@iscas.ac.cn/

The candidate was found with our static analysis tooling; the audit and
the fix were then assisted by DeepSeek and GPT-6.1 Sol. The patches are
based on mainline as of d4872371bae (v7.4-rc1) and were built for x86_64
with CONFIG_SURFACE_AGGREGATOR=m, without new warnings; checkpatch.pl
reports no issues. I could not test them at runtime, as that needs a
Surface device shutting down with packets still queued or pending.

Wentao Liang (2):
  platform/surface: aggregator: Fix wrong completion list for pending
    packets
  platform/surface: aggregator: Fix use-after-free in ssh_ptl_shutdown()

 drivers/platform/surface/aggregator/ssh_packet_layer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

