Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF40DB3F;
	Mon, 27 Jul 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158361; cv=none; b=EugEhw9NxV8JyE5msPJj1VRIe3Im1DF052kWgcftX5mnZ4ALTRrfPHb7E4A5X3YxV4VQegF+ptAU/FEGxfhe8v2vkNZ59pfSyROiVzc9x6ImJLR6Vy+6YFgIKCCm1yZc+cDEd0xWlcVDlm0+NyxVDd032fyr/aaW/cjcncgg8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158361; c=relaxed/simple;
	bh=yZxyCRkmp4AKMHYqkRoIsn2dSvwisuNURdwjTe4731Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klqQq5M1Cw4aeAhCgb8EhrO434OR+v2/ik3nytCuXPdnQcVaftKk9sqkE3znfirUuh8kDyJtjzU5ZqlOqJ7wLibqYFgJyNZyWBW1pRohr/wMxJSUsmZo+KhW3tDc6SS+D5IpfNv5blUGIu3opFXz2DM8kg7wIzKWcjKvcl9OqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=L4TwiAxN; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=WM7Eil5l; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="L4TwiAxN";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="WM7Eil5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158352; bh=yZxyCRkmp4AKMHYqkRoIsn2dSvwisuNURdwjTe4731Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4TwiAxNK/Cb3MvZW0k64qIQL19rqUf+xvgm/a6C96QQrrq9yoykH4D4fsAkl71WW
	 UCF68s7TiR70P8KG81EYQ/vnMqlzZ3O364AS5Lvlv1fE+KjR7nvAJ8cNrhq+JNEQxf
	 6h6WuySNbtHPbz6BckyW9/cQVx1WnBuk7/KTZRYnEvurNah4OpYtV4RuJJS/PnvYKw
	 6yADaI+NKXBjSCoNaQ5AGo+LqmVu/SPPrNdmgGLpG6CQl0q5HSjAznCp9+6ABDjWZz
	 CPW24mL4kixGZt+7lHwW7ainyoCZngck4UyuTvWNKIF6SOaNrt33ax2TsEziM1FYrk
	 A++iUuCuEEtmg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 7235F4252A; Mon, 27 Jul 2026 14:19:12 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158351; bh=yZxyCRkmp4AKMHYqkRoIsn2dSvwisuNURdwjTe4731Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WM7Eil5lQ9SqFEc+rE7lJ7oWanQ2jHhLVze9rg4sq7CrQis9fbjaqS31NuKUpaLX7
	 CC6iPwaf6TsO7fFyQiytGJRPRD/o0EDtrMrU4sWbXB1X2Jod0LA+amyS/aOXIX8VyO
	 qiAKX1XUFMR/wgGj77MXFRoI71uVPF5B1FNaqoGgoZUEu4pOK62LdKAS/ZVqowymFp
	 i9cG85ujYzDkHIPAfjvLYLrlpDEi1DhUc53bd8IcpG5VN7dzEQ74VxUBsENl5OzwhS
	 T4cDqJJLTk6ffUC1oXtK1EvVDJ7WdIIxEYzedUluRO5PhEJpDKP/41ggUmeUKkFwxb
	 Zyde6MZTYEU8A==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 81A7641567;
	Mon, 27 Jul 2026 14:19:11 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/15] media: streamzap: Add missing rc_unregister_device()
Date: Mon, 27 Jul 2026 14:18:44 +0100
Message-ID: <84b29522529b542fd604efa258383c445c0f9663.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If usb_submit_urb() fails during probe, then the error path is missing a
call to rc_unregister_device(), which will leak various things like the
input device.

Fixes: 42844992664f ("media: rc: streamzap: Error handling in probe")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/streamzap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 307985d74fe8..41195ad82734 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -365,6 +365,7 @@ static int streamzap_probe(struct usb_interface *intf,
 
 	return 0;
 rc_submit_fail:
+	rc_unregister_device(sz->rdev);
 	rc_free_device(sz->rdev);
 	usb_set_intfdata(intf, NULL);
 rc_dev_fail:
-- 
2.55.0

