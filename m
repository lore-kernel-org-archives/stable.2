Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794203743;
	b=NC4eklO1fR3dMHNt51P0/krJeHeAkmwV6m1GqWN8Zm+YU5PrAKr6eahqGb+eaRTIv2ct
	 Z1LOROnnnOTG9lr0fhtktxjxyr1rLn79Wl22c8nhzuaT8tqV6vfAeYdHugsU209cFqX1f
	 kpukiBUpMFWRDaRRbBfOVLXLUvK3QtwkCGTzH/DFLE3vHolkrHUibfsvQUK//L2N8Jity
	 paL3kTuUiwbbHo4NSwGXthCiUu/ePLvgfGplRnOoGxWagvz1GZJpSCtMeGaDpqCAeQ2zp
	 GylWgT5jVL3pyK2b4mfVFR2HAhq4CuBoiny5Zj7xbmWy9xejQuzNq9Y049Nz3oli4mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203743;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WIIMhlyT6bJG5iobFdCE4wO+AjJlp7bbmR8f4x8NNmc=;
	b=eARxrPrJXow7woXR4u6IgZmmp3TabUpaRmPi8MJVgi5mIVQWyNETbtMfcIZ/MDJshOEd
	 5aUb32CrhDWCUvUeyOXMCxxTnIncXA0Ja8tINu+k4/y3jVzs0rBvoSRgli9mkYGEKA0HA
	 j3vQDY/0DExmWLOHAtTS9+okURg8ybyam039j2sRlL4hMf34h0JAx5WFyrhEmbYye1xYC
	 WS0zuLCyjMyUMyLq2+aANvvIK6YkEnlyiM7/U7QqhrdEaZ7Dtl1kbBiN47QOhnZKVxeQk
	 AhEa1OyB0zOxIxCdNnMlMLkMXrtG1Zcw8Si+s3/NZ/jEXMtPi1v9dadk4CXt7EFfJZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQOOoFlK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01C606A321;
	Mon,  9 Nov 2026 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQOOoFlK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794203743;
	b=HllokmyKsaH9YMYubtW9N66kz29elxJpOqUWnBgNWK+RsyIjJ/bLRq1PSYzWSb0gAlbJ
	 WACdJKl93X2BXr+GpydsNxwqEXCiCtlVIDf3oxZM2co+XdEB2DkP7idzaVFAf87g8kzR8
	 KvsEcdTJDmxxOg8iL49mobTlqq1HP1m04iToseghXWn2EBaCIgCtxlHb5WyYQMA/40xCa
	 qv/QjSryWq46YCF0bGv8YuiHorB5cDWvsrFYCDmJCdurAlOSoRj33SZiTPamESxVdSI6T
	 sax32pJQK67FS5uxcFZgWQR3iwYF3Le+Bu8eyO743KmQJP5b7Q4+sDcj7c88iNorKww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794203743;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WIIMhlyT6bJG5iobFdCE4wO+AjJlp7bbmR8f4x8NNmc=;
	b=zESQemZO4o6xtD2SrRfbbjNvYnE5qCp8kYo50Nn1gs7MaBAWR+5CVbbJjvQOK8Uir7lK
	 5IP2QAU6+F6oDM8jG9GrUA7qoPX17UAq6Qpw124X43XaO01s8gdXsHdhTPGZ0EW5m6m1r
	 6s67dPuhGNuPmQ7h1KhSQ5Sfgwrv2hNsP8FAWIs9NEQ8NFuOOAcAI4Wn14ufKhJf0rYwh
	 rZDnsTxxejbkHU58uwzOTvsEpmoxo+GolvBvNEkv1MzrZeI5O+hnsYxAuQTExV1D8DJiT
	 aJ9FDgQMbdg8KEVv00jJE54mOlcZ00C9g6JfuqfI/GkY4ULqe2hF494ea9KczdCYfAA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1F64D1F008A3;
	Mon,  9 Nov 2026 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203743;
	bh=WIIMhlyT6bJG5iobFdCE4wO+AjJlp7bbmR8f4x8NNmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kQOOoFlKBXfsuIu/RUvUkKiRFLnKAdt034B7w6H7ygAZd203GoiM+fRSXgNmW7+qc
	 fTkZAWHVXIZRRCF0fUcZQNg2bgtv7TrJIRxGwiBXNmRwkj1fWHT7s/koaMR5UX8QmX
	 hOz3iHVB8rJHxtay1XAb3XVrSBdHQIXdcBIOgT70SafaMIazYXeikIvIsvl/3haXUF
	 78XGcRUbXG8HcTtwME6Mx0mPy7pNMFbC5bBqCuownpr52y6O+/NbBcCuJ/Bcx9t0Ch
	 gpNmm0RFMe0mxS+d9IwNbD8o7XCLTswGu/z8BsuKo+Tczp/H2IePN7dfGhLSWOMs/p
	 rUrdCVDTKY/dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9F7EB482DC;
	Mon,  9 Nov 2026 05:55:41 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 13:55:41 +0800
Subject: [PATCH v5 3/3] usb: gadget: gadgetfs: avoid writing through the
 const setup pointer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-b4-gadgetfs-ep0-v5-3-f16d0b648bc2@gmail.com>
References: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
In-Reply-To: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Jing Lin <kayano050408@gmail.com>, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794203739; l=1685;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=b6MoNxME4f44lJnt8mP7Bi+ISns5QSLf02GNPFd9pf4=;
 b=ippID2JFWPISCSEuMYPgtr32/xjHzFRd56V+ja8sr0eTSIw1bsTRCyHB2YPmak+ot9LGZ7vNc
 vw/8H2pC0N6DZFkBz/vCPszw7xGWWvwgiSww3DxRTFalt+mmKpsxg7I
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_setup() receives the setup packet as const, but clamps an
oversized control IN request by casting away the constness and writing
the truncated length back into the caller's wLength field.

The setup() callback has no business modifying the setup packet.  Use a
local copy of the request for the clamped length instead.  Userspace
still observes the truncated wLength in the GADGETFS_SETUP event, and
the queued request length is unchanged.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 4635a603e..23a36d556 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1510,15 +1510,16 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	struct usb_request		*req = dev->req;
 	int				value = -EOPNOTSUPP;
 	struct usb_gadgetfs_event	*event;
+	struct usb_ctrlrequest		ctrl_buf;
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 
 	if (w_length > RBUF_SIZE) {
 		if (ctrl->bRequestType & USB_DIR_IN) {
-			/* Cast away the const, we are going to overwrite on purpose. */
-			__le16 *temp = (__le16 *)&ctrl->wLength;
-
-			*temp = cpu_to_le16(RBUF_SIZE);
+			/* Report the length we can actually handle to userspace. */
+			ctrl_buf = *ctrl;
+			ctrl_buf.wLength = cpu_to_le16(RBUF_SIZE);
+			ctrl = &ctrl_buf;
 			w_length = RBUF_SIZE;
 		} else {
 			return value;

-- 
Git-155)


