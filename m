Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038846;
	b=Vs/GHHLU8FowHTvpzpQcVZ/VsKPRuH0/eB6llQpeA19E9WgYWvwhQDO+7/Zl4VUGfgwB
	 SZp7STS030hwjS9paVIoiYYJL4iIwiPNgJNMnBSEAs/JYn67gMbx38JFnOEu63eCERRNi
	 XdStkGKZ2Ke7glnQ3GEcYOH31kOyfc+ARiSXDUgHwnGB2J3taLvw1bpIljz9K0mBDbDTR
	 QeROrY2L/DX0kPRYRMrVVJ6LNZD/GDJv03WUtaQZYanhQiDApOyQAoJzi7FuEDYU5uJXN
	 pJLZNo6cJOTiPw6mldrpsEBDM1qlrbYMg8T/eLLFbY0SbdYNzCriPYCbVsPZ7yBJ2Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038846;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=bgCp1Ntl0hpGN7wbF0e+QO8amvIdAh43gaGIfm69pF8=;
	b=FjglV6lKkls2uTjQ+odT8Q3CEDtF0/cQwkG1s3r7OLHwuqNTEl1Elavo37wc5DANHZuS
	 B3LYBaYTITW2h8+84I5SX7+vKMZRDsLCFsHJsIrMBpZ6EAOQuIVDp/EvIXOnFrukau6CV
	 QrUmYQl90gY7QgxLRXDVXsnANWboaNkBJpsdX44IwW04I9eR35X9ZQfR6Dpy0UvMIFyEu
	 T/e52w8JDzwMClwDxRDbqao0zh2S17a4qVW8POySVSvaxbE29YvUzumxBh4SFo7z1vYlv
	 IRAi/eBbxoGCqgBkcjQd7astSbDm7J+FWjMXm3P5SmUcZGHlZH7CL7WMd38fNttGvXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBD3606A335;
	Sat,  7 Nov 2026 08:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBD3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXhP443O5qzr5xAA--.13418S4;
	Sat, 07 Nov 2026 16:07:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans de Goede <hansg@kernel.org>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/2] platform/surface: aggregator: Fix use-after-free in
 ssh_ptl_shutdown()
Date: Sat, 07 Nov 2026 08:07:30 +0000
Message-ID: <20261107080730.2-vulab@iscas.ac.cn>
In-Reply-To: <20261107080730.0-vulab@iscas.ac.cn>
References: <20261107080730.0-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABXhP443O5qzr5xAA--.13418S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF18ArykWr48KrykZw47urg_yoW8Cw1rpr
	WUG3y3Kr4kJr47ta18Gw4j9a1UZayFqw4j934F9w1Uuws8XrnIgr1I9r1rWF90kFWDW3ya
	kr4ktr45Z3WjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxU2f-BDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcEA2rub5HADQAAsx

Both loops that drain the local packet lists in ssh_ptl_shutdown() call
ssh_packet_put() on the loop variable. This drops the reference that the
queue or the pending set held on the packet, which can be the last one,
so the packet may be freed before the iterator advances to the next
entry. The iterator then reads the list node of the freed packet to do
so.

Use list_for_each_entry_safe() for both loops, which caches the next
entry while the current packet is still alive.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Cc: stable@vger.kernel.org
Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/surface/aggregator/ssh_packet_layer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index a51395942747..871780828419 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1989,7 +1989,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
 	spin_unlock(&ptl->pending.lock);
 
 	/* Complete and drop packets on complete_q. */
-	list_for_each_entry(p, &complete_q, queue_node) {
+	list_for_each_entry_safe(p, n, &complete_q, queue_node) {
 		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
 			__ssh_ptl_complete(p, -ESHUTDOWN);
 
@@ -1997,7 +1997,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
 	}
 
 	/* Complete and drop packets on complete_p. */
-	list_for_each_entry(p, &complete_p, pending_node) {
+	list_for_each_entry_safe(p, n, &complete_p, pending_node) {
 		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
 			__ssh_ptl_complete(p, -ESHUTDOWN);
 

-- 
2.34.1

