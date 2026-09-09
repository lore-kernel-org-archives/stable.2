Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76335957
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974422; cv=none; b=lJqkyKcDbI/XHaQAQZBudlMzdnqWaBXu7+ARqG2m89ChOtsDhdHQoUOWJr/vAe02x+Sw+cw50/MgHeMTiF1qtnUpZsds0YZbQF46ZRTnasKrWMWU4vbIE2ka7+6b3fKuD78zNLNsN2geUimWaYEx+p5QYr3lBwO9Stw193dwgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974422; c=relaxed/simple;
	bh=LS1hRin3DkPyUEc+erGBUUePznaRy/v4mKLcpiMoR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFlIkWGp8qE6XZxsrvBB46R7DpkOhq3PIZZlwT4FumQIUQXukLH5uJ+b1kCVtOfXEJfKt6tI8vdEujmbzltBf0G/jI7tyzwsNL90VPPHdQ/uGQoJAW9dFTKDJBs8U2ULl5MQDZ8jxvshkH8yZ8Yy2k6WbZwRojHXlZcgdgK2iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW9C/6vn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW9C/6vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C261F000FF;
	Wed,  9 Sep 2026 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974420;
	bh=2VFkre2MyrtuJGsIgYgnkLEiBLUkFG/Abw8cbLV/EPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OW9C/6vnqYWIX9bkMQ4mNScMKZUMbeSTzn8h8gZv3JJbIpn6x4/Xzq2N9dEmbjqig
	 q75zI2f1+AqZeIW+XCPFZe+7T3MeaXhrU3sXUc8+z+XfQ6i771zpeIuiw5+ITWjAyF
	 WeE6OBdTEG4TXEA0tNY5in66ZLeNFrFNw43eOB0GmABQd7ScsFqYq66u7qyt/viluH
	 QR+Fgko8Fxr+3DlaX7smYBJXtvt/1S+Njo+UdBKf6D9rVIhIpzHxz93I0atw2vQvuY
	 EmdhcUTOF4wK50YBiW6gfYVH7HkvKWjN95N1eK5SIKJ1+yNm43xJ/rW8940cWN5c9z
	 PpUp5yUUW22ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Ye <fy15309206903@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: thunderbolt: Release the Rx HopID that was handed out on mismatch
Date: Wed,  9 Sep 2026 13:20:17 -0400
Message-ID: <20260909172018.3255744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-matcher-folk-642c@gregkh>
References: <2026090358-matcher-folk-642c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ye <fy15309206903@gmail.com>

[ Upstream commit 2f1463554d0561a2fead81e3888604e5c1125e29 ]

tb_xdomain_alloc_in_hopid() passes the wanted HopID to ida_alloc_range()
as the lower bound, so a taken id is not an error there: the allocator
returns the next free one above it. tbnet_connected_work() asks for the
peer's transmit path, treats any other id as a failure and returns
without releasing what it got, so that allocation stays live for the rest
of the XDomain connection with nothing left holding a reference to it.

Release the id when it is not the one we asked for, the same way the
error unwind at the end of the function releases the expected one.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260811-b4-tbnet-hopid-v3-1-9e75d1b51331@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 3c8b26ebf525 ("net: thunderbolt: Mark the connection down when bringing it up fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 7900d35096b01..fab332302e981 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -619,6 +619,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 
-- 
2.53.0

