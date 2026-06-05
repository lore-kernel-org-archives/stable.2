Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBA400E02
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688311; cv=none; b=Hw03F7cnvdPpD+lEWLcjGT7Dy4pQpcNRR96sc1AeknH0hzji98gHdFgjJa+DqlyjMYfBwzx4J9Xups9AvWsPD637WBKJ5xMTpSXg45xOVzUaS8PeKIyiFmg9ndZJMPzFllncdcraRKqmHAl7YTOc9i75kJeNyhNcyJn05YEutNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688311; c=relaxed/simple;
	bh=nHncwJOdj9tQYdQ5dilzwheJ3C61+jkS/wcDUt4vfjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8YaaNEK08Y+aQ9JgN1wVwDzDLI0ogdqK68xqMuNBo9/shyTe5H1YVSe9jmRA4uyKXtBaVDWrJ2JSaUtYAVO7cX9Fjg7RQx1jUJvlcG7auMTWsLis84rt8gkWgAbJaYJQHM1fMTsQoec0JaAfY4lVn1hp9s9d1ekNcTWPF2E2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8FKuZ4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8FKuZ4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6981F00898;
	Fri,  5 Jun 2026 19:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688309;
	bh=2ATlPSSNy6IjPI4LYiNVtM0nmv8Ya3EZbVr+W08UZM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8FKuZ4TIZb+q5LBDrJh53lQAX5Q7HxOgqFIJPS4rLyOAC1V6m2JcR//6AGESNrR1
	 p8Bs3040yYh33T1w19FBfozRdhKjaJbI8a5TcNdMOh71OGQ++xmBReprysT4hjw+IC
	 HDmVIi7iQELGNDG685SdGaiuoYZARR1+fTDTrgT7dHcCOJl/rjFCd5bonhmgzLY3xK
	 x/4xU53mMU0p1XakM4CrFmezY5ZXRju7cLbLA2F6YXPv83gIzuWTOLsA/5gdD2/aHd
	 TKg6ulnX+KUX5xYsbD2bgw8TmVDJzLJnrqh9HItzJX9uS5U595vUIXm+FD5SQWgYbU
	 LLFee3ECs7nHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable <stable@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: gadget: f_hid: fix device reference leak in hidg_alloc()
Date: Fri,  5 Jun 2026 15:38:26 -0400
Message-ID: <20260605193826.2169399-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605193826.2169399-1-sashal@kernel.org>
References: <2026060453-cape-pavestone-2366@gregkh>
 <20260605193826.2169399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 4f88d65def6f3c90121601b4f62a4c967f3063a6 ]

hidg_alloc() initializes hidg->dev with device_initialize() before
calling dev_set_name(). If dev_set_name() fails, the function currently
jumps to err_unlock and returns without calling put_device().

This leaves the device reference unbalanced and prevents hidg_release()
from being called. Calling put_device() here is also safe, since
hidg_release() only frees resources owned by hidg.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Route the dev_set_name() failure path through err_put_device so the
device reference is dropped properly.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable <stable@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold johan@kernel.org
Link: https://patch.msgid.link/20260413142119.2977716-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 07c4f7bbdb2719..7b19f8ffa87150 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1278,7 +1278,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1313,7 +1313,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }
-- 
2.53.0

