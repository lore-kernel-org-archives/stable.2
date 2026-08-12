Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286A46AA7B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545983; cv=none; b=Z7EV1EgYVbxa8ynw6EmUHB/FlftXq+grxEq4jpzukcEUZppWGsCzzP0WkFXte58fcMt3240pE3ynqAZqYvd6sxJQMFlhCpXUIs6jlC3vNYLkr6aIehOLKsh0Ix4jeeG/9NfSjxNqXenQYfw4aUetqqxtxYxh1tIIvCKei0cKW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545983; c=relaxed/simple;
	bh=ZujZ+/p7L2pTgEMMIFzRJ7dtxwotqUb4fQrhR9F+sV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1hgwZG24Eu6kre0rGJfW/yzMIGM4Z1onrTmkWxtAqYfuRVOT8k8Zj13hq/h44yxLpXIQwL+ycspERGlm6qAHKqjcOyORGw4nJbmXuQmGxSIl+6mZQwad4Gn2Kn89xxTpOkAdahFQT/nglb++RIYhgFDUWVxia6NuWvuHO9Ki7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqdwD0cU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqdwD0cU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF2A1F00A3A;
	Wed, 12 Aug 2026 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786545981;
	bh=veUH14MxHutrx06D1IMONgRBe0Qx3eyaC++hJei1Ujg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqdwD0cUCBYFFFDp1WljwNIXQ8lQiYUBZA0iaRA5/p1SAAJhBKFSBxp9LYmnYq1jX
	 dMpTNptetS0FsAZr5I1XU6YspDW6wb7G3DZZuu5Wn6KoTWqC88epGVb4mASTulHCW7
	 Xn6NTaX3/SH6lDyrBm3cMS5i54QJWb/x7ik5B3qi2ume6oSW1hCEEBr/MSseznoLXf
	 XgRcLCr01omRs5I7Pas+Oqfzvm+QgqJ4KrNyVho370SkT/+S3zcM4Nqj7D7Jd4Vnyy
	 d5UO0XitI1oTbsfz15HnZdf7+TO+T/ai5ZGa1a6+IdYQgmjPfKUyWVqHG40s5xhe9R
	 1+6LA+l4TSAnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
	Kohei Enju <kohei@enjuk.jp>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ice: wait for reset completion in ice_resume()
Date: Wed, 12 Aug 2026 10:46:18 -0400
Message-ID: <20260812144618.2226698-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812144618.2226698-1-sashal@kernel.org>
References: <2026080526-docile-reply-8f04@gregkh>
 <20260812144618.2226698-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit c2816d613f388814d27bc9fd6dbd931a88056e19 ]

ice_resume() schedules an asynchronous PF reset and returns
immediately. The reset runs later in ice_service_task(). If
userspace tries to bring up the net device before the reset
finishes, ice_open() fails with -EBUSY:

  ice_resume()
    ice_schedule_reset()          # sets ICE_PFR_REQ, returns
  ...
  ice_open()
    ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
  ...
  ice_service_task()
    ice_do_reset()
      ice_rebuild()               # clears ICE_PFR_REQ, too late

Reproduced on E800 series NICs during suspend/resume with irdma
enabled, where the aux device probe widens the race window.

  ice 0000:81:00.0: can't open net device while reset is in progress

Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
for the reset to complete before returning from ice_resume(). In
practice the reset completes in ~300ms.

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Cc: stable@vger.kernel.org
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0403391b3680e..ebead7f44bc56 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4948,6 +4948,16 @@ static int __maybe_unused ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Best-effort wait for the scheduled reset to finish so that the
+	 * device is operational before returning. Without this, userspace
+	 * (e.g. NetworkManager) may try to open the net device while the
+	 * asynchronous reset is still in progress, hitting -EBUSY.
+	 */
+	ret = ice_wait_for_reset(pf, secs_to_jiffies(10));
+	if (ret)
+		dev_err(dev, "Wait for reset timed out (10s) during resume: %d\n",
+			ret);
+
 	return 0;
 }
 #endif /* CONFIG_PM */
-- 
2.53.0

