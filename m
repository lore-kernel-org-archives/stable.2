Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49092419FCC
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752039; cv=none; b=Xgh5BxKU7OVzXJ5MHMMSGckqm8EtchPz4ljfL9YjhEsYDB+kJIe9GxqioQ1mxTcsbNwYRZaZvDJZsDRCoAXGeOME98xKZoRUZu+Vkg1dR3DIrMdFJdww02Yoc8zfwOamx7KUOfwDR2pqK2Dillg00JKzh/WGWtng6LXKt1Y85SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752039; c=relaxed/simple;
	bh=ux/cqlri8VtG1JxrreiYNUG/Q3W/2gYb74emYSuakZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1wCH3KhTd1phzEGNm+e7NSlZVn8tQRcjBKq+MnNiIGUFJMe7Vq+di540lRkP2QCjKmhE9zGdANc7kA27+JIcsXgH2W0EVLlpErHlS4v0/53mQR8kGa4w0tkT9qfac1Kmhy+XHJZ/SlDJYMOpN8o3CwVZJPk8PmUsV7XosCvOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haoMoivq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haoMoivq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4651F000E9;
	Wed, 26 Aug 2026 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752037;
	bh=Cl5kDJPmOsHALUu9nlMTrIx9A3c86JHQMNBugw85Sr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=haoMoivqWBxso6yUGT9rw5hg8naJLvoaNc6zNflPDb7KIjLq2XG48dCdnb+DTOPHk
	 +epwIRLUqrZEfa7da3vOz4xH5VxfwMlkhQGZwwc5Yh1qLmE6/QeFuCkHueVCebohTu
	 bo/fubu+lmxWkm35OmMNVXjMKDmE68srfHO5jtxa+NSRlncBIoRX4lkudAG2DM58X5
	 wXxPqweUF3BcT9PRCq9J9kI3gaHP6WEHt0uTU2R/M02eRTHF2HoFpWvbo1p2KjUSXf
	 DkEGl1+eQYNiR9K/9m+2WGvShM3mmZdqtFZ2NJvz4dX0hYOzizzFTDQB7Ni/Qi2Fwo
	 YCpuMzCZPUy9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] HID: pidff: Rework pidff_set_time() to fix warnings
Date: Wed, 26 Aug 2026 09:47:12 -0400
Message-ID: <20260826134715.3968449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082517-petroleum-anaerobic-3fd3@gregkh>
References: <2026082517-petroleum-anaerobic-3fd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit bed72bd240ce77623845853397b89a08f6dc5770 ]

Fixes blank line warning from checkpatch.pl script

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 67bb1074e3d2 ("HID: pidff: fix OOB write when hid->inputs is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 0e653b104b525..471dbc8fabc98 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -339,8 +339,8 @@ static void pidff_set_signed(struct pidff_usage *usage, s16 value)
 
 static void pidff_set_time(struct pidff_usage *usage, u16 time)
 {
-	u32 modified_time = pidff_rescale_time(time, usage->field);
-	usage->value[0] = pidff_clamp(modified_time, usage->field);
+	usage->value[0] = pidff_clamp(
+		pidff_rescale_time(time, usage->field), usage->field);
 }
 
 static void pidff_set_duration(struct pidff_usage *usage, u16 duration)
-- 
2.53.0

