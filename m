Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97334521885;
	Mon, 21 Sep 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029583; cv=none; b=pQpuoSMjKkp+zZ0Vrmy0jDG58kue9ZizP1t9bxCS98UgyWgsk21yT7OoJLjQRkpQjRDga75DfqzH6ywP70W0S4A1AzTYcwqCB9Mp+SF6v8BtSwiRJKNddOBXCwdFEgyRPRcXBoYkVSrsi0SCWbOZI4uRHVfCAx7s3QIUvrMqNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029583; c=relaxed/simple;
	bh=kGn4fo3O/U2M+GSCkXWn/C6CCJQkldv4VF8Y7HOGcUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxSi+56B/4SvDNVTnCKWoWiSlKMvyUiDUR/C5h3A1pmKDVIFW2WAHxcdgdqdIj1Qo8DRAGzijxXyIYVpAvJBPz72WkzXUAzUg0BZC+8hztAtNjSi0k1TDx8B88HxdHhLkEsCgvZ5jjhwljjInI6Ae9GUzJRheMwJxEzY83+38jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loIpKnro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loIpKnro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA291F00893;
	Mon, 21 Sep 2026 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029582;
	bh=ag8KW8kXzCaKg2bzp2xZ1iTg5aJBZQBvB8ODRASf4hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=loIpKnroi6LGO/+zQRxc2/UxmQl6s6zUIZC8EJt8bMfWPQ3zyykLCLPy3+InMmtoY
	 6qMNjjArX7IqQDCYF9OARldB7XhDQ/sr+1O9sBv2jPEOfZ3F1hPvgcuTfPUAQUFjvM
	 yluNgxnLXR5eY4ndgjyDjx0eKN1+wfZKD2NxP1/cq4VefuOyUUBC6MBG/vT2occDAo
	 F5CBuY23R3VOb7fdjVh/94nzEECuwhR+rWv3iZ/UxzeChKHk594mThGohRsGJS0rwB
	 j8fKRj6BLmFJnFSW6U/ksT3Pj0oWcY5vQm65k+scS/+aIUxAnUUqji+Zv/4m5qoUI+
	 M0CpNhyS+T/yw==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:25:56 +0200
Subject: [PATCH 3/7] net/9p/usbg: always reset completion when
 disconnecting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-3-9d8dcc52904c@kernel.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=mgr@kernel.org;
 h=from:subject:message-id; bh=kGn4fo3O/U2M+GSCkXWn/C6CCJQkldv4VF8Y7HOGcUU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8EIzSxwVioGL/FhkWgeGhqpcystajcKgAl7
 giDwh5/IRSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvBAAKCRC/aVhE+XH0
 q8wlD/9aKWpnITmVellIbfp+bB60vGpaMA4TUIqqKJru6NImwH9i1Nsoyym0gykokh3tq/N/Mae
 Am/QCGHQVDBwAVhyNjMCkW0BwSl+4Ar5HPxSKEGOc2yh/6lAKqBMpT38lujK/NXmvk9CV+8/okl
 Q7oZhaUSQv8BvLiQlYQsd1lTgKSzJYYuWBLZgJS5Ph9UBkWAemVAtOF4c9LUAkgQ66B8nXjQTRo
 GJ0d1WcXn3t6FVp3iev0T7X7Um4/4Rpn3NoNo9xXv0d7luktYe6+8MUMWQ/PZtH16OWIz5F4vmB
 m8YddWb0rsJwJdhqUrwnB9/u5Lb9yEraInI5YtOSOzequc6BViviYb6XY18LG4U68vYLP6va/jB
 7VCRHt9CJHw00OrIMdnoLUlRMwxaX2nMb2+eu519Gc2T2OohAPAmnaXhPp+16ouNNgr7mtWzDNQ
 zvPxZWfO6e/+k3z1DX0lAqg2/hXKFAY/po9xMWsgmcLqmv5fdwX1eULc5pPpevzCnB5+KpxCMCy
 heeG3AU/lGSchHnudUS7TRdDEOJq/732S4WJkP5VGAD9A4dsdcJ0/sQaDbTzaHUf/IAXR/jmBsY
 7pC1Wwiusssk/TvuZqXQ+az+CrCK33/77HKQ6doXgmMZTNFDtkQmBS3LOPvYz91Im+T+TwyHZsy
 uDMAlmRwJ7dTDYg==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

When some tx or rx transfers were pending while closing the connection,
the completion handler could catch one pending completion call. To
ensure a normal start when mounting again, we have to reset the
completion and flush any pending completions.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index a3182d3db175..e3af8e1002d7 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -475,6 +475,7 @@ static void p9_usbg_close(struct p9_client *client)
 	mutex_unlock(&usb9pfs_lock);
 
 	disable_usb9pfs(usb9pfs);
+	reinit_completion(&usb9pfs->send);
 }
 
 static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
@@ -764,6 +765,7 @@ static void usb9pfs_disable(struct usb_function *f)
 		usb9pfs->client->status = Disconnected;
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 	usb9pfs_clear_tx(usb9pfs);
+	reinit_completion(&usb9pfs->send);
 }
 
 static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)

-- 
2.53.0

