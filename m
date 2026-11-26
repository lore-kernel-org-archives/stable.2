Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697114;
	b=2Nw2O8WEfB/j5QLXQ5kZcLD06PLB85ROk/Xszx9grdmRbtrNV7syU+wwEeCeX62o9MCQ
	 BRjKXuc5TEvTEiTZ/T93VwNcoxnM91kyjpFuugve4vuFo6pxttzHOFSSLorxXh4cMckkq
	 avHn5G5+Xwvu+4bkFbKtgxPfoRur57v96FnVxULfmOrVRmqPPamsShLbs3VJ6gNtDI2cY
	 XQjmP+NkbjTUqS8ReHzBimRGZvD94FJnm/xNhja+l+27V72xeXsn7srot8+HdUbOfl4mz
	 ofwJELubTGrzx5r3wXLYeo5VCO5yWB1kdtT7buEsnJ6NeR5rcD+iScFkHw0guwHc1Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697114;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E9yDbQ0remy2qz5TJaNHmIfIamOoLrFTaYrPugpZ6XA=;
	b=h0srx2UOGq1lvR1/w/vRlyXlYkrQ5/rm+wr+NiwZzqWEZ9ctmBA/EnYF+60XJgx7qWd4
	 44k3S/OxsbKZlW27uhLq/eCqNKYouWYLZX2S0WjCCq8wjeOdME9ck6DOzhw9VesCMgkUm
	 Mz7ds00OLdGhUp6yE+OG8dVQO1YW4gSf3INaus6qZ37+pLtVSKNsJn2LSMn9ymdOw8N5+
	 1s7G9n7EiASHROmKjNBH7wlJpkxZ4IZPHl1VFKqaobf8e8idEHEEkVNmplr5DUUFL3KNp
	 K7YTcA3K7afF3XvM7jkG2CWoHVZaHx1CTwpzm6i3LkD7O15PNjJI/c181iHger13QSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKjLtgKm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF4606A331;
	Thu, 26 Nov 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKjLtgKm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795697113;
	b=vK31KanTE3P+OgCNdnMo3h5+h6+tohJyVw8g9NtsVhB2ecUSbz7DyrOk1HDQ9Q2d2FV9
	 BnJ1Rk0shhw0b624uaDGqbd/Cm8DJfXuV8+aubhzre/P1MxiRGTcwBapgmRrc3FoEQ6LO
	 nYb+SFEZ2rA9JF1kqa7uRPtffscM9uKBB7SdkMNO/9iQijAmAmWIWj5/62BJZeTmeoQPk
	 tIzn46BOoqpjGGQGZTo7KbU91qfBXu+DdUi/dzepH612WUQWqmF1+tSSfEmUXDw3ACxzo
	 7PeBkwgkK5RtruI6C/V4rMFAuvc3w12HXKZ0gIWfpTUU/t6usD69cA9NtVgbx+7mxxw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697113;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E9yDbQ0remy2qz5TJaNHmIfIamOoLrFTaYrPugpZ6XA=;
	b=Bp/cxZMQEir5NtWeCFQ+SbtOazEImAHfa03eyI61jdVyUYgThH/e9SoGZofyiEBAKmS9
	 i01g21z7TW12tAwxSU874UP81WZgDKc57XIWAMAm40POE808aP3vqjdY2cpDu/a+WBtGl
	 lRe9fagU8zzs15JKjYf2XxQPwsSazb+fPxIviTdRITt8aXNyFs2ojuwtROu9DGMyO14HK
	 4xxKC9WPhR/k8TY1ExcdZe7/1kCpL9AMeHylDodW3Jc8NAe5WZQ3lFuHlBGXea46/QOOR
	 20NQ/jT5Fqz+gRtHQ5b0qts29eTRbp0YIFN5N5rApl2r56RSJZCGxKBXCllh6MYgg9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C7F221F000C6;
	Thu, 26 Nov 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697113;
	bh=E9yDbQ0remy2qz5TJaNHmIfIamOoLrFTaYrPugpZ6XA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iKjLtgKmGTeAfgS54ptCq88w1LG8FsfsCkr2Bf7CR6ethF+apGk1ZkBY7DJ9egIhq
	 mZ2THrChD//uXXA6gb/+KEiI2weu/zrJ+MW8i9bIY0Rv8m2msmOsaInbnvpw4AvTVr
	 moB4JI2QeHsHjmz6xJ7x7WHZH19LSOJI3TBycw01JNEpYbaLxgzhfTCNLokNloiFMV
	 fAp2W8CFGccjco5f99hzJJWbMG2jOR8QrlqGcHGSzBaRAj4JmJWvBtbPuhzqoh/rtw
	 bze0mu/uTzkJrmxL+bmlv2Oyuv63+yhWtrmWXt1i72RurgLbdQRxFzS+UyIJUU3a3h
	 tmJMysClb3/RA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5B2B54D4F7;
	Thu, 26 Nov 2026 12:44:55 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 21:44:56 +0900
Subject: [PATCH v10 6/6] usb: gadget: gadgetfs: avoid writing through the
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
Message-Id: <20261126-gadgetfs-ep0-v10-6-8add6d9cace2@gmail.com>
References: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795697092; l=1664;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=K83WCxg7Uqn+9HPmQ31xFCBufL/y6Cnf9nqdhp+j2Fw=;
 b=GufeG7tBLFWkme0krOdN2ZkCnnS5I1BgZ75SDYDlV+g0Vb9fcTSKGZuPo1EWbGk09haWUQdaQ
 kdvFWJsYi73D4OXi1SvmRfzn23UY3qMe/UDWsnqUosUTqq69IcSB4BG
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_setup() receives the setup packet as const, but clamps an
oversized control-IN request by casting away the constness and writing
the truncated length back into the caller's wLength field.

The setup() callback has no business modifying the setup packet, and
ctrl->wLength is only used afterwards when initializing event->u.setup.
Store the clamped w_length into event->u.setup.wLength directly instead.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ed26cef30..e79a4e401 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1668,10 +1668,6 @@ gadgetfs_do_setup(struct dev_data *dev, const struct usb_ctrlrequest *ctrl,
 
 	if (w_length > RBUF_SIZE) {
 		if (ctrl->bRequestType & USB_DIR_IN) {
-			/* Cast away the const, we are going to overwrite on purpose. */
-			__le16 *temp = (__le16 *)&ctrl->wLength;
-
-			*temp = cpu_to_le16(RBUF_SIZE);
 			w_length = RBUF_SIZE;
 		} else {
 			return value;
@@ -1828,6 +1824,8 @@ gadgetfs_do_setup(struct dev_data *dev, const struct usb_ctrlrequest *ctrl,
 			/* state changes when reader collects event */
 			event = next_event (dev, GADGETFS_SETUP);
 			event->u.setup = *ctrl;
+			/* Report the length we can actually handle */
+			event->u.setup.wLength = cpu_to_le16(w_length);
 			ep0_readable (dev);
 			/*
 			 * Return USB_GADGET_DELAYED_STATUS as a workaround to

-- 
Git-155)


