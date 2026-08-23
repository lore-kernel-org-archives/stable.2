Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D938C438;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501415; cv=none; b=L5G2afXTzBK43jgaimOhKYJAeg+RnnF+O0AZ9iTX9B6PbSufVmN2Hcor6ItIY5ohg+aUU6rvgsv7i0GSB9gTKL0MxlBy1ZWjcffdVy4Cz0WkYfXLujwl5hw97T/s0lBeYK9WyUCUp2Adg54+Gj/zX5zACbFeztdT46UK8qAFIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501415; c=relaxed/simple;
	bh=Gf7s+iDVEY9i7s48leCOPqnKX0wFtaHwnlaLaAMjjTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f14nvGzw36YyTm/8+yA8F2Rk8ogeu+owt3EtlHBucLLkUxhCLc+x4NkVJximcsqFizCj3/M4AMIMnVbaI5R6xhr6F2r2ZBu+Uvvx8NpdAynlCFuh54F3IjncZnW+wk7A2zpDb9IknvcTq8GTFMKUo5Lcpm5Qc+gUNF/Il9Z6okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9kEyPLF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9kEyPLF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D6E8C2BCFF;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787501415;
	bh=Gf7s+iDVEY9i7s48leCOPqnKX0wFtaHwnlaLaAMjjTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P9kEyPLFU5Bk7v2yu0OReo2urXS75n8PFY0UZH5S5wd5hI4MYMMHlx+5o5HIYS92J
	 r5lwUYcwlNDa7+6qKgnR5238NE4fxnZ+wSIPU3VlLZz2b+DWjJ3oR5JO/BVIJ7o6f8
	 FW9sFCLw3qvC/sfKwTkvJvgTa1Ycb6HZLJQ5AbInCtQgsH8FI9Ox6t5rG5TWPafwH7
	 BgM2gCbcISANYZBMrVIzXVKev3B7dYPwwziVRUCimtDWj6ANpOYN1u/VJbNUMpYfVK
	 asBrFEuFSFnLU5zvT09xp8xblmcKf/qKzd/smMhh4t02W1ZFn5gmFIliSHPDEaXbF9
	 O/Oz7M5A5QqRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B677C5DF97;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 23 Aug 2026 18:09:18 +0200
Subject: [PATCH v2 5/7] thunderbolt: Mark discovered tunnels as active
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-b4-tbt-fixes-v2-5-26a18a426c9f@kernel.org>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
In-Reply-To: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Gf7s+iDVEY9i7s48leCOPqnKX0wFtaHwnlaLaAMjjTI=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1a3dOIBW5fuoJ+bOxYy9C49tkM96Oy5pZ3zTIQX/74vG
 XSBZXNlRykLgxgXg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiJg0M/91+/I1fI8E7TyZA
 1uqYn8//7+YPZy0zXs76dPMSEfe9N28z/E/mvPpG7K/4qxOLO+Wfvf8QoNIptGeHy/2odUYzN2i
 d4ecGAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Discovered tunnels that have been activated by whatever was running
before us stay in TB_TUNNEL_INACTIVE until hibernation restore such that
anything depending on tb_tunnel_is_active() skips them. Mark them active
during discovery instead. These now also emit TUNNEL_EVENT=activated
uevents during discovery.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/thunderbolt/tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 5f536635908f..3785e29cf92b 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -507,6 +507,7 @@ struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down,
 		goto err_deactivate;
 	}
 
+	tb_tunnel_set_active(tunnel, true);
 	tb_tunnel_dbg(tunnel, "discovered\n");
 	return tunnel;
 
@@ -1671,6 +1672,7 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
 
 	tb_dp_dump(tunnel);
 
+	tb_tunnel_set_active(tunnel, true);
 	tb_tunnel_dbg(tunnel, "discovered\n");
 	return tunnel;
 
@@ -2299,6 +2301,7 @@ struct tb_tunnel *tb_tunnel_discover_usb3(struct tb *tb, struct tb_port *down,
 			tb_usb3_reclaim_available_bandwidth;
 	}
 
+	tb_tunnel_set_active(tunnel, true);
 	tb_tunnel_dbg(tunnel, "discovered\n");
 	return tunnel;
 

-- 
2.55.0


