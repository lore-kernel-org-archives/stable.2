Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70847A872
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912804; cv=none; b=UxUWGa6A36zvp6K53U03fiq8lk9h+0zQEvKNAUo2WIKmu9ZYgfzbFytdDhDldfOx5qXyL4H8WqLa9JFw7lFntbGJNyxgoqMmXYmnCew0Af0bCTNlInSMJfS3DzeH5sJYU1GLgaLbEX0PVO/tV0/vsrHDDQBbGDbhOIkuwNpfSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912804; c=relaxed/simple;
	bh=JVFkb7Cu6YP094+ZnATto6Q9s4QbtUg3QlEdZAc0Qo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAoOXAx5kXImoesHWc23bJTaVntKZfOeF/zczTDUNYYGWsjdqrj/l2LBEh1yCcNmod1s1r5u5UuM3xVRNU4M6e29iTkVOyYXKWJlXb0myFcVoLcFwvADOUdoSfpE+7O7OIZbwSiGkUstT92P8FGjecLNtKIDr/2qxaqtFURjtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiqjafpK; arc=none smtp.client-ip=74.125.224.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiqjafpK"
Received: by mail-yx2-f9.google.com with SMTP id 956f58d0204a3-6757067f4e9so1339580d50.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912802; x=1792517602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktaJr2DM5Zu0cnAztDTvIMhfnw3Hsx1asRS1ecJrXeg=;
        b=AiqjafpK1JYuCmn+s3TiNuPOZcd9gH6oLc0ptahOzx4EMyOWymGzmF43/cg+rE4h/z
         DWLLDpTEmEX+1qUBfe9zkkJSk/KWhxS7D/IMwyQeHiTl+25Fr1oGh6ueEGoOdPD/30kH
         9xpDhE6rKyDWK+sHipKQcBJtbAWPqTBA4juOAmRDB77qtH7M+gfSOU7SffhwJxQeWaLH
         BO09wPhjIcEqMtDriZvP27sPMgnlVFusMUc2cipCF5iaF4blzTN/kfVw3gNt6ic3Ly5f
         bTFYI2T6Lk6JX5UqXWsZqm4iQZwxC78BUrprcUrupB/ICwS6wiuVs5iuyOV1oAiJ5Sgk
         H77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912802; x=1792517602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktaJr2DM5Zu0cnAztDTvIMhfnw3Hsx1asRS1ecJrXeg=;
        b=MAmuVXgJ0QsKPfE0lrN3Uafl5NHrb9baSD/Joi92EGIUOD5NWu3Xp4jobhm3kc2k/O
         F5mhoAQ6C7Zu6EitHWYZxT4oSl4gprhu8BP2ldMs87nn8j7Bx7/uCIXjCJCHFlQmCPw5
         1qj9RD1ZVFxhqv2KHrclv7M4lTrs8LC5H4MO+qCBkYG32WKOzWZMIcqvTTC9lFKi1hg5
         LNrslkyWDMtcRy2+fMDYecgYyodS83nOVgFZAoNGcQuniDrxVh+vmZlReN0KQfAhcI4U
         wfMOrW9iwxXMi2bzKdZxErFXlQ2Xh3Jt8u2dyPkuWvRbo7VEgtiPfcQZqW9iYJO35srD
         H5rw==
X-Forwarded-Encrypted: i=1; AKwUvBzkrRsJy95ypCxgaXrqJ4pd0cuF3cyNhBbZoEAgfr6zck16UOvEroAtrkGifsT0t16BdjLerHk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr1RRjDAdQPiZTewijXhFVuKW0O7P8Yc/VeIHT60fr2SNfsu04
	YwZQE6LRb3ju0S5mFMlO71BDWGuBerBbhSsqha1MqdjKS9rnSowOs5n1
X-Gm-Gg: AYBFou2ar2jyxd1888MM29dgdQdLHyMwchC0DRxZivVh0a9L33Q0E/wCxLNGfpviqL/
	78h2Q05JM6tCESkruU8xbfov9O8ES11kGOol0+vm7+jqH/MjpAVIbg+ZELPmQpPdPzOMgUa7Cki
	kDcxTcVoqJdqn0XRXeWrypB3aoQtuPJHMHR+Vo78C7qJvSron/6QS85E1KNIl+mTOA/jzQXI40f
	j30jiD3PG8UlxEc6Czue3B1UfMtsBqqcetVmwyYU50X1N6NxHQjcDpRsj6zNjc2mz0jlPyeMd9w
	W23lfLPQQ1Ic3XT6ie1fkiaY0M8kkSzrgGMzCJu2vEhdcz/wX/86EXzIkyY/Qgqsx0mlte7YW4v
	9Ru3BJhuAJ4F4DvddydPG3XeEvqQ8TqsSEdPzSrogT2HqY5wTxnGqyf3hk3yR8JwNn8ti+aR/QU
	BUoCxS+cWoloditboukprMs44enogRGW9eKS2kITOcQyvZEvnhDE0wkY1aLQMZetGTxgpgdCup
X-Received: by 2002:a05:690e:14c1:b0:675:40a6:142c with SMTP id 956f58d0204a3-67935f1c770mr4649463d50.22.1791912801676;
        Tue, 13 Oct 2026 10:33:21 -0700 (PDT)
Received: from paradox ([98.122.223.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1ecbfbsm46571567b3.23.2026.10.13.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:33:21 -0700 (PDT)
From: Martin Belanger <martin.nvme.dev@gmail.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: axboe@kernel.dk,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>,
	stable@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: [PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable by root only
Date: Tue, 13 Oct 2026 13:32:41 -0400
Message-ID: <20261013173241.1713708-1-martin.nvme.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
0644. Their show functions return the secret, so any local user can
read the DH-HMAC-CHAP secrets of a connected controller.

Change the mode to 0600. Writing the attributes was already limited to
root and is not changed.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>
Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
---
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e1e3dcfd084b..e0cb34545b97 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -864,7 +864,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(dhchap_secret, 0600,
 	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
 
 static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
@@ -922,7 +922,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(dhchap_ctrl_secret, 0600,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
-- 
2.53.0

