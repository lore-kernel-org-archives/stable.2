Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546A3375C3;
	Fri, 14 Aug 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715358; cv=none; b=RIK1c9WnY9+uqVJiBBX39br25h5rWDNkHVO0AFsptkt8q55ji6Z1je0uKBMQVq3KwIdnde9kFZESX87bFR5J/K7jMzSIcUmGE4rTqMEIyq/NgoH3g5YJ3BK3/4PwcEvtJPbpFMt/IpLL1AfO78cdd2sEYLD8CT5DCleWsv5d7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715358; c=relaxed/simple;
	bh=je0Gn8UedNj46wQelTm807nMV+YFl5+w7RoiNCV0XPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzJsxofYjgB8utqIyCUXPzJmi6OFZS7F5gulC0Kyog4GevJ27vf7dCfrXY9ubjMEX34LAsm972L0ngL4DUYqZm/re7MmReBKKNE2ncSUizJ6xXKGyhCkApA3cntO0/SAJGR76719E4ZPF6/pzC9D+VSHhnx6YYHaUiWx5t/XauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWLJUP//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWLJUP//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F561F00A3E;
	Fri, 14 Aug 2026 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715356;
	bh=4UmPkjJn6FzZdr3G7GcuUavKUP8P36jT9i8Urx3AgHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWLJUP//6SHXOJ936l2MMRjI97TNV30IJJ84ZqL40ZfY8eXvHsIR7upIZ3Gj1UrJx
	 sYMvxscEyB7M35GyK0QzH7wrKtX07ra2rmeDAL//xX3C/3BEsyxWuz9LyPJdFB2Om5
	 TvxYjQeCLrm6LBIqFtYLQMZL9uHZOTvZfVckbNueYE0omdRbq6VbchMffjyRKHvjeT
	 LycS/nNlqrIEiA5Ly/dm9nLgt3X3xFmb1iV1hajYO7alD29PH/J8KqWmVknuZbPaOk
	 +bMhkMC0iTrvK1wC+ANYu7WtYCos2E8MZI+55lU8hRSgs1TqYV2TCayxBq9Ct/IWWC
	 vOV4lzh+HAyDw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3 3/4] EDAC/altera: Fix code leak on dci allocation failure
Date: Fri, 14 Aug 2026 08:48:53 -0500
Message-ID: <20260814134854.2397810-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260814134854.2397810-1-dinguyen@kernel.org>
References: <20260814134854.2397810-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko reports: If devres_open_group() fails, the function returns -ENOMEM
without freeing the dci structure allocated earlier with edac_device_alloc_ctl_info().

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: No changes
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8a3438fb5f44..ccdfb35178b69 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1516,8 +1516,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
-- 
2.42.0.411.g813d9a9188

