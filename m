Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC195B21A;
	Sun, 20 Sep 2026 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886941; cv=none; b=c55GYkB+vMM+PpGvgnN2CDAar2SJGOy/a02VmtKpcZrw3EiJfMV7HN4RZ3niwPmNCLlcZCmqlBsuBnB4SL0lMIcBVs3Xqu08BOfWKIS7FRc9EDh+JDvJf7SsYj3zusGQTXe62NSD3HbuDgtnuULmnkaGgQMZtztLkaUHREi9I6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886941; c=relaxed/simple;
	bh=66LM1I859EyKcyh8gaB21EwTKfleaw/RiwJGDIUIio0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssULpTYllhx6C41pPZihwldJ2hpeuztq+nIYpxKsGGyJ6aa0S4PtYD/3WdhGqFqX2d+6uDsXJa+wgsMjffScepS3eqME0YqrBbxTZc4v1htfMxl4RJvqiM15e8p5z732V2myMk6Th5Wv3peABbT1MpEPYUwnoItL/3vqB+lB9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bDeDEz6o; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bDeDEz6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xn
	nrjYHteaJiELISGRVvsK99/RZqA1Xfx28O81X6+Is=; b=bDeDEz6oGiGVgjsWkd
	n4s2Ilyj6sRYaNugFzc6W2sq1M15z5Z1nGuLnXuGpW/iGGccEsUQN0MZOeHsLb69
	KHLzwvwV4Gszrzuedp6ZTnXfLMnfi//5k9EYFGOnll+4Bpyl/25131c/Whc3dsqa
	hU5EPdmljeksYdW2D+fbQIeh0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3j5Kbga9q9QbHBw--.42328S2;
	Sun, 20 Sep 2026 14:47:56 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net] ice: roll back the port VLAN when ice_eswitch_br_set_pvid() fails
Date: Sun, 20 Sep 2026 14:47:54 +0800
Message-Id: <20260920064754.1935818-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3j5Kbga9q9QbHBw--.42328S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWruryUuw1UAr15ArW5Jrb_yoW5Xry7pF
	WqkF90krWkXF4Ygw1qga10yr45Jay8ZrW0gr97K395Aw45Ar9aqrW7KF9FvryUZr1xJa4a
	vw1DCr1DCwn8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlR0O5GqvgZ10xQAA3K

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_eswitch_br_set_pvid() puts the VF VSI into port VLAN mode with
ice_vf_vsi_enable_port_vlan() before it programs the port VLAN itself.
Both error paths below that point return the error code straight away,
so nothing is undone when set_port_vlan() or add_vlan() fails.

The stale port VLAN is the more visible half of the problem.
set_port_vlan() turns on Rx VLAN pruning in the VSI context and relies
on the add_vlan() call right after it to install the matching prune
filter, so a failing add_vlan() leaves the VF VSI pruning away every
packet it receives, while port->pvid stays 0 and the bridge is told the
VLAN was not offloaded.

The VLAN ops table is never restored either.
ice_vf_vsi_disable_port_vlan() is only ever called from
ice_eswitch_br_clear_pvid(), which is reached from
ice_eswitch_br_vlan_cleanup() only when port->pvid matches the VLAN
being removed. Neither the failed VLAN, which was never inserted into
port->vlans, nor a port->pvid value ever got that far, so the VSI keeps
the port VLAN flavour of its inner and outer vlan_ops until the VF VSI 
is rebuilt:
dis_rx_filtering() turns into a no-op and, in Double VLAN Mode, the
inner add_vlan() and del_vlan() stop doing anything.

Unwind both steps the way ice_eswitch_br_clear_pvid() does: clear the
port VLAN from the VSI context when it was already programmed, then
hand the VLAN ops back to ice_port_vlan_off().

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 1d8a6b95ccda..53ce98ba7007 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -679,16 +679,23 @@ ice_eswitch_br_set_pvid(struct ice_esw_br_port *port,
 	vlan_ops = ice_get_compat_vsi_vlan_ops(port->vsi);
 	err = vlan_ops->set_port_vlan(port->vsi, &port_vlan);
 	if (err)
-		return err;
+		goto err_disable_port_vlan;
 
 	err = vlan_ops->add_vlan(port->vsi, &port_vlan);
 	if (err)
-		return err;
+		goto err_clear_port_vlan;
 
 	ice_eswitch_br_port_vlans_flush(port);
 	port->pvid = vlan->vid;
 
 	return 0;
+
+err_clear_port_vlan:
+	vlan_ops->clear_port_vlan(port->vsi);
+err_disable_port_vlan:
+	ice_vf_vsi_disable_port_vlan(port->vsi);
+
+	return err;
 }
 
 static struct ice_esw_br_vlan *
-- 
2.25.1

