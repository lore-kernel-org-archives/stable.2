Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00EF4E8E0E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949756; cv=none; b=FHQ76mDrNxVbZgjV57+RPNV7xXrn+he997cvjFMHl48XrDXB+v/L+/6wiQXtZFDf/AoKZNKX0te7cUp66bDYNvBnEc8KF/vD57vcdjGYX7lBxTDssqzK+s8xrmQ/ugldkXg0juHGbBdBYOFOTCaDQnxQlOR61WxwEE0bAElSiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949756; c=relaxed/simple;
	bh=uPH2UBjhPFLJG5/9VhkFLV5Pb9cqWDK+h3fwgL1VfT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SdLehCrZwNYey4/nD59bBcD3lJ+eDExAEiSje2vmTddC6+pJ1BuBy/KY8cV6lSEytQbuyieXMNO1UXKArObHxRPxw/cSXkD2h2DWl26NNWNxeFJDHHvR+s8D/uLbjMpgMxS//Tl+gMEZ+eCuqu6YJCAqvBmSfM7JJ5XQkRa1URU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aNnp8dAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aNnp8dAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2701F00A3A;
	Wed,  9 Sep 2026 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949754;
	bh=FLgdcLNfh7p4dlmVTarkJsk/4vU1k0ds9Rb+9vzdjr8=;
	h=Subject:To:Cc:From:Date;
	b=aNnp8dASUK4w29Py5xPPFTCwUPpJtGF0fwLi+HmLOYRKTLDb63Chj4/TxfyonIl9P
	 u8hDtJhwpiNJqApdtQNnVYd38nJoUVH77E9r0eWeNx1l+3y8euiZCGeUj8nG4WrVRe
	 SttTAR2VMPtKmokXDNkFVWRoUsxmGkkpndzMlLOk=
Subject: FAILED: patch "[PATCH] iio: light: apds9306: fix PM reference leak in" failed to apply to 6.12-stable tree
To: mokshpanicker.7@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:21:52 +0200
Message-ID: <2026090952-mollusk-copilot-9a29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d378fceaafd79e0dc59d3546bda251a3058062c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090952-mollusk-copilot-9a29@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d378fceaafd79e0dc59d3546bda251a3058062c0 Mon Sep 17 00:00:00 2001
From: Moksh Panicker <mokshpanicker.7@gmail.com>
Date: Sun, 2 Aug 2026 19:07:01 +0000
Subject: [PATCH] iio: light: apds9306: fix PM reference leak in
 apds9306_read_data()

apds9306_read_data() calls pm_runtime_resume_and_get() but several
error paths return directly without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference and preventing the device from
autosuspending.

Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() to
automatically handle runtime PM reference release on all return paths.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..d582bda4d847 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -469,9 +469,9 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	int status = 0;
 	u8 buff[3];
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret)
-		return ret;
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
@@ -535,8 +535,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_put_autosuspend(data->dev);
-
 	return 0;
 }
 

