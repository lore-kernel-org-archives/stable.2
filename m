Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7134F247;
	Wed, 29 Jul 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338594; cv=none; b=I1/pwmmdMx13PH8NuCkWCQdKvw/cEW4m4ivRa3wDWy7ipP5rktadT3mLtWl7wfW1Y7Bz5VVWz1vDPHrUr6xRmB/Jvxdh/kzVQN0CxTKwXzd2ZJaxwIlOTS6Wj9z7+wRQSdiQbTO4VgIPYjf6zxarzKe4c17pKObFM058IQB8p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338594; c=relaxed/simple;
	bh=csD4C9aGmo8ROb3Tk3cNJUGCpn5XKsdKsR71UwnyuvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb+kYtzmJinWFSeMsG8/NJpPJ9MBiI4PjXNIpHUSntjxU7lBqJIo/AqA/SMnXIJ6XAoHELLWU4QpKZ4FYRiQ2WQN9q7V4AV5ORiqdBMwgAkO51gIfmS+w1jbT1HCtZtwwoQPw5tcHi98SVC+37YiajdSnaigAV4wdyLGmDGBN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ULRrXtCr; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ULRrXtCr; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ULRrXtCr";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ULRrXtCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338591; bh=csD4C9aGmo8ROb3Tk3cNJUGCpn5XKsdKsR71UwnyuvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULRrXtCrf9AxIcLTmwS56fSyNCLJwSdlHn72xJrXj4DbZgkU0BbiumWZakPBGP0RF
	 LXij1HxHa94PigMqB7G2UiD62QPVLwLEJsAAtne83wZd9lJ67dmaf5H5RiS8IFRtrc
	 j0kn6lciU6O100lYstdi6cO8T4+KW8wU46FyhOQysJ6f+MjTaWY0fA7Z2QESo6a3c2
	 ZdAutKifvkXGMF1zaIJm9lhHrWVNrp1TCzbjUoTPpqJBx8antPyJeX68sDHPBxLv4C
	 hvSYTVpf/294WTh9FA2pPj9eh91orfCfOdWfHSlofQ1pxO6Olnkn2wWabQMZ6l3ZsF
	 FnBbVMz9oApyQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id B76A34252A; Wed, 29 Jul 2026 16:23:11 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338591; bh=csD4C9aGmo8ROb3Tk3cNJUGCpn5XKsdKsR71UwnyuvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULRrXtCrf9AxIcLTmwS56fSyNCLJwSdlHn72xJrXj4DbZgkU0BbiumWZakPBGP0RF
	 LXij1HxHa94PigMqB7G2UiD62QPVLwLEJsAAtne83wZd9lJ67dmaf5H5RiS8IFRtrc
	 j0kn6lciU6O100lYstdi6cO8T4+KW8wU46FyhOQysJ6f+MjTaWY0fA7Z2QESo6a3c2
	 ZdAutKifvkXGMF1zaIJm9lhHrWVNrp1TCzbjUoTPpqJBx8antPyJeX68sDHPBxLv4C
	 hvSYTVpf/294WTh9FA2pPj9eh91orfCfOdWfHSlofQ1pxO6Olnkn2wWabQMZ6l3ZsF
	 FnBbVMz9oApyQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 4531E42536;
	Wed, 29 Jul 2026 16:23:11 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/15] media: redrat3: Ensure all urbs are suspended
Date: Wed, 29 Jul 2026 16:22:42 +0100
Message-ID: <8823c420bbc702084ba04304bb018ac88eddc006.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the learn urb is stopped before suspend.

Fixes: c49fcdde38cb ("[media] redrat3: enable carrier reports using wideband receiver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index f86efcb74e6e..994d4864520c 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -1170,6 +1170,7 @@ static int redrat3_dev_suspend(struct usb_interface *intf, pm_message_t message)
 	usb_kill_urb(rr3->narrow_urb);
 	usb_kill_urb(rr3->wide_urb);
 	usb_kill_urb(rr3->flash_urb);
+	usb_kill_urb(rr3->learn_urb);
 	return 0;
 }
 
-- 
2.55.0

